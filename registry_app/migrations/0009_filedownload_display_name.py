# Generated by Django 4.2.16 on 2024-11-20 16:23

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('registry_app', '0008_filedownload_alter_review_category'),
    ]

    operations = [
        migrations.AddField(
            model_name='filedownload',
            name='display_name',
            field=models.TextField(blank=True, null=True),
        ),
    ]
