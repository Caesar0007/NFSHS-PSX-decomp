#!/usr/bin/env python3
"""pickparse.py -- round-11 harness: align a [sched_pick] trace (GCC_TRACE_SCHED)
with the -dS dump's RTL so every pick line reads as named insns.

Usage:
  python pickparse.py <trace.txt> <dump.i.sched> [--fn FontUpsideDown] [--pass 0|1]

Output: one line per pick:
  <n> pick=<uid>:<label>  (rule=pri|class|luid|only)  ready: uid:label(p,c,l) ...

The 'rule' column = which rank_for_schedule layer separated ready[0] from
ready[1]:  pri (priority differs), class (dep-class differs), luid (pure tie ->
source order), only (singleton list).
"""
import re, sys

def label_rtl(dump_txt, fn):
    i = dump_txt.index(fn)
    seg = dump_txt[i:i+60000]
    lab = {}
    for m in re.finditer(r'\(insn (\d+) \d+ \d+ \(set \(([^\n]{0,90})\n?\s*(\([^\n]{0,90})?', seg):
        uid, dst, srcp = m.group(1), m.group(2), m.group(3) or ''
        d = dst.replace('reg/v:SI ', 'r').replace('reg:SI ', 'r').replace('mem/s:SI ', 'M').replace('mem:SI ', 'M')
        s = srcp.replace('reg/v:SI ', 'r').replace('reg:SI ', 'r')
        t = (d + '<=' + s)[:48].replace('\t', ' ')
        # friendlier tags
        if 'font_tint' in m.group(0): t = 'TINT:' + t
        if '528482304' in m.group(0): t = 'PAL*:' + t
        if 'gFontClut' in m.group(0): t = 'CLUT:' + t
        lab[uid] = t
    return lab

def main():
    trace_p, dump_p = sys.argv[1], sys.argv[2]
    fn = 'FontUpsideDownBlit'
    want_pass = None
    if '--fn' in sys.argv: fn = sys.argv[sys.argv.index('--fn')+1]
    if '--pass' in sys.argv: want_pass = sys.argv[sys.argv.index('--pass')+1]
    lab = label_rtl(open(dump_p).read(), fn)
    n = 0
    for L in open(trace_p, errors='replace'):
        m = re.match(r'\[sched_pick\] pass=(\d) clk=(-?\d+) last=(-?\d+) ::(.*)', L)
        if not m: continue
        if want_pass and m.group(1) != want_pass: continue
        entries = re.findall(r'(\d+)\(p(\d+),c(\d+),l(\d+)\)', m.group(4))
        if not entries: continue
        # only report picks whose insns belong to our fn (uid in lab) --
        # cheap filter: ready[0] labeled
        if entries[0][0] not in lab and len(entries) > 1 and entries[1][0] not in lab:
            continue
        n += 1
        u0, p0, c0, l0 = entries[0]
        if len(entries) == 1:
            rule = 'only'
        else:
            u1, p1, c1, l1 = entries[1]
            if p0 != p1: rule = 'pri'
            elif c0 != c1: rule = 'class'
            else: rule = 'luid'
        rl = ' '.join('%s:%s(p%s,c%s,l%s)' % (u, lab.get(u, '?'), p, c, l)
                      for u, p, c, l in entries[:6])
        print('%3d pick=%s:%s rule=%-5s | %s' % (n, u0, lab.get(u0, '?'), rule, rl))

if __name__ == '__main__':
    main()
