"""text_hashes.py OUT.json -- sha1 + size of the .text contents of every build/recon C++ object (section bytes only, so
symbol-linkage differences do not count)."""
import glob
import hashlib
import json
import subprocess
import sys
import tempfile
import os
from pathlib import Path

R = Path(__file__).resolve().parents[2].as_posix() + '/'
OC = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objcopy.exe'
out = {}
tmp = os.path.join(tempfile.gettempdir(), 'th_text.bin')
for o in sorted(glob.glob(R + 'build/recon/**/*.cpp.o', recursive=True)):
    o = o.replace(chr(92), '/')
    if os.path.exists(tmp):
        os.remove(tmp)
    subprocess.run([OC, '-O', 'binary', '-j', '.text', o, tmp], capture_output=True)
    b = open(tmp, 'rb').read() if os.path.exists(tmp) else b''
    out[o.replace(R + 'build/', '')] = [hashlib.sha1(b).hexdigest(), len(b)]
json.dump(out, open(sys.argv[1], 'w'), indent=0)
print(len(out), 'objects')
