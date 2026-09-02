#!/usr/bin/env python3
"""R01 scratch: map every ctor-argument constant difference between the BASE
oracle of __15tGlobalMenuDefs and the NFS4-R-USA regional oracle onto the
member offset (`this + N`) the call constructs, so it can be applied to the
right initializer-list entry in the source.

Output: one line per (member offset, argument position, base -> region).
"""
import re, sys

def norm(s):
    t = re.sub(r'\s+', ' ', s.strip()).replace('$', '')
    t = re.sub(r'\bs8\b', 'fp', t)
    t = re.sub(r',\s+', ',', t)
    t = re.sub(r'0x([0-9a-fA-F]+)', lambda m: str(int(m.group(1), 16)), t)
    t = re.sub(r'^move (\w+),(\w+)$', r'addu \1,\2,zero', t)
    t = re.sub(r'^(?:addiu|ori) (\w+),zero,(-?\d+)$', r'li \1,\2', t)
    return t

def load(p):
    out = []
    for ln in open(p, encoding='utf8', errors='replace'):
        s = re.sub(r'/\*.*?\*/', '', ln).strip()
        if (not s or s.endswith(':') or
                s.startswith(('.', 'glabel', 'nonmatching', 'dlabel', 'jlabel',
                              'alabel', 'endlabel'))):
            continue
        out.append(norm(s))
    return out

def scan(lines):
    """walk the whole (straight-line) ctor tracking this-relative pointers and
    integer constants; emit one record per jal."""
    off  = {}      # reg -> this+N
    imm  = {}      # reg -> integer constant
    slot = {}      # sp slot -> this+N
    simm = {}      # sp slot -> integer constant
    calls = []
    pend  = {}     # argpos -> const, for the call being set up
    penda = {}     # a-reg -> const
    this_off = None
    for i, s in enumerate(lines):
        m = re.match(r'^jal (\S+)$', s)
        if m:
            nxt = lines[i+1] if i+1 < len(lines) else ''
            # the delay slot instruction still belongs to the call setup
            args = dict(pend)
            for r, v in penda.items():
                args[int(r[1])] = v
            calls.append([m.group(1), this_off, args, i])
            pend, penda, this_off = {}, {}, None
            continue
        m = re.match(r'^li (\w+),(-?\d+)$', s)
        if m:
            imm[m.group(1)] = int(m.group(2)); off.pop(m.group(1), None)
            if re.fullmatch(r'a[123]', m.group(1)):
                penda[m.group(1)] = int(m.group(2))
            continue
        m = re.match(r'^lui (\w+),', s)
        if m:
            imm.pop(m.group(1), None); off.pop(m.group(1), None); continue
        m = re.match(r'^addiu (\w+),(\w+),(-?\d+)$', s)
        if m:
            d, a, k = m.group(1), m.group(2), int(m.group(3))
            if a in off: off[d] = off[a] + k
            else: off.pop(d, None)
            imm.pop(d, None); continue
        m = re.match(r'^addu (\w+),(\w+),zero$', s)
        if m:
            d, a = m.group(1), m.group(2)
            if a in off: off[d] = off[a]
            else: off.pop(d, None)
            if a in imm: imm[d] = imm[a]
            else: imm.pop(d, None)
            if d == 'a0' and a in off: this_off = off[a]
            if re.fullmatch(r'a[123]', d) and a in imm: penda[d] = imm[a]
            continue
        if s == 'addu a0,zero,zero':
            this_off = 0; continue
        m = re.match(r'^sw (\w+),(\d+)\(sp\)$', s)
        if m:
            r, n = m.group(1), int(m.group(2))
            if n >= 16 and n < 64 and r in imm:
                pend[(n - 16)//4 + 4] = imm[r]
            if n >= 16 and n < 64 and r in off:
                pend[(n - 16)//4 + 4] = ('&+%d' % off[r])
            slot[n] = off.get(r); simm[n] = imm.get(r)
            continue
        if s == 'sw zero,16(sp)':
            pend[4] = 0; continue
        m = re.match(r'^sw zero,(\d+)\(sp\)$', s)
        if m:
            n = int(m.group(1))
            if 16 <= n < 64: pend[(n-16)//4 + 4] = 0
            continue
        m = re.match(r'^lw (\w+),(\d+)\(sp\)$', s)
        if m:
            r, n = m.group(1), int(m.group(2))
            if n == 640: off[r] = 0; imm.pop(r, None)
            else:
                if slot.get(n) is not None: off[r] = slot[n]
                else: off.pop(r, None)
                if simm.get(n) is not None: imm[r] = simm[n]
                else: imm.pop(r, None)
            continue
        # anything else kills the dest register
        m = re.match(r'^\w+ (\w+),', s)
        if m:
            off.pop(m.group(1), None); imm.pop(m.group(1), None)
    return calls

b = scan(load(r'asm/nonmatchings/front/__15tGlobalMenuDefs.s'))
r = scan(load(r'regiondiff/oracles/NFS4-R-USA/__15tGlobalMenuDefs.s'))
assert len(b) == len(r), (len(b), len(r))
for n, (bc, rc) in enumerate(zip(b, r), 1):
    ba, ra = bc[2], rc[2]
    for k in sorted(set(ba) | set(ra)):
        bv, rv = ba.get(k), ra.get(k)
        if bv != rv and isinstance(bv, int) and isinstance(rv, int):
            print(f"call{n:4d} off={bc[1]} (0x{bc[1]:X}) arg{k} {bv} -> {rv}"
                  if bc[1] is not None else
                  f"call{n:4d} off=? arg{k} {bv} -> {rv}")
