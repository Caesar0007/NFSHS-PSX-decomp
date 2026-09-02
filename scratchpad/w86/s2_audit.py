"""S2 audit: per-fn SYM local/param inventory vs the recon C source (read-only).

usage: s2_audit.py <SYMFILE.CPP> <recon/path/file.cpp>
prints, per SYM function of that source file, the SYM param/local list and the
names that do NOT appear anywhere in the recon TU (a cheap first-pass filter).
"""
import sys, re
SYM = r"C:\Temp\nfs4-psx\nfs4-psx-sym.txt"

def blocks():
    lines = open(SYM, encoding='latin-1').read().split('\n')
    i = 0
    while i < len(lines):
        if lines[i].endswith('8c Function start'):
            j = i + 1; blk = [lines[i]]
            while j < len(lines) and lines[j].startswith('    '):
                blk.append(lines[j]); j += 1
            while j < len(lines):
                if '8c Function start' in lines[j]: break
                blk.append(lines[j])
                if '8e Function end' in lines[j]:
                    j += 1; break
                j += 1
            yield blk
            i = j
        else:
            i += 1

want = sys.argv[1].upper()
src = open(sys.argv[2], encoding='latin-1').read() if len(sys.argv) > 2 else ''
srcnc = re.sub(r'/\*.*?\*/', '', src, flags=re.S)
srcnc = re.sub(r'//.*', '', srcnc)

DEF = re.compile(r'^[0-9a-f]+: \$([0-9a-f]+) (9[46]) Def2? class (\w+) type (.*?) (?:size (\d+))? ?(?:dims \d+.*?)?(?:tag (\S*)\s+)?name (\S+)\s*$')
for blk in blocks():
    txt = '\n'.join(blk)
    m = re.search(r'file = (.*)', txt)
    if not m or not m.group(1).strip().upper().endswith(want):
        continue
    fn = re.search(r'name = (.*)', txt).group(1).strip()
    va = blk[0].split('$')[1].split()[0]
    recs = []
    for l in blk:
        mm = re.match(r'^[0-9a-f]+: \$([0-9a-f]+) 9[46] Def2? class (\w+) type (.*?)\s+name (\S+)\s*$', l)
        if mm:
            slot, cls, rest, nm = mm.groups()
            recs.append((cls, nm, rest, int(slot, 16)))
    missing = [r for r in recs if not re.search(r'\b%s\b' % re.escape(r[1]), srcnc)]
    print(f"@{va} {fn}")
    for cls, nm, rest, slot in recs:
        flag = '  !!MISSING' if (cls, nm, rest, slot) in missing else ''
        print(f"    {cls:8} ${slot:<3x} {nm:24} {rest}{flag}")
    print()
