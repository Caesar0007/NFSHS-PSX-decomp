# W63-A6 — libcd-B belt receipts (2026-08-15)

Base HEAD at start `10e1a01b`. Commits: `90111f6a`, `2baf3b86`, (StCdInterrupt), `ffc812de`.
`tu_order_audit` = 0 inversions. Every TU gated 2x after every landing; zero PASS→FAIL.

## 0. RE-GATED BASELINES vs the briefing (the board rows were stale on 2 of 11)

| fn | board % | RE-GATED baseline | final | Δ |
|---|---|---|---|---|
| iso9660 `CdSearchFile` | 90.31 | 42 (182/182) | **19** | −23 |
| iso9660 `CD_newmedia` | 98.18 | 11 (178/177) | 11 | — |
| cdread `CdRead` | 83.24 | 14 (105/103) | 14 | — |
| cdread `_read_int` | 97.20 | 15 (158/157) | 15 | — |
| cdread `_read_issue` | 91.52 | 15 (119/122) | **8 (122/122 count-EXACT)** | −7 |
| stcdint `StCdInterrupt` | 97.10 | 36 (575/583) | **27** | −9 |
| stcdint `_st_dma` | 92.74 | 25 (107/106) | 25 | — |
| streamhelp `StGetNext` | 99.89 | **PASS (46)** — row STALE | PASS | — |
| streamhelp `data_ready_callback` | 89.43 | 9 (34/35) | 9 | — |
| libapi/FIRST `firstfile` | 96.50 | 5 (104/103) | 5 | — |
| eacpsxz `cdfs.c` `CdReadyHandler` | 99.98 | **gate PASS (300)** — row STALE | PASS | — |

**Total −39 diffs, 0 regressions.**
`cdfs.cpp` in the briefing does not exist — the TU is `recon/eaclib/psx/eacpsxz/cdfs.c`.

## 1. DUAL-LANE SEAL — `CdReadyHandler` (already sealed, board row stale)
```
gate       CdReadyHandler: PASS (300 insns)
psyqproof  300 words (-G4), REAL=0 RELOP=0, reloc-site diffs=82 (pre-link unknowns)
```
⇒ **gate PASS + psyqproof REAL=0 = DUAL-LANE SEALED.** No source change needed.

## 2. LANDED — `CdSearchFile` 42 → 19

**(A) A REAL TRANSCRIPTION BUG, found by reading the oracle for an allocno conflict.**
The trailing diagnostic printed `name`; the oracle's second argument is
`addiu $a1,$sp,0x10` = `&comp[0]` (`asm/nonmatchings/main/CdSearchFile.s` @0x800F9320),
and the matched PsyQ-4.0 twin agrees (`C:/Temp/psyz/decomp/src/libcd/iso9660.c:118`).
Consequence beyond correctness: `name` stayed live across the entire final scan loop
(qty272: refs 6 / live 88 / crosses 5 calls) and **conflicted with that loop's `_cd_dir`
address givs** — pseudo 154 (`_cd_dir+8`, refs 7 / live 14 / pri 10000) was allocated
first and took the `$s3` retail gives `name`. Fixing the argument killed the conflict
outright: **42 → 37**.

**(B) reqdelta272-priced zero-insn ref dial.** With 154 out of the way qty272 read
`sep .2000 ($s3) > name .1754 ($s4) > notfound .0517 ($s5)` — exactly inverted from
retail (`name $s3 / notfound $s4 / sep $s5`). An in-loop read-only fence operand is
+2 loop-weighted refs; `name` ×1 + `notfound` ×2 lifts both over `sep`. **37 → 19**,
zero instructions (181 both sides), all registers now retail-exact.
Operand grid (`probe_iso7.py`): x1/x1 = 23 · **x1/x2 = 19 (minimal)** · x2/x2 = x2/x3 =
x3/x3 = x3/x4 = x4/x5 = 19 · x2/x4 = 37 (over-dial re-inverts name/notfound).

**RESIDUAL 19** = the inner split loop alone. Retail peels the entry guard, keeps a
caller-saved inner-preheader copy of the separator, and loads the SAME byte TWICE
(`lb` for the `!= sep` compare, `lbu` for the zero test AND the `*q` store).
Falsified on this basin (`probe_iso8.py`): `ch` as `u_char` decl-only 19 (inert) ·
zero-test off the cached `ch` 23 · explicit u_char cache + signed re-read 55 @177 ·
`*(u_char*)++s` 55 @177 · no cache at all 55 @177 — **every distinct-extension spelling
makes cc1-2.7.2 FUSE the lb+lbu pair and land 4-5 insns SHORT.**
Falsified on the pre-fence basin: the whole psyz-4.0 loop transplant (cached-`ch` test +
`fp++;fp--;`) 64-74 (`probe_iso.py`) · explicit peeled guard + do-while 82-90 (`probe_iso3.py`).
**NAMED ANGLE:** a zero-insn way to defeat the lb/lbu fusion without the known 13E
phantom-16-byte-`vars` frame growth.

## 3. LANDED — `_read_issue` 15 → 8, COUNT-EXACT 122/122

The w62-a6 receipt's own NAMED ANGLE, measured for the first time, **plus** a position dial:
1. split the sector value into its own local so the tail anchor is minted AFTER
   `CdPosToInt` (retail: `jal CdPosToInt` → `la _read_int` → `la _cdr` → `jal
   CdReadyCallback` with `sw v0,32(s0)` in its slot);
2. a zero-insn **void barrier** immediately before the anchor — reorg.c `stop_search_p`
   halts the backward scan at any asm, so the `lui $s0` half can no longer be stolen
   into an earlier jal's delay slot.
Neither alone moves it (both 15); together 12 @120/122 (`probe_issue.py`: Y1 15, Y3 15,
Y4 no-fence 19).
3. two more void barriers, position-swept (`probe_issue2.py`): before CdFlush 12 (inert) ·
   **after** CdFlush 11 · error-label head 9 · before-CdFlush+error 9 ·
   **after-CdFlush+error 8 @122/122**. POSITION is the dial (W45 fixpoint law).

## 4. LANDED — `StCdInterrupt` 36 → 27

One zero-insn void barrier at the head of the channel-mismatch tail
(`if (_st_slot[0] != 0x160 || channel mismatch) { … }`), found by a **mechanical
fence-POSITION sweep over every statement in the function** (`fencesweep.py`, ~90
candidate positions). Only that block moves: its three adjacent slots all measure 27,
every other position is 36 or worse. This is cluster (C) of the w52-a2 residual list
(retail RE-READS `_st_slot` here instead of reusing the cached base).

## 5. AXES CLOSED (negatives with receipts, all in-source)

- **`_read_int` / `_st_dma` / `CD_newmedia` / `data_ready_callback` / `CdRead`:** the
  void-barrier POSITION axis is CLOSED — the per-statement sweep finds nothing under the
  baseline. This is a *real* negative: the same sweep moved `_read_issue` 15→8 and
  `StCdInterrupt` 36→27 in this wave.
- **`CdRead`:** the switch residual is exactly *which arm is the `beq` fall-through*
  (retail pre-sets the DEFAULT's `li 0x246`, ours steals case-0x20's `li 0x249`).
  Every W47-a2 "pre-set the default" rewrite is WORSE: default-arm-in-the-middle 26
  @103/103 (count-exact but far worse) · default-first 21 @102 · if/else with the default
  pre-assigned 39 @102. Opaque-zero for `CdControlB`'s 3rd arg: 16 alone, 28 with the swap.
  A18's sotn angle (store-then-read-back discriminator) is **already in our source**.
- **`CD_newmedia`:** the matched-twin PVD-STRUCT COMPONENT_REF spelling
  (`(&lba)->i = ((IsoPVD*)buf)->ptLBA.i`, psyz iso9660.c:145 — the catalog's STRUCT-READ
  ANTI-DEP law on the load side) is **INERT** at 11; member-to-member 39; whole-union
  struct assignment 74 @171/177. ⇒ the `buf`-to-symbol const-fold is not a
  MEM_IN_STRUCT_P question.
- **`firstfile`:** basin has MOVED (now 5 @104/103, 1 LONG; the w59-a13 note's residual (2)
  is gone). The W43 array-decay-vs-`&scalar` law — which is exactly what the symptom looks
  like (ours separate-scratch + unfilled `lb` slot, retail self-temp) — is inert: a second
  `asm`-labelled scalar view 5 · with a cast 5 · `&arr[0]` 5 · identity/read-only fence on
  `p` 5 · every fence position 5 or 8. **NAMED ANGLE:** `scan` before `p` is count-EXACT
  103/103 at 18 — it *does* fill the slot, at the price of swapping `p`/`scan`
  ($a0↔$v1) through the prefix loop; that basin + a p/scan coloring dial is the only
  structurally-right route seen.
- **`data_ready_callback`:** sotn's two devices (element-pointer hoist, `do{}while(0)`
  scaffold) are already present / have nothing to lift — the residual is purely the
  anchor's HARD REGISTER ($a0 ours vs $a2 retail), and retail's body never uses `$a1` at
  all, so it is **not** "two other qtys took $a0/$a1". **NAMED ANGLE:** find what
  EXCLUDES $a0/$a1 from the numeric scan in retail (most likely the align-1 4-byte
  movstrsi block move reserving its own address registers) — read `[find_free_reg]` on
  the fenced count-exact basin, do not spell-probe.

## 6. CORPUS VERDICT (read-only; A18's harvest cross-checked against the gate)

- `C:/Temp/psyz/decomp/src/libcd/iso9660.c` (PsyQ 4.0, matched) — **paid off twice**: it
  confirmed the `printf(comp)` argument independently of the oracle, and its PVD struct
  gave a clean falsification. Its CdSearchFile *loop* shape does NOT port (64-74 vs 42).
- `C:/Temp/ps1-decomp-refs/sotn-decomp/src/main/psxsdk/libcd/cdread.c` (matched) — the
  named CdRead delta was already in our source; the arm-order reading it suggests is
  falsified above.
- psyz `libcd/c_004.c`/`c_009.c`/`c_011.c`/`cdread.c` and `libapi/a66.c` are all
  `INCLUDE_ASM` — no twin there for StCdInterrupt/_st_dma/StGetNext/data_ready_callback/
  firstfile (A18's table agrees).

## 7. TOOL PROMOTED-WORTHY

`scratchpad/w63a6/fencesweep.py` — mechanical void-barrier POSITION sweeper over one
function's statements (`<tu-rel> <FUNC> <start-marker> <end-marker>`; patches the REAL
path so PER_TU_FLAGS still applies, restores in `finally`). It found the StCdInterrupt
win in one run and CLOSED the axis on five other functions. This is the missing
mechanisation of the W45 fence-fixpoint law and belongs in `tools/`.

## 8. HAZARDS ENCOUNTERED

- **Mixed line endings inside one TU**: `iso9660.c` (349 CRLF / 405 LF at start) and
  `FIRST.c` (decl line CRLF, body lines LF) — every probe anchor had to be derived
  PER ANCHOR; two probes asserted-out before this was fixed (the assert saved them).
- **Heredoc backslash collapse fired once** (`'\\\\'` in a bash heredoc → wrong bytes,
  assertion caught it). All subsequent probe scripts written with the Write tool.
- Control-byte scan after every scripted edit: 0 control bytes in all five TUs.
