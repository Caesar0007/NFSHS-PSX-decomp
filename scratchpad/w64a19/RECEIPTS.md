# W64-A19 — THE LINK CAMPAIGN: symbol debt + linker scripts

Repo `C:\Temp\nfs4-decomp`, wave W64, 2026-08-15. Base HEAD `fbc974f7`
(peers landed continuously through the run; every number below was re-measured
by me, never quoted from a briefing).

---

## 0. HEADLINE

| axis | briefed (W62-A18 / W63-A19) | measured at start | after this agent |
|---|---|---|---|
| reloc-filtered unresolved, recon lane | 156 | **192** | **88** |
| — wrong-mangling (ALIAS) | 108 | **108** | **4** (all in USER-BLOCKED TUs) |
| — true undefined | 48 | **84** (59 ORPHAN + 25 retail-named) | 84 (classified, §3) |
| COMMON symbols | 37 | **37** | 37 (classified, §3.4) |
| recon-lane REAL ld link | never attempted | — | **runs; 402 undefined names** |
| …with the jump-table axis localized | — | — | **52** (= exactly the true-undefined set) |
| `linkers/nfs4.ld` (src lane) | "DEAD, 2077 undefined `.L` labels" | 1975 msgs, **0 undefined** | **20 msgs** with a ONE-LINE fix (§4.1) |

Two findings correct the standing record:

1. **The 108 wrong-manglings are not one class.** 99 are declaration drift, but
   **7 are IMPLICIT DECLARATIONS** (a prototype below its own call sites, so
   cc1plus emitted the call with an unmangled C name — `Cars_SortCars` was
   undefined *in the object that defines* `Cars_SortCars__Fv`) and **3 are
   vtable slots relocating against overloads that are DECLARED BUT NEVER
   DEFINED** — a hard link error and a runtime NULL dispatch.
2. 🔴 **`linkers/nfs4.ld` is NOT dead because of jump tables.** Its errors are
   not "undefined" at all; every one reads *"defined in discarded section
   `.text` of build/src/…"*. The script still names only `build/src/front.c.o`
   and `build/src/main.c.o` — **952-byte empty shells** — while the src lane was
   long ago split into **461 per-module objects**, all of which fall into the
   trailing `/DISCARD/ : { *(*); }`. Narrowing that one rule takes the src lane
   from **1975 error lines to 20** (§4.1). The "2077 undefined `.L` jump-table
   labels" framing in catalog 15E should be retired.

---

## 1. METHOD / ANTI-VACUITY

Every census in this run obeys the two banked gate defects:

* **ARG_MAX** — `nm`/`objdump` are fed in batches of 30 objects, never one glob
  (`scratchpad/w64a19/census.py`). An empty object list is a hard `assert`.
* **reloc filtering** — "unresolved" counts only names an actual
  `R_MIPS_*` relocation references (`objdump -r`); a dangling symtab entry is
  not a link error. (Recon lane: 192 raw = 192 reloc-referenced, 0 benign; the
  src lane's benign `__maspsx_include_asm_hack_*` noise is excluded by
  construction.)
* **exact-name matching** — never VA-grouped, so a hidden phantom cannot hide
  behind a differently-spelled definition of the same address.
* **excluded build subtrees are counted, not assumed** (`build/diffsrc`,
  `build/scratch`, `build/scratchpad`, `build/pbuild`).

The count moved 156 → 192 purely because the object set grew (519 → 621: the
W63 blob cuts added 97 pieces) and peers landed new code; the CLASSES are stable.

---

## 2. MISSION 1 — THE 108 WRONG-MANGLINGS  (108 → 4)

### 2.1 The device and why it is the right one

The dominant shape is a consumer TU declaring a C++ **member** as a flattened
free function (`void Draw(tVideoWall*)` → `Draw__FP10tVideoWall`) or with a
P-vs-R / `i`-vs-`l` / `int`-vs-`bool` parameter, so every call site emits a
symbol nothing defines while the real definition sits in-tree under its retail
mangling. `verify_asm` is deliberately reloc-name lenient (catalog 0c) so the
gate can NEVER see any of them.

Fix = an **asm-label on the declaration** (`… asm("Draw__10tVideoWall")`), the
project's established alias device (`feapp.cpp:104`; the W62-A17 `Speech_*` /
`MCRD_*` fixes). Chosen over retyping the parameter because it is **byte-neutral
by construction** — only the emitted relocation NAME changes — whereas retyping
a `bool`/`short` parameter changes the caller's argument conversion and would
put currently-byte-exact functions at risk. Where the mangling encodes a real
truth it is recorded in the alias (e.g. `BWorldSm_TunnelFlagSm` takes
`BWorldSm_Pos*` not `void*`; `Hud_BuildString`'s last parameter is `bool`;
`Flare_CarShapedHalo` args 3-4 are `COORD16*` not `int`).

### 2.2 Landed EMPIRICALLY, never by pattern-matching a signature

`scratchpad/w64a19/apply_alias{,2,3}.py`, `resolve_ambig{,2}.py`. For each
(symbol, TU): alias a candidate declaration → **recompile the TU** → keep the
edit only if

* the wrong symbol disappears from the TU's undefined set, **and**
* the only new undefined name is the intended retail one, **and**
* the TU's DEFINED symbol set is unchanged;

otherwise revert and try the next candidate. Logs: `apply_log*.txt`.

Three scanner defects were found and fixed *by the rejections*, each a real
source shape:
* a declaration whose `;` is followed by a trailing block comment;
* declarations inside an `extern "C" { … }` block (the plain-vs-mangled class —
  `Platform_ResetDCTBuffer`, `mdecreset`, `Texture_GetClutId`);
* several declarations on ONE line where one already carried an alias
  (`screencarselect_externs.h:103/105`) — the alias must be scoped to the
  individual declaration.

For the 22 ambiguous rows (many defined candidates share the base name) the
receiver is read out of the wrong mangling itself
(`Base__FP<len><Class>…` → `Base__<len><Class>…`, arg-count tie-break); the four
`void *`-receiver rows were decided at the CALL SITE
(`&menuDefs->iteratorTrack` → `tListIteratorTrack`; `gPauseCurrentMenu` →
`tPMenu`).

### 2.3 The 7 IMPLICIT DECLARATIONS (real bugs, not drift)

`cars.cpp` (`AIWorld_CalculateLaneInfo`, `AIPhysics_UseCoolPhysics`,
`AISpeeds_MaintainLeaderBoard`, `DrawW_DoObjectAnimations`, `Cars_SortCars`),
`audiocmn.cpp` (`AudioCmn_ReverbOff`, 5 call sites), `aispeeds.cpp`
(`AISpeeds_CalcHumanCurveSpeed`). The prototypes sat BELOW their call sites, so
cc1plus fell back to an implicit declaration and emitted unmangled C names.
Fix = hoist the prototype above the first use, signature unchanged.

### 2.4 The 3 vtable slots that pointed at nothing

`vtables_tmenu.cpp` took three member addresses through casts whose parameter
types come from `nfs4_types.h`, which declares `Draw(int)` and
`Draw(int,int,char)` for `tBlankMenuItemGoToMenuNFS4Button` /
`tBlankMenuItemNFS4LeftRightChoice`. **Those overloads are declared but never
defined** — the real definitions (`femenudefs.cpp`) are the `b`(bool) forms
already named in each slot's `@VA` comment. `nfs4_types.h` and `femenudefs.cpp`
are user-owned, so the slots now take the address through an asm-labelled
extern; the datum is a relocation either way, so zero data bytes move.

### 2.5 Proof of byte-neutrality (`byteneutral.py`)

Every affected TU compiled **twice** — once with this agent's 34 files reverted
to the pre-run snapshot, once with them in place, peers' concurrent edits left
in place on BOTH sides so the A/B isolates exactly this agent's change — and the
raw **section bytes** compared:

```
affected TUs: 32   section-byte IDENTICAL: 31   CHANGED: 1   skipped: 0
CHANGED recon/game/common/cars.cpp: ['.text']
```

`cars.cpp` is the one intended codegen change (implicit `int` return → declared
`void`); it re-gates **33/33 PASS**, i.e. the whole TU is byte-exact, so no
PASS→FAIL is possible.

### 2.6 Gate ledger — all 32 affected TUs, `tools/tugate.py`, run TWICE

```
feapp 14/15   fememcard 18/18   femenuoptions 91/92   fetourn 35/35
fevideowall 12/12   screenaudio 8/8   screencarselect 59/59
screencongrats 28/28   screencontroller 22/22   screenmain 13/13
screenmemcard 15/15   screenpinkslips 8/8   screentournselect 9/9
screentrackinfo 5/5   screentrackrecords 7/7   screentracks 10/10
screentrophyinfo 3/3  screentrophyroom 9/9    statchk 4/5
fetexture 2/2  movie 17/17  video 9/9
aispeeds 29/29  audiocmn 47/48  cars 33/33  mpause 10/10  nfs3 10/11
track 29/29  vtables_tmenu 0/0  drawc 17/20  overlays 3/5  weather 24/25
```
Identical on both runs except `drawc.cpp`, which a peer was mid-edit on; the
failure reproduces with my file REVERTED, so it is not mine (and `byteneutral`
proves drawc's bytes are unchanged by my edit). Every FAIL above is a
pre-existing near-miss on a byte-identical object.
`tu_order_audit.py`: **508 objects, 0 inversions**. `ownmap.py` re-run: unchanged
(this lane touched no data blob).

Commits: `24f4b993`, `ad6a8c87`, `265c8b14` (batches 1-3, explicit paths only).

### 2.7 The 4 that remain — USER-BLOCKED files, exact diffs for the user

| symbol | TU | one-line fix |
|---|---|---|
| `DisplayHelp__FP14tFEApplicationi` | `femenu.cpp` | alias the decl to `DisplayHelp__14tFEApplications` (the parameter is `short`) |
| `DrawBackgroundImage__FP7tScreeniiP18tTexture_ShapeInfoi` | `screenpost.cpp` (via `screenpost_externs.h`) | alias to `DrawBackgroundImage__7tScreeniiP18tTexture_ShapeInfoi` |
| `FETextRender_FullTextRGB__FPcssici` | `screenpost.cpp` | alias to `FETextRender_FullTextRGB__FPcssics` (last parameter is `short`, not `int`) |
| `TextValue__FPv7tPlayer` | `screenpost.cpp` | receiver is the `tListIterator*` passed at the call site — alias to the matching `TextValue__<class>7tPlayer` |

Also for the user: `nfs4_types.h` should declare
`tBlankMenuItemGoToMenuNFS4Button::Draw(bool)` / `Draw(int,int,bool)` and
`tBlankMenuItemNFS4LeftRightChoice::Draw(int,int,bool)` — the current `int` /
`char` spellings are the overloads nothing defines (§2.4).

---

## 3. MISSION 2 — THE TRUE UNDEFINED (84) + THE COMMONS (37)

Classified, not guessed: `scratchpad/w64a19/unres_classified.txt`. **Not landed**
— every one is a data-materialization or storage-shape change inside
byte-matched TUs, where a `.comm`-vs-`.bss` or extern-vs-tentative-definition
choice is exactly the §3.12 #6 gp-rel lever and can regress a match. They need
the owning belt with a gate, not a bulk sweep. The classes and their prices:

### 3.1 Retail-named, defined NOWHERE — 25 (the biggest by reloc count)
`sndgs` (201 relocs), `sndpd` (113), `gPadinfo` (115), `gVoxEvents` (44),
`sndss` (24), `sndpps` (22), `ispch_gChoice` (16), `sndchanreserved` (17),
`sndmm` (13), `gVoxInGame`, `ispch_gPickSamples`, `gEventDats`, `gLastSubTick`,
`sndpp`, `gSentenceChoice`, `gFilterSetting`, `Padglobal`, `gGameNum`,
`gLastTick`, `gDataRate`, `gPreLoadTicks`, `currentwindow`, `memclass`,
`mutexbuf`, `__last_org`.
These ARE in `configs/symbol_addrs.txt` — retail names with known VAs — so the
recipe is exact: read the size from the VA delta to the next symbol and emit one
owned `.bss` definition in the owning TU (`sndgs`/`sndpd` = the sound-driver
state blocks, `gPadinfo` = eaclib pad). ⚠️ every consumer TU of each block must
be re-gated: turning an `extern` into a definition is the documented gp-rel
switch (§3.12 #6).

### 3.2 `DAT_`/`D_` data-mat debt — 16
`DAT_80134a6c DAT_8013bd50 DAT_801478f4 DAT_801479f0 DAT_80147e28 DAT_80148064
DAT_80148448` (7, also **seal-criterion #3 violations** — a Ghidra-ism in code:
`ssysreal.c`, `isqrttbl.c`, `salloc.c`, `sdplapat.c`+`sdriver.c`, `spatkey.c`,
`spchpick.c`×2) plus `D_801489B4` (56 relocs, `drv.c`), `D_80148AC4`,
`D_80148AD4`, `D_801479F0`, `D_80147871`, `D_80147898`, `D_80147A0C`,
`D_80147E34`, `D_8013EAD8`. Recipe: read the bytes at the VA, emit a typed
definition in the owning module, drop the placeholder name.

### 3.3 Project-invented libetc/EA names — 43
11 libetc (`g_dicr_ptr g_dpcr_ptr g_hooks_ptr g_imask_ptr g_istat_ptr g_madr_ptr
g_rcnt_ptr g_vsync_gp1_ptr g_vsync_t1_ptr g_videomode g_intr_timeout` +
`dma_cb`, `vsync_lastcount`) — file-local by nature: define `static` in the
owning TU, or fold the MMIO pointers into `((volatile u_long *)0x1F80…)`
literals (legitimate source form, methodology §3.6).
The rest are EA/game data-mat: `bigBuf` (23 relocs, 5 TUs), `showRoomFlag` (17,
3 TUs), `inputQueue` (15), `_cdr` (34), `_fnt`/`_fnt_active`/`_fnt_count`,
`_cd_cached_dir`, `_cd_search_nopen`, `_first_devname`, `_first_save`,
`_rsincos` (16), `hoff`, `debounce`, `nextTick`, `ticksA`, `output`,
`gSndState`, `g_bootGP`, `systemtasksubs`, `hilight_colors`,
`loading_languageNames`, `FECredits_lastFadeTick`, `CarIO_textureName`,
`iSNDplatformrate`, `_init_pad_flag`, `CD_init`, plus two invented spellings
(`__20tDialogMessageString`, `tScreen_ProcessInput__FP7tScreen…`) that want the
W58-10B CTOR_ALIAS/MEMBER device. `_gp`, `D_80000004`, `D_1000001` are
linker-provided absolutes.

### 3.4 COMMONs — 37, ALL in syslib, full table
`stream.c` 19, `iso9660.c` 3 (`_cd_dir` 1536 B, `_cd_pathtbl` 5632 B,
`_cd_secbuf` 2048 B), `drv.c` 3 (`D_8014899C/A4/AC`, 8 B each),
`streamhelp.c` 3, `stcdint.c` 2, `event.c` 2, `SYS.c` (`_gp1_shadow` 256 B),
`INTR.c` (`g_intr` **4200 B**), `INTR_VB.c` (`vsync_cb` 32 B).
Full listing with sizes: `scratchpad/w64a19/census_recon.txt`.
🔴 **A COMMON is placed by ld, not by the object**, so all 37 land wherever
`*(COMMON)` appears — none of them can reach its retail VA. They must become
real definitions in their owning TU **before** the `.ld` can be byte-faithful.
This is a per-TU gate job (a `.comm` under `-G4`/`-G8` is gp-addressable; a
`.bss` definition may not be — flipping it moves addressing).

---

## 4. MISSION 3 — THE LINKER SCRIPTS

### 4.1 🔴 `linkers/nfs4.ld` — the real defect, and its one-line fix

The W63 record says the script "dies on ~2077 undefined `.L<VA>` jump-table
labels". Re-measured, **none of those messages is an undefined symbol**:

```
`.L80014C3C' referenced in section `.rodata' of build/asm/data/rdata_80010000.rodata.s.o:
             defined in discarded section `.text' of build/src/frontend/common/feapp.c.o
```

The labels **are defined** — in the per-module src object — and the script
**discards that object**: `nfs4.ld` still names only `build/src/front.c.o` and
`build/src/main.c.o`, which are now **952-byte empty shells**, while the src
lane consists of **461 per-module objects**; every one of the other 459 is eaten
by the trailing `/DISCARD/ : { *(*); }`.

Probe (`scratchpad/w64a19/nfs4_src_nodiscard.ld`, repo untouched): narrow
`/DISCARD/` to the metadata sections and add one catch-all placement region —

```
    .src_rest : SUBALIGN(4) { *(.text); *(.rodata); *(.data); *(.sdata); *(.sbss); *(.bss); *(COMMON); }
    /DISCARD/ : { *(.pdr); *(.reginfo); *(.MIPS.abiflags); *(.gnu.attributes); *(.comment); *(.mdebug*); }
```

| | stderr lines | "discarded section" | undefined names |
|---|---|---|---|
| `linkers/nfs4.ld` at HEAD | **1975** | 1975 | 0 |
| the same script, `/DISCARD/` narrowed | **20** | **0** | **2** |

The residual 20 are honest and actionable: `small-data section too large; lower
small-data size limit (see option -G)` plus 18 `R_MIPS_GPREL16` truncations
(`AIDataRecord_WhichRecord`, …) — i.e. the src lane's real next problem is the
`-G` small-data budget, not symbols. **I did not land this**: `linkers/nfs4.ld`
is regenerated by the blob-ownership lane (A18 owns blob regions this wave) and
the two edits would collide. It is a one-line spec plus the per-module object
list, and it retires the 15E "nfs4.ld is DEAD (2077 `.L`)" row.

### 4.2 `linkers/nfs4_recon.ld` — LANDED, and it links for real

`scratchpad/w64a19/gen_ld.py` generates it from
* the **W62-A19 text spine** — each object's base = the mode of
  (retail VA − our section offset) over its text symbols, emitted in base order,
  objects that would drive the location counter backwards dropped;
* the two **W63 `.ldfrag` files** for `.data` (0x8010CCD4) and `.sdata`
  (0x8013C54C), with every remaining recon `.data`/`.sdata` appended so nothing
  is silently dropped;
* trailing catch-alls for `.rodata`/`.bss`/`.sbss`/`COMMON`.

```
objects with text            : 460
  placed (resident .text)    : 440
  DROPPED (interleaved)      :  20
objects with text but NO base:  10
```
(receipts: `scratchpad/w64a19/genld_report.txt`)

Real GNU-ld link of the recon lane (508 recon + 113 asm objects):

| link | stderr | undefined names | multiple definition | reloc truncated |
|---|---|---|---|---|
| strict | 2817 | **402** | 795 | 10 |
| `--allow-multiple-definition` | 1227 | **402** | 0 | 10 |

The 795 multiple definitions are exactly the known blob-vs-TU data-ownership
class (W62-A18 T1) that the W63 region cuts are eating through; they are not a
symbol-naming problem.

⚠️ **`gen_ld.py` must be re-run immediately before every link**: the blob pieces
named by the `.ldfrag`s change under the ownership lane (one run failed on
`data_8010CCD4_r20.data.s.o` that a peer had just removed). Same discipline as
15E's "stale `objdata.json` costs ~1% — run `scan.py` first".

### 4.3 The `.L` decision: **LOCALIZE**, and it is byte-proven

Of the 402 undefined names, **350 are `.L<VA>` jump-table labels** (337 `.word .L`
refs in `rdata_80010000.rodata.s`, 562 in `rdata_80054548.rodata.s`; 54
`jtbl_<VA>` regions).

The decisive evidence — `jtbl_80010078` vs `feapp.cpp.o`'s own `.rodata`:

| blob word | recon `.rodata` word (R_MIPS_32 vs `.text`) | feapp base + offset |
|---|---|---|
| `.L80014C3C` | `0x1c9c` | 0x80012FA0 + 0x1c9c = **0x80014C3C** |
| `.L80014C94` | `0x1cf4` | **0x80014C94** |
| `.L80014CD4` | `0x1d34` | **0x80014CD4** |
| `.L80014D64` | `0x1dc4` | **0x80014D64** |
| `.L80015274` | `0x22d4` | **0x80015274** |
| `.L800150D0` | `0x2130` | **0x800150D0** |
| `.L80015274` | `0x22d4` | **0x80015274** |
| `.L8001537C` | `0x23dc` | **0x8001537C** |

**8 of 8 identical.** The recon TU *already emits the same jump table* into its
own `.rodata`; the blob's copy is a duplicate and its `.L` operands are
unresolvable only because the recon switch's labels have different names.

⇒ **Do NOT emit `.L` labels into the src-lane objects.** Cut the `jtbl_<VA>`
regions out of the two rodata blobs exactly as W63 cut `sdata_8013C54C` /
`data_8010CCD4` (`_jNN` pieces linked by the SPLAT lane only), and let each
recon TU's own `.rodata` supply its table — the same blob-vs-TU ownership
decision, with the `.L` operand as the machine-readable tell for which region
belongs to which TU.

Quantified without touching the repo blobs
(`scratchpad/w64a19/jtbl_probe.py` writes size-preserving copies with every
`.word .L…` replaced by `.space 4`, assembles them and relinks):

```
[recon lane, jump-table axis localized] undefined-names = 52,  of which .L = 0
```

**402 → 52**, and the 52 are *exactly* the mission-2 true-undefined set (45
named + 7 `DAT_`). So after the jtbl cut and the §3 data-mat, the recon lane's
unresolved list is empty — nothing else stands between here and a resolving
recon-lane link.

---

## 5. TOOLS LEFT BEHIND (all in `scratchpad/w64a19/`, promote-worthy)

| file | what it does |
|---|---|
| `census.py` | batched, reloc-filtered, exact-name symbol census of either lane (recon/src) → `census_<lane>.{txt,json}` |
| `classify.py` | splits the unresolved set into ALIAS / IN_SYMADDRS / ORPHAN with per-symbol candidates and referencing objects |
| `apply_alias{,2,3}.py`, `resolve_ambig{,2}.py` | the empirical alias lander (recompile-and-verify per candidate declaration) |
| `byteneutral.py` | section-byte A/B of an agent's whole edit set across every affected TU — the proof that a declaration-only landing moved no code |
| `gateall.py` | `tugate` sweep over exactly the TUs an edit set can reach |
| **`gen_ld.py`** | generates `linkers/nfs4_recon.ld` and links it for real (strict + multdef-ok), with the spine/exclusion report |
| `jtbl_probe.py` | prices the `.L` jump-table axis without touching the repo blobs |
| `ownership.py`, `difftouched.py`, `myfiles.py` | concurrency hygiene: which working-tree changes are mine vs a peer's, before staging |
