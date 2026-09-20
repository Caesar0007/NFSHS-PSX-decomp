"""Insert CHECKPOINT 2026-09-20f into the NFS4 memory hub (after the 2026-09-20e line)."""
P = 'C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/00_current_nfs4.md'
s = open(P, encoding='utf-8', errors='surrogateescape').read()
assert 'CHECKPOINT 2026-09-20f' not in s
i = s.index('- CHECKPOINT 2026-09-20e')
j = s.index(chr(10), i) + 1
NEW = (
    "- CHECKPOINT 2026-09-20f (USER: 'continue on vtables'): `main` = c9516032, 0 diff. Census of what is LEFT of hand-made vtable "
    "machinery after the 40 vtables_*.cpp files: (1) DONE now -- draww.cpp's two ObjectAnim::Draw dispatches are real virtual calls "
    "(draww_types.h declares the polymorphic root: `virtual ~ObjectAnim(); virtual int Draw(...) = 0;`, derived copies by "
    "inheritance; nothing emitted in draww, .text 0x5970 unchanged); (2) 🔴 THE SPEECH FAMILY = the last one, NOT started: "
    "`Speech::Speaker` / `Speech::MobileSpeaker` / `Speech::DispatchSpeaker` (NESTED classes: manglings `Q26Speech7Speaker`, "
    "`Q26Speech13MobileSpeaker`, `Q26Speech15DispatchSpeaker`), 31 slots each and NO destructor slot: [1] Report(Car_tObj*) [2] Status "
    "[3] Deny [4] Grant [5] Ready(Car_tObj*) [6] Engage(Car_tObj*) [7] Lose [8] Accident(int) [9] Catch(int) [10] RoadBlock [11] "
    "SpikeBelt [12] Backup [13] ReportBlockade [14] Roger [15] Bullhorn [16] Purge [17] Unit [18] KnownPerp(Car_tObj*) [19] "
    "ClearPerp(Car_tObj*) [20] IsSuper [21] StatusCount [22] StatusSub [23] PurgeStatusSub [24] DistToPerp [25] CarObj [26] "
    "ReActivate [27] Perp [28] GetCarBank(int) [29] FindClosestLocationTo(int) [30] CallSign. Tables are hand-written INSIDE "
    "recon/game/common/speech.cpp (end of file, `const __vtbl_ptr_type X_vtable[31] __asm__(\"_vt_Q26Speech...\")`, retail "
    "0x80055BD4 Mobile, 0x80055CCC Dispatch, 0x80055DC4 Speaker = reverse declaration order Speaker, Dispatch, Mobile). Current "
    "modelling: flat top-level structs, COMPOSITION (`_base_Speaker`, 548 uses), members written as FREE functions "
    "`Speech_Speaker_X(Speaker *self, ...) asm(\"X__Q26Speech7Speaker...\")` or member decls with asm labels; 129 live `_vf` sites in "
    "speech.cpp, 25 in aih_btccop.cpp, 2 in aih_btcperp.cpp (`*mobileSpeaker->_vf + 0x3c` = slot 7 Lose); private `struct Speaker` "
    "copies in aih_basiccop/aih_basicperp/aih_btccop/aih_btcperp/aih_cop/aih_play/copspeak _types.h; users nfs3.cpp too. PLAN: real "
    "nesting `struct Speech { struct Speaker {virtual ...}; struct DispatchSpeaker : Speaker; struct MobileSpeaker : Speaker; ... }` so "
    "the manglings become natural and every asm label goes; free functions -> members (`self` -> `this`, same a0 ABI); a retail "
    "`jal` to a virtual member = a QUALIFIED call `p->Speech::Speaker::X()` or a member-object call, a `_vf` site = plain `p->X()`; "
    "no dtor slot => classes declare NO virtual destructor (vptr store only in ctors); same workflow (fevirt_errs.py, "
    "fevirt_sites.py with a SPEAKER slot map, fndrift.py, vt_census.py, rows from table addresses; game objects are NOT under the "
    "NII flag: every inline member of a key-function class gets an out-of-line copy there). Expect it to be the size of the screen "
    "family.\n")
s = s[:j] + NEW + s[j:]
open(P, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(s)
print('ok')
