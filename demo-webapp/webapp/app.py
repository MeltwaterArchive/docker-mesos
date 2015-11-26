import os, signal

from flask import Flask
from flask import request

app = Flask(__name__)
healty = True

# Start failing the health check when receiving SIGTERM
def sigterm_handler(_signo, _stack_frame):
    global healty
    print "Caught SIGTERM, starting to fail the health check"
    healty = False
signal.signal(signal.SIGTERM, sigterm_handler)

@app.route('/_status')
def status():
	if healty:
		return ''
	return '', 503

@app.route('/')
def hello():
    template = \
"""
Hello world!<br/><br/>
- I'm container id %s<br/>
- My database is at %s (username: %s, password: %s)<br/>
<br/>
== HTTP Request Headers ==<br/>
%s
"""
    cid = os.environ.get('HOSTNAME','localhost')
    dsn = os.path.expandvars(os.environ.get('DATABASE',''))
    username = os.environ.get('DATABASE_USERNAME','')
    password = os.environ.get('DATABASE_PASSWORD','')
    headers = "<br/>\n".join(['%s: %s' % (key, value) for key, value in request.headers.items()])
    return template % (cid, dsn, username, password, headers)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT0', '8080')))
