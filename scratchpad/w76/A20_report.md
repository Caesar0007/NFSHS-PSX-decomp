# W76-A20 — INSTRUMENTS + VPTR SWEEP + RELOAD-INHERITANCE RE-CHECK (report, INCREMENTAL)

Belt: (1) build `[distribute_notes]` into the instrumented cc1plus (+ fold the hand `[reload-order]`
patch into apply_traces.py), validate on Night_CreateNightTableElement; (2) the ~90-site vptr-cast
sweep (§24A alias dial); (3) reload-inheritance verdict re-check via the §24B(4) `.greg`-vs-`.s`
discriminator.
Repo `C:\Temp\nfs4-decomp`. **No git commit/push. `tools/build.py` foreign hunks preserved.
No memory-dir writes. Zero PASS→FAIL contract.**

STEP 0 done: `reference_mips_isa_asm.md` (full), `reference_psx_cpp_reconstruction_methodology.md`
(full, 1018 lines), BRIEF.md, `scratchpad/w75/A20_report.md`, catalog §20–§24 (full text of
20A/20B, 21A–E, 22A–D, 23A–D, 24A–F).

## STATUS: ✅ COMPLETE — all three tasks done (1: instrument built+validated+neutral; 2: 89 censused / 27 converted / 0 regressions; 3: inventory closed, 1 mechanism flip, 0 gate changes). Full-scratchpad background grep confirmed no further inheritance certificates exist (all hits = backups of FONT.c/trnsmult.c/spchrule.c, already classified).

---

## TASK 1 — `[distribute_notes]` instrument (STATUS: patching)

Target mechanism (catalog 24E-6): combine.c `distribute_notes` — a REG_DEAD note whose backward
walk from i3 (`for (tem = prev_nonnote_insn (i3); place == 0 && tem && (INSN||CALL_INSN); ...)`,
combine.c:11298) hits a non-INSN stopper (CODE_LABEL) emits a **synthetic `(use reg)`**
(`emit_insn_after (gen_rtx (USE, ...), tem)`, combine.c:11396) → the pseudo gains a 2nd REG_DEAD →
fails local-alloc.c:472 eligibility → loses its hard reg. The 2.8.0-vs-2.8.1 Night delta
(Night_CreateNightTableElement reg 137) is exactly this note.

Facts established so far:
* combine.c is byte-identical (md5 332cad38…) across all three trees: repo build source
  `scratch/gccsrc/gcc-2.8.1/`, the second tree `C:\Temp\gccsrc\gcc-2.8.1\`, and the citation
  source `C:\Temp\gcc-2.8.1-src\extracted\` — pristine, no instrumentation yet.
* `distribute_notes (notes, from_insn, i3, i2, elim_i2, elim_i1)` — at the emission site the
  locals available are `note`, `tem` (the stopper), `place` (the new USE insn), plus args.
* The hand-added `[reload-order]` trace lives ONLY in `scratch/gccsrc/gcc-2.8.1/reload1.c`
  (after the `bad_spill_regs, HARD_FRAME_POINTER_REGNUM` anchor in `order_regs_for_reload`,
  ~:3944) — to be folded into `apply_traces.py` as an idempotent patch fn (W75-A20 flag).
* Build tree has `cc1.exe` (Aug 23, reload_pick era) AND `cc1plus.exe` (Aug 8 — predates the
  reload_pick + reload-order patches; those are trace-only/gated so its codegen is still valid).
  cc1plus is built via `mingw32-make CC="gcc -std=gnu89 -w" CFLAGS="-O1 -w -std=gnu89"
  LANGUAGES="c++" cc1plus` (per scratch/instr/build_cc1plus.log).

Planned trace grammar (gated on env `GCC_TRACE_DISTRIBUTE_NOTES`, its own gate so it doesn't
flood GCC_TRACE_ALLOC streams; helper `nfs4_dn_trace`, marker `nfs4_dn_trace`):

```
[distribute_notes] fn=<name> reg=<regno> i3=<uid> from_insn=<uid|-1> stopped_at=<code>:<uid> use=<uid>
```

(fn printed inline because combine runs BEFORE local_alloc's `===== FUNCTION =====` marker.)

### ✅ BUILT + VALIDATED (2026-08-23 17:27)

**What landed** (all in `apply_traces.py`, BOTH copies mirrored — repo
`scratch/instr/apply_traces.py` CRLF, `C:\Temp\nfs4-instr-cc1\apply_traces.py` LF):

1. **`patch_distribute_notes()`** — patches `combine.c` (shared backend ⇒ BOTH cc1 and
   cc1plus get it). Marker `nfs4_dn_trace`; own env gate `GCC_TRACE_DISTRIBUTE_NOTES`
   (`=1` orphan lines only, `=2` + a walk-outcome line per REG_DEAD entering the
   `place==0` backward walk). K&R PROTO forward decl injected at the `distribute_notes
   PROTO` anchor; helper + `extern char *current_function_name;` above the fn.
2. **`patch_reload_order()`** — the W75-flagged fold: emits the hand `[reload-order]`
   census (r2..r15 `hard_reg_n_uses`/`regs_explicitly_used` at the end of
   `order_regs_for_reload`) BYTE-IDENTICALLY to the hand patch; idempotence marker =
   the `"[reload-order] FUNCTION` format string, so the already-hand-patched repo tree
   was detected and skipped, while `C:\Temp\gccsrc\gcc-2.8.1\reload1.c` (which LACKED
   it — confirmed count 0) received it. A from-scratch rebuild no longer loses the trace.
   ⚠️ FOUND while folding: the second tree carried its OWN undocumented hand trace
   `[reload-totals]` (r0..r31 variant, same anchor) that is in NO script — same hazard
   class; left in place, flagged here for the lab owner.

**Trees patched:** repo `scratch/gccsrc/gcc-2.8.1` (combine.c new; reload-order already
present) and `C:\Temp\gccsrc\gcc-2.8.1` (combine.c + reload-order new). combine.c.orig
backups kept by the script. Citation source `C:\Temp\gcc-2.8.1-src\extracted\combine.c`
untouched (md5 332cad38… = pristine, identical to both build trees pre-patch).

**Build:** `sh scratch/instr/build_cc1.sh ecoff` → `scratch/gccbuild-ecoff/cc1.exe`
(1 995 558 B) + `mingw32-make … LANGUAGES="c++" cc1plus` in `scratch/gccbuild-ecoff` →
`cc1plus.exe` (2 556 027 B). NOTE: cc1plus had been STALE since Aug 8 (predating
[reload_pick]/[reload-order]); the relink brings it onto the full instrument stack.
Pre-patch binaries preserved: `scratchpad/w76/a20/cc1{,plus}-ecoff-pre-dn.exe`;
build logs `scratchpad/w76/a20/build_cc1{,plus}_dn.log`.

**Codegen neutrality (byte-compare of `.s`, old binary vs new, same flags):**

| TU | compiler | result |
|---|---|---|
| SYS.c.i (`-O2 -G0 -mgas -mno-split-addresses`) | cc1 | IDENTICAL (both rc=33, same known post-alloc segfault point) |
| FONT.c.i (`-O2 -G0 -mgas`) | cc1 | IDENTICAL (same segfault point reproduced) |
| COR_01.c.i (`-O2 -G0 -mgas`) | cc1 | IDENTICAL |
| addtimer.c.i (`-O2 -G4 -mgas`) | cc1 | IDENTICAL |
| night.cpp.i (`-O2 -G8 -mgas -funsigned-char`) | cc1plus | IDENTICAL — proves the WHOLE stack (incl. the Aug-8→now reload_pick/reload-order delta) is codegen-neutral on the C++ lane |

**Validation — Night_CreateNightTableElement (the known positive, W75-A13 receipt):**
* `GCC_TRACE_DISTRIBUTE_NOTES=2` on `night.cpp.i` (instrumented 2.8.1 cc1plus,
  A13's recipe `-O2 -G8 -funsigned-char`): **ZERO `[distribute_notes]` lines in the
  whole TU** — not even walk lines. This is a NEW precision on A13's dumps: under
  FSF 2.8.1 the reg-137 REG_DEAD never even ENTERS the `place==0` backward walk
  (the Feb-1998 fixes seat it directly), vs 2.8.0 which orphans it at
  code_label 139. The negative certificate is now one command instead of a
  combine-dump diff. Trace file: `scratchpad/w76/a20/night_dn_trace.txt`.
* **Positive controls** (the instrument fires where orphans really happen — swept
  60 build/recon `.i` under the 2.8.1 lab): `movf.c` `movfxya` — 2 orphans
  (`reg=125 i3=63 from_insn=63 stopped_at=code_label:53 use=452`, and reg=174 at
  code_label:358), `nasync.c` `initasync` — 1 orphan with a **jump_insn** stopper
  (`reg=143 … stopped_at=jump_insn:19`) — confirming the walk stops on ANY
  non-INSN/CALL, not only CODE_LABELs. Verbose walk lines pair 1:1 with the
  orphans. Files: `scratchpad/w76/a20/{movf,nasync}_dn.txt`.

**Per-basin fidelity (mandatory honesty):** `cmp_fns.py` lane-`.s` (CC1PLPSX 2.8.0,
`build/recon/game/psx/night.cpp.s`) vs instrumented-2.8.1 `.s`: **IDENTICAL 1/19**
(only Night_FindClosestColor). ⇒ as with W75's LIBMCRD verdict, **no number from a
2.8.1 trace may be quoted as a byte receipt for the default C++ (CC1PLPSX 2.8.0)
lane** — on night.cpp the instrument's value is (a) the mechanism-level negative
certificate above and (b) orphan detection on any TU compiled by the 2.8.x lab.
This is expected: the entire A13 story IS a 2.8.0-vs-2.8.1 allocation divergence.
For the vendor-2.8.0 orphan's exact (i3, from_insn) pair a 2.8.0-source lab would
be needed (does not exist; gcc281.tar.gz is the only tree) — A13's combine-dump
diff (insn 320 after code_label 139) remains the citation for that side.

**Usage recipe (for A13 / any consumer):**
```sh
cd C:/Temp/nfs4-decomp
cp build/recon/<path>/<TU>.{c,cpp}.i scratchpad/<mine>/tu.i    # never share the .i
export TMPDIR='C:\Temp\nfs4-decomp\scratchpad\<mine>\tmp\'     # Windows path, TRAILING backslash
export TMP="$TMPDIR" TEMP="$TMPDIR"
GCC_TRACE_DISTRIBUTE_NOTES=2 \
  scratch/gccbuild-ecoff/cc1plus.exe -quiet -O2 -G<g> -funsigned-char \
  scratchpad/<mine>/tu.i -o scratchpad/<mine>/tu.s 2> scratchpad/<mine>/dn.txt
# (cc1.exe for C lanes, add -mgas; the trace prints fn= inline -- combine runs
#  before local_alloc's ===== FUNCTION ===== markers, no GCC_TRACE_ALLOC needed)
grep 'distribute_notes' scratchpad/<mine>/dn.txt
```
Grammar: `[distribute_notes] fn=<name> ORPHAN reg=<pseudo> i3=<uid> from_insn=<uid|-1>
stopped_at=<rtxcode>:<uid> use=<newUSEuid>`; `=2` adds `… walk reg=… place=<uid|0>
tem=<rtxcode>:<uid>|null kind=<REG_NOTE_KIND>` per REG_DEAD entering the place==0 walk.
An `ORPHAN reg=N` on a lane's own compiler = REG_N_DEATHS(N) becomes 2 = the pseudo
fails local-alloc.c:472 eligibility (catalog 24E-6) — the named cure family is
DEMOTE/keep-combine-from-orphaning, not a rotation dial.

---

## TASK 2 — THE VPTR-CAST SWEEP ✅ (89 sites censused, 27 converted, 0 PASS→FAIL)

**Census** (`scratchpad/w76/a20/site_census.txt`, comment-stripped regex over the 12
site-bearing TUs — all in `recon/frontend/common/`): **89 code sites** (the raw grep's 95
minus 6 comment/receipt hits in femenudefs receipts, front_externs.h, nfs4_types.h).
88 sit in out-of-line ctors/dtors of the tMenu/tScreen/tDialog/tListIterator families;
2 (femenudefs :247/:768) in free fns constructing a stack `tDialogYesNoTri`; 1 is a
comma-expr in a mem-initializer (front.cpp:82). The ten nfs4_types.h inline-ctor sites
were already converted by W75-A1 — zero cast sites remain in headers.

**Classification (the §24A relevance law, applied per site):**
* **Containing-fn status: ALL 89 sites sit in gate-PASSING functions.** The only FAIL
  fns in site-bearing TUs are feapp `Redraw__14tFEApplication` (10 diffs), front
  `GetPSXPadValue__Fii` (12), femenudefs `__15tGlobalMenuDefs` (1138) — none is a
  ctor/dtor, and none CONTAINS a vptr STORE (checked: Redraw has only `_vf` dispatch
  READS; GetPSXPadValue is pad logic; tGlobalMenuDefs' vptr stores are the ALREADY
  CONVERTED header inline ctors). ⇒ **no site anywhere matches the §24A signature
  (argument load pinned below a vptr store in a near-miss)** — a PASS fn by definition
  already has retail order.
* **TU-has-FAIL-fns criterion** ⇒ 27 candidate sites: feapp (5), front (20 incl. the
  comma-expr), femenudefs (2). The other 62 sites live in nine 100%-TUs (fecars 4,
  fedialog 4, fememcard 3, femenu 22, femenuextended 11, femenuoptions 13, fescreen 2,
  fetourn 1, fetracks 2) — **classified NOT RELEVANT, not converted** (conversion there
  is pure regression risk with zero §24A upside; the dial is site-scoped by order).

**Conversions landed** (spelling per the W75-A1 winner: `X->_vf =
(__typeof__(X->_vf))VT;` — COMPONENT_REF, /s SET; each tagged
`/* w76-A20 vptr-store alias dial (24A) */`; protocol: re-read file at edit time
[shared clone], whole-TU tugate before/after, both runs twice, per-fn PASS-list diff):

| TU | sites | baseline (×2) | after (×2) | per-site outcome |
|---|---|---|---|---|
| femenudefs.cpp | 2 (:247 MenuExtended_GoToTwoPlayerSingleRace, :768 PinkSlipsPreSave) | 65/66, tGlobalMenuDefs 1138 | 65/66, 1138 — per-fn IDENTICAL | both NEUTRAL → **KEPT** |
| feapp.cpp | 5 (tDialogBase/MessageString/Help/MessageStringWithTimeout/NoInputMessage ctors) | 14/15, Redraw 10 | 14/15, Redraw 10 — per-fn IDENTICAL | all 5 NEUTRAL → **KEPT** |
| front.cpp | 20 (19 stmt-form dialog/screen ctors + the :82 CarDialog comma-expr mem-init) | 42/43, GetPSXPadValue 12 | 42/43, 12 — per-fn IDENTICAL | all 20 NEUTRAL → **KEPT** |

**ZERO PASS→FAIL; zero reverts needed.** Gate logs: `scratchpad/w76/a20/{fmd,feapp,front}_{base,after}{1,2}.txt`.

**Finding for the catalog:** in these small ctors the conversion is BYTE-NEUTRAL —
the vptr store is followed only by member stores/calls whose operands the scheduler
had no reason to hoist, so /s CLEAR-vs-SET changes nothing. The §24A dial only has
teeth where argument loads of a FOLLOWING inlined ctor/call sit under the store (the
tGlobalMenuDefs shape). ⇒ the remaining 62 sites are LIKELY neutral too, but under
the site-scoped-risk rule they stay cast-form until a FAIL fn implicates them; the
cast form remains flagged as a reconstruction artifact (W75-A1).

---

## TASK 3 — RELOAD-INHERITANCE VERDICT RE-CHECK ✅ (inventory complete; 1 already-flipped confirmed, 1 mechanism-sharpened, 0 gate changes)

**Discriminator ground truth re-verified from source first:** toplev.c:3479-3491 writes the
`.greg` dump (dump_global_regs + print_rtl_with_bb) after global_alloc+reload and
**BEFORE** `reload_cse_regs` (:3501). ⇒ an insn that is a constant/MEM set in `.greg` but a
register copy in the final `.s` was rewritten by reload_cse_regs; a copy already in `.greg`
is reload's own (inheritance/output-reload). One compile with `-dg` decides it.

**Certificate inventory** (grep `reload[- ]inheritance` over recon/** + scratchpad
reports; the plain-"inheritance" hits are C++-inheritance talk, excluded):

| certificate | fn | still-FAIL? | verdict |
|---|---|---|---|
| recon/syslib/psx/libgpu/FONT.c (7 mentions, W64-A3/W71/W74-A17 line) + scratchpad/w61a4/RECEIPTS.md + w63a3/RECEIPTS.md | FntFlush (2 @199) | YES | **already FLIPPED by W75-A15** (the origin of catalog 24B-4): `.greg` receipt `scratchpad/w75/a15_FONT_base.greg` shows reload emitting retail's `sw $a2,16($sp); lw $a0,16($sp)` verbatim — the copy is reload_cse's MEM flavour. Confirmed the w61a4/w63a3 receipts are the SAME (superseded) certificate. Cure space exhausted by A15 (label devices DCE'd, `(void)&dr` re-pools the slot, ver ladder loses whole-fn); donor store + consumer load are reload-EMITTED ADJACENT insns ⇒ no source-level statement position exists between them — the structural twin of 24B-2's call-arg unreachability. Standing verdict: certified reload_cse identity, expression forbidden under the no-post-compile policy. NO ACTION LEFT. |
| recon/game/common/nfs3.cpp:645 (W75-A11 item 3: "`addu a1,a0,zero` is reload INHERITANCE feeding L") | NFS3_CheckForFileOperations (2 @21) | YES | **MECHANISM SHARPENED this wave (new run)** — see below. Gate unchanged; actionable angle unchanged. |
| recon/eaclib/psx/eacpsxz/trnsmult.c (6 mentions) | transmult | **NO** (not in the 44 sub-100 rows) | out of scope (certificate on a non-FAIL fn) |
| recon/eaclib/psx/spchpsxz/spchrule.c:336 | (a3 tie note) | NO | out of scope |

**The NFS3_CheckForFileOperations run** (read-only; TU is concurrently OWNED by another
W76 belt — `scratchpad/w76/nfs3.cpp.w76bak` + new in-file `register …asm("$4")` pins —
so no edit was made, only the discriminator):
`CC1PLPSX -quiet -O2 -G8 -dg` on the lane `.i` (private copy,
`scratchpad/w76/a20/nfs3/`). In the CURRENT (pinned) basin:
* `.greg`: `insn 54 (set (reg a0) (const_int 0))` then `insn 50 (set (reg a2)
  (const_int 0))` — TWO constant sets, NO copy.
* `.s`: `move $4,$0` then **`move $6,$4`** — insn 50's constant was rewritten into a
  copy from $a0 (the lowest-numbered reg recorded as holding 0; $zero is never *set*
  so reg_values[0] is empty — same ascending-scan shape as W75-A20's `_read_issue`).
* ⇒ **the trap-zero COPY is manufactured by reload_cse_regs (const flavour), not by
  reload inheritance.** The W75-A11 round-robin model keeps its validity for the
  REGISTER CHOICE (it was validated by prediction); reload_cse is the COPY actor.
  By the same economy, retail's `addu a0,a2,zero` / `addu a1,a0,zero` are most simply
  the same pass acting on retail's stream (reload_cse exists in the retail 2.8.0 lane),
  which RETIRES the untestable "retail inheritance" attribution without changing the
  requirement: retail's shape still needs `hard_reg_n_uses[$a0]==0` + an earlier reload
  (W75-A11 item 3 stands as the requirement, re-derived through a cited pass).
* **Cure attempt NOT applicable, by direction:** the clobber-escape/arg-launder cures
  SUPPRESS reload_cse's rewrite — but retail HAS the copy; suppressing ours moves away
  from retail. The residual is the register assignment, and the standing named angle is
  unchanged: a source shape in which the guard bound G is never a pseudo (W75-A11 tail).
  Left for the TU's owner; noted here so the certificate text can be corrected when
  that belt lands.

**Verdicts flipped this wave: 1 mechanism-attribution (nfs3.cpp trap-zero copy:
inheritance → reload_cse const-flavour, dump-cited), 0 gate changes; FntFlush's flip
was last wave's (confirmed + its two older scratchpad certificates marked superseded).
No other standing reload-inheritance certificate exists on any still-FAIL fn.**

---

## CLOSING SUMMARY

| task | outcome |
|---|---|
| 1 `[distribute_notes]` | BUILT into combine.c via apply_traces.py (both copies), cc1 + cc1plus rebuilt, codegen-neutral ×5 TUs, validated (Night negative certificate + 3 positive-control orphans), `[reload-order]` folded (+ found the second tree's unscripted `[reload-totals]`) |
| 2 vptr sweep | 89 sites censused; 27 relevant (FAIL-TU criterion) converted to plain member assignment — ALL codegen-neutral, kept; 62 classified not-relevant (PASS TU, no §24A pattern); 0 PASS→FAIL |
| 3 inheritance re-check | inventory complete: FntFlush already flipped (W75-A15, confirmed + 2 older certificates superseded); nfs3.cpp copy-actor flipped to reload_cse by a new `-dg` run; trnsmult/spchrule out of scope (fns not FAIL) |

**Contract compliance:** zero PASS→FAIL tree-wide (every touched TU gated twice, per-fn
lists diffed); no commits/stage/push; `tools/build.py` never opened for writing (its
uncommitted foreign hunks untouched); memory dir read-only; no post-compile rows added;
no pins added (**PIN-SEALED items: none**); no probe TU left behind by this belt
(edits were surgical; note: an UNTRACKED `recon/frontend/common/femenudefs__w76p.cpp`
belonging to ANOTHER belt exists — orchestrator should confirm its owner deletes it,
and that my 2 femenudefs sites survive if that belt whole-file-writes the TU).

**Files changed by this belt:**
* `scratch/instr/apply_traces.py` + `C:\Temp\nfs4-instr-cc1\apply_traces.py` (mirrored; +patch_reload_order, +patch_distribute_notes)
* `scratch/gccsrc/gcc-2.8.1/combine.c` and `C:\Temp\gccsrc\gcc-2.8.1\{combine.c, reload1.c}` (instrumented, .orig backups kept)
* `scratch/gccbuild-ecoff/cc1.exe` (1 995 558 B) + `cc1plus.exe` (2 556 027 B) — rebuilt, codegen-neutral (pre-patch copies in `scratchpad/w76/a20/`)
* `recon/frontend/common/{femenudefs,feapp,front}.cpp` — 27 vptr-store conversions, all gate-neutral
* `scratchpad/w76/a20/*` — logs, traces, census, .greg receipts, protected binaries
