# W67-A5 RECEIPTS — THE SRC-LANE CLEAN LINK

Repo `C:\Temp\nfs4-decomp`, wave W67, 2026-08-15.  Base HEAD `2f455291`
(w67a1 landed mid-wave; every number below re-measured by me, never quoted).
Files touched: 3 src TUs (1 new), 5 asm/nonmatchings files (1 new),
`linkers/nfs4.ld`.  Tools untouched; memory dir untouched; MATCH_PROGRESS.txt
untouched (regen run for verification, then restored to HEAD).

## 0. HEADLINE

| axis | briefed | measured baseline | after |
|---|---|---|---|
| relink src REAL duplicates | 5 | **5** | **0** (GATE GREEN, `ld -r` rc 1→0) |
| relink src HIDDEN PHANTOMS | 0 | 0 | 0 |
| relink src UNRESOLVED (reloc) | — | 202 | **200** (−PAD_convert, −ReadInitPadFlag) |
| src-lane full-link (srclink) undefined: PAD_convert/ReadInitPadFlag | 2 | 2 | **0** |
| src-lane full-link multiple-definition lines | 5 findings | 5 | **0** |
| src-lane full-link stderr lines | "fall from 14" | **931** (see §1) | 918 defect-landing / 959 post-spine (coalescing-only, §4.2) |
| src-lane distinct undefined names | — | 65 | **63** (the 63 = pre-existing A6-belt class, §1) |
| `.text` order vs spine | catch-all (command-line order) | — | **map == generator order 459/459; strict spine (365) a subsequence** |
| splat image byte-identity (P6) | required | sha1 `ea07306d…` 240464 B | **byte-identical A/B/A′, stderr identical** |
| board metric | no double-count, no regen commit | 3489/3389 | regen (verified, NOT committed): **3490/3390 — exactly +1 row** (PAD_convert), reproducible 2× |

## 1. THE "14" BASELINE NO LONGER EXISTS — measured correction to the brief

W65-A7's 14-line snapshot (`02a03a9d`, 08-15 18:25) predates W65-A6's
`380217a3` (08-15 22:0x), which stripped **132 stale hard-assignments** from
`linkers/undefined_syms_auto.txt` and moved that storage into RECON TUs.  The
SRC lane has no owner for those symbols (`asm/data/bss.bss.s` and
`sbss.sbss.s` are 6-line empty stubs since the scaffold commit), so the src
full link now reports **63 distinct undefined data/BSS names**
(CChannel/StCHANNEL/St* libcd-stream set, sndgs/sndpd/sndpp/… sndpsxz set,
gPadinfo/Padglobal, D_8014xxxx BSS, currentwindow/currentdirectory, …) =
931 stderr lines at my baseline.  **This class is NOT mine** (data lane: the
src lane needs either a bss dlabel fragment or its own assignment script —
adding dlabels to the shared `bss.bss.s` would collide with the recon lane's
A6 storage, both lanes link `build/asm`).  Named angle, receipted for the
orchestrator; my acceptance is measured against the 931 baseline and the
mission's three named classes, all of which went to 0.

## 2. MISSION 1 — the 2 INCLUDE_ASM restored (report-neutral)

* `src/eaclib/psx/pad.c`: `INCLUDE_ASM(..., PAD_convert)` inserted between
  PAD_state and PAD_update — retail VA order 0x800E41AC < **0x800E41FC** <
  0x800E4210.  Object offsets after rebuild reproduce the retail deltas
  exactly (PAD_convert @+0x114 = 0x800E40E8+0x114 = 0x800E41FC ✔,
  PAD_update @+0x128 ✔).
* `src/syslib/psx/libapi/PAD.c` **NEW** (retail owner: libapi.lib(PAD.OBJ) =
  the single fn ReadInitPadFlag @0x8010C9B0; recon owner
  `recon/syslib/psx/libapi/PAD.c`, gate PASS).  The old stub sat in the WRONG
  unit (`src/syslib/psx/libpad/PAD.c`, removed 2026-08-10) — restoring it
  THERE would have re-created the phantom rows; the new TU has **no objdiff
  unit**, so it adds no report row at all.
* **Report neutrality PROVEN** (`repcheck.py`, `report_r1/r2.json`,
  `MATCH_PROGRESS_r1/r2.txt`):
  - objdiff report reproducible 2× (raw rows 3497, byte-equal board files).
  - Through update_match_progress's SUPERSEDED filter: **PAD_convert counts
    exactly ONCE** (`eaclib/psx/pad` @100%; the stale `syslib/psx/libpad/PAD`
    0% row stays filtered) → TOTAL 3489→3490, matched 3389→3390.
    **ReadInitPadFlag contributes zero rows** (no unit) — no double-count
    anywhere.
  - Only other board delta: `_set_intr_callback` 97.17→96.50 — **stale-expected
    artifact predating this landing** (control-proven: rebuilding expected
    INTR.c.o from HEAD src at today's tree gives the same 96.50; the recon
    base drifted at w65-a6 while `expected/` dated Aug 9).  Not mine.
  - `MATCH_PROGRESS.txt` restored to HEAD after verification (NOT committed);
    the 5 touched `expected/src/**` targets were refreshed (git-ignored tree).

## 3. MISSION 2 — the retail-static-copy duplicates LOCALIZED (5 → 0)

Recipe = w65-a7 §3.2 / the 16E `.L` decision: in the `_<VA>`-suffixed splat
file, bind the symbol LOCAL (`.type X,@function` + label, no `.globl`).

| dup | localized copy | global stays |
|---|---|---|
| VoxSentence_GetNumPhrases | `_8010B100.s` (spchrule static) | spchdata @0x80100730 (canonical) |
| iSPCH_GetOffset8 | `_8010B10C.s` (spchrule static) | spchdata @0x80100748 (canonical) |
| iSPCH_GetOffset16 | `_8010B124.s` (spchrule static) | spchdata `_80100760.s` (lane's sole global; canonical 0x800E6EA8 is a recon-only static in spchevnt — src spchevnt callers bind to spchdata exactly as before) |
| ___15AIHigh_BTC_Perp | `_80061348.s` (deleting dtor, SYM `_._`) | aihigh @0x8005B438 (member dtor) |
| _bzero_w | **NEW `_bzero_w_800F2E70.s`**, INTR.c repointed to it | INTR_DMA keeps `_bzero_w.s` @0x80106924 |

* **The _bzero_w defect was deeper than a binding**: BOTH src TUs included
  the SAME `_bzero_w.s` (the 0x80106924 INTR_DMA copy) — the 0x800F2E70
  INTR.OBJ copy had never been extracted (it hides between RestartCallback
  and setfont; no splat file covers it).  The new file carries the ROM bytes
  @file-off 0xE3670 (9-word stream, **byte-verified identical** to the
  INTR_DMA copy, and correctly NO trailing pad word — setfont starts flush
  at 0x800F2E94, while the 0x80106924 copy carries an inter-obj pad nop).
* **Byte-neutrality measured** (objcopy `.text` compare, before/after):
  - `aih_btcperp.c.o` .text **IDENTICAL** (7500 B); binding T→t.
  - `spchrule.c.o` same length (1196 B); 3 words differ = the in-TU `jal`s
    now assembler-resolved to the TU's OWN local copies (0x44C/0x458/0x470)
    instead of an R_MIPS_26 against the global — the linked bytes are the
    LO16/addend equivalence class, and the BINDING is now retail-true
    (spchrule's callers call spchrule's statics; before the fix they linked
    to whichever global won).
  - `INTR.c.o` 1612→1608 B: −4 = the foreign copy's pad nop gone
    (retail-true), + `_initIntr`'s `jal` locally resolved.
  - `pad.c.o` 540→560 B = the restored PAD_convert body (mission 1).
* No external asm caller references `___15AIHigh_BTC_Perp` or `_bzero_w`
  (grep: only the defining files); spch cross-TU callers bind to the
  remaining globals as before.

## 4. MISSION 3 — the W62-A19 .text spine ported into `linkers/nfs4.ld`

### 4.1 Shape
Generator `scratchpad/w67a5/gen_text_spine.py` (probe_link's spine rule,
verbatim: implied base = retail VA − section offset, mode over the object's
.text symbols; `type:func` VAs, multi-VA names excluded — 5, printed).  459
src objects with .text; 365 = the strict spine, **94 interleavers** (vs the
recon lane's 18 — src TUs span multiple retail VA clusters, so whole-object
spans overlap more).  Since `.nfs4` is one CONTIGUOUS region (no absolute
per-object bases), relative order is all there is: ALL 459 are emitted in
ascending implied-base order with interleavers annotated in place — the
strict spine stays a subsequence, and an interleaver at its sorted position
reproduces retail order strictly better than the catch-all tail would.
* 🔴 **Every generated entry is a WILDCARD (`*/src/<rel>(.text)`), never an
  exact filename** — the W65-A7 absolute-path trap generalized: an exact
  filename inside SECTIONS that is not already a loaded input is OPENED BY LD
  AS AN ADDITIONAL INPUT.  `build.py`'s splat link passes no object list, so
  exact names would drag all 460 src objects into the splat image.  A
  wildcard never loads a file → byte-identity BY CONSTRUCTION (and still
  proven, §4.3).  The existing exact `front.c.o`/`main.c.o` entries (empty
  shells, already script-loaded) stay pinned first; `build/src/*(.text)`
  stays as the trailing catch-all for no-base objects.

### 4.2 Acceptance, measured (`mapcheck.py`, `errcmp.py`)
* **map == generator order 459/459**, linked addresses monotone, strict
  spine (365) a subsequence — the full link now REPRODUCES the spine.
* Splat P6: **byte-identical A/B/A′** (`ldneutral.py`, sha1 `ea07306d…`,
  240464 B, stderr identical 2079 lines).
* srclink raw lines 918→959 across the reorder — **presentation only**: ld
  coalesces consecutive same-symbol undefined messages ("more undefined
  references to X follow") differently under a different object order.
  Defect-level A/B: distinct undefined names **63 == 63 (zero delta)**,
  multiple-defs 0==0, truncations 0==0, discards 0==0.  Run 2× — identical.
* relink src (2×): REAL=0, PHANTOMS=0, `ld -r` rc=0, UNRESOLVED 200.
  relink recon: GREEN (REAL=0, PHANTOMS=0; 5 unresolved = the linker-script
  symbols `_gp`/`ticksA`/`__last_org`/`D_1000001`/`D_80000004`, invisible to
  `ld -r` by construction — standing, not new).
* tu_order_audit: 508 objects, **0 inversions** (5 multi-VA excluded).
* probe_link (recon lane, for the record): 82.76% in-place, 159/442 exact.

## 5. LEDGER (all numbers re-gated by me)

| gate | before | after |
|---|---|---|
| relink src REAL / PHANTOM / rc | 5 / 0 / 1 | 0 / 0 / 0 |
| relink src unresolved-reloc | 202 | 200 |
| srclink multiple-definition | 5 | 0 |
| srclink distinct undefined | 65 | 63 |
| srclink lines | 931 | 918 (defects) / 959 (post-spine, coalescing) |
| map order vs spine | n/a | 459/459 exact |
| splat P6 | sha1 ea07306d | ea07306d (identical) |
| board (verified, not committed) | 3489/3389 | 3490/3390, +1 row, reproducible 2× |

## 6. HAZARDS / NOTES

1. **Heredoc backslash collapse fired again** (a `'\\'` in a `python - <<EOF`
   became `'\'` → SyntaxError).  Write-tool for any escape-bearing script, as
   banked.
2. **Transient BFD crash on the first relink** (`internal error … _bfd_doprnt`
   while printing an error involving `libc/C21.c.o`) — vanished on re-run;
   peer-churn class (w67a1 committed 1 min before my first probe).  If it
   recurs deterministically, it is worth a standing note.
3. **`expected/` is 6 days stale tree-wide** (Aug 9); w65-a6's recon drift
   means a full orchestrator regen will shift a handful of fuzzy% rows that
   have nothing to do with their TUs' asm (the `_set_intr_callback`
   97.17→96.50 class, control-proven).  A tree-wide
   `build.py --out expected --no-link` + regen commit would zero this class.
4. The 63-name src-lane undefined class (§1) is the natural next src-lane
   task (needs a data-lane owner decision, coordinate with A5/A6's blob
   ownership work — NOT a unilateral `bss.bss.s` edit).
5. Backups: `scratchpad/w67a5/before/*.o` (pre-edit objects),
   `nfs4.ld.pre_spine`, `INTR.c.w67a5`; probes/maps/reports all in
   `scratchpad/w67a5/`.
