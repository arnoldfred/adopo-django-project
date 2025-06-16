from django.contrib import admin
from django.urls import include, path
from gestiondesprojetsapp import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.home, name='index'),
    path('projects/', views.projects, name='projects'),
    #path('projects/tasks/', views.tasks, name='tasks'),
    path('statistics/', views.statistics, name='statistics'),
    path('projects/create/', views.project_create, name='project_create'),
    path('tasks/create/', views.task_create, name='task_create'),
    path('tasks/', views.tasks_list, name='tasks_list'),
    path('projects/<int:project_id>/tasks/', views.project_tasks, name='project_tasks'),
    path('teams/', views.teams_list, name='teams_list'),
    path('teams/create/', views.create_team, name='create_team'),
    path('teams/', views.teams_list, name='teams_list'),
    path('membres/', views.membres_list, name='membres_list'),

    path('', include('gestiondesprojetsapp.urls')),  # <-- ajoute cette ligne


    # Pour toutes les autres routes de l'app :
]