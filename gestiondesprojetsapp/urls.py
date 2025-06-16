from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('projects/', views.projects, name='projects'),
    path('projects/create/', views.project_create, name='project_create'),
    path('projects/create_htmx/', views.project_create_htmx, name='project_create_htmx'),
    path('tasks/', views.tasks_list, name='tasks'),
    path('tasks/create/', views.task_create, name='task_create'),
    path('projects/<int:project_id>/tasks/', views.project_tasks, name='project_tasks'),
    path('tasks/<int:task_id>/toggle/', views.toggle_task_status, name='toggle_task_status'),
    path('statistics/', views.statistics, name='statistics'),
    path('teams/', views.teams_list, name='teams_list'),
    path('teams/create/', views.create_team, name='create_team'),
    path('membres/', views.membres_list, name='membres_list'),
    path('membres/create/', views.create_member, name='add_member'),  # Ligne corrigée
    path('membres/<int:member_id>/edit/', views.edit_member, name='edit_member'),
    path('membres/<int:member_id>/delete/', views.delete_member, name='delete_member'),
    path('membres/<int:member_id>/', views.member_detail, name='member_detail'),
    path('projects/<int:project_id>/edit/', views.project_edit, name='project_edit'),
    path('projects/<int:project_id>/delete/', views.project_delete, name='project_delete'),
    path('tasks/<int:task_id>/edit/', views.task_edit, name='task_edit'),
    path('tasks/<int:task_id>/delete/', views.task_delete, name='task_delete'),
    path('membres/<int:member_id>/tasks/', views.member_tasks, name='member_tasks'),
    path('tasks/<int:task_id>/toggle-status/', views.toggle_task_status, name='toggle_task_status')
]