# W67-A6 — THE INFRASTRUCTURE SWEEP

Repo `C:\Temp\nfs4-decomp`, base `77c09895`.  Four named gaps, each landed with
its spec's acceptance met.  Every number below was measured in this run, at the
stated instant; a peer (W67-A5, `scratchpad/w67a5/gen_text_spine.py`) was LIVE
in `linkers/nfs4.ld` mid-run — that file is deliberately NOT in my commit.
Memory dir: READ-ONLY, untouched.  Fresh `tools/build.py --no-link` (rc 0,
508 recon objects) ran before any measurement.

---

## 1. psyqproof BRANCH_RETARGET hook (the w66-a1 §5.3 named gap) — LANDED

`tools/psyqproof.py` now applies `bp._apply_branch_retarget(rel_posix, s_file)`
immediately after `bp._apply_text_moves(...)` inside `_apply_probe_moves` —
exactly the `scratchpad/w66a1/pq.py` prototype's NEW block, minus the harness-
only build-module substitution (the shipped tool's cached `build_module()`
already returns the wired build.py).  The effective-row counter now counts BR
rows too (a BR-only TU no longer prints "NO-OP").  Direct call, not `getattr`:
if build.py ever loses the mechanism the prover fails LOUDLY rather than
measuring without it.

Discipline: `.bak` kept (`tools/psyqproof.py.bak` + scratchpad copy), file is
LF-only and stayed LF-only (byte-checked), `ast.parse` clean after the edit.

**Re-certification (2× each, shipped tool, no hooks — the untouched path):**

| fn | .bak baseline | landed tool (2×) |
|---|---|---|
| `iSND100hzserver` (sndpsxz/sserver.c) | REAL=0 RELOP=0, 12 reloc | **REAL=0 RELOP=0, 12 reloc** |
| `Night_KillNightDriving__Fv` (game/psx/night.cpp) | REAL=0 RELOP=0, 18 reloc | **REAL=0 RELOP=0, 18 reloc** |

**The two BR-rowed EA fns w66-a1 named unprovable (the other one =
`MCRD_handlecardevents`, per w66a1 §2 rows 3+5), under `--with-text-moves`:**

| fn | .bak (no hook) control | landed tool (2×) |
|---|---|---|
| `DrawBackground__11tScreenMain` (screenmain.cpp) | REAL=**1** | **REAL=0 RELOP=0** (822 words, -G0) |
| `MCRD_handlecardevents` (frontend/psx/memcard.c) | REAL=**1** | **REAL=0 RELOP=0** (211 words) |
| `Sim_MainGameLoop__Fv` (bonus, 5 rows fire) | — | **REAL=0 RELOP=0** (321 words) |

The control leg (.bak reads REAL=1 on both) proves the hook is load-bearing,
not vacuous.  Honest note: the change was made in 3 Edit steps (call + counter
+ docstring), each ast-parsed; the re-cert was run after the composite, not
between the steps.

## 2. probe_link implied-base DATA treatment + scratch-base control leg — LANDED

`tools/probe_link.py` (w66-a6 §3.2 spec + w66-a4 §7 control-leg correction):

* `.data/.sdata/.sbss/.bss` per object-section placed at the implied retail
  base (mode over that SECTION's symbols; data VAs from symbol_addrs + the
  `D_/DAT_/lbl_/jtbl_` placeholder names, VA band 0x80010000..0x80200000);
  NOBITS sections carry no bytes but their symbols resolve retail — the sndgs
  mechanism fix;
* `.rodata` placed from `linkers/nfs4_recon.rodata_placement.json` (the
  canonical rodownmap anchor map, §4 — votes can never anchor a jump table);
* overlap pruning trust-ordered (map ≫ votes), rejected/un-based sections go
  to PER-SECTION scratch bases 0x80400000+ (never a shared catch-all — the
  w66a4 attributability lesson), `.other` retained for COMMON/leftovers;
* NEW separate metric: placed initialized data regions inside the ROM are
  byte-compared (`DATA bytes compared/identical`, exact sections);
* `--no-data` = the legacy behaviour, bit-for-bit (control measured below);
  cache renamed `objdata2.json` (format v2: all-section symbols) so a stale
  v1 cache can never be silently consumed.

**Acceptance (target: sndpsxz losses recover, 161→169+, data counted, 2×):**

| leg | .text exact objs | .text identical bytes | DATA bytes |
|---|---|---|---|
| `--no-data` control (== old tool == standing baseline) | 161/443 | 765 060 (82.98%) | — |
| **data treatment, run 1** | **226/443** | **777 622 (84.34%)** | 53 010 / 56 502 (93.82%), 160/214 sections exact |
| **data treatment, run 2** | **226/443** | **777 622** | **identical** |

Per-object A/B vs the control: **0 objects LOST byte-exactness, 66 gained**;
worked exhibit `sndpsxz/sover.c.o` (the w66-a6 sndgs case) 3-differing → **0**.
One object is 1 byte worse (`fixdatan.c` 5→6) — the receipted `.rodata`
SPLIT-STORAGE object (w66a4 §4), not an exactness loss.  Note the standing
`link_probe.txt` header now carries `data_placed/data_bytes/data_identical`;
consumers of the old header line get the same leading fields.

## 3. tools/undefcall_audit.py — THE THIRD AUDIT CLASS (w66-a3 §4 / 18B) — BUILT

Calls to UNDEFINED callees are invisible to `verify_asm` (reloc-name lenient)
AND `calltarget_audit` (needs both VAs).  The new tool: every `R_MIPS_26`
reloc in `.text` whose target is not defined by any lane object → a site,
attributed to its enclosing function.  The defined set reuses
`tools/relink.py`'s own machinery (imported, not re-implemented — 12H).
Classes: `UNDEF` (blocking) vs `PROVIDED` (resolves only through a
`undefined_*_auto.txt` hard absolute — reported, the stale_absolutes family).

Anti-vacuity: batched objdump with empty-batch hard exits; a tree-wide run
that scanned <1000 call relocs refuses to report clean; `--selftest`
assembles a synthetic `jal never_defined` object and asserts the audit's own
code path flags it (known-POSITIVE) — passed.

**Validation + tree-wide (2× recon):**

| run | result |
|---|---|
| `--selftest` | synthetic undefined call flagged — OK |
| known-negative `--obj sim.cpp.o` | 116 call relocs, 0 sites |
| **recon lane tree-wide (2×)** | **15 779 call relocs, UNDEF=0, PROVIDED=0** (exit 0) |
| src lane tree-wide | 15 779 call relocs, **UNDEF=2** (exit 1): `PAD_state → PAD_convert` (src/eaclib/psx/pad.c.o), `INIT.c.o → ReadInitPadFlag` |

The 2 src-lane rows are exactly the W48 mis-attribution queue ("PAD_convert →
eaclib pad.c; ReadInitPadFlag → libapi/PAD.c — already PASS at their real
homes; the 4-layer re-attribution deferred") — the tool independently
re-derives that queue, which doubles as its tree-level known-positive.

## 4. tools/gen_ld.py — THE CANONICAL GENERATOR (w66-a4 §8 orchestrator action) — LANDED

Folds the three scratchpad legs into ONE owner:
w65a5 base (spine + .L LOCALIZE cut + ldfrags) + w66a3 `.bss` catch-all
widening (`*(.bss.*)` — the stream/streamhelp nobits runs were ORPHANS under
the un-widened script) + w66a4 `.rodata_main` + `.roNNNN` legs.  The census is
re-scanned fresh every run (15E); `--objdata` override prints loudly.  The
rodata anchor map is adopted as a canonical committed input:
`linkers/nfs4_recon.rodata_placement.json` (verbatim copy of
`scratchpad/w66a4/rodata_placement.json`, 101 rows).

**THE LANE-MARKER GUARD** (the clobber-with-empty-git-diff hazard): the
generator stamps `GENERATED by tools/gen_ld.py` and REFUSES to overwrite a
file whose marker names an unrecognised owner (recognised: itself + the
superseded `scratchpad/w65a5/gen_ld.py` stamp all three legs wrote);
`--take-over` overrides loudly.  Tested: a planted foreign marker
(`scratchpad/w99x1/...`) → refusal; `--take-over` → loud overwrite.

**Byte-identity proofs:**

| proof | result |
|---|---|
| w66a4 leg + its own (stale) objdata → `linkers/nfs4_recon.ld` | **byte-IDENTICAL to HEAD** (the HEAD file is reproducible; measured twice) |
| canonical tool + the SAME stale objdata | **identical to HEAD except exactly 3 receipted spots**: the 2 marker header lines + the 1 w66a3 `.bss` line |
| canonical tool, fresh census, run 1 vs run 2 | **byte-IDENTICAL** (idempotent) |
| `linkers/nfs4.ld` | **NEVER written** by the tool; `--check-nfs4ld` verifies all 233 cut-blob pieces / 5 stems present per-section exactly once in per-letter blob order (hash identical before/after) |
| link A/B, HEAD script vs canonical script, same rsp | **identical diagnostics**: undefined 0 (.L=0), multdef 804 (all blob-class, REAL=0), reloc-truncated 10, both legs |

**The one CONTENT delta of the committed regen vs HEAD** (fresh census, root-
caused): `.t0004` is now `fecars.cpp` @0x800161b0 (fedialog dropped).  A peer
landing shrank `feaudio.cpp.o`'s `.text` 0xa34→0xa30, so the spine now tiles
FLUSH with fecars (feaudio end == fecars base); fecars' own end 0x800186C8
overruns `fedialog`'s base 0x800186a8 by 0x20 — i.e. fecars' reconstruction is
32 B over its retail window, a pre-existing near-miss now visible in the
spine.  Named for the fecars belt; the greedy drop is correct behaviour.

**The scratchpad generator legs are DEAD** — do not run
`scratchpad/{w65a5,w66a3,w66a4}/gen_ld.py` again (the w66a4 §8 clobber was two
of them fighting; the marker guard now also physically refuses a stale-lane
overwrite since their stamp is the superseded one... note: their stamp is in
the RECOGNISED set so the guard permits THIS tool over THEIR file, not vice
versa — the legs themselves have no guard, hence: do not run them).

## 5. Standing gates at close

| gate | result |
|---|---|
| `tu_order_audit` | 508 objects, **0 inversions** |
| `relink --lane recon` | DUP 804 all blob-class / **REAL=0** / **HIDDEN PHANTOMS=0** / UNRESOLVED=5 (the ld-provided absolutes) — **GATE: GREEN** |
| `undefcall_audit --lane recon` | **UNDEF=0** (2×) |
| `gen_ld --link` strict | undefined **0** (.L=0), multdef 804, trunc 10 — same as the HEAD-script control |
| psyqproof re-certs | §1 table, all REAL=0 2× |
| PASS→FAIL | structurally 0 — **no recon source or shared header was touched** (the only non-tools files touched are the two generated/adopted linkers files) |

## 6. Hazards / notes

* **A LIVE PEER (W67-A5) modified `linkers/nfs4.ld` mid-run** (22:14, the
  gen_text_spine block).  My snapshot predates it; the canonical tool never
  writes that file; it is NOT in my commit (explicit-files staging).
* The `--check-nfs4ld` first cut wrongly assumed one reference per piece and
  name-order == file-order; nfs4.ld legitimately references every piece once
  PER SECTION region, and `.sdata` piece file-order is RETAIL order, not name
  order.  Corrected to per-(piece, section) uniqueness + per-letter ascending
  order before any verdict was recorded.
* Marker regex first cut clipped at the `.` in `gen_ld.py` (`\S+?` +
  terminator class) → refused its own lineage; fixed to greedy + rstrip.
* pipe-swallowed exit codes (`tool | tail; echo $?`) — re-measured the
  blocking exits directly (`undefcall_audit` src lane exit 1 confirmed).
* `.bak` files kept: `tools/psyqproof.py.bak`, `tools/probe_link.py.bak`
  (+ scratchpad copies `*.pre_w67a6.bak`).  Untracked by design.
* probe_link JSON/`link_probe.txt` gained data fields; `objdata.json` cache
  renamed `objdata2.json` (v2 format) — old caches cannot be mis-consumed.

## 7. Files committed (`w67a6:`, explicit paths)

`tools/psyqproof.py` · `tools/undefcall_audit.py` · `tools/gen_ld.py` ·
`tools/probe_link.py` · `linkers/nfs4_recon.ld` (canonical regen) ·
`linkers/nfs4_recon.rodata_placement.json` (adopted canonical input) ·
`scratchpad/w67a6/RECEIPTS.md`.

Evidence kept in `scratchpad/w67a6/`: `nfs4_recon.ld.HEAD` + `.canonical*`
(the byte-proof snapshots) · `objdata.w66a4.stale.json` / `objdata.fresh.json`
(the A/B censuses + the feaudio root-cause) · `probe_baseline.json` /
`probe_nodata.json` / `probe_data{1,2}.json` · `link_probe.{nodata,data}.txt`
(the 0-losses A/B) · `undefcall_{recon,src}.json` · `build1.log`.
