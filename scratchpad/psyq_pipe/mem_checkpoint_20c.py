"""Insert CHECKPOINT 2026-09-20c into the NFS4 memory hub (after the 2026-09-20b line)."""
P = 'C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/00_current_nfs4.md'
s = open(P, encoding='utf-8', errors='surrogateescape').read()
assert 'CHECKPOINT 2026-09-20c' not in s
i = s.index('- CHECKPOINT 2026-09-20b')
j = s.index(chr(10), i) + 1
NEW = (
    "- CHECKPOINT 2026-09-20c (real-virtuals 5/N MERGED): FE MENU FAMILY DONE -- nfs4-decomp `main` = c305985f, 0 diff after a FULL "
    "rebuild, ownership audit 3401 B; hand vtable files 40 -> 22 (all remaining = tScreen + tDialog), `_vf` occurrences 801 -> 456; "
    "branch wip/fevirt-tmenu is merged (fast-forward) and can be deleted; UNPUSHED on top of pushed 6871d324. What closed it: (1) "
    "fedialog's `this->ProcessInputVirtual` is the DIALOG's own facade (tScreen family) -- my blanket rename broke it; (2) slider ctor "
    "= `fFlags |= 0x80; fData = d; fFlags |= 0x80;` (the old order was an artefact of the hand-placed `_vf` store; cse does not merge "
    "the two ORs only because a store sits between them); (3) FEMenu.obj table order needs tMenu declared AFTER "
    "tMenuItemGoToMenuButton -> tMenu lives in fe_core_tmenu.h, included in place by fe_core_types.h unless "
    "NFS4_FE_CORE_TMENU_AFTER_ITEMS (femenu_types.h re-includes it after its item classes, with NFS4_FE_CORE_FEMENU_METHODS "
    "re-defined around it); (4) tInsideBoxSongMenu::Draw: natural `DrawOneSong(song,x,...)` call (the `* 0x10000 >> 0x10` hand "
    "conversions are the compiler's now) and `drawY = j * 0x15 - 0x28` AT ITS USE -- a GIV: loop.c emits hoisted invariants first, "
    "then giv initialisers in order of use, which is retail's [sll/sra][li -40][s0 init]; (5) rodata rows = base + built size for "
    "femenu 0x800110C8, femenuextended 0x80010610, femenuoptions 0x80010960, femenudefs 0x800114D8. 🔴 -fno-implement-inlines A/B "
    "(`NFS4_FE_NII=1 python tools/build.py --no-link`): NOT lane-wide -- femenuoptions + femenudefs NEED it (PER_TU_FLAGS, marked "
    "FEVIRT-NII-PROBE), femenuextended needs it OFF (its in-class inline virtual Draw__27tMenuItemGoToMenuNFS4Buttonb is not emitted "
    "under the flag because the class has a key function; the all-inline tBlank* classes' inlines ARE emitted under it) and feapp "
    "needs it OFF while the pragma carrier exists; every other FE object is indifferent. honest_measure's RECON count dips when "
    "object paths wrap in the map -- trust ownership_audit2.py. NEXT: tScreen + tDialog hierarchy (22 files: vtables_tscreen*, "
    "tscreen2*, tdialog*), owners fescreen/fedialog/feapp/screen*.cpp; roots in femenu_types.h/fescreen headers; expect the same "
    "workflow (fevirt_sites.py needs a SCREEN slot map: ~, GetShapeInfo, DrawBackground, DrawForeground [dtor at slot 4 in dialogs' "
    "tables -- check], PreLoad, Initialize, Cleanup, TransitionIsFinished, ProcessInput, CalculateDimensions, Draw); retiring "
    "fedialog_timeout_class.h's #pragma carrier is part of it.\n")
s = s[:j] + NEW + s[j:]
open(P, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(s)
print('ok')
