# W66-A5 RECEIPTS — THE WINDOW ENDGAME (front_data + region-1 E3 + zeroinit tree-wide)

Continues W65-A8's cursor. Every number below was measured in this run; no
briefed number is reused. Memory dir: READ-ONLY, untouched. `tools/*.py`,
`tools/maspsx` and the user-live TUs (`femenudefs.cpp`, `fedialog_externs.h`,
`femenuextended_externs.h`, `screenusername_externs.h`, `nfs4_types.h`):
untouched.

Commits: `44422c21` (the SYM obj-attribution oracle + 5 windows + 1 real data
defect) · `8132dfcc` (fememcard + fetools whole-run migration + the pad bound).

---

## 0. MANDATORY READS (done, in order)

1. `reference_mips_isa_asm.md` — full.
2. `reference_psx_cpp_reconstruction_methodology.md` — in pages (§0 seal bar,
   §1 authority hierarchy + PROCESS ORDER, §2 step 4b data-materialisation,
   §3.1/3.2/3.2c oracle-vs-Ghidra, §3.6b fixed-address storage shape, §3.9b
   code-as-data, §3.12 levers incl. #5 unsized-array/storage shape).
3. `reference_asm_pattern_catalog.md` — the law tail in full: 15A–15F, 16A–16F,
   **17A–17C** (17B EXTERN-ORDER + SUBALIGN + SYM-STATIC-is-the-ownership-oracle
   is this lane's brief; 17A's zeroinit row is item 3).
4. `AGENT_GUIDE.md`, `scratchpad/w66/BRIEF.md`, `scratchpad/w65/BRIEF.md`,
   `scratchpad/w65a8/RECEIPTS.md`.

---

## 1. HEADLINE

| region | blob | W65-A8 close | **W66-A5 close** | Δ |
|---|---|---|---|---|
| 3 | `front_data` | 10 win / **428 B** | **17 win / 1 056 B** | +7 / **+628 B (+147 %)** |
| 1 | `sdata_8013C54C` | 39 win / 860 B | **41 win / 900 B** | +2 / +40 B |
| 2 | `data_8010CCD4` | 34 win / 35 464 B | **36 win / 35 620 B** | +2 / +156 B |
| **all** | | **83 / 36 752 B** | **94 / 37 576 B** | **+11 / +824 B** |

* front_data E0 ambiguous anchors **5 → 0**; its E3 rows **15 → 4**.
* **1 more REAL DATA DEFECT** decoded from `rom/nfs4-f.exe` and fixed (§4).
* Region-1's E3 verdict **CORRECTED**: they are not ordering rows (§5).

Acceptance metrics, all re-measured by me:

| gate | baseline (my fresh build+scan) | close |
|---|---|---|
| `build.py --no-link` | 508 objects, 0 TU failures | same (run 7×) |
| `tu_order_audit` | 508 objects, **0 inversions** | same |
| `probe_link` | 82.93 % / 161 of 442 | **82.98 % / 161 of 443** |
| `stale_absolutes` | — | 0 rows shadow a real definition |
| `calltarget_audit` | — | 0 proven wrong-call-target sites |
| PASS→FAIL | — | **ZERO** (every TU re-gated ×2) |

---

## 2. 🏆 THE INSTRUMENT: the SYM is an obj-attribution oracle FOR DATA

`scratchpad/w66a5/symown.py` + `objruns.py`.

The trusted SYM emits one symbol block per linked object and **terminates each
block with a `94 Def class FILE type NULL size 0 name <foo>.obj` record**. Every
`Def`/`Def2 class EXT|STAT` record between two FILE records belongs to **that**
object. So the SYM answers, for any data VA, *which .obj owns it* — and, in SYM
order, *in what order that obj emitted its objects*, which is precisely what the
17B extern-order law has to reproduce.

**Why it matters (the case that forced it).** `gShowroomLights` @0x800514b4 sits
immediately before FEApp.obj's run and ownmap blamed feapp.cpp for it as
"E1 un-migrated". Geometry cannot decide that. The SYM can: it is the **last EXT
of fe3dmenu.obj**, and FEApp.obj's run starts one record later at 0x800514b8.
Migrating it into feapp.cpp would have been a silent, gate-invisible error.

Two corollaries, both used this run:

* **A file-static's SYM value is its OBJ-RELATIVE OFFSET, not a VA.**
  `currentVideo` = `$00000004` in FEApp.obj ⇒ obj `.data` base 0x800514b8 + 4 =
  0x800514bc = the splat label `D_800514BC`. Proven independently: the oracle
  `RunDemoVideo` body does `lui $s1,%hi(D_800514BC) … lw/sw %lo(D_800514BC)`.
  Same device named ScreenController.obj's three unnamed cells
  (`flare_intensity` `$7ec`, `max_fi` `$7f0` = 0xea6, `max_fidir` `$7f4` = 0xfa,
  against obj base 0x800520d8).
* **An obj's data run is contiguous** — so any interior "gap" is that obj's own
  un-emitted content, never another obj's. That single reading flipped the
  region-1 diagnosis (§5).

`objruns.py --lo --hi` prints a whole VA window grouped by owning obj; that is
now the first thing to run on any window, before ownmap's geometry.

---

## 3. THE OWNERSHIP LANDINGS (all extern-order / `= 0`, all re-gated ×2)

| TU | window | before → after | gate before → after |
|---|---|---|---|
| `screentrophyinfo.cpp` | 0x80052078 36 B | 3 bases → 1, **OWN** | 3/3 → 3/3 |
| `feapp.cpp` | 0x800514b8 12 B | 2 bases → 1, **OWN** | 14/15 → 14/15 |
| `feaudio.cpp` | 0x800514c8 116 B | 4 bases → **1** | 9/10 → 9/10 |
| `fecars.cpp` | 0x80051540 104 B | 2 bases → 1, **OWN** | 46/46 → 46/46 |
| `front.cpp` | 0x800517e8 387 B | 6 bases → 1, **OWN** | 42/43 → 42/43 |
| `fememcard.cpp` | 0x80051a68 56 B | 2 bases + 3 un-migrated → 1, **OWN** | 18/18 → 18/18 |
| `fetools.cpp` | 0x800517d0 18 B | 1 of 5 labels → all 5, **OWN** | 6/6 → 6/6 |
| `device.cpp` | 0x8013d778 29 B | 3 bases → 1, **OWN** | 10/10 → 10/10 |

Header consumers re-gated ×2, all identical to their own baselines:
`fememcard` 18/18, `psxfront` 23/25, `femenudefs` 65/66, `feinput` 4/4.

Every touched header carries a **"DO NOT RE-SORT"** block naming 17B and the
retail run it encodes.

### 3.1 The `= 0` discriminator, stated sharply

16E says a tentative definition emits **after** every initialised object. So:

> **An all-zero cell that sits BETWEEN two initialised objects in retail cannot
> have been a tentative definition. Retail's source initialised it explicitly.**
> gcc-2.8 has no zero-initialized-in-bss pass, so `= 0` keeps it in `.data` at
> its definition position — and initialised objects emit in **.cpp definition
> order**, while tentative ones emit in **first-declaration order** (17B).

That one test decided every landing above: `gStopCommentaryNow` (feaudio),
`overRide` + `ComingIntoTheFrontEndTheVeryFirstTime` (front), and the four
FEMemCard.obj cells. It is mechanical and needs no experiment.

### 3.2 Two source bugs found on the way

* `front.cpp` `_usePlayerUpgrades` — **0 references anywhere in `recon/`, and no
  SYM record in ANY obj block**. An invention that was silently occupying
  `gAllScreens`' 4 retail bytes. Removed. `gAllScreens[0]` (a zero-size array
  that emitted **nothing**) → `[1]`, matching the SYM (`PTR STRUCT`, 4 B).
* `fememcard.cpp`'s note *"TITLE/nomessage/MEMCARD_INITIALIZED are already
  defined elsewhere (nm-confirmed)"* was **STALE** — an nm sweep over all 508
  recon objects shows nothing defines `CURRENTPLAYER` / `nomessage` /
  `MEMCARD_INITIALIZED`. **A "confirmed" note ages with the tree; re-run the
  confirmation before trusting it.**

---

## 4. THE REAL DATA DEFECT (8th of the zeroinit class)

| TU | symbol @ VA | retail bytes | was | now |
|---|---|---|---|---|
| `frontend/psx/drawshp.cpp` | `kNoColor` @0x800529d0 | `80 80 80 00` | 0 | **0x00808080** |

`kNoColor` is the neutral "no tint" RGB the shape blitter compares and assigns
against; starting at 0 is black, not neutral. Same family as W65-A8's
`font_tint`.

**It was hidden by the screen's own UNKNOWN bucket.** A blob RECORD runs to the
next LABEL and therefore includes the object's trailing alignment pad, so our
section legitimately stops sooner — `zeroinit` called that `short read`, filed
the symbol as UNKNOWN, and never compared the 4 bytes it *could* read.
Fixed to compare the readable **overlap**; only a symbol with no overlap at all
is now UNKNOWN. That single change turned W65-A8's 22 UNKNOWN rows into
**21 clean + this defect** — closing its cursor item 6 mechanically.

*This is the third instance of the same meta-lesson in this lane (A8 recorded
the other two): **a screen whose failure mode is a quiet bucket is worth less
than its bucket is big.** Build the bucket first, then make it shrink.*

### zeroinit is now TREE-WIDE

| blob region | TU-defined labels checked | missing-initialiser hits |
|---|---|---|
| `front_data` | 62 | **1** (kNoColor) |
| `sdata_8013C54C` | 445 | 0 |
| `data_8010CCD4` | 264 | 0 |
| `rdata_80010000` | 0 (no recon TU defines any of its labels) | 0 |
| `rdata_80054548` | 0 | 0 |
| `front_bss` / `tail` | 0 (all splat `D_` labels) | 0 |

The three `0`-label regions were verified non-vacuous: `blobparse` parses them
(44 and 83 records) — there genuinely is nothing there that a recon TU defines.

---

## 5. 🔴 REGION-1's 22 E3 ROWS: THE VERDICT WAS WRONG, AND HERE IS THE RIGHT ONE

The brief expected "mostly the extern-order law". **It is not.** Measured, per
row, with `orderdiag.py` + the new `gaptell.py`:

* 9 of 14 sampled rows do have an order difference — but **reordering alone
  closes NONE of them**, because retail's run is punctuated by objects we never
  put in that section at all. After a perfect re-sort `drawc` would still hold
  2 bases, `platform` 2, `cario` 3, `mpause` 2.
* Decoding those gaps from the ROM says exactly what they are:

> **≤ 8-byte STRING LITERALS that a `-G8` build keeps in `.sdata`.**
> Our `-G4` build puts them in `.rodata`, leaving precisely that hole.

`gaptell.py` classifies every gap record automatically (string / all-zero /
other). Receipts in `scratchpad/w66a5/gaptell_sdata.txt`. The tell is present in
**12 TUs**:

| TU | literal gaps | bytes | sample |
|---|---|---|---|
| `r3dcar.cpp` | 14 | 98 | `"sub_ot0"` `"bigfile"` `".viv"` `"zz%s"` |
| `hud.cpp` | 12 | 116 | `"SLC %d"` `"0M00S00"` `"%02d"` |
| `copspeak.cpp` | 13 | 68 | `"lden"` `"ldex"` `"%s%d"` |
| `audiocmn.cpp` | 11 | 56 | `"SFXHDR"` `"fesfx"` `"eng"` |
| `bworld.cpp` | 5 | 52 | `"bworld"` `"S.grp"` |
| `nfs3.cpp` | 4 | 32 | `"%s%s"` `"ymus"` `"win*"` `"lose*"` |
| `cario.cpp` | 4 | 32 | `"plate1"` `"blnk"` |
| `sim.cpp` | 3 | 24 | `"Sc32-1"` `"Sc32-2"` `"Sc64"` |
| `night.cpp` | 1+ | 44 | `"plnight"` |
| `platform.cpp` | 1 | 16 | `"cdrom:"` |
| `loading.cpp` | 1 | 8 | `"back"` |
| `fileroot.c` | 1 | 8 | `"sim:"` |

This upgrades W65-A8's cursor item 2 from one TU's observation to a **12-TU
mechanical census with per-literal evidence**, and it re-ranks the whole region:
region 1 is a **build.py `-G` wiring** problem, not a source-shape one. The one
row that genuinely *was* an ordering row (`device.cpp` — no gaps at all) is
landed and OWN.

⚠️ Do not read this as "wire `-G8` everywhere": W59-11G measured that a whole-TU
`-G8` **breaks CheckState** in `audiocmn`. The clean whole-TU candidates are the
small ones with no counter-evidence — `loading` (1 literal), `platform` (1),
`fileroot` (1), `sim` (3), `nfs3` (4, already A8's nomination).

---

## 6. THE `< 4` PAD BOUND WAS A GUESS (ownmap2 B2)

W65-A8's B2 leg accepted an alignment-pad tail only if it was **< 4 bytes**.
Retail's obj `.data` bases in this image run to 16-alignment (0x80051540,
0x800517c0, 0x800517d0, 0x80051970), so the pad after a `char`/`short`-tailed
object is routinely 5..15 B. It is the same `.ld` `FILL(0)` either way, and the
**all-bytes-zero test is what proves the class — the length never did**.
Bound relaxed to `< 16`; the zero test, the `nb % 4 == 0` test and the
`nb <= host.end` test are unchanged.

That unblocked two windows that were already base-exact *and* content-exact:
`front.cpp` 387 B (5 B pad, verified `00 00 00 00 00`) and `fetools.cpp` 18 B
(6 B pad, verified `00 00 00 00 00 00`) — **+405 B, more than half this lane's
front_data gain**.

`ownmap2` correction **D2** (the E0 killer): a **LOCAL** definition of a name is
a different object that merely shares a spelling. With the W63 maspsx `.lcomm`
guard landed, the five file-static `gSwapFileName` copies are `l .bss`
(objdump-verified this run), so they can no longer poison screentrophyroom's
one real global. Guard (D)'s premise ("maspsx re-emits every .bss entry with an
unconditional `.globl`") is now historical. E0 5 → 0, and the five phantom
zero-size windows it was inventing are gone.

---

## 7. NAMED BLOCKERS (no floors — each is a named angle with a next step)

1. **`feaudio` 116 B — E5? UNDECIDABLE, reloc into `.rodata`.** Content and
   order are exact (one base). `allLanguages[6]` holds 6 pointers to string
   literals retail keeps at 0x8001013c..0x80010164 (8-byte stride) inside the
   `rdata_80010000` blob. Ownership cannot be *proved* until our TU's `.rodata`
   is VA-placed. **That is A5's rdata lane, not a source problem.**
2. **`screencontroller` 2 040 B** (the region's biggest single prize). SYM says
   ScreenController.obj's `.data` base is **0x800520d8** (not our 0x80052104)
   and that the three unnamed cells at 0x800528c4/c8/cc are its file-statics
   `flare_intensity` = 0, `max_fi` = **0xea6**, `max_fidir` = **0xfa** — two
   NON-ZERO values we do not currently emit anywhere. Migrate them as
   function-local statics in the right order, then re-check the 44 B before
   0x80052104.
3. **`screencarselect` 392 B** — un-migrated `PinkSlipsScreenState`, E5 188/392.
4. **`fetracks` 24 B** — blocked by two dead, unreferenced 44-byte
   `tTrackInformation` tables (`gTrackInfo_FETrackList` @0x80010fd0,
   `gTrackInfo_Tourney` @0x8001159c) that our TU emits into `.data` while retail
   holds them in `.rodata` (splat calls the first `D_80010FD0`, "fetrk.trk").
   `const` (→ `.rodata`) is the faithful shape; they have **0 references** in
   `recon/`, so deleting them is also safe (the blob keeps the bytes).
5. **`screencongrats` / `screenpinkslips` / `screendisplay` / `screenaudio`** —
   small runs whose SYM blocks I printed (§ objruns 0x800520f0..0x80052960) but
   did not land; ScreenMemcard.obj owns the 18 `*MEMCARD*` cells that ownmap
   currently blames on `screencongrats`.
6. **`femenudefs.cpp` 236 B, `screenusername.cpp` 32 B** — both **user-live**,
   excluded by standing rule. `screenusername` is front_data's ONLY
   permutation-only (`P`) row per `e3screen`; it is a one-line reorder for
   whoever owns that file.
7. **`front.cpp`'s cut needs byte-granular residual emission.** Its window ends
   at 0x8005196b (not 4-aligned, `picked` is `char[11]`). `splitblob2` emits
   `.word` lines only, so the 5-byte residual cannot be cut out yet — either
   teach it `.byte`, or let the piece's `FILL(0)` cover it.

---

## 8. HAZARDS ENCOUNTERED

* 🔴 **`ownmap2.py` imports `ownmap` and `vamap` as siblings** — `tools/vamap.py`
  is now promoted (A8's request #1 landed) but `ownmap.py` still is not
  importable as a scratchpad sibling; I copied `w65a8/ownmap.py` next to it.
  Any promotion of `ownmap2` must carry both dependencies.
* 🔴 **Mixed CRLF inside one file.** `fememcard.cpp` has `\n` before a comment
  and `\r\n` inside it; a plain-text `str.replace` asserted out. All scripted
  edits went through byte-mode with explicit `\r\n` joins (the methodology's
  recorded hazard, fired again).
* 🔴 **A `§` in a source comment is UTF-8 `\xc2\xa7` on this box** — pattern
  matching source text must be done in bytes, not decoded str.
* **`relink.py` is RED with 5 REAL DUPs** — `VoxSentence_GetNumPhrases`,
  `iSPCH_GetOffset8/16` (spchrule ↔ spchdata), `___15AIHigh_BTC_Perp`
  (aihigh ↔ aih_btcperp), `_bzero_w` (INTR ↔ INTR_DMA). **All five are
  `build/src/**` scaffolding objects and all five are exactly the names
  `tu_order_audit` excludes as multi-VA; none of them is in any file I touched,
  and no data/order edit can create a duplicate symbol definition.** Reported,
  not fixed — it is the src lane's.
* A peer committed `w66a1` mid-run; HEAD moved under me. Staged **explicit
  files** in both commits (never a directory), per 17C.

---

## 9. CONTINUATION CURSOR (exact)

Re-measure first, always, in this order (peers move `build/**` constantly):

```bash
python tools/build.py --no-link
python scratchpad/w66a5/scan.py                     # NEVER skip
python scratchpad/w66a5/probe_link.py
EX="--exclude femenu.cpp --exclude fetv.cpp --exclude screenpost.cpp --exclude screenusername.cpp"
python scratchpad/w66a5/ownmap2.py --blob scratchpad/w64a18/ctl_blob/front_data.data.s      --end 0x80052B38 --out .../ownmap_front.txt --json .../ownmap_front.json $EX
python scratchpad/w66a5/ownmap2.py --blob scratchpad/w63a19/ctl_blob/sdata_8013C54C.sdata.s --end 0x8013DD7C --out .../ownmap_sdata.txt --json .../ownmap_sdata.json $EX
python scratchpad/w66a5/ownmap2.py --blob scratchpad/w63a19/ctl_blob/data_8010CCD4.data.s   --end 0x8013C54C --out .../ownmap_data.txt  --json .../ownmap_data.json  $EX
```

**Then, for ANY window, run the oracle BEFORE the geometry:**

```bash
python scratchpad/w66a5/objruns.py --lo 0xVA --hi 0xVA     # who owns what, in retail order
python scratchpad/w66a5/symown.py  --obj Foo.obj           # one obj's whole block
python scratchpad/w66a5/side.py    --blob <ctl> --end 0xVA --obj <name.cpp.o> --sec .data
python scratchpad/w66a5/gaptell.py --blob <ctl> --end 0xVA --only <obj.o> ...   # what the gaps ARE
python scratchpad/w66a5/zeroinit.py --blob <ctl> --end 0xVA --out ...           # real-bug sweep
```

### Ranked next targets (measured this run, best first)

1. **`screencontroller`, 2 040 B** — the single biggest data window left in the
   image, and §7.2 already names its three statics *and their retail values*.
2. **The `-G8` wiring wave** (§5) — 12 TUs with per-literal evidence; start with
   the 1–3-literal TUs (`loading`, `platform`, `fileroot`, `sim`), keep
   `audiocmn` on the per-fn splice per W59-11G.
3. **`screencarselect` 392 B** and the ScreenMemcard/ScreenCongrats cluster
   (§7.3, §7.5) — all now decidable with `objruns`.
4. **`fetracks`** (§7.4) — 24 B, and it deletes two dead 44-byte tables.
5. **A `symown`-driven audit of EVERY recon TU's data set**: for each obj block,
   diff {SYM says this obj owns} against {our TU defines}. That finds both
   directions of misattribution (a symbol we own that is not ours, a symbol
   ours that we never defined) *mechanically*, over the whole tree, not window
   by window. `gShowroomLights` and `_usePlayerUpgrades` were each found by
   hand this run; this pass would have found both, and everything like them.

## 10. ORCHESTRATOR ACTIONS REQUESTED

1. **Promote `symown.py` + `objruns.py`** — the SYM's `Def class FILE` records
   are an authoritative VA → owning-obj map for DATA. This is the missing
   authority behind every "is this label ours?" question; it retires guessing
   from geometry. (Promote `gaptell.py` and `side.py` with them; and note
   `ownmap2` needs BOTH `ownmap.py` and `vamap.py` beside it.)
2. **`-G8` per-TU wiring** (§5) — evidence table above, 12 TUs, per-literal.
3. **Catalog rows** (I do not write the memory dir):
   * **17B addendum — the SYM FILE-record obj-attribution oracle**, plus
     *a file-static's SYM value is its OBJ-RELATIVE OFFSET* (`currentVideo`
     `$4` = `D_800514BC`, proven against the oracle's `%hi/%lo`), plus
     *an obj's data run is contiguous, so an interior gap is that obj's own
     un-emitted content*.
   * **The `= 0` discriminator, stated as a test** (§3.1): an all-zero cell
     between two initialised objects cannot have been tentative.
   * **The `-G8` STRING-LITERAL TELL is mechanically detectable** (§5) and is
     region-1's real blocker — the E3/ordering reading was wrong.
   * **Vacuity trap #3 in the same screen family**: an UNKNOWN bucket that
     discards a symbol on a length mismatch hides real defects (`kNoColor`).
     Compare the readable overlap.
   * **A "nm-confirmed" in-source note ages** (§3.2) — re-run it before use.
4. **`relink` RED, 5 REAL DUPs in `build/src/**`** (§8) — not this lane's; owner
   should re-check the spchrule/spchdata, aihigh/aih_btcperp and INTR/INTR_DMA
   splits.
