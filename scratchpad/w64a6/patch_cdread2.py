import os

p = r'C:\Temp\nfs4-decomp\recon\syslib\psx\libcd\cdread.c'
d = open(p, 'rb').read()
NL = b"\n"

# ---- CdRead: replace the stale "RESIDUAL 16, named" tail with the W64 residual ------
old1 = b"     * before vs after the frame restores (`0 < _read_issue(0)` Yoda INERT at 16).\n"
assert d.count(old1) == 1, ("a1", d.count(old1))
add1 = NL.join([
b"     *",
b"     * W64-A6: 14 -> 5 (three levers, see the commit and the three in-body receipts).",
b"     * RESIDUAL 5, named + priced in THIS basin:",
b"     *  (c) the `jal CdSyncCallback` delay slot: retail carries the `sw $s4,0($s0)`",
b"     *      (w00 = sectors) store there; gcc's reorg REFUSES a volatile MEM (3.25-3c) so",
b"     *      the slot stays a nop, and every non-volatile-cast spelling that unblocks reorg",
b"     *      ALSO lets gcc re-order the w04/w00 store pair, which flips the s3/s4 parm",
b"     *      homes and costs more than it saves.  MEASURED (all gated, all reverted):",
b"     *      w00 nonvol 16 @103 - w04 nonvol 10 @103 - both 10 @103 - w0c nonvol 10 @103 -",
b"     *      w00+w0c 10 @103 - source order swapped, both nonvol 14 @103 - w00 vol first,",
b"     *      w04 nonvol 8 @103 - `e` declared NON-volatile throughout 15 @102 - w00 via a",
b"     *      `(char*)e + 0` cast 16 @103.  A void barrier BETWEEN the two stores preserves",
b"     *      the order but IS the reorg barrier (stop_search_p), so the slot stays empty",
b"     *      (7, i.e. inert) -- the two requirements are mutually exclusive with any asm.",
b"     *      ORCHESTRATOR CANDIDATE (15D TEXT_MOVES, 1 row): take the `sw $19,0($16)` line",
b"     *      and slot it into the following `jal`, drop_nop.  Semantically identical (the",
b"     *      slot executes before the call, exactly where the store already is) -- verify",
b"     *      via objdump per the _padInitDirSeq rule before wiring.",
b"     *  (d) `CdControlB(9,0,0)`'s 3rd argument: ours `addu $a2,$a1,$zero` (cse shares the",
b"     *      live zero), retail `addu $a2,$zero,$zero`.  This is the 11B cse-constant-",
b"     *      sharing-across-two-identical-literal-args class (identity fence is NOT the",
b"     *      cure).  Re-measured INERT at 5 in this basin: `(u_char *)0` on both args, on",
b"     *      the 3rd arg only, two named null locals, and naming CdStatus's result; a void",
b"     *      barrier before the call costs an instruction (6 @105).",
b"     * The fence-POSITION axis stays closed (w63 sweep) and no rung beats the wired lane. */",
b""])
d = d.replace(old1, old1 + add1, 1)

# ---- _read_int: fence-removal axis ------------------------------------------------
old2 = (b"     * cast is FALSIFIED at this site, see the in-body note), and the `beqz $v1` slot where\n"
        b"     * retail carries `li $v0,1`. */\n")
assert d.count(old2) == 1, ("a2", d.count(old2))
add2 = NL.join([
b"     * W64-A6: re-gated 15 @158/157 and the FENCE-REMOVAL axis is now closed too (the",
b"     * w64 CdRead lesson -- an inherited fence can itself be the blocker -- does NOT",
b"     * apply here): dropping the `exp` fence 24 @157, the DMA-arm `cur` fence 17, the",
b"     * PIO-arm `cur` fence 37 @160, ALL FOUR 48 @159.  Only the trailing `g` fence in the",
b"     * PIO arm is INERT (15) -- kept as documentation of the derived-view shape.",
b"     * Per-fn `-mno-split-addresses` (the mechanism that seals CdRead) is decisively",
b"     * WRONG here: 47 @162 (and _read_issue 32 @126, _read_data_int PASS->3,",
b"     * CdReadSync PASS->2), so the two split `lui/addiu` pairs are not reachable that way. */",
b""])
d = d.replace(old2, old2 + add2, 1)

tmp = p + '.tmp'
open(tmp, 'wb').write(d)
assert os.path.getsize(tmp) > 100
os.replace(tmp, p)
b = open(p, 'rb').read()
print('ok CR', b.count(13), 'NUL', b.count(0), 'size', len(b))
