from django.db import models

# Create your models here.

class Rutinas(models.Model):
    idrutina = models.AutoField(db_column='idRutina', primary_key=True)  # Field name made lowercase.
    identrenador_fk = models.ForeignKey('usuarios.Entrenadores', models.DO_NOTHING, db_column='idEntrenador_fk', blank=True, null=True)  # Field name made lowercase.
    nomrutina = models.CharField(db_column='nomRutina', max_length=50)  # Field name made lowercase.
    objetivo = models.CharField(max_length=11)
    nivelrutina = models.CharField(db_column='nivelRutina', max_length=12, blank=True, null=True)  # Field name made lowercase.
    estadorutina = models.CharField(db_column='estadoRutina', max_length=8, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'rutinas'

class Ejercicios(models.Model):
    idejercicio = models.AutoField(db_column='idEjercicio', primary_key=True)  # Field name made lowercase.
    idmaquina_fk = models.ForeignKey('Maquinas', models.DO_NOTHING, db_column='idMaquina_fk', blank=True, null=True)  # Field name made lowercase.
    idmusculo_fk = models.ForeignKey('Musculos', models.DO_NOTHING, db_column='idMusculo_fk', blank=True, null=True)  # Field name made lowercase.
    nombre = models.CharField(max_length=50)
    repeticiones = models.IntegerField()
    descripcion = models.TextField(blank=True, null=True)
    videodemo = models.CharField(db_column='videoDemo', max_length=250, blank=True, null=True)  # Field name made lowercase.
    descanso = models.TimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'ejercicios'

class Maquinas(models.Model):
    idmaquina = models.AutoField(db_column='idMaquina', primary_key=True)  # Field name made lowercase.
    codmaq = models.CharField(db_column='codMaq', max_length=50)  # Field name made lowercase.
    nommaq = models.CharField(db_column='nomMaq', max_length=50)  # Field name made lowercase.
    pesomax = models.IntegerField(db_column='pesoMax', blank=True, null=True)  # Field name made lowercase.
    estadomaq = models.CharField(db_column='estadoMaq', max_length=17)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'maquinas'

class Musculos(models.Model):
    idmusculo = models.AutoField(db_column='idMusculo', primary_key=True)  # Field name made lowercase.
    idpartecuerpo_fk = models.ForeignKey('PartesCuerpo', models.DO_NOTHING, db_column='idParteCuerpo_fk', blank=True, null=True)  # Field name made lowercase.
    nombre = models.CharField(max_length=50)
    descripcion = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'musculos'

class PartesCuerpo(models.Model):
    idpartecuerpo = models.AutoField(db_column='idParteCuerpo', primary_key=True)  # Field name made lowercase.
    nombre = models.CharField(max_length=50)
    descripcion = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'partes_cuerpo'

class RutinaEjercicios(models.Model):
    idrutinaejercicio = models.AutoField(db_column='idRutinaEjercicio', primary_key=True)  # Field name made lowercase.
    idrutina_fk = models.ForeignKey('Rutinas', models.DO_NOTHING, db_column='idRutina_fk', blank=True, null=True)  # Field name made lowercase.
    idejercicio_fk = models.ForeignKey('Ejercicios', models.DO_NOTHING, db_column='idEjercicio_fk', blank=True, null=True)  # Field name made lowercase.
    orden = models.IntegerField()
    series = models.IntegerField()
    repeticiones = models.IntegerField()
    descanso = models.TimeField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'rutina_ejercicios'

class AprendizRutina(models.Model):
    idaprendizrutina = models.AutoField(db_column='idAprendizRutina', primary_key=True)  # Field name made lowercase.
    idusuario_fk = models.ForeignKey('usuarios.Usuarios', models.DO_NOTHING, db_column='idUsuario_fk', blank=True, null=True)  # Field name made lowercase.
    idrutina_fk = models.ForeignKey('Rutinas', models.DO_NOTHING, db_column='idRutina_fk')  # Field name made lowercase.
    fechaasignacion = models.DateField(db_column='fechaAsignacion')  # Field name made lowercase.
    estado = models.CharField(max_length=10, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'aprendiz_rutina'

class SemanaAdaptacion(models.Model):
    idadaptacion = models.AutoField(db_column='idAdaptacion', primary_key=True)  # Field name made lowercase.
    idusuario_fk = models.ForeignKey('usuarios.Usuarios', models.DO_NOTHING, db_column='idUsuario_fk', blank=True, null=True)  # Field name made lowercase.
    idrutina_fk = models.ForeignKey('Rutinas', models.DO_NOTHING, db_column='idRutina_fk', blank=True, null=True)  # Field name made lowercase.
    fechainicio = models.DateField(db_column='fechaInicio')  # Field name made lowercase.
    fechafin = models.DateField(db_column='fechaFin', blank=True, null=True)  # Field name made lowercase.
    estado = models.CharField(max_length=12)

    class Meta:
        managed = False
        db_table = 'semana_adaptacion'

