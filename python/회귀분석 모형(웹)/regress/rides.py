from flask import Flask, render_template, request
import joblib

app = Flask(__name__)

@app.route('/', methods=['GET'])
def main():
    return render_template('rides/input.html')

@app.route('/result', methods=['POST'])
def result():
    model = joblib.load('c:/data/rides/rides_regress.model')
    a = int(request.form['a'])  # 자녀수
    b = int(request.form['b'])  # 거리
    c = int(request.form['c'])  # 놀이기구점수
    d = int(request.form['d'])  # 게임점수
    e = int(request.form['e'])  # 대기시간점수
    f = int(request.form['f'])  # 청결도
    g = int(request.form['g'])  # 주말여부

    if g == 0:
        h = 1   # 주말
    elif g == 1:   
        h = 0   # 평일

    # 2차원 배열로 입력해야 함
    test_set = [[a,b,c,d,e,f,g,h]]
    result = model.predict(test_set)
    return render_template('rides/result.html', point='{:.2f}'.format(result[0]), a=a, b=b, c=c, d=d, e=e, f=f,
                           g=g, h=h)

if __name__ == '__main__':
    # 웹브라우저에서 실행할 때 http://localhost로 하면 느림
    # 서버를 실행시킨 후 http://127.0.0.1:8000 링크를 클릭
    app.run(port=80, threaded=False)