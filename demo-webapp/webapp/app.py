import os

from flask import Flask
from flask import request

app = Flask(__name__)

@app.route('/')
def hello():
    template = \
"""
Hello world!<br/><br/>
- I'm container id %s<br/>
- My database is at %s<br/>
<br/>
== HTTP Request Headers ==<br/>
%s
"""
    cid = os.environ.get('HOSTNAME','localhost')
    dsn = os.path.expandvars(os.environ.get('DATABASE',''))
    headers = "<br/>\n".join(['%s: %s' % (key, value) for key, value in request.headers.items()])
    return template % (cid, dsn, headers)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
