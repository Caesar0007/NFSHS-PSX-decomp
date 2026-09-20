"""Insert CHECKPOINT 2026-09-20za into the NFS4 memory hub (before the 2026-09-20z line)."""
P = 'C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/00_current_nfs4.md'
s = open(P, encoding='utf-8', errors='surrogateescape').read()
assert 'CHECKPOINT 2026-09-20za' not in s
i = s.index('- CHECKPOINT 2026-09-20z ')
NEW = (
    "- CHECKPOINT 2026-09-20za (USER: 'fix three link-order misattributions'): nfs4-decomp `main` = e59590e4 (LOCAL, NOT pushed; "
    "pushed = 4d4a4179), honest link 297407/297407 = 0 diff, OVERLAP AUDIT 0, DROPPED 0, link-stripped gate 80 listed / 0 violations, "
    "PSYLINK lane 516/516 + 0 link errors + still ONE drift point (Stats_TrackEndGame). VERDICTS on the three outliers I had listed: "
    "(1) `seedX` was CORRECT (spchrand 260 follows fixdsqrt.obj's table, index 252) -- the LIS tie-break blamed the wrong row; the real "
    "defect was `tmrsub[8]` 0x8012360C owned by addtimer.obj (250) while sitting after index 260 -> moved to vars.obj (267) together "
    "with the previously UNOWNED vbltmrsub[8] 0x8012362C (PC build: tmrsub was a STATIC of inittmr.obj; on PSX addtimer.obj + "
    "inittmr.obj both use it => library global in vars). (2) `sndgs` .bss 0x80147860 (slot callback 361 .. salloc 369) moved from "
    "ssysinit.c (285) to sdata.c = sndpsxz sdata.obj (365), EA's sound DATA module (NFS2-PC sdata.obj = 20 data globals, 0 functions). "
    "OPEN: slot 365..366 cannot tell whether iSNDplatformfree is sdata.obj's or the lone survivor of sdasync.obj (then sdasync is NOT "
    "fully stripped) -- left in sdata.c, noted in its header. (3) libpad `_padFunc*`/_waitTime rows = FALSE ALARM: a STALE "
    "build/recon/syslib/psx/libpad/PAD.c.o (source deleted long ago) shadowed PADMAIN.c.o in the nm scan; deleted the stale objects, "
    "linkorder_outliers.py now ignores build objects without a recon source and reports owners that are NOT retail module names. "
    "THAT report exposed more of the same class, all fixed: snddata.c (not a retail module) DISSOLVED -- sndseed -> srandom.c (484), "
    "sndpsxlimits[5] -> slimits.c (237; needs an explicit data_extra.json row, `vas` has no entry), key-group counter DAT_801371cc + "
    "previously UNOWNED snddefaultenvelope[8] 0x801371C4 -> stagpat.c (379; envelope could equally be sclcptch 378 -- user = owner "
    "heuristic). stagpat.c now builds g_value 0 (sndpsxz has zero %gp_rel sites) which RETIRES its five-byte extern-view device, "
    "still byte-exact. sclcptch.c `sndcents[512]` carried a COPY of snddefaultenvelope + counter + libc _ctype_ + 12 unowned bytes "
    "(byte-identical, so neither honest_measure nor the overlap audit could object) -> real size 256. snddata.c's .sdata alignment "
    "tail had been 'covering' savegp.obj's word 0x801234E8 -> savegp.c owns it now (g_value 0, `.text` added at the head of its asm "
    "block because the C data definition leaves the assembler in .data). LESSON: a byte-identical COPY of a neighbour's data inside an "
    "oversized array is invisible to every byte gate -- only the link-order/label census sees it; candidates to sweep next = any recon "
    "array whose extent crosses the NEXT retail label (tool idea: compare each defined symbol's size with the distance to the next "
    "SYM label). New tools in scratchpad/psyq_pipe: linkorder_window.py LO HI, linkorder_slot.py LOIDX HIIDX, honest_diffs.py (lists "
    "the differing words of the honest link), blob_only_ranges.py [LO HI], own_by_linkorder4.py. linkorder_outliers.py = 0 real "
    "outliers in all six data sections (+5 same-named C statics: requestidcounter nasync/stream, tvOrder, gSwapFileName -- not "
    "decidable by name). Blob-only 3226 B. STILL UNOWNED .data labels: identitymatrix 0x801237EC (matrix.c has a `const` copy -> "
    ".rodata; slot SYS 268 .. TABLE 274, matrix = 270: make it non-const .data), sndpe 0x80136E00 660 B (slot slib 372 .. sfxlevel "
    "375: sdriver/sdfx/sfxlevel). Newly visible unowned bytes: 0x80137254..60 (12 zero bytes between _ctype_ and asintbl; slot "
    "CTYPE0 389 .. asintbl 394), 0x801371CD..D0 (3 pad bytes after stagpat's counter). Non-module file names still to rename: libcd "
    "drv.c (= BIOS.obj), stcdint.c (= C_011.obj), cdcont.c (= libcd SYS.obj). Untracked strays in the repo root/tools NOT mine to "
    "judge: `-G0`, cta00148/280/308, tools/_weather.py, tools/*.py.bak.\n"
)
s = s[:i] + NEW + s[i:]
open(P, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(s)
print('ok')
