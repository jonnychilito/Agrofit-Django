
from django.db import models
from django.contrib.auth.base_user import AbstractBaseUser, BaseUserManager

class Roles(models.Model):
    idrol = models.AutoField(
        db_column='idRol',
        primary_key=True
    )

    nomrol = models.CharField(
        db_column='nomRol',
        max_length=50
    )

    class Meta:
        managed = False
        db_table = 'roles'
        verbose_name = 'Rol'
        verbose_name_plural = 'Roles'

    def __str__(self):
        return self.nomrol

class TipoDocumento(models.Model):
    idtipodoc = models.AutoField(
        db_column='idTipoDoc',
        primary_key=True
    )

    nomdoc = models.CharField(
        db_column='nomDoc',
        max_length=50
    )

    class Meta:
        managed = False
        db_table = 'tipo_documento'
        verbose_name = 'Tipo de documento'
        verbose_name_plural = 'Tipos de documento'

    def __str__(self):
        return self.nomdoc

class UsuariosManager(BaseUserManager):

    def create_user(self, docusu, password=None, **extra_fields):
        if not docusu:
            raise ValueError("El documento es obligatorio")

        usuario = self.model(
            docusu=docusu,
            **extra_fields
        )

        usuario.set_password(password)
        usuario.save(using=self._db)

        return usuario

    def create_superuser(self, docusu, password=None, **extra_fields):
        raise NotImplementedError(
            "Utiliza el usuario existente de la tabla administradores."
        )

class Usuarios(AbstractBaseUser):

    idusuario = models.AutoField(
        db_column='idUsuario',
        primary_key=True
    )

    idrol_fk = models.ForeignKey(
    'Roles',
    models.DO_NOTHING,
    db_column='idRol_fk',
    blank=True,
    null=True
    )

    idtipodoc_fk = models.ForeignKey(
        'TipoDocumento',
        models.DO_NOTHING,
        db_column='idTipoDoc_fk',
        blank=True,
        null=True
    )

    docusu = models.CharField(
        db_column='docUsu',
        max_length=50,
        unique=True
    )

    nomusu = models.CharField(
        db_column='nomUsu',
        max_length=50
    )

    apellusu = models.CharField(
        db_column='apellUsu',
        max_length=50
    )

    numusu = models.CharField(
        db_column='numUsu',
        max_length=50
    )

    correousu = models.CharField(
        db_column='correoUsu',
        max_length=50,
        unique=True
    )

    password = models.CharField(
        db_column='clave',
        max_length=200
    )

    estadou = models.CharField(
        db_column='estadoU',
        max_length=8
    )

    edad = models.IntegerField(
        blank=True,
        null=True
    )

    peso = models.DecimalField(
        max_digits=5,
        decimal_places=2,
        blank=True,
        null=True
    )

    estatura = models.DecimalField(
        max_digits=10,
        decimal_places=2,
        blank=True,
        null=True
    )

    # Esta tabla no tiene una columna last_login.
    last_login = None

    objects = UsuariosManager()

    USERNAME_FIELD = 'docusu'

    REQUIRED_FIELDS = [
        'nomusu',
        'apellusu',
        'correousu',
        'numusu'
    ]

    @property
    def is_active(self):
        return self.estadou == 'ACTIVO'
    
    @property
    def is_staff(self):
        return self.es_administrador

    @property
    def is_superuser(self):
        return self.es_administrador

    @property
    def es_administrador(self):
        return Administradores.objects.filter(
            idusuario_fk=self.pk
        ).exists()

    def has_perm(self, perm, obj=None):
        return self.is_superuser

    def has_module_perms(self, app_label):
        return self.is_superuser

    class Meta:
        managed = False
        db_table = 'usuarios'
        verbose_name = 'Usuario'
        verbose_name_plural = 'Usuarios'

    def __str__(self):
        return f"{self.docusu} - {self.nomusu}"

class Administradores(models.Model):
    idadmin = models.AutoField(db_column='idAdmin', primary_key=True)  # Field name made lowercase.
    idusuario_fk = models.ForeignKey('Usuarios', models.DO_NOTHING, db_column='idUsuario_fk', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'administradores'

class Aprendices(models.Model):
    idaprendiz = models.AutoField(db_column='idAprendiz', primary_key=True)  # Field name made lowercase.
    idusuario_fk = models.ForeignKey('Usuarios', models.DO_NOTHING, db_column='idUsuario_fk', blank=True, null=True)  # Field name made lowercase.
    idficha_fk = models.ForeignKey('centros.Fichas', models.DO_NOTHING, db_column='idFicha_fk', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'aprendices'

class Entrenadores(models.Model):
    identrenador = models.AutoField(db_column='idEntrenador', primary_key=True)  # Field name made lowercase.
    idusuario_fk = models.ForeignKey('Usuarios', models.DO_NOTHING, db_column='idUsuario_fk', blank=True, null=True)  # Field name made lowercase.
    idespecialidad_fk = models.ForeignKey('Especialidades', models.DO_NOTHING, db_column='idEspecialidad_fk', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'entrenadores'

class HorariosInstructor(models.Model):
    idhorario = models.AutoField(db_column='idHorario', primary_key=True)  # Field name made lowercase.
    identrenador_fk = models.ForeignKey('Entrenadores', models.DO_NOTHING, db_column='idEntrenador_fk')  # Field name made lowercase.
    diasemana = models.CharField(db_column='diaSemana', max_length=9)  # Field name made lowercase.
    horainicio = models.TimeField(db_column='horaInicio')  # Field name made lowercase.
    horafin = models.TimeField(db_column='horaFin')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'horarios_instructor'

class Especialidades(models.Model):
    idespecialidad = models.AutoField(db_column='idEspecialidad', primary_key=True)  # Field name made lowercase.
    nomesp = models.CharField(db_column='nomEsp', max_length=50, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'especialidades'

class Funcionarios(models.Model):
    idfuncionario = models.AutoField(db_column='idFuncionario', primary_key=True)  # Field name made lowercase.
    idusuario_fk = models.ForeignKey('Usuarios', models.DO_NOTHING, db_column='idUsuario_fk', blank=True, null=True)  # Field name made lowercase.
    iddependenciaf_fk = models.ForeignKey('DependenciasFuncionario', models.DO_NOTHING, db_column='idDependenciaF_fk', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'funcionarios'

class DependenciasFuncionario(models.Model):
    iddependenciaf = models.AutoField(db_column='idDependenciaF', primary_key=True)  # Field name made lowercase.
    nomdependenciaf = models.CharField(db_column='nomDependenciaF', max_length=200)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'dependencias_funcionario'

