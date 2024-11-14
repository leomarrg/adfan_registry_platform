from django.contrib import admin
from django.db.models import Count, F
from django.utils.html import format_html
from django.http import HttpResponseRedirect
from django.urls import path
from .models import Attendee, Table, Review
from django.http import JsonResponse


admin.site.site_header = "Panel de Administración de Congreso Adopción"
admin.site.site_title = "Administración de Congreso Adopción"
admin.site.index_title = "Bienvenido al Panel de Administración"

class AttendeeAdmin(admin.ModelAdmin):
    list_display = (
        'id', 'name', 'last_name', 'email', 'table', 'seat_number', 
        'arrived', 'date_of_birth', 'registration_type', 'mark_as_arrived_button'
    )
    list_filter = ('pre_registered', 'registered_at_event', 'arrived', 'table')
    list_editable = ['table']
    search_fields = ['name', 'last_name']

    class Media:
        js = ('js/dynamic_search.js',)  # Add the JavaScript for dynamic search


    # Add the autocomplete URL
    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path('attendee_autocomplete/', self.admin_site.admin_view(self.autocomplete_view), name='attendee_autocomplete'),
            path('<int:attendee_id>/mark_arrived/', self.admin_site.admin_view(self.mark_as_arrived), name='mark_as_arrived'),
            path('<int:attendee_id>/unmark_arrived/', self.admin_site.admin_view(self.unmark_as_arrived), name='unmark_as_arrived'),
        ]
        return custom_urls + urls

    # Custom view to handle autocomplete
    def autocomplete_view(self, request):
        if 'term' in request.GET:
            qs = Attendee.objects.filter(name__icontains=request.GET.get('term')) | Attendee.objects.filter(last_name__icontains=request.GET.get('term'))
            attendees = list(qs.values('id', 'name', 'last_name'))
            return JsonResponse(attendees, safe=False)

        return JsonResponse([], safe=False)

    def registration_type(self, obj):
        if obj.pre_registered:
            return "Pre-Registered"
        elif obj.registered_at_event:
            return "Same-Day Registered"
        return "Unknown"

    registration_type.short_description = "Registration Type"

    # Custom buttons to mark/unmark attendees as arrived
    def mark_as_arrived_button(self, obj):
        if not obj.arrived:
            return format_html('<a class="button" href="{}">Mark as Arrived</a>', f'{obj.id}/mark_arrived/')
        else:
            return format_html('<a class="button" href="{}">Unmark as Arrived</a>', f'{obj.id}/unmark_arrived/')

    mark_as_arrived_button.short_description = "Mark/Unmark as Arrived"
    mark_as_arrived_button.allow_tags = True

    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path('<int:attendee_id>/mark_arrived/', self.admin_site.admin_view(self.mark_as_arrived), name='mark_as_arrived'),
            path('<int:attendee_id>/unmark_arrived/', self.admin_site.admin_view(self.unmark_as_arrived), name='unmark_as_arrived'),
        ]
        return custom_urls + urls

    def mark_as_arrived(self, request, attendee_id):
        attendee = Attendee.objects.get(pk=attendee_id)
        if not attendee.arrived:
            attendee.arrived = True
            if attendee.table is None or attendee.seat_number is None:
                attendee.table, attendee.seat_number = self.get_available_seat()
            attendee.save()
            self.message_user(request, "Attendee marked as arrived and seat assigned.")
        return HttpResponseRedirect(request.META.get('HTTP_REFERER', '/admin/'))

    def unmark_as_arrived(self, request, attendee_id):
        attendee = Attendee.objects.get(pk=attendee_id)
        if attendee.arrived:
            attendee.arrived = False
            attendee.save()
            self.message_user(request, "Attendee unmarked as arrived.")
        return HttpResponseRedirect(request.META.get('HTTP_REFERER', '/admin/'))

    def get_available_seat(self):
        # Logic to get the next available seat in a table
        available_table = Table.objects.annotate(
            attendee_count=Count('attendee')
        ).filter(
            attendee_count__lt=F('max_seats')
        ).first()

        if available_table:
            assigned_seats = Attendee.objects.filter(table=available_table).values_list('seat_number', flat=True)
            available_seat = next((seat for seat in range(1, available_table.max_seats + 1) if seat not in assigned_seats), None)
            if available_seat is not None:
                return available_table, available_seat

        return None, None  # If no seats are available
    

class TableAdmin(admin.ModelAdmin):
    list_display = ('table_number', 'max_seats')  # Display table number and max seats
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

