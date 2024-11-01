# registry_app/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('register/', views.register_attendee, name='register_attendee'),
    path('front_desk_register/', views.front_desk_register, name='front_desk_register'),
    path('review/<int:attendee_id>/', views.leave_review, name='leave_review'),
    path('test/', views.test_template, name='test_template')
]
