#!/usr/bin/env python3
"""strict_branch.py -- STRICT BRANCH-WORD audit for the NFS4-PSX matching decomp.

WHY: tools/verify_asm.py is branch-target LENIENT by design (its norm_ins() rewrites
every branch's target operand to the literal 'T').  A branch with the right opcode and
the right registers but the WRONG DISPLACEMENT therefore gates PASS.  That blind spot
cost us the iSND100hzserver incident (retail word 10800015 vs ours 10800011 -- the
negative-volume SNDstop nested one level too shallow) while the gate said PASS 184/184.

WHAT: for a given TU object (build/recon/<unit>.<ext>.o) this disassembles with
mipsel-none-elf-objdump, walks each requested function's instruction stream, and
compares every BRANCH instruction WORD byte-for-byte against the retail word in the
oracle .s comment column (`/* FOFF VA WORD */`, little-endian byte string) -- the same
"the comment column IS the retail byte truth" principle as scratchpad/psyq_confirm/
confirm2.py.  Branch words carry NO relocation (PC-relative, intra-function), so they
must match EXACTLY in an unlinked object.  jal/j (R_MIPS_26) and lui/addiu/lw %hi/%lo
(R_MIPS_HI16/LO16/GPREL16) sites are EXCLUDED -- their immediates are link-time addends.

USAGE
  python strict_branch.py --all                 # every 100.00% fn in MATCH_PROGRESS.txt
  python strict_branch.py --unit game/common/aicop
  python strict_branch.py --fn AICop_StartUp__Fv
  python strict_branch.py --all --json out.json
Options: --pct 100.00 (filter), --objdir DIR (extra object search root), --quiet.
"""
import argparse
import json
import os
import re
import struct
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]          # C:/Temp/nfs4-decomp
OBJD = str(Path(r'C:/Tools/mips-ps1/mips/bin') / 'mipsel-none-elf-objdump.exe')
BUILD_RECON = ROOT / 'build' / 'recon'
SEGS = ('main', 'front')

# ---------------------------------------------------------------- branch decoding
# MIPS-I branch encodings (reference_mips_isa_asm.md "MIPS-I INSTRUCTION SET"):
#   op 0x01 REGIMM : bltz/bgez/bltzal/bgezal   (rt = 0,1,16,17)
#   op 0x04 beq  0x05 bne  0x06 blez  0x07 bgtz
#   op 0x10/11/12 with rs=0x08 : BCzF/BCzT (coprocessor branch)
# op 0x14-0x17 are the MIPS-II branch-LIKELY forms: NOT on R3000 -- flagged as anomaly.
REGIMM_BRANCH_RT = {0x00, 0x01, 0x10, 0x11}
LIKELY_OPS = {0x14, 0x15, 0x16, 0x17}


def br_kind(w):
    """Return a branch descriptor dict, or None if w is not a branch instruction."""
    op = (w >> 26) & 0x3F
    rs = (w >> 21) & 0x1F
    rt = (w >> 16) & 0x1F
    if op == 0x01 and rt in REGIMM_BRANCH_RT:
        name = {0x00: 'bltz', 0x01: 'bgez', 0x10: 'bltzal', 0x11: 'bgezal'}[rt]
        return dict(name=name, op=op, rs=rs, rt=rt, likely=False)
    if op in (0x04, 0x05, 0x06, 0x07):
        name = {0x04: 'beq', 0x05: 'bne', 0x06: 'blez', 0x07: 'bgtz'}[op]
        return dict(name=name, op=op, rs=rs, rt=rt, likely=False)
    if op in LIKELY_OPS:
        name = {0x14: 'beql', 0x15: 'bnel', 0x16: 'blezl', 0x17: 'bgtzl'}[op]
        return dict(name=name, op=op, rs=rs, rt=rt, likely=True)
    if op in (0x10, 0x11, 0x12) and rs == 0x08:
        return dict(name='bc%df/t' % (op - 0x10), op=op, rs=rs, rt=rt, likely=False)
    return None


def br_disp(w):
    """Signed 16-bit branch displacement (in instructions)."""
    d = w & 0xFFFF
    return d - 0x10000 if d & 0x8000 else d


def is_jump(w):
    return ((w >> 26) & 0x3F) in (0x02, 0x03)          # j / jal (R_MIPS_26 addend)


def lenient(w, reloc, oracle_txt):
    """Model tools/verify_asm.py's LENIENCY at the word level: it rewrites every
    branch/jump target to the literal 'T' and normalizes %hi/%lo/%gp_rel to 0.  So
    mask exactly those fields.  If two streams are lenient-EQUAL but a branch word
    differs strictly, the gate says PASS while the bytes differ => HIDDEN bug (the
    iSND100hzserver class).  If they are lenient-UNEQUAL the gate would fail too."""
    if br_kind(w):
        return w & 0xFFFF0000
    if is_jump(w):
        return w & 0xFC000000
    if reloc or ('%hi' in oracle_txt or '%lo' in oracle_txt or '%gp_rel' in oracle_txt):
        return w & 0xFFFF0000
    return w


REGN = ['zero', 'at', 'v0', 'v1', 'a0', 'a1', 'a2', 'a3', 't0', 't1', 't2', 't3',
        't4', 't5', 't6', 't7', 's0', 's1', 's2', 's3', 's4', 's5', 's6', 's7',
        't8', 't9', 'k0', 'k1', 'gp', 'sp', 'fp', 'ra']


def br_text(w):
    k = br_kind(w)
    if not k:
        return '%08X (not a branch)' % w
    if k['op'] == 0x01:
        return '%s $%s, %+d' % (k['name'], REGN[k['rs']], br_disp(w))
    if k['op'] in (0x04, 0x05):
        return '%s $%s, $%s, %+d' % (k['name'], REGN[k['rs']], REGN[k['rt']], br_disp(w))
    return '%s $%s, %+d' % (k['name'], REGN[k['rs']], br_disp(w))


# ---------------------------------------------------------------- oracle side
_SYMBOL_ADDRS = None


def symbol_addrs():
    global _SYMBOL_ADDRS
    if _SYMBOL_ADDRS is None:
        _SYMBOL_ADDRS = {}
        p = ROOT / 'configs' / 'symbol_addrs.txt'
        if p.exists():
            for ln in p.read_text(errors='replace').splitlines():
                m = re.match(r'^(\w+)\s*=\s*0x([0-9A-Fa-f]+)\s*;', ln.strip())
                if m:
                    _SYMBOL_ADDRS[m.group(1)] = int(m.group(2), 16)
    return _SYMBOL_ADDRS


def _exists_exact(p):
    """NTFS is case-INSENSITIVE: 'cd_read.s' silently opens 'CD_Read.s' (a DIFFERENT
    function) -> false PASS/FAIL.  Require the on-disk entry name to match byte-exact.
    (Same guard as tools/verify_asm.py::_exists_exact.)"""
    try:
        return p.exists() and p.name in {e.name for e in p.parent.iterdir()}
    except OSError:
        return False


def find_oracle_path(fn):
    for seg in SEGS:
        p = ROOT / 'asm' / 'nonmatchings' / seg / (fn + '.s')
        if _exists_exact(p):
            return p
    addrs = symbol_addrs()
    vas = []
    if fn in addrs:
        vas.append(addrs[fn])
    else:
        pat = re.compile(r'^' + re.escape(fn) + r'_[0-9A-Fa-f]{8}$')
        for name, va in addrs.items():
            if pat.match(name):
                vas.append(va)
    for va in vas:
        for seg in SEGS:
            for cand in ('%s_%08X' % (fn, va), 'func_%08X' % va):
                p = ROOT / 'asm' / 'nonmatchings' / seg / (cand + '.s')
                if _exists_exact(p):
                    return p
    return None


ORACLE_LINE = re.compile(
    r'^\s*/\*\s*([0-9A-Fa-f]+)\s+([0-9A-Fa-f]{8})\s+([0-9A-Fa-f]{8})\s*\*/\s*(.*)$')


def oracle_words(fn):
    """[(va, word, text)] for fn, stopping at `endlabel`.  Also returns the set of
    interior alabel names (they SPLIT our objdump block and must be walked through)
    and a va->label map for diagnosing branch targets."""
    p = find_oracle_path(fn)
    if p is None:
        return None, set(), {}, None
    txt = p.read_text(errors='replace')
    m = re.search(r'^endlabel', txt, re.M)
    if m:
        txt = txt[:m.start()]
    alabels = set(re.findall(r'^\s*alabel\s+(\S+)', txt, re.M))
    words = []
    labels = {}
    pending_label = None
    for ln in txt.splitlines():
        s = ln.strip()
        lm = re.match(r'^(\.L[0-9A-Fa-f]+|[A-Za-z_.$][\w.$]*):\s*$', s)
        if lm:
            pending_label = lm.group(1)
            continue
        am = re.match(r'^(?:alabel|glabel|jlabel|dlabel)\s+(\S+)', s)
        if am:
            pending_label = am.group(1)
            continue
        mm = ORACLE_LINE.match(ln)
        if not mm:
            continue
        va = int(mm.group(2), 16)
        word = struct.unpack('<I', bytes.fromhex(mm.group(3)))[0]
        words.append((va, word, mm.group(4).strip()))
        if pending_label:
            labels[va] = pending_label
            pending_label = None
    return words, alabels, labels, p


# ---------------------------------------------------------------- object side
class Obj(object):
    def __init__(self, path):
        self.path = Path(path)
        self.dis = subprocess.run([OBJD, '-d', '-r', '-z', str(self.path)],
                                  capture_output=True, text=True).stdout
        self.symtab = subprocess.run([OBJD, '-t', str(self.path)],
                                     capture_output=True, text=True).stdout
        self.name2addr = {}
        for ln in self.symtab.splitlines():
            if '*UND*' in ln or '*ABS*' in ln:
                continue          # undefined externs have a bogus addr 0 -> false alias
            t = ln.split()
            if len(t) >= 2 and re.match(r'^[0-9a-f]{8}$', t[0]):
                self.name2addr[t[-1]] = t[0]
        self.addr2label = {}
        for ln in self.dis.splitlines():
            m = re.match(r'^([0-9a-f]{8}) <(.+)>:', ln)
            if m:
                self.addr2label.setdefault(m.group(1), m.group(2))

    def resolve(self, fn):
        """Several XDEFs can share ONE address; objdump labels the block with the
        alphabetically-first name.  Map name->addr->whatever objdump called it."""
        a = self.name2addr.get(fn)
        return self.addr2label.get(a, fn) if a else fn

    def words(self, fn, interior=()):
        """[(off, word, text, reloc_or_None)] for fn's objdump block."""
        label = self.resolve(fn)
        lines = []
        inb = False
        for ln in self.dis.splitlines():
            m = re.match(r'^[0-9a-f]{8} <(.+)>:', ln)
            if m:
                if inb and (m.group(1) in interior or
                            re.fullmatch(r'LM\d+', m.group(1))):
                    continue                      # oracle alabel: same block
                if inb:
                    break
                inb = (m.group(1) == label)
                continue
            if inb:
                lines.append(ln)
        out = []
        for i, ln in enumerate(lines):
            mm = re.match(r'^\s*([0-9a-f]+):\t([0-9a-f]{8})\s*\t(.*)', ln)
            if not mm:
                continue
            reloc = None
            nxt = lines[i + 1] if i + 1 < len(lines) else ''
            rm = re.search(r'(R_MIPS_\w+)\s+(\S+)', nxt)
            if rm:
                reloc = (rm.group(1), rm.group(2))
            out.append((int(mm.group(1), 16), int(mm.group(2), 16),
                        mm.group(3).strip(), reloc))
        return out


# ---------------------------------------------------------------- unit -> object
def find_object(unit, extra_dirs=()):
    for d in list(extra_dirs) + [BUILD_RECON]:
        for ext in ('cpp', 'c', 'cc', 's'):
            p = Path(d) / ('%s.%s.o' % (unit, ext))
            if p.exists():
                return p
        p = Path(d) / (unit + '.o')
        if p.exists():
            return p
    return None


def source_for(unit):
    for ext in ('cpp', 'c', 'cc'):
        p = ROOT / 'src' / ('%s.%s' % (unit, ext))
        if p.exists():
            return p
    return None


# ---------------------------------------------------------------- the audit
def audit_fn(fn, obj, unit):
    """Return a result dict for one function."""
    res = dict(fn=fn, unit=unit, verdict='CLEAN', branches=0, insns=0,
               mismatches=[], note='')
    ow, alabels, labels, opath = oracle_words(fn)
    if ow is None:
        res['verdict'] = 'NO-ORACLE'
        return res
    res['oracle_path'] = str(opath)
    mine = obj.words(fn, alabels)
    if not mine:
        res['verdict'] = 'NOT-IN-OBJECT'
        return res
    res['insns'] = len(mine)
    if len(mine) != len(ow):
        # length skew makes index-alignment meaningless: report, do not guess
        res['verdict'] = 'SIZE-SKEW'
        res['note'] = 'ours %d insns / oracle %d insns' % (len(mine), len(ow))
        return res
    # gate-leniency model: would tools/verify_asm.py have said PASS on this stream?
    len_diffs = 0
    for (off, myw, mytxt, reloc), (va, rw, rtxt) in zip(mine, ow):
        if lenient(myw, reloc, rtxt) != lenient(rw, reloc, rtxt):
            len_diffs += 1
    res['gate_lenient_diffs'] = len_diffs
    res['gate'] = 'PASS' if len_diffs == 0 else 'FAIL'
    for i, ((off, myw, mytxt, reloc), (va, rw, rtxt)) in enumerate(zip(mine, ow)):
        rk = br_kind(rw)
        mk = br_kind(myw)
        if not rk and not mk:
            continue
        if reloc:
            # a branch carrying a reloc (R_MIPS_PC16) is a link-time addend -> exclude
            continue
        res['branches'] += 1
        if myw == rw:
            continue
        kind = 'STRUCTURAL'
        detail = ''
        if rk and mk and rk['op'] == mk['op'] and rk['rs'] == mk['rs'] and rk['rt'] == mk['rt']:
            kind = 'WRONG-TARGET'
            rtgt = va + 4 + br_disp(rw) * 4
            mtgt = va + 4 + br_disp(myw) * 4
            detail = ('retail -> %08X %s | ours -> %08X %s | delta %+d insns'
                      % (rtgt, labels.get(rtgt, '?'), mtgt, labels.get(mtgt, '?'),
                         br_disp(myw) - br_disp(rw)))
        elif rk and mk:
            kind = 'OPCODE/REG'
            detail = 'retail %s | ours %s' % (br_text(rw), br_text(myw))
        elif rk and not mk:
            kind = 'BRANCH-LOST'
            detail = 'retail %s | ours %s' % (br_text(rw), mytxt)
        else:
            kind = 'BRANCH-ADDED'
            detail = 'retail %s | ours %s' % (rtxt, br_text(myw))
        if (rk and rk['likely']) or (mk and mk['likely']):
            detail += '  [!! MIPS-II branch-likely: NOT on R3000]'
        res['mismatches'].append(dict(idx=i, va='%08X' % va, off='%X' % off,
                                      retail='%08X' % rw, ours='%08X' % myw,
                                      kind=kind, detail=detail,
                                      retail_txt=rtxt, ours_txt=mytxt))
    if res['mismatches']:
        # HIDDEN = the charter's target class: verify_asm gates PASS yet a branch WORD
        # differs (wrong nesting / wrong TU layout).  VISIBLE = the lenient gate would
        # fail too, so the MATCH_PROGRESS 100.00% row is simply STALE relative to the
        # current object (another agent mid-edit) -- not a gate blind spot.
        res['verdict'] = 'MISMATCH-HIDDEN' if res['gate'] == 'PASS' else 'MISMATCH-VISIBLE'
    return res


def load_progress(pct_filter):
    rows = []
    p = ROOT / 'MATCH_PROGRESS.txt'
    for ln in p.read_text(errors='replace').splitlines():
        # VA column is `-` for rows with no configs/symbol_addrs.txt entry (data blobs,
        # patch templates, address-named func_<VA> leftovers).  They still gate PASS,
        # so they MUST be audited -- accept both forms.
        m = re.match(r'^\s*(0x[0-9A-Fa-f]+|-)\s+(\d+\.\d+)%\s+(\S+)\s+(\S+)\s*$', ln)
        if m:
            pct = float(m.group(2))
            if pct_filter is not None and abs(pct - pct_filter) > 1e-9:
                continue
            va = int(m.group(1), 16) if m.group(1) != '-' else 0
            rows.append(dict(va=va, pct=pct, unit=m.group(3), fn=m.group(4)))
    return rows


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--all', action='store_true')
    ap.add_argument('--unit')
    ap.add_argument('--fn')
    ap.add_argument('--pct', type=float, default=100.00)
    ap.add_argument('--objdir', action='append', default=[])
    ap.add_argument('--json')
    ap.add_argument('--quiet', action='store_true')
    a = ap.parse_args()

    rows = load_progress(None if (a.fn or a.unit) else a.pct)
    if a.unit:
        rows = [r for r in rows if r['unit'] == a.unit]
    if a.fn:
        rows = [r for r in rows if r['fn'] == a.fn]
    if not rows:
        print('no functions selected'); return 2

    by_unit = {}
    for r in rows:
        by_unit.setdefault(r['unit'], []).append(r)

    results = []
    missing_objs = []
    for unit in sorted(by_unit):
        op = find_object(unit, a.objdir)
        if op is None:
            missing_objs.append(unit)
            for r in by_unit[unit]:
                results.append(dict(fn=r['fn'], unit=unit, verdict='NO-OBJECT',
                                    branches=0, insns=0, mismatches=[], note=''))
            continue
        obj = Obj(op)
        for r in by_unit[unit]:
            res = audit_fn(r['fn'], obj, unit)
            res['va'] = '%08X' % r['va']
            res['pct'] = r['pct']
            res['obj'] = str(op)
            results.append(res)
            if not a.quiet and res['verdict'] != 'CLEAN':
                print('%-12s %-28s %s %s' % (res['verdict'], unit, r['fn'], res['note']))
                for m in res['mismatches']:
                    print('    [%s] insn %d @ %s: retail %s ours %s' %
                          (m['kind'], m['idx'], m['va'], m['retail'], m['ours']))
                    print('        %s' % m['detail'])
                    print('        oracle: %s' % m['retail_txt'])
                    print('        ours  : %s' % m['ours_txt'])

    n = len(results)
    tally = {}
    for r in results:
        tally[r['verdict']] = tally.get(r['verdict'], 0) + 1
    print('\n=== strict-branch audit: %d functions, %d branch words compared ===' %
          (n, sum(r['branches'] for r in results)))
    for k in sorted(tally):
        print('  %-14s %d' % (k, tally[k]))
    if missing_objs:
        print('  (units with no object: %d) %s' %
              (len(missing_objs), ', '.join(missing_objs[:10])))
    if a.json:
        Path(a.json).write_text(json.dumps(results, indent=1), encoding='utf-8')
        print('  json -> %s' % a.json)
    return 1 if tally.get('MISMATCH-HIDDEN', 0) + tally.get('MISMATCH-VISIBLE', 0) else 0


if __name__ == '__main__':
    sys.exit(main())
