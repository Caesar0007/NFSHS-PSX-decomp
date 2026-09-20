"""Insert CHECKPOINT 2026-09-20m into the NFS4 memory hub (after the CI FIX line)."""
P = 'C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/00_current_nfs4.md'
s = open(P, encoding='utf-8', errors='surrogateescape').read()
assert 'CHECKPOINT 2026-09-20m' not in s
i = s.index('- CI FIX 2026-09-20')
j = s.index(chr(10), i) + 1
NEW = (
    "- CHECKPOINT 2026-09-20m (USER CORRECTION: 'spchdata.obj is canonical and listed in SYM' + 'check SYM for other data and "
    "declaration only .obj, e.g. chunkvis.obj and vars.obj'): nfs4-decomp `main` = af86ddda (LOCAL, 2 commits ahead of pushed "
    "4d4a4179), honest link 297399/297399 = 0 diff, DROPPED 0, blob-only 3242 B (was 3298). 🔴 RULE: a module named by a SYM FILE "
    "record is CANONICAL -- never delete its TU; when its supposed functions turn out to be another object's statics, find what it "
    "REALLY contributes. 🔑 LAW (data ownership): PSYLINK lays every data section out PER OBJECT IN LINK ORDER = SYM FILE-record "
    "order (library modules included; their FILE records carry no contents, only the order). So an unowned data label is "
    "bracketed by its owned neighbours' link indices -> tool scratchpad/psyq_pipe/data_owner_by_linkorder.py [section]; "
    "sym_obj_census.py lists function-less SYM objects (game: DATA-ONLY / DECLARATION-ONLY from debug records; library modules: "
    "names with no recon TU). RESULTS: (1) spchdata.obj = the speech library's DATA module: the 12 initialised globals "
    "gSampleRequest..gCDErrors 0x80137094..0x801370C4 are contiguous in its slot (376, before sclcptch.obj's sndcents) -- moved out "
    "of their USERS spchinit.c/spchbank.c (my 2026-09-19 attribution by user was wrong) into recon/eaclib/psx/spchpsxz/spchdata.c; "
    "data_extra.json rows merged; the six Vox accessors stay static in spchpick.c. (2) vars.obj (267) also owns the head cells "
    "library=4, disablecd=1, currentfilesystem, availablefilesystems 0x8013DC54..64 (gate row in tools/source_data_owners.py now "
    "0x8013DC54/176 B). (3) textfor.obj (317): textntabstops, texttabstops, showmissingcharacters 0x8013DD50..5C. (4) callback.obj "
    "(361): loadfilecallback 0x8013DD60 (the only cell between threads.obj 360 and window.obj 404). (5) NEW data-only TUs window.c "
    "(404: videopages, videopage, windowpage) and pageflip.c (491: gpusetdispenv, vblsetdispenv, vsdeferred = the last .sdata "
    "cells). Raw cells survive as asm/data/sdata_{textfor,callback,window,pageflip}_legacy.sdata.s + the vars legacy head, linked "
    "by linkers/nfs4.ld only; r24 piece deleted; each owner has a payload gate (SOURCE_DATA_OWNERS). C lane default is -G4, so "
    "`int x = 0;` lands in .sdata (this nm prints D/b for small sections too -- check with objdump -t). GAME function-less objects: "
    "all have TUs and own their data (FEI, aidebug, DrawDbg, FEColor) except bigbuf.obj, address.obj and syslib 2mbyte.obj (no TU; "
    "2mbyte = _stacksize/_ramsize 0x80136CD0/D4 candidates). LIBRARY modules with NO recon TU: libcd C_011, sndpsxz sdasync, "
    "eacpsxz unitvect / textsubs / hypot3d / hypot, libgpu P26 / P20, libapi CHCLRPAD / A21 / A18 / A19 / A20. STILL UNOWNED .data "
    "labels with brackets: vbltmrsub 0x8012362C (250..268: addtimer first), identitymatrix 0x801237EC (268..274: matrix), sndpe "
    "0x80136E00 (372..376: slib/sdriver/sdfx/sfxlevel), snddefaultenvelope 0x801371C4 (378..389). The `.NN`-suffixed labels the "
    "tool prints for .sbss/.bss are function-statics whose numeric suffix differs from ours (noise).\n")
s = s[:j] + NEW + s[j:]
open(P, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(s)
print('ok')
