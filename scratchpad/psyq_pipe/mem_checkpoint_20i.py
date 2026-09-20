"""Insert CHECKPOINT 2026-09-20i into the NFS4 memory hub (after the 2026-09-20h line)."""
P = 'C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/00_current_nfs4.md'
s = open(P, encoding='utf-8', errors='surrogateescape').read()
assert 'CHECKPOINT 2026-09-20i' not in s
i = s.index('- CHECKPOINT 2026-09-20h')
j = s.index(chr(10), i) + 1
NEW = (
    "- CHECKPOINT 2026-09-20i (USER: 'Speech classes' -- REAL NESTING DONE): nfs4-decomp `main` = 458d2dd4 (branch "
    "wip/speech-nesting fast-forwarded; UNPUSHED, 36 ahead of 6871d324), FULL rebuild + honest link 297385/297385 = 0 diff, DROPPED "
    "0. New shared guarded header recon/game/common/speech_class.h = SPCHNFSType_* flag words + the COMPLETE `struct Speech` with "
    "nested CarBank, LocationBank, CallSignBank, Speaker, CarBankName, DispatchSpeaker, MobileSpeaker (same relative order: "
    "Speaker, Dispatch, Mobile) and REAL static members `static Speech *fgSpeech; static Speaker *fgUndefined;` (natural "
    "mangling is `_6Speech.fgSpeech` with a DOT, like `_vt.Q26Speech7Speaker`; symbol_addrs spells both with `_`). Included by "
    "speech_types.h and copspeak_types.h (-> nfs3, cars). 87 asm labels removed (57 header + 30 in "
    "speech_speaker_virtuals.inc) plus 15 stale free-function forward decls in speech.cpp; definitions are "
    "`Speech::LocationBank *Speech::DispatchSpeaker::FindClosestLocationTo(int)` style (return types need the qualifier, bodies "
    "do not). nfs3.cpp: `Speech::fgUndefined = new Speech::Speaker;`, `Speech::fgSpeech = new Speech;`, `delete "
    "Speech::fgSpeech;`, `Speech::Reset();` replace the raw `__6Speech(__builtin_new(0x3a4))` / `___6Speech(p,3)` calls -- byte "
    "exact. The six AI surfaces (aih_basiccop, aih_basicperp, aih_btccop, aih_btcperp, aih_cop, aih_play) nest their reduced "
    "Speaker copy in a reduced `struct Speech { struct Speaker {...virtuals .inc...}; static Speaker *Dispatch(); static "
    "Speaker *Mobile(Car_tObj *); };` and call `Speech::Mobile(x)->Lose()`; their asm-labelled `Speech_Mobile` / "
    "`Speech_Dispatch` externs are gone. All ten touched TUs = 0 differing lines (fn_diffcount.py). LEFT: recon/nfs4_types.h "
    "still has its own labelled Speech copy (monolithic header, 38 TUs, none Speech users), recon/game/common/speech.h has stale "
    "`__6Speech` prototypes, stale `_vf` comments; purity list of 2026-09-20e unchanged. Scripts: speech_nest1..3.py.\n")
s = s[:j] + NEW + s[j:]
open(P, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(s)
print('ok')
