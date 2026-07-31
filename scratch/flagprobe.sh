#!/bin/bash
# usage: flagprobe.sh <tu-path> <key> <fnlist>
set -e
TU="$1"; KEY="$2"; FNS="$3"
cd /c/Temp/nfs4-wt39-a5
python - "$TU" "$KEY" <<'PY'
import io,sys,re
tu,key=sys.argv[1],sys.argv[2]
p='tools/build.py'
s=io.open(p,encoding='utf-8').read()
needle='"%s":' % tu
i=s.index(needle)
j=s.index('{',i); k=s.index('}',j)
body=s[j+1:k]
if key not in body:
    body = body.rstrip() + (', ' if body.strip() else '') + '"%s": True' % key
s=s[:j+1]+body+s[k:]
io.open(p,'w',encoding='utf-8',newline='').write(s)
print("patched",tu,key)
PY
python tools/verify_asm.py "$TU" "$FNS" 2>&1 | grep -E 'PASS|FAIL'
git checkout tools/build.py
