from django.urls import path
from . import views

urlpatterns = [
    path('', views.inicio, name='inicio'),
    path('inicio/', views.inicio, name='inicio2'),
    path('registroa/', views.registroa, name='registroa'),
    path('registroe/', views.registroe, name='registroe'),
    path('registrof/', views.registrof, name='registrof'),
    path('clave1/', views.clave1, name='clave1'),
    path('clave2/', views.clave2, name='clave2'),
    path('clave3/', views.clave3, name='clave3'),
    path('aprendiz/', views.aprendiz, name='aprendiz'),
    path('entrenador/', views.entrenador, name='entrenador'),
    path('funcionario/', views.funcionario, name='funcionario'),
]