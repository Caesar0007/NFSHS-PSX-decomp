"""simplemem_apply.py [--dry] -- give every reconstructed object that lacks it the retail "SimpleMem" .rodata head.

LAW (2026-09-17/19): retail objects' .rodata opens with an UNREFERENCED "SimpleMem" literal = an expansion-time
literal of the first literal-bearing function; `if (0) sprintf((char *)0,"SimpleMem");` in a NON-LEAF function
reproduces it without touching the code (a dead variadic call in a LEAF adds a frame).

Per candidate (rodata row whose preceding retail bytes are the tag):
  1. F = first non-leaf function of the built .s; refuse if any .rdata item is emitted before F's `.globl`
     (an earlier function's literal would precede the tag).
  2. find F's definition in the source from its mangled name; refuse if not found exactly once.
  3. insert the dead call after the opening brace (+ a sprintf declaration if the TU has none).
  4. rebuild; if the object's .text size changed, REVERT the source; else move the row down by the head size.
Prints a per-object verdict; nothing is committed."""
import json
import re
import subprocess
import sys
from pathlib import Path

ROOT = Path('C:/Temp/nfs4-decomp')
LOAD = 0x80010000
OBJDUMP = 'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
DRY = '--dry' in sys.argv
rom = (ROOT / 'rom/nfs4-f.exe').read_bytes()[0x800:]
ROWS = ROOT / 'linkers/nfs4_recon.rodata_placement.json'
rows = json.load(open(ROWS))
TAG = b'SimpleMem\0'
STMT = '\n  if (0) sprintf((char *)0,"SimpleMem");   /* retail: this object\'s .rodata opens with the unreferenced "SimpleMem" tag */\n'


def text_size(obj):
    out = subprocess.run([OBJDUMP, '-h', str(obj)], capture_output=True, text=True).stdout
    m = re.search(r'^\s*\d+\s+\.text\s+([0-9a-f]{8})', out, re.M)
    return int(m.group(1), 16) if m else -1


def demangle(f):
    m = re.match(r'^__(\d+)(.*)$', f)                      # constructor  __<len>Class<args>
    if m:
        n = int(m.group(1))
        cls = m.group(2)[:n]
        return cls + '::' + cls
    m = re.match(r'^(\w+?)__(\d+)(\w+)$', f)               # method       Name__<len>Class<args>
    if m:
        n = int(m.group(2))
        return m.group(3)[:n] + '::' + m.group(1)
    m = re.match(r'^(\w+?)__F', f)                          # free function Name__F<args>
    if m:
        return m.group(1)
    return f                                                # extern "C"


def find_def(src_text, qual):
    pat = re.compile(r'^[^\n;{}#/*]*\b' + re.escape(qual) + r'\s*\([^;{}]*\)[^;{}]*\{', re.M)
    return list(pat.finditer(src_text))


todo = []
for r in rows:
    b = r['base']
    head = None
    for back in (12, 16):
        o = b - back - LOAD
        if o >= 0 and rom[o:o + 10] == TAG and not any(rom[o + 10:o + back]):
            head = back
    if head is None:
        continue
    todo.append((r, head))

# ---- link-order check: a tag before X's window is X's only if every object between the previous window's owner and X
# (in retail text order) is accounted for by its own tag:  tags_in_gap == objects_between + 1
spine = [m.group(2) for m in sorted(((int(m.group(1), 16), m) for m in re.finditer(
    r'(0x[0-9a-f]+) : SUBALIGN\(4\) \{ (build/recon/\S+?)\(\.text\)', (ROOT / 'linkers/nfs4_recon.ld').read_text(errors='replace'))),
    key=lambda t: t[0]) for m in [m[1]]]
pos = {o: i for i, o in enumerate(spine)}
allrows = sorted(rows, key=lambda r: r['base'])
rowobjs = {r['obj'] for r in rows}


def unambiguous(r):
    i = allrows.index(r)
    if i == 0 or r['obj'] not in pos:
        return None
    prev = allrows[i - 1]
    if prev['obj'] not in pos or pos[prev['obj']] > pos[r['obj']]:
        return None
    gap = rom[prev['end'] - LOAD:r['base'] - LOAD]
    tags = gap.count(TAG)
    between = [o for o in spine[pos[prev['obj']] + 1:pos[r['obj']]] if o not in rowobjs]
    return tags, len(between)


done, skipped = [], []
for r, head in sorted(todo, key=lambda t: t[0]['base']):
    obj = ROOT / r['obj']
    src = ROOT / r['obj'].replace('build/', '', 1)[:-2]
    sfile = ROOT / (r['obj'][:-2] + '.s')
    name = r['obj'].split('build/recon/')[-1]
    if not src.exists() or not sfile.exists():
        skipped.append((name, 'no source/.s'))
        continue
    text = src.read_text(encoding='utf-8', errors='replace')
    ua = unambiguous(r)
    if ua is None or ua[0] != ua[1] + 1:
        skipped.append((name, f'ambiguous owner: tags/objects-between = {ua}'))
        continue
    if 'SimpleMem' in text:
        skipped.append((name, 'already has a SimpleMem literal'))
        continue
    lines = sfile.read_text(errors='replace').splitlines()
    order, jal, cur = [], {}, None
    for ln in lines:
        m = re.match(r'\s*\.ent\s+(\S+)', ln)
        if m:
            cur = m.group(1)
            order.append(cur)
            jal[cur] = 0
        elif cur and re.match(r'\s*jal\s', ln):
            jal[cur] += 1
    F = next((f for f in order if jal[f]), None)
    if F is None:
        skipped.append((name, 'no non-leaf function'))
        continue
    gl = next((i for i, ln in enumerate(lines) if re.match(r'\s*\.globl\s+' + re.escape(F) + r'\s*$', ln)), None)
    first_ro = next((i for i, ln in enumerate(lines) if re.match(r'\s*\.rdata', ln)), None)
    if gl is None:
        gl = next((i for i, ln in enumerate(lines) if re.match(r'\s*\.ent\s+' + re.escape(F) + r'\s*$', ln)), 0)
    if first_ro is not None and first_ro < gl and order.index(F) != 0:
        skipped.append((name, f'a literal is emitted before {F}'))
        continue
    qual = demangle(F.replace('_._', '___'))
    hits = find_def(text, qual)
    if len(hits) != 1:
        skipped.append((name, f'{len(hits)} definitions found for {qual}'))
        continue
    if DRY:
        done.append((name, qual, head))
        continue
    before = text_size(obj)
    new = text[:hits[0].end()] + STMT + text[hits[0].end():]
    if not re.search(r'\bsprintf\b', text):
        incs = [m.end() for m in re.finditer(r'^#include[^\n]*\n', new, re.M)]
        decl = ('extern "C" int sprintf(char *, const char *, ...);\n' if src.suffix == '.cpp'
                else 'extern int sprintf(char *, const char *, ...);\n')
        at = incs[-1] if incs else 0
        new = new[:at] + decl + new[at:]
    src.write_text(new, encoding='utf-8', newline='')
    b = subprocess.run([sys.executable, str(ROOT / 'tools/build.py'), '--skip-asm', '--only', r['obj']],
                       capture_output=True, text=True, cwd=ROOT)
    after = text_size(obj) if 'OK build' in b.stdout else -2
    if after != before:
        src.write_text(text, encoding='utf-8', newline='')
        subprocess.run([sys.executable, str(ROOT / 'tools/build.py'), '--skip-asm', '--only', r['obj']],
                       capture_output=True, text=True, cwd=ROOT)
        skipped.append((name, f'REVERTED: text {before:#x} -> {after:#x} ({qual})'))
        continue
    r['base'] -= head
    r['size'] += head
    r['end'] = r['base'] + r['size']
    done.append((name, qual, head))
if not DRY:
    json.dump(rows, open(ROWS, 'w'), indent=1)
print(f'--- applied {len(done)}')
for n, q, h in done:
    print(f'   {n:46s} {q}  (-{h})')
print(f'--- skipped {len(skipped)}')
for n, why in skipped:
    print(f'   {n:46s} {why}')
