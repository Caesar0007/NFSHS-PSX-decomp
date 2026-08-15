# W63-A19 RECEIPTS — FIRST-REAL-LINK CAMPAIGN, T1
## (blob-vs-TU data ownership sweep, region 1 = `sdata_8013C54C`)

Base at start: HEAD `10e1a01b`. Everything below was measured in this run;
no briefed number was reused. Memory dir: READ-ONLY, untouched.
`tools/*.py`, `tools/maspsx`, and the four user-live TUs: untouched.

---

## 0. MANDATORY READS (done, in order)

1. `reference_mips_isa_asm.md` — full.
2. `reference_psx_cpp_reconstruction_methodology.md` — full (1018 lines, read in
   pages; §0 seal bar, §1 authority hierarchy, §2 step 4b data-materialisation,
   §3.7/§3.9b/§3.12#5/#6 storage shape, §8.4/8.5 section map are the ones this
   lane is built on).
3. `reference_asm_pattern_catalog.md` — full (1414 lines; §E gp-REL/DATA/RELOC,
   14B link readiness, 12B link-model verdict are the load-bearing rows).
4. `AGENT_GUIDE.md`, `scratchpad/w63/BRIEF.md`,
   `scratchpad/w62a19/{LAYOUT_AUDIT,RECEIPTS}.md`,
   `scratchpad/w62a18/SYMBOL_LEDGER.md` — full.

---

## 1. ACCEPTANCE BASELINE (mission item 1) — re-established on current HEAD

Fresh `python tools/build.py --no-link` (508 recon objects, **0 TU build
failures**), then `scan.py` → `probe_link.py`:

| when | bytes identical | byte-exact objects | placed/dropped |
|---|---|---|---|
| W62-A19 (briefed) | 80.15 % | 203 / 438 | 438 / 23 |
| **W63 open (this run, 13:52)** | **80.76 %** | **202 / 439** | 439 / 22 |
| W63 close (this run, fresh scan) | **80.93 %** | 202 / 437 | 437 / 24 |

🔴 **probe_link is NOT attributable to this lane and moved under my feet.**
`git status` at wave open listed 4 modified `recon/**` files; by mid-run it
listed **9** (`psxfront.cpp`, `aih_opp.cpp`, `r3dcar.cpp`, `INTR.c`, … added by
a peer belt) and `find build/recon -newer objdata.json` showed peers rebuilding
objects during my run. Measured drift on an unchanged tree state: 80.76 →
79.87 → 80.10 → 80.93 as `objdata.json` and `build/recon/**` desynchronised and
resynchronised. **Rule for the next agent: re-run `scan.py` immediately before
`probe_link.py`, always — a stale `objdata.json` mis-attributes several tenths
of a percent, and `dropped` moves with it.**

**Orthogonality proof (why this lane cannot move probe_link at all):**
`probe_link.py`'s ld input set is exactly the recon objects listed in
`objdata.json` plus `linkers/undefined_{syms,funcs}_auto.txt`. **No
`asm/data/**` object is an input, and only `.text` is compared.** This lane
touched only `asm/data/**` and `linkers/**`. It HELD (in fact ended above the
opening number); it could not have dropped.

---

## 2. THE OWNERSHIP MODEL (built here, `ownmap.py`)

W62-A18 §1.1 says the sweep must be per blob region in VA order because ld
places WHOLE object sections. Turned into a decidable per-window test:

```
implied_base = retail_VA(label) - our_section_offset(label)
window       = [base, base + our_section_size)
```
A `(recon object, section)` OWNS its window iff **all five** hold:

| id | condition | why it is a hard blocker |
|---|---|---|
| E1 | every blob label inside the window is defined by THIS TU (or is a splat `D_<VA>` interior alias) | otherwise the cut deletes another TU's datum, or an un-migrated one |
| E2 | every blob label this TU defines lies INSIDE the window | otherwise one section would have to be placed at two VAs |
| E3 | all its labels agree on ONE implied base | a second base = intra-TU data ORDER/SIZE drift |
| E4 | `base` and `end` are both blob-label boundaries **and 4-aligned** | a mis-aligned or mid-label cut lets ld insert padding and silently shift the whole region |
| E5 | the window's **retail bytes == our section's bytes** (zeros for `.bss`/`.sbss`) | 🔑 **the anti-vacuity gate**: without it "ownership" is a name-level claim and a wrong-valued TU silently corrupts the run |

`D_<VA>` labels strictly interior to a window are splat SYNTHETIC names for an
offset inside the TU's own object (methodology §3.12) — absorbed, not foreign.

### Result for region 1 (`0x8013C54C..0x8013DD7C`, 6192 B, 1099 labels)

```
blob labels also defined by a recon TU : 458      (W62-A18 briefed 449)
windows examined                       :  74
OWNABLE windows                        :  30      (0 overlapping, 0 pruned)
bytes owned                            : 408 of 6192
blob labels inside owned windows        : 102  (96 TU-defined + 6 splat D_ interior)
TU-defined labels NOT ownable           : 362
```

**Failure-mode histogram (non-exclusive, 44 blocked windows):**

| blocker | windows |
|---|---|
| E5 bytes differ | **33** |
| E3 intra-TU data ORDER/SIZE drift | 28 |
| E1 un-migrated blob label inside | 19 |
| E1 foreign owner inside | 17 |
| E2 own label outside window | 17 |
| E4 edge not a label boundary | 14 |

🔴 **The dominant blocker is NOT ordering — it is E5, DATA BYTES.** One third of
the windows carry data that is not retail's. W62-A18 ranked this class as a
pure link/ownership programme; measured, it is **half a data-materialisation
programme** (methodology §2 step 4b). That is the single biggest correction to
the briefing.

Full per-window verdict + evidence: `ownmap_sdata.txt` (t0) and
`ownmap_sdata_t1.txt` (re-run against the peer-rebuilt snapshot).
**Stability control:** t0 vs t1 window set and label set **IDENTICAL** — the
30 ownable windows survive concurrent peer landings.

---

## 3. WHAT LANDED — the region-1 cut

`splitblob.py --apply` sliced `asm/data/sdata_8013C54C.sdata.s` at the 30
ownership boundaries into **53 segment files**:

* `sdata_8013C54C_r00..r22.sdata.s` — 23 **residual** segments (labels no recon
  TU defines) — linked by BOTH lanes.
* `sdata_8013C54C_o00..o29.sdata.s` — 30 **owned** windows — **splat-lane
  filler only**; each carries a banner naming the owning object/section/VA
  range and stating that the recon-lane script must link that object's own
  section here instead.

`linkers/nfs4.ld` now lists all 53 pieces in VA order in place of the single
blob. `linkers/nfs4_recon.sdata.ldfrag` (new) is the **recon-lane** ordering:
the 23 residual pieces plus the 30 recon objects' own sections, each annotated
with its retail VA range and the `_oNN` it replaces.

### Why the split is scoped this way (the decisive constraint, measured)

The obvious reading of "remove the duplicate bytes from the splat blob" is to
delete them outright. **That is not possible without breaking the tree**, and
the reason is checkable in one grep: the oracle `.s` the splat lane assembles
reference these symbols directly —
`asm/nonmatchings/main/AICop_{StartUp,Restart,CleanUp}__Fv.s` all carry
`%gp_rel(AICop_rawTriggers)`. The splat lane has no recon object to supply the
definition, so deleting it makes `linkers/nfs4.ld` unresolvable. Mixing lanes
is worse: adding recon objects to `nfs4.ld` collides with `build/src/**` on
every function symbol.
⇒ **A blob-vs-TU ownership decision is per-LINK-SET, not per-tree.** The cut
records the decision physically and scopes it: no link set now contains both
definitions, and the `_oNN` files are the exact, machine-readable TODO list —
each one is deleted the moment its window's E1–E5 blockers clear.

### Proofs (all run, all in this receipts dir)

| # | claim | evidence |
|---|---|---|
| P1 | the parser is lossless | `blobparse.py` re-emits the blob **BYTE-IDENTICAL** before any edit is allowed |
| P2 | the segmentation loses nothing | `splitblob.py` asserts the concatenated segment lines == the original body, and every cut is 4-aligned and on a label boundary |
| P3 | the assembled pieces reconstruct the blob object exactly | concatenated `.sdata` of the 53 piece objects vs the pre-split blob object: **6192 == 6192, IDENTICAL: True** |
| P4 | relocations survive the cut | 3 `R_MIPS_32` relocs (`D_8013DD18`, `D_8013DD2C`, `D_8013DD38`), same absolute offsets, same targets: **IDENTICAL: True** |
| P5 | the piece bytes are retail's | piece-by-piece vs `rom/nfs4-f.exe`: only the 12 bytes covered by P4's 3 relocs differ (unrelocated in the object) — every other byte matches |
| P6 | **the splat lane is unchanged** | ld with HEAD's `nfs4.ld` + the original blob vs ld with the new `nfs4.ld` + the 53 pieces: **rc 1 both, 2077 stderr lines both, byte-identical diagnostics** |

🔴 **P6 also re-confirms W62-A19 §0 with a fresh receipt: `linkers/nfs4.ld` does
not link at HEAD** and never did in this state — it dies on ~2077 undefined
`.L<VA>` jump-table labels out of `rdata_80010000.rodata.s.o`, because the src
lane's `INCLUDE_ASM` stubs never define them. The failure is identical before
and after this lane, and is in a *different section and object* from anything
touched here.

---

## 4. GATES

| gate | result |
|---|---|
| `python tools/tu_order_audit.py` | **508 objects, 0 inversions** (5 multi-VA names excluded, as always) |
| `probe_link.py` | **HELD** — 80.76 % open → 80.93 % close, 202 byte-exact both ends; structurally orthogonal (§1) |
| spot `tugate` — `game/common/ai.cpp` | **40/40 PASS** |
| spot `tugate` — `game/psx/texture.cpp` | **24/24 PASS** |
| spot `tugate` — `eaclib/psx/eacpsxz/threads.c` | **2/2 PASS** |
| tree build | `build.py --no-link`: 508 recon objects, **0 failures** |

Zero PASS→FAIL is *structural* here, not just sampled: this lane changed no
`recon/**` source and no shared header, and no recon TU includes `asm/data/**`,
so no TU's compilation input changed. The three spot TUs (one per owned-window
family: game/common, game/psx, eaclib) confirm it empirically.

---

## 5. NEW FINDINGS — 3 REAL DATA DEFECTS, byte-evidenced

Isolating windows that fail **only** E5 (structure perfect, bytes wrong) gives
three exact, self-contained bugs. Retail bytes read from `rom/nfs4-f.exe`:

| TU | VA | retail | ours | reading |
|---|---|---|---|---|
| `game/common/fastrand.cpp` | `0x8013D0FC` | `01af74f8 00000000 01000000 00000000` | all zero | **RUNTIME BUG**: `fastRandom` starts at `0xF874AF01` and `randSeed` at `1` in retail; ours start at 0. `randtemp`/`numRandCalls` are correctly 0. |
| `game/common/mpause.cpp` | `0x8013D244` | `12001100 13000000 17001800 19000000` | all zero | **RUNTIME BUG**: `short InGameSelectListAudioMode[4] = {0x12,0x11,0x13,0}` and `short SelectListConfig[4] = {0x17,0x18,0x19,0}` are declared with no initializer — the two in-game menu item-id lists are empty. |
| `game/common/aispeeds.cpp` | `0x8013C5D0` (`D_8013C5D0`, 8 B) | `61697774 68657200` = **`"aiwther"`** | 8 zero bytes | **NOT a data bug — a `-G` IDENTITY tell.** The string is `reservememadr("aiwther",0x104,0)` at `aispeeds.cpp:71`. Retail placed an 8-byte string literal in `.sdata`, which is only possible at **`-G8`**; our `-G4` build puts it in `.rodata` and leaves 8 zero bytes at the window tail. |

🔑 **NEW LAW CANDIDATE (catalog §E / the `-G8` census family):**
*a window whose only E5 failure is a short string literal or a ≤8-byte array
sitting at a retail small-data VA is a `-G8` OBJECT TELL* — a >4-byte object
cannot reach `.sdata` at `-G4`. Two independent hits here: `aispeeds.cpp` (the
`"aiwther"` literal) and `mpause.cpp` (two 8-byte `short[4]` arrays, which are
also 2 of the 8 symbols W62-A19 §3.2 flagged as "defined in the WRONG section"
— **same root cause, one fix**). `-G` wiring is `PER_TU_FLAGS`, i.e.
orchestrator-owned: see §7.

I did not land these: `fastrand`/`mpause` initialiser fixes and a `-G8` wiring
are source/wiring changes owned by the game belts and the orchestrator, and
this lane's mandate was ownership, not matching. All three are one-line fixes
with the retail bytes already decoded above.

---

## 6. CONTINUATION CURSOR (exact)

**Region 1 (`sdata_8013C54C`) is CUT but not CLOSED: 30 of 74 windows owned,
408 of 6192 bytes, 96 of 458 duplicated labels resolved.**

Next agent, in order:

1. **Re-measure first.** `python scratchpad/w63a19/scan.py && python
   scratchpad/w63a19/probe_link.py` (in that order, same invocation — a stale
   `objdata.json` is worth ±1 %). Then
   `python scratchpad/w63a19/ownmap.py --blob
   scratchpad/w63a19/ctl_blob/sdata_8013C54C.sdata.s` for the ownership map
   (that path is the pre-split copy the map must be read against; the live blob
   is now 53 pieces).
2. **Finish region 1 by clearing blockers, cheapest first** — each cleared
   window is a `_oNN` file deleted, one line changed in `linkers/nfs4.ld` and
   one in `linkers/nfs4_recon.sdata.ldfrag`:
   * **E5-only (3 windows, §5)** — `fastrand` + `mpause` initialisers, then the
     `-G8` probe for `aispeeds`/`mpause`. Cheapest wins in the whole region.
   * **E3 (28)** — intra-TU data ORDER drift; this is the *data twin* of the
     closed text-inversion programme (W62-A19 §2.2 counted 124 order
     divergences in 33 objects). Worst offenders in this region:
     `audiocmn.cpp` (10 implied bases), `genericpmx.cpp` (10), `nfs3.cpp` (4),
     `copspeak.cpp`, `bworld.cpp`, `aiphysic.cpp`, `mpause.cpp`.
   * **E1 un-migrated (19)** — a blob label inside an otherwise-owned window
     that no TU defines yet: pure §4b data-materialisation.
   * **E2 (17)** / **E4 (14)** — a TU whose data spans two retail runs, or
     whose section is short by a tail datum.
3. **Then region 2 = `data_8010CCD4`** (273 dups, the next-largest) and region
   3 = `front_data` (78). `ownmap.py`/`splitblob.py` are blob-agnostic:
   `--blob asm/data/data_8010CCD4.data.s --end <next section VA>`; the only
   per-blob input is the region's end VA.
4. **Do NOT** rename the 131 `*_vtable` labels (T2) without deleting the
   matching rodata-blob region in the same commit — W62-A18 §5: rename-alone
   converts 115 silent duplicates into 115 hard errors.

---

## 7. ORCHESTRATOR ACTIONS REQUESTED

1. **`-G8` probe + wiring for `game/common/aispeeds.cpp` and
   `game/common/mpause.cpp`** (`PER_TU_FLAGS` `{"g_value": "8"}`). Evidence:
   §5 — an 8-byte string literal and two 8-byte `short[4]` arrays that retail
   holds in `.sdata`. Expected: E5 flips for both windows AND 2 of W62-A19's 8
   "wrong section" symbols close. ⚠️ `PER_TU_FLAGS` duplicate-key hazard
   (catalog 12F): grep the key before adding, and re-gate WIRED, not probed.
2. **Route the 2 initialiser bugs** (`fastrand.cpp`, `mpause.cpp`, §5) to the
   game/common belt — retail bytes decoded, one line each.
3. **Promote `ownmap.py` as the data-ownership gate.** It is the data twin of
   `tu_order_audit.py`: it is the only instrument that sees "a recon TU's data
   section cannot be placed", and its E5 leg catches wrong data VALUES that no
   per-function gate can. Standing numbers for region 1: **30 ownable / 74
   windows, 408 / 6192 bytes**.
4. **Decide the recon-lane `.ld`** (W62-A19 §6.1 `gen_ld.py`).
   `linkers/nfs4_recon.sdata.ldfrag` is its sdata section, ready to paste.
5. **`linkers/nfs4.ld` does not link at HEAD** (§3 P6, 2077 undefined `.L<VA>`
   jump-table labels from the src lane). Either wire the src lane's local
   labels or retire the script — right now `python tools/build.py` (no flags)
   cannot complete, which is why this hazard has gone unnoticed.

---

## 8. HAZARDS ENCOUNTERED

* 🔴 **Concurrent peer belts moved `recon/**` and `build/recon/**` mid-run**
  (4 modified files at open → 9 by mid-run). Any absolute number read off
  `build/**` is a snapshot. I re-ran the ownership map against the peer-rebuilt
  objects and diffed it (§2, IDENTICAL) rather than assuming.
* 🔴 **`objdump -t` output is COLUMN-EXACT, not whitespace-delimited**: the
  7-character flag field starts with a SPACE for undefined symbols, so a greedy
  `\s+` silently misaligns every such line. Caught before trusting output;
  `ownmap.py` uses a fixed-width regex.
* 🔴 **`objdump` echoes the path you PASS it**; feeding absolute paths while
  keying results on relative ones drops every record. The tool asserts that
  every requested object produced a record (this fired).
* An objdump byte-compare of a data blob **will differ from the ROM wherever a
  relocation sits** (the object holds 0). Classify by `objdump -r` before
  calling it a data defect — this is the same vacuity class as catalog 12H.
* `build.py --help` is not a flag: `tools/build.py` parses `sys.argv` by hand
  and any unknown argument runs a **full build + link**.
* Piping a long `build.py` run into `head` yields an empty log (SIGPIPE) and a
  0 exit code — redirect to a file, never pipe.

---

## 9. FILES

**Landed (committed):**
`asm/data/sdata_8013C54C.sdata.s` → deleted, replaced by 53 `_rNN`/`_oNN`
pieces · `linkers/nfs4.ld` (53 ordered entries) ·
`linkers/nfs4_recon.sdata.ldfrag` (new).

**Tools built here (`scratchpad/w63a19/`, all committed):**
`blobparse.py` (lossless spimdisasm-blob parser + re-emit assertion) ·
`ownmap.py` (the E1–E5 ownership map) · `splitblob.py` (the cut, with the
tiling/alignment/round-trip assertions) · plus `scan.py`/`probe_link.py`/
`tile.py`/`layout.py` copied from `w62a19` so this lane is self-contained.

**Evidence:** `ownmap_sdata.txt` / `.json` (t0), `ownmap_sdata_t1.txt` / `.json`
(post-peer-rebuild control), `sdata_pieces_order.txt`, `link_probe.txt`,
`build_baseline.log`, `nfs4_HEAD.ld` (the P6 control script),
`sdata_8013C54C.sdata.s.bak` + `ctl_blob/` (the pre-split blob, kept because
`ownmap.py` must be pointed at an un-split blob).
