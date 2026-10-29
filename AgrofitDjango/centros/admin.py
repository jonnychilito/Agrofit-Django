from django.contrib import admin
from centros.models import (
    CentroFormacion,
    DependenciasCentro,
    Fichas,
    Programas,
)

admin.site.register([
    CentroFormacion,
    DependenciasCentro,
    Fichas,
    Programas,
])
