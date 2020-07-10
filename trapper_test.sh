#!/bin/bash

# trap ctrl-c and call ctrl_c()
function CTRL_C()
{
  echo "** Trapped CTRL-C"
  echo "THE PID IS $THEPID"
}
trap CTRL_C INT

BROWSER_CMD="chromium-browser 'http://localhost:8000'"
eval $BROWSER_CMD
