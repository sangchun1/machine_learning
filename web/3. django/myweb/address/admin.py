from django.contrib import admin
from address.models import Address

class AddressAdmin(admin.ModelAdmin):
    # 화면에 출력할 필드 목록을 튜플로 지정
    list_display = ('name', 'tel', 'email', 'address')

admin.site.register(Address, AddressAdmin)