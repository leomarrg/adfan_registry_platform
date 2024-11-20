from django.contrib import admin
from django.db.models import Count, F
from django.utils.html import format_html
from django.http import HttpResponseRedirect
from django.urls import path
from .models import Attendee, Table, Review
from django.http import JsonResponse
from django.http import HttpResponse
from django.http import HttpResponse
import csv
from .models import FileDownload



admin.site.site_header = "Panel de Administración de Congreso Adopción"
admin.site.site_title = "Administración de Congreso Adopción"
admin.site.index_title = "Bienvenido al Panel de Administración"

def export_to_text(modeladmin, request, queryset):
    # Set up the HTTP response with a plain text content type
    response = HttpResponse(content_type='text/plain')
    response['Content-Disposition'] = 'attachment; filename="attendees_list.txt"'

    # Loop through each attendee in the queryset and write their info to the response
    for attendee in queryset:
        response.write(f"{attendee.name} {attendee.last_name}\n")  # Customize the fields as needed

    return response

# Add the custom action to your Admin class
export_to_text.short_description = "Export selected attendees to text file"

class AttendeeAdmin(admin.ModelAdmin):
    list_display = ('name', 'last_name', 'email', 'arrived', 'mark_as_arrived_button')
    list_select_related = ('table',)
    list_filter = ('pre_registered', 'registered_at_event', 'arrived')
    search_fields = ['name', 'last_name']
    actions = [export_to_text]
    list_per_page = 20  # Adjust this number to what suits your needs


    # class Media:
    #     js = ('js/dynamic_search.js',)  # Add the JavaScript for dynamic search


    # Add the autocomplete URL
    def get_urls(self):
        urls = super().get_urls()
        custom_urls = [
            path('<int:attendee_id>/mark_arrived/', self.admin_site.admin_view(self.mark_as_arrived), name='mark_as_arrived'),
            path('<int:attendee_id>/unmark_arrived/', self.admin_site.admin_view(self.unmark_as_arrived), name='unmark_as_arrived'),
        ]
        return custom_urls + urls

    # def autocomplete_view(self, request):
    #     if 'term' in request.GET:
    #         term = request.GET.get('term')
    #         # Use 'istartswith' for prefix-based matching
    #         qs = Attendee.objects.filter(name__istartswith=term) | Attendee.objects.filter(last_name__istartswith=term)
    #         attendees = list(qs.values('id', 'name'))
    #         return JsonResponse(attendees, safe=False)

    #     return JsonResponse([], safe=False)

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

    actions = ['export_reviews_to_txt']

    def export_reviews_to_txt(self, request, queryset):
        # Create the HttpResponse object with plain text content
        response = HttpResponse(content_type='text/plain')
        response['Content-Disposition'] = 'attachment; filename="reviews.txt"'

        # Write the selected reviews to the response
        for review in queryset:
            response.write(
                f"Satisfaction: {review.satisfaction}\n"
                f"Usefulness: {review.usefulness}\n"
                f"Category: {review.category}\n"
                f"Comments: {review.comments}\n"
                f"Review Date: {review.review_date}\n\n"
            )

        return response

    export_reviews_to_txt.short_description = "Export selected reviews to text file"
    # Restringir permisos de edición
    def has_change_permission(self, request, obj=None):
        return request.user.has_perm('registry_app.change_review')

@admin.register(FileDownload)
class FileDownloadAdmin(admin.ModelAdmin):
    list_display = ('file_name', 'display_name', 'download_count')  # Add display_name here
    list_editable = ('display_name',)  # Allow editing directly in the list view
    search_fields = ('file_name', 'display_name')  # Enable search functionality
    list_filter = ('download_count',)
    
admin.site.register(Attendee, AttendeeAdmin)
admin.site.register(Table, TableAdmin)
admin.site.register(Review, ReviewAdmin)

