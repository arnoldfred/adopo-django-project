# gestiondesprojetsapp/models.py

from django.db import models

class Team(models.Model):
    name = models.CharField(max_length=100)
    description = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

class Member(models.Model):
    name = models.CharField(max_length=200)
    email = models.EmailField()
    role = models.CharField(max_length=50)
    # --- C'est le changement crucial : ajout de related_name='members' ---
    team = models.ForeignKey(Team, on_delete=models.CASCADE, related_name='members')
    # -------------------------------------------------------------------
    skills = models.TextField(blank=True, null=True)
    avatar_emoji = models.CharField(max_length=2, default="👤")
    status = models.CharField(max_length=20, default="active")

    def __str__(self):
        return self.name

class Project(models.Model):
    PRIORITY_CHOICES = [
        ('high', 'Urgent'),
        ('medium', 'Normal'),
        ('low', 'Faible'),
    ]
    name = models.CharField(max_length=255)
    description = models.TextField()
    team = models.ForeignKey(Team, related_name='projects', on_delete=models.CASCADE)
    priority = models.CharField(max_length=10, choices=PRIORITY_CHOICES)
    deadline = models.DateField()
    budget = models.DecimalField(max_digits=12, decimal_places=2)
    updated_at = models.DateTimeField(auto_now=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

    def completed_tasks(self):
        return self.tasks.filter(status='completed').count()

    def total_tasks(self):
        return self.tasks.count()

    def progress_percent(self):
        total = self.total_tasks()
        return int((self.completed_tasks() / total) * 100) if total else 0

class Task(models.Model):
    STATUS_CHOICES = [
        ('completed', 'Terminée'),
        ('pending', 'En attente'),
    ]
    PRIORITY_CHOICES = [
        ('low', 'Faible'),
        ('medium', 'Normal'),
        ('high', 'Urgent'),
    ]
    project = models.ForeignKey(Project, related_name='tasks', on_delete=models.CASCADE)
    title = models.CharField(max_length=255)
    description = models.TextField()
    priority = models.CharField(max_length=10, choices=PRIORITY_CHOICES, default='medium')
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default='pending')
    assigned_to = models.ForeignKey(Member, on_delete=models.SET_NULL, null=True, related_name='tasks')
    due_date = models.DateField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.title