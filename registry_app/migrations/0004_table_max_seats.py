# Generated by Django 4.2.16 on 2024-10-31 07:34

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('registry_app', '0003_table_attendee_arrived_attendee_seat_number_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='table',
            name='max_seats',
            field=models.PositiveIntegerField(default=5),
        ),
    ]
