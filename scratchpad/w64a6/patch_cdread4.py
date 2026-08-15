import os

p = r'C:\Temp\nfs4-decomp\recon\syslib\psx\libcd\cdread.c'
d = open(p, 'rb').read()
NL = b"\n"

# ---- CdRead: W64 residual, appended inside the existing block comment -------------
old1 = b"     * before vs after the frame restores (`0 < _read_issue(0)` Yoda INERT at 16).\n"
assert d.count(old1) == 1, ("a1", d.count(old1))
add1 = NL.join([
b"     *",
b"     * W64-A6: 14 -> 5 (three levers, see the three in-body receipts).",
b"     * RESIDUAL 5, named + priced in THIS basin:",
b"     *  (c) the `jal CdSyncCallback` delay slot: retail carries the `sw $s4,0($s0)`",
b"     *      (w00 = sectors) store there; gcc's reorg REFUSES a volatile MEM (3.25-3c) so",
b"     *      the slot stays a nop, and every non-volatile-cast spelling that unblocks",
b"     *      reorg ALSO lets gcc re-order the w04/w00 store pair, which flips the s3/s4",
b"     *      parm homes and costs more than it saves.  MEASURED (all gated, all reverted):",
b"     *      w00 nonvol 16 @103 - w04 nonvol 10 @103 - both 10 @103 - w0c nonvol 10 @103 -",
b"     *      w00+w0c 10 @103 - source order swapped, both nonvol 14 @103 - w00 vol first,",
b"     *      w04 nonvol 8 @103 - `e` declared NON-volatile throughout 15 @102 - w00 via a",
b"     *      `(char *)e + 0` cast 16 @103.  A void barrier BETWEEN the two stores preserves",
b"     *      the order but IS the reorg barrier (stop_search_p), so the slot stays empty",
b"     *      (7 = inert) -- the two requirements are mutually exclusive with any asm.",
b"     *      ORCHESTRATOR CANDIDATE (15D TEXT_MOVES, one row): take the `sw $19,0($16)`",
b"     *      line into the following `jal`'s slot, drop_nop.  Semantically identical (the",
b"     *      slot executes before the call, exactly where the store already stands) --",
b"     *      objdump-verify per the _padInitDirSeq rule before wiring.",
b"     *  (d) `CdControlB(9,0,0)`'s 3rd argument: ours `addu $a2,$a1,$zero` (cse shares the",
b"     *      live zero), retail `addu $a2,$zero,$zero` -- the 11B cse-constant-sharing-",
b"     *      across-two-identical-literal-args class (identity fence is NOT the cure).",
b"     *      Re-measured INERT at 5 in this basin: `(u_char *)0` on both args, on the 3rd",
b"     *      only, two named null locals, and naming CdStatus's result; a void barrier",
b"     *      before the call costs an instruction (6 @105).",
b"     * The fence-POSITION axis stays closed (w63 sweep) and no rung beats the wired lane.",
b""])
d = d.replace(old1, old1 + add1, 1)

# ---- _read_issue: fence-removal axis ---------------------------------------------
old2 = b" * 3. two more void barriers, position-swept"
assert d.count(old2) <= 1
old3 = b"extern int _read_issue(int retry)\n"
assert d.count(old3) == 1, ("a3", d.count(old3))
add3 = NL.join([
b"/* W64-A6: re-gated 8 @122/122 (count-EXACT).  The FENCE-REMOVAL axis is closed: every",
b" * one of w63's landed devices is load-bearing -- dropping the pre-anchor void barrier 9",
b" * @121, the post-CdFlush barrier 9 @121, the `mp` identity fence 15 @121, the in-arm",
b" * barrier 11 @121, the error-label barrier 11 @121, the tail `g` identity fence 14 @122.",
b" * Residual 8 = (a) `CdControl(9,0,0)`'s 3rd arg, the same 11B cse-shared-live-zero class",
b" * as CdRead's (2 diffs), and (b) the CdControlF(6,0) region where retail DUPLICATES its",
b" * `li $a0,6` into the preceding `beqz` delay slot (a reorg eager-steal duplicate) and",
b" * carries `lw $v0,4($s0)` in the call's own slot, where ours fills the beqz slot by the",
b" * simple backward scan and nops the call slot (6 diffs).  Per 13B a fence can only BLOCK",
b" * a steal, never supply one, so this half needs a filler hoisted into reorg's scan range",
b" * or a TEXT_MOVES row, not another barrier. */",
b""])
d = d.replace(old3, add3 + old3, 1)

tmp = p + '.tmp'
open(tmp, 'wb').write(d)
assert os.path.getsize(tmp) > 100
os.replace(tmp, p)
b = open(p, 'rb').read()
print('ok CR', b.count(13), 'NUL', b.count(0), 'size', len(b))
