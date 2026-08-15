# W64-A21 RECEIPTS — board reconciliation auditor

Deliverable: `BOARD_RECONCILIATION.md` (same directory). All timings WAST 2026-08-15.
Concurrency: ~20 belts building throughout; every measurement is timestamped and the
rows that moved under me are listed in §7 of the deliverable.

## R1 — lane identity (mission step 1)

| question | evidence |
|---|---|
| what lane does the board build? | `objdiff.json` `custom_make` = python + `tools/build.py --skip-asm`; `base_path` = `build/recon/<tu>.<ext>.o` |
| is that the same object verify_asm gates? | `tools/build.py:2230 compile_cpp` → `obj = OUT / (str(rel)+".o")` with `OUT = BUILD` (`verify_asm.py:18` sets `bld.OUT = bld.BUILD`). **Same path.** Confirmed empirically: gating a TU rewrites the very object the next `report generate` reads (used deliberately in R3). |
| does `report generate` build? | No — 461 units in 0.17 s, no compiler invoked. `update_match_progress.py` runs `build.py` separately first. |
| ⇒ does the board miss PER_TU/PER_FN shims? | **No.** They are applied by definition. **Class (b) = 0 rows.** |

## R2 — what the board metric charges for (mission step 1, second half)

Three back-to-back `report generate` runs over identical objects
(`bA.json` default, `bB.json` `-c functionRelocDiffs=none`, `bC.json` `=all`):

* default vs none: **0 of 3489 rows differ** ⇒ relocation name/addend differences are
  ALREADY free in `fuzzy_match_percent`.
* `=all`: 3355 → 2130 rows at 100 ⇒ 1225 rows carry a reloc difference that the default
  metric ignores.
* per-row fit (`fuzzyfit.py`): `(100−fuzzy)/100 × n_insns` = `1.00 × inserts/deletes +
  0.05 × surviving arg mismatches`. Exact on `stup0` (4 deletes / 7 → 42.857),
  `func_8010CA40` (4 args / 9 → 97.778), `__divsf3` (2 / 81 → 99.877),
  `Camera_UpdateHeliCam` (1 branch / 443 → 99.9887).

⇒ the mission's class (c) "reloc rendering costs board points" is **falsified**.

## R3 — the census (mission step 2)

1. worklist = every row non-100 on the committed board **or** on a fresh regen = **150 rows / 82 TUs**.
2. 82 TUs whole-TU gated (`w64a21_gate.py`, drives `verify_asm.py`'s own module — same
   compile, normalisers, and the w59-a9 dead-`%hi` collapse; anti-drift per catalog 12H).
   17:11:50 → 17:13:46.
3. board regenerated AFTER (2) so both lanes read the same objects → `board_after.json`.
4. per-row mechanism via `objdiff-cli diff -u <unit> <sym>` → `objclass.py` classifier
   (RELOC_ALIAS / RELOC_UNK / RELOC_DIFF / BRANCH_DEST / STRUCT / OTHER / DATA).
5. gate-PASS rows re-gated + re-measured at 17:28–17:32 against current objects.

Result: **a=101, b=0, c=4 (+1 fixed), d=27, e=19.**

Hazards hit and fixed:
* my first TU list was written with python's default newline → CRLF; `xargs` passed
  `path\r` and **all 82 TUs "failed to compile"** with a filename containing a newline.
  (The AGENT_GUIDE CRLF hazard in a new costume.) Re-written with `newline='\n'`.
* 14 TUs then failed as "No such file": `objdiff.json`'s `metadata.source_path` says
  `.cpp` where the recon file is `.c` (task-#90 C-lane migration). Remapped; reported as
  a hygiene defect (§8.1 of the deliverable).
* `recon/game/common/newton.cpp` failed to compile at 17:12 and compiled clean at 17:15 —
  a belt mid-edit. Re-gated.

## R4 — class d cross-check (mission step 2d: "cross-check psyqproof + brdist")

`tools/brdist.py` run over all 23 TUs holding a BRANCH_DEST row (fresh compile,
independent per-branch DISTANCE comparison): **27 of 28 candidates confirmed**, with the
exact (index, ours, oracle) triples now in the deliverable's table. The 28th,
`StatChk_IsTopTime__FP10Car_tStatss`, was a belt transient — hand-verified byte-identical
(`objdump` of both objects) and clean on the 17:29 re-measure.

Shape: 17 rows are ±1-instruction shifts, 10 are whole-block routing differences.

## R5 — LANDED FIX: `stup0` 42.86 % → 100.00 % (commit `7a662a6e`)

Not the reloc class — the **st_size** class (W52 "fix_symsizes truncation / PATCHGTE 50 %").
Baseline: gate PASS 7/7, board 42.857 (= 3/7).

Root cause, proven from the two symtabs:
* `expected/src/.../2mbyte.c.o`: `stup0` @0xa0 **size 0x1c**, `D_800E40D8` @0xac global
  `STT_FUNC` size 0x10 (splat's `nonmatching stup0, 0x1C` + `alabel`).
* `build/recon/.../2mbyte.c.o`: `stup0` @0xa8 **size 0x0c**, `D_800E40D8` @0xb4 **local,
  size 0** — `tools/fix_symsizes.py` sizes a size-less global up to the *next symbol value*,
  and the interior label is that next symbol.

Angles considered:
* rename the interior label `.L…` (fix_symsizes excludes `.L*` as a boundary) — **rejected**:
  our object would stop defining `D_800E40D8` and objdiff's row for it would break.
* patch `fix_symsizes.py` to skip LOCAL symbols as boundaries — **rejected**: `tools/*.py`
  is orchestrator-owned, and it would silently re-size symbols tree-wide.
* explicit `.type`/`.size` in the recon asm (precedent: `PATCH.c` `func_8010CA40`,
  `PATCHGTE.c`) — **adopted**. `fix_symsizes` only fills `size==0`, so an explicit size wins.
  ⚠️ first attempt (stup0 only) moved `D_800E40D8` 100.00 → 0.00 because stup0's new extent
  swallowed its bytes; the landed version also gives `D_800E40D8` the expected object's own
  shape (`.globl` + `@function` + `0x10`). Only this TU defines/uses the name
  (`stup1`'s `%hi/%lo` pair), so the global binding cannot collide at link.

Receipts: gate **2× 4/4 PASS** (unchanged) · `psyqproof` **REAL=0 RELOP=0** on stup0, stup1,
`__main`, `__SN_ENTRY_POINT` · `tu_order_audit` 0 inversions · board regen: `stup0`
42.86 → 100.00, `D_800E40D8` stays 100.00, **zero rows moved the wrong direction** ·
symtab now mirrors the expected object exactly · CRLF preserved, 0 NUL/control bytes ·
backup `scratchpad/w64a21/2mbyte.c.bak` · staged by explicit path.

🔗 **COORDINATION FLAG for the orchestrator:** the immediately preceding commit
(`8eb3987c`, w64-a20) drops `.type`/`.size` from `draww.cpp`'s file-scope asm as part of
making 27 GNU-dialect TUs ASPSX-buildable ("retiring the W52 workaround"). My fix *adds*
them to `2mbyte.c`. They are not in conflict today — I measured `psyqproof` REAL=0
RELOP=0 on all four 2mbyte symbols **after** the edit — but if a tree-wide `.type`/`.size`
purge is planned, `stup0` needs the equivalent expressed another way (e.g. moving the
inline table out of the symbol, or teaching `fix_symsizes` not to treat a LOCAL label as a
sizing boundary) or the board row silently reverts to 42.86 %.

## R6 — NOT landed (specced, per mission step 3)

* **splat literal-`D_` pseudo-labels** (4 rows: `func_8010CA40`, `__divsf3`,
  `AISpeeds_CalcOpponentTopSpeed`, `R3DCar_CalcCarDimensions`). Byte-identical after link;
  the gate already resolves them (w52-a9 `_literal_dlabel`). objdiff cannot: the *expected*
  object carries a real `R_MIPS_HI16/LO16` there and ours carries none, so no
  `functionRelocDiffs` setting reaches it (verified under `none`/`default`/`all`). The fix
  is an ORACLE-side relabel of `%hi/%lo(D_<literal>)` → bare constants in 4 `.s` files =
  a 4-layer rename touching CI. **Orchestrator call.** Yield +4 rows ≈ +0.11 %.
* **`tools/strict_branch.py` / `tools/ownmap.py` `ROOT = parents[2]`** (resolves to
  `C:\Temp`, not the repo — `strict_branch` finds no objects, silently). One-character fix
  to `parents[1]`; `ownmap` additionally imports a missing `blobparse`. tools/ = orchestrator.
* **`objdiff.json` stale `metadata.source_path` on 14 units** — regenerate with
  `tools/gen_objdiff_units.py`.
* **NO change to `tools/update_match_progress.py`** is warranted: the tool is correct, the
  lane is correct, and its `SUPERSEDED` list is current. **What IS needed is simply to
  re-run it** — the committed board understates the fresh one by 18 rows.

## R7 — NEW FINDING: the fourth blind spot (reloc TARGET identity)

Neither lane charges for calling the wrong function: `verify_asm` is reloc-name lenient by
design, and R2 shows the board ignores relocs entirely. `calltarget_audit.py` closes it
(15 s over 461 units): **147 sites / 96 distinct pairs** where both sides name a real symbol
in `configs/symbol_addrs.txt` at DIFFERENT VAs, with section-relative `.text`+addend relocs
(the file-static callee form) excluded because objdiff renders those as the *containing*
symbol's name and a difference there proves nothing.

Two families: (1) C++ hierarchy depth — retail chains to the BASE, we chain to an
INTERMEDIATE (`___7tScreen` vs `___12tDialogYesNo` ×16, `___24tMenuItemLeftRightChoice` vs
`___31tMenuItemOptionsLeftRightChoice` ×9, `___11AIHigh_Base` vs `___14AIHigh_BTC_Cop` ×2,
…); (2) wrong overload binding — `AIWorld_ApxSplineDistance` (4 overloads at 4 VAs, owner
declares all four, consumers' `*_externs.h` declare one) at 5 call sites in
`game/common/{ai,aicop,aispeeds}`. Recommend promoting the tool to `tools/` as a standing
wave-close check.

## R8 — files touched

* landed: `recon/syslib/psx/2mbyte/2mbyte.c` (+19 lines, symbol metadata only) — commit
  `7a662a6e` `w64a21: stup0 symbol SIZE fix`.
* created: `scratchpad/w64a21/**` (10 scripts + data + this file + the deliverable).
* **not touched**: `tools/**`, `build.py`, the memory dir, and every user-live TU.
