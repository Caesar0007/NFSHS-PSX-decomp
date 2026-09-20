"""Insert CHECKPOINT 2026-09-20h into the NFS4 memory hub (after the 2026-09-20g line)."""
P = 'C:/Users/Vyacheslav/.claude/projects/C--Temp-claud/memory/00_current_nfs4.md'
s = open(P, encoding='utf-8', errors='surrogateescape').read()
assert 'CHECKPOINT 2026-09-20h' not in s
i = s.index('- CHECKPOINT 2026-09-20g')
j = s.index(chr(10), i) + 1
NEW = (
    "- CHECKPOINT 2026-09-20h (🏆 SPEECH FAMILY MERGED -- NO live hand-made vtable dispatch is left anywhere in recon): nfs4-decomp "
    "`main` = 153ef867 (wip/fevirt-speech fast-forwarded; 33 commits ahead of pushed 6871d324, UNPUSHED), FULL rebuild + honest link "
    "297385/297385 = 0 diff, DROPPED 0, ownership audit 3298 B blob-only. The open function DispatchSpeaker::Status (366/366, 150 "
    "diff lines) was solved by ONE spelling: `this->Sub()->Engage(this->Sub()->Perp());` with `Speaker *Sub() { return fSub; }` an "
    "in-class INLINE ACCESSOR of Speech::Speaker (speech_types.h). 🔑 LAW (cc1plus 2.8, extends the argument-evaluation law): an "
    "INLINE call is still a CALL_EXPR when expand_call decides which arguments to precompute, so a receiver spelled through an "
    "inline accessor makes the implicit argument 1 (`this + vtbl[n].delta`) call-bearing -> receiver, vptr load, entry address "
    "(`addiu s1,v0,48`) and delta (`lh s0,48(v0)`) are evaluated BEFORE the nested argument call, pfn load after; the accessor body "
    "itself folds/cse's away to the plain field load. SYMPTOM: retail fetches the outer virtual's table entry BEFORE the nested "
    "argument call although the receiver is a plain field, and shares one vptr load between both calls -> the original source used "
    "an inline getter as receiver. Variants that FAILED there: plain field (366 but Perp-first), local receiver (364), assignment-"
    "expression receiver (368), pointer-to-member. Remaining `_vf` text in recon = comments and `#if 0` reference blocks only "
    "(aih_btccop.cpp 1670-2217 / 2683-2804, screencarselect/femenudefs/screencongrats/draww/speech comments) = the stale-comment "
    "cleanup item. New tool: scratchpad/psyq_pipe/fn_sxs.py CPP FUNC [START [COUNT]] (full-context retail-vs-ours diff of one "
    "function). FOLLOW-UPS still open: really nest Speaker/DispatchSpeaker/MobileSpeaker in `struct Speech` so the 30 asm labels "
    "in speech_speaker_virtuals.inc go; the purity list of 2026-09-20e; branches wip/fevirt-tmenu, wip/fevirt-tscreen, "
    "wip/fevirt-speech are merged and can be deleted.\n")
s = s[:j] + NEW + s[j:]
open(P, 'w', encoding='utf-8', errors='surrogateescape', newline='').write(s)
print('ok')
