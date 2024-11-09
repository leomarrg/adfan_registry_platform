"""
URL configuration for ADFAN_registry project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from registry_app import views as registry_views  # Import the views from your registry_app

urlpatterns = [
    path('admin/', admin.site.urls),
    path('registry/', include('registry_app.urls')),  # Existing registry URLs
    path('', registry_views.register_attendee, name='home'),  # Root URL now points to the register_attendee view
    path('registry/review/<int:pk>/', registry_views.leave_review, name='leave_review')
]
