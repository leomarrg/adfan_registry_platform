from django.contrib import admin
from .models import Attendee, Review, Table

admin.site.site_header = "Panel de Administración de Congreso Adopción"
admin.site.site_title = "Administración de Congreso Adopción"
admin.site.index_title = "Bienvenido al Panel de Administración"

# Register your models here.

class AttendeeAdmin(admin.ModelAdmin):
    list_display = ('id', 'name', 'last_name', 'email', 'table', 'seat_number', 'arrived', 'date_of_birth', 'registration_type', 'registration_date')
    list_filter = ('pre_registered', 'registered_at_event', 'arrived', 'table')  # Add filters for categories
    list_editable = ('table', 'seat_number', 'arrived')

    def registration_type(self, obj):
        if obj.pre_registered:
            return "Pre-Registered"
        elif obj.registered_at_event:
            return "Same-Day Registered"
        return "Unknown"

    registration_type.short_description = "Registration Type"

    # Restringir permisos de edición
    def has_change_permission(self, request, obj=None):
        return request.user.has_perm('registry_app.view_attendee')  # Cambia 'yourapp' por el nombre de tu app

class TableAdmin(admin.ModelAdmin):
    list_display = ('table_number', 'max_seats')  # Display table number and max seats
    list_editable = ('max_seats',)  # Allow editing max seats directly in the admin list view
    ordering = ['table_number']

class ReviewAdmin(admin.ModelAdmin):
    list_display = ('satisfaction', 'usefulness', 'category', 'comments', 'review_date')
    fields = ('satisfaction', 'usefulness', 'category', 'comments', 'review_date')  # Include 'category' in the detail view

    # Restringir permisos de edición
    def has_change_permission(self, request, obj=None):
        return request.user.has_perm('registry_app.change_review')
    
admin.site.register(Attendee, AttendeeAdmin)
admin.site.register(Table, TableAdmin)
admin.site.register(Review, ReviewAdmin)

