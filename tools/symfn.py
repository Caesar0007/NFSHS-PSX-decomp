#!/usr/bin/env python3
"""symfn.py FUNCTION [FUNCTION...] [--no-code] | --all [OUT.txt] -- a function as the retail SYM describes it.

    python tools/symfn.py Initialize__18tTournamentManager
    python tools/symfn.py --all                 # every function, address order -> build/sym/symfn_all.txt

Prints, from the retail SYM dump (tools/retail_sym.py makes it from rom/NFS4.SYM):
  * where: source file, first/last line, address range, frame (fsize, saved-register mask, mask offset);
  * scopes and locals: the block tree with ABSOLUTE line numbers (the SYM stores block lines relative to the
    function's first line) and the address each block opens/closes at; every parameter and local is printed
    inside the block that declares it -- storage class, home (register or sp offset), type, name;
  * lines: the SLD table, address -> source line, in address order.  With the image at hand (rom/nfs4-f.exe)
    every entry is annotated with what the code between it and the next entry does: `if` = a forward
    conditional branch, `loop` = a backward branch (the line is a loop head or body), `call X` = jal, `ret`.
    A line number that goes DOWN between consecutive entries is marked `<` -- the compiler went back to an
    earlier line (loop condition re-emitted, else-arm, unrolled body).
The SYM has no record of statement kinds; the lines plus the branch shapes are what there is."""
import re
import struct
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / 'tools'))
LOAD, FOFF = 0x80010000, 0x800


def load_sym():
    import retail_sym
    return Path(retail_sym.txt()).read_text(encoding='utf-8', errors='replace').splitlines()


def symbols():
    out = {}
    for ln in (ROOT / 'configs' / 'symbol_addrs.txt').read_text(errors='replace').splitlines():
        m = re.match(r'^(\S+)\s*=\s*0x([0-9A-Fa-f]+);', ln)
        if m:
            out[int(m.group(2), 16)] = m.group(1)
    return out


REC = re.compile(r'^[0-9a-f]+: \$([0-9a-f]{8}) ([0-9a-f]{2}) (.*)$')


def function_block(lines, fn, start_index=0):
    """(start address, header dict, records after the header up to Function end)"""
    for i in range(start_index, len(lines)):
        ln = lines[i]
        if ln.strip() != 'name = ' + fn:
            continue
        j = i - 1                                   # the 8c record sits a few field lines above `name`
        while j > i - 12 and not lines[j].endswith('8c Function start'):
            j -= 1
        if not lines[j].endswith('8c Function start'):
            continue
        if True:
            m = REC.match(lines[j])
            hdr = {'addr': int(m.group(1), 16)}
            for h in lines[j + 1:i]:
                k, _, v = h.strip().partition(' = ')
                hdr[k] = v
            recs = []
            for ln2 in lines[i + 1:]:
                recs.append(ln2)
                if ' 8e Function end' in ln2:
                    break
            return hdr, recs
    return None, None


_SLD = None


def sld_index(lines):
    """every SLD record of the dump, once: sorted [(addr, line)], the last line stated per address"""
    global _SLD
    if _SLD is None:
        last = {}
        for ln in lines:
            if 'SLD' not in ln:
                continue
            m = REC.match(ln)
            if not m:
                continue
            n = re.search(r'\(to (\d+)\)|linenum to (\d+)|to line (\d+) of', m.group(3))
            if n:
                last[int(m.group(1), 16)] = int(next(g for g in n.groups() if g))
        _SLD = sorted(last.items())
    return _SLD


def sld_table(lines, lo, hi):
    """[(addr, line)] for every SLD record inside [lo, hi)"""
    import bisect
    idx = sld_index(lines)
    keys = [a for a, _ in idx]
    return idx[bisect.bisect_left(keys, lo):bisect.bisect_left(keys, hi)]


def annotate(img, syms, start, lo, hi, fn_lo, fn_hi):
    """what the instructions in [lo, hi) do, as short tags"""
    tags = []
    for va in range(lo, hi, 4):
        off = FOFF + va - LOAD
        if off + 4 > len(img):
            break
        w = struct.unpack_from('<I', img, off)[0]
        op = w >> 26
        if op == 3:
            t = ((w & 0x3FFFFFF) << 2) | (va & 0xF0000000)
            tags.append('call ' + syms.get(t, '%08X' % t))
        elif op == 2:
            t = ((w & 0x3FFFFFF) << 2) | (va & 0xF0000000)
            tags.append('loop' if t <= va else 'jump')
        elif op in (4, 5, 6, 7) or (op == 1 and ((w >> 16) & 31) in (0, 1, 2, 3, 16, 17)) or op in (0x14, 0x15, 0x16, 0x17):
            t = va + 4 + (struct.unpack('<h', struct.pack('<H', w & 0xFFFF))[0] << 2)
            tags.append('loop' if t <= va else 'if')
        elif op == 0 and (w & 0x3F) == 8 and ((w >> 21) & 31) == 31:
            tags.append('ret')
        elif op == 0 and (w & 0x3F) in (8, 9):
            tags.append('call *reg' if (w & 0x3F) == 9 else 'jump *reg')
    # compress repeats, keep order
    seen, out = set(), []
    for t in tags:
        if t not in seen:
            seen.add(t); out.append(t)
    return out


def show(fn, lines, img, syms, with_code, start_index=0):
    hdr, recs = function_block(lines, fn, start_index)
    if hdr is None:
        print('%s: not in the SYM' % fn); return
    start = hdr['addr']
    end_rec = REC.match(recs[-1])
    end = int(end_rec.group(1), 16)
    fline = int(hdr['line'])
    eline = re.search(r'line (\d+)', end_rec.group(3))
    print('== %s' % fn)
    print('   %s : lines %s..%s   %08X..%08X (%d bytes)' % (hdr.get('file', '?'), fline, eline.group(1) if eline else '?', start, end, end - start))
    print('   frame %s bytes, saved mask %s, mask offset %s, return reg %s' % (hdr.get('fsize'), hdr.get('mask'), hdr.get('maskoffs'), hdr.get('retreg')))

    # locals INSIDE the scope that owns them: a variable declared in a nested block (a `for (int i ...)`
    # init, a braced body, an inline expansion) is printed under that block's `{`, so its scope is explicit
    print('-- scopes and locals (absolute lines; a local belongs to the innermost `{` above it)')
    depth = 0
    for ln in recs:
        m = REC.match(ln)
        if not m:
            continue
        a, body = int(m.group(1), 16), m.group(3)
        if 'Block start' in body:
            rl = int(re.search(r'line = (\d+)', body).group(1))
            print('   %s{ line %d  @%08X' % ('    ' * depth, fline + rl - 1, a))
            depth += 1
        elif 'Block end' in body:
            depth -= 1
            rl = int(re.search(r'line = (\d+)', body).group(1))
            print('   %s} line %d  @%08X' % ('    ' * depth, fline + rl - 1, a))
        else:
            d = re.match(r'Def2? class (\w+) type (.+?) size (\d+)(?: dims (\d+(?: \d+)*))?(?: tag (\S*))? name (\S+)$', body)
            if not d:
                continue
            cls, typ, size, dims, tag, name = d.groups()
            if cls == 'REGPARM' or cls == 'REG':
                home = '$%d' % a
            elif cls in ('AUTO', 'ARG'):
                home = 'sp%+d' % struct.unpack('<i', struct.pack('<I', a))[0]
            else:
                home = '%08X' % a
            if tag:
                typ += ' ' + tag
            if dims and dims.split()[0] != '0':          # "dims N n1 n2..." -> [n1][n2]
                typ += ''.join('[%s]' % n for n in dims.split()[1:])
            print('   %s%-8s %-8s %s  %s' % ('    ' * depth, cls, home, typ, name))

    sld = sld_table(lines, start, end)
    print('-- lines (SLD: address -> source line%s)' % (', code shape from the image' if with_code and img else ''))
    prev = None
    for i, (a, l) in enumerate(sld):
        nxt = sld[i + 1][0] if i + 1 < len(sld) else end
        mark = '<' if prev is not None and l < prev else ' '
        tags = annotate(img, syms, start, a, nxt, start, end) if (with_code and img) else []
        print('   %08X  %s%4d  %s' % (a, mark, l, ', '.join(tags)))
        prev = l


def main():
    with_code = '--no-code' not in sys.argv
    lines = load_sym()
    img = None
    for cand in (ROOT / 'rom' / 'nfs4-f.exe', ROOT / 'build' / 'full_link' / 'nfs4.exe'):
        if cand.is_file():
            img = cand.read_bytes(); break
    syms = symbols()

    if '--all' in sys.argv:
        import contextlib
        import io
        i = sys.argv.index('--all')
        rest = [a for a in sys.argv[i + 1:] if not a.startswith('--')]
        path = Path(rest[0]) if rest else ROOT / 'build' / 'sym' / 'symfn_all.txt'
        blocks = []                                  # (address, line index of the 8c record, name)
        for j, ln in enumerate(lines):
            if ln.endswith('8c Function start'):
                for h in lines[j + 1:j + 10]:
                    if h.strip().startswith('name = '):
                        blocks.append((int(REC.match(ln).group(1), 16), j, h.strip()[7:])); break
        blocks.sort()
        nl = chr(10)
        with open(path, 'w', encoding='utf-8', newline=nl) as f:
            f.write('retail NFS4.SYM, every function, in address order -- generated by tools/symfn.py --all' + nl)
            for _, j, name in blocks:
                buf = io.StringIO()
                with contextlib.redirect_stdout(buf):
                    show(name, lines, img, syms, with_code, start_index=j)   # by index: same-named statics stay apart
                f.write(nl + '=' * 110 + nl + buf.getvalue())
        print('wrote %s: %d functions, %d bytes' % (path, len(blocks), path.stat().st_size))
        return

    args = [a for a in sys.argv[1:] if not a.startswith('--')]
    if not args:
        sys.exit(__doc__)
    for fn in args:
        show(fn, lines, img, syms, with_code)
        print()


if __name__ == '__main__':
    main()
