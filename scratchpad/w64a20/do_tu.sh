#!/bin/sh
# w64-a20 mission 1: convert + banner + accept-or-revert, one TU.
# usage: sh do_tu.sh <tu-rel> [--drop-elf]
set -e
cd /c/Temp/nfs4-decomp
TU="$1"; shift
python scratchpad/w64a20/aspsxify.py "$TU" --write "$@" | sed 's/^/  /'
python scratchpad/w64a20/aspsxify.py "$TU" --banner-only --write >/dev/null
if python scratchpad/w64a20/verify_tu.py "$TU"; then
  exit 0
else
  echo "  -> REVERTING $TU"
  cp -f "$TU.w64a20.bak" "$TU"
  exit 1
fi
