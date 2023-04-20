"""
URL configuration for config project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from mytest.views import ch01, ch02

urlpatterns = [
    path("admin/", admin.site.urls),
    path('', ch01.home),
    path('hello/', ch01.hello),
    path('now/', ch01.now),
    path('array/', ch01.array),
    path('age/', ch02.age),
    path('mysum/', ch02.mysum),
    path('salary/', ch02.salary),
    path('radio/', ch02.radio),
    path('checkbox/', ch02.checkbox),
    path('button/', ch02.button),
    path('textarea/', ch02.textarea),
    path('select/', ch02.select),
    path('point/', ch02.point),
    path('gugu/', ch02.gugu),
    path('select2/', ch02.select2),
]