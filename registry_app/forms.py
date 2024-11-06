# registry_app/forms.py
from django import forms
from .models import Attendee, Review
from django.core.exceptions import ValidationError

class AttendeeForm(forms.ModelForm):
    class Meta:
        model = Attendee
        fields = ['name', 'last_name', 'phone_number', 'date_of_birth', 'email']
        widgets = {
            'date_of_birth': forms.DateInput(attrs={'type': 'date'}),  # Use a date input widget
        }
        labels = {
        'name': 'Nombre1',
        'last_name': 'Apellidos',
        'phone_number': 'Número de teléfono',
        'date_of_birth': 'Fecha de nacimiento',
        'email': 'Correo electrónico',
    }
    def clean_email(self):
        email = self.cleaned_data.get('email')
        if Attendee.objects.filter(email=email).exists():
            raise ValidationError("Este correo electrónico ya está en uso. Por favor, use otro.")
        return email

class ReviewForm(forms.ModelForm):
    class Meta:
        model = Review
        fields = ['rating', 'comments']
        widgets = {
            'rating': forms.RadioSelect(choices=[(i, str(i)) for i in range(1, 6)]),
        }
