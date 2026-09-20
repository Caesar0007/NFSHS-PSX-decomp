"""Insert CHECKPOINT 2026-09-20e into the NFS4 memory hub (after the 2026-09-20d line)."""
P = 'C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/00_current_nfs4.md'
s = open(P, encoding='utf-8', errors='surrogateescape').read()
assert 'CHECKPOINT 2026-09-20e' not in s
i = s.index('- CHECKPOINT 2026-09-20d')
j = s.index(chr(10), i) + 1
NEW = (
    "- CHECKPOINT 2026-09-20e (🏆 REAL-VIRTUALS CAMPAIGN COMPLETE): nfs4-decomp `main` = 91b25b11, 0 diff after a FULL rebuild, "
    "ownership audit 3310 B unowned, 27 commits ahead of pushed 6871d324 (UNPUSHED). ALL 40 hand vtable files "
    "(recon/game/common/vtables_*.cpp) are GONE; no live `_vf` code is left in the front end (only comments + the POD layout copies "
    "in frontend/psx/mmeffect_types.h and game-side *_types.h that never dispatch). Branches wip/fevirt-tmenu and wip/fevirt-tscreen "
    "are merged (fast-forward) and can be deleted. tScreen + tDialog closing facts: (1) fedialog class order via guarded pieces "
    "fedialog_class_help.h / _backuponly.h / _noinput.h, pulled early by screendisplay_types.h under "
    "NFS4_SCREENDISPLAY_FEDIALOG_METHODS; (2) tDialogInteractive = all-inline class with an EXPLICIT inline ctor defined in "
    "fedialog.cpp after tDialogMessageString's (`timeOutTicks = 0; fCurrentlyRunning = 0;`), tDialogYesNo's body = ReturnValue, "
    "ReadyToReturnValue -- each inlined ctor level's statements sit between the vptr stores, which is what stops cse from folding "
    "repeated stores (the old volatile-cast hack is gone); offsets: ReadyToReturnValue +152, fCurrentlyRunning +156; (3) PER-TU "
    "-fno-implement-inlines now: femenuoptions, femenudefs, fedialog, screentracks (build.py PER_TU_FLAGS, FEVIRT-NII-PROBE marks); "
    "femenuextended and feapp need it OFF; (4) the feapp #pragma interface carrier + helper base are RETIRED "
    "(fedialog_timeout_class.h = plain all-inline class, inline ctor in feapp.cpp, synthesized dtor); (5) user-EMPTY inline dtors "
    "`~X() {}` in screen classes were part of the old asm-dtor hack: retail's are SYNTHESIZED (no vptr store) -> removed with the "
    "two __asm__ dtor blocks; (6) `obj.member.Virtual()` is a DIRECT call, `(&obj.member)->Virtual()` is dynamic; (7) SimpleMem heads "
    "when the first literal-bearing function is a LEAF or the literal is file-scope data: `static inline const char "
    "*SimpleMem_ClassName(void) { return \"SimpleMem\"; }` after the includes (unused inline: literal emitted, body dropped) -- used "
    "for screencontroller 0x80012040, screentrackrecords 0x80011FC8, screentrophyinfo 0x80011E78, all PROVEN by vtable `.align 3`; "
    "(8) tools: fndrift_all.py [substr] (every FE object vs retail, anchored on its first known function), vt_census.py, "
    "fevirt_rodata_rows.py [--apply] (row = [last retail table end - built .rodata size, end]; 19 owners, all bases agreed with the "
    "existing rows), fevirt_errs.py, fevirt_sites.py auto-menu|auto-screen, fevirt_basecalls.py. STILL OPEN (purity): "
    "Stats_TrackEndGame inline asm, `&&label` carriers in aih_cop + spchinit, 4 asm CERTIFICATES (asm/cert: _st_dma, FntFlush, "
    "MemCardFormat, MemCardGetDirentry), PSYLINK lane not rerun since the virtuals work, honest_measure.py wrapped-map-line gap, the "
    "`#define tPlayer int`-style owner-surface macros that remain in non-virtual contexts, stale 'manual _vf' comments.\n")
s = s[:j] + NEW + s[j:]
open(P, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(s)
print('ok')
