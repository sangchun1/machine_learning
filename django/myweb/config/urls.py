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
from django.urls import path, include
from config import views
from django.conf import settings
from django.urls import re_path

urlpatterns = [
    # 관리자용 사이트
    path('admin/', admin.site.urls),
    path('', views.home),
    path('address/', include('address.urls')),
    path('memo/', include('memo.urls')),
    path('book/', include('book.urls')),
    path('transaction/', include('transaction.urls')),
    path('procedure/', include('procedure.urls')),
    path('mymember/', include('mymember.urls')),
    path('ajax/', include('ajax.urls')),
    path('survey/', include('survey.urls')),
]

if settings.DEBUG:
    import debug_toolbar
    urlpatterns += [
        re_path(r'^__debug__/', include(debug_toolbar.urls)),
    ]