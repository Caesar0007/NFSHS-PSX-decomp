"""Insert CHECKPOINT 2026-09-20zb into the NFS4 memory hub (before the 2026-09-20za line)."""
P = 'C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/00_current_nfs4.md'
s = open(P, encoding='utf-8', errors='surrogateescape').read()
assert 'CHECKPOINT 2026-09-20zb' not in s
i = s.index('- CHECKPOINT 2026-09-20za ')
NEW = (
    "- CHECKPOINT 2026-09-20zb (USER: 'sweep for other oversized arrays whose extent crosses the next retail label, the same class as "
    "sndcents'): nfs4-decomp `main` = 491eb77c (LOCAL, NOT pushed; pushed = 4d4a4179). Honest link 297407/297407 = 0 diff, OVERLAP AUDIT "
    "0, FOREIGN LABELS 0/0, DROPPED 0, 'objects with text but NO base' 0 (was 1), link-stripped gate 81 listed / 0 violations (71 exact, "
    "10 open), PSYLINK 516/516 + 0 link errors + ONE drift point. 🆕 GATE tools/foreign_labels.py (run + printed by honest_measure.py, "
    "exit 1 on a hit): (a) every retail SYM label (kinds 2/6) inside a PLACED reconstructed input section must be a symbol THAT object "
    "defines at that address (function-statics compared by base name; allow-list = bigBuf @0x80010000, bigbuf.obj's view of the overlay "
    "load address); (b) no reconstructed section with bytes may sit in a catch-all (.rodata_rest/.data_rest/.sbss/.bss). First run = 22 "
    "labels + 6 stray sections, NO second sndcents-style array copy -- the class showed up as UNPLACED sections instead: (1) libgpu "
    "FONT.c .bss (0x4404, added with FntOpen) had no base -> catch-all over 19 retail labels; home = the one unclaimed .bss hole between "
    "fileroot.obj [311] and libcd C_011.obj [339], 0x4410 B = PsyQ 4.3 FONT.obj .bss size EXACTLY -> bss_extra row 0x80140454. (2) 🔴 "
    "`.rodata.strip` was NEVER discarded: gen_ld's `.rodata_rest { *(.rodata); *(.rodata.*) }` matched first (first statement wins) and "
    "linked the 3 pieces past the image end -> a separate /DISCARD/ for .text.strip/.rodata.strip/.bss.strip now precedes the catch-all. "
    "(3) stray .bss homed by link order + SDK sizes (new tools scratchpad/psyq_pipe/bss_holes.py = unclaimed .sbss/.bss holes with "
    "link-order brackets, sdk_bss.py LIB/MEMBER = SDK object section sizes + XBSS): copspeak Copspeak_gTimeString.308 @0x8013E0B0 (our "
    "static is numbered .106, so no name match); libapi PAD.obj .bss 0x10 = hole 0x80148AB4 (WAITRC2 488 .. libcard PATCH 508); "
    "CHCLRPAD.obj + libapi PATCH.obj .bss = the LAST 32 bytes of .bss 0x80148AE4 / 0x80148AF4 (link tail END, ssine, CHCLRPAD, PATCH, "
    "A21, A18, A19, A20) = PROOF that a fully link-stripped member keeps its .bss; CHCLRPAD's cell is 16 B (`long _chgclrpad_bss[4]`), "
    "not one long. (4) aih_btccop `static bool sayLose` (declared, never referenced): new LINK_STRIPPED_BSS tag (.bss.strip, discarded; "
    "psylink_lane skips it). EVIDENCE (stat_small.py): all 12 uninitialised function-statics with small-value STAT records have a retail "
    "`name.NN` label, sayLose alone has none. ⚠ CORRECTION of my first reading: the small STAT values ($0..$7f4, 50 names) are ordinary "
    "object-relative offsets -- 38 of them are INITIALISED statics, which never get a label -- NOT a sign of stripping. (5) `sndpe` "
    "@0x80136E00 was owned all along: sdfx.c carried it as the invented `snd_reverb_table` -> renamed to the retail name (sdfx = 374, "
    "in slot). (6) libc C52.c held an INVENTED `Libc_c52` nop @0x80106E0C (= the delay-slot nop of the function before EnableEvent; "
    "never referenced, unplaceable). PsyQ 4.3 libc C52.obj = `free` (A0:0x34 thunk), linked at index 433 then stripped (no `free` label, "
    "no A0:0x34 trampoline in the image) -> BIOS_THUNK_LINK_STRIPPED(free, 0xA0, 0x34), byte-exact. REMAINING unplaced .bss tails are SN "
    "section-size round-ups (FONT 0x4410 vs our 0x4404, C_011 0x10 vs stcdint's 4, PADMAIN/PADCMD 8+12, PATCHGTE 12), no labels inside. "
    "STILL UNOWNED .data label: identitymatrix 0x801237EC only (matrix.c has a `const` copy -> .rodata; slot SYS 268 .. TABLE 274, matrix "
    "= 270). Unowned zero bytes 0x80137254..60 (slot CTYPE0 389 .. asintbl 394). OPEN from za unchanged: iSNDplatformfree sdata vs "
    "sdasync; snddefaultenvelope stagpat vs sclcptch. PITFALL re-learned twice this pass: bash heredocs eat backslashes in regexes "
    "(a mangled grep produced a fully bogus 'NO RETAIL LABEL' list) -- Write tool for anything with a backslash.\n"
)
s = s[:i] + NEW + s[i:]
open(P, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(s)
print('ok')
