"""pairdiff.py OURS ORACLE [OBJ FN] -- align on skeleton, then compare aligned
pairs FULLY.  With OBJ+FN given, reloc-carrying instructions are masked exactly
like regiondiff/tools/verify_region.py does (HI16/LO16/GPREL16/26)."""
import re, sys, difflib, subprocess
OBJD = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'

def norm(t):
    t = re.sub(r'\s+', ' ', t.strip()).replace('$', '')
    t = re.sub(r',\s+', ',', t)
    t = re.sub(r'0x([0-9a-fA-F]+)', lambda m: str(int(m.group(1), 16)), t)
    t = re.sub(r'%hi\([^)]*\)', '0', t)
    t = re.sub(r'%lo\([^)]*\)', '0', t)
    t = re.sub(r'%gp_rel\([^)]*\)', '0', t)
    t = re.sub(r'^move (\w+),(\w+)$', r'addu \1,\2,zero', t)
    t = re.sub(r'^or (\w+),zero,(\w+)$', r'addu \1,\2,zero', t)
    t = re.sub(r'^or (\w+),(\w+),zero$', r'addu \1,\2,zero', t)
    t = re.sub(r'^(?:addiu|ori) (\w+),zero,(-?\d+)$', r'li \1,\2', t)
    m = re.match(r'(beq|bne)\s+(\w+,\w+),', t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m = re.match(r'(b\w+z|bgez|blez|bgtz|bltz)\s+(\w+),', t)
    if m: return f"{m.group(1)} {m.group(2)},T"
    m = re.match(r'(j|jal|b)\s+', t)
    if m: return f"{m.group(1)} T"
    return t

def mask(t, kind):
    if kind == 'R_MIPS_HI16':
        return re.sub(r'^(lui \w+),.*$', r'\1,A', t)
    if kind in ('R_MIPS_LO16', 'R_MIPS_GPREL16', 'R_MIPS_LITERAL'):
        t = re.sub(r',-?\d+\(', ',A(', t)
        t = re.sub(r',-?\d+$', ',A', t)
    return t

ours = [norm(l) for l in open(sys.argv[1]) if l.strip()]
orc  = [norm(l) for l in open(sys.argv[2]) if l.strip()]
kinds = [None] * len(ours)
if len(sys.argv) > 4:
    dis = subprocess.run([OBJD, '-d', '-r', '-z', sys.argv[3]],
                         capture_output=True, text=True).stdout
    lines, inb = [], False
    for ln in dis.splitlines():
        m = re.match(r'^[0-9a-f]{8} <(.+)>:', ln)
        if m:
            if inb and re.fullmatch(r'LM\d+', m.group(1)): continue
            if inb: break
            inb = (m.group(1) == sys.argv[4]); continue
        if inb: lines.append(ln)
    kinds, idx = [], 0
    for i, ln in enumerate(lines):
        if not re.match(r'^\s*[0-9a-f]+:\t([0-9a-f]+)\s*\t(.*)', ln): continue
        nxt = lines[i+1] if i+1 < len(lines) else ''
        mrel = re.search(r'R_MIPS_\w+', nxt)
        kinds.append(mrel.group(0) if mrel else None)

def sk(t): return re.sub(r'-?\b\d+\b', 'N', t)
sm = difflib.SequenceMatcher(None, [sk(x) for x in ours], [sk(x) for x in orc], autojunk=False)
n = 0
for tag, i1, i2, j1, j2 in sm.get_opcodes():
    if tag == 'equal':
        for k in range(i2 - i1):
            i, j = i1 + k, j1 + k
            a, b = ours[i], orc[j]
            kd = kinds[i] if i < len(kinds) else None
            if kd: a, b = mask(a, kd), mask(b, kd)
            if a != b:
                n += 1; print(f"  @{i}/{j}  - {ours[i]}\n           + {orc[j]}")
    else:
        n += (i2 - i1) + (j2 - j1)
        print(f"  GAP {tag} ours[{i1}:{i2}] oracle[{j1}:{j2}]")
        for i in range(i1, i2): print(f"           - {ours[i]}")
        for j in range(j1, j2): print(f"           + {orc[j]}")
print(f"TOTAL {n} diffs (ours {len(ours)} / oracle {len(orc)})")
