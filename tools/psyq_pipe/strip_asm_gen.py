"""strip_asm_gen.py -- source lines for a Sony HAND-ASSEMBLY routine taken from a PsyQ 4.3 object (for LINK_STRIPPED asm
members).  gen(lib, member, fn, nxt, symmap) -> list of assembler lines:
  * plain instructions: objdump mnemonics with numeric registers;
  * words objdump cannot name (GTE cop2 COMMANDS): `.word 0x........`;
  * branches inside the routine: local labels `.L<fn>_<offset>`;
  * relocated instructions: %hi()/%lo() or a symbolic jal/j target, through `symmap`
    { 'SECT(.data)+0x14': 'D_8013485C', 'SECT(.text)+0x100': '_VectorNormalSS_kernel', 'extsym': 'extsym' }."""
import re
import subprocess
import sys

R = 'C:/Temp/nfs4-decomp/'
REG = {'zero': 0, 'at': 1, 'v0': 2, 'v1': 3, 'a0': 4, 'a1': 5, 'a2': 6, 'a3': 7, 't0': 8, 't1': 9, 't2': 10, 't3': 11, 't4': 12,
       't5': 13, 't6': 14, 't7': 15, 's0': 16, 's1': 17, 's2': 18, 's3': 19, 's4': 20, 's5': 21, 's6': 22, 's7': 23, 't8': 24,
       't9': 25, 'k0': 26, 'k1': 27, 'gp': 28, 'sp': 29, 's8': 30, 'ra': 31}


def num(args):
    return re.sub(r'(?<![\w$.])(' + '|'.join(REG) + r')\b', lambda k: '$%d' % REG[k.group(1)], args)


def relkey(rel):
    rel = rel.strip()
    m = re.match(r'\((0x[0-9A-Fa-f]+) \+ (SECT\(\.\w+\)|\w+)\)$', rel)
    if m:
        return '%s+%s' % (m.group(2), m.group(1).lower())
    return rel


def gen(lib, member, fn, nxt, symmap):
    cmd = [sys.executable, R + 'tools/psyq_pipe/sdkfn.py', lib, member, fn] + ([nxt] if nxt else [])
    rows = []
    for ln in subprocess.run(cmd, capture_output=True, text=True).stdout.splitlines():
        m = re.match(r'^([0-9a-f]{4})  (.{34}) ?(.*)$', ln)
        if m:
            rows.append((int(m.group(1), 16), m.group(2).strip(), m.group(3).strip()))
    # raw words for the unnamed ones
    words = {}
    out = subprocess.run([sys.executable, R + 'tools/objtruth.py', 'dump', 'C:/Temp/nfs4-clean/psyq43/extracted/%s/obj/%s.obj' % (lib, member), fn] +
                         (['--end', nxt] if nxt else []), capture_output=True, text=True).stdout
    for ln in out.splitlines():
        m = re.match(r'\s+\+([0-9A-F]+) ([0-9A-F]{8})', ln)
        if m:
            words[int(m.group(1), 16)] = int(m.group(2), 16)
    while rows and words.get(rows[-1][0]) == 0 and not (len(rows) > 1 and re.match(r'(jr|j|jal|b\w*) ', rows[-2][1])):
        rows.pop()                                   # the member's zero alignment tail
    targets = set()
    for off, dis, rel in rows:
        m = re.match(r'(b\w+) (.*,)?(0x[0-9a-f]+)$', dis)
        if m and not rel:
            targets.add(int(m.group(3), 16))
    lines = []
    for off, dis, rel in rows:
        if off in targets:
            lines.append('.L%s_%x:' % (fn, off))
        if dis == '?' or dis.startswith('.word'):
            lines.append('\t.word 0x%08x' % words[off])
            continue
        op, _, args = dis.partition(' ')
        args = num(args.strip())
        if op == 'sll' and args.replace(' ', '') == '$0,$0,0x0':
            lines.append('\tnop'); continue
        if rel:
            sym = symmap[relkey(rel)]
            if op in ('jal', 'j'):
                lines.append('\t%s %s' % (op, sym))
            elif op == 'lui':
                lines.append('\tlui %s,%%hi(%s)' % (args.split(',')[0], sym))
            else:
                m = re.match(r'(\$\d+),(-?\w+)\((\$\d+)\)$', args)
                if m:
                    lines.append('\t%s %s,%%lo(%s)(%s)' % (op, m.group(1), sym, m.group(3)))
                else:
                    a = args.split(',')
                    lines.append('\t%s %s,%s,%%lo(%s)' % (op, a[0], a[1], sym))
            continue
        m = re.match(r'(b\w+)$', op)
        if m and re.search(r'0x[0-9a-f]+$', args):
            t = int(re.search(r'0x([0-9a-f]+)$', args).group(1), 16)
            args = re.sub(r'0x[0-9a-f]+$', '.L%s_%x' % (fn, t), args)
        lines.append('\t%s %s' % (op, args))
    # maspsx convention for hand assembly: the DELAY-SLOT instruction is written with a leading space (as in
    # recon/lib/bios_thunk.h); without it maspsx materialises its own nop after the jump.
    out, slot = [], False
    for l in lines:
        if l.endswith(':'):
            out.append(l)
            continue
        if slot:
            l = l[0] + ' ' + l[1:]
        slot = bool(re.match(r'\t ?(j|jr|jal|jalr|b\w*)\b', l))
        out.append(l)
    return out


def macro(fn, lines):
    return 'GTE_ASM_LINK_STRIPPED(%s,\n%s);\n' % (fn, '\n'.join('    "%s\\n"' % l.replace('\t', '\\t') for l in lines))
