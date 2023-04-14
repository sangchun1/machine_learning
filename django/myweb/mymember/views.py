from django.shortcuts import render, redirect
from django.contrib.auth.models import User
from django.contrib.auth import authenticate
from django.contrib.auth import login as dlogin, logout as dlogout
#from mymember.models import UserForm, LoginForm
from mymember.models import Member

def home(request):
    if 'userid' not in request.session.keys():
        return render(request, 'mymember/login.html')
    else:
        return render(request, 'mymember/main.html')

def login(request):
    if request.method == 'POST':
        userid = request.POST['userid']
        passwd = request.POST['passwd']
        row = Member.objects.filter(userid=userid, passwd=passwd)[0]
        if row is not None:
            request.session['userid'] = userid
            request.session['name'] = row.name
            return render(request, 'mymember/main.html')
        else:
            return render(request, 'mymember/login.html', {'msg': '아이디 또는 비밀번호가 일치하지 않습니다.'})
    else:
        return render(request, 'mymember/login.html')

def join(request):
    if request.method == 'POST':
        userid = request.POST['userid']
        passwd = request.POST['passwd']
        name = request.POST['name']
        address = request.POST['address']
        tel = request.POST['tel']
        Member(userid=userid, passwd=passwd, name=name, address=address, tel=tel).save()
        request.session['userid'] = userid
        request.session['name'] = name
        return render(request, 'mymember/main.html')
    else:
        return render(request, 'mymember/join.html')

def logout(request):
    request.session.clear()
    return redirect('/mymember')