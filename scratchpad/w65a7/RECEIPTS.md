# W65-A7 RECEIPTS — THE LINKER-SCRIPT ENGINEER

Repo `C:\Temp\nfs4-decomp`, wave W65, 2026-08-15. Base HEAD `14c766e6`
(peers landed continuously through the run — A5's jump-table cut re-sliced both
rodata blobs mid-session; every number below was measured by me, never quoted).
Scope honoured: **only `linkers/` and `tools/` were written**; nothing in
`recon/`, `src/`, `asm/` or the memory dir.

---

## 0. HEADLINE

| axis | briefed | measured control | after |
|---|---|---|---|
| `linkers/nfs4.ld` src-lane link, ld stderr lines | "1975 → 20 with a one-line fix" | **1985** | **14** |
| — "defined in discarded section" | 1975 | 1975 | **0** |
| — `small-data section too large` | 1 (residual) | 1 | **0** |
| — `R_MIPS_GPREL16` truncations | 18 (residual) | 18 | **0** |
| splat link (`tools/build.py`) image | — | 241280 B `sha1=11dfa619…` | **byte-identical** |
| standing gates promoted | 0 | — | `tools/relink.py`, `tools/probe_link.py` |

Two corrections to the standing record:

1. **The W64-A19 spec's trailing `.src_rest` region is what CAUSES the
   "residual 20".** Both residual classes (the `-G` overflow and all 18
   `R_MIPS_GPREL16` truncations) are **symbol MISPLACEMENT**, not gp distance
   and not a `-G` budget problem. Fold the catch-alls into the *matching*
   section run of `.nfs4` and both classes vanish with no `-G` change (§2).
2. **A response file of ABSOLUTE paths silently doubles every blob object.**
   A filename inside a `SECTIONS` command that does not match an already-loaded
   input is opened by ld as an ADDITIONAL input, so `build/asm/x.o` (script) and
   `C:/Temp/nfs4-decomp/build/asm/x.o` (rsp) load twice → **2900 phantom
   "multiple definition" lines**. Every link probe must feed ROOT-RELATIVE
   paths spelled exactly as the script spells them (§1.1).

---

## 1. METHOD / ANTI-VACUITY

* **Control-derived, not backup-derived.** `build/**` and `linkers/nfs4.ld`
  churn under peers (A5 re-cut both rodata blobs *during* this run). Every A/B
  is measured against a CONTROL generated from the **current** file with only
  the W65-A7 change backed out (`scratchpad/w65a7/mkctrl.py`), so a peer's
  concurrent object-list edit is held constant on both sides. A backup taken
  minutes earlier already produced one false "DIFFER 4829 bytes" reading.
* **A/A′ stability re-link.** `ldneutral.py` links A, B, then A again and
  refuses to report if A ≠ A′ (the object set moved mid-probe).
* **Every count re-measured 2×.**
* **No vacuous green.** `relink.py` exits 2 on an empty object list, on a
  missing merged object, and on peer churn (`cannot find`); it deletes the
  merged object before every link — a STALE partial `ld -r` output read as a
  plausible symbol table and manufactured **25 fake hidden phantoms** in the
  src lane before that guard existed.
* **Batching** (ARG_MAX defect): nm at 40 objects/call, objdump at 30.
* **Exact-name matching** everywhere; VAs are used only to FIND a hidden
  phantom, never to declare a symbol resolved.

### 1.1 The absolute-path trap (new hazard, cost ~30 min)
`scratchpad/w65a7/dupclass.py` classified the first probe's 2905
multiple-definition pairs: **2900 were `X <-> X`, the same object against
itself**. Cause above. Fix: `rsp.write_text(o.relative_to(ROOT).as_posix())`.
Symptom to recognise: a "multiple definition" whose two sides are the same
file, one spelled absolute.

---

## 2. MISSION 1 — `linkers/nfs4.ld`

### 2.1 The defect (re-measured, W64-A19 §4.1 confirmed)
The trailing `/DISCARD/ : { *(*); }` ate **459 of the src lane's 461**
per-module objects; the script still names only `build/src/front.c.o` and
`build/src/main.c.o`, both **952-byte empty shells** (`.text`/`.data`/`.bss`
all size 0 — objdump-verified). Every jump-table `.L<VA>` in the rodata blobs
then reported *"defined in discarded section `.text` of build/src/<mod>.c.o"*:
1975 lines, **0 of them an undefined symbol**.

### 2.2 Three variants measured
`scratchpad/w65a7/mkld.py` builds each from the live file; `srclink.py` links
the whole src lane (461 src + all asm objects) exactly the way `build.py` does.

| variant | shape | ld stderr | discarded | -G overflow | GPREL16 trunc | undefined | splat link |
|---|---|---|---|---|---|---|---|
| control | HEAD `*(*)` | **1985** | 1975 | 0 | 0 | 0 | baseline |
| **A** | W64-A19 spec: trailing `.src_rest` | **30** | 0 | **1** | **18** | 2 | (not measured) |
| B | section-aware, unscoped `*(sec)` | **14** | 0 | 0 | 0 | 2 | **+240 B — REGRESSION** |
| **C — LANDED** | section-aware, `build/src/*(sec)` + `.rel.dyn` discarded | **14** | 0 | **0** | **0** | 2 | **byte-identical** |

(A's 30 lines = the briefed 20 plus 10 lines of the 5 pre-existing src↔src
multiple definitions, which appeared after the W64-A19 snapshot.)

### 2.3 The residual 20, both classes KILLED — and they were never a `-G` problem
`scratchpad/w65a7/gprel.py` reads each truncated symbol's linked address out of
the two maps. Under variant A the *whole* small-data run lands at 0x80048C90
because `.nfs4`'s text stayed tiny and the src objects' own `.sdata` went to the
trailing region ~0x8008xxxx — two small-data runs 0x80000 apart, which is both
the `small-data section too large` message AND every truncation:

| symbol | variant A | variant C |
|---|---|---|
| `AIDataRecord_BestLine` | 0x80048D20 = `_gp-0xF382C` **out of range** | 0x8013D0E0 = `_gp+0xB94` in range |
| `AIDataRecord_TrackCurve` | 0x80048D24 = `_gp-0xF3828` | 0x8013D0E4 = `_gp+0xB98` |
| `AIDataRecord_WhichRecord` | 0x80048D28 = `_gp-0xF3824` | 0x8013D0E8 = `_gp+0xB9C` |
| `AIDataRecord_RecordMethod` | 0x80048D2C = `_gp-0xF3820` | 0x8013D0EC = `_gp+0xBA0` |
| `AITraffic_rawTriggers` | 0x80048CF0 = `_gp-0xF385C` | 0x8013D0B0 = `_gp+0xB64` |

**Classification: 18/18 SYMBOL MISPLACEMENT, 0 genuine gp-distance.**
`_gp` is unchanged (0x8013C54C) and **no `-G` threshold was touched**. Only 10
of the 18 print before ld's "additional relocation overflows omitted".

### 2.4 The `/DISCARD/` list is evidence-derived, and `.rel.dyn` is load-bearing
`scratchpad/w65a7/seccensus.py` (598 objects, batched): the ONLY input sections
in either lane are `.text .data .bss .sdata .sbss .rodata` (real) and
`.reginfo .MIPS.abiflags .pdr .gnu.attributes` (metadata). Variant B still grew
the splat image by exactly **240 bytes** — an ld-GENERATED `.rel.dyn` that
HEAD's `*(*)` had been swallowing. Adding `*(.rel.dyn); *(.rel*)` (plus
`.note*/.debug*/.line/.stab*/.got*/.dyn*` for future-proofing) restores
byte-identity. **A narrowed `/DISCARD/` must name the linker's own output
sections, not just the input metadata.**

### 2.5 Zero-regression proof
`tools/build.py`'s `link_and_verify()` passes **no object list** — every input
comes from the filenames inside the script. `ldneutral.py` links control and
landed back-to-back plus the A/A′ stability re-link:

```
[a ] rc=0 stderr=2077 bytes=241280 sha1=11dfa6191346c6d32e02407acdaf5818b7ab7f94
[b ] rc=0 stderr=2077 bytes=241280 sha1=11dfa6191346c6d32e02407acdaf5818b7ab7f94
[a2] rc=0 stderr=2077 bytes=241280 sha1=11dfa6191346c6d32e02407acdaf5818b7ab7f94
BYTE-IDENTICAL / stderr identical
```
(The "2077" of catalog row 15E is this no-object-list link, unchanged.)

⚠️ **Concurrency note for the orchestrator:** commit `02a03a9d` staged
`linkers/nfs4.ld`, which at that moment also carried A18/A5's uncommitted
blob-placement lines for `data_8010CCD4_o32/_r20/_o33/_r21`. Their work is
preserved inside my commit, not lost — but it is attributed to `w65a7:`.

---

## 3. WHAT A **CLEAN** SRC-LANE LINK STILL NEEDS

The residual after the fix is **7 findings / 14 lines**, all pre-existing and
all outside `linkers/`. Exact specs, none landed by me:

### 3.1 TWO UNDEFINED — a missing `INCLUDE_ASM` pair (→ A6 or the syslib belt)
```
build/src/eaclib/psx/pad.c.o:            (.text+0xf0) undefined reference to `PAD_convert'
build/src/syslib/psx/libcard/INIT.c.o:   (.text+0x20) undefined reference to `ReadInitPadFlag'
```
Both asm bodies EXIST (`asm/nonmatchings/main/PAD_convert.s`,
`…/ReadInitPadFlag.s`); no src TU includes them. `src/syslib/psx/libpad/PAD.c`
records that the two stubs were **deliberately removed 2026-08-10** because they
produced phantom 0.00% report rows under a wrong unit — the removal was right for
the report and wrong for the link. Recipe: add
`INCLUDE_ASM("asm/nonmatchings/main", PAD_convert);` to the src TU that owns
0x800E41FC (recon owner: `recon/eaclib/psx/pad.c`) and
`INCLUDE_ASM("asm/nonmatchings/main", ReadInitPadFlag);` to the one that owns
0x8010C9B0 (recon owner: `recon/syslib/psx/libapi/PAD.c`), each **positioned in
retail VA order inside the TU** (the same ordering law `tu_order_audit` enforces
for recon), so the eventual ordered link keeps them at their retail addresses.

### 3.2 FIVE REAL DUPLICATES — the RETAIL-STATIC-COPY class (→ A5/A6, asm lane)
```
VoxSentence_GetNumPhrases  spchrule.c.o <-> spchdata.c.o
iSPCH_GetOffset8           spchrule.c.o <-> spchdata.c.o
iSPCH_GetOffset16          spchrule.c.o <-> spchdata.c.o
___15AIHigh_BTC_Perp       aihigh.c.o   <-> aih_btcperp.c.o
_bzero_w                   INTR_DMA.c.o <-> INTR.c.o
```
These are **not** a mis-split. `configs/symbol_addrs.txt` carries each name at
TWO VAs (`_bzero_w` = 0x800F2E70 **and** 0x80106924; `VoxSentence_GetNumPhrases`
= 0x80100730 and 0x8010B100) — retail duplicated a FILE-LOCAL static into two
objects. `tools/tu_order_audit.py` already excludes exactly these names as
"multi-VA". The second copy's splat file is named `<name>_<VA>.s` but still
`glabel`s the BASE name, so both copies export the same global.
**Recipe — the same LOCALIZE decision 16E made for `.L` labels:** in the
`_<VA>`-suffixed asm file, emit the symbol LOCAL (label + `.type … @function`
without `.globl`, or `glabel <name>_<VA>` with the interior label keeping the
retail bytes). Byte-neutral by construction: the bytes and the offsets do not
move, only the binding.

### 3.3 THE BIG ONE — `.text` ORDER (the step to a byte-faithful src link)
The landed catch-all places the 459 objects' `.text` in *command-line order*,
not retail VA order, so the link RESOLVES but does not REPRODUCE. The recipe
already exists and is proven on the recon lane: the W62-A19 text spine (implied
base = retail VA − our section offset, mode over the object's text symbols),
which `tools/probe_link.py` now computes on every run. Turning `nfs4.ld` into an
ordered script is a mechanical port of that generator to the src lane — with the
same "objects that drive the location counter backwards are dropped" rule (18
interleavers on the recon lane) — and is the natural next agent-task. It must be
coordinated with A5, who owns blob placement inside the same file.

---

## 4. MISSION 2 — THE STANDING GATES, PROMOTED

### 4.1 `tools/relink.py` (W62-A18 spec, promoted + hardened)
`ld -r` the whole lane into one object; ld is the ground truth for duplicates,
`nm -u` for the unresolved set. Three classes, per the mission's acceptance
definition:

* **REAL dup must be 0** — a duplicate where NEITHER side is a `build/asm/**`
  splat blob. The blob-class count is reported separately because it is the
  SHRINKING set the region-cut lane is eating (recon: 796, all blob).
* **HIDDEN PHANTOMS must be 0** — an unresolved EXACT name whose VA IS defined
  in the lane under a different spelling. This is the
  `feedback_verify_gate_hidden_phantom` class a VA-keyed check calls "frontier".
* **UNRESOLVED (reloc-referenced)** — tracked, not gating. `objdump -r` filters
  out symtab-only noise (the src lane's **3486** `__maspsx_include_asm_hack_*`
  entries are exactly that; the honest figure is 202).

Root resolution `parents[1]` (the 16F promotion law). Exits 2 rather than
report a vacuous number.

### 4.2 `tools/probe_link.py` (W62-A19 harness, promoted with `scan` inlined)
Scans `build/recon/**` fresh on every run (the ~1% stale-`objdata.json` hazard
of 15E — `--reuse-objdata` exists but prints the cache age), rebuilds the text
spine, links for real, flattens the placed regions and byte-compares against
`rom/nfs4-f.exe`. `--min-pct` turns it into a floor gate; `--json` writes the
row. Refuses to score if no ELF was produced or zero bytes were compared.

---

## 5. THE LINK LANE'S ACCEPTANCE SHEET

(see `SESSION_GATES.md` in this directory for the run-by-run numbers)

---

## 6. HAZARDS ENCOUNTERED

1. **Absolute-path response file doubles script-named inputs** (§1.1) — new.
2. **Stale `ld -r` output**: a failed `ld -r` still leaves a partial `.o`; a
   later `nm -u` on it reports a plausible-but-wrong symbol table (25 fake
   hidden phantoms). Delete the output before every link.
3. **Peer build churn**: objects vanish mid-link ("cannot find", "file
   truncated"); a src-lane probe taken mid-rebuild read 365 lines / 221
   undefined `.L` instead of 14. Every harness now re-globs and retries once,
   and refuses rather than report.
4. **Backup-as-control is wrong under concurrency** — derive the control from
   the live file (§1).
5. **Heredoc backslash collapse fired again** (`p.replace('\\','/')` inside a
   `python - <<EOF` became a SyntaxError). Write-tool only, as banked.
