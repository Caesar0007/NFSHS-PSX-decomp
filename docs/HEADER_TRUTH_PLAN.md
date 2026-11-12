# Header-truth plan (NFS4 PSX)

Started 2026-11-12. Owner ruling (2026-11-12): keep commits 7838ab858..2ac4bd057, remove the
fabrications selectively, follow this plan, keep this document updated as work lands.

## Why

The 2026-11-08/09 type-record rounds lowered the SLINK census (1650 -> 436) partly by *fitting*:
source was invented so the compiler would emit one more record. The census cannot tell an invented
inline from the real one, so the number stopped measuring closeness to the retail headers.

Vtables are NOT hand-made: every polymorphic class uses real `virtual` members and cc1plus emits
the tables (0 live `_vf` lines; about 20 file-header comments still say "manual _vf vtable").
The real vtable risk is duplicated class definitions that must agree by hand.

## Baseline (HEAD 2ac4bd057)

| Counter | Value | Direction |
|---|---|---|
| Code bytes | 299819/299819 | must hold |
| Fake `*Inferred*Op*` members/functions | 17 sites | -> 0 |
| `INFERRED` markers (game/frontend/shared) | 142 | down; each survivor needs evidence |
| Header conditionals keyed on the including object | 176 | down |
| Classes defined in more than one header | 94 | down, polymorphic ones first |
| `link_stripped.json` rows (non-SDK) | 158 (85 added since 1e8cf3499) | only evidence-backed rows stay |
| SLINK census | 436 | reported, no longer a target; may rise |

## Evidence rule (replaces "the count needs one more")

An inline body, member or out-of-line copy stays only with at least one of:
1. a call site in byte-matched code (zero-length `this` pair or line record in retail SYM);
2. a retail SYM record naming it;
3. the named twin in NFS4-PC / NFS2-PC / NFS3 sources or debug info;
4. compiler-mandated emission from an evidenced body (out-of-line copy of an evidenced in-class
   inline in the class's key object, removed by the retail link).

A TPDEF count or run pattern alone is not evidence. Without evidence the mismatch stays and is
listed under "Open mismatches" below.

## Phases

### Phase 1 - remove pure fabrications (the 17 `*Inferred*Op*` sites)
aidatarecord.cpp, aihigh.h, aih_basiccop.cpp, aih_btccop_types.h (x2), aih_hierarchy_types.h,
audioclc_types.h, audiotrk_types.h, camera_types.h, copspeak.cpp, speech_speaker_virtuals.inc (x4),
hud.cpp, psxfront.cpp (x2). Their link_stripped rows go with them.

### Phase 2 - Speech pilot: one SPEECH.H
`speech_speaker_virtuals.inc` loses its per-object branches (one member list for every includer);
speech_class.h inferred accessors audited against the evidence rule.

### Phase 3 - audit the remaining INFERRED bodies
Per file: keep (cite evidence in the comment) or remove. Macro-packed bodies in
`shared/tpdef_keys.h` move back into their class headers as ordinary members or go away.

### Phase 4 - one definition per class
Polymorphic families first (tMenuItem family, tMenu, tListIterator, AIHigh_Base), then
tFEApplication, AnimScript, Object*Anim, AIDataRecord_*. Per-object copies replaced by the single
reconstructed retail header; differences between objects explained by include graph only.

### Phase 5 - gate and comments
Add the counters above to the gate (must not rise). Fix the stale "manual _vf" file headers.

## Gate per change
bytes 299819/299819, 0 masked, gdebug 0 FAILED, every including TU PASS, SLINK lane builds.
Census/inversions are recorded, regressions caused by removing a fabrication are accepted and
re-baselined (head.json / slink_head.json).

## Progress log

| Date | Commit | Change | Fake ops | INFERRED | Per-object conds | Dup classes | Stripped rows | Census |
|---|---|---|---|---|---|---|---|---|
| 2026-11-12 | 2ac4bd057 | baseline | 17 | 142 | 176 | 94 | 158 | 436 |
| 2026-11-12 | (phase 1) | all 17 fake `*Inferred*Op*` sites + their 4 stripped rows removed; bytes 299819/299819, SLINK symtree no regressions | 0 | 125 | 175 | 94 | 154 | 487 |

## Open mismatches (left unexplained on purpose)

Phase 1 removals. Each is a retail type record our source no longer produces; restore only under the evidence rule.

| Object | Retail record left unmatched | What is known |
|---|---|---|
| hud.obj | `Car_tObj` (+ field walk) before Hud_BuildCdPlayer | HUD.CPP lines 795-800 owned by no retail function: a link-stripped function existed, name and body unknown |
| copspeak.obj | `Car_tObj` between CopSpeak_StartUp and CopSpeak_Request | COPSPEAK.CPP 975-1027 gap: link-stripped function, unknown |
| psxfront.obj | `Car_tObj shapetbl` before DoTitleScreen; `shapetbl` before FontUpsideDownBlit | PSXFRONT.CPP 98-141 and 1260-1338 gaps: two link-stripped functions, unknown |
| aidatarecord.obj | `Car_tObj` (+walk), `AIDataRecord_t` between StartUp2 and CleanUp1 | count only |
| aih_basiccop.obj | one more `Car_tObj` in the ctor group | count only |
| aih_btccop.obj | `Car_tObj` in the BTC_Perp run; `coorddef` after AIDataRecord_AccTable_t | count only |
| AI objects | one more `AIHigh_BTC_Perp` (this-only body); aihigh.obj one more `AIHigh_Base` | count only |
| aih_cop.obj | four `Speaker` this-records without `Car_tObj` | to be re-examined in phase 2 (single SPEECH.H) |
| audioclc/audiotrk/camera.obj | one `Trk_AnimateInst` each | count only |

The four "gap" rows are the best candidates for real recovery: check NFS4-PC / NFS3 for a function at that position.
