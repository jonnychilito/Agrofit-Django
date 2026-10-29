from django.contrib import admin
from usuarios.models import (Usuarios, Roles, TipoDocumento, Aprendices, Entrenadores, Funcionarios, Administradores, DependenciasFuncionario)


@admin.register(Usuarios)
class UsuariosAdmin(admin.ModelAdmin):
    list_display = (
        'docusu',
        'nomusu',
        'apellusu',
        'correousu',
        'estadou',
        'es_administrador',
    )

    search_fields = (
        'docusu',
        'nomusu',
        'apellusu',
        'correousu',
    )

    list_filter = ('estadou',)

    ordering = ('docusu',)

    readonly_fields = ('es_administrador',)

    fields = (
        'docusu',
        'nomusu',
        'apellusu',
        'correousu',
        'numusu',
        'idrol_fk',
        'idtipodoc_fk',
        'estadou',
        'edad',
        'peso',
        'estatura',
        'es_administrador',
    )

admin.site.register([
    Roles,
    TipoDocumento,
    Aprendices,
    Entrenadores,
    Funcionarios,
    Administradores,
    DependenciasFuncionario,
])