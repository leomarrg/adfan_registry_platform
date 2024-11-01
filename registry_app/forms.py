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

class ReviewForm(forms.ModelForm):
    class Meta:
        model = Review
        fields = ['rating', 'comments']
        widgets = {
            'rating': forms.RadioSelect(choices=[(i, str(i)) for i in range(1, 6)]),
        }
