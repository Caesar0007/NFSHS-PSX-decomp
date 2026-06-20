#!/usr/bin/env python3
"""rediff1.py FUNC — recompile aidatarecord.cpp, diff one function vs build/exp.dis (oracle).
Prints the count + listing of differing instructions (reloc-name & branch-offset lenient)."""
import re, sys, subprocess
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent
sys.argv_keep = sys.argv
FUNC = sys.argv[1] if len(sys.argv) > 1 else '__30AIDataRecord_CurveSpeedTable_tPc26AIDataRecord_WhichRecord_t'
SRC = ROOT / 'recon' / 'game' / 'common' / 'aidatarecord.cpp'
OBJDUMP = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'

# compile via build.py's compile_cpp
import importlib.util
spec = importlib.util.spec_from_file_location('bld', ROOT / 'tools' / 'build.py')
bld = importlib.util.module_from_spec(spec); spec.loader.exec_module(bld)
bld.OUT = bld.BUILD
bld.OUT.mkdir(parents=True, exist_ok=True)
obj = bld.compile_cpp(SRC)
dis = subprocess.run([OBJDUMP, '-D', '-r', obj], capture_output=True, text=True).stdout

def grab(text, name):
    out = []; inb = False
    for ln in text.splitlines():
        m = re.match(r'^[0-9a-f]{8} <(.+)>:', ln)
        if m:
            inb = (m.group(1) == name)
            if inb: out.append(ln)
            continue
        if inb:
            if ln.strip() == '' and out and out[-1].strip() == '': break
            out.append(ln)
    return out

def norm(lines):
    r = []
    for ln in lines:
        m = re.match(r'^\s*[0-9a-f]+:\t[0-9a-f ]+\t(.*)', ln)
        if m:
            t = re.sub(r'\s+', ' ', m.group(1).strip())
            # branch/jump-offset lenient: drop trailing hex target+label
            t = re.sub(r'(b\w+z?|b|j|jal)\s+[0-9a-f]+ <[^>]+>', r'\1 <T>', t)
            t = re.sub(r'\b[0-9a-f]{4,8} <[^>]+>', '<T>', t)
            r.append(t)
        elif 'R_MIPS' in ln:
            # reloc-NAME lenient: keep reloc TYPE only
            r.append('[' + ln.split('R_MIPS')[1].split()[0] + ']')
    return r

ours = norm(grab(dis, FUNC))
exp = norm(grab((bld.BUILD / 'exp.dis').read_text(), FUNC))
import difflib
d = [l for l in difflib.unified_diff(ours, exp, 'OURS', 'ORACLE', lineterm='') if l[0] in '+-' and not l.startswith(('+++', '---'))]
print(f"{FUNC}\n  differing lines: {len(d)}  (ours {len(ours)} / oracle {len(exp)} insns+relocs)")
for l in d: print('  ', l)
