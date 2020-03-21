#!/usr/bin/python3

'''

a modified version of cvim_server.py orginially
created by 1995eaton
https://github.com/1995eaton/chromium-vim/blob/master/cvim_server.py

USAGE: ./cvim_server.py
If you want to use native Vim to edit text boxes
you must be running this script. To begin editing,
first map the editWithVim (e.g. "imap <C-o> editWithVim") mapping.
By default, this script will spawn a gvim ("gvim -f"), but this action
can be changed by setting the VIM_COMMAND variable below

-- additional notes from budRich
OBS! VIM_COMMAND is renamed VB4C_VIM_COMMAND, which
defaults to the environment variable with the same name.
Or "gvim -f" if not set.

This version will instead execute a command if the
first word posted in a message to the server matches
EXEC_WORD and exectute the rest of the message as a command.

below is an example from my cvimrc (VB4C_EXEC_WORD = brwscon)
that will execute 'notify-send' with a URL as the only
argument. (S : current page, s : from hint)
...

let vimport = 8065

externalCommandHint(link) -> {{
  var url = link.href || link.value || link.getAttribute('placeholder');
  PORT('editWithVim', {
    text: `brwscon notify-send ${url}`
  });
}}

externalCommandPage -> {{
  var url = document.URL;
  PORT('editWithVim', {
    text: `brwscon notify-send ${url}`
  });
}}

map S :call externalCommandPage<CR>
map s createScriptHint(externalCommandHint)

...

for the commands in the example to work, this script
must be running and executed something like this:

(backslash escapes new line)

VB4C_PORT=8065                                        \
VB4C_VIM_COMMAND='sublaunch --profile subltmp --wait' \
VB4C_EXEC_WORD=brwscon                                \
./vb4c_server.py

'''

import os
import sys
import shlex
from json import loads
import subprocess
from tempfile import mkstemp
from http.server import HTTPServer, BaseHTTPRequestHandler

VB4C_PORT = int(os.getenv("VB4C_PORT", 8001))
VB4C_VIM_COMMAND = os.getenv("VB4C_VIM_COMMAND", 'gvim -f')
VB4C_EXEC_WORD = os.getenv("VB4C_EXEC_WORD", 'vb4cconnect')


def edit_file(content):
    fd, fn = mkstemp(suffix='.txt', prefix='cvim-', text=True)
    os.write(fd, content.encode('utf8'))
    os.close(fd)
    subprocess.Popen(shlex.split(VB4C_VIM_COMMAND) + [fn]).wait()
    text = None
    with open(fn, 'r') as f:
        text = f.read()
    os.unlink(fn)
    return text


class CvimServer(BaseHTTPRequestHandler):

    def do_POST(self):
        length = int(self.headers['Content-Length'])
        content_str = self.rfile.read(length).decode('utf8')
        content = loads(content_str)
        self.send_response(200)
        self.send_header('Content-Type', 'text/plain')
        self.end_headers()

        brwschk = content['data'].split()
        edit = ''

        # Block XMLHttpRequests originating from
        # non-Chrome extensions
        if not self.headers.get('Origin', '').startswith('chrome-extension'):
            pass

        elif brwschk[0] == VB4C_EXEC_WORD:
            subprocess.call(brwschk[1:])

        else:
            edit = edit_file(content['data'])

        self.wfile.write(edit.encode('utf8'))


def init_server(server_class=HTTPServer, handler_class=BaseHTTPRequestHandler):
    server_address = ('127.0.0.1', VB4C_PORT)
    httpd = server_class(server_address, CvimServer)
    httpd.serve_forever()


try:
    init_server()
except KeyboardInterrupt:
    pass
