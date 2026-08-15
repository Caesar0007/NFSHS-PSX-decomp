# W62-A17 RECEIPTS — declarations-divergence auditor

Deliverable table: `scratchpad/w62a17/DECL_DIVERGENCE.md`.
Every gate below is `python tools/tugate.py <cpp>` run **twice**; baseline re-measured
by me, never taken from `MATCH_PROGRESS.txt`.

## Commits (each one symbol-class, small, early)

| commit | what | gates (before → after, both runs identical) |
|---|---|---|
| `ad0254e2` | memcard BOOL flags `char`→`int` (`CURRENTLYUSINGMEMCARD`, `MEMCARD_INITIALIZED`, `MEMCARDFRONTENDISINITTED`) in `fememcard_externs.h`; retired the `*(int*)&MEMCARDFRONTENDISINITTED` local cast | fememcard 18/18 → 18/18 (gated after **each** of the 3 symbol edits) |
| `1856400b` | `Stats_gTrackRecords` `int*` / `tRecordBuffer*` / `int` → `tRecordBuffer[187]` in `fememcard_externs.h`, `fecheats_externs.h`, `front_externs.h` | fememcard 18/18, fecheats 10/10, front 41/43, psxfront 23/25, femenudefs 65/66, minfront 1/1 |
| `c3021c78` | `screenpost_externs.h`: `int *gCView` → `DRender_tView gCView`; `char CURRENTLYUSINGMEMCARD` → `int` | screenpost 12/13 |
| `2949e4ae` | `Speech_Mobile`/`Speech_Dispatch`/`Speech_Reset` asm-label aliases to the real `Mobile__6SpeechP8Car_tObj` / `Dispatch__6Speech` / `Reset__6Speech` across 7 headers | aih_basiccop 9/9, aih_basicperp 8/9, aih_btccop 39/40, aih_btcperp 26/26, aih_cop 9/10, aih_play 10/10, nfs3 10/11 |
| `44e1b58a` | `AIInit_forceHumanHandBrake` `u_char[]` → `int` (`aiphysic_externs.h`); `sizeof(bool)==4` lane law receipted in `screentrackrecords_externs.h` | aiphysic 40/42, aih_basiccop 9/9, screentrackrecords 7/7 |
| `e34826de` | `MCRD_*` family wrapped in `extern "C"` (`fememcard_externs.h`, `screenmemcard_externs.h`) — 8 phantom manglings removed | fememcard 18/18, screenmemcard 15/15 |
| `142f5396` | `psxfront_externs.h`: the function block was inside `extern "C" { }` → **33** unmangled refs to C++-defined functions. Block restored to C++ linkage; `elapsedticks` (real eaclib C) given its own `extern "C"`. | psxfront 23/25 → 23/25 |

## Evidence instruments used

* **SYM** `C:\Temp\claud\dumpsym_clean\dumpsym_src\nfs4-f-v3.txt` — `94/96 Def class EXT type …`
  records give the retail type and (for structs) the byte size. v3 `BOOL` is **4 bytes**
  (the dumpsym bool port), which is what settled the memcard flags.
* **Symbol adjacency** — `CURRENTLYUSINGMEMCARD` @`0x80051a7c` with `MEMCARD_INITIALIZED`
  @`0x80051a80` bounds the first at exactly 4 bytes.
* **Oracle access-WIDTH census** (`scratchpad/w62a17/width_census.py`) — histogram of
  `lw/sw/lb/lbu/sb/lh/sh/addiu` against `%lo(SYM)`/`%gp_rel(SYM)` across all of `asm/`.
  An `addiu`-only symbol is storage whose address is taken (never a pointer cell) — that is
  what proved `Stats_gTrackRecords` is an array.
* **`asm/data/*.s` dlabels** — the authoritative extent of a data object
  (`NewRecords` = 8 `.word`s, `gSwapFileName` = 5 `.word`s ending at `kBannerColors`,
  `screenMain` = 2 `.word`s).
* **nm over the LINK set only** — `build/recon` + `build/asm`, batched 50 objects per call
  (ARG_MAX vacuous-pass law). Including `build/src` (the `INCLUDE_ASM` oracle objects) or
  `build/diffsrc` (the `-g` SLD instruments) inflates the phantom count 221 → 3345.

## Falsifications / negative results (do not re-fight)

1. **`NewRecords`/`NewBestLap` `bool` → `int` is WRONG.** Measured: `7/7 → 6/7`,
   `DrawRecords__19tScreenTrackRecordss` gains `sltu a2,zero,a2`. The oracle passes the loaded
   word straight into `DrawOneRecord__19tScreenTrackRecords`**`ibi`** with no normalization.
   Reverted. ⇒ **LAW: `sizeof(bool) == 4` on the cc1plus C++ lane**, so the tree-wide
   bool-vs-int divergence is *not* a storage bug — it only bites at conversion sites, and the
   consumer's mangling (`b` vs `i`) is the arbiter of which spelling is right.
2. **`ticks` must NOT be promoted to `volatile` in the shared headers.** The owners
   (`inittmr.c`, `timer.c`) are correct that it is IRQ-written, and `fememcard.cpp` receipts a
   real infinite-loop bug from the non-volatile decl — but catalog 09I measured that a blanket
   volatile READ degrades `lh`→`lhu` and costs 20+ phantom diffs. The per-site
   `*(volatile int*)&` / asm-label `volatile` view is the sanctioned device and is already
   deployed in fememcard/mdec/video/fe3dmenu. Not touched.
3. **The `(...)` / 10C phantom class is CLOSED, not open.** 324 literal `(...)` decls look
   alarming, but 218 sit inside `libfns.h`'s `extern "C"` (no mangling possible) and nm reports
   **zero** undefined `__Fe` symbols. The only float-taking functions in the tree
   (`DrawCar`, `Draw_MenuRenderingView`) are typed at every declaration site.
4. **The `_padFunc*` `void*`-vs-fn-ptr split is the sanctioned pattern**, not a bug
   (methodology §4 gotcha #8: dispatch slots are defined `void *slot = 0;` and each consumer
   declares its own concrete type). 12 symbols removed from the bug list on that basis.
5. **`gSwapFileName`'s 4-way extent split is mostly a false positive** — 5 of 6 decls are
   per-TU `static` buffers at different addresses. Only the one EXTERNAL definition
   (`screentrophyroom_externs.h`, `[16]` vs the oracle's 20 bytes) is a real bug.
6. **A `T*` vs `T**` "extra indirection" cluster across `draww_externs.h`/`track_externs.h`
   (21 symbols) was a SCANNER BUG**, not a tree bug — the star in the base-type token was being
   counted twice. Fixed in `decl_scan.py`; Tier 2 collapsed 21 → 1.

## Hazards hit

* **Concurrent rebuilds by belt agents** make `build/**` a moving target: two identical nm runs
  minutes apart gave 2298 vs 3345 raw phantoms. Any nm-derived count must be re-measured
  immediately before acting on it.
* `git log --oneline -1` immediately after `git commit` can show **another agent's** commit
  (one landed between my commit and the log). Verify with `git log --oneline -6`.
* The Edit tool's CRLF normalization shows several headers as `M` with a zero-byte
  `git diff` (catalog 12K). `recon/lib/libfns.h` was already in that state on arrival and was
  **left alone** (never `git checkout`-ed).

## Header-wish sweep

Tree-wide `HEADER WISH` markers: 8. Folded in: 3 (the fememcard true-type block — commits
`ad0254e2` / `1856400b`). Tabled with reasons in DECL_DIVERGENCE.md §3: the four sndpsxz
sndpd-relative migrations (`sdpacket.c` ×2, `spktplay.c`, `spchpick.c`) and the `draw.cpp:368`
scratchpad-accessor promotion — all cross-TU refactors, out of a header-only scope.
Belt-agent `scratchpad/w62a*/RECEIPTS.md` swept twice (mid-run and at close). At close 14
belts had published: `w62a1` and `w62a8` carry an explicit **"HEADER-WISH: none"**; the other
12 (`a2 a3 a4 a5 a7 a10 a11 a13 a14 a19 a20`) contain no shared-header request at all — a
keyword scan over all of them returns only "preheader"/"file header" false positives.
**Net: zero belt-agent header wishes to fold in this wave.**

## Recommended next actions (orchestrator)

1. ~~RANK-1 class A sweep~~ — **33 of the 42 LANDED** (`142f5396`). The 9 stragglers live in
   other headers (`cars.cpp`/`aispeeds.cpp`/`audiocmn.cpp`/`fetexture.cpp`/`video.cpp`/
   `nfs3.cpp` consumers): `AIPhysics_UseCoolPhysics`, `AISpeeds_CalcHumanCurveSpeed`,
   `AISpeeds_MaintainLeaderBoard`, `AIWorld_CalculateLaneInfo`, `Cars_SortCars`,
   `DrawW_DoObjectAnimations`, `AudioCmn_ReverbOff`, `Texture_GetClutId`, `mdecreset`,
   `restoretextdraw`, `systemtask__Fi`. Same one-line treatment; re-run
   `scratchpad/w62a17/phantom_recon` output to get the current owning header per symbol.
2. **RANK-1 class C (67 symbols):** the remaining §3.23b flattened-free-fn → method conversion.
   Catalog 10F sized it at ~17; the full-link-set nm says **67**.
3. **RANK-1 class B (9):** pointer→reference parameter corrections; each is a one-line header
   edit plus dropping `&` at the call sites.
4. **USER-BLOCKED, needs sign-off:** `fedialog_externs.h`'s three `(...)` decls (typed forms
   already exist in sibling headers, quoted in §3) — the last real 10C row.
5. `screenMain` should become `extern tScreenMain *screenMain;` (oracle: 2-word dlabel,
   `fecredits.cpp` uses `screenMain->`), gated on `screenmain.cpp`.
