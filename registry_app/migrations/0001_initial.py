# Generated by Django 4.2.16 on 2024-11-20 23:15

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Attendee',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(db_index=True, max_length=100)),
                ('last_name', models.CharField(db_index=True, max_length=100)),
                ('email', models.EmailField(max_length=254, unique=True)),
                ('date_of_birth', models.DateField(blank=True, null=True)),
                ('phone_number', models.CharField(max_length=15)),
                ('pre_registered', models.BooleanField(default=False)),
                ('registered_at_event', models.BooleanField(default=False)),
                ('registration_date', models.DateTimeField(auto_now_add=True)),
                ('seat_number', models.PositiveIntegerField(blank=True, null=True)),
                ('arrived', models.BooleanField(default=False)),
                ('table', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='registry_app.table')),
            ],
        ),
        migrations.CreateModel(
            name='FileDownload',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('file', models.FileField(default='files/placeholder.txt', upload_to='files/')),
                ('download_count', models.PositiveIntegerField(default=0)),
                ('display_name', models.TextField(blank=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Review',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('rating', models.IntegerField(choices=[(1, 1), (2, 2), (3, 3), (4, 4), (5, 5)])),
                ('comments', models.TextField(blank=True, null=True)),
                ('satisfaction', models.CharField(max_length=50)),
                ('usefulness', models.CharField(max_length=50)),
                ('review_date', models.DateTimeField(auto_now_add=True)),
                ('category', models.CharField(max_length=1000)),
                ('attendee', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='registry_app.attendee')),
            ],
        ),
        migrations.CreateModel(
            name='Table',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('table_number', models.PositiveIntegerField(unique=True)),
                ('max_seats', models.PositiveIntegerField(default=5)),
            ],
        ),
    ]
