# W86-S6 receipt — SYM/SLD-exactness AUDIT of `recon/game/common` + `recon/game/psx`

Agent: W86-S6 (SYM/SLD verification). Repo `C:\Temp\nfs4-decomp`.
Step-0 reads done: `reference_mips_isa_asm.md`, `reference_psx_cpp_reconstruction_methodology.md`
(§0 rule 8 + §3.8b = task spec), `scratchpad/w86/GUIDE.md` (SYM/SLD section).
Authority: `C:/Temp/nfs4-psx/nfs4-psx-sym.txt` (the GUIDE's `nfs4-psx-sym.txt`; the
`nfs4-psx decompiles\` path in the GUIDE resolves to `C:\Temp\nfs4-psx\`).

**Verdict: the user's SYM series left NO fillable gap and NO actionable residual in these
two trees.** Everything the audit flagged resolved, on inspection, to an already-documented
deliberate decision, a macro/`#if 0`/inline-expansion artifact, or an auditor false positive.
One real defect was found and fixed (a wrong file-header banner in an uncovered TU).

---

## 1. COVERAGE MAP (what the user's series touched)

Existing code TUs: **92** in `recon/game/common`, **35** in `recon/game/psx` = **127**.

| tier | definition | count |
|---|---|---|
| A | touched by a `SYM-exact` / `SYM declaration audit` commit | 85 (72 common + 13 psx) |
| B | touched by another SYM commit only (`SYM type surface`, `SYM owners`, …) | 26 existing files |
| C | **not touched by any SYM commit** | **16** |

Enumeration method: `git log --grep=SYM --name-only` (and the narrower
`--grep="SYM-exact" --grep="SYM declaration audit"`), intersected with the current file list.
Read-only; no git state was changed.

### Tier C — the 16 uncovered TUs

```
recon/game/common/aispeech.cpp        recon/game/psx/ddvfont.cpp
recon/game/common/async.cpp           recon/game/psx/debug.cpp
recon/game/common/debugvar.cpp        recon/game/psx/draw2.cpp
recon/game/common/fei.cpp             recon/game/psx/drawdbg.cpp
recon/game/common/minfront.cpp        recon/game/psx/filedbg.cpp
recon/game/common/smack.cpp           recon/game/psx/nfs2mem.cpp
recon/game/common/vtables_tlist.cpp   recon/game/psx/profile.cpp
recon/game/common/vtables_tscreen.cpp
recon/game/common/vtables_tscreen2.cpp
```

## 2. §3.8b CHECK ON THE UNCOVERED TUs

Counted `8c Function start` records per SYM `FILE`-block for each owning object:

```
MinFront.obj  fns=1     FEI.obj      fns=0     aispeech.obj fns=0     async.obj    fns=0
debugvar.obj  fns=0     smack.obj    fns=0     Ddvfont.obj  fns=0     debug.obj    fns=0
Draw2.obj     fns=0     DrawDbg.obj  fns=0     filedbg.obj  fns=0     nfs2mem.obj  fns=0
profile.obj   fns=0
```

* **13 of 16 have ZERO SYM functions** — pure type-definition / empty-marker / data-only TUs
  (`fei.cpp` is the 912-byte `FEI_gList[114]` table; `drawdbg.cpp` is one `.bss` global). The
  §3.8b local/param/scope check is **vacuous** for them: there are no `8c` blocks, hence no
  REGPARM/AUTO/REG/STAT records to be exact to. Their existing headers already state this and
  the statement now stands verified against the raw SYM.
* **`vtables_tlist.cpp` / `vtables_tscreen.cpp` / `vtables_tscreen2.cpp`** are synthetic
  data-materialisation TUs (their own banners say "NOT original layout"); they own no SYM
  object and therefore no SYM function blocks. Vacuous likewise.
* **`minfront.cpp` — the only uncovered TU with a function.** Audited in full against
  `MinFront_ParseOptions__Fv` @0x800128f0:

  | SYM | recon |
  |---|---|
  | ret `FCN PTR INT` | `int *` ✔ |
  | params — none (`__Fv`) | `(void)` ✔ |
  | 1 × `94 Def class REG type PTR INT` `$00000010`(=`$s0`) name **stream** | `int *stream;` ✔ |
  | one `90 Block start line = 1` … `92 Block end` | single block ✔ |
  | fsize 24, retreg 31, mask `$80010000` (ra+s0), maskoffs −4 | consistent ✔ |
  | SLD 781–805 of `MINFRONT.CPP` | header breadcrumb `[MINFRONT.CPP:781-805]` ✔ |

  **Already SYM-exact.** No AUTO/ARG/STAT records exist, so nothing else to name.

### Gap filled (the only edit this agent made)

`recon/game/common/minfront.cpp` — the file-header banner was a verbatim copy-paste of
`frontend/common/fecars.cpp`'s banner ("46 fns across 3 classes: tCarManager …"), describing a
TU that has never lived in this file. Replaced with an accurate banner recording the SYM facts
in the table above.

* **Comment-only, codegen-free.** Gate before: `minfront.cpp: 1/1 PASS`.
  Gate after: `minfront.cpp: 1/1 PASS`. Unchanged.

No other file in either tree was modified.

## 3. SPOT-AUDIT OF THE COVERED TUs (widened to a FULL audit)

Rather than 2–3 functions per TU, a mechanical §3.8b audit was run over **every** function of
all 127 TUs (tooling in `scratchpad/w86/`, read-only, outside `tools/`):

* `s6_symaudit.py` — parses each SYM `8c` block (REGPARM/ARG/REG/AUTO/STAT with block
  nesting, register homes via `$N`→`s0/t8/…`, fsize/mask, SLD span) and diffs the names
  against the C function's declared locals + parameters.
* `s6_filecheck.py` — cross-checks that each matched SYM block's `file =` equals the TU.
* `s6_absentcheck.py` — re-checks every "absent" hit against the RAW text (comments kept).
* `s6_typecheck.py` — SYM type vs C declared type (pointer-ness / array-ness / scalar family).

Raw outputs: `S6_audit_raw.txt`, `S6_absent_check.txt`, `S6_typecheck.txt`.

### Results

| measure | result |
|---|---|
| functions bound to a unique SYM block | **1364** |
| SYM `file =` vs TU filename mismatches | **0 / 1364** |
| functions with every SYM local name present in the C | **1092** |
| name-matched locals type-checked (SYM type vs C type) | **4812** |
| genuine type mismatches after inspection | **0** |
| candidate absences, hand-adjudicated | 45 in 16 fns → **0 genuine** |

### Adjudication of the 45 candidate absences (all resolved, none actionable)

| class | count | evidence |
|---|---|---|
| already annotated `SYM-OPTIMIZED` / `SYM-INLINE-LOCAL` / `SYM-CARRIER` at the use site — inlined-callee locals that legitimately have no caller-scope C variable | 22 | `aih_cop.cpp` slowDownEndTime/slice/rightLatPos/timeNow; `aispeeds.cpp` futureSpeed/speed/sIndex; `aiphysic.cpp` reverseTime/d; `aih_play.cpp` level; `aih_traf.cpp` trigger; `speech.cpp` bankid/unit/p/a/b; `aih_btcperp.cpp` carObj/trafficOffset; `draww.cpp` tempnight/tempcop (W70 falsification recorded in-file) |
| declared inside a **macro** whose expansion reproduces the SYM's nested blocks | 3 | `trsproj.cpp` `TRSPROJ_SET_MATRIX_ROW` supplies `r0/r1/r2`; the SYM's three line-1 blocks match one-for-one |
| present in the C under the exact SYM name — auditor's body extraction stopped early | 8 | `aih_btccop.cpp` `AIHigh_BTC_Wingman::HighExecute` chaseState/endSlice/rbDistanceMeters/rbAbsDistanceMeters/release/timeNow/timeToRB/gotoState all exist verbatim in the live body |
| SYM records the **inlined callee's** locals in the caller's block; the recon keeps the callee as its own function (with a measured in-file rationale) | 11 | `sfx.cpp` `Sfx_BuildSouffleFacet` absorbs `Sfx_AdditivePrim`'s l0–l3/tpage/pmx + ptrans/invertedm/dest/check/scale; sfx.cpp:158-177 already records the measured cost of the l0–l3 naming choice |
| function body lives inside `#if 0` (preserved historical variant) | — | see §4 |

### Ghidra-named-local census (methodology §0 seal criterion 2)

85 declarations across both trees still carry Ghidra-style names. 73 sit under an explicit
`SYM-CODEGEN-CARRIER` / `SYM-CARRIER` note (measured non-neutral to fold). The 12 without one
resolve as:

* `AIWORLD.cpp:472-473`, `physics.cpp:1658-1659` — `optVar1`/`optVar2` are **EA's own SYM
  names** (`AIWorld_CalcSpeed__FP8Car_tObj`: `94 Def class REG type INT name optVar1` `$05`,
  `optVar2` `$03`). Not Ghidra-isms; correctly named.
* `aistate.cpp:3093/3095/3201`, `object.cpp:1287/1332` — compiler-generated deleting
  destructors (`___21AIState_RovingTraffic`, `___12AIState_Idle`, `___14ObjectSignAnim`,
  `___15ObjectMultiAnim`), flagged `SLD-FLAG:NO_SLD`. **No SYM block exists** for them, so
  there is no ground-truth name to be exact to; each already carries a MATCH note.
* `aih_btccop.cpp:1704-1714` (`bVar1`, `pSVar2`, `iVar3`, `sVar6`, `WVar7`) — **inside the
  `#if 0` block at lines 1689-2291**, a preserved pre-W76 variant of
  `AIHigh_BTC_Wingman::HighExecute`. The live definition (line 2503) uses the SYM names.
  Dead text, not a live fidelity defect.

### Type fidelity

23 flags over 4812 checks, all benign on inspection:
* `bworld.cpp BWorld_BuildGlareEffects` `int group;` shadowing the `Group *group` param —
  **the SYM does the same**: `REGPARM PTR STRUCT tag Group name group` plus
  `REG INT name group` in the block at line 25. Recon is exact.
* `speech.cpp` `char *c` vs SYM `INT c` — the INT `c` records are the inlined `ReadBE32`
  helper's local (already annotated `SYM-INLINE-LOCAL: c = ReadBE32`), a different variable.
* `sfx.cpp` `dSouffle` — SYM holds both the outer `AUTO STRUCT sfxsouffle dSouffle` (which the
  C matches) and an inner `REG PTR STRUCT` record from an inlined callee's parameter.

## 4. GATE STATE (iron rule)

Whole-TU `tools/tugate.py` runs. The only TU edited was `minfront.cpp`; the others were gated
to establish that the flagged functions are already at 100% and therefore report-only.

```
recon/game/common/minfront.cpp   1/1   PASS   (before AND after the header fix)
recon/game/psx/trsproj.cpp      11/11  PASS
recon/game/common/aiphysic.cpp  42/42  PASS
recon/game/common/aih_play.cpp  10/10  PASS
recon/game/common/object.cpp    37/37  PASS
recon/game/common/aistate.cpp   52/52  PASS
recon/game/common/aih_btccop.cpp 40/40 PASS
```

**0 regressions. 0 reverts needed** (no scope/order change was attempted, because every
candidate reshape resolved to "already correct" or "already measured and documented").

## 5. MISMATCHES THAT COULD NOT BE APPLIED

None outstanding for these two trees. The two categories a future wave could still choose to
revisit — both already priced in-file by earlier waves, both currently at 100%:

1. `sfx.cpp` — `Sfx_AdditivePrim` is kept as a separate function while the SYM shows it inlined
   into `Sfx_BuildSouffleFacet`. Re-inlining would be a whole-function reshape of a
   126/126-count-exact body; sfx.cpp:158-177 records the falsified `l0..l3` naming attempt.
2. `draww.cpp` — `tempnight` / `tempcop` are carried by a single shared `temp0` slot; writing
   them as separate block-local `VECTOR`s was measured **non-neutral on cc1plus 2.8.0** (W70,
   `SYM-CARRIER` note at draww.cpp:1428-1448).

## 6. TOOLING BANKED (scratchpad only — no `tools/*.py` touched)

```
scratchpad/w86/s6_symaudit.py     SYM 8c-block parser + per-TU local/param diff
scratchpad/w86/s6_filecheck.py    SYM `file =` vs TU-name consistency check
scratchpad/w86/s6_absentcheck.py  re-check absences against raw text (comments kept)
scratchpad/w86/s6_typecheck.py    SYM type vs C declared type
scratchpad/w86/S6_audit_raw.txt   full 127-TU audit output
scratchpad/w86/S6_absent_check.txt
scratchpad/w86/S6_typecheck.txt
```

Known auditor limitations (documented so a future wave does not re-chase them): it parses
`#if 0` text as live code, it does not join multi-line declarations, and it can bind the wrong
body when a file holds two same-named definitions. Every hit in §3 was hand-adjudicated
against the file and the SYM before being reported.

## 7. PROHIBITIONS OBSERVED

No git operations. No edits to `tools/*.py`, `regiondiff/tools/*.py`, boards, MANIFEST, or any
memory-dir file. No new devices, no pins, no `volatile`/`asm`. One source file touched
(`recon/game/common/minfront.cpp`, comment-only), gated before and after.
