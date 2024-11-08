# Generated by Django 4.2.16 on 2024-10-31 06:35

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('registry_app', '0002_attendee_date_of_birth'),
    ]

    operations = [
        migrations.CreateModel(
            name='Table',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('table_number', models.PositiveIntegerField(unique=True)),
            ],
        ),
        migrations.AddField(
            model_name='attendee',
            name='arrived',
            field=models.BooleanField(default=False),
        ),
        migrations.AddField(
            model_name='attendee',
            name='seat_number',
            field=models.PositiveIntegerField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='attendee',
            name='table',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='registry_app.table'),
        ),
    ]
