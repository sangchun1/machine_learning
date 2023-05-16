from django.contrib import admin
from django.urls import path
from shop import views

urlpatterns = [
    path('admin', admin.site.urls),
    path('', views.home),
    path('list', views.list),
    path('insert', views.insert),
    path('detail/<int:product_code>', views.detail),
    path('update', views.update),
    path('delete', views.delete),
]
