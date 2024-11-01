from django.contrib import admin
from .models import Attendee, Review, Table

# Register your models here.

class AttendeeAdmin(admin.ModelAdmin):
    list_display = ('name', 'last_name', 'email', 'table', 'seat_number', 'arrived', 'date_of_birth', 'registration_type', 'registration_date')
    list_filter = ('pre_registered', 'registered_at_event', 'arrived', 'table')  # Add filters for categories
    list_editable = ('table', 'seat_number', 'arrived')

    def registration_type(self, obj):
        if obj.pre_registered:
            return "Pre-Registered"
        elif obj.registered_at_event:
            return "Same-Day Registered"
        return "Unknown"

    registration_type.short_description = "Registration Type"

class TableAdmin(admin.ModelAdmin):
    list_display = ('table_number', 'max_seats')  # Display table number and max seats
    list_editable = ('max_seats',)  # Allow editing max seats directly in the admin list view
    ordering = ['table_number']

admin.site.register(Attendee, AttendeeAdmin)
admin.site.register(Table, TableAdmin)
admin.site.register(Review)
