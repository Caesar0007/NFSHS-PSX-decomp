"""Insert CHECKPOINT 2026-09-20k into the NFS4 memory hub (after the 2026-09-20j line)."""
P = 'C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/00_current_nfs4.md'
s = open(P, encoding='utf-8', errors='surrogateescape').read()
assert 'CHECKPOINT 2026-09-20k' not in s
i = s.index('- CHECKPOINT 2026-09-20j')
j = s.index(chr(10), i) + 1
NEW = (
    "- CHECKPOINT 2026-09-20k (USER: 'PSYLINK rerun'): nfs4-decomp `main` = 3173bf53 (UNPUSHED, 40 ahead), honest GNU link 0 diff "
    "restored after the experiment below. PSYLINK LANE (scratchpad/psyq_pipe/psylink_lane.py, ~6 min, run it in background): ASPSX "
    "ok 507 bad 0, 513 objects, PSYLINK 0 error lines, 44 undefined all equ'd from the honest link, 0 unresolvable. drift.py = the "
    "SAME 2 points as 2026-09-19: .text +4 after Stats_TrackEndGame (inline asm) and .sdata +4 at aicop.obj (AICop_rawTriggers, "
    "section alignment). drift_vt.py (NEW): all 115 retail `_vt.*` labels exist in our SYM under the natural names (incl. "
    "Q26Speech*); rdata table drifts are negative steps (-48 tMenu, -16 tListIteratorTournament, -16 tScreenMain; .rdata -36 "
    "AccTable, -12 AIState_Cruise, -108 MobileSpeaker, -84 ObjectSignAnim, -12 tPMenu) = read-only bytes our objects do not own in "
    "this lane -- NOT yet analysed. 🔑 NEW CHECK sym_linkage.py: SN SYM label kind 2 = global, 6 = local (retail `Def class "
    "EXT/STAT` agrees). 104 mismatches: (A) 47 = compiler-SYNTHESIZED virtual destructors of key-function classes (tDialog*, "
    "tScreen*, tMenuItem*, AIHigh_*, AIDataRecord_AccTable_t ...): retail GLOBAL, ours local. PROVEN cause = compiler build: "
    "PsyQ 4.3 CC1PLPSX `2.8.0 SN32 Build 4.0.0007` (our default) emits them local; PsyQ 4.4/4.5 CC1PLPSX `2.8.1 SN32 BUILD "
    "4.0.0010` (C:/Temp/psq44/pssn/bin, the existing `2.8.1-sn` rung of replay.cpp + night.cpp) emits `.globl _._3Acc` = retail "
    "(test build/tmp/kd.cpp; #pragma interface is NOT it -- it would also globalize Best-style tables retail keeps local). => "
    "retail's C++ compiler is the 2.8.1 build. WHOLE-TREE TRIAL `NFS4_CC1PL=C:/Temp/psq44/pssn/bin/CC1PLPSX.EXE`: only 18 of the "
    "C++ objects change .text (text_hashes.py): fedialog 6428->6168, femenuoptions 19856->19568, screentracks 3060->3028 (the "
    "-fno-implement-inlines TUs shrink: the NII probe flags are probably a 2.8.0 artefact), femenu +4, femenudefs +4, "
    "femenuextended +4, screenmemcard +4, aih_btccop +4, aistate +4, camera +8, newton -4, draww +20, hrzsku +16, hud +16, "
    "psxcontroller +4, and same-size changes in screencongrats, physics, drawc; honest link then = 7974 diff words, 7 dropped, 18 "
    "undefined. NOT adopted: DECISION FOR THE USER = make 2.8.1 the default C++ compiler and re-match those 18 TUs (their "
    "carriers were tuned for 2.8.0). (B) 57 = retail LOCAL, ours global: statics of the EA libs (nsync, nasync, nfile, syncfile, "
    "stream, cdfs, unhuff, unref/unbtree SQV*, textfor, wildcard strrstr, spchdata, spchrule, spchevnt), front.cpp "
    "regularCopModels/superCopModels, and Get__26AIDataRecord_CarTracking_ti (retail: CarTracking is an ALL-INLINE class -- "
    "local Get, local dtor, no `_vt` label -- yet its table is emitted and NOTHING references it; dead construction after "
    "`return` or behind a foldable local flag does NOT emit it, a surviving reference does: mechanism still OPEN). "
    "static_census.py lists definitions; CAUTION: spchpick.c really calls iSPCH_GetMatchValue / VoxSentence_GetShortRule "
    "(defined in spchdata.c) -> check whether retail has them in ONE object before adding `static`. Outputs saved: "
    "scratchpad/psyq_pipe/drift_full.txt, drift_vt.txt, sym_linkage.txt.\n")
s = s[:j] + NEW + s[j:]
open(P, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(s)
print('ok')
