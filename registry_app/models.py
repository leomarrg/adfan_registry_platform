from django.db import models

# Create your models here.
# registry_app/models.py

class Table(models.Model):
    table_number = models.PositiveIntegerField(unique=True)
    max_seats = models.PositiveIntegerField(default=5)  # Add max_seats field with a default value

    def __str__(self):
        return f"Table {self.table_number}"
    
    def current_attendees_count(self):
        return self.attendee_set.filter(arrived=True).count()

    def has_available_seat(self):
        return self.current_attendees_count() < self.max_seats

class Attendee(models.Model):
    name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    email = models.EmailField(unique=True)
    date_of_birth = models.DateField(null=True, blank=True)
    phone_number = models.CharField(max_length=15)
    pre_registered = models.BooleanField(default=False)
    registered_at_event = models.BooleanField(default=False)
    registration_date = models.DateTimeField(auto_now_add=True)
    table = models.ForeignKey(Table, on_delete=models.SET_NULL, null=True, blank=True)
    seat_number = models.PositiveIntegerField(null=True, blank=True)
    arrived = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.name} {self.last_name}"
    
    def save(self, *args, **kwargs):
        if self.arrived and not self.table:
            self.assign_table_and_seat()
        super().save(*args, **kwargs)

    def assign_table_and_seat(self):
        # Get all tables sorted by the number of attendees assigned
        tables = Table.objects.all()
        tables = sorted(tables, key=lambda t: t.current_attendees_count())

        # Find the first available table with fewer attendees than max seats
        for table in tables:
            if table.has_available_seat():
                self.table = table
                self.seat_number = table.current_attendees_count() + 1
                break

class Review(models.Model):
    comments = models.TextField()
    satisfaction = models.CharField(max_length=50)
    usefulness = models.CharField(max_length=50)
    review_date = models.DateTimeField(auto_now_add=True)


    def __str__(self):
        return f"{self.attendee.name} - {self.rating} Stars"
