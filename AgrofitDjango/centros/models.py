from django.db import models

# Create your models here.

class CentroFormacion(models.Model):
    idcentro = models.AutoField(db_column='idCentro', primary_key=True)  # Field name made lowercase.
    nomcentro = models.CharField(db_column='nomCentro', max_length=50)  # Field name made lowercase.
    codcentro = models.CharField(db_column='codCentro', max_length=50)  # Field name made lowercase.
    direccionc = models.CharField(db_column='direccionC', max_length=50)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'centro_formacion'

class DependenciasCentro(models.Model):
    iddependencia = models.AutoField(db_column='idDependencia', primary_key=True)  # Field name made lowercase.
    nombre = models.CharField(max_length=50)
    idcentro_fk = models.ForeignKey('CentroFormacion', models.DO_NOTHING, db_column='idCentro_fk', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'dependencias_centro'

class Fichas(models.Model):
    idficha = models.AutoField(db_column='idFicha', primary_key=True)  # Field name made lowercase.
    idprograma_fk = models.ForeignKey('Programas', models.DO_NOTHING, db_column='idPrograma_fk', blank=True, null=True)  # Field name made lowercase.
    idcentro_fk = models.ForeignKey('CentroFormacion', models.DO_NOTHING, db_column='idCentro_fk', blank=True, null=True)  # Field name made lowercase.
    numficha = models.CharField(db_column='numFicha', max_length=50)  # Field name made lowercase.
    jornada = models.CharField(max_length=6, blank=True, null=True)
    nivelf = models.CharField(db_column='nivelF', max_length=9, blank=True, null=True)  # Field name made lowercase.
    fechaini = models.DateField(db_column='fechaIni', blank=True, null=True)  # Field name made lowercase.
    fechafin = models.DateField(db_column='fechaFin', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'fichas'

class Programas(models.Model):
    idprograma = models.AutoField(db_column='idPrograma', primary_key=True)  # Field name made lowercase.
    codprog = models.CharField(db_column='codProg', max_length=50)  # Field name made lowercase.
    nomprog = models.CharField(db_column='nomProg', max_length=50)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'programas'

