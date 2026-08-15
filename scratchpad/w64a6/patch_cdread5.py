import os

p = r'C:\Temp\nfs4-decomp\recon\syslib\psx\libcd\cdread.c'
d = open(p, 'rb').read()
NL = b"\n"

old = (b"     *      ORCHESTRATOR CANDIDATE (15D TEXT_MOVES, one row): take the `sw $19,0($16)`\n"
       b"     *      line into the following `jal`'s slot, drop_nop.  Semantically identical (the\n"
       b"     *      slot executes before the call, exactly where the store already stands) --\n"
       b"     *      objdump-verify per the _padInitDirSeq rule before wiring.\n")
assert d.count(old) == 1, ("a", d.count(old))
new = NL.join([
b"     *      ORCHESTRATOR ROW, DERIVED AND PROVEN (15D TEXT_MOVES, one row -- the spec",
b"     *      lives in scratchpad/w64a6/tm_cdread.json, the objdump proof in RECEIPTS.md):",
b"     *          take  \\tsw\\t\\$20,0\\(\\$16\\)\\n(?=\\t#\\.set\\tnovolatile\\n\\tjal\\tCdSyncCallback\\n)",
b"     *          after \\tjal\\tCdSyncCallback\\n(?=\\tmove\\t\\$4,\\$0\\n)      slot: true",
b"     *      REGISTER RECONCILED against retail first: the store retail slots is the w00",
b"     *      one, `sw $s4,0($s0)` = `sw $20,0($16)` in our .s -- NOT `sw $19,4($16)`,",
b"     *      which is the w04 store ($19 = $s3 = buf, $20 = $s4 = sectors, $16 = $s0).",
b"     *      No drop_nop: our .s carries no nop there (maspsx materialises it in reorder",
b"     *      mode), and `slot: true`'s `.set noreorder` wrapper is what suppresses it.",
b"     *      The `after` lookahead is LOAD-BEARING: unpinned, `jal CdSyncCallback` matches",
b"     *      TWICE in this region and _apply_text_moves takes the FIRST -- the watchdog",
b"     *      arm's call, whose slot already holds `addu $16,$16,-40`.",
b"     *      MEASURED (vprobe W60_TEXT_MOVES_FILE, twice, whole TU): CdRead 5 -> 2",
b"     *      COUNT-EXACT 103/103; CdReadSync/_read_data_int/_read_sync stay PASS,",
b"     *      _read_int 15 and _read_issue 8 unchanged -> zero PASS->FAIL.",
b""])
d = d.replace(old, new, 1)

tmp = p + '.tmp'
open(tmp, 'wb').write(d)
assert os.path.getsize(tmp) > 100
os.replace(tmp, p)
b = open(p, 'rb').read()
print('ok CR', b.count(13), 'NUL', b.count(0), 'size', len(b))
