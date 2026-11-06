from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login

# Create your views here.

def inicio(request):

    if request.method == 'POST':

        documento = request.POST.get('documento')
        contrasena = request.POST.get('contrasena')

        usuario = authenticate(
            request,
            username=documento,
            password=contrasena
        )

        if usuario is not None:
            login(request, usuario)

            rol = usuario.idrol_fk.nomrol

            if rol == 'Aprendiz':
                return redirect('aprendiz')

            elif rol == 'Entrenador':
                return redirect('entrenador')

            elif rol == 'Funcionario':
                return redirect('funcionario')

            else:
                return redirect('inicio')

        else:
            return render(request, 'usuarios/inicio.html', {
                'error': 'Documento o contraseña incorrectos.'
            })
    return render(request, 'usuarios/inicio.html')

def aprendiz(request):
    return render(request, 'perfiles/aprendiz.html')

def entrenador(request):
    return render(request, 'perfiles/entrenador.html')

def funcionario(request):
    return render(request, 'perfiles/funcionario.html')

def registroa(request):
    return render(request, 'usuarios/registro_a.html')

def registroe(request):
    return render(request, 'usuarios/registro_e.html')

def registrof(request):
    return render(request, 'usuarios/registro_f.html')

def clave1(request):
    return render(request, 'usuarios/clave1.html')

def clave2(request):
    return render(request, 'usuarios/clave2.html')

def clave3(request):
    return render(request, 'usuarios/clave3.html')