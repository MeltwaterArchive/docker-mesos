import os

from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    template = \
"""
Hello world!<br/><br/>
- I'm container id %s<br/>
- My database is at %s
"""
    cid = os.environ.get('HOSTNAME','localhost')
    dsn = os.path.expandvars(os.environ.get('DATABASE',''))
    return template % (cid, dsn)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
