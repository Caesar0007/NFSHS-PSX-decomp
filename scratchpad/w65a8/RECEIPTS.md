# W65-A8 RECEIPTS — THE OWNERSHIP CONTINUATION (blob-window DATA/SDATA lane)

Continues W64-A18's cursor. Every number below was measured in this run; no
briefed number is reused. Memory dir: READ-ONLY, untouched. `tools/*.py`,
`tools/maspsx` and the four user-live TUs: untouched.

Commits: `0ba59955` (regions 1+2 re-cut, the order law, P6) · `ea3d1189`
(the missing-initialiser screen + 7 real defects) · plus this file.

---

## 0. MANDATORY READS (done, in order)

1. `reference_mips_isa_asm.md` — full.
2. `reference_psx_cpp_reconstruction_methodology.md` — full, in pages (§0 seal
   bar, §1 authority hierarchy, §2 step 4b data-materialisation, §3.9b
   code-as-data islands, §3.12 #5/#6 storage shape, §4 gotchas, §5 tooling,
   §8.4/8.5 section map).
3. `reference_asm_pattern_catalog.md` — §A–§I plus the 11–16 law series in
   full; **16E** is this lane's brief, 15E/16D its context.
4. `AGENT_GUIDE.md`, `scratchpad/w65/BRIEF.md`, `scratchpad/w64a18/RECEIPTS.md`.

---

## 1. HEADLINE

| region | blob | W64-A18 close | **W65-A8 close** | pieces |
|---|---|---|---|---|
| 2 | `data_8010CCD4` | 32 win / 34 144 B | **34 win / 35 464 B** | 52 → **56** |
| 1 | `sdata_8013C54C` | 35 win / 776 B | **39 win / 860 B** | 58 → **64** |
| 3 | `front_data` | 10 win / 428 B | 10 win / 428 B | 19 (untouched) |
| **all** | | **77 / 35 348 B** | **83 / 36 752 B** | **129 → 139** |

Region-1 E3 blockers 27 → **22**. Seven **REAL DATA DEFECTS** decoded from
`rom/nfs4-f.exe` and fixed (§4) — three of them live runtime guards.

Acceptance metric, all re-measured by me:

| when | probe_link | byte-exact objects |
|---|---|---|
| my baseline (fresh build + fresh scan) | 83.07 % | 201→**202** / 441 |
| after my region 1+2 landing | **83.07 %** | **202** / 442 |
| after peer belts landed w65a1/a5/a6 | 82.93 % | 161 / 442 |

**HELD across my landing, and the later fall is provably not mine** — see §6.

---

## 2. THE INSTRUMENTS THIS LANE ADDED

### 2.1 `zeroinit.py` — the MISSING-INITIALISER screen (the real-bug lane)

ownmap's E5 leg answers *per WINDOW*: "N bytes differ". A window whose labels
are merely out of ORDER therefore buries genuine defects under alignment noise
(region 1 had 29 E5 windows and `e5diag` printed hundreds of "differing" bytes,
almost all of them drift).

`zeroinit` is *per SYMBOL* and order-independent: for every blob label a recon
TU defines it compares retail's bytes at the label's retail VA against OUR
bytes at that label's offset in OUR section, and reports only the class that
cannot be a layout artifact —

> retail bytes NON-ZERO ∧ our bytes ALL-ZERO ∧ no relocation covering them
> ⇒ the object is INITIALISED in retail and we emitted a zero-valued
> tentative definition.

That is exactly the class behind W64-A18's `aicop`/`fastrand` finds and its
§10 `flare`/`sndpdsafeloop` hand-offs — now mechanical. 773 labels swept
across the three regions, **7 hits, all fixed** (§4).

**Two anti-vacuity defects in the screen itself, both caught by its own
asserts before any conclusion was drawn, both receipted in-source:**

* `objdump -s` prints the offset at the section VMA's width — **4** hex digits
  for an unlinked object, not 8. An 8-digit regex made every read come back
  EMPTY. Because an unreadable symbol is reported `UNKNOWN` and never counted
  clean, the run printed `checked 0 / UNKNOWN 447` instead of a triumphant
  "0 defects". *A screen whose failure mode is a green light is worthless;
  build the UNKNOWN bucket first.*
* `set(ours) > {0}` is a **superset** test and is FALSE for `{0xff}` — it
  reported 16 already-correct symbols (aispeeds ×6, fastrand, nfs3 ×5, force,
  font ×3 after I had just fixed them) as defects. Fixed to `any(ours)`;
  19 → 3 hits on region 1. The 16 were re-verified against the ROM as already
  byte-correct.

### 2.2 `e3screen.py` — price the ordering lever BEFORE editing

Per (obj, section) E3 window it answers "would REORDERING alone give one
implied base?" — `P` (permutation-only, a codegen-inert win) vs `H` (needs a
heavier lever, and which one). It found the 4 cheap region-1 wins in one run
and correctly rejected the 19 that look similar.

🔴 **A soundness hole in its first form, found and fixed here:** the tiling
test compared retail's *span* to our *section size*. `r3dcar.cpp` passed that
test while retail holds a **96-byte foreign run in the middle of its label
set** — the two errors cancelled exactly. The test is now
`span == sum(retail record sizes of our labels) == our section size`, and the
run-gap test ignores splat `D_<VA>` interior labels so the screen and the
ownership gate obey the same rule (ownmap correction C).

### 2.3 `p6min.py` — P6 upgraded from stderr-equality to IMAGE-equality

See §3. `stage_own_hunks.py` — own-hunk staging for the shared `linkers/nfs4.ld`
(§7).

---

## 3. 🔴 P6 WAS TOO WEAK, AND WHAT IT NOW PROVES

W64-A18's P6 compared the two links' **stderr**. That is blind to layout, and
this wave it was also unusable: a peer belt rewrites `linkers/nfs4.ld` and the
rdata blobs while we run, and the whole-tree src link went 14 → 1969 stderr
lines inside one hour, none of it ours.

`p6min.py` links ONE region's pieces and its un-split control blob with a
private throw-away script and compares the emitted image:

| SUBALIGN | `data_8010CCD4` | `sdata_8013C54C` | `front_data` |
|---|---|---|---|
| input alignment (4) | 194 680 == 194 680 **IDENTICAL** | 6 192 == 6 192 **IDENTICAL** | 6 360 == 6 360 **IDENTICAL** |
| **16 (what `nfs4.ld` declares)** | +248 B fill, 82 989 B differ | +432 B, 3 562 B differ | +128 B, 3 354 B differ |

**The cut is exactly layout-neutral. `SUBALIGN(16)` is not.** `linkers/nfs4.ld`
declares `.nfs4 0x80010000 : AT(nfs4_ROM_START) SUBALIGN(16)`, which overrides
every input section's own 4-byte alignment and pads EVERY boundary a cut
creates — 800 bytes across my three regions, and a further **2 468 B already
being paid by A5's rdata lane**, measured in the same map. It is what actually
falsifies the "keeps producing a byte-identical image" claim printed in every
piece banner, and it agrees with W62-A18's independent finding that retail
bases are 4-aligned.

**ORCHESTRATOR: `SUBALIGN(4)` on `.nfs4` is the one-token fix.** Not landed
here — `nfs4.ld` was being rewritten by a peer belt during this run and a
SUBALIGN change touches every object in the image, so it wants its own gated
landing, not a drive-by inside a data commit.

Full P1–P5 battery re-run per region, all green:

| proof | `data_8010CCD4` | `sdata_8013C54C` |
|---|---|---|
| P1 parser round-trip byte-identical | 856 records / 194 680 B | 1 099 records / 6 192 B |
| P2 data lines identical and in order | 49 518 | 1 186 |
| P3 concatenated pieces == control object | 194 680 == 194 680 | 6 192 == 6 192 |
| P4 relocations identical | 454 | 3 |
| P5 ROM-differing bytes outside a reloc word | 1 808 → **0** | 12 → **0** |

---

## 4. THE SEVEN REAL DEFECTS (all decoded from `rom/nfs4-f.exe`)

| TU | symbol @ VA | retail bytes | was | now |
|---|---|---|---|---|
| `game/psx/font.cpp` | `font_clutx` @0x8013d854 | `ff ff ff ff` | 0 | **-1** |
| | `font_cluty` @0x8013d858 | `ff ff ff ff` | 0 | **-1** |
| | `font_tint` @0x8013d85c | `80 80 80 66` | 0 | **0x66808080** |
| `game/common/simqueue.cpp` | `gSimQueue_Ticker` @0x8013d434 | `ff ff ff ff` | 0 | **-1** |
| | `gSimQueue_BlockSelf` @0x8013d438 | `01 00 00 00` | 0 | **1** |
| | `gSimQueue_BlockOther` @0x8013d43c | `01 00 00 00` | 0 | **1** |
| `syslib/psx/libpad/PAD.c` | `_padChanStop` @0x80137ccc | `01 00 00 00` | 0 | **1** |

Three are **live runtime guards**, not just image bytes:

* `Font_DeInit`/`Font_ExitFromGame` guard on `if (font_clutx != -1)` before
  `Texture_MenuReleaseClutId(...)`. Starting at 0 makes that guard TRUE on the
  first call and releases a CLUT id that was never allocated.
* `PADMAIN`'s `if (_padChanStop == 0)` default-fill guard fired on a build
  whose retail word is 1.
* the three `gSimQueue_*` cells all held the wrong value until
  `SimQueue_StartUp`/`Reset` ran.

No per-function gate can see any of this: it is data. (Same class as W64-A18's
`aicop` nested-brace defect and the `flare`/`sndpdsafeloop` hand-offs — both of
which, incidentally, had landed in peer TUs by the time I re-ran ownmap, which
is where region 2's +1 320 B came from.)

---

## 5. 🏆 THE LAW: FIRST-DECLARATION ORDER, NOT DEFINITION ORDER

16E records "the `=0` pair: tentative defs emit AFTER every initialised object
… + declaration order IS emission order". The second half is **not** the
`.cpp`'s declaration order for a tentative definition, which is why W64-A18's
`genericpmx` recipe (reorder the `.cpp`) did not transfer to region 1's 27 E3
windows.

**LAW: a TU-owned TENTATIVE DEFINITION is emitted in the order its identifier
is FIRST DECLARED — which is the `extern` line in the `*_externs.h`, not the
definition in the `.cpp`.** (An *initialised* object is emitted at its
definition, which is why `genericpmx` responded to a `.cpp` re-sort.)

**CONTROL (this is what makes it a law and not a correlation):** reordering
`replay.cpp`'s five tentative definitions changed the emitted `.sdata` order
**not at all** — gate 16/16 PASS both ways, emission `Mode, StorePtr, GetPtr,
Size, numValidCams` before and after. Reordering the **same five `extern`
lines** in `replay_externs.h` put all five at their exact retail offsets.

Reproduced on four TUs, each flipping its window to OWN, each codegen-inert:

| TU | window | bases | gate before → after |
|---|---|---|---|
| `game/common/aiphysic.cpp` | 0x8013c594 12 B | 3 → 1 | 41/42 → 41/42 PASS |
| `game/common/object.cpp` | 0x8013d2c8 24 B | 3 → 1 | 37/37 → 37/37 PASS |
| `game/common/replay.cpp` | 0x8013d3ec 20 B | 2 → 1 | 16/16 → 16/16 PASS |
| `game/psx/textureprocess.cpp` | 0x8013db74 28 B | 5 → 1 | 16/16 → 16/16 PASS |

Every touched header carries a "do NOT re-sort" comment naming the law and the
retail VA run it encodes. Consumers of the touched headers were re-gated too
(`aih_basiccop` 9/9, `overlays` 3/5 — both identical to their own baselines).

---

## 6. GATES

| gate | result |
|---|---|
| `python tools/build.py --no-link` | 508 recon objects, **0 TU build failures** (run 6×) |
| `python tools/tu_order_audit.py` | **508 objects, 0 inversions** (5 multi-VA names excluded, as always) |
| `tugate` ×2, every edited TU | textureprocess 16/16 · aiphysic 41/42 · object 37/37 · replay 16/16 · font 15/15 · simqueue 7/8 · PAD.c 0/0 |
| `tugate` ×2, every consumer of a touched header | aih_basiccop 9/9 · overlays 3/5 · PADMAIN 10/11 |
| PASS→FAIL | **ZERO** — every count above equals its own re-measured baseline |
| P1–P5 | green per region (§3) |
| P6-MIN | PASS, all three regions (§3) |
| `probe_link` | 83.07 % / 202 of 442 at my baseline **and after my region 1+2 landing** |

**The later 82.93 % / 161 reading is NOT this lane's, and that is proven by
control, not asserted:** I reverted my three source edits, rebuilt, re-scanned
and re-linked — `763001 B / 82.93 % / 161 of 442` — then restored them and got
the same three numbers **to the byte**. Structurally, this lane cannot move
probe_link at all: its input set is `build/recon/**/*.o` and it compares
`.text` only, so no `asm/data` object is ever an input. The 202 → 161 fall
happened while peer belts committed `w65a1`, `w65a5`, `w65a6`.

---

## 7. HAZARDS ENCOUNTERED

* 🔴🔴 **I swept a peer's work into my first commit.** `git add -- asm/data`
  took A5's 62 uncommitted `rdata_80054548_*` / `rdata_80010000_*` pieces (and
  their blob deletions) along with mine. Content is intact and nothing is
  lost — only the attribution is wrong, and A5's matching `nfs4.ld` hunks are
  still un-staged in the working tree, so HEAD is briefly inconsistent for the
  src lane until they commit. **I did not rewrite history to fix it** (a peer
  is committing into the same repo this hour; an amend is far more dangerous
  than a wrong commit message). W64-A18 §8 recorded this exact hazard in the
  other direction and its lesson — "stage and commit in ONE shell step" — is
  necessary but **NOT sufficient**: the real rule is **stage explicit FILES,
  never a directory**, in a tree with concurrent belts.
  `stage_own_hunks.py` (this lane) is the working device for the shared file:
  it staged only the `nfs4.ld` hunks whose every +/- line names one of my blob
  stems and left A5's three hunks alone.
* 🔴 **`pathlib.write_text` truncated `e3screen.py` to 0 bytes** — a `🔴` in
  the docstring hit cp1251 on this box and the file was already open for
  write. Exactly the methodology's recorded hazard. Recovered from git
  (it was committed minutes earlier); all subsequent edits went through the
  Edit tool. **Never `write_text` a file you cannot re-derive, and keep the
  scratchpad committed early for exactly this reason.**
* 🔴 **`nfs4.ld` at HEAD was internally inconsistent**: it listed 56
  `data_8010CCD4` pieces while `asm/data` held only 52 — four entries pointed
  at files that did not exist. My re-cut makes the two agree, and the
  regenerated `nfs4.ld` came out **byte-identical** to HEAD's, which is what
  proves the inconsistency was on the `asm/data` side.
* 🔴 **`splitblob2.py` writes its piece-order file to a HARD-CODED
  `scratchpad/w64a18/` path** — the third instance of the fixed-name-output
  hazard W63-A19 and W64-A18 each fixed once. My copy derives it from
  `Path(__file__).parent`. Fix it before promoting the tool.
* 🔴 `tools/ownmap.py` (the promoted v2) **cannot run**: it does
  `import vamap` and `tools/vamap.py` does not exist. The promotion took the
  module but not its dependency. I used the `scratchpad/w64a18` copies.
* A peer's mid-edit of `nfs4_types.h`/`fedialog.cpp` broke one TU during one of
  my builds ("1 TU(s) FAILED"); it cleared on the next run. Re-run a build
  before believing a failure that names a file you never touched.
* `objdump -s` offset width (§2.1) and the `set > {0}` superset trap (§2.1).

---

## 8. CONTINUATION CURSOR (exact)

Re-measure first, always, in this order (peers move `build/**` constantly):

```bash
python tools/build.py --no-link
python scratchpad/w65a8/scan.py                     # NEVER skip
python scratchpad/w65a8/probe_link.py
EX="--exclude femenu.cpp --exclude fetv.cpp --exclude screenpost.cpp --exclude screenusername.cpp"
python scratchpad/w65a8/ownmap2.py --blob scratchpad/w63a19/ctl_blob/data_8010CCD4.data.s  --end 0x8013C54C --out .../ownmap_data.txt  --json .../ownmap_data.json  $EX
python scratchpad/w65a8/ownmap2.py --blob scratchpad/w63a19/ctl_blob/sdata_8013C54C.sdata.s --end 0x8013DD7C --out .../ownmap_sdata.txt --json .../ownmap_sdata.json $EX
python scratchpad/w65a8/ownmap2.py --blob scratchpad/w64a18/ctl_blob/front_data.data.s      --end 0x80052B38 --out .../ownmap_front.txt --json .../ownmap_front.json $EX
python scratchpad/w65a8/e3screen.py --blob <ctl> --end <VA> --out ...   # price before editing
python scratchpad/w65a8/zeroinit.py --blob <ctl> --end <VA> --out ...   # real-bug sweep
```
then re-cut / re-link / re-prove per region exactly as W64-A18 §6, plus
`python scratchpad/w65a8/p6min.py`.

### Ranked next targets (measured this run, cheapest first)

1. **`SUBALIGN(4)`** on `.nfs4` (§3) — one token, 800 B of my fill and 2 468 B
   of A5's, and it restores the piece banners' byte-identity claim. Needs a
   gated landing of its own; coordinate with whoever owns `nfs4.ld` that hour.
2. **The `-G8` identity tells.** `audiocmn.cpp` is the region-1 heavyweight
   (188 B `.sdata`, 41 labels, 10 bases) and it is **not** an ordering problem:
   retail holds five 8-byte objects (`bestLapTime`, `gtotallaptimes`,
   `AudioCmn_gPlayerArrested`, `currentWindVal`, `nextWindVal`) inside its
   `.sdata` run that `-G4` pushes into our `.data`, leaving 24- and 16-byte
   holes. ⚠️ W59-11G already measured that a whole-TU `-G8` **breaks
   CheckState** — this one wants the per-fn `-G8` region splice, not a TU flag.
   `nfs3.cpp` (W64-A18 §7 item 1, four 8-byte string literals) is the clean
   whole-TU case and is still unwired.
3. **E3 with the ordering law, remaining region-1 rows**: 22 windows. The
   screen says none is permutation-only, so each needs its named heavier
   lever first (`track` 10 bases / `drawc` 7 / `draw` 6 / `weather` 5 /
   `primate` 5) — read `scratchpad/w65a8/e3screen_sdata.txt`, not the count.
4. **`front_data` (region 3) is untouched by this lane and is the last
   uncut-improvement region**: 10 windows / 428 B of 6 360, blocked by
   **E0 ×5** (ambiguous anchors — the `maspsx` `.lcomm` guard's remaining
   customers), E1-un-migrated ×8 (`gShowroomLights`, `speechfileHeader`,
   `fHelpText`, `nomessage`, `MEMCARD_INITIALIZED`, `CREDFADETICKS`,
   `PinkSlipsScreenState`, `screenMemcard`) and E1-foreign ×6
   (`textDefinitions`, `gSemiTransText`, `CURRENTLYUSINGMEMCARD`,
   `textSysMemCardFail_Index`, `screenDisplay`, `screenAudio`). Its one
   permutation-only row is `screenusername.cpp` — **user-live, excluded**.
5. **`font.cpp`'s tail**: our `.sdata` is 28 B but our labels reach only 24 —
   `gCurrentBlitter` sits in `.sdata` where retail has it at 0x8013ddec in
   `.sbss`. Same family as W62-A19 §3.2's "27 symbols we wrongly place in
   small-data" (`sndpdsafeloop` was one, now fixed). The window also overlaps
   `flare.cpp`'s `gfrgb`.
6. `zeroinit`'s two `UNKNOWN` rows per region are **not clean** and want a
   look: `aih_play.cpp gBlockadeTypes`, `copspeak.cpp CopSpeak_gStaticPatch`,
   `isqrt.c isqrttbl`, `nfs3.cpp befuddleTemp`, `PAD.c padIntFunc`, and 14
   front-region rows.

## 9. ORCHESTRATOR ACTIONS REQUESTED

1. **`tools/vamap.py` is missing** — `tools/ownmap.py` (promoted v2) is
   unrunnable without it (§7). Promote `scratchpad/w64a18/vamap.py` beside it.
2. **`SUBALIGN(4)`** (§3) — evidence is in `p6min.py`'s two runs.
3. **Promote `zeroinit.py` and `e3screen.py`** (§2) — one finds real data bugs
   mechanically, the other prices the ordering lever before anyone edits a
   header. Fix `splitblob2.py`'s hard-coded output path when promoting it.
4. **Catalog rows** (I do not write the memory dir):
   * 16E refinement — **first-declaration order, not definition order**, is the
     emission dial for a TU-owned tentative definition; the `*_externs.h`
     `extern` line is the dial; control-proven (§5).
   * **P6 must compare IMAGES, not stderr** — and `SUBALIGN` is the thing that
     decides whether a blob cut is layout-neutral (§3).
   * **The missing-initialiser class is mechanically detectable** per symbol,
     and E5-per-window cannot see it (§2.1).
   * Two fresh vacuity traps: `objdump -s` offset width, and `set(x) > {0}`
     as an "is non-zero" test (§2.1).
   * Process: **stage explicit FILES, never a directory** (§7).
5. **A5 (jump-table lane): 62 of your `rdata_*` files are in my commit
   `0ba59955`** (§7). Content intact; your `nfs4.ld` hunks are still yours in
   the working tree.
