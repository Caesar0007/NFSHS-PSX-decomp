"""Insert CHECKPOINT 2026-09-19p into the NFS4 memory hub (after the 2026-09-19o line)."""
P = 'C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/00_current_nfs4.md'
s = open(P, encoding='utf-8', errors='surrogateescape').read()
assert 'CHECKPOINT 2026-09-19p' not in s
i = s.index('- CHECKPOINT 2026-09-19o')
j = s.index(chr(10), i) + 1
NEW = (
    "- CHECKPOINT 2026-09-19p (USER: convert the hand-written vtables to real C++ virtuals -- 'FRONT-END REAL VIRTUALS' "
    "campaign STARTED): HEAD = dde52ddb (UNPUSHED on top of pushed 6871d324), honest 0 diff (297783/297783). 40 hand vtable "
    "files recon/game/common/vtables_*.cpp -> 38 left; 801 `_vf` occurrences in 80 files at start. UNIT OF WORK = A WHOLE "
    "HIERARCHY (a base with real virtuals forces every derived class over at once): tScreen (screens + dialogs, ~22 vtable "
    "files, most `_vf` sites; tDialog tables carry tScreen:: slots), tMenu (+ tPauseMenu, 12 files), tList (4 files); "
    "singletons DONE: (1) 2ee16b29 AIDataRecord family (scratchpad/psyq_pipe/fevirt_aidatarecord.py): classes declared in "
    "retail's reverse-vtable order (base, AccTable, BestLine, TrackCurve, CurveSpeedTable, CarTracking); derived dtors are "
    "compiler-SYNTHESIZED (no vptr store, no delete tail: declare NO dtor); an UNREFERENCED vtable in retail = the class has "
    "a KEY FUNCTION in that TU (CarTracking::Get out-of-line, last regular fn) -- a dead `if (0) new X` does NOT emit a "
    "vtable (the reference dies before final); other TUs' private struct copies keep the `_vf` data member (same layout, no "
    "dispatch) so the conversion stays local. (2) dde52ddb ObjectAnim family (fevirt_object.py): real inheritance replaces "
    "`_base_ObjectAnim` composition + extern-C dtor devices; five IN-CLASS inline dtors = deferred-inline tail in reverse "
    "order; base Draw pure (no key fn -> local table, matches SYM having `_vt.` only for the 4 derived); a user-written "
    "inline ctor in a key-function class gets an out-of-line copy -> Finished* declare NO ctor. 🔑 LAW: g++ 2.8 emits every "
    "vtable with `.align 3` (section-relative) -- the 4 zero bytes before object's tables are alignment (my `\"\"` carrier "
    "was WRONG: small literals go to .sdata at -G8 and tripped ld's `gVi` address ASSERT -- those asserts are a good net). "
    "🔴 STALE-OBJECT FINDING: object.cpp had NOT compiled since the AI refactor (object_types.h's private AIHigh_Traffic "
    "copy kept `AIHigh_Traffic() {}` while AIHigh_Base lost its default ctor); build.py --only leaves the old .o in place, "
    "so the honest link was measuring a stale object. Full `python tools/build.py --no-link` rebuild launched to find "
    "others (log build/full_rebuild_0919.log) -- CHECK ITS RESULT FIRST when resuming; after any shared-header change run a "
    "full rebuild, not --only. NEXT: tList hierarchy (4 files), then tMenu, then tScreen; the feapp `#pragma interface` "
    "carrier (fedialog_timeout_class.h) dies with the tScreen conversion.\n")
s = s[:j] + NEW + s[j:]
open(P, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(s)
print('ok')
