from django.shortcuts import HttpResponse
from shop.models import Product
from shop import ProductSerializer as ps
import simplejson

def list(request):
    items = Product.objects.order_by("-product_name")
    serializer = ps.ProductSerializer(items, many=True)
    return HttpResponse(simplejson.dumps(serializer.data))
