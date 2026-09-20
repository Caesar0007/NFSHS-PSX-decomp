"""Insert CHECKPOINT 2026-09-20l into the NFS4 memory hub (after the 2026-09-20k line)."""
P = 'C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/00_current_nfs4.md'
s = open(P, encoding='utf-8', errors='surrogateescape').read()
assert 'CHECKPOINT 2026-09-20l' not in s
i = s.index('- CHECKPOINT 2026-09-20k')
j = s.index(chr(10), i) + 1
NEW = (
    "- CHECKPOINT 2026-09-20l (USER: '57 symbols that retail has local and we export' -- 56/57 DONE): nfs4-decomp `main` = 8db8ee10 "
    "(wip/retail-statics fast-forwarded; UNPUSHED, 43 ahead of 6871d324), honest link 0 diff (297385/297385), DROPPED 0; PSYLINK "
    "lane rerun: linkage mismatches 104 -> 48 = the 47 compiler-build destructors (need cc1plus 2.8.1, USER DECISION pending) + "
    "Get__26AIDataRecord_CarTracking_ti; drift still the same 2 points. 🔑 LAW: SN SYM label kind 6 = C `static` (PROOF: retail has "
    "`locaterequest` TWICE -- nasync 0x800F0BF4 and stream 0x800FC4E4 -- and duplicate VoxSentence_GetNumPhrases / iSPCH_GetOffset8 / "
    "16 copies); local labels therefore also prove OBJECT BOUNDARIES (a static and its callers share one object). Lib module FILE "
    "records in the SYM are names in link order only, they carry no addresses. DONE: (1) static_fix1.py -- 43 EA-library functions "
    "(nsync 3, spchevnt 1, wildcard strrstr, syncfile 2, nfile 6, nasync 11, textfor 1, cdfs 4, stream 13, spchrule 1) got `static`; "
    "their prototypes left the headers and became a static forward-declaration block after the file's includes. (2) static_fix2.py -- "
    "memcpyl/memcpyb/refcpy moved from the end of unhuff.c to the TOP of unref.c (callers refcpy + unrefpack); chase moved from "
    "unref.c to unbtree.c; SQVclue/left/right/s/d are `static` in unbtree.c (local .sbss, still gp-relative), the tentative commons "
    "in unref.c are gone. (3) static_fix3.py -- spchdata.c/.h DELETED (an invented exporting file): its six Vox accessors "
    "(0x80100710..0x8010077C, only callers in spchpick) are static at the top of spchpick.c; build.py PER_TU row removed; "
    "spchdata.obj is still a retail link-order name with unknown real contents. (4) front_externs.h lost the stray externs of the "
    "already-static regularCopModels / superCopModels. CC1PSX does NOT drop unused static functions (test build/tmp/st.c), so the "
    "per-object copies are real per-file definitions, not a shared header of statics. OPEN: CarTracking (retail = all-inline class, "
    "local Get + local dtor + local UNREFERENCED table). FALSIFIED angles: code after `return` (dropped before expansion), local "
    "flag initialised right before the test (folded, nothing emitted), local flag across a loop (reference SURVIVES -> table emitted "
    "local with local Get/dtor in the right tail order, but StartUp1 grows 27 -> 42), unused inline function constructing it, dead "
    "`if (0) new` with an inline ctor. Working theory: emission of a local table needs a reference that reaches the assembler "
    "output, so retail's referencing code was output and is not in the image -- NEW ANGLE to try: a deferred out-of-line inline / a "
    "function in a discarded section. ALSO FALSIFIED: the 2.8.1 build behaves the same for `if (0) new` and the folded local flag "
    "(test build/tmp/kc.cpp: 0 table, 0 Get under both builds).\n")
s = s[:j] + NEW + s[j:]
open(P, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(s)
print('ok')
