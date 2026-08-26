#!/usr/bin/env python3
"""gen_target_asm.py FUNC [--dis build/exp.dis] — emit decomp.me-ready GAS for one function.

Turns objdump output (bare regs, raw offsets, R_MIPS reloc lines) into a paste-ready
`Target assembly` block: glabel header, %hi()/%lo() relocs, internal branch/jump -> .Lxxx,
external jal/j -> symbol name, and the GAS-required $-prefix on every register
(objdump prints regs BARE; GAS rejects them — see methodology §3.16).

Default source is build/exp.dis (the disassembled `expected/` target object). Pass
--obj X.o to objdump a fresh object instead. Works for any MIPS I (R3000/PSX) function.
"""
import re, sys, subprocess, argparse
from pathlib import Path
ROOT = Path(__file__).resolve().parent.parent
OBJDUMP = r'C:/Tools/mips-ps1/mips/bin/mipsel-none-elf-objdump.exe'
REGS = ('zero','at','v0','v1','a0','a1','a2','a3','t0','t1','t2','t3','t4','t5','t6',
        't7','s0','s1','s2','s3','s4','s5','s6','s7','t8','t9','k0','k1','gp','sp','fp','ra')
REG_RE = re.compile(r'(?<![\w$%.])(' + '|'.join(REGS) + r')(?![\w])')

ap = argparse.ArgumentParser()
ap.add_argument('func')
ap.add_argument('--dis', default=str(ROOT / 'build' / 'exp.dis'))
ap.add_argument('--obj', default=None)
a = ap.parse_args()

if a.obj:
    text = subprocess.run([OBJDUMP, '-d', '-r', a.obj], capture_output=True, text=True).stdout
else:
    text = Path(a.dis).read_text()

name = a.func
parsed, inb = [], False
for ln in text.splitlines():
    m = re.match(r'^[0-9a-f]{8} <(.+)>:', ln)
    if m:
        # An object can carry LOCAL labels (.L*) as real symbols INSIDE a
        # function -- jump-table targets do exactly that.  objdump prints a
        # header for each, so breaking on any header truncates the function
        # mid-body and leaves its branches as raw `1720 <.Lxxxx+0x14>` text.
        # Only a non-.L symbol actually ends the function.
        if m.group(1).startswith('.L'):
            continue
        if inb:
            break
        inb = (m.group(1) == name); continue
    if not inb:
        continue
    mi = re.match(r'^\s*([0-9a-f]+):\t([0-9a-f]+)\s*\t(.*)', ln)
    if mi:
        parsed.append([int(mi.group(1), 16), mi.group(3).strip(), None])
    elif 'R_MIPS' in ln:
        parsed[-1][2] = (ln.split('R_MIPS')[1].split()[0], ln.split()[-1])
if not parsed:
    sys.exit(f"function {name!r} not found in {a.obj or a.dis}")

base = parsed[0][0]
end = parsed[-1][0] + 4
targets = set()
for off, txt, _ in parsed:
    m = re.search(r'<' + re.escape(name) + r'(?:\+0x([0-9a-f]+))?>', txt)
    if m:
        targets.add(int(m.group(1), 16) if m.group(1) else 0)
    m2 = re.match(r'(b\w+|j)\b.*?\b([0-9a-f]+) <', txt)
    if m2 and base <= int(m2.group(2), 16) < end:
        targets.add(int(m2.group(2), 16) - base)   # internal, .L-named

def fix(txt, reloc):
    m = re.search(r'<' + re.escape(name) + r'(?:\+0x([0-9a-f]+))?>', txt)
    m2 = re.match(r'(b\w+|j)\b.*?\b([0-9a-f]+) <', txt)
    if m and re.match(r'(b\w+|j)\b', txt):                    # internal branch/jump -> .Lxxx
        off = int(m.group(1), 16) if m.group(1) else 0
        txt = re.sub(r'[0-9a-f]+ <' + re.escape(name) + r'(?:\+0x[0-9a-f]+)?>', '.L%x' % off, txt)
    elif (m2 is not None and base <= int(m2.group(2), 16) < end):
        # internal target objdump named after a local .L symbol.  The range
        # test MUST be in the condition: an EXTERNAL `j 0 <sym>` has to fall
        # through to the R_MIPS_26 reloc handler below.
        txt = re.sub(r'\b[0-9a-f]+ <[^>]+>',
                     '.L%x' % (int(m2.group(2), 16) - base), txt)
    elif reloc:
        typ, sym = reloc
        if typ.startswith('_HI16'):
            txt = re.sub(r'0x0$', '%hi(' + sym + ')', txt)
        elif typ.startswith('_LO16'):
            txt = (re.sub(r'0\(', '%lo(' + sym + ')(', txt)
                   if re.search(r'\b(lw|sw|lb|sb|lh|sh|lbu|lhu|lwl|lwr|swl|swr)\b', txt)
                   else re.sub(r',0$', ',%lo(' + sym + ')', txt))
        elif typ.startswith('_26'):
            txt = re.sub(r'\b0(?:x0)? <[^>]+>', sym, txt)
    # mnemonic stays bare; $-prefix only the operand field
    parts = txt.split('\t', 1)
    if len(parts) == 2:
        parts[1] = REG_RE.sub(r'$\1', parts[1])
        txt = '\t'.join(parts)
    else:
        txt = REG_RE.sub(r'$\1', txt)
    return txt

COP0 = {'c0_sr': '$12', 'c0_cause': '$13', 'c0_epc': '$14', 'c0_badvaddr': '$8',
        'c0_context': '$4', 'c0_status': '$12', 'c0_prid': '$15'}

out = ['glabel %s' % name]
for off, txt, reloc in parsed:
    rel = off - base
    if rel in targets and rel != 0:
        out.append('.L%x:' % rel)
    line = fix(txt, reloc)
    for k, v in COP0.items():          # objdump prints cop0 regs by name
        line = line.replace(k, v)
    out.append('    ' + line)
print('\n'.join(out))
