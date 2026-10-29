from django.contrib import admin
from seguimiento.models import (
    Progreso,
    EvaluacionesFisicas,
    Asistencias,
)

admin.site.register([
    Progreso,
    EvaluacionesFisicas,
    Asistencias,
])
