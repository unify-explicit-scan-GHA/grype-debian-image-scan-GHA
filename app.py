from flask import Flask, request
import os

app = Flask(__name__)

@app.route('/')
def index():
    return '''
        <form action="/ping" method="post">
            <input name="ip" placeholder="Enter IP address">
            <input type="submit">
        </form>
    '''

@app.route('/ping', methods=['POST'])
def ping():
    ip = request.form.get('ip')
    # WARNING: This is insecure (command injection risk)!
    result = os.popen(f"ping -c 2 {ip}").read()
    return f"<pre>{result}</pre>"

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=5000)
