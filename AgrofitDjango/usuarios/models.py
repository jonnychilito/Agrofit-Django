from django.contrib.auth.models import AbstractUser
from django.db import models


# Create your models here.

class Usuarios(AbstractUser):
    ROL_CHOICE = (
        ('funcionario', 'Funcionario'),
        ('entrenador', 'Entrenador'),
        ('aprendiz', 'Aprendiz'),
    )

    rol = models.CharField(max_length=20, choices=ROL_CHOICE, default='aprendiz', verbose_name='Rol')

    class Meta:
        verbose_name = 'Usuario'
        verbose_name_plural = 'Usuarios'

    def __str__(self):
        return f"{self.username} - ---"