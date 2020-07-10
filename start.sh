#!/bin/bash

trap CTRL_C INT

# trap ctrl-c and call ctrl_c()
function CTRL_C()
{
  echo "** Trapped CTRL-C"
  echo "PYTHON $PID_PYTHON // BROWSER $PID_BROWSER"
  kill $PID_BROWSER
  kill $PID_PYTHON
}

if [ -n "$WORDLESS_ROOT" ]; then
  echo "project root is $WORDLESS_ROOT";
else
  echo "project root is not set";
  WORDLESS_ROOT='~/almat_wordless';
  echo "default to $WORDLESS_ROOT"
fi

PYTHON_VERSION=`python -c 'import sys; version=sys.version_info[:3]; print("{0}".format(*version))'`
if [ $PYTHON_VERSION -eq 3 ]; then
  # NOTE: for python version 3.X use `python -m http.server`
  PYTHON_CMD='python -m http.server';
else
  PYTHON_CMD='python -m SimpleHTTPServer'
fi

# Next open chromium and navigate to `localhost:8000`
BROWSER_CMD="chromium-browser 'http://localhost:8000'"
echo "HTTP Server '$PYTHON_CMD'"
echo "Browser '$BROWSER_CMD'"


# Start python server in almat_wordless directory
cd $WORDLESS_ROOT

eval $PYTHON_CMD &
PID_PYTHON=$!
eval $BROWSER_CMD &
PID_BROWSER=$!
# Return the python server to the foreground
wait
