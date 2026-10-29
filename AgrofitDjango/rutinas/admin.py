from django.contrib import admin
from rutinas.models import (
    Rutinas,
    Ejercicios,
    Maquinas,
    Musculos,
    PartesCuerpo,
    RutinaEjercicios,
    AprendizRutina,
    SemanaAdaptacion,
)

admin.site.register([
    Rutinas,
    Ejercicios,
    Maquinas,
    Musculos,
    PartesCuerpo,
    RutinaEjercicios,
    AprendizRutina,
    SemanaAdaptacion,
])
