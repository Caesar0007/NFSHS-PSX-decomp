# W60-A1 — THE LINK-MODEL VERDICT (intra-TU function order)

**Question (wave top-ranked):** does the CURRENT link model place code per-symbol or
per-object, and are the 250 intra-TU order inversions real defects?

**VERDICT (one line):** placement is **PER-OBJECT-SECTION** — GNU ld copies an input
`.text` verbatim and never reorders symbols inside it, so **intra-TU order IS linked VA
order** and every inversion is a real defect; the only reason inversions are not
*currently* producing wrong VAs is that `linkers/nfs4.ld` is STALE and links **zero**
reconstruction text at all (`nfs4_TEXT_SIZE = 0`).

---

## 1. Evidence — how ld places code here

### 1.1 The mechanism is per-object-section, proven empirically

`include/decomp/include_asm.h` emits every function into ONE `.text` section per TU
(no `-ffunction-sections`, no `.section .text.<name>`). `linkers/nfs4.ld` uses whole-object
input specs (`build/src/front.c.o(.text)`), and `tools/build.py:link_and_verify()` passes
**no object files on the ld command line at all** — objects are pulled in solely by the
script's `file(.section)` statements. There is no `--sort-section`, no `--gc-sections`,
no per-symbol spec anywhere in the repo.

Direct probe — link `build/recon/syslib/psx/libetc/INTR.c.o(.text)` alone at retail's
first-function VA `0x800F284C` and read the symbol table back:

```
SECTIONS { .text 0x800F284C : SUBALIGN(16)
           { build/recon/syslib/psx/libetc/INTR.c.o(.text); } ... }
```

| symbol | linked VA (probe) | retail VA | delta |
|---|---|---|---|
| `_bzero_w`           | 0x800F2850 | 0x800F2E70 | **-0x620** |
| `_initIntr`          | 0x800F2874 | 0x800F2968 | **-0xF4**  |
| `ResetCallback`      | 0x800F294C | 0x800F284C | **+0x100** |
| `InterruptCallback`  | 0x800F297C | 0x800F287C | +0x100 |
| `DMACallback`        | 0x800F29AC | 0x800F28AC | +0x100 |
| `VSyncCallback`      | 0x800F29DC | 0x800F28DC | +0x100 |
| `VSyncCallbacks`     | 0x800F2A10 | 0x800F2910 | +0x100 |
| `CheckCallback`      | 0x800F2A40 | 0x800F2940 | +0x100 |
| `SetIntrMask`        | 0x800F2A50 | 0x800F2950 | +0x100 |
| `_intrhand`          | 0x800F2A68 | 0x800F2A40 | +0x28  |
| `_set_intr_callback` | 0x800F2C34 | 0x800F2C10 | +0x24  |
| `StopCallback`       | 0x800F2D80 | 0x800F2D58 | +0x28  |
| `RestartCallback`    | 0x800F2E20 | 0x800F2DF8 | +0x28  |

Every linked VA = *object base + the symbol's offset inside the object*. ld reproduced the
object's internal order exactly and **13/13 functions landed at the wrong address**.
That is the whole answer to "per-symbol or per-object": per-object, and the inversion is
NOT masked.

### 1.2 …but the current .ld links no text whatsoever

`configs/nfs4.yaml` still declares only TWO code subsegments (`front`, `main`), so the
generated `linkers/nfs4.ld` names only `build/src/front.c.o(.text)` and
`build/src/main.c.o(.text)`. Both TUs were emptied by the 2026-06-24 main-sweep (461-way
TU split); the other 459 `src/*.o` and all `build/recon/**` objects are never presented to
ld and would hit `/DISCARD/ : *(*)` if they were.

From the in-tree `build/nfs4.map` (last full build):

```
1005:  0x80015d30   nfs4_TEXT_START = .
1006:  build/src/front.c.o(.text)
1007:   .text  0x80015d30  0x0   build/src/front.c.o
1008:  build/src/main.c.o(.text)
1009:   .text  0x80015d30  0x0   build/src/main.c.o
1011:  0x80015d30   nfs4_TEXT_END = .
1012:  0x00000000   nfs4_TEXT_SIZE = ABSOLUTE(...)
```

`LOAD` count in the map: **12** objects (header + 10 data/rodata blobs + the two empty
code stubs). The link stage today is a data-only, vestigial artifact.

### 1.3 Answer to (a)

> With the current .ld, does an intra-TU inversion produce wrong VAs in a linked image,
> or does per-symbol placement mask it?

**Neither.** Per-symbol placement does not exist and could not mask it (§1.1). The
inversions are *latent* purely because the current .ld links none of the affected objects
(§1.2). The moment the .ld/yaml is brought up to date to the 461-TU split — the only
route to a bootable image — every inversion becomes a wrong VA. There is no configuration
of the present toolchain in which an inversion is harmless: making ld place per-symbol
would require `-ffunction-sections` + per-symbol input specs, which is both absent and
itself incompatible with a byte-exact image (extra section alignment/padding).

### 1.4 Answer to (b)

> For the TRUE-SOURCE goal (linkable into the retail image with a period linker that
> places whole objects), are inversions real defects?

**Yes, unambiguously — and more strongly than under GNU ld.** SN/PSYLINK places whole
`.obj` sections; retail's own VA layout IS the concatenation of each object's internal
function order. A TU whose functions are emitted in the wrong order cannot produce
retail's VAs under ANY whole-object linker. The retail VA sequence in
`configs/symbol_addrs.txt` is a direct read-out of the original source's function
definition order — reproducing it is part of reconstructing the source, not a link-script
detail. An inverted TU is a *wrong reconstruction of the source file*, independent of
which linker is used.

---

## 2. Why the byte gates cannot see this (and what can)

A function's `.text` bytes are position-independent inside its own object: intra-function
branches are self-relative, and inter-function references are either relocations (patched
by ld) or — rarely — assembler-resolved displacements. So for almost every inversion the
object's bytes are IDENTICAL to a correctly-ordered TU's; only the concatenation order
differs. `verify_asm` (per-function), `tugate` (per-TU, per-function), objdiff (per-symbol)
and even a whole-object byte compare are all blind to it. `tools/tu_order_audit.py` is the
only instrument that sees it, and `tools/strict_branch.py` sees the one sub-class that
does change bytes.

## 3. Risk classification of the inversion population

Classifier written for this task: `scratchpad/w60a1/xfn.py` (also
`.../tier.py`, raw output `.../xfn_all.txt`, `.../tier.txt`). For every
`build/recon/**/*.o` it finds intra-object cross-function references and splits them:

* **A — assembler-baked cross-function branch.** A `b/beq/bne/...` whose target lands in a
  *different* function of the same object: the assembler bakes a 16-bit displacement, so
  changing intra-TU order **changes the emitted bytes**. This is the MSC02 class
  (`VectorNormalS -> VectorNormalSS`, commit f2170255's precedent) — the only class a byte
  comparison can catch.
* **B — `j`/`jal` to a local label with no relocation record.** Same 26-bit sensitivity.
* **C — a relocation naming another function DEFINED in the same object** (`jal <sibling>`,
  `%hi/%lo` of a sibling's address). ld patches these with the sibling's *actual* linked
  VA, so the bytes are fine but the **value is wrong** whenever either function moved.

Crossed against the 250 inversions:

| tier | definition | objects | note |
|---|---|---|---|
| **1** | inverted **and** class A/B present — wrong VAs **and** wrong bytes | **0** | MSC02 was the only class-A site in the whole tree (1 hit, 204 objects with any cross-fn ref) and it is already fixed + no longer inverted |
| **2** | inverted **and** class C present — wrong VAs incl. its own intra-TU call targets | **46** | the bulk; includes every TU on this belt |
| **3** | inverted, no intra-object references — wrong VAs for external callers only | **3** | `spchdata.c` (2), `libcd/streamhelp.c` (1), `libetc/VSYNC.c` (1) |

**Totals: 49 objects / 250 inversions** (down from 274 at f2170255). Tree-wide class-A
census: **1 site, MSC02, already closed** — so the byte-visible sub-class is empty and the
remaining 250 are purely positional defects.

⚠️ **Snapshot caveat.** These figures are a W60 START-OF-RUN snapshot. The wave cleared
them fast — by the time this belt was finished the audit read **159** inversions (A8/A9/A10
+ the user landing reorders concurrently). The *tiering* is stable; only the counts move.
Re-run `tu_order_audit.py` + `xfn.py` before quoting a number.

### Practical consequence for triage
Severity is uniform (all 250 put functions at wrong VAs); what differs is only
*detectability*. Since tier 1 is empty, no inversion can be found by any byte gate — so
`tools/tu_order_audit.py` must become a **standing gate**, run per-wave, exactly like
the nm phantom check. Ordering the fix by inversion count (aiphysic 38, libgpu/SYS 37,
nfile 25, screencongrats 19, INTR/PADCMD 12 …) is the right work order because a single
misplaced function usually accounts for many reported inversions (INTR.c: **one**
misplaced `_bzero_w` produced 12 of its 12 reports).

## 4. Standing recommendations

1. **Promote `tu_order_audit.py` to the wave-close gate** (`0 inversions` alongside
   `HIDDEN PHANTOMS=0`). It is the only detector, and the class is invisible to
   everything else.
2. **Regenerating the .ld/yaml to the 461-TU split is now a prerequisite** for any
   "first light"/bootable-image work, and it must be done *after* the inversions are
   cleared, or the first real link will bake 250 wrong VAs into the image.
3. **Fix order = definition order, and it is codegen-neutral.** Proven on this belt: 6
   TUs reordered (INTR, INTR_VB, VSYNC, PATCH, BIOS, FIRST), PASS sets and per-function
   diff counts byte-identical before and after in every one. Pure source hygiene with a
   real correctness payoff — sweep it module-by-module rather than deferring it.
4. **The reorder makes the object's layout auditable, and that finds real bugs.** Once a
   TU is in VA order its `.text` offsets can be compared against the retail VA deltas
   directly (`scratchpad/w60a1/ord.py`). Four of the six belt TUs then matched retail's
   spacing EXACTLY; the two that did not each exposed something real — INTR.c a +4 drift
   from `_intrhand` being one instruction short (its own open FAIL, now closed
   count-exact), and PATCH.c a genuinely MISSING word (see the commit: the 10th word of
   `func_8010CA40` is BIOS patch template 2's fifth word, and `_patch_card2`'s copy loop
   is bounded by `_patch_card`'s address, so without it the loop copies four words instead
   of five). **Offset-vs-retail-delta comparison should be the second half of the standing
   order gate.**
