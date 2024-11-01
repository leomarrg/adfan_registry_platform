from django.core.management.base import BaseCommand
from registry_app.models import Table

class Command(BaseCommand):
    help = 'Create default tables with a fixed seating capacity'

    def handle(self, *args, **kwargs):
        default_number_of_tables = 5
        max_seats_per_table = 5

        # Create the default number of tables if they don't already exist
        for i in range(1, default_number_of_tables + 1):
            if not Table.objects.filter(table_number=i).exists():
                Table.objects.create(table_number=i, max_seats=max_seats_per_table)
                self.stdout.write(self.style.SUCCESS(f'Table {i} with {max_seats_per_table} seats created.'))
            else:
                self.stdout.write(self.style.WARNING(f'Table {i} already exists.'))
