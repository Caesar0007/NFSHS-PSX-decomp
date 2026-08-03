#!/usr/bin/env python
"""w47-a6: ASPSX-2.77 `.set reorder` EMULATION over a cc1 .s file (probe only).

WHY.  methodology 3.25 axis 3b + the w34-a9 receipt in recon/eaclib/psx/spchpsxz/
spchinit.c say the same thing from two directions: our pipeline is
    cc1 -> maspsx -> GNU as
and maspsx does NOT implement the *scheduling* half of ASPSX's `.set reorder`
mode.  Where gcc leaves a branch delay slot empty (reorder mode) or leaves a
`#nop` load-delay PLACEHOLDER for the assembler, ASPSX 2.77 **schedules**
(fills the slot from a preceding independent instruction / hoists the load),
while maspsx **inserts a nop**.  That difference is the entire residual of a
documented floor class (the ~25-fn syslib "epilogue swap", pad.obj, SPCH_Init).

This module is a MEASUREMENT INSTRUMENT, not a build change: it rewrites the
cc1 .s in place before maspsx sees it, so we can measure how much of the
residual is exactly this and nothing else.  It deliberately implements only
the two ASPSX behaviours the retail bytes prove:

  RULE 1 (branch/jal delay-slot fill).  For a branch or jump emitted in
    `.set reorder` mode, search BACKWARD inside the same basic block for the
    nearest single-machine-instruction that can legally sink to just after the
    branch; wrap the pair in gcc's own `.set noreorder/.set nomacro` bracket.
    Multi-instruction assembler MACROS (la / symbolic lw,sw / big li) are
    skipped, never split -- proven by padinit, where ASPSX skipped
    `la $4,PAD_update` and reached back one further for `sw $2,0($16)`.

  RULE 2 (`#nop` load-delay resolution by HOISTING).  gcc writes the literal
    text `#nop` when it wants the ASSEMBLER to resolve a load-use hazard.
    ASPSX resolves it by hoisting the LOAD as early as dependences allow
    (blocked by any def of the loaded register -- e.g. a `jal`, which defines
    $31).  Proven by SPCH_Init: retail's `lw $ra,0x10($sp)` sits immediately
    after the last `jal`, three instructions above where gcc emitted it.

usage:  python scratch/w47_a6_aspsxreorder.py <file.s>          (rewrite in place)
        python scratch/w47_a6_aspsxreorder.py <file.s> --stdout (print)
as a library:  from w47_a6_aspsxreorder import reorder_text
"""
import os
import re
import sys

# --- instruction classification -------------------------------------------
BRANCH = {
    'b', 'bal', 'beq', 'bne', 'beqz', 'bnez', 'blez', 'bgtz', 'bltz', 'bgez',
    'bgezal', 'bltzal', 'bge', 'bgt', 'ble', 'blt', 'bgeu', 'bgtu', 'bleu',
    'bltu', 'j', 'jal', 'jr', 'jalr',
}
# single-machine-instruction ops that may sink into a delay slot
SIMPLE = {
    'addu', 'subu', 'addiu', 'and', 'andi', 'or', 'ori', 'xor', 'xori', 'nor',
    'sll', 'srl', 'sra', 'sllv', 'srlv', 'srav', 'slt', 'sltu', 'slti',
    'sltiu', 'move', 'negu', 'mfhi', 'mflo', 'mthi', 'mtlo', 'lui',
    'lw', 'lb', 'lbu', 'lh', 'lhu', 'sw', 'sb', 'sh', 'lwl', 'lwr', 'swl',
    'swr', 'li', 'mult', 'multu',
}
STORES = {'sw', 'sb', 'sh', 'swl', 'swr'}
LOADS = {'lw', 'lb', 'lbu', 'lh', 'lhu', 'lwl', 'lwr'}

REG = re.compile(r'\$(?:[a-z0-9]+)')


def _split_ops(rest):
    # strip trailing gcc comment (`# high`, `# 0x...`)
    rest = rest.split('#')[0]
    return [o.strip() for o in rest.split(',') if o.strip()]


def _regs(op):
    return set(REG.findall(op))


class Ins(object):
    __slots__ = ('idx', 'mn', 'ops', 'text', 'defs', 'uses', 'simple', 'macro')

    def __init__(self, idx, mn, ops, text):
        self.idx = idx
        self.mn = mn
        self.ops = ops
        self.text = text
        self.macro = False
        self.simple = mn in SIMPLE
        d, u = set(), set()
        if mn in BRANCH:
            for o in ops:
                u |= _regs(o)
            if mn in ('jal', 'jalr', 'bal', 'bgezal', 'bltzal'):
                d.add('$31')
        elif mn in STORES:
            for o in ops:
                u |= _regs(o)
        elif mn in ('mult', 'multu', 'div', 'divu'):
            for o in ops:
                u |= _regs(o)
            d |= {'$hi', '$lo'}
        elif mn in ('mfhi', 'mflo'):
            d |= _regs(ops[0]) if ops else set()
            u |= {'$hi', '$lo'}
        elif ops:
            d |= _regs(ops[0])
            for o in ops[1:]:
                u |= _regs(o)
            # `lw $2,4($3)` -- the base inside the first operand's parens is a USE
            if mn in LOADS and len(ops) >= 2:
                u |= _regs(ops[1])
        self.defs = d
        self.uses = u
        # assembler MACRO detection: an operand naming a symbol (not a plain
        # register / numeric literal / numeric displacement) expands to more
        # than one machine instruction -> ASPSX never splits it into a slot.
        for o in ops:
            body = o.split('#')[0].strip()
            if '%hi' in body or '%lo' in body or '%gp_rel' in body:
                self.macro = True
            else:
                # strip registers AND numeric literals (0x.. / decimal) before
                # looking for a SYMBOL name -- a hex immediate like 0xffff is
                # not a symbol (this bit once: `andi $2,$2,0xffff` was wrongly
                # classed as a multi-instruction macro and never sank).
                body = re.sub(r'\$[a-z0-9]+', '', body)
                body = re.sub(r'0[xX][0-9a-fA-F]+', '', body)
                body = re.sub(r'-?\d+', '', body)
                if re.search(r'[A-Za-z_.][A-Za-z_0-9.]*', body):
                    self.macro = True
        if mn == 'li' and ops:
            try:
                v = int(ops[-1], 0)
                if not (-32768 <= v <= 65535):
                    self.macro = True
            except ValueError:
                self.macro = True
        if mn == 'la':
            self.macro = True


INSN_RE = re.compile(r'^\s+([a-z][a-z0-9._]*)(?:\s+(.*))?$')


def _parse(lines):
    """Return a list of records: (kind, text, Ins|None). kind in
    label/insn/dir/other."""
    out = []
    for i, ln in enumerate(lines):
        s = ln.rstrip('\n')
        st = s.strip()
        if not st:
            out.append(('blank', s, None))
        elif st.startswith('#'):
            out.append(('hash', s, None))
        elif re.match(r'^[A-Za-z_$.][\w$.]*:', st):
            out.append(('label', s, None))
        elif st.startswith('.'):
            out.append(('dir', s, None))
        else:
            m = INSN_RE.match(s)
            if not m:
                out.append(('other', s, None))
                continue
            mn = m.group(1)
            ops = _split_ops(m.group(2) or '')
            out.append(('insn', s, Ins(i, mn, ops, s)))
    return out


def _noreorder_map(recs):
    """index -> True when that record sits inside a gcc `.set noreorder`."""
    st = False
    flags = []
    for kind, text, _ in recs:
        t = ' '.join(text.split())
        if kind == 'dir' and t.startswith('.set'):
            if t == '.set noreorder':
                st = True
            elif t == '.set reorder':
                st = False
        flags.append(st)
    return flags


def _can_sink(recs, j, i):
    """Can the instruction at record j sink to just after the branch at i?"""
    a = recs[j][2]
    if a is None or not a.simple or a.macro:
        return False
    # ASPSX never sinks an instruction that redefines the STACK POINTER into a
    # delay slot (assembler-side conservatism about the frame being live in the
    # slot).  PROVEN by pad.obj: gcc leaves `addu $sp,$sp,24 / j $31` in reorder
    # mode and retail keeps exactly that order with a `nop` in the slot, even
    # though the sp-adjust was a legal filler -- which is also precisely the
    # shape gcc's OWN delayed-branch pass produces when it is enabled.
    if a.defs & {'$sp', '$29', '$gp', '$28'}:
        return False
    br = recs[i][2]
    # the branch must not read anything the candidate defines
    if a.defs & br.uses:
        return False
    if a.defs & br.defs:
        return False
    for k in range(j + 1, i):
        kind, _t, b = recs[k]
        if kind == 'label':
            return False
        if b is None:
            continue
        if b.mn in BRANCH:
            return False
        if a.defs & (b.defs | b.uses):
            return False
        if b.defs & a.uses:
            return False
        # be conservative about memory: never move a store past a load/store
        if (a.mn in STORES or a.mn in LOADS) and (b.mn in STORES or b.mn in LOADS):
            return False
    return True


def _is_pair_tail(recs, k):
    """True when recs[k] is the SECOND half of a lui/li + ori/addiu 32-bit
    constant (or address) materialisation -- `ori $3,$3,LO` under `li $3,HI`."""
    b = recs[k][2]
    if b is None or b.mn not in ('ori', 'addiu') or len(b.ops) < 2:
        return False
    if b.ops[0] != b.ops[1]:
        return False
    j = k - 1
    while j >= 0 and recs[j][0] != 'insn':
        j -= 1
    if j < 0:
        return False
    a = recs[j][2]
    return a.mn in ('lui', 'li') and a.ops and a.ops[0] == b.ops[0]


def _block_start(recs, i, nore):
    k = i - 1
    while k >= 0:
        kind, _t, b = recs[k]
        if kind == 'label':
            return k + 1
        if b is not None and b.mn in BRANCH:
            return k + 1
        k -= 1
    return 0


def reorder_text(text):
    lines = text.split('\n')
    recs = _parse(lines)
    nore = _noreorder_map(recs)

    # ---- RULE 1: fill empty branch delay slots in reorder mode -----------
    filled = 0
    i = 0
    while i < len(recs):
        kind, _t, ins = recs[i]
        if kind == 'insn' and ins.mn in BRANCH and not nore[i]:
            lo = _block_start(recs, i, nore)
            cand = None
            for j in range(i - 1, lo - 1, -1):
                if recs[j][0] != 'insn':
                    continue
                if nore[j]:
                    break
                if _can_sink(recs, j, i):
                    cand = j
                    break
                # a non-sinkable MACRO is skipped over (ASPSX reaches past it);
                # anything else that blocks for dependence reasons stops us
                if recs[j][2] is not None and recs[j][2].macro:
                    continue
            fwd = None
            if cand is None and ins.mn not in ('jal', 'jalr', 'jr', 'bal',
                                               'bgezal', 'bltzal'):
                # RULE 1b -- FORWARD fill.  ASPSX also sinks the instruction
                # that FOLLOWS a conditional branch / plain `j` into its slot
                # when that instruction is a single machine insn (never half of
                # an assembler macro) and does not feed the branch.  It is safe
                # only when the moved value is dead on the taken path, which a
                # whole-file assembler can determine; CALLS are excluded (an
                # argument register moved before a `jal` would be visible to the
                # callee -- and retail indeed leaves those slots `nop`, e.g.
                # padinit's `jal PadStartCom`).  PROVEN by PAD_state, whose two
                # `beqz` slots hold the FOLLOWING `sltiu`/`sll`.
                for q in range(i + 1, len(recs)):
                    if recs[q][0] in ('blank', 'hash', 'dir'):
                        continue
                    if recs[q][0] != 'insn':
                        break
                    b = recs[q][2]
                    if b.simple and not b.macro and b.mn not in BRANCH \
                            and not (b.defs & {'$sp', '$29', '$gp', '$28', '$31'}):
                        fwd = q
                    break
            if cand is None and fwd is not None:
                moved = recs[fwd]
                brec = recs[i]
                del recs[fwd]
                new = [('dir', '\t.set\tnoreorder', None),
                       ('dir', '\t.set\tnomacro', None),
                       brec,
                       moved,
                       ('dir', '\t.set\tmacro', None),
                       ('dir', '\t.set\treorder', None)]
                recs[i:i + 1] = new
                nore = _noreorder_map(recs)
                filled += 1
                i += len(new)
                continue
            if cand is not None:
                moved = recs[cand]
                brec = recs[i]
                del recs[cand]
                i -= 1
                new = [('dir', '\t.set\tnoreorder', None),
                       ('dir', '\t.set\tnomacro', None),
                       brec,
                       moved,
                       ('dir', '\t.set\tmacro', None),
                       ('dir', '\t.set\treorder', None)]
                recs[i:i + 1] = new
                nore = _noreorder_map(recs)
                filled += 1
                i += len(new)
                continue
        i += 1

    # ---- RULE 2: resolve `#nop` load-delay placeholders by HOISTING ------
    hoisted = 0
    i = 0
    while i < len(recs):
        kind, text_i, _ = recs[i]
        if kind == 'hash' and text_i.strip() == '#nop':
            # the load whose delay this covers is the nearest preceding insn
            j = i - 1
            while j >= 0 and recs[j][0] != 'insn':
                j -= 1
            # ...but only when the hazard is REAL: gcc plants `#nop` pessimistically,
            # and the very next instruction is usually an independent filler already
            # (pad.obj's epilogue `lw $16,16($sp) / #nop / addu $sp,$sp,24`).  ASPSX
            # only reschedules when the following instruction actually USES the
            # loaded register (SPCH_Init: `lw $31 / #nop / j $31`).
            nxt = None
            for q in range(i + 1, len(recs)):
                if recs[q][0] == 'insn':
                    nxt = recs[q][2]
                    break
            # SCOPE (evidence-bounded): only the EPILOGUE `$ra` restore is
            # rescheduled.  padinit FALSIFIES a general load hoist -- retail
            # keeps `lw $v0,0($s0) / nop / bnez $v0` even though the preceding
            # `sw $ra,0x14($sp)` was a legal thing to hoist over.  SPCH_Init is
            # the positive case: `lw $ra,0x10($sp)` moved three instructions up.
            if j >= 0 and recs[j][2].mn in LOADS and nxt is not None \
                    and (nxt.uses & recs[j][2].defs) \
                    and recs[j][2].defs == {'$31'} and nxt.mn in ('j', 'jr'):
                ld = recs[j][2]
                lo = _block_start(recs, j, nore)
                dest = j
                k = j - 1
                while k >= lo:
                    kind2, _t2, b = recs[k]
                    if kind2 == 'label':
                        break
                    if b is None:
                        k -= 1
                        continue
                    if b.mn in BRANCH:
                        break
                    if (b.defs & (ld.defs | ld.uses)) or (b.uses & ld.defs):
                        break
                    # memory disambiguation: ASPSX sees the whole file, so a
                    # frame load ($sp-based) freely crosses a store through a
                    # DIFFERENT base register (SPCH_Init hoists `lw $ra,16($sp)`
                    # over the `sw $v1,%lo(gSPCH_Initialized)($v0)`).  Only a
                    # same-base store blocks.
                    if b.mn in STORES and (b.uses & ld.uses):
                        break
                    # a 32-bit constant / address built as lui+ori (or lui+addiu)
                    # is ONE unit to the assembler: never hoist above (or into) it.
                    if _is_pair_tail(recs, k):
                        break
                    dest = k
                    k -= 1
                if dest != j:
                    rec = recs[j]
                    del recs[j]
                    del recs[i - 1]          # the `#nop` (indices shifted by 1)
                    recs.insert(dest, rec)
                    nore = _noreorder_map(recs)
                    hoisted += 1
                    continue
        i += 1

    sys.stderr.write('[aspsxreorder] slots filled=%d loads hoisted=%d%s'
                     % (filled, hoisted, os.linesep))
    return '\n'.join(t for _k, t, _n in recs)


def main():
    path = sys.argv[1]
    with open(path, 'r', encoding='utf-8', newline='') as fh:
        src = fh.read()
    out = reorder_text(src)
    if '--stdout' in sys.argv:
        sys.stdout.write(out)
    else:
        with open(path, 'w', encoding='utf-8', newline='') as fh:
            fh.write(out)


if __name__ == '__main__':
    main()
