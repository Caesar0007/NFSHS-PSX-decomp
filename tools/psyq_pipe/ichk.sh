#!/bin/bash
# usage: ichk.sh <tu.cpp ...>   (run in /c/Temp/n4g)
# Recompile each TU on the debug lane and compare its preprocessed source with the baseline in /c/Temp/ibase
# (snapshot of a gate-passed state). Identical token stream => identical bytes, records and record order.
cd /c/Temp/n4g
norm() { grep -v '^#' "$1" | tr -d '\r' | sed 's/[ \t]*$//' | grep -v '^$'; }
for f in "$@"; do
  r=$(python tools/psyq_pipe/gdebug_compile.py $f 2>&1 | tail -1 | cut -c1-80)
  if [ -f build/gdebug/$f.i ] && [ -f /c/Temp/ibase/$f.i ]; then
    d=$(diff <(norm /c/Temp/ibase/$f.i) <(norm build/gdebug/$f.i) | grep -c '^[<>]')
    [ "$d" = "0" ] && echo "same  $f" || { echo "DIFF $d  $f  [$r]"; diff <(norm /c/Temp/ibase/$f.i) <(norm build/gdebug/$f.i) | grep '^[<>]' | head -6 | cut -c1-150; }
  else echo "NO-I  $f  [$r]"; fi
done
echo ICHK-DONE
