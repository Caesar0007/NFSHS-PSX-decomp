# W66-A4 RECEIPTS — THE `.rodata` OWNMAP + PLACEMENT

Repo `C:\Temp\nfs4-decomp`, wave W66, 2026-08-15. Started from `c7904577`;
peers landed `d594889a..4f662f85` during the run (see §8 — one of them
CLOBBERED my `linkers/nfs4_recon.ld`, restored and re-verified).
Every number below was measured in this run. No briefed number is reused.
Memory dir: READ-ONLY, untouched. `tools/*.py`: untouched. A3's `.bss`/symbol
files and A5's `front_data`/E3 files: untouched.

---

## 0. HEADLINE

| axis | control (same instant) | with `.rodata` placed |
|---|---|---|
| probe byte-EXACT objects | **161 / 443** | **169 / 443**  (**+8**) |
| probe bytes identical to retail | 764 670 (82.94 %) | 765 532 (**83.03 %**, **+862 B**) |
| objects whose `.text` diff changed | — | **96 improved, 0 regressed** |
| recon-lane real link, undefined names | 0 (`.L`=0) | **0 (`.L`=0)** |
| — multiple definition / reloc truncated | 797 / 10 | **797 / 10 (unchanged)** |
| `tu_order_audit` | 508 objects, 0 inversions | **508 objects, 0 inversions** |
| `relink` recon lane | — | **DUP REAL=0, HIDDEN PHANTOMS=0, UNRESOLVED=5** |

`tools/probe_link.py` (the standing control, which places NO `.rodata`) reads
**161/443, 82.97 %** on the same tree — the same byte-exact object count as my
control leg, so the +8 is measured against the standing instrument, not
against a private baseline.

**Why placing `.rodata` moves `.text` bytes at all** — the mechanism this lane
exists for: a switch dispatch materialises its table with
`lui %hi(.rodata+N)` / `addiu %lo(...)`, i.e. a HI16/LO16 relocation against
the LOCAL `.rodata` section symbol. W65-A5 excluded the splat blobs' `_jNN`
jump-table pieces from the recon link because the recon TU emits that table
itself, but nothing ever PLACED the TU's own `.rodata`: it fell into the
trailing `.rodata_rest` catch-all, so those two `.text` words linked to a
non-retail address in **123 objects**. Placing the section at its retail base
fixes them. It also fixes every CONSUMER of a `.rodata`-resident global — e.g.
`wildcard.c`'s three `_ctype_` references, which is how an unplaced object
turned up in the delta list.

---

## 1. THE INSTRUMENT — `rodownmap.py`, the `.rodata` twin of `tools/ownmap.py`

`tools/ownmap.py` derives a window's retail base from a BLOB LABEL the object
also defines. A compiler-emitted jump table carries **no global symbol at all**
(it is a local `$L`/`.L` label), so no recon object ever defines a `jtbl_<VA>`
name and ownmap yields **zero** `.rodata` windows. Three anchors replace it;
everything after the anchor is verbatim ownmap E1–E5.

| anchor | rule | result |
|---|---|---|
| **1. jump-table CONTENT** (W65-A5's proof, generalised to a base) | `implied_text_base(obj) = mode(retail VA − our offset)` over the object's `.text` symbols; every `R_MIPS_32`-vs-`.text` word in our `.rodata` resolves to `base + addend`; a blob region `jtbl_<VA>` holding `[t0..tN-1]` anchors the section at `VA − offset` iff a CONTIGUOUS run of N resolved words equals that sequence element for element | **50 regions across 37 objects** |
| **2. UNIQUE MASKED ROM MATCH** | resolve every relocation we can, WILDCARD the rest, search the ROM for the byte pattern at 4-aligned positions; a unique hit is simultaneously the anchor AND the E5 byte proof | **76 of 127** unique (1 ambiguous, 43 no match, 7 no usable seed) |
| **3. BEST PARTIAL MATCH** (content is a near-miss, so anchor 2 can never fire) | every fixed run ≥12 B with ≥3 distinct non-zero bytes seeds a candidate; accepted only if the base is inside a rodata blob span, is the unique best by ≥8 pp, and matches ≥60 % of comparable bytes; **every accepted base is printed with its score** | **9 accepted**, 62.5 %–98.9 % |

🔑 **THE CROSS-CHECK IS THE ANTI-VACUITY PROOF: where anchors 1 and 2 both
exist they AGREE 17/17, disagree 0.** Two mechanically independent derivations
(relocation arithmetic vs raw byte search) of the same number.

**Anchored: 105 of 127 objects with a non-empty `.rodata`.**

E1–E5, unchanged from ownmap: E1 no foreign/un-migrated blob label inside
(own jtbl regions and splat `D_` interior labels absorbed); E2 every anchored
region inside the window; E3 ONE implied base — *N independent jump tables in
one TU must agree*; E4 both edges at blob-record boundaries (+ the 4-aligned
record-interior cut and the trailing retail-ZERO alignment-pad relaxations);
E5 our bytes with every relocation RESOLVED equal retail's, an unresolvable
reloc making the window `E5?` UNDECIDABLE, never silently owned.

**47 windows are fully E1–E5 clean (2 868 B owned).** Failure histogram:
E3 1 · E4 54 · E5 29 · E5? 1 · E1-foreign 2 · E1-unmigrated 4 · E2 0.
(E4 is high because 9 windows live in the DATA blobs, whose record boundaries
this tool does not load — see §5.)

Anti-vacuity asserted every run: objdump batched (never one glob), an empty
batch is a hard assert, an object producing no record is named; an object that
VANISHED from `build/` under a peer between the scan and the objdump is
reported BY NAME; the blob record set is re-assembled from the CUT PIECES and
asserted to tile each span with no gap/overlap and to start at the blob base;
the `jtbl` trailing-zero-pad shape is re-proved (a `.L` word after a non-`.L`
word, or a non-zero trailing word, aborts); `objdump -s` length is asserted
equal to `objdump -h`; **zero anchors is a hard assert** — the tool cannot
pass vacuously.

---

## 2. THE PLACEMENT — `mkplace.py`

OWNERSHIP and PLACEMENT are deliberately different questions. E1–E5 answers
*may the recon TU's bytes REPLACE the blob's over this window* (the licence to
CUT). Placement answers *at which VA must this section link so its jump table
lands where retail's does* — decided by the ANCHOR alone. A TU whose content
is a near-miss still needs its table at the retail VA, because the
`%hi/%lo(.rodata+N)` pairs in its `.text` resolve through the section base.
Measured: **every placed object improved, none regressed**, including the
E5-red ones.

🔴 **Overlap resolution is by TRUST, not by address order.** A low-address
window whose base is wrong swallows a dozen correct neighbours if the pruner
keeps the first. Windows are accepted in descending proof strength
(E1–E5 clean > E5 bytes-equal > jtbl-anchored > partial), and a colliding
lower-trust window is dropped and NAMED. **101 placed, 3 dropped:**

| dropped | clashes with | cause |
|---|---|---|
| `texture.cpp` 0x800569f0..0x80056aac | `skidmark.cpp` (E1–E5 clean) | head not in ROM at the base |
| `track.cpp` 0x800564f0..0x80056724 | `scene.cpp` (E5 clean) | head not in ROM at the base |
| `fixdatan.c` 0x800568b0..0x80056cd8 | `skidmark.cpp` (E1–E5 clean) | 1 032-byte head not in ROM; the `.rodata` SPLIT-STORAGE class (§4) |

---

## 3. THE `.ld` LANDING — `linkers/nfs4_recon.ld` (via the gen_ld lane)

`scratchpad/w66a4/gen_ld.py` (successor of W65-A5's) adds two legs:

1. **`.rodata_main 0x80054548`** — the SECOND rodata blob had **no placed
   region at all** at HEAD (cursor item 3): its residual `_rNN` pieces fell
   into `.rodata_rest` with no address. Placed now, `_jNN` still excluded.
   The precondition the cursor asked for is MEASURED, not assumed: **ZERO
   text objects intersect 0x80054548..0x8005797C** (`ai.cpp.o` starts exactly
   at the blob end 0x8005797C), and the generator ASSERTS it per object.
2. **92 × `.roNNNN <retail base> : { <obj>(.rodata); }`** — one region per
   anchored TU whose window lies inside a rodata blob span, VA-ordered, with a
   generator assert that the windows do not overlap each other.

Diagnostics, this leg vs the same generator with `--no-rodata`, same instant:

| | control `--no-rodata` | with the placement |
|---|---|---|
| `[strict]` undefined names | 0 (`.L`=0) | **0 (`.L`=0)** |
| `[strict]` multiple definition | 797 | **797** |
| `[strict]` relocation truncated | 10 | **10** |
| `[multdef-ok]` | 0 / 0 / 10 | **0 / 0 / 10** |

Strictly neutral on every link diagnostic, so the placement is address-only.

**No splat-side change was made**, therefore the P6 image-equality control is
not applicable to this landing (it gates blob CUTS; W65-A5's `p6.py` is copied
into the lane for the follow-up in §5). `linkers/nfs4.ld` untouched.

---

## 4. THE SHORT/LONG DIAGNOSIS — `ropad.py` + `rosplit.py` (the camera 44/45 question, answered)

**MECHANISM.** gcc-2.8 emits `.rdata` + `.align 3` immediately before every
switch jump table (`BIGGEST_ALIGNMENT` = 64 bits on MIPS). `.align` is
relative to the SECTION START, so whether it costs a 4-byte pad depends on how
much `.rdata` the TU emitted BEFORE the table. If our reconstruction's leading
`.rdata` differs in length from retail's by **≡ 4 (mod 8)**, the pad appears
(or disappears) and the whole section's implied base slides by 4: the jump
table still anchors correctly, but every OTHER `%hi/%lo(.rodata+N)` in that
TU's `.text` then resolves 4 bytes off.

`ropad.py` tests it mechanically — with `B` our base, `R` the nearest record
boundary at/above it, `d = R − B`, `J` our first table's offset:
`ours[0:J−d] == retail[R:R+J−d]` **and** `ours[J−d:J]` all zero **and**
`ours[J:] == retail[R+J−d:]`. Verdicts over the 54 E4/E5-failing windows:

| verdict | n | meaning |
|---|---|---|
| **BASE-OK** | 28 | base already a record boundary |
| **PAD** | 4 | proven 4-byte `.align 3` pad, head and tail byte-exact |
| **GAP** | 11 | base sits deep inside a record — our leading content is not retail's there |
| **SHIFT?** | 2 | partial (see `screencarselect`, `fixdatan`) |
| **OTHER** | 9 | window is in a DATA blob (§5) |

**WORKED EXAMPLE — `camera.cpp`, the cursor's 44-vs-45-word case (CLOSED).**
Our `.rodata` is 220 B = three 12-byte arrays (0x24) + a **4-byte zero pad** +
three jump tables (180). Retail's run is 216 B with NO pad: `.rodata`
`+0x00..0x20` equals retail `0x800558A4..0x800558C8` word for word, and every
one of the 45 jump-table words matches. The 9 "differing" words are purely
the 4-byte slide. Arithmetic closes it: `jtbl_800558C8` must be 8-aligned
*section-relative*, and the only blob-record boundary ≤ 0x800558A4 satisfying
`0x800558C8 − base ≡ 0 (mod 8)` is **0x80055880** — whose record holds a
`{0, 0x000A0000, 0}` word triple and two `"SimpleMem"` string literals.
⇒ **`camera.cpp` is missing 0x24 bytes of LEADING `.rodata`**; with it the
`.align 3` costs nothing and the section base is 0x80055880.
**NOT fixed**: adding a const + two string literals requires the code that
references them, so it is *not* codegen-inert (the mission's bar). Documented.
Same class, same cure, same verdict: `femenuoptions`, `fememcard`, `r3dcar`.

**The mirror sub-class (retail HAS the pad, we do not)** — `rosplit.py` finds
our head in the ROM at `base − 4` (`screencarselect` 0x80011aa4,
`stattool` 0x80012514, `replay` 0x8005654c, `cario` 0x8005676c) or `base − 0x14`
(`aih_traf` 0x800551a4): retail's leading `.rdata` is ≡4 (mod 8) LONGER than
ours. Same root cause, opposite sign.

🔬 **MEASURED FALSIFICATION — head-anchoring those five is WORSE.** A full A/B
placing them at their head-derived base instead of their table-derived base:
**+861 B vs +862 B, byte-exact objects +8 in both.** The table anchor wins;
recorded so it is not re-fought.

**`fixdatan.c` = the `.rodata` SPLIT-STORAGE class.** Its 1 064-byte section is
a 1 032-byte table + a 32-byte jump table. The table's bytes are NOT at the
table-anchored base, while siblings `atanfunc.c` (0x80136ce8) and
`asinfunc.c` (0x80137260) anchor cleanly into the DATA blob region: retail put
the eaclib math tables in `.data` and only the jump table in the resident
`.rodata` run. **One object, two disjoint retail runs — unplaceable as a
single section.** Dropped from placement (it would swallow 12 correct
neighbours); named, not forced.

---

## 5. 🔴 A REAL DATA BUG — `_ctype_` WAS 128 BYTES TOO LONG (fixed)

`recon/syslib/psx/libc/CTYPE0.c` declared `_ctype_[257]`. The blob itself
labels the run `_ctype_` 0x801371D0..**0x80137260** and `asintbl` from
0x80137260 (`asm/data/data_8010CCD4_r18.data.s`). The extra 128 bytes were
**15 bytes of retail inter-object ZERO pad plus 113 bytes of `asinfunc.c`'s
arcsin table** — our object literally carried another object's data.

How the ownmap surfaced it: `CTYPE0.c` and `asinfunc.c` BOTH produced unique
exact ROM matches, at 0x801371D0 and 0x80137260, and their windows OVERLAPPED
by 113 bytes — an impossibility that can only mean one section is over-long.
Fixed to `_ctype_[129]` (index −1..127: a signed `char c` gives `c+1` in
−127..128, so 129 is the exact reachable span). After the fix the two windows
are disjoint and both E5-clean.

**Codegen-inert, gated 2×**: `CTYPE0.c` is a DATA-only TU with zero functions;
every reference is `%hi/%lo(_ctype_)`, size-independent; the only consumer,
`wildcard.c`, declares it UNSIZED. `verify_asm wildcard` = **PASS (150 insns)
twice**, before and after. `.rodata` size now `0x81`.

Same catalog class as W65-A6's `sndStreamMap` overrun ("cross-check a
materialised array's byte-length against its successor symbol").

---

## 6. QUEUED FOR THE DATA LANE (byte-proven, not landed here)

Nine anchored windows are E5-clean but sit in the **DATA** blobs, i.e. our
compiler classes them `.rodata` while retail's run is `.data`. There is
already a precedent for exactly this in `linkers/nfs4_recon.data_8010CCD4.ldfrag`
line 61 (`matrix.c.o(.rodata)` at 0x801237ec). The other eight are ready to
follow, with the same one-line ldfrag treatment and a blob cut:

| window | size | object |
|---|---|---|
| 0x80136ce8 | 257 B | `eacpsxz/atanfunc.c` |
| 0x801371d0 | 129 B | `libc/CTYPE0.c` (after §5) |
| 0x80137260 | 512 B | `eacpsxz/asinfunc.c` |
| 0x8013c348 | 514 B | `sndpsxz/snddata.c` |
| 0x8013c5d8 | 13 B | `game/common/aistate.cpp` |
| 0x8013d410 | 21 B | `game/common/sim.cpp` |
| 0x8013d440 | 8 B | `game/common/souffle.cpp` |
| 0x8013dc20 | 16 B | `eacpsxz/memstd.c` |

(`matrix.c` 0x801237ec, 52 B — already landed by the data lane.)
They are DELIBERATELY not placed by this lane: their addresses fall inside the
`.data`/`.sdata` regions the ldfrags own, and placing them here would put two
lanes' entries at the same VA. Their probe value is real and already visible
in the +8 (they are included in the probe list, which tolerates overlap
because it compares `.text` only).

**Corroboration with the w66-a6 finding** in the consolidation commit
(`probe_link falls as data-mat succeeds — the dummy `.other` catch-all
mis-resolves new data; spec = implied-base data treatment`): this lane is the
`.rodata` half of exactly that spec, and the instrument (`probe_ro.py`) shows
the shape a `probe_link` extension would need.

---

## 7. GATES

| gate | result |
|---|---|
| `tools/build.py --no-link` | RC=0, 508 recon objects (run 3×) |
| `tools/tu_order_audit.py` | **508 objects, 0 inversions** |
| `tools/relink.py`, recon lane | **DUP total 797 / blob-class 797 / REAL 0**, **HIDDEN PHANTOMS 0**, UNRESOLVED 5 |
| `tools/relink.py`, src lane | RED 5 — **pre-existing, not this lane**: the 5 REAL DUPs are all src-lane `INCLUDE_ASM` objects (`spchrule`↔`spchdata` ×3, `aihigh`↔`aih_btcperp`, `INTR_DMA`↔`INTR`); 4 of the 5 are exactly the multi-VA names `tu_order_audit` excludes. This lane touched no `src/**`, no `asm/**`, no `configs/**`. |
| `tools/probe_link.py` (standing control) | 161/443 byte-exact, 82.97 % — unchanged (it places no `.rodata`) |
| `scratchpad/w66a4/probe_ro.py` A/B | **161 → 169 byte-exact (+8), +862 B, 96 improved, 0 regressed** |
| `verify_asm wildcard` (the `_ctype_` consumer), 2× | **PASS (150 insns)** both runs |
| recon-lane real link, with vs without the placement | identical on every counter |

**Zero PASS→FAIL is structural for the `.ld` half** — it changes no `recon/**`
source and no shared header. The one source change (§5) is in a DATA-only TU
with zero functions; its only consumer is gated twice.

🔴 **A PROBE-HARNESS CORRECTION worth keeping.** The first A/B ran leg A with
NO `.rodata` sections placed, which pulled 101 sections out of the
`.other 0x80300000` catch-all and moved SEVEN unplaced objects' `.text` bytes,
making the delta unattributable. Leg A now places the SAME set at a
non-retail scratch base (0x80400000 + i·0x4000), so `.other` is byte-identical
in both legs and the ONLY variable is the base. Any future data-placement A/B
needs the same treatment.

---

## 8. HAZARDS ENCOUNTERED

* 🔴🔴 **A PEER REGENERATED `linkers/nfs4_recon.ld` FROM `scratchpad/w65a5/gen_ld.py`
  MID-RUN AND CLOBBERED THIS LANE'S VERSION** — the file silently reverted to
  the W65-A5 header with `git diff` EMPTY, after my generator had already
  written and linked it. Caught only by grepping for my own `.roNNNN` marker.
  **`linkers/nfs4_recon.ld` is a GENERATED SHARED FILE and two lanes'
  generators overwrite each other wholesale**; a `git status` check is useless
  because the clobber restores the file to HEAD. **ORCHESTRATOR ACTION: fold
  the W66-A4 legs into ONE canonical generator (or nominate an owner), and
  make every gen_ld variant refuse to run if the file it is about to write
  carries another lane's marker.** Restored + re-linked + re-verified.
* 🔴 **`git status` on this tree prints ~20 000 characters of untracked
  scratchpad** — always scope it (`git status --porcelain -- <path>`).
* Peers moved HEAD `c7904577 → 4f662f85` during the run; the object census
  changed under me (placed text objects 442→443, no-base 10→1). Every number
  in this file was re-measured at the final HEAD after a fresh
  `build.py --no-link` + `scan.py`.
* `blobparse`/`vamap`/`ownmap` root-resolution: `tools/` is `parents[1]`,
  scratchpad is `parents[2]` (catalog 16F). A copied `HERE = ROOT /
  "scratchpad" / "w65a5"` in the inherited `gen_ld.py` wrote this lane's
  report into the PREVIOUS lane's directory until fixed.
* No heredoc was used for any escape-bearing content (Write tool only).

---

## 9. TOOLS LEFT BEHIND (`scratchpad/w66a4/`, promote-worthy)

| file | what it does |
|---|---|
| **`rodownmap.py`** | THE `.rodata` ownmap: 3 anchors (jtbl content / unique masked ROM match / best partial) + ownmap E1–E5 with the reloc-aware E5 leg, the anchor cross-check, and the full anti-vacuity assert set |
| **`mkplace.py`** | ownmap → placement list; trust-ordered overlap resolution, every drop named |
| **`ropad.py`** | the `.align 3` alignment-pad diagnosis (PAD / GAP / SHIFT / BASE-OK) — the camera 44/45 instrument |
| **`rosplit.py`** | the SPLIT-STORAGE screen: ROM-searches the pre-table head independently |
| **`rodiag.py`** | per-object word-by-word window dump vs retail with relocs resolved and record boundaries marked |
| **`probe_ro.py`** | the A/B probe with the `.rodata` placement leg + the scratch-base control (see §7) |
| **`gen_ld.py`** | the recon-lane generator, now emitting `.rodata_main` and the 92 `.roNNNN` regions |
| `scan.py`, `probe_link.py`, `p6.py`, `proofs.py`, `splitjtbl.py`, `relink_nfs4ld.py`, `jtbl_own.py` | copied from W65-A5 so the lane is self-contained |

Evidence: `rodownmap.{txt,json}` + `rodownmap_all.json` · `ropad.{txt,json}` ·
`rosplit.txt` · `rodata_placement*.json` · `probe_ro.json` ·
`probe_{A,B}.{ld,map}` · `recon_strict{,_NORO}.err` +
`recon_strict_undef{,_NORO}.txt` · `genld_report.txt` · `objdata.json`.

---

## 10. CONTINUATION CURSOR (exact)

```bash
python tools/build.py --no-link
python scratchpad/w66a4/scan.py                 # NEVER skip
python scratchpad/w66a4/rodownmap.py            # re-anchor (peers move build/**)
python scratchpad/w66a4/mkplace.py --tier e3
python scratchpad/w66a4/gen_ld.py --link        # rerun IMMEDIATELY before every link
python scratchpad/w66a4/gen_ld.py --link --no-rodata   # the same-instant control
python scratchpad/w66a4/probe_ro.py
python tools/tu_order_audit.py && python tools/relink.py
```

### Ranked next targets (measured, cheapest first)

1. **The 8 DATA-blob windows (§6)** — one ldfrag line each plus a blob cut,
   `matrix.c` is the precedent, all byte-proven E5-clean. Needs the P6
   image-equality control because it cuts a blob.
2. **`fixdatan.c` SPLIT-STORAGE** — the 1 032-byte table wants the DATA lane's
   treatment while the 32-byte jump table stays in the resident run; today the
   TU is unplaceable and blocks nothing else (it is dropped, not forced).
3. **The 4 PAD + 5 mirror-PAD TUs (§4)** — each is a named MISSING/EXTRA
   leading-`.rodata` reconstruction gap of ≡4 (mod 8) bytes, with the exact
   byte content for `camera.cpp` already decoded (`{0,0xA0000,0}` +
   `"SimpleMem"` ×2 at 0x80055880). Fixing any of them collapses that TU's
   remaining `.rodata` address error.
4. **22 objects still unanchored** (7 with no usable seed, 1 ambiguous, the
   rest content near-misses); `speech.cpp` 799 B, `screenusername` 376 B,
   `SYS.c` 462 B and `LIBPRESS.c` 337 B are the biggest, and `SYS.c` alone
   carries 52 `.text`→`.rodata` relocations.
5. **`probe_link.py` extension** — teach the standing tool the `.rodata`
   (and, per w66-a6, the `.data`) implied-base treatment; `probe_ro.py` is the
   working reference including the scratch-base control leg.
