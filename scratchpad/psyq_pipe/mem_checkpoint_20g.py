"""Insert CHECKPOINT 2026-09-20g into the NFS4 memory hub (after the 2026-09-20f line)."""
P = 'C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/00_current_nfs4.md'
s = open(P, encoding='utf-8', errors='surrogateescape').read()
assert 'CHECKPOINT 2026-09-20g' not in s
i = s.index('- CHECKPOINT 2026-09-20f')
j = s.index(chr(10), i) + 1
NEW = (
    "- CHECKPOINT 2026-09-20g (SPEECH FAMILY = WIP ON A BRANCH, ONE FUNCTION LEFT): `main` = c9516032+checkpoint (0 diff). Branch "
    "`wip/fevirt-speech`: Speaker / DispatchSpeaker / MobileSpeaker use REAL virtuals; the three hand tables at the end of speech.cpp, "
    "the `_base_Speaker` composition (574 uses), the 64 `VirtualX()` bridges, the cached-table carriers (`pa_VarN = this->_vf`), the "
    "MOBILE_SPEAKER_COORD slot macro and copspeak_types.h's manual vptr store are gone. Links clean; speech.obj .rodata byte-exact "
    "(SimpleMem head 0x80055B54 PROVEN by vtable alignment -> row 0x80055B54..0x80055EBC; declaration order Speaker, DispatchSpeaker, "
    "MobileSpeaker = retail tables Mobile 0x80055BD4, Dispatch 0x80055CCC, Speaker 0x80055DC4); every function of speech.cpp matches "
    "EXCEPT `Status__Q26Speech15DispatchSpeaker` (366/366 instructions, 150 differing lines = allocation cascade, ~366 diff words in "
    "the honest link, no size change). Mechanics: speech_speaker_virtuals.inc = the 30 virtuals in slot order WITH asm labels "
    "(nested-class manglings `X__Q26Speech7Speaker...`; real nesting in `struct Speech` is the follow-up), included by the `struct "
    "Speaker` copies in speech/aih_btccop/aih_btcperp/aih_cop/copspeak _types.h (aih_basiccop/aih_basicperp/aih_play copies had no "
    "`_vf`); inline ctors `Speaker() { fSub = 0; }`, `DispatchSpeaker() {}`, `MobileSpeaker() { fCarObj = 0; }` + plain `new` in "
    "Speech::Speech(); speech.cpp built with no_implement_inlines (Speaker::SetColour inline has no retail copy). 🔑 LAW (argument "
    "evaluation order, cc1plus 2.8): an argument that CONTAINS A CALL is precomputed before the others; if SEVERAL arguments contain "
    "calls they are precomputed IN ORDER. The implicit `this + vtbl[n].delta` is argument 1 -- so `Sub->KnownPerp(this->Perp())` with "
    "a LOCAL `Sub` runs Perp() first, while `Speech::Dispatch()->KnownPerp(this->Perp())` does Dispatch(), vptr, entry address "
    "(`addiu sN,v0,8*n`) and delta FIRST, then Perp(), then loads pfn through the saved entry pointer = retail. That retired four "
    "entry-pointer carriers in MobileSpeaker::Engage (467/467 exact). OPEN: DispatchSpeaker::Status has the same retail shape "
    "(`addiu s1,v0,48; lh s0,48(v0)` before the Perp() call, one shared vptr load for Perp and Engage) but its receiver is the plain "
    "field `this->fSub` (no call) -- the natural `this->fSub->Engage(this->fSub->Perp())` gives Perp-first (count-exact 366, 150 "
    "diffs); a receiver local gives 364; pointer-to-member gives 490. Find what makes argument 1 call-bearing/early there (the two "
    "other converted sites in that function: `this->fSub->Perp() == 0` guard and `int perpDistance = this->fSub->DistToPerp();`). "
    "Other typed-pointer fallout fixed: `*(int *)(this->CallSign() + 4)` was BYTE arithmetic on an int result -> "
    "`this->CallSign()->fDispatch` (5 sites). Tools added: fncount_hunks.py (register-blind hunks where the instruction COUNT "
    "differs), fn_diffcount.py CPP (per-function diff lines for a TU), fevirt_sites.py accepts hex slot numbers. To resume: "
    "`git checkout wip/fevirt-speech`, full build, relink, `python scratchpad/psyq_pipe/fn_diffcount.py recon/game/common/speech.cpp`.\n")
s = s[:j] + NEW + s[j:]
open(P, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(s)
print('ok')
