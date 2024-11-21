# registry_app/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('register/', views.register_attendee, name='register_attendee'),
    path('front_desk_register/', views.front_desk_register, name='front_desk_register'),
    path('review/', views.leave_review, name='leave_review'),
    path('test/', views.test_template, name='test_template'),
    path('download/<int:file_id>/', views.download_file, name='download_file'),
    path('files/', views.file_list, name='file_list'),
]


