# W62-A17 — TREE-WIDE DECLARATION DIVERGENCE TABLE

Repo `C:\Temp\nfs4-decomp`, wave W62, 2026-08-15. Scope: every shared header
(`recon/nfs4_types.h`, `recon/lib/*.h`, `recon/**/*_externs.h`, `recon/**/*.h`) plus every
file-scope declaration in `recon/**/*.{c,cpp}`.

**USER-BLOCKED files were NOT edited** (AGENT_GUIDE §5 / §7.5): `recon/nfs4_types.h`,
`fedialog_externs.h`, `femenuextended_externs.h`, `screenusername_externs.h`,
`femenudefs.cpp`. Divergences found in those are TABLED with the exact diff below.

---

## 0. HEADLINE NUMBERS

| measurement | count |
|---|---|
| files parsed (`recon/**/*.{h,c,cpp}`) | 844 |
| distinct file-scope DATA symbols | 1713 |
| **data symbols declared with ≥2 DIFFERENT types** | **133** |
| ── TIER 1 base/element type differs (real class) | 54 |
| ── TIER 2 pointer-DEPTH differs | 1 |
| ── TIER 3 array-EXTENT only (documented `[]`-view lever) | 78 |
| TU-local **asm-label** redeclarations (`… asm("sym")`) | 82 decls / 53 symbols |
| in-source `HEADER WISH` markers outstanding | 8 → **3 folded in, 5 tabled** |
| function names with divergent signatures (ignoring param names) | 625 / 3926 |
| ── of those, divergent **ARITY** | 347 |
| literal `(...)` declarations | 324 (218 of them inside `libfns.h`'s `extern "C"`) |
| **`__Fe` variadic phantoms at link (nm)** | **0 — the 08A/10C debt is closed** |
| nm LINK-set objects (`build/recon` + `build/asm`, excl. `src`/`diffsrc`/`scratch`) | 520 |
| **phantom externs — ALIAS class** (symbol exists under a *different exact name*) | **148** |
| **phantom externs — ORPHAN class** (no symbol anywhere shares the base name) | **73** |
| symbols FIXED this run | **50** across 12 headers, 7 commits |
| PASS→FAIL regressions introduced | **0** (every consumer TU gated twice) |

---

## 1. FIXED (receipt-proven true type, all users agree, gated 2×)

| # | symbol | header type (before) | TU-local override | PROVEN true type | evidence | verdict |
|---|---|---|---|---|---|---|
| 1 | `CURRENTLYUSINGMEMCARD` | `char` ×2 (fememcard, screenpost); `int` ×3 | `int … asm("CURRENTLYUSINGMEMCARD")` + unsized `int[]` view (fememcard.cpp) | **`int` (4-byte BOOL)** | SYM `94 Def class EXT type BOOL` @`0x80051a7c`; next symbol at **+4**; oracle census **7 `lw` + 8 `sw`, 0 byte ops** | **FIXED** `ad0254e2`,`c3021c78` |
| 2 | `MEMCARD_INITIALIZED` | `char` (fememcard); `int` (femenudefs) | asm-label `int` + `int[]` view | **`int`** | SYM `EXT BOOL` @`0x80051a80`; oracle 4 `lw` + 2 `sw`, 0 byte | **FIXED** `ad0254e2` |
| 3 | `MEMCARDFRONTENDISINITTED` | `char` (fememcard); `int[]` (front) | asm-label `int` + `*(int*)&` cast at the use site | **`int`** | SYM `EXT BOOL` @`0x8013d284`; oracle 2 `lw` + 3 `sw`, 0 byte | **FIXED** `ad0254e2` (cast workaround retired) |
| 4 | `Stats_gTrackRecords` | `int*` (fememcard), `tRecordBuffer*` (fecheats), `int` (front) | unsized `int[]` / `tRecordBuffer[]` asm-label views in both TUs | **`tRecordBuffer[187]`** | owner `nfs3.cpp` @`0x80114d94`; oracle = **7 `addiu` address materializations, 0 loads**; `statchk`/`stattool` blockmove `0x154 = 0x11×20 B` | **FIXED** `1856400b` |
| 5 | `gCView` | `int*` (screenpost) vs `DRender_tView` ×6 | — | **`DRender_tView`** | SYM `96 Def2 class EXT type STRUCT size 140 tag DRender_tView` @`0x80116f7c`; owner `render.cpp` | **FIXED** `c3021c78` (last survivor of the 10E row) |
| 6 | `AIInit_forceHumanHandBrake` | `u_char[]` (aiphysic) vs `int` ×4 | — | **`int`** | owner `aiinit.cpp` @`0x8013c584`; oracle `sw %gp_rel`, `lw`, `sw` — 3 word ops, 0 byte | **FIXED** `44e1b58a` |
| 7–9 | `Speech_Mobile` / `Speech_Dispatch` / `Speech_Reset` | C++ free-fn decls in **7** headers → `Speech_Mobile__FP8Car_tObj`, `Speech_Dispatch__Fv`, `Speech_Reset__Fv` | — | **`Mobile__6SpeechP8Car_tObj` / `Dispatch__6Speech` / `Reset__6Speech`** (C linkage, `speech.cpp`) | nm: all three referenced manglings are in the ORPHAN class — **they exist nowhere** | **FIXED** `2949e4ae` via asm-label alias |
| 10–17 | `MCRD_init/restore/savefile/loadfile/getopts/setopts/fileexists` (+`handlecardevents` normalized) | plain C++ decls → `MCRD_init__Fi`, `MCRD_loadfile__FiP12MCRDFILE_defi`, … | — | **plain C names** (`memcard.c` is a C-lane TU) | nm ALIAS class, 8 rows; siblings in the same block already had `extern "C"` | **FIXED** `e34826de` |
| 18–50 | 33 game entry points in `psxfront_externs.h` (`AudioCmn_LoadFESamples`, `Draw_SetView`, `R3DCar_Instantiate3DCar`, `Texture_*`, `play_movie`, …) | the whole function block sat inside `extern "C" { }` → 33 UNMANGLED refs | — | **C++ linkage** (`…__Fv` / `…__Fii` / `…__FP8Car_tObji`) | per-name nm test over the 520-object link set: 1 plain-defined (`elapsedticks`, real eaclib C), **33 mangled-only**, 1 undefined either way (`trap`) | **FIXED** `142f5396` — the single largest link-debt concentration in the tree |

Gate ledger (baseline → after, each run twice, **identical**):
`fememcard 18/18`, `fecheats 10/10`, `front 41/43`, `psxfront 23/25`, `femenudefs 65/66`,
`minfront 1/1`, `screenpost 12/13`, `screenmemcard 15/15`, `aiphysic 40/42`,
`aih_basiccop 9/9`, `aih_basicperp 8/9`, `aih_btccop 39/40`, `aih_btcperp 26/26`,
`aih_cop 9/10`, `aih_play 10/10`, `nfs3 10/11`, `screentrackrecords 7/7`.

---

## 2. NEW MEASURED LANE LAW — `sizeof(bool) == 4` on the cc1plus C++ lane

This **retires the whole "bool vs int" divergence class as a storage bug** and is the single
most important negative result of the run.

* Storage proof: `front_data.data.s` dlabels `NewRecords` as **8 `.word`s** @`0x80052978`;
  `StatChk_ClearNewRecords` walks it with `addiu $v0,-0x4`; `DrawRecords` indexes with
  `sll $s1,2`. Our build **PASSes that function with `extern bool NewRecords[8]`** ⇒ our
  `bool` array has stride 4.
* Conversion proof (the direction that *does* matter): the oracle passes
  `lw $a2,0($s0)` straight into `DrawOneRecord__19tScreenTrackRecords**i b i**` with **no**
  normalization. Re-declaring the array `int` **adds** `sltu a2,zero,a2` → 7/7 → **6/7**.
* ⇒ `bool` is the *correct* spelling at every site whose consumer mangling carries `b`;
  `statchk.h`'s `int NewRecords[8]` / `int NewBestLap` are the divergent-but-size-compatible
  spelling. The trial `int` conversion was **reverted**; the law is receipted in
  `screentrackrecords_externs.h`.

Affected rows now reclassified **TABLED — non-bug**: `NewBestLap`, `NewRecords`,
`Hud_BeTheCop`, `Hud_kTurnSongOffNext`, `bSirenOn`.

---

## 3. TABLED — CONFLICT (two TUs assert DIFFERENT true types, or evidence is thin)

| symbol | competing types | why not fixed |
|---|---|---|
| `CD_status` | `char` (`cdcont.c`) vs `int` (`drv.c`) | **Oracle uses BOTH**: 4 `lbu` + 3 `lw` + 3 `sw`. Genuinely mixed-width access — the object is probably a word whose low byte is read separately, or two overlapping symbols. Needs a per-site decision, not a header edit. |
| `ticks` | `int` ×19, `int[]` ×12, **`volatile int` ×2** (eaclib `inittmr.c`/`timer.c` — the OWNERS) | The owners are right: `ticks` is written by `Clock_MasterInterruptHandler` behind the compiler's back, and `fememcard.cpp` carries a receipt that the plain decl lets gcc fold its wait loops into **infinite loops** (a real behavioural bug). But blanket volatile-ization is expressly against AGENT_GUIDE §5.4 and catalog 09I (`a volatile READ degrades lh→lhu`, 20+ phantom diffs). **The established project device is the per-site `*(volatile int*)&` / asm-label `volatile` view, already used in fememcard/mdec/video/fe3dmenu.** Recommendation: keep per-site, do NOT promote to the shared headers. |
| `gPreLoadTicks` | `void(*)(void)` (sdma.c), `void*` (sdpacket.c), `int` (spchevnt.c), `int[]` (spchpick.c) | 4-way split across two libraries; `sdpacket.c` carries a receipt that this and its two siblings are really **fields inside the `sndpd` block** (`sw v0,0x724(s2)`), not standalone globals. Correct fix is the cross-TU sndpd-relative migration, not a type edit. |
| `snd_voice_done_hook`, `snd_user_serve_hook`, `+1` | standalone globals vs `sndpd+0x720/+0x724/+0x728` fields | Same receipt as above (`sdpacket.c:163`). 6 sites across `sdma/sdriver/slib/spchevnt/spchpick`. Cross-TU migration. |
| `DAT_801479f0` | `char` ×2 vs `int` ×1 | `sdpacket.c` proves it is `sndpd[0xD8]`, i.e. a field of the packet-voice table, not a symbol. Migration, not a type edit. |
| `_padFunc*` (12 symbols) | `void*` in `PAD.c` vs typed fn-ptrs in `PADMAIN/PADPORTD/PADCMD/PADSEQD/MCXMAIN/PADENTRY` | This is the **documented, sanctioned** pattern (methodology §4 gotcha #8: a runtime dispatch slot is defined `void *slot = 0;` and each consumer declares its own concrete fn-ptr type). Several consumers additionally disagree with each other on return type (`int`/`unsigned`/`void`) and on `char*` vs `_PadDev*` — same size, no link effect. |
| `sndgs` (`int[]` ×43 vs `SNDGlobals` ×2), `simGlobal` (`Sim_tSimGlobalVar` ×37 vs `int[]` ×1), `ginfo` (`SPEECHINFO` ×4 vs `char[256]` ×1), `CF_DVLC`, `currentfont` | struct vs blob-view | The blob/`int[]` views are the deliberate unified-blob device (methodology "Blob-view aliasing"). Oracle is `addiu`-dominant in every case (address-taken storage), so both spellings reach the same bytes. No action. |
| `Draw_gPlayer1View` | `int` ×13 vs `void*` ×2 | Same size; no oracle discriminator found. Cosmetic. |
| `fastRandom`/`randSeed`/`randtemp` | `u_int` ×16 vs `int` ×1 (`aiphysic_externs.h`) | Signedness only, same size. Codegen-relevant (`srl` vs `sra`) if shifted; `aiphysic` does not shift them. Low priority — the ×16 `u_int` majority is presumably right. |
| `gFECheats`/`gFEBonus` | `int` (fecheats) vs `u_long` (nfs3.cpp, the owner) | Signedness only; oracle is `lw`/`sw` both ways. |
| `Render_gPacketEnd` | `char*` ×4 vs `u_char*` ×1 (owner `render.cpp`) | Pointee signedness. **No oracle reference under that symbol name** (it is a scratchpad-resident cursor, §3.6b) — no discriminator. `draw.cpp:368` carries a standing header wish to convert the whole family to `sd->head…` scratchpad accessors. |
| `screenMain` | `tScreenMain` OBJECT (`screenmain_externs.h`) vs `tScreenMain*` ×2 vs `tScreenMain*[]` ×1 | Oracle dlabel `screenMain` = **2 words** @`0x80051E58`, and `fecredits.cpp` uses `screenMain->…` ⇒ it is a POINTER, so the object spelling is wrong. Not fixed: `screenmain_externs.h` is heavily consumed and the object form may be load-bearing for a member-access spelling there. **Recommended fix: `extern tScreenMain *screenMain;`** — needs a screenmain.cpp gate. |
| `DrawW_gChunkVtxBuf` | `Group*` (owner `draww.cpp`) vs `SVECTOR[]` (`hrzsku_externs.h`) | Pointer vs array — one of them is wrong, but there is no oracle reference under this project-invented name to arbitrate. |
| `highLevelAIObjs` | `AIHigh_Base*[]` ×6 vs `AIHigh_Traffic*[]` ×2 | Element type differs; both are 4-byte pointers so codegen is identical, but the `AIHigh_Traffic*` spelling in `aih_traf`/`object` silently reinterprets a base-class slot. Correct fix is `AIHigh_Base*[]` + a cast at use. |
| `tScreenPinkSlipStandings_vtable`, `tScreenTournamentStandings3item_vtable` | `__vtbl_ptr_type[]` vs `__nfs4_vtbl_ptr_t[10]` | Part of the ~55-symbol vtable-materialization debt (catalog 10F). |
| `gSwapFileName` (extent 16/20/40×2/64) | — | ⚠️ **Mostly a FALSE POSITIVE**: five of the six decls are `static` per-TU buffers at *different* addresses (`0x80052c00/0x80052c28/0x80052c90/0x80052ca0`). The one EXTERNAL definition, `screentrophyroom_externs.h: char gSwapFileName[16]; /* @0x80052064 */`, **is undersized**: the oracle dlabel spans 5 words (20 B) `0x80052064–0x80052077`, ending exactly at `kBannerColors`. Tabled only because no `.cpp` currently includes that header. |
| `fedialog_externs.h`: `void DrawShape_NFS4RoundRectangle(...); void MenuNFS4_SetHelpPos(...); int CalcOnOffFade(...);` | `(...)` vs the typed forms already present in `femenuextended`/`femenuoptions`/`screencarselect`/`fefades.h` | **USER-BLOCKED FILE.** Recommended diff: replace with `void DrawShape_NFS4RoundRectangle(int, RECT &, short);`, `int CalcOnOffFade(tMenuTextType, short, short, short, int &, int &);` (copy from `femenuextended_externs.h:48` / `screencarselect_externs.h:117`). This is the last real 10C row. |

---

## 4. THE `(...)` / 10C CLASS — effectively CLOSED

* nm over the true link set finds **zero** undefined `__Fe` symbols. The 218 `(...)` decls in
  `recon/lib/libfns.h` are all inside `extern "C" { … }`, so they mangle to their plain names
  and cannot produce a phantom.
* The 10C *codegen* risk (float args passed as double under default promotions) requires a
  float/double parameter. A tree-wide scan finds **exactly two** float-taking functions —
  `DrawCar` and `Draw_MenuRenderingView` — and **both are typed at every declaration site**.
  The only float `(...)` decls left are the eight libgcc soft-float helpers
  (`__adddf3`, `__divsf3`, `__floatsisf`, …), which no source calls explicitly; the compiler
  emits those calls itself with its own ABI knowledge, so the decl is inert.
* Residual: the `(...)`/`()` placeholders in `recon/lib/syslib.h` and `recon/lib/eaclib.h`
  (e.g. `int CD_sync();` vs the real `int CD_sync(int, unsigned char *)`, `CD_Read(int arg0)`
  vs `(int,int,int,int)`) — these drive most of the 347 "divergent arity" rows. On MIPS with
  int/pointer arguments the promotion is codegen-neutral, and every calling TU carries its own
  typed prototype. **TABLED, low risk**, but they should eventually be replaced by the typed
  forms harvested from the owning TU.

---

## 5. LINK-RISK RANKING (what would actually break or corrupt a real PSYLINK link)

### RANK 1 — HARD LINK FAILURE (unresolved symbol). 221 symbols found, **44 fixed this run, 177 remain**.
The gate cannot see any of these: `verify_asm` is deliberately reloc-name-lenient (catalog 0c).
Counts from `nm` over the 520-object link set (`build/recon` + `build/asm`).

| sub-class | count | example | fix shape |
|---|---|---|---|
| **C — flattened free-fn vs real METHOD mangling** (§3.23b / 08B) | **67** | `DeInit__FP14tCreditManager` vs `DeInit__14tCreditManager`; `Draw__FP10tVideoWall` vs `Draw__10tVideoWall` | declare the method in the class + convert call sites to `obj->f(...)` (byte-neutral) |
| **A — `extern "C"` plain name vs C++ mangling** | **42** → **9 left** | `psxfront.cpp.o` refs `Draw_InitViews`, `CarIO_StartUp`, `R3DCar_StartUp`, `Texture_InitMenuClut`, … vs `…__Fv` | **33 FIXED** (`142f5396`, `psxfront_externs.h`). Remaining 9: `AIPhysics_UseCoolPhysics`, `AISpeeds_CalcHumanCurveSpeed`, `AISpeeds_MaintainLeaderBoard`, `AIWorld_CalculateLaneInfo`, `Cars_SortCars`, `DrawW_DoObjectAnimations` (all from `cars.cpp.o`/`aispeeds.cpp.o`), `AudioCmn_ReverbOff` (`audiocmn.cpp.o`), `Texture_GetClutId` (`fetexture.cpp.o`), `mdecreset`/`restoretextdraw`/`systemtask__Fi` — same one-line treatment, different headers |
| **D — argument TYPE drift** | **22** | `BWAllocMem__Fi` vs `__Fl`; `Init_Memcard__FbUc` vs `__FbT0`; `Hud_BuildString__FPciiiii` vs `__FPciiiib`; `FEInput_GetKeyFromPlayer__F7tPlayeri` vs `__F7tPlayerl` | correct the declared parameter type (the mangling names the truth) |
| **B — pointer vs REFERENCE parameter** | **9** | `DrawTV__FP9tTVConfig` vs `__FR9tTVConfig`; `FECheat_SaveBonus__FPUl` vs `__FRUl`; `DrawShape_NFS4RoundRectangle__FiP4RECTs` vs `__FiR4RECTs` | change `T*` → `T&` and drop the `&` at call sites |
| **A2 — C++ ref vs plain C definition** | **8** | the `MCRD_*` family | **FIXED this run** (`e34826de`) — count is from pre-fix objects |
| **ORPHAN — nothing anywhere shares the base name** | **73** | `Speech_*` (3, **FIXED**); `showRoomFlag` ×3 TUs; `bigBuf` ×5 TUs; `_cdr`, `_fnt*`, `g_*_ptr`, `vsync_lastcount`, `systemtasksubs`; 19 `func_800EExxx`/`func_8005Fxxx` refs from `asm/data/*.s` | mixed: some are missing tentative definitions (§3.12 #6), the `func_<VA>` ones are **vtable/jump-table materialization debt** (catalog 10F), `bigBuf` is a string-pool base needing a data-mat definition |

### RANK 2 — SILENT CORRUPTION (links fine, reads/writes the wrong bytes).
* `Stats_gTrackRecords` as `int*`/`tRecordBuffer*` — would have loaded the array's own first
  4 bytes as a pointer and dereferenced it. **FIXED.**
* `gCView` as `int*` — same shape on a 140-byte struct. **FIXED.**
* `char`-declared 4-byte BOOLs (`CURRENTLYUSINGMEMCARD` etc.) — a `char` **store** writes 1 byte
  and leaves 3 stale; on a flag polled by the memcard IRQ path that is a live hazard. **FIXED.**
* `AIInit_forceHumanHandBrake` as `u_char[]`. **FIXED.**
* `highLevelAIObjs` as `AIHigh_Traffic*[]` where the storage is `AIHigh_Base*[9]` — TABLED.
* `screenMain` declared as an OBJECT where the storage is a pointer — TABLED.
* `screentrophyroom_externs.h: char gSwapFileName[16]` vs the oracle's 20-byte object, whose
  next neighbour is `kBannerColors` — a 4-byte under-definition. TABLED (no consumer today).

### RANK 3 — CODEGEN-ONLY (byte-match risk, no link/semantic risk).
The 78 TIER-3 array-extent rows (`T x` vs `T x[]` vs `T x[N]`) and the 53 asm-label views.
These are the **deliberate §3.12 #5 unsized-array lever** and must NOT be "normalized" —
`T x[]` + `x[0]` is what forces the oracle's separate `%hi` scratch. Every one of the 53
asm-label redeclarations inspected this run is either (a) that lever, (b) a `volatile` view
of an IRQ-written global, or (c) a true-type workaround for a header this run has now fixed.

### RANK 4 — COSMETIC.
Signedness-only rows (`int`/`u_int`, `int`/`u_long`, `char*`/`u_char*`), return-type-only
differences (not mangled — methodology gotcha #10), and parameter-NAME differences
(625 → 347 once names are ignored; the rest is pure naming).

---

## 6. TOOLS LEFT IN THE SCRATCHPAD (reusable)

| file | what it does |
|---|---|
| `scan_asmlabels.py` | every `… asm("sym")` redecl in `recon/`, paired with each shared-header decl of the same symbol |
| `decl_scan.py` | brace-depth-aware file-scope declaration parser → data-type divergence, `(...)` decls, signature divergence |
| `classify.py` | tiers the divergence list into base-type / pointer-depth / extent-only |
| `phantom_audit.py`, `phantom_classify.py`, **`phantom_recon.py` output** | nm over the LINK set only, split into ALIAS vs ORPHAN |
| `width_census.py` | oracle access-WIDTH census for a symbol list (`lw`/`lb`/`sb`/`addiu` histogram) — the fastest true-type oracle for a scalar |
| `fix_speech_alias.py` | the asm-label-alias applier (template for the RANK-1 class A sweep) |

**Reproduction caveat:** `build/**` objects are rebuilt by other agents mid-wave, so the nm
counts drift by a few between runs. Always re-run `phantom_recon` before acting on a row, and
never scan `build/src` (the oracle side) or `build/diffsrc` (the `-g` SLD instruments) —
including them inflated the phantom count from 221 to 3345.
