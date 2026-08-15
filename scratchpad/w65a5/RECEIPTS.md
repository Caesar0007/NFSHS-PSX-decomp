# W65-A5 RECEIPTS — THE `.L` LOCALIZE CUT

Repo `C:\Temp\nfs4-decomp`, wave W65, 2026-08-15. Started from `14c766e6`.
Every number below was measured in this run. No briefed number is reused.
Memory dir: READ-ONLY, untouched. `tools/*.py`, `recon/**`, all shared headers:
untouched.

Commits (explicit paths, staged and committed in ONE shell step, never leaving
an index populated across a tool call):

| commit | content |
|---|---|
| `f9c62a96` | region 1 — `rdata_80010000` cut into 33 pieces + both linker scripts + the `SUBALIGN` fix |
| `0ba59955` | ⚠️ **a peer's `git add -A` swept my region-2 `.s` files into its own commit** (see §8) |
| `f0988bb6` | region 2 wired into both linker scripts + the zero-size-section fix + P6 hardening |
| this file | receipts + the six tools |

---

## 0. HEADLINE

| axis | measured baseline (mine) | final |
|---|---|---|
| recon-lane real link, undefined names | **398** (350 `.L`) | **15** (0 `.L`) |
| — of which `.L<VA>` jump-table labels | **350** | **0** |
| — same-instant no-cut control, final tree | **365** (350 `.L`) | — |
| multiple definition | 796 | **796 (unchanged)** |
| relocation truncated | 10 | **10 (unchanged)** |
| probe_link | **83.07 %**, 202/442 byte-exact | **83.08 %**, 202/442 |
| tu_order_audit | 508 objects, 0 inversions | 508 objects, **0 inversions** |
| splat-lane `.nfs4` image | — | **BYTE-IDENTICAL to the un-cut control** |

**The `.L` axis is closed.** Every one of the 350 undefined `.L<VA>` names is
gone, and the multiple-definition and reloc-truncation counts are *identical*
at every rung, so nothing but the `.L` class moved.

The residual 15 are the true-undefined class W64-A19 priced at 52 (A6's
lane — deliberately untouched). It fell 48 → 15 under **peer** belts during
my run (w65a6's blob-alias sweep, w65a8's COMMONs), not under this lane;
`398 → 15` is therefore not a single attributable delta, which is exactly why
the same-instant no-cut control is reported beside every rung.

---

## 1. THE OWNERSHIP PROOF (the E5 discipline on the jump-table axis)

`scratchpad/w65a5/jtbl_own.py` — receipts `jtbl_own.txt`, `jtbl_own.json`,
per-word diagnosis in `jtbl_diag.txt`.

```
implied_base(obj) = mode over the object's .text symbols of
                    (retail VA of the symbol) − (our section offset)

every R_MIPS_32 relocation in the object's own .rodata whose target is .text
resolves to  implied_base + in-place addend      (MIPS REL: the word IS the addend)

a blob region jtbl_<VA> holding [t0 … tN-1] is OWNED by obj iff obj's .rodata
carries a CONTIGUOUS run of N such resolved VAs equal to that sequence,
element for element, in order.
```

| result | count |
|---|---|
| regions in the two blobs | **54** (18 + 36) |
| byte-proven duplicates `[E5]` | **48** |
| owned by text-window containment, owner is a near-miss `[CONTAIN]` | **6** |
| **no owner** | **0** |

The 6 `[CONTAIN]` rows, each with its differing words listed in
`jtbl_diag.txt`: `fememcard 800117A8` (2 targets drifted),
`screenusername 800125F0` (all 62 uniformly −0xC), `memcard.c 80012888`
(different table entirely), `aih_btcperp 80055040` (1 word),
`aih_cop 8005516C` (5 uniformly +0xC), `camera 800558C8` (3 words). Every one
is a *known near-miss in the owning function* — the region is still that
function's jump table, so cutting it is right; the byte proof simply cannot
close while the owner is unsealed. When those six functions seal, re-run
`jtbl_own.py` and all 54 become `[E5]`.

Anti-vacuity in the prover itself:
* `objdump` is fed in batches of 30, never one glob; an empty batch is a hard
  `assert` (the ARG_MAX gate defect);
* a region whose `.L` words are followed by anything other than `.word 0x0`
  aborts the run, and a `.L` word appearing *after* a non-`.L` word aborts it
  too — the trailing-zero-pad assumption is re-proved every run, not assumed;
* an object that vanished from `build/` under a peer between the scan and the
  objdump is **reported by name**, never silently treated as examined
  (`FONT.c.o` did exactly this mid-run).

---

## 2. THE CUT — `splitjtbl.py`, whole-record granularity

Both edges of every cut are blob-label boundaries **by construction** (a
window is exactly one blob record), so the E4 leg is trivially green and no
record ever needs splitting.

| | `rdata_80010000` | `rdata_80054548` |
|---|---|---|
| span | 0x80010000..0x800128F0 (10 480 B) | 0x80054548..0x8005797C (13 364 B) |
| records | 240 | 345 |
| pieces | **33** (15 `_rNN` + 18 `_jNN`) | **61** (25 `_rNN` + 36 `_jNN`) |

**A5-class find — the boundary alignment carry.** spimdisasm emits a bare
`.align 3` *before* every `jtbl_` record, and the parser attributes it to the
**previous** record. In the whole blob it pads nothing; at the END of a
standalone piece whose own size is not 8-aligned it emits real padding and the
concatenation comes out 16 B (region 1) longer than the control. The splitter
carries such trailing directives to the head of the NEXT piece — the global
line ORDER is untouched, so A2 still compares the full original stream — and
asserts that no piece ends in an alignment directive. 26 directives carried in
region 1, 48 in region 2.

### Anti-vacuity, asserted every run
A1 parser round-trip byte-identical · A2 the concatenated line stream equals
the original body AND the data lines are identical and in order · A3 the
segments tile the blob with no gap/overlap · A4 every cut is 4-aligned ·
A5 per-line sizes derived from the NEXT line's VA and summing to the record
size.

### P1–P5 (`proofs.py`, both regions)
```
region 1  P1 240 records / 10480 B  P2 2433 lines  P3 10480 == 10480 IDENTICAL
          P4 1115 relocations identical  P5 4429 ROM diffs, 0 outside a reloc word
region 2  P1 345 records / 13364 B  P2 2449 lines  P3 13364 == 13364 IDENTICAL
          P4  902 relocations identical  P5 3584 ROM diffs, 0 outside a reloc word
```

---

## 3. P6 — THE SPLAT-LANE CONTROL, STRENGTHENED TO IMAGE EQUALITY

`p6.py` links `linkers/nfs4.ld` twice — once with the 94 pieces, once with the
two un-split control blob objects — and compares **the produced `.nfs4` image
byte for byte**, then the normalised diagnostics.

```
P6 image: NEW .nfs4 = 1236928 B   CTL .nfs4 = 1236928 B   IDENTICAL
NEW rc=0 stderr lines=14      CTL rc=0 stderr lines=14
P6 normalised diagnostic DIFF LINES: 0
```

The image leg is not decoration — it caught **two real defects a
diagnostics-only P6 is blind to**:

### 3.1 🔴 `SUBALIGN(16)` on `.nfs4` — a LATENT defect, now fixed
`SUBALIGN(N)` forces **every input section** in the region to alignment N,
overriding its own. Blob piece boundaries are 4-aligned, not 16. `front_data`
has been cut into pieces inside this region since W64-A18, so the padding was
already being inserted then; adding 94 rodata pieces turned it into a hard
`final link failed: file truncated`. `SUBALIGN(16)` → `SUBALIGN(4)` (retail
bases are 4-aligned, catalog 14B; the group boundaries that really need 16 are
held by the explicit `. = ALIGN(., 16);` statements). P6 is measured with the
fix held constant on both sides, so the only variable is the cut.
**Consequence for the record: any earlier P6 that compared diagnostics only
could not have seen this.**

### 3.2 🔴 A ZERO-SIZE INPUT SECTION STILL TAKES PART IN `SUBALIGN`
Region 1 replaced the blob's `(.data)` and `(.bss)` entries with a comment
because `objdump` shows both sections at size 0. Dropping them removed a
4-byte fill and shifted the image. Both stems now list **every piece for all
three sections**; re-aligning to 4 is idempotent, so 94 zero-size sections
cost exactly what 1 did.

### 3.3 🔴 THE CONTROL MUST BE DERIVED FROM THE LIVE SCRIPT
A snapshot of `linkers/nfs4.ld` taken at the start of the run went stale: a
peer belt re-ordered the `sdata_8013C54C` pieces in that same file mid-run,
and the stale control attributed a **96-byte phantom image diff** to my cut.
`p6.py` now rebuilds the control from the live script by reversing *only* this
lane's edit (collapse each rdata piece group back to one whole-blob entry) and
asserts it found exactly `3 × len(STEMS)` groups.

---

## 4. THE RECON LANE — `gen_ld.py`

Three forced repairs over W64-A19's generator:

1. **its `.ldfrag` inputs did not exist.** W64-A18 renamed the fragments per
   blob STEM (the fixed-name clobber fix), so `nfs4_recon.{data,sdata}.ldfrag`
   are gone; the successor reads `nfs4_recon.data_8010CCD4.ldfrag` and
   `nfs4_recon.sdata_8013C54C.ldfrag`.
2. **`objdata.json` is read from this wave's scratchpad**, with `scan.py` run
   immediately before every link (a stale objdata costs ~1 %, catalog 15E).
3. **the cut itself**: every `<stem>_jNN.*.o` is dropped from the object list
   AND from the script, and each surviving `_rNN` piece is placed at its own
   retail VA via `. = <offset>;` inside `.rodata_front`, so removing a piece
   shifts nothing. The map proves it:
   ```
   .rodata_front   0x80010000     0x28f0          <- exactly the retail span
    .rodata        0x80010000       0x78 …_r00.rodata.s.o
                   0x00000098               . = 0x98
    *fill*         0x80010078       0x20          <- the excised jtbl_80010078
   ```

`front_data` is deliberately **not** placed by this script (see §7 cursor):
adding a placed region for it would change `.data` addresses in the same
commit as the `.L` cut and make probe_link movement unattributable.

### The ladder (each rung measured on the tree as it stood)
| rung | undefined | of which `.L` | mult-def | reloc-trunc |
|---|---|---|---|---|
| no-cut control, pre-region-1 | 398 | 350 | 796 | 10 |
| after region 1 | **277** | 236 | 796 | 10 |
| after region 2 | **39** | **0** | 796 | 10 |
| final tree | **15** | **0** | 796 | 10 |
| final tree, same-instant no-cut control | 365 | 350 | 796 | 10 |

Undefined **strictly falls at every landing**, and the two invariant columns
prove the fall is the `.L` class alone.

---

## 5. GATES

| gate | result |
|---|---|
| `python tools/build.py --no-link` | RC=0, 508 recon objects, 94 rodata piece objects (run 5×) |
| `python tools/tu_order_audit.py` | **508 objects, 0 inversions** |
| `probe_link.py` (after `scan.py`, every time) | baseline **83.07 %** 202/442 → final **83.08 %** 202/442 — **CLIMBED** |
| `tools/ownmap.py` × 3 data regions | runs clean; untouched by this lane (no `.data`/`.sdata` blob, no recon source) |
| `tugate` spot-checks, owning TUs | fememcard 18/18 · memcard.c 20/20 · feapp 14/15 · camera 37/38 · r3dcar 26/27 · aih_cop 9/10 · FONT.c 1/2 · SPRINTF.c 0/1 — every one equal to its pre-existing baseline |

**Zero PASS→FAIL is STRUCTURAL here**, not merely measured: this lane changed
no `recon/**` source, no shared header and no `tools/*.py`, and no recon TU
includes `asm/data/**`. `probe_link` links only recon objects, so it likewise
cannot be moved by this lane — it is reported as a no-regression check.

---

## 6. TOOLS LEFT BEHIND (`scratchpad/w65a5/`, promote-worthy)

| file | what it does |
|---|---|
| **`jtbl_own.py`** | the jump-table ownership prover: implied-base + resolved-`R_MIPS_32` contiguous-run match, E5 and containment tiers, vanished-object reporting |
| `jtbl_diag.py` | per-word diagnosis of any region the byte proof cannot close |
| **`splitjtbl.py`** | the cut, whole-record granularity, A1–A5 + the boundary-alignment carry |
| **`p6.py`** | the splat-lane control, **image equality** + live-derived control script |
| `relink_nfs4ld.py` | writes the piece lists into `linkers/nfs4.ld`, re-proving the non-primary sections are empty every run |
| **`gen_ld.py`** | the recon-lane script generator + real link, with the `.L` cut and the two stale-input repairs |
| `scan.py`, `probe_link.py`, `proofs.py`, `vamap.py`, `blobparse.py` | copied in so the lane is self-contained |

---

## 7. CONTINUATION CURSOR (exact)

Re-measure first, always, in this order:

```bash
python tools/build.py --no-link                    # peers move build/**
python scratchpad/w65a5/scan.py                    # NEVER skip
python scratchpad/w65a5/jtbl_own.py                # re-prove ownership
python scratchpad/w65a5/gen_ld.py --link           # rerun IMMEDIATELY before every link
python scratchpad/w65a5/gen_ld.py --link --no-cut  # the same-instant control
python scratchpad/w65a5/p6.py                      # splat-lane image equality
python scratchpad/w65a5/probe_link.py
python tools/tu_order_audit.py
```

To re-cut after a blob or ownership change:
```bash
python scratchpad/w65a5/splitjtbl.py --blob scratchpad/w65a5/ctl_blob/rdata_80010000.rodata.s \
    --end 0x800128F0 --json scratchpad/w65a5/jtbl_own.json --apply
python scratchpad/w65a5/splitjtbl.py --blob scratchpad/w65a5/ctl_blob/rdata_80054548.rodata.s \
    --end 0x8005797C --json scratchpad/w65a5/jtbl_own.json --apply
rm -f build/asm/data/rdata_800*_*.o build/asm/data/rdata_80010000.rodata.s.o \
      build/asm/data/rdata_80054548.rodata.s.o
python scratchpad/w65a5/relink_nfs4ld.py --stem rdata_80010000 --sec rodata \
    --order scratchpad/w65a5/rdata_80010000_pieces_order.txt --apply
python scratchpad/w65a5/relink_nfs4ld.py --stem rdata_80054548 --sec rodata \
    --order scratchpad/w65a5/rdata_80054548_pieces_order.txt --apply
python tools/build.py --no-link
```
⚠️ `relink_nfs4ld.py` currently rewrites only the `.rodata` entries and leaves
the `.data`/`.bss` groups alone once they are lists; after a re-cut with a
changed piece COUNT, regenerate those two groups as well (§3.2 — they are
load-bearing for alignment even though every piece's section is empty).

### Ranked next targets (measured, cheapest first)

1. **Place the recon TU's own `.rodata` AT the jump-table VA.** This is the
   natural completion of LOCALIZE and the only remaining half. Today the recon
   lane leaves a zero hole at each cut region and the TU's own table lands in
   the trailing `.rodata_rest`, so the switch dispatch resolves to a
   non-retail address. Sizing evidence already collected: `fememcard`'s whole
   `.rodata` is exactly its 4 consecutive tables (0x800116F8..0x80011858, 4 ×
   88 B, contiguous in the blob); but `camera` is 44 words against a 45-word
   blob span (the 1-word zero pad after `jtbl_800558C8` sits inside the run),
   so this needs a per-TU `.rodata`-window ownership pass — an `ownmap`
   instance for `.rodata`, not a hand list.
2. **`front_data` has no placed region in `linkers/nfs4_recon.ld`.** Its
   pieces and their owning recon TUs still fall into the trailing
   `.data_rest` catch-all. `linkers/nfs4_recon.front_data.ldfrag` exists and
   is ready; `gen_ld.py` reads it nowhere by design (§4). One region, one
   measurement.
3. **`.rodata` anchoring for `rdata_80054548`.** Region 1 is placed at
   0x80010000; region 2's residual pieces are still swept by `.rodata_rest`
   with no address at all. Placing them needs the W62-A19 §6.3 step-7
   `.rodata` base anchoring (513 HI16+LO16 pairs across 123 objects) to be
   sure no text object overlaps the 0x80054548..0x8005797C window.
4. **The 6 `[CONTAIN]` regions become `[E5]` for free** when their owning
   functions seal (`fememcard`, `screenusername`, `memcard.c`, `aih_btcperp`,
   `aih_cop`, `camera`) — re-run `jtbl_own.py` after any of them lands.
5. **Do NOT touch the residual 15 undefined names** — that is A6's
   true-undefined class.

---

## 8. HAZARDS ENCOUNTERED

* 🔴🔴 **A peer belt's `git add -A` swept my entire region-2 landing into its
  own commit `0ba59955` ("w65a8: region 1+2 re-cut …").** The exact W64-A18
  §8 hazard, one wave later, and the peer's own message describes a *different*
  "region 1+2" (the data blobs). Content verified intact afterwards; only the
  message is not mine. `git add -A -- <deleted tracked path>` then failed with
  `pathspec did not match any files` because the deletion was already staged
  by that sweep — that error is the *tell* that a sweep has happened.
* 🔴 **`SUBALIGN(N)` overrides every input section's own alignment**, so it is
  fundamentally incompatible with blob cutting (§3.1). Any future region cut
  must check its output section's `SUBALIGN`.
* 🔴 **A zero-size input section is not free** — it still participates in
  alignment (§3.2).
* 🔴 **A P6 control snapshot goes stale under concurrent belts** — derive it
  from the live script (§3.3).
* 🔴 **`str.replace` without a match-count assert gave a fake "ok"** (catalog
  12K, fired again): the Write tool writes CRLF, and one of three multi-line
  patches silently did nothing while the script still printed success. The
  landed edits use the Edit tool or an `assert count == 1`.
* **`git status` on this tree prints ~20 000 characters of untracked
  scratchpad** — always scope it (`git status --porcelain -- <path>`).
* **`M` status with a ZERO-BYTE `git diff`** on ~30 `data_8010CCD4_*.s` files
  is the `.gitattributes`/autocrlf phantom; never stage them.
* **Stale build objects**: `build/asm/data/<stem>.rodata.s.o` survives the
  deletion of its source, and `gen_ld.py`'s object glob would link both it and
  the pieces. `rm` the stale object before rebuilding — `gen_ld.py` also
  asserts that the whole blob and its pieces never coexist in `asm/data`.
* **A partial `build/src` tree changes the splat lane's diagnostics by two
  orders of magnitude** (14 vs 2077 lines, and a 238 KB vs 1 237 KB `.nfs4`).
  Both P6 legs must be linked back to back on the same tree; the absolute
  numbers are not comparable across a rebuild.

---

## 9. FILES

**Landed:** `asm/data/rdata_80010000_[rj]NN.rodata.s` (33) ·
`asm/data/rdata_80054548_[rj]NN.rodata.s` (61) — the two whole blobs are gone ·
`linkers/nfs4.ld` (94 piece entries × 3 sections + the `SUBALIGN(4)` fix) ·
`linkers/nfs4_recon.ld` (regenerated, `_jNN` excluded, `_rNN` VA-placed).

**Evidence:** `jtbl_own.{txt,json}` · `jtbl_diag.txt` ·
`rdata_800{10000,54548}_pieces_order.txt` · `genld_report.txt` ·
`recon_{strict,multdef-ok}{,_nocut}.{err,map}` + `_undef.txt` ·
`p6_{new,ctl}.{err,elf,nfs4.bin}` + `p6_diff.txt` (empty) ·
`link_probe.txt` · `ownmap_{data,sdata,front}.{txt,json}` ·
`ctl_blob/` (the two pre-cut blobs) · `nfs4_PRE_W65A5.ld`,
`nfs4_ctlblob.ld` · `build_*.log` · `msg_r1.txt`, `msg_r2b.txt`.
