# W64-A20 -- PRODUCTION-LANE LEDGER (psq43 cc1 + ASPSX 2.77)

Supersedes `scratchpad/w63a20/PRODUCTION_LEDGER.md` (kept as the W63 snapshot).
Scope unchanged: every `MATCH_PROGRESS.txt` row at 100.00% under `game/**`,
`frontend/**`, `eaclib/**`.  The board grew during the wave: **2979 rows / 304
TUs** (2972 at W63 close + 7 peer seals).

Controls, re-certified after every write to `tools/psyqproof.py`:
`iSND100hzserver` REAL=0 RELOP=0 12 reloc - `Night_KillNightDriving__Fv`
REAL=0 RELOP=0 18 reloc.

---

## 1. THE CLOSING SWEEP (unchanged method, 0-worse bar met)

`scratchpad/w64a20/{jobgen,pqbatch2}.py` -> `w64_full.jsonl`, the W63 harness
re-run verbatim (it imports `tools/psyqproof.py`, so it picked up this wave's
hooks without re-implementing anything).

| | rows | |
|---|---:|---|
| REAL=0 and RELOP=0 | **2923** | production-identical modulo link |
| non-zero | 46 | every one SHIM-MASKED (unchanged set) |
| INAPPLICABLE_LANE | 10 | `eacpsxz/nsync.c` is wired `cc1_ver: 2.8.1` |
| **total** | **2979** | **2923/2979 = 98.12%**, 98.45% of provable rows |

**W63 -> W64: 0 rows worse, 0 rows better, 0 status changes.**  W63 was
2916/2972 = 98.12%; the +7 on both sides are the peer seals that landed during
the wave.  This is the receipt that the 27 source conversions in mission 1 moved
NOTHING on the production lane -- as their per-TU object hashes already proved
constructively.

---

## 2. 🔴 THE LEDGER'S READING OF THE 46 WAS WRONG (mission 3's real result)

The W63 ledger reported the shim-masked residual as psyqproof's raw number,
taken with **no per-fn mechanism applied**, and concluded:

> "The five heavies (310 / 276 / 241 / 184 / 168) are whole-schedule
> divergences, not one-line moves."

That is false.  `PER_FN_TEXT_MOVES` is a post-cc1 **line relocation**; one
displaced instruction shifts every following word, so a one-line move reads as
hundreds of diffs.  With the fn's own mechanism applied to the production `.s`
(new `--with-text-moves` hook, using build.py's OWN `_apply_text_moves`):

| fn | ledger residual | with its mechanism |
|---|---:|---:|
| `DrawW_DrawQuad` | 303+7 | **0+0** |
| `InGame_ResetPSXController` | 228+48 | **0+0** |
| `AudioCmn_SoundCar` | 218+23 | **0+0** |
| `DrawObjectSimple` | 160+24 | **0+0** |
| `Camera_UpdateTailCam` | 147+21 | **0+0** |
| ...and every other TEXT_MOVES row (33 total) | 1..17 | **0+0** |

### ANTI-VACUITY -- the leg that makes this a result

Under the **same** hook, the rows shimmed by a **different** mechanism do not
move at all, landing on their exact ledger values:

| fn | mechanism | measured |
|---|---|---:|
| `SPCH_AddEvent` | FORCE_ADDR | 36+9 |
| `FILE_completeop` | PROLOGUE_UNSINK | 6+2 |
| `CV_ColorTracks` | RA_SINK | 5+0 |
| `Weather_Init` | FORCE_ADDR | 3+4 |
| `padinit` | EPILOGUE_UNFILL | 3+0 |
| `AudioClc_SoundPlayersCar` | NO_THREAD_JUMPS | 3+0 |

and `AudioCmn_Init` reproduces the ledger's own -G8 row off the other hook
(`W64_PQ_TU_FLAGS g_value=8`: RELOP 8 -> 0).  So the hook discriminates; it does
not launder.

### The restated distance

These mechanisms are **lane-independent** -- they are textual edits to the
compiler's `.s`, downstream of cc1 and upstream of either assembler.  Applying
them on the production lane is therefore legitimate, not a fudge.  On that
basis:

| | rows | share |
|---|---:|---:|
| production-identical, no mechanism needed | 2923 | 98.12% |
| production-identical **with the fn's own mechanism** | +33 | |
| **subtotal** | **2956** | **99.23%** |
| residual: mechanism the prover still does not model | 13 | 0.44% |
| INAPPLICABLE_LANE (`nsync.c`, 2.8.1) | 10 | 0.34% |

**The gate<->production distance was never 46 unexplained rows.  It is ONE
un-modelled thing: the prover did not apply build.py's per-fn `.s` mechanisms.**

The honest open list is the **13**: `SPCH_AddEvent` (FORCE_ADDR),
`Weather_Init` (FORCE_ADDR), `CV_ColorTracks` (RA_SINK), `padinit` +
`PAD_state` (EPILOGUE_UNFILL), `PAD_restore` (NO_DELAYED_BRANCH),
`AudioClc_SoundPlayersCar` (NO_THREAD_JUMPS), `FILE_completeop`
(PROLOGUE_UNSINK), `AudioCmn_Init` (G8 -- already cured, wants a per-region
flag splice), plus the four `femenu*`/`screenusername` rows whose mechanism is
TEXT_MOVES on a **user-live TU** and which I did not re-measure to avoid
touching those files.

### What this does NOT claim

It does not say those 33 functions' SOURCE is right.  It says their production
residual is exactly the same post-cc1 edit the gate applies -- so they are no
worse on the production lane than on the gate lane, and any remaining doubt is
about the mechanism itself, identically on both.  Retiring a mechanism stays a
source problem, tracked per-fn.

---

## 3. MISSION 1: the GNU-dialect source pass (27 TUs landed)

The shim made 29 EA TUs *provable*; it did not make them *buildable* -- ASPSX
2.77 refused the source as written.  Converted at the source, with the shim
still in place as belt-and-braces:

`crc blkfill blkmov fileroot fixdmult fixdsqrt getm math64a nasync nfile random
savegp shpdepth shpsubs nullfunc fixddiv fixdinv sinfunc fastmovf movf`
(eacpsxz) + `screencarselect screencontroller` (frontend/common) + `drawc`
(game/psx) + `hrzsku` (swept into a peer commit).

Acceptance per TU (`verify_tu.py`), both lanes:
* **gate**: build.py object sha256 identical BEFORE vs AFTER (a byte-identical
  object is a *constructive* zero-PASS->FAIL proof, stronger than re-diffing);
  where only the ELF symtab ORDER moved (nullfunc, sinfunc) the disassembly,
  relocs and the (addr,size,name) symbol set are identical.  tugate re-run on
  every TU, unchanged.
* **production**: ASPSX object identical shim-ON vs shim-OFF **and** identical
  to the pre-edit shim-ON object; shim-OFF went from an ASPSX error to OK.

Constructs and cures:

| construct | cure |
|---|---|
| ABI register names | numeric |
| `.set push/pop` | explicit axis restore, **space form** -- maspsx only parses `.set<TAB>` (`maspsx/__init__.py:1013`), so it is a maspsx no-op that reaches gnu-as exactly as `pop` did |
| `sym2 = sym` | a second LABEL at the same address (ASPSX has no symbol-assignment form at all) |
| raw `divu $zero,rs,rt` | `.word` -- GNU-as needs the 3-operand `$zero` form, ASPSX expands that WITH a /0 guard, ASPSX's own 2-operand form makes maspsx die; only the machine word suits both |
| `.type` / `.size` | dropped -- ELF-only and redundant with `fix_symsizes.py` (object came out bit-identical) |

### Two named residuals

1. **`draww.cpp` -- a COUPLED landing** (patch + JSON spec in this directory).
   The conversion is right, but build.py's `DrawW_DrawQuad` TEXT_MOVES row pins
   its `after` anchor on the ABI spelling:
   `r"\$L\d+:\n(?= \#APP\n\tlw\t\$t4,0\(\$2\)\n)"`.  Convert the source and the
   anchor stops matching, the move never fires, DrawQuad loses its PASS.  This
   is catalog **15D's anchor law from the other side** -- and it is the ONLY
   anchor in the whole build.py that names an ABI register
   (`grep '\$t[0-9]' tools/build.py` = 1 hit, line 1711).
   **Probe-verified cure** (vprobe `W60_TEXT_MOVES_FILE`): lookahead becomes
   `\tlw\t\$12,0\(\$2\)\n` -> DrawQuad **PASS 592/592**.  build.py is
   orchestrator-owned, so source + anchor must land together.
2. **`eacpsxz/isqrttbl.c`** -- `decodeshiftjis2/3` stay symbol assignments.
   Their target is the SECOND function body, and **CC1PSX emits a file-scope
   `__asm__` ahead of ALL function bodies**, so a label there attaches to the
   first (measured: the labels landed on `remapshiftjiscode`, `.text+0` size
   0x28, instead of `+0x28` size 0x68).  Reordering the two functions would
   break the retail intra-TU VA order (`tu_order_audit`).
   This refines catalog **12B** ("file-scope `__asm__` is NOT hoisted"): on the
   C lane it *is* placed ahead of every function body.

---

## 4. FILES

| file | what |
|---|---|
| `PRODUCTION_LEDGER.md` | this document |
| `RECEIPTS.md` | the agent receipt: method, measurements, hazards |
| `w64_full.jsonl` | the 2979-row closing sweep |
| `heavies.py` / `heavies.json` | the 46-row with/without-mechanism re-pricing |
| `aspsxify.py` | the source converter (rules 1-5, comment-safe) |
| `verify_tu.py` / `prodobj.py` / `prove.py` | the two-lane acceptance harness |
| `appcensus.py` / `appcensus.jsonl` | the `#APP`-scoped dialect census (510 TUs) |
| `mixcheck.py` | asm-template both-ways-spelled detector |
| `draww_source.patch` / `draww_moves.json` | the coupled draww spec |
| `jobgen.py` / `pqbatch2.py` | the sweep harness (W63's, re-run) |
