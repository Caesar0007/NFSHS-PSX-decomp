#!/bin/bash
cd /c/Temp/nfs4-decomp
while read -r f n; do
  [ -z "$n" ] && continue
  python tools/verify_asm.py "$f" "$n" 2>&1 | head -1
done < "$1"
