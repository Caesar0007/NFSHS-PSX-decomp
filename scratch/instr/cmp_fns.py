#!/usr/bin/env python
"""w46-a10: split N .s files into per-function instruction streams and report,
per function, which candidate compilers reproduce the REFERENCE (argv[1], the
real PsyQ CC1PSX) exactly.

Comparison is on the INSTRUCTION STREAM only:
  * directives (.ent/.end/.def/.set nobopt/.frame/.mask/.loc/debug records) are
    dropped -- ELF-vs-ECOFF differ on those by construction and they are not
    codegen;
  * whitespace normalized;
  * local labels ($LNN / $Lnn) renumbered in order of first appearance so a pure
    label-counter offset is not a "difference".
"""
import re
import sys

DROP = re.compile(r'^\s*\.(ent|end|def|val|scl|type|tag|size|dim|endef|file|loc|'
                  r'frame|mask|fmask|set|align|globl|text|data|rdata|sdata|'
                  r'sbss|bss|comm|lcomm|section|previous|cpload|cprestore|'
                  r'ident|stab\w*|word|byte|half|space|ascii|asciiz|gpword|'
                  r'nan|module|option|abicalls|extern)\b')


def fns(path):
    out, cur, name = {}, None, None
    for line in open(path, errors='replace'):
        m = re.match(r'^\s*\.ent\s+(\S+)', line)
        if m:
            name, cur = m.group(1), []
            continue
        if re.match(r'^\s*\.end\b', line):
            if name:
                out[name] = cur
            name, cur = None, None
            continue
        if cur is None:
            continue
        s = line.split('#')[0].rstrip()
        if not s.strip() or DROP.match(s):
            continue
        cur.append(s.strip())
    return out


def norm(body):
    lab, n, out = {}, [0], []
    def sub(m):
        k = m.group(0)
        if k not in lab:
            n[0] += 1
            lab[k] = 'L%d' % n[0]
        return lab[k]
    for l in body:
        l = re.sub(r'\$L\w+', sub, l)
        l = re.sub(r'\s+', ' ', l).strip()
        out.append(l)
    return out


def main():
    ref = sys.argv[1]
    cands = sys.argv[2:]
    R = {k: norm(v) for k, v in fns(ref).items()}
    C = [(p, {k: norm(v) for k, v in fns(p).items()}) for p in cands]
    print('reference: %s  (%d functions)\n' % (ref, len(R)))
    hdr = '%-52s' % 'function'
    for p, _ in C:
        hdr += ' %-9s' % p.split('/')[-2]
    print(hdr)
    tally = {p: 0 for p, _ in C}
    for k in sorted(R):
        row = '%-52s' % k[:52]
        for p, D in C:
            b = D.get(k)
            if b == R[k]:
                row += ' %-9s' % 'SAME'
                tally[p] += 1
            elif b is None:
                row += ' %-9s' % 'MISSING'
            else:
                row += ' %-9s' % ('d%d' % sum(
                    1 for a, c in zip(R[k], b + [''] * len(R[k])) if a != c))
        print(row)
    print()
    for p, _ in C:
        print('%-12s IDENTICAL %d / %d' % (p.split('/')[-2], tally[p], len(R)))


if __name__ == '__main__':
    main()
