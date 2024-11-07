from django.shortcuts import render, redirect
from .forms import AttendeeForm
from .models import Attendee
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
            attendee.registered_at_event = True  # Mark as same-day registration
            attendee.save()
            messages.success(request, "Registration successful!")  # Display success message
            return redirect('register_attendee')  # Redirect to the same registration page to refresh the form
    else:
        form = AttendeeForm()
    return render(request, 'registry_app/front_desk_register.html', {'form': form})

# Review view
def leave_review(request, attendee_id):
    attendee = Attendee.objects.get(id=attendee_id)
    if request.method == 'POST':
        form = ReviewForm(request.POST)
        if form.is_valid():
            review = form.save(commit=False)
            review.attendee = attendee
            review.save()
            return redirect('review_success')
    else:
        form = ReviewForm()
    return render(request, 'registry_app/review.html', {'form': form, 'attendee': attendee})

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
