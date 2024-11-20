from django.shortcuts import render, redirect
from .forms import AttendeeForm, ReviewForm
from .models import Attendee
import logging
from django.http import FileResponse, HttpResponseNotFound
from django.shortcuts import get_object_or_404, render
from .models import FileDownload
from django.conf import settings
import os

logger = logging.getLogger(__name__)

from django.contrib import messages

# Pre-registration view
def register_attendee(request):
    if request.method == 'POST':
        form = AttendeeForm(request.POST)
        if form.is_valid():
            attendee = form.save(commit=False)
            attendee.pre_registered = True
            attendee.save()
            # Mostrar mensaje de éxito
            messages.success(request, "Registro exitoso!")
            return redirect('register_attendee')
        else:
            # Agregar todos los errores del formulario a `messages` para mostrarlos en la parte superior
            for field, errors in form.errors.items():
                for error in errors:
                    # Crear un mensaje que combine el campo y el error
                    messages.error(request, error)
    else:
        form = AttendeeForm()

    # Renderizar siempre el formulario con cualquier mensaje (error o éxito)
    return render(request, 'registry_app/register.html', {'form': form})


# Same-day registration view
def front_desk_register(request):
    if request.method == 'POST':
        form = AttendeeForm(request.POST)
        if form.is_valid():
            attendee = form.save(commit=False)
            attendee.registered_at_event = True
            attendee.save()
            # Mostrar mensaje de éxito
            messages.success(request, "Registro exitoso!")
            return redirect('register_attendee')
        else:
            # Agregar todos los errores del formulario a messages para mostrarlos en la parte superior
            for field, errors in form.errors.items():
                for error in errors:
                    # Crear un mensaje que combine el campo y el error
                    messages.error(request, error)
    else:
        form = AttendeeForm()

    # Renderizar siempre el formulario con cualquier mensaje (error o éxito)
    return render(request, 'registry_app/front_desk_register.html', {'form': form})

# registry_app/views.py
def leave_review(request):
    if request.method == 'POST':
        logger.debug(f"POST data: {request.POST}")  # Add this line to log submitted data
        form = ReviewForm(request.POST)
        if form.is_valid():
            form.save()
            messages.success(request, "¡Gracias por tu retroalimentación!")
            return redirect('leave_review')
        else:
            logger.error(f"Form errors: {form.errors}")
            for field, errors in form.errors.items():
                for error in errors:
                    messages.error(request, f"{field}: {error}")
    else:
        form = ReviewForm()

    return render(request, 'registry_app/review.html', {'form': form})

def attendee_lists(request):
    pre_registered_attendees = Attendee.objects.filter(pre_registered=True)
    same_day_registered_attendees = Attendee.objects.filter(registered_at_event=True)
    return render(request, 'registry_app/attendee_lists.html', {
        'pre_registered_attendees': pre_registered_attendees,
        'same_day_registered_attendees': same_day_registered_attendees
    })

def test_template(request):
    return render(request, 'registry_app/test.html')

def pre_registered_list(request):
    attendees = Attendee.objects.filter(pre_registered=True)
    return render(request, 'registry_app/pre_registered_list.html', {'attendees': attendees})

def front_desk_registered_list(request):
    attendees = Attendee.objects.filter(registered_at_event=True)
    return render(request, 'registry_app/front_desk_registered_list.html', {'attendees': attendees})

# View for downloading files
def download_file(request, file_id):
    # Get the file record from the database
    file_record = get_object_or_404(FileDownload, id=file_id)

    # Construct the full file path
    file_path = os.path.join(settings.MEDIA_ROOT, 'files', file_record.file_name)

    # Serve the file or return a 404 if not found
    try:
        return FileResponse(open(file_path, 'rb'), as_attachment=True, filename=file_record.file_name)
    except FileNotFoundError:
        return HttpResponseNotFound("The requested file does not exist.")

# View for listing files
def file_list(request):
    files = FileDownload.objects.all()
    return render(request, 'registry_app/file_list.html', {'files': files})
