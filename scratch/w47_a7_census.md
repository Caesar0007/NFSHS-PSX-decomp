# WAVE-47 a7 — per-object `-G` SIGNATURE CENSUS + measured probe deltas

Tool: `tools/w47_a7_gcensus.py` (committed). Probe harness: `scratch/w47_a7_probe.py`.
Tables: `scratch/w47_a7_census_all.md` (461 objects) · `scratch/w47_a7_census_eaclib.md` (151) + JSON.
**`tools/build.py` is CLEAN** — probe patches were applied in this worktree, measured, and reverted.

---

## 0. HEADLINE RESULTS

1. 🏆 **The entire front overlay is `-G0`.** 0 GPREL16 relocs across all 50 overlay
   objects vs 2378 elsewhere; the map has *no front sdata/sbss group at all*.
   `screencontroller.cpp`'s proven `g_value "0"` is a **class rule**, not a one-off.
2. 🔴 **The eaclib `-G` axis is CLOSED — no eaclib TU should change its `-G`.** Measured on
   6 TUs: `-G4 ≡ -G8` byte-for-byte in **every** one, and **every** `-G0`/`-G2` candidate
   regresses. `spchrule`'s −3 was **not** a `-G` finding — a9 showed it was one scalar-declared
   extern, fixed as a source edit. **Joint closure with a9** (who measured `G4≡G8` in 31/31
   failing eaclib TUs, `G0` better nowhere).
3. ⚠️ **The whole ADDRESSING-side UPPER bound is UNSOUND** (a9): a `%hi/%lo` access to a
   ≤4-byte symbol is evidence about the **declaration shape**, not about `-G` — an unsized or
   over-declared `extern` yields that form at *any* `-G`. Every verdict it generated was
   falsified by the gate. Only the **PLACEMENT** signature and the **GPREL16 lower bound** are
   declaration-independent (they read the oracle + SYM sizes alone) — and those are what carry
   findings 1 and 4. See §4.
4. 🐛 **Build defect confirmed** (a8): `compile_c` ignored `PER_TU_FLAGS["g_value"]`.
   Patch snippet in §6 — without it every eaclib `-G` probe silently no-ops.

### 🔴 Interpretation, after a10: **CC1PSX's `-G` DEFAULTS TO 8**
So the census's verdicts invert in meaning. A `-G8` object is one whose makefile passed
**no `-G` flag at all**; the `-G4`/`-G2`/`-G0` objects are the **explicitly overridden** ones.
Read the table's `-G` column as *"the value in effect"*, and the `identity` column as
*"default (no flag)"* vs *"explicit"*.

---

## 1. METHOD — three signatures, two load-bearing filters

**(P) PLACEMENT** — decided by the object that *defines* the symbol. A symbol lands in
small data iff `size <= -G`. `NFS4.MAP` pins the region: `.sdata 0x8013C54C..0x8013DD7B`,
`.sbss 0x8013DD7C..0x8013DEDF`.
`G >= max{size : owned, in small data}` · `G < min{size : owned, in .data/.bss}`

**(A) ADDRESSING** — decided by the object that *references* it; this is what
`PER_TU_FLAGS["g_value"]` controls. `R_MIPS_GPREL16` iff `size <= -G`, else `HI16/LO16`.
`G >= max{size : GPREL16}` ← **hard** · `G < min{size : OWNED, small, HI16 w/ LO16 on a memop}`

**(S) ADDRESS-MATERIALISATION FORM** — the "sfx tell". At-or-under threshold cc1 emits the
single `la $r,sym` macro → an **adjacent** lui/addiu pair. Above threshold cc1 pre-splits into
a separately schedulable pair the scheduler can pull apart. Both emit HI16+LO16, so only the
*distance* discriminates. **Reported as a column, deliberately NOT folded into the verdict** —
see §4.

### 🔴 Filter 1 — OWNERSHIP (methodology §3.12 #6)
A reference to *another* object's small global is full-addressed regardless of `-G`. Without
this filter **every** object reads `MIXED` (night.obj's `Chunk_lightTable`/`Weather_gType`,
cario.obj's `Texture_palCopy`, audio.obj's `AudioCmn_kAudioOn` — all foreign).

### 🔴 Filter 2 — MEMOP (new this wave; the naive census died on it)
`lui %hi` + `addiu %lo` is **address-of**, which cc1 emits for small-data symbols too. Counting
it as "full-addressed" made every genuinely-`-G8` object read `CONFLICT`. force.obj is the proof:

```
7c: lui   a1,%hi(Force_gActAlign)      <- HI16
80: addiu a1,a1,%lo(Force_gActAlign)   <- LO16 on an ADDIU = address-of, not an access
84: jal   PadSetActAlign
```
…while PLACEMENT proves that same 6-byte array **is** in `.sdata`. So an HI16 is evidence only
when its partner LO16 rides a load/store.

### Sources
`expected/src/**/*.o` (retail `.text` per object assembled from splat asm ⇒ its relocs ARE
retail's choices) · `NFS4.MAP` (sections) · `nfs4-f-v3.txt` SYM (**true sizes + per-object
ownership**, incl. library members `..\eaclib\psx\eacpsxz.lib(addtimer.obj)`, 519 objects,
1 owner/symbol) · `asm/data/*.s` splat `dlabel` extents · dense address set for `.sbss`/`.bss`.
⚠️ Map **address gaps are unusable** as sizes — statics between globals inflate them
(`CarIO_carPixMap` reads 32 by gap, 4 by SYM).

---

## 2. VALIDATION GATE — `python tools/w47_a7_gcensus.py --validate` → **9/9 GREEN**

| object | census | build.py | |
|---|---|---|---|
| `game/psx/hud` | **8** `[8,10)` | `"8"` | ✅ exact |
| `game/psx/cario` | **8** `[8,12)` | `"8"` | ✅ exact |
| `game/psx/force` | **8** `[6,16)` | `"8"` | ✅ exact |
| `game/common/genericpmx` | **8** `[8,12)` | `"8"` | ✅ exact |
| `game/psx/device` | 8..16 `[8,60)` | `"8"` | ✅ lower bound 8 |
| `game/psx/night` | 8..16 `[8,20)` | `"8"` | ✅ lower bound 8 |
| `game/common/cars` | 4..16 `[4,28)` | `"8"` | ✅ consistent — its 8-byte witness is the `"p%s.dat"` **string literal**, which has no SYM record |
| `frontend/common/screencontroller` | 0..2 `[0,4)` | `"0"` | ✅ upper bound < 4 |
| `game/psx/sfx` | UNDET | `"8"` | ✅ correctly silent — build.py's own comment says *"NO %gp_rel at all"*; sfx's proof was signature (S) |

---

## 3. 📐 MEASURED PROBE DELTAS (whole-TU gates, `scratch/w47_a7_probe.py`)

Baseline = the current global `-G4`. Every row is a full-TU sweep; `-G` injected through a
temporary `NFS4_PROBE_G` hook + the `compile_c` fix (§6), both reverted afterwards.

| TU | census verdict | `-G4` (base) | `-G0` | `-G2` | `-G8` | verdict |
|---|---|---|---|---|---|---|
| `eacpsxz/loadshp` | `>=8` | 1 PASS / 0 diffs | **FAIL** (−1 PASS) | — | 1 PASS / 0 (**≡G4**) | keep |
| `eacpsxz/nasync` | `>=8` | 23 PASS / 0 diffs | 10 PASS / **+193** | +193 | 23 PASS / 0 (**≡G4**) | keep |
| `eacpsxz/nsync` | `0..2` | 8 PASS / 29 diffs | **+28** | **+28** | ≡G4 | ❌ census falsified |
| `eacpsxz/memstd` | `0..2` | 13 PASS / 0 diffs | −1 PASS / **+2** | −1 / +2 | ≡G4 | ❌ census falsified |
| `spchpsxz/spchpick` | `0..2` (S) | 21 PASS / 37 diffs | **+16** | **+16** | ≡G4 | ❌ census falsified |
| `spchpsxz/spchrule` | UNDET, (S) flagged | 7 PASS / 57 diffs | −3 | −3 | ≡G4 | ⚠️ **NOT a `-G` finding** — a9: one scalar-declared extern; fix is a source edit |

### What the probes prove
* **`-G4 ≡ -G8` in 6/6 eaclib TUs, zero delta.** Confirms a8's resolution limit
  *independently and by construction*: eaclib codegen distinguishes only **≥4 vs ≤2**.
  Combined with a10's "default is 8", the `>=8` rows (`loadshp`, `nasync`) mean *"took the
  default"*, and the current global `-G4` is behaviourally identical for them — **no change
  needed, and no risk either way**.
* **`spchrule` is RETRACTED as a `-G` finding.** The −3 reproduced a8's number exactly, but a9
  identified the mechanism: the recon declares one extern as a scalar, so cc1 full-addresses it
  at `-G4` and the `-G0` build happened to land the same shape. The correct fix is the source
  declaration (a9 landed it), **not** a `g_value` entry.
* ⇒ **NO `PER_TU_FLAGS` `g_value` change is recommended for any eaclib TU.** The lane's
  actionable output is the *frontend* class rule (§0.1) and the build defect (§6).

---

## 4. ⚠️ WHAT THE GATE FALSIFIED (do not re-derive these as truth)

**(0) 🔴 The ADDRESSING-side UPPER bound is unsound in principle** (a9). `G < size(s)` inferred
from a full-addressed access to a small owned symbol assumes cc1 *knew* the true size. It often
did not: an `extern int a[];` (unsized) or an over-declared extern is ineligible for small data
at **any** `-G` — IDT R30xx Ch9's unsized-array warning, and methodology §3.12 #5. So that bound
measures **declaration shape**, not `-G`. All three candidates it produced regressed, and the one
apparent win (`spchrule`) was a declaration bug. The census keeps the bound only to *generate
leads*; the `--validate` gate passes on the PLACEMENT + GPREL16 evidence, which is
declaration-independent.

**(a) Exclusive-reference ownership.** eaclib `.lib` members carry **no data `Def` records** in
the SYM (165 eaclib objects → 2 data symbols with SYM sizes, both in `pad.obj`, a direct `.obj`).
To get an upper bound at all, the census treats "referenced by exactly one object" as ownership.
`nsync` (`abortflag`, `loadfilecallback`) and `memstd` (`mb_default`) both came out `0..2` this
way and **both regress**. The failure mode is real: object A can *define* a global it never
references while object B is its only user.

**(b) The pre-split / "sfx tell" form (S).** Flagging every non-adjacent lui/addiu pair produced
**36** `0..2` eaclib rows and **broke the validate gate** when folded into the verdict, so it is
reported as a column only. `spchpick` (10 pre-split sites, min size 4) regresses +16. It did
flag the one true positive (`spchrule`), so it is a useful **lead generator with poor precision** —
the missing piece is an ownership/declaration analysis of the pre-split symbol.

**(c) `pad.c` has NO derivable `-G`** (a8): `-mno-split-addresses`, which pad is the one proven
object for, **fully masks** the signature. Its census row (`0..8`) is marked `n/a` — give it no verdict.

---

## 5. EACLIB TABLE (151 objects; full table in `scratch/w47_a7_census_eaclib.md`)

| verdict | n | meaning after a10's "default = 8" |
|---|---|---|
| `>= 8` — `loadshp`, `nasync` | 2 | took the **default** (no `-G` flag); `-G4` is byte-identical, keep |
| `>= 4` — `inittmr`, `nfile`, `primate`, `stream`, `systask`, `threads`, `timer`, `unbtree`, `unref` | 9 | indistinguishable from default at eaclib's ≥4-vs-≤2 resolution |
| CONFLICT — `fileroot`, `joystkn` | 2 | mixed signature → **routed to a8/a9**: a per-*symbol* unsized-`extern` declaration (IDT R30xx Ch9), not a per-module flag |
| UNDET | 138 | `-G` is a genuine no-op for these — no small-data access at all |
| `-G0` **proven by gate** — `spchrule` | 1 | **explicit override**, wire it |

`pad` — excluded (see §4c).

---

## 6. 🐛 BUILD DEFECT (confirmed independently; the consolidator must land this)

`PER_TU_FLAGS["g_value"]` was wired in `compile_cpp` **only**. `compile_c` — i.e. **all of
eaclib and syslib** — used the global `G_VALUE` for both cc1 and the assembler, so every `-G`
override on a C TU silently no-opped. My probes only produced deltas *because* this was patched;
unpatched, all six rows in §3 would read identical.

```python
# tools/build.py, in compile_c(), replacing `cc1_flags = list(CC1_FLAGS)`:
tu_g_value = str(tu_flags.get("g_value", G_VALUE))
cc1_flags = [f"-G{tu_g_value}" if f == f"-G{G_VALUE}" else f for f in CC1_FLAGS]
...
# and in the maspsx invocation, `f"-G{G_VALUE}"` -> `f"-G{tu_g_value}"`
```

---

## 7. LEADS OUTSIDE a7's SCOPE (game/psx + game/common) — reported, not probed

20 objects carry the `-G >= 8` PLACEMENT signature but only 6 are wired. Under a10's reframing
these are simply **default-`-G`** objects, so the risk of leaving them at `-G4` is exactly the
`≥4 vs ≤2` question — likely inert, but each is a cheap probe:

`aih_play` **8** · `audiocmn` **8** · `audioeng` >=8 · `copspeak` **8** · `dashhud` 8..16 ·
`hudpmx` 8..16 · `input` 8..16 · `mpause` 8..16 · `nfs3` **8** · `r3dcar` **8** · `render` 8..16 ·
`replay` 8..16 · `simqueue` 8..16 · `drawc` 8..16 · `draww` 8..16 · `hrzsku` **8** ·
`overlays` 8..16 · `psxcontroller` 8..16 · `textureprocess` **8** · `weather` **8**

Plus one more `-G0`: `game/psx/fe3dmenu` `0..0` — consistent with §0's overlay rule.

---

## 8. REPRODUCE

```
python tools/w47_a7_gcensus.py --validate                      # the 9/9 gate
python tools/w47_a7_gcensus.py --filter eaclib --out X.md
python tools/w47_a7_gcensus.py --explain eaclib/psx/spchpsxz/spchrule
python scratch/w47_a7_probe.py recon/<tu>.c FN,FN,... 4,0,2,8  # needs the §6 fix
```
`expected/` is gitignored, so from a worktree the tool falls back to
`C:/Temp/nfs4-decomp/expected/src` (read-only); override with `NFS4_EXPECTED_SRC`.
