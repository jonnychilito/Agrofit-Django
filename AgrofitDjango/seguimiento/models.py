from django.db import models

# Create your models here.

class Progreso(models.Model):
    idprogreso = models.AutoField(db_column='idProgreso', primary_key=True)  # Field name made lowercase.
    idaprendizrutina_fk = models.ForeignKey('rutinas.AprendizRutina', models.DO_NOTHING, db_column='idAprendizRutina_fk', blank=True, null=True)  # Field name made lowercase.
    idrutinaejercicio_fk = models.ForeignKey('rutinas.RutinaEjercicios', models.DO_NOTHING, db_column='idRutinaEjercicio_fk', blank=True, null=True)  # Field name made lowercase.
    fecha = models.DateField(blank=True, null=True)
    peso = models.DecimalField(max_digits=20, decimal_places=6, blank=True, null=True)
    repeticiones = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'progreso'

class EvaluacionesFisicas(models.Model):
    idevaluacion = models.AutoField(db_column='idEvaluacion', primary_key=True)  # Field name made lowercase.
    idaprendiz_fk = models.ForeignKey('usuarios.Aprendices', models.DO_NOTHING, db_column='idAprendiz_fk')  # Field name made lowercase.
    identrenador_fk = models.ForeignKey('usuarios.Entrenadores', models.DO_NOTHING, db_column='idEntrenador_fk')  # Field name made lowercase.
    fechaevaluacion = models.DateField(db_column='fechaEvaluacion')  # Field name made lowercase.
    peso = models.DecimalField(max_digits=5, decimal_places=2, blank=True, null=True)
    altura = models.DecimalField(max_digits=4, decimal_places=2, blank=True, null=True)
    imc = models.DecimalField(max_digits=4, decimal_places=2, blank=True, null=True)
    frecuenciacardiaca = models.IntegerField(db_column='frecuenciaCardiaca', blank=True, null=True)  # Field name made lowercase.
    observaciones = models.TextField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'evaluaciones_fisicas'

class Asistencias(models.Model):
    idasistencia = models.AutoField(db_column='idAsistencia', primary_key=True)  # Field name made lowercase.
    idaprendiz_fk = models.ForeignKey('usuarios.Aprendices', models.DO_NOTHING, db_column='idAprendiz_fk')  # Field name made lowercase.
    fechaasistencia = models.DateField(db_column='fechaAsistencia')  # Field name made lowercase.
    horaentrada = models.TimeField(db_column='horaEntrada', blank=True, null=True)  # Field name made lowercase.
    horasalida = models.TimeField(db_column='horaSalida', blank=True, null=True)  # Field name made lowercase.
    estado = models.CharField(max_length=8, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'asistencias'

