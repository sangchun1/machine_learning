from django.shortcuts import render
from urllib import parse
from datetime import datetime

def set_cookie(request):
    name = parse.quote('김철수')
    response = render(request, 'ch03/set_cookie.html', {'name': parse.unquote(name)})
    response.set_cookie('id', 'kim')
    response.set_cookie('pwd', '1234')
    response.set_cookie('name', name)
    return response

def del_cookie(request):
    response = render(request, 'ch03/del_cookie.html')
    response.delete_cookie('id')
    response.delete_cookie('pwd')
    response.delete_cookie('name')
    return response

def change_cookie(request):
    name = 'Kim Chul'
    response = render(request, 'ch03/change_cookie.html')
    response.set_cookie('id', 'kim')
    response.set_cookie('pwd', '2222')
    response.set_cookie('name', name)
    return response

def counter(request):
    if request.COOKIES['last_visit']:
        last_visit = request.COOKIES['last_visit']
        visits = request.COOKIES['visits']
        int_visit = int(visits) + 1
        t1 = datetime.strptime(str(datetime.now()), '%Y-%m-%d %H:%M:%S.%f')
        t2 = datetime.strptime(last_visit, '%Y-%m-%d %H:%M:%S.%f')
    result = []
    for i in range(0, len(str(visits))):
        result.append(f'{visits[i]}.gif')
    context = {"result": result}
    response = render(request, 'ch03/counter.html', context)
    if request.COOKIES['last_visit']:
        if (t1 - t2).seconds > 3:
            response.set_cookie('visits', str(int_visit))
            response.set_cookie('last_visit', str(datetime.now()))
    else:
        response.set_cookie('last_visit', str(datetime.now()))
        response.set_cookie('visits', 1)
    return response