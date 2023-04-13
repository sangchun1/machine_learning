# Generated by Django 4.2 on 2023-04-13 00:38

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name="Emp",
            fields=[
                ("empno", models.IntegerField(primary_key=True, serialize=False)),
                ("ename", models.CharField(max_length=50)),
                ("job", models.CharField(max_length=50)),
                ("hiredate", models.DateTimeField(default=datetime.datetime.now)),
                ("sal", models.IntegerField(default=0)),
            ],
        ),
    ]
