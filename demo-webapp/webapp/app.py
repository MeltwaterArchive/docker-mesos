import os, signal

from flask import Response, Flask
from flask import request

app = Flask(__name__)
shutdown = False

def shutdown_server():
    func = request.environ.get('werkzeug.server.shutdown')
    if func is not None:
        print "Gracefully stopping server"
        func()
    else:
        print 'Failed to stop gracefully: Not running with the Werkzeug Server'

# Start failing the health check when receiving SIGTERM
def sigterm_handler(_signo, _stack_frame):
    global shutdown
    print "Caught SIGTERM, setting flag to gracefully stop server"
    shutdown = True
signal.signal(signal.SIGTERM, sigterm_handler)

@app.route('/_status')
def status():
    if shutdown:
        #shutdown_server()
        return 503, ''
    return ''

@app.route('/')
def hello():
    template = \
"""
Hello world!<br/><br/>
- I'm container id %s<br/>
- My mesos task id is %s<br/>
- My database is at %s (username: %s, password: %s)<br/>
<br/>
== HTTP Request Headers ==<br/>
%s
"""
    cid = os.environ.get('HOSTNAME','localhost')
    mid = os.environ.get('MESOS_TASK_ID','localhost')
    dsn = os.path.expandvars(os.environ.get('DATABASE',''))
    username = os.environ.get('DATABASE_USERNAME','')
    password = os.environ.get('DATABASE_PASSWORD','')
    headers = "<br/>\n".join(['%s: %s' % (key, value) for key, value in request.headers.items()])
    body = template % (cid, mid, dsn, username, password, headers)

    response = Response(body)
    #response.headers['Connection'] = 'close'
    return response

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT0', '8080')), threaded=True)
