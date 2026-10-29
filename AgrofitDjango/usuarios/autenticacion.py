
from django.contrib.auth.backends import ModelBackend
from django.contrib.auth.hashers import check_password, identify_hasher
from django.contrib.auth.hashers import make_password

from usuarios.models import Usuarios


class AgrofitBackend(ModelBackend):

    def authenticate(
        self,
        request,
        username=None,
        password=None,
        **kwargs
    ):
        documento = username or kwargs.get("docusu")

        if not documento or password is None:
            return None

        try:
            usuario = Usuarios.objects.get(docusu=documento)
        except Usuarios.DoesNotExist:
            return None

        if not usuario.is_active:
            return None

        clave_guardada = usuario.password

        # Comprueba si la clave ya tiene un hash de Django.
        try:
            identify_hasher(clave_guardada)
            es_hash = True
        except (ValueError, TypeError):
            es_hash = False

        if es_hash:
            if check_password(password, clave_guardada):
                return usuario
        else:
            # Compatibilidad temporal con las claves antiguas.
            if clave_guardada == password:
                usuario.password = make_password(password)
                usuario.save(update_fields=["password"])
                return usuario

        return None
