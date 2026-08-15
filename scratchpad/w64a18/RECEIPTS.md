# W64-A18 RECEIPTS — THE LINK CAMPAIGN, DATA REGIONS

Continues W63-A19's blob-vs-TU data-ownership sweep. Every number below was
measured in this run; no briefed number was reused. Memory dir: READ-ONLY,
untouched. `tools/*.py`, `tools/maspsx`, and the four user-live TUs
(`femenu.cpp`, `fetv.cpp`, `screenpost.cpp`, `screenusername.cpp`): untouched.

Commits: `37291b82` (regions 1+2) · `2ab433f4` (region 3) · plus this file.
⚠️ The region-2 first cut was swept into a peer's commit `39026b4d` — see §8.

---

## 0. MANDATORY READS (done, in order)

1. `reference_mips_isa_asm.md` — full.
2. `reference_psx_cpp_reconstruction_methodology.md` — full (1018 lines, read in
   pages). §0 seal bar, §1 authority hierarchy, §2 step 4b data-materialisation,
   §3.9b code-as-data islands (the SN-LNK blob signature that decided the isqrt
   cut), §3.12 #5/#6 storage shape, §8.4/8.5 section map.
3. `reference_asm_pattern_catalog.md` — the 12/13/14/15 series in full; **15E**
   (production lane + link campaign) is this lane's brief, 14B is its inventory.
4. `AGENT_GUIDE.md`, `scratchpad/w64/BRIEF.md`, `scratchpad/w63a19/RECEIPTS.md`,
   `scratchpad/w62a19/LAYOUT_AUDIT.md`, `scratchpad/w62a18/SYMBOL_LEDGER.md`.

---

## 1. HEADLINE — all three blob regions are now cut

| region | blob | bytes | W63 baseline | **W64 final** | pieces |
|---|---|---|---|---|---|
| 2 | `data_8010CCD4` | 194 680 | 26 win / 24 232 B | **32 win / 34 144 B** | 52 (20 r + 32 o) |
| 1 | `sdata_8013C54C` | 6 192 | 30 win / 408 B | **35 win / 776 B** | 58 (23 r + 35 o) |
| 3 | `front_data` | 6 360 | *untouched* | **10 win / 428 B** | 19 (9 r + 10 o) |
| **all** | | **207 232** | **56 win / 24 640 B** | **77 win / 35 348 B** | **129** |

Duplicate blob labels resolved (the 800-symbol T1 blocker of W62-A18 §1.1):
**273 of 813** TU-defined labels now sit inside an owned window
(region 2: 133 of 277 · region 1: 127 of 458 · region 3: 13 of 78).

Ownership grew **+43.5 %** (24 640 → 35 348 B). **+7 888 B of that came from
instrument corrections alone, with zero source edits** — i.e. it was already
byte-provable and the old model could not see it.

Acceptance metric (`probe_link.py`, re-measured by me, never briefed):

| when | bytes identical | byte-exact objects |
|---|---|---|
| my baseline (fresh build, fresh scan) | 81.31 % | 201 / 441 |
| after regions 1+2 | 83.02 % | 202 / 441 |
| after region 3 (close) | **83.29 %** | **202 / 442** |

It CLIMBED and never dropped. ⚠️ Not attributable to this lane: `probe_link`
compares only `.text`, and its ld input set is the recon objects in
`objdata.json` — **no `asm/data` object is an input**. Peer belts moved
`recon/**` throughout. `scan.py` was re-run immediately before every
`probe_link.py`, as W63-A19 requires.

---

## 2. THE INSTRUMENT — `ownmap2.py`, five corrections to the E1–E5 model

W63-A19's `ownmap.py` (now promoted) decides ownership per `(recon object,
section)` window: `implied_base = retail_VA(label) − our_section_offset(label)`,
`window = [base, base+size)`, owned iff E1 (no foreign/un-migrated label
inside) ∧ E2 (no own label outside) ∧ E3 (one implied base) ∧ E4 (both edges
are blob-label boundaries) ∧ E5 (window bytes == retail bytes).

Five defects found and fixed. **Three cost ownership; one was a real vacuity
hole; one is a policy guard.**

### (A) E5 IS NOW RELOCATION-AWARE — the biggest false-negative

An `R_MIPS_32` word in a data section holds only its **addend** until link, so
its raw bytes can *never* equal retail's linked value. v1 compared raw bytes,
so **every pointer-bearing data section was mis-classified as a DATA DEFECT.**

v2 builds a global name→VA map (`vamap.py`: `configs/symbol_addrs.txt` 4 740 +
every `asm/**/*.s` dlabel → **6 788 names**), resolves each `R_MIPS_32` as
`VA(sym) + in-place addend`, and compares the *resolved* word. A reloc whose
target VA is unknown makes the window **UNDECIDABLE (`E5?`)** — never silently
owned. This is a *strengthening*: v1 could also PASS a window whose reloc value
happened to match.

* **Hand-verified**: `fei.cpp` has 108 `.data` relocs; all 108 resolve to
  retail's exact linked words (`gUseFrontend`→`0x8013D274`,
  `GameSetup_gData+0x0…+0x1A4`). Its 912-byte window flips from
  "432 of 912 bytes differ" to **OWN**.
* `libcd/cddebug.c`'s "160 of 160 bytes differ" is **not a defect either** — it
  is a `.rodata`-relative string table (`CD_comstr`, 40 relocs). Its `.rodata`
  base is unanchored (W62-A19 §2.1: 113 objects have no `.rodata` symbol), so
  it is now honestly reported `E5? UNDECIDABLE`, not "wrong data".
* Region-2 histogram: `E5 bytes differ` 21 → 15, `E5? undecidable` 4.

### (B) E4 ACCEPTS A RECORD-INTERIOR CUT

The splat blob's label granularity is coarser than the object boundary, so a
section's end often lands strictly inside the last blob *record*. Two
sub-cases, both byte-proven, both reported explicitly in the map:

* **B1 RECORD SPLIT** — a 4-aligned cut inside a record that is ours or a splat
  `D_` interior label. The blob is one data directive per line with a
  `/* fileoff VA bytes */` comment, so the cut is a clean LINE split
  (`splitblob2.py`; line sizes derived from the NEXT line's VA, never guessed
  from the directive). Customers: `isqrt.c` **256 B** — its 8-byte tail at
  `0x8013BF10` is `50 73 0b 25 9b 53 43 00`, the **inert SN-LNK linker-blob
  signature** of methodology §3.9b, *not* `isqrttbl` data; `matrix.c` `.rodata`
  **52 B**; 4 more in `front_data`.
* **B2 ALIGNMENT SLACK** — our section ends < 4 bytes short of the next
  boundary and retail's bytes there are **zero**: inter-object alignment pad,
  supplied by the `.ld`'s `FILL(0)`. Customer: `nfs3.cpp` `.data` **6 668 B**.
  The tail datum `befuddleTemp` is `char[10]` and **our size is RIGHT** — SYM
  `2c73a6: $80115c3c 96 Def2 class EXT type ARY CHAR size 10` — so the 2 bytes
  to `0x80115C48` are pad, not a missing datum. (The briefing's reading of the
  E4 class as "add the missing tail object" holds for some windows; for the two
  biggest it was the *blob's* granularity, not our data, that was wrong.)

### (C) A SPLAT `D_<VA>` LABEL IS ABSORBED AT THE WINDOW BASE TOO

v1 absorbed `D_` synthetics only strictly inside the window (`va > base`),
which blocked every TU whose section starts with un-named data —
`genericpmx.cpp` leads with **208 bytes = 26 eight-byte `D_` records**. Safe:
a `D_` name is never TU-defined (the foreign test runs first) and ownership
still requires E5 over the window's *whole* extent. **+604 B.**

### (D) AMBIGUOUS-ANCHOR GUARD — a real vacuity hole, caught in region 3

`maspsx` re-emits every `.bss`/`.sbss` entry with an unconditional `.globl`
(W62-A18 §1.2 / T5), so the **five file-static copies of `gSwapFileName` become
global** and are indistinguishable from the one real global. ownmap anchored a
window on that name in **four different TUs, all claiming `0x80052064`**, and
v1's overlap pruning then kept one **arbitrarily** — a silently wrong cut.

v2 excludes any blob label defined by more than one `(obj, section)` from base
derivation; a window left with no unambiguous anchor is reported **E0** and
never owned. front_data: 15 "ownable" with 3 dropped-by-overlap → **12 with 0
dropped**. Re-checked against regions 1 and 2: **window sets IDENTICAL** (0
ambiguous anchors there), so the landed cuts are unaffected.

### (E) `--exclude` FOR USER-LIVE TUs

`femenu.cpp` / `fetv.cpp` / `screenpost.cpp` / `screenusername.cpp` are under
live user edit; their section sizes can move under a landed cut. Their 2
front_data windows (16 B) are deliberately left residual.

---

## 3. SOURCE FIXES — four, all decoded from `rom/nfs4-f.exe`, all gated ×2

Zero PASS→FAIL. Every TU re-gated before and after, twice.

| # | TU | defect | evidence | result | gate |
|---|---|---|---|---|---|
| 1 | `game/common/aicop.cpp` | **REAL RUNTIME BUG** | see below | E5 301/1420 → 0; window **1420 B OWN** | 4/4 PASS (was 4/4) |
| 2 | `game/common/fastrand.cpp` | tentative defs break section ORDER | 3 implied bases | E3 → 1; **16 B OWN** | 2/2 PASS (was 2/2) |
| 3 | `game/common/genericpmx.cpp` | declarations sorted ALPHABETICALLY | 10 implied bases | E3 → 1; **276 B OWN** (with C) | 1/1 PASS (was 1/1) |
| 4 | `game/common/nfs3.cpp` | same tentative-def order | 4 implied bases | E3 4 → 2; 13 symbols now at their exact retail offsets; window still blocked (needs `-G8`, §7) | 10/11 PASS (was 10/11) |

### 3.1 `aicop.cpp` — the cop-chase tuning tables were silently corrupt

`copLevel_t` is a **nested** struct — `copChasers[2]`, `numBlockaders`,
`copBlockaders[2]`, `spikeBelt`, `copAggression[2]`, then `copsPerLap`,
`engagementLapFraction`, `warningTicks`, `beatingTicks`, `numWarningsAdded`
= **13 words / 52 bytes**. All six tables (`twoLapCopGame`, `fourLapCopGame`,
`twoLapCopGameSplit`, `fourLapCopGameSplit`, `twoLapCopGame1H1AI`,
`fourLapCopGame1H1AI`, 25 entries) were written as **flat 10-value
initialisers**, so C brace elision assigned values to the wrong fields from
`copBlockaders[1]` onward and left the last 3 words zero.

Retail entry 0 of `twoLapCopGame` is `2,0,0,0,0,0,0,0,16,19660,512,128,2`;
the flat form produced `spikeBelt=16`, `copAggression={19660,512}`,
`copsPerLap=128`, `engagementLapFraction=2`, everything after zero. **Every
cop chase level in the game had the wrong spike-belt flag, aggression pair,
cops-per-lap, lap fraction, and warning/beating ticks.** No per-function gate
can see this (it is data), and it is exactly the class ownmap's E5 leg exists
to catch.

Rewritten with explicit nested braces, values decoded **word-for-word** from
the ROM at each table's VA. Residual: 24 bytes = `copGame[]`'s six
`R_MIPS_32` pointer words, resolved by correction (A).

### 3.2 THE `= 0` LEVER (new, reusable — the dominant E3 cure)

**Symptom:** a TU's small-data window shows N distinct implied bases; retail
*interleaves* initialised and zero objects in one run, ours emits **all
initialised first, all zero after**.

**Root cause:** a TENTATIVE definition (`u_int x;`, no initialiser) is emitted
after every initialised object of the same section. Retail's interleaving is
only possible if **all** of them carried an initialiser.

**Fix:** give the zero objects an explicit `= 0` / `= {0}`. Proven on
`fastrand.cpp` (`randtemp`, `numRandCalls`: 3 bases → 1, window OWN) and
applied to `nfs3.cpp`'s eight zero `.sdata` objects (4 bases → 2, all 13 named
symbols now land at their exact retail offsets).

**Sibling lever — DECLARATION ORDER IS EMISSION ORDER.** `genericpmx.cpp`
listed its 20 globals alphabetically (a reconstruction artefact, not retail);
gcc emits each section in declaration order, so its 13 small-data pointers were
in the wrong `.sdata` order and the whole 276-byte run was un-placeable.
Reordered into two retail-VA-ordered groups (`.data` @0x80112AE0, `.sdata`
@0x8013D1DC) with a "do NOT re-sort" comment. Both levers are **codegen-inert**
(the gates are byte-identical before and after) — they only move data.

`orderdiag.py` is the instrument: per `(obj, section)` it prints our offset,
implied base, retail VA, retail record size, whether retail's bytes are zero
(the `= 0` candidacy test), and both orderings side by side.

---

## 4. GATES

| gate | result |
|---|---|
| `python tools/build.py --no-link` | 508 recon objects, **0 TU build failures** (run 4×) |
| `python tools/tu_order_audit.py` | **508 objects, 0 inversions** (5 multi-VA names excluded, as always) |
| `probe_link.py` | **CLIMBED** 81.31 % → 83.29 %, 201 → 202 byte-exact |
| `tugate` aicop.cpp | 4/4 PASS ×2 (baseline 4/4) |
| `tugate` fastrand.cpp | 2/2 PASS ×2 (baseline 2/2) |
| `tugate` genericpmx.cpp | 1/1 PASS ×2 (baseline 1/1) |
| `tugate` nfs3.cpp | 10/11 PASS ×2 (baseline 10/11 — the 8-diff `NFS3_CheckForFileOperations` near-miss is pre-existing and untouched) |
| `tugate` isqrt.c / fei.cpp | 1/1 PASS · 0/0 PASS (baseline identical) |

Zero PASS→FAIL is *structural* for the blob work (it changes no `recon/**`
source and no shared header, and no recon TU includes `asm/data/**`) and
*measured* for the four source fixes.

---

## 5. PROOFS — the full anti-vacuity battery, per region

`scratchpad/w64a18/proofs.py` (P1–P5) + the P6 splat-lane control.

| proof | `data_8010CCD4` | `sdata_8013C54C` | `front_data` |
|---|---|---|---|
| P1 parser round-trip byte-identical | 856 records, 194 680 B | 1 099 records, 6 192 B | 227 records, 6 360 B |
| P2 data lines identical **and in order** | 49 518 | 1 186 | 1 655 |
| P3 concatenated piece objects == control object | 194 680 == 194 680 | 6 192 == 6 192 | 6 360 == 6 360 |
| P4 relocations identical (offset, type, target) | 454 | 3 | 71 |
| P5 bytes differing from ROM, **outside a reloc word** | 1 808 → **0** | 12 → **0** | 283 → **0** |

P5 is checked byte-by-byte against the relocation coverage *set*, never
inferred from a count (the W63-A19 hazard).

**P6 — splat-lane control, all three regions at once.** `ld` with the 129
pieces vs `ld` with the three un-split control blob objects:
**rc 1 both, 2 077 stderr lines both, and after normalising the object name and
the section-relative offset the diagnostics are 0 DIFF LINES.** (W63-A19
reported "29 lines differ, all name/offset"; this is the exact-equality form.)

P6 re-confirms W62-A19 §0 / W63-A19 §3: **`linkers/nfs4.ld` does not link at
HEAD** and never did in this state — it dies on ~2 077 undefined `.L<VA>`
jump-table labels out of `rdata_80010000.rodata.s.o`, because the src lane's
`INCLUDE_ASM` stubs never define them (1 858 truncated-reloc lines, 782
mentioning a `.L` label). Identical before and after this lane, in a different
section and object from anything touched here.

---

## 6. CONTINUATION CURSOR (exact)

All three blob regions are **CUT but not CLOSED**: 77 of 162 windows owned,
35 348 of 207 232 bytes, 273 of 813 duplicated labels resolved.

Re-measure first, always, in this order:

```bash
python tools/build.py --no-link                       # peers move build/**
python scratchpad/w64a18/scan.py                      # NEVER skip
python scratchpad/w64a18/probe_link.py
python scratchpad/w64a18/ownmap2.py --blob scratchpad/w63a19/ctl_blob/data_8010CCD4.data.s  --end 0x8013C54C \
    --out scratchpad/w64a18/ownmap2_data.txt  --json scratchpad/w64a18/ownmap2_data.json  \
    --exclude femenu.cpp --exclude fetv.cpp --exclude screenpost.cpp --exclude screenusername.cpp
python scratchpad/w64a18/ownmap2.py --blob scratchpad/w63a19/ctl_blob/sdata_8013C54C.sdata.s --end 0x8013DD7C ...
python scratchpad/w64a18/ownmap2.py --blob scratchpad/w64a18/ctl_blob/front_data.data.s      --end 0x80052B38 ...
```
(the `ctl_blob` copies are the PRE-SPLIT blobs the map must be read against;
the live blobs are now 129 pieces.)

Then re-cut + re-link + re-prove, per region:

```bash
python scratchpad/w64a18/splitblob2.py --blob <ctl> --end <VA> --json <json> --apply
python scratchpad/w64a18/relink_ld.py  --stem <STEM> --sec <sec> \
    --order scratchpad/w64a18/<STEM>_pieces_order.txt --json <json> --end <VA> --apply
rm -f build/asm/data/<STEM>_*.o && python tools/build.py --no-link
python scratchpad/w64a18/proofs.py --ctl <ctl> --end <VA> --sec .<sec> \
    --order scratchpad/w64a18/<STEM>_pieces_order.txt
```

### Ranked next targets (measured, cheapest first)

1. **The `= 0` / declaration-order lever at scale (§3.2).** It is the cure for
   the dominant E3 class and it is codegen-inert. `orderdiag.py` prices any TU
   in one run. Region 1 still has **28 E3 windows**; region 2 has 8; region 3
   has 15. ⚠️ The heaviest (`audiocmn.cpp`, 41 `.sdata` labels / 10 bases, 65
   duplicated symbols) was **NOT touched — a peer belt has it modified in the
   working tree.** Check `git status -- recon/` before editing any TU.
2. **E1 un-migrated (§4b data-materialisation)**: 8 windows region 2, 18
   region 1, 8 region 3. Each is one blob label inside an otherwise-owned
   window that no TU defines yet; the bytes are already decoded in the blob.
   Biggest single unlock: `speech.cpp` 1 880 B and `hud.cpp` 1 894 B (each
   blocked by 4–5 foreign/un-migrated labels).
3. **E1 foreign (12 / 16 / 6 windows)** — two TUs' data interleaves in the
   retail run. This is the *data* twin of the closed text-interleave class
   (W62-A19 §1.3) and needs the same "move the datum to the TU whose retail run
   it belongs to" treatment.
4. **`E5? UNDECIDABLE` (4 / 2 / 3 windows)** — all are `.rodata`-relative
   relocs whose `.rodata` base is unanchored. They unblock for free once
   W62-A19 §6.3 step 7 (anchor `.rodata` from the `%hi/%lo` reloc pairs in the
   owning object's own `.text`, 513 HI16+LO16 pairs across 123 objects) lands.
   `libcd/cddebug.c` 160 B is the model case.
5. **Do NOT** rename the 131 `*_vtable` labels (T2) without deleting the
   matching rodata-blob region in the SAME commit — W62-A18 §5: rename-alone
   converts 115 silent duplicates into 115 hard errors. Still untouched.

---

## 7. ORCHESTRATOR ACTIONS REQUESTED

1. **`-G8` wiring for `recon/game/common/nfs3.cpp`** (`PER_TU_FLAGS`
   `{"g_value": "8"}`). Evidence: retail holds **four 8-byte string literals**
   — `"%s%s"`, `"ymus"`, `"win*"`, `"lose*"` — at `0x8013D294..0x8013D2B4`
   inside nfs3's `.sdata` run; a >4-byte literal cannot reach `.sdata` at
   `-G4`. This is the same **`-G8` IDENTITY TELL** class W63-A19 found for
   `aispeeds.cpp` / `mpause.cpp` (both already wired at HEAD, and both windows
   improved — `aispeeds` is down to 4 differing bytes, `mpause` to 1).
   Expected: nfs3's 88-byte `.sdata` window flips to OWN once combined with the
   `= 0` fix already landed. ⚠️ `PER_TU_FLAGS` duplicate-key hazard (catalog
   12F): grep the key first, re-gate WIRED not probed.
2. **PROMOTE `ownmap2.py` over `ownmap.py`.** The promoted v1 has two
   *wrong-answer* defects, not just gaps: it reports pointer-bearing sections
   as data defects (A), and it can silently pick an arbitrary owner when a
   `maspsx`-globalized file-static makes two TUs claim the same window (D).
   Promote `vamap.py` with it (the reloc resolver's VA source).
   Also promote `e5diag.py` / `e4diag.py` / `orderdiag.py` — they turn each
   blocker class into an actionable per-datum list.
3. **The `maspsx` `.lcomm` guard (W62-A18 T5) is now blocking the DATA lane
   too,** not just symbol hygiene: the 5 globalized `gSwapFileName` statics are
   what made four TUs claim `0x80052064`. Correction (D) makes ownmap2 refuse
   to guess, but the windows stay unowned until the guard lands.
4. **Decide the recon-lane `.ld`** (W62-A19 §6.1 `gen_ld.py`). All three
   fragments are ready to paste and are now **named after the blob STEM**:
   `linkers/nfs4_recon.{data_8010CCD4,sdata_8013C54C,front_data}.ldfrag`.
   🔴 The old per-SECTION names were a live clobber bug — `front_data` and
   `data_8010CCD4` are both `.data` runs, so writing one overwrote the other.
   (Same fixed-name hazard W63-A19 fixed for the piece-order file; it had a
   second home.)
5. **`linkers/nfs4.ld` still does not link** (§5, P6) — 2 077 undefined
   `.L<VA>` jump-table labels from the src lane. Wire the src lane's local
   labels or retire the script; `python tools/build.py` with no flags cannot
   complete today.

---

## 8. HAZARDS ENCOUNTERED

* 🔴🔴 **A peer belt's `git add -A` swept my entire staged region-2 landing
  into its own commit `39026b4d` ("w64a20: the ALIAS + raw-divide +
  ELF-directive classes cured at the SOURCE").** Exactly the W63-A19 §9
  hazard, fired again one wave later. Content verified intact afterwards
  (`git diff HEAD` over `asm/data`, `linkers`, `scratchpad/w64a18` is EMPTY;
  52 of my files are in that commit's stat). Only the message is not mine.
  **Process rule that worked afterwards: stage and commit in ONE shell step
  (`git add -- <paths> && git commit -F msg`), never leave an index populated
  across a tool call.**
* 🔴 **Fixed-name output files have MORE THAN ONE HOME.** W63-A19 fixed the
  piece-order file; the `.ldfrag` had the same bug (per-section, two `.data`
  regions). Any generator that derives its output name from a *section* rather
  than the *blob* will clobber.
* 🔴 **`build.py` ignores unknown flags and runs a full build** (`--only` is
  not a flag; only `clean`, `--skip-asm`, `--no-link`, `--out` are parsed).
  Always pass `--no-link` explicitly.
* Piping a long `build.py` run into `head`/`tail` yields an empty log (SIGPIPE)
  and a 0 exit code — redirect to a file, never pipe. Python also buffers when
  redirected, so a log can be 0 bytes for minutes while the build is healthy;
  check `find build/recon -name '*.o' -newermt '-3 minutes' | wc -l` instead.
* Stale piece objects: `splitblob2` renames pieces (`_rNN`/`_oNN` indices
  shift), so `rm -f build/asm/data/<STEM>_*.o` **before** rebuilding, or the
  `.ld` picks up objects for pieces that no longer exist.
* `.gitattributes`/`autocrlf`: the repo stores these `.s` files LF and checks
  them out CRLF, so a freshly written LF piece is byte-identical *in the repo*
  to a checked-out CRLF one. Both assemble; P3 arbitrates.
* An `objdump` byte-compare of a data section **will** differ from the ROM
  wherever a relocation sits — classify by `objdump -r` before calling it a
  data defect. This is the whole of correction (A) and the same vacuity class
  as catalog 12H.

---

## 9. FILES

**Landed:** `asm/data/{data_8010CCD4,sdata_8013C54C,front_data}_[ro]NN.*.s`
(129 pieces; the three whole blobs are gone) · `linkers/nfs4.ld` (129 ordered
entries) · `linkers/nfs4_recon.{data_8010CCD4,sdata_8013C54C,front_data}.ldfrag`
(new names; the two section-named files removed) ·
`recon/game/common/{aicop,fastrand,genericpmx,nfs3}.cpp`.

**Tools built here (`scratchpad/w64a18/`, all committed):**
`ownmap2.py` (the five-correction ownership map) · `vamap.py` (global name→VA,
6 788 names) · `splitblob2.py` (record-splitting cut with A1–A5 assertions) ·
`relink_ld.py` (nfs4.ld + per-stem recon fragment) · `proofs.py` (P1–P5) ·
`e4diag.py` / `e5diag.py` / `orderdiag.py` (per-blocker actionable lists) ·
`scan.py`/`probe_link.py`/`tile.py`/`layout.py`/`blobparse.py`/`ownmap.py`
copied from W63-A19 so this lane is self-contained.

**Evidence:** `ownmap2_{data,sdata,front}.txt`/`.json` (+ `_D` re-checks with
corrections D/E), `ownmap_data_base.{txt,json}` (the v1 control),
`e4diag_data.txt`, `e5diag_data.txt`, `e5_{flare,aicop,fastrand}.txt`,
`order_{genericpmx,audiocmn,nfs3}.txt`, `{data_8010CCD4,sdata_8013C54C,front_data}_pieces_order.txt`,
`p6_{new,ctl}.err` + `p6_diff.txt` (empty), `nfs4_PRE_W64A18.ld`,
`nfs4_ctlblob.ld`, `build_*.log`, and `*.bak` per edited TU.

---

## 10. TWO BYTE-DECODED DEFECTS HANDED OFF (peer-owned TUs, not landed)

Both TUs were **modified in the working tree by another belt**, so editing them
would have raced. Retail bytes decoded here; each is a one-line class of fix.

### 10.1 `game/psx/flare.cpp` — `Flare_SunFlarePieces[9]`, 20 wrong bytes

`FLARE_PIECE_DEF` is `{int distance, int size, CVECTOR color, char type}` — the
`CVECTOR` is a 4-byte struct, so the flat initialiser
`{0, 19660, 2585, 1}` puts `2585` into `color.r` (truncated) and `1` into
`color.g`, leaving `type` zero. The numbers already in the source are the
**correct 32-bit colour words**; only the braces are missing. Fix = brace the
CVECTOR: `{ dist, size, {W&0xff, (W>>8)&0xff, (W>>16)&0xff, W>>24}, type }`.
All nine entries verified against the ROM:

| # | distance | size | colour (r,g,b,cd) | type |
|---|---|---|---|---|
| 0 | 0 | 19660 | 0x19,0x0a,0,0 | 1 |
| 1 | −9830 | 65536 | 0x10,0x05,0,0 | 0 |
| 2 | −16384 | 6553 | 0x0f,0x0f,0x03,0 | 0 |
| 3 | 9830 | 26214 | 0x15,0x0a,0,0 | 2 |
| 4 | 29491 | 26214 | 0x06,0x06,0x14,0 | 0 |
| 5 | 49152 | 19660 | 0x15,0x0f,0x08,0 | 4 |
| 6 | 55705 | 13107 | 0x0a,0x14,0x1f,0 | 2 |
| 7 | 65536 | 6553 | 0x0a,0x14,0x0a,0 | 0 |
| 8 | 75366 | 19660 | 0x1f,0x0f,0x10,0 | 2 |

Unblocks a **1 304-byte** region-2 window (currently its only blocker).

### 10.2 `eaclib/psx/sndpsxz/slib.c` — `sndpdsafeloop` is the wrong size AND section

Our TU emits **1 byte of `.sbss`** at `0x80136DF0`; retail has a **16-byte
INITIALIZED `.data` object** there, `00 07 00 00` followed by 12 zero bytes
(i.e. `0x00000700` in word 0). Already flagged by W62-A19 §3.2 as one of the
27 symbols we wrongly place in small-data. One-line fix in the owning TU; the
window is only 16 B but it is a genuine wrong value at runtime.
