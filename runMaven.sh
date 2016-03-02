#!/bin/sh
# mvn wrapper that first (re-)creates a VNC session

# Cleanup X11 sockets from previous run
rm -rf /tmp/.X11-unix /tmp/.X1-lock

# Fork the X11 session; startup script in $HOME/.vnc/xstartup
vncserver :1 -geometry 1280x800 -depth 24 > $HOME/.vnc/vncserver.log 2>&1

# Handoff to the real Maven
echo "# mvn $*"
DISPLAY=:1 /usr/bin/mvn "$@"
