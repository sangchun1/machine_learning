from datetime import datetime
from django.db import models

# 테이블과의 매핑을 위한 클래스
class Memo(models.Model):
    # 자동증가, PK
    idx = models.AutoField(primary_key=True)
    writer = models.CharField(max_length=50, blank=True, null=True)
    memo = models.TextField(blank=True, null=True)
    # 날짜 - 현재 시각으로 자동 입력
    post_date = models.DateTimeField(default=datetime.now, blank=True)