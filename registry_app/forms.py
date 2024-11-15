# registry_app/forms.py
from django import forms
from .models import Attendee, Review

class AttendeeForm(forms.ModelForm):
    class Meta:
        model = Attendee
        fields = ['name', 'last_name', 'phone_number', 'date_of_birth', 'email']
        widgets = {
            'date_of_birth': forms.DateInput(attrs={'type': 'date'}),  # Use a date input widget
        }
        labels = {
        'name': 'Nombre',
        'last_name': 'Apellidos',
        'phone_number': 'Número de teléfono',
        'date_of_birth': 'Fecha de nacimiento',
        'email': 'Correo electrónico',
    }
    # Personalizar la validación del campo email
    def clean_email(self):
        email = self.cleaned_data.get('email')
        if Attendee.objects.filter(email=email).exists():
            raise forms.ValidationError("Correo electrónico ya en uso. Por favor, utilice otro.")
        return email

class ReviewForm(forms.ModelForm):
    satisfaction = forms.ChoiceField(
        choices=[
            ('Muy satisfecho', 'Muy satisfecho'),
            ('Satisfecho', 'Satisfecho'),
            ('No satisfecho', 'No satisfecho')
        ],
        widget=forms.RadioSelect,
        label="¿Está satisfecho con la información que recibió?",
        required=True,
        error_messages={'required': 'Por favor, selecciona una opción de satisfacción.'}
    )

    usefulness = forms.ChoiceField(
        choices=[
            ('Mucha utilidad', 'Mucha utilidad'),
            ('De utilidad', 'De utilidad'),
            ('No es pertinente a la labor que realizo', 'No es pertinente a la labor que realizo')
        ],
        widget=forms.RadioSelect,
        label="¿La información compartida hoy es de utilidad para la labor que realiza?",
        required=True,
        error_messages={'required': 'Por favor, selecciona una opción de utilidad.'}
    )

    CATEGORY_CHOICES = [
        ('', 'Seleccione una opción'),  # Placeholder option with empty value
        ('Panel: Diversidad Funcional: Retos y Adaptaciones en la Adopción', 'Panel: Diversidad Funcional: Retos y Adaptaciones en la Adopción'),
        ('Impacto Legal y Social de la Adopción en el Bienestar Familiar', 'Impacto Legal y Social de la Adopción en el Bienestar Familiar'),
        ('La Musicoterapia: alcance e impacto en metas clínicas desde el arte de la música', 'La Musicoterapia: alcance e impacto en metas clínicas desde el arte de la música'),
        ('Crear una Vida en Balance: Medicina Integrativa', 'Crear una Vida en Balance: Medicina Integrativa')
    ]

    category = forms.ChoiceField(
        choices=CATEGORY_CHOICES,
        label="Seleccione una opción"
    )
    class Meta:
        model = Review
        fields = ['satisfaction', 'usefulness', 'comments', 'category']
        labels = {
            'satisfaction': "¿Está satisfecho con la información que recibió?",
            'usefulness': "¿La información compartida hoy es de utilidad para la labor que realiza?",
            'comments': 'Comentarios'
        }
        widgets = {
            'comments': forms.Textarea(attrs={'class': 'custom-textarea'}),
        }
        