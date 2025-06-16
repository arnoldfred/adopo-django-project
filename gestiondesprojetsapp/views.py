# gestiondesprojetsapp/views.py

from django.shortcuts import render, redirect, get_object_or_404
from django.http import HttpResponse, JsonResponse
from django.template.loader import render_to_string
from django.db.models import Sum, Count, Q
from django.utils import timezone
from django.views.decorators.http import require_POST
from django.contrib import messages

from .models import Project, Task, Team, Member
from .forms import MemberForm, ProjectForm, TaskForm, TeamForm


def home(request):
    nb_projects = Project.objects.count()
    nb_tasks_completed = Task.objects.filter(status='completed').count()
    nb_teams = Team.objects.count()
    total_budget = Project.objects.aggregate(total=Sum('budget'))['total'] or 0

    projects_this_month = Project.objects.filter(created_at__month=timezone.now().month).count()
    new_teams = Team.objects.filter(created_at__month=timezone.now().month).count()

    # Placeholders pour les pourcentages, à adapter si vous avez des calculs plus complexes
    tasks_progress_percent = 23
    budget_percent = 12

    projects = Project.objects.select_related('team').all()
    for project in projects:
        project.total_tasks = project.tasks.count()
        project.completed_tasks = project.tasks.filter(status='completed').count()

    context = {
        'nb_projects': nb_projects,
        'nb_tasks_completed': nb_tasks_completed,
        'nb_teams': nb_teams,
        'total_budget': total_budget,
        'projects_this_month': projects_this_month,
        'new_teams': new_teams,
        'tasks_progress_percent': tasks_progress_percent,
        'budget_percent': budget_percent,
        'projects': projects,
    }
    return render(request, 'index.html', context)


def projects(request):
    projects = Project.objects.prefetch_related('tasks', 'team').all()
    teams = Team.objects.all() # Peut être utile pour les filtres ou la création rapide
    return render(request, 'projects.html', {'projects': projects, 'teams': teams})


def project_create(request):
    if request.method == 'POST':
        form = ProjectForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "Projet créé avec succès !")
            return redirect('projects')
        else:
            messages.error(request, "Erreur lors de la création du projet. Veuillez corriger les erreurs.")
    else:
        form = ProjectForm()
    return render(request, 'project_create.html', {'form': form})


# Cette vue semble être conçue pour HTMX, car elle renvoie du HTML partiel.
# Si vous voulez une création pure Django, utilisez project_create ci-dessus.
# Si vous gardez HTMX, assurez-vous que votre formulaire est traité côté client pour des erreurs si form.is_valid() est False
def project_create_htmx(request):
    if request.method == 'POST':
        form = ProjectForm(request.POST)
        if form.is_valid():
            project = form.save()
            # Si vous utilisez HTMX pour ajouter une ligne au tableau par exemple
            html = render_to_string('partials/project_row.html', {'project': project}, request=request)
            return HttpResponse(html)
        else:
            # Renvoyer le formulaire avec erreurs pour HTMX
            html = render_to_string('partials/project_create_form.html', {'form': form}, request=request)
            return HttpResponse(html, status=400) # Statut 400 pour indiquer une erreur de validation
    # Pour un GET, si cette vue est utilisée pour afficher le formulaire initial pour HTMX
    form = ProjectForm()
    html = render_to_string('partials/project_create_form.html', {'form': form}, request=request)
    return HttpResponse(html)


def tasks_list(request):
    tasks = Task.objects.select_related('project', 'assigned_to').all().order_by('-due_date')
    return render(request, 'tasks.html', {'tasks': tasks, 'project': None})


def task_create(request):
    if request.method == 'POST':
        # Intercepte la valeur 'add_member' avant la validation du formulaire
        assigned_to_value = request.POST.get('assigned_to')
        if assigned_to_value == 'add_member':
            messages.info(request, "Veuillez d'abord ajouter le nouveau membre.")
            # Redirige vers la page d'ajout de membre.
            # Vous pourriez ajouter des paramètres GET pour pré-remplir la tâche après l'ajout du membre.
            return redirect('add_member')

        form = TaskForm(request.POST)
        if form.is_valid():
            task = form.save()
            messages.success(request, f"Tâche '{task.title}' créée avec succès !")
            return redirect('tasks')
        else:
            messages.error(request, "Erreur lors de la création de la tâche. Veuillez corriger les erreurs.")
            context = {'form': form}
            return render(request, 'tasks_create.html', context)
    else:
        form = TaskForm()
        context = {'form': form}
        return render(request, 'tasks_create.html', context)


def project_tasks(request, project_id):
    project = get_object_or_404(Project, pk=project_id)
    tasks = Task.objects.filter(project=project).select_related('assigned_to').order_by('-due_date')
    return render(request, 'tasks.html', {'tasks': tasks, 'project': project})


@require_POST
def toggle_task_status(request, task_id):
    task = get_object_or_404(Task, pk=task_id)
    task.status = 'completed' if task.status != 'completed' else 'pending'
    task.save()
    messages.info(request, f"Statut de la tâche '{task.name}' mis à jour.")
    # Si cette vue est utilisée avec HTMX, elle peut renvoyer un partiel
    # Sinon, elle devrait probablement rediriger ou rafraîchir la page
    return render(request, "partials/task_item.html", {"task": task})


def statistics(request):
    nb_projects = Project.objects.count()
    nb_tasks_completed = Task.objects.filter(status='completed').count()
    total_budget = Project.objects.aggregate(total=Sum('budget'))['total'] or 0

    avg_progress = 0
    projects = Project.objects.all()
    progress_list = []
    for project in projects:
        total = project.tasks.count()
        completed = project.tasks.filter(status='completed').count()
        progress = int((completed / total) * 100) if total > 0 else 0
        progress_list.append(progress)

    if progress_list:
        avg_progress = int(sum(progress_list) / len(progress_list))
    avg_progress_rest = 100 - avg_progress

    # Statistiques par priorité de tâche
    priorities = [choice[0] for choice in Task.PRIORITY_CHOICES] # Utilise les choix du modèle
    priority_counts = [Task.objects.filter(priority=p).count() for p in priorities]
    # Mappers les labels pour l'affichage si besoin
    priority_labels = [dict(Task.PRIORITY_CHOICES).get(p, p) for p in priorities]


    # Budget par équipe
    teams_with_budget = Team.objects.annotate(team_budget=Sum('projects__budget')).order_by('name')
    team_labels = [team.name for team in teams_with_budget]
    team_budgets = [float(team.team_budget or 0) for team in teams_with_budget]

    # Activité mensuelle (6 derniers mois)
    months_data = []
    completed_per_month = []
    new_per_month = []
    now = timezone.now()

    for i in range(6):
        month = now - timezone.timedelta(days=30 * i)
        month_start = month.replace(day=1, hour=0, minute=0, second=0, microsecond=0)
        next_month_start = (month_start + timezone.timedelta(days=32)).replace(day=1, hour=0, minute=0, second=0, microsecond=0)

        label = month.strftime('%b')
        months_data.append(label)

        completed = Task.objects.filter(
            status='completed',
            created_at__gte=month_start,
            created_at__lt=next_month_start
        ).count()
        completed_per_month.append(completed)

        new = Task.objects.filter(
            created_at__gte=month_start,
            created_at__lt=next_month_start
        ).count()
        new_per_month.append(new)

    # Inverser l'ordre pour que les mois récents soient à droite sur un graphique
    months_data.reverse()
    completed_per_month.reverse()
    new_per_month.reverse()

    context = {
        'nb_projects': nb_projects,
        'nb_tasks_completed': nb_tasks_completed,
        'avg_progress': avg_progress,
        'avg_progress_rest': avg_progress_rest,
        'total_budget': total_budget,
        'priority_labels': priority_labels,
        'priority_counts': priority_counts,
        'team_labels': team_labels,
        'team_budgets': team_budgets,
        'months': months_data,
        'completed_per_month': completed_per_month,
        'new_per_month': new_per_month,
    }
    return render(request, 'statistics.html', context)


def teams_list(request):
    teams = Team.objects.prefetch_related('members', 'projects__tasks').all()
    for team in teams:
        team.total_tasks = 0
        team.completed_tasks = 0
        for project in team.projects.all():
            team.total_tasks += project.tasks.count()
            team.completed_tasks += project.tasks.filter(status='completed').count()

    return render(request, 'teams.html', {'teams': teams})


def create_team(request):
    # Si cette vue est utilisée pour un formulaire standard
    if request.method == 'POST':
        form = TeamForm(request.POST)
        if form.is_valid():
            team = form.save()
            messages.success(request, f"L'équipe '{team.name}' a été créée avec succès !")
            return redirect('teams_list') # Redirige vers la liste des équipes
        else:
            messages.error(request, "Erreur lors de la création de l'équipe. Veuillez corriger les erreurs.")
    else:
        form = TeamForm()
    return render(request, 'team_create.html', {'form': form}) # Créez un template 'team_create.html' si ce n'est pas déjà fait


def membres_list(request):
    membres = Member.objects.prefetch_related('team', 'tasks').annotate(
        completed_tasks_count=Count('tasks', filter=Q(tasks__status='completed'))
    ).order_by('name') # Tri par nom pour une meilleure lisibilité

    for membre in membres:
        membre.skills_list = [s.strip() for s in (membre.skills or '').split(',') if s.strip()]
        # Récupère les projets distincts auxquels le membre est assigné via des tâches
        membre.projects_assigned = Project.objects.filter(tasks__assigned_to=membre).distinct()

    context = {
        'membres': membres,
    }
    return render(request, 'membres.html', context)

# gestiondesprojetsapp/views.py

from django.shortcuts import render, redirect
from django.contrib import messages
from .forms import MemberForm # Assuming you have a form for Member
from .models import Team, Member # Import your Team and Member models

def create_member(request): # The view function name matches your urls.py
    if request.method == 'POST':
        form = MemberForm(request.POST) # Use the form dedicated to members
        if form.is_valid():
            member = form.save(commit=False) # Don't save the Member object just yet

            # --- Handle the team selection by name ---
            team_name = request.POST.get('team_name') # Get the value from the 'name="team_name"' field in the template
            if team_name:
                try:
                    # Find the Team object that matches the received name
                    member.team = Team.objects.get(name=team_name)
                except Team.DoesNotExist:
                    messages.error(request, f"The selected team '{team_name}' is invalid. Please select an existing one or create a new one.")
                    teams = Team.objects.all() # Re-fetch teams for the context in case of error
                    return render(request, 'add_member.html', {'form': form, 'teams': teams})
            else:
                member.team = None # If no team is selected (if the field isn't mandatory for a member)

            member.save() # Save the member with the assigned team
            messages.success(request, "Member added successfully!")
            return redirect('membres_list') # Redirect to the member list after success
        else:
            messages.error(request, "Please correct the errors in the form.")
    else:
        form = MemberForm() # Create an empty form for a GET request

    # --- KEY STEP: Fetch all teams to pass to the template ---
    teams = Team.objects.all() # This line retrieves teams from the database

    return render(request, 'add_member.html', {'form': form, 'teams': teams})

def edit_member(request, member_id):
    member = get_object_or_404(Member, pk=member_id)
    if request.method == 'POST':
        form = MemberForm(request.POST, instance=member)
        if form.is_valid():
            form.save()
            messages.success(request, f"Le membre '{member.name}' a été mis à jour avec succès.")
            return redirect('membres_list')
        else:
            messages.error(request, "Erreur lors de la mise à jour du membre. Veuillez corriger les erreurs.")
    else:
        form = MemberForm(instance=member)
    teams = Team.objects.all() # Pour le champ équipe
    return render(request, 'edit_member.html', {'member': member, 'teams': teams, 'form': form})


@require_POST
def delete_member(request, member_id):
    member = get_object_or_404(Member, pk=member_id)
    member_name = member.name
    member.delete()
    messages.success(request, f"Le membre '{member_name}' a été supprimé avec succès.")
    return redirect('membres_list')


def member_detail(request, member_id):
    member = get_object_or_404(Member, pk=member_id)
    # Les tâches du membre
    tasks = member.tasks.all().select_related('project').order_by('-due_date')
    # Les projets auxquels il est lié par ses tâches
    projects_involved = Project.objects.filter(tasks__assigned_to=member).distinct()
    return render(request, 'member_detail.html', {'member': member, 'tasks': tasks, 'projects_involved': projects_involved})


def project_edit(request, project_id):
    project = get_object_or_404(Project, pk=project_id)
    if request.method == 'GET':
        form = ProjectForm(instance=project)
        # Rendu HTMX ou JSON pour un formulaire de modification dans une modale
        html = render_to_string('partials/project_edit_form.html', {'form': form, 'project': project}, request=request)
        return JsonResponse({'html': html})
    elif request.method == 'POST':
        form = ProjectForm(request.POST, instance=project)
        if form.is_valid():
            form.save()
            messages.success(request, f"Projet '{project.name}' mis à jour avec succès !")
            return JsonResponse({'success': True, 'message': 'Projet mis à jour!'})
        else:
            messages.error(request, "Erreur lors de la mise à jour du projet.")
            html = render_to_string('partials/project_edit_form.html', {'form': form, 'project': project}, request=request)
            return JsonResponse({'success': False, 'form_html': html, 'message': 'Erreurs de validation.'}, status=400) # Statut 400
    return JsonResponse({'error': 'Méthode de requête invalide.'}, status=400)


@require_POST
def project_delete(request, project_id):
    project = get_object_or_404(Project, pk=project_id)
    project_name = project.name
    project.delete()
    messages.success(request, f"Le projet '{project_name}' a été supprimé avec succès.")
    return JsonResponse({'success': True}) # Utile si utilisé avec HTMX


def task_edit(request, task_id):
    task = get_object_or_404(Task, pk=task_id)
    if request.method == 'POST':
        form = TaskForm(request.POST, instance=task)
        if form.is_valid():
            form.save()
            messages.success(request, f"La tâche '{task.name}' a été mise à jour avec succès.")
            return redirect('tasks_list') # Redirige vers la liste des tâches
        else:
            messages.error(request, "Erreur lors de la mise à jour de la tâche. Veuillez corriger les erreurs.")
    else:
        form = TaskForm(instance=task)
    return render(request, 'task_edit.html', {'form': form, 'task': task})


@require_POST
def task_delete(request, task_id):
    task = get_object_or_404(Task, pk=task_id)
    task_name = task.name
    task.delete()
    messages.success(request, f"La tâche '{task_name}' a été supprimée avec succès.")
    return JsonResponse({'success': True}) # Utile si utilisé avec HTMX


def member_tasks(request, member_id):
    member = get_object_or_404(Member, pk=member_id)
    tasks = Task.objects.filter(assigned_to=member).select_related('project').order_by('-due_date')
    return render(request, 'member_tasks.html', {'member': member, 'tasks': tasks})