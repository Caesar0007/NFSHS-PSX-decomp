# W65-A6 — THE DATA-MATERIALIZATION BELT

Repo `C:\Temp\nfs4-decomp`, wave W65, 2026-08-15. Every number below was measured by me
(`tools/tugate.py`, `tools/tu_order_audit.py`, `scratchpad/w65a6/census.py`), never quoted
from a briefing. Peers landed continuously through the run; all baselines were re-measured.

---

## 0. HEADLINE

| axis | briefed (W64-A19) | measured at start | after this belt |
|---|---|---|---|
| reloc-referenced **undefined**, recon lane | 84 | **82** | **18** |
| reloc **sites** behind them | — | **1077** | **141** |
| **COMMON** symbols | 37 | **37** | **1** (parked, §5) |
| `DAT_`/`D_` seal-criterion #3 violations in code | 7 | 7 | **1** (`debug_cause`'s host TU; §5) |
| PASS→FAIL regressions | — | — | **0** |
| `tu_order_audit` | 0 inversions | 0 | **0** (508 objects) |

**64 symbols closed** across 4 committed batches
(`cd0c6f64` content¹, `deae02d7`, `6a848896`, `055f6550`).

¹ batch 1's *content* was swept into peer commit `cd0c6f64` by a concurrent `git add -A`
(the 15F "a peer git add -A swept another agent's work" hazard, this time in reverse: my
`git commit` then had an empty index and exited 1). The code is in git; only the message is
not. The full batch-1 message is reproduced in §7.

---

## 1. THE THREE ROOT CAUSES (all mechanical, all now named)

The 84 "true undefined" and the 37 COMMONs were never one problem. They are three:

**(a) A whole storage class was never emitted.** 23 retail-named blocks + 12 project/`D_`
names were `extern`-declared in 1..30 TUs and **defined nowhere**. Every one sits at
VA > `t_addr + t_size` = **0x8013E000** (PS-X EXE header: `t_addr=0x80010000`,
`t_size=0x12E000`), i.e. beyond the file — **pure zero-init BSS with no retail bytes to
decode**. That is why a data-mat pass that reads bytes from the image never produced them.

**(b) `__attribute__((section(".bss")))` is INERT on the cc1_272 lane — and it is the sole
cause of all 37 COMMONs.** gcc-2.7.2 emits an uninitialised file-scope object as
`.comm NAME,size` *regardless of the section attribute*, and syslib compiles with **no
maspsx**, so nothing rewrites the `.comm`. Four TUs (`stream.c`, `stcdint.c`, `streamhelp.c`,
`event.c`) carry an `ST_BSS` macro with a comment explaining an effect that never happened;
`SYS.c` and `INTR.c`/`INTR_VB.c` the same idea inline. A COMMON is placed by **ld**, not by
the object, so none of the 37 could ever reach its own breadcrumb VA.

**(c) A third of the "undefined" list was already defined — under another name.** Their VAs
are *inside* the initialised image and the splat blobs emit the bytes under a `D_<VA>`
dlabel; only the spelling differed (`DAT_80134a6c` vs `D_80134A6C` = the casing-phantom
class, methodology gotcha #17), or the recon used the PsyQ-sourced name
(`_cd_search_nopen` vs `D_80136C6C`). Four of these were **worse than undefined**: a
tentative def had turned them into a COMMON that would have shadowed real image data with
zeros — `g_intr` (4200 bytes!), `vsync_cb` (32), `CD_cbread`, `CD_read_dma_mode`.

---

## 2. THE DEVICE MENU (which spelling, and why)

Four devices, chosen per symbol. The gate result is the arbiter; every choice below was
measured, and the two rejected ones are receipted in §6.

| # | device | when | why |
|---|---|---|---|
| 1 | **C tentative definition** `T x;` | the existing decl already has a **complete type** AND size > the TU's `-G` | cc1's view is bit-identical, so codegen cannot move. Used for `gPadinfo`/`Padglobal` (pad.c) and `sndmm` (smemman.c). Under maspsx a `.comm` larger than `-G` becomes a real `.section .bss` + `.globl` + `.space` definition. |
| 2 | **file-scope asm `.section .bss`** + `.globl` | everything else | The C view stays `extern`, so the storage is **byte-neutral by construction**. Required whenever (i) size ≤ the TU's `-G` — maspsx routes such a `.comm` into `.section .sbss` **without** the `.globl` guard, producing a LOCAL symbol that fixes nothing *and* flipping cc1 to gp-relative addressing; or (ii) the decl is an **unsized array**, a documented codegen lever (§3.12 #5 / §3.15-CORRECTION). |
| 3 | same, **without `.globl`** | the SYM records the symbol as **type 6 = STATIC** | reproduces retail's static binding exactly while still resolving the owning TU's references. `systemtasksubs`, `inputQueue`. |
| 4 | **asm-label alias** `extern T x __asm__("D_<VA>");` | storage already emitted by a splat blob | only the relocation NAME changes; no blob-vs-TU duplicate (W62-A18 class M1). 20 symbols. |

**The gp-rel gate was checked, not assumed.** For every symbol ≤ `-G` the oracle was grepped
for `%gp_rel(SYM)`: **zero hits, all of them** (`grep -rl '%gp_rel(S)' asm/nonmatchings/`),
i.e. retail addressed them absolutely — which is exactly what device 2 preserves and what a
tentative def would have destroyed (§3.12 #6 ownership rule, applied in the *negative*
direction).

**Interior aliases are LABELS, never `sym = base+N`.** ASPSX 2.77, the production assembler,
has no symbol-assignment form (catalog 15E), so a second label at the right offset is the only
dual-legal spelling.

---

## 3. THE BIG FINDING: 10 undefined `DAT_`/`D_` names are not objects

They are **fixed offsets inside the retail-named blocks**, which is precisely why nothing ever
defined them. Emitting them as extra labels closes them and retires 4 of the 7 seal-criterion
#3 violations at the same time:

```
D_80147871   = sndgs   + 0x11    D_80147898 = sndgs + 0x38   DAT_801478f4 = sndgs + 0x94
D_801479F0 = DAT_801479f0 = sndpd + 0xD8    D_80147A0C = sndpd + 0xF4
DAT_80147e28 = sndpd   + 0x510   D_80147E34 = sndpd + 0x51C
DAT_80148064 = gVoxEvents + 4    DAT_80148448 = gSentenceChoice + 0xC
gRepeatCount = gVoxInGame  + 4
```

The `sndgs`/`sndpd` interiors were already *documented in-source* as such
(`salloc.c`: "channel-pool pointer (sndgs + 0x94)") — the offsets were known, only the
storage was not.

---

## 4. LEDGER — 64 symbols, every one gated

Ownership is evidence-based. Where exactly one recon TU references a symbol, that TU is the
owner (sole-referencer evidence). Where several do, the decider is the **interleaving
argument**: ld places whole object sections, so symbols that alternate in VA between two TUs'
reference sets provably came from **one** retail object, and the owner is picked by reference
count. Every size is a SYM/`symbol_addrs` VA delta, and every run below is *fully accounted*
(the arithmetic closes on the next known symbol) unless flagged.

### 4.1 eaclib BSS blocks — batch 1 (`cd0c6f64` content)

| symbol(s) | VA | size | owner TU | device | gate before → after |
|---|---|---|---|---|---|
| `gPadinfo`, `Padglobal` | 0x8013E89C | 84, 16 | `eaclib/psx/pad.c` | 1 | 4/5 → 4/5 |
| `memclass` | 0x8013E900 | 64 | `eacpsxz/inittmr.c` | 2 | 4/4 → 4/4 |
| `sndss`, `sndStreamMap` | 0x8013EA80 | 4, 4 | `sndpsxz/sst.c` | 2 | 16/16 → 16/16 |
| `mutexbuf` | 0x801477E0 | 128 | `eacpsxz/callback.c` | 2 | 2/2 → 2/2 |
| `sndgs` (+3 interiors) | 0x80147860 | 180 | `sndpsxz/ssysinit.c` | 2 | 4/4 → 4/4 |
| `sndchanreserved` | 0x80147914 | 4 | `sndpsxz/salloc.c` | 2 | 4/4 → 4/4 |
| `sndpd` (+5 interiors) | 0x80147918 | 1836 | `sndpsxz/slib.c` | 2 | 5/5 → 5/5 |
| `gPreLoadTicks`,`gEventDats`,`gVoxInGame`(+`gRepeatCount`),`gVoxEvents`(+`DAT_80148064`) | 0x80148044 | 996 | `spchpsxz/spchevnt.c` | 2 | 16/16 → 16/16 |
| `gGameNum`,`gFilterSetting`,`gLastSubTick`,`gDataRate`,`gLastTick` | 0x80148428 | 20 | `spchpsxz/spchinit.c` | 2 | 7/7 → 7/7 |
| `gSentenceChoice`(+`DAT_80148448`),`ispch_gPickSamples`,`gChooseShort`,`ispch_gChoice` | 0x8014843C | 312 | `spchpsxz/spchpick.c` | 2 | 27/27 → 27/27 |
| `sndpps` | 0x80148574 | 4 | `sndpsxz/spktplay.c` | 2 | 13/13 → 13/13 |
| `sndpp` | 0x80148578 | 52 | `sndpsxz/sdpacket.c` | 2 | 13/13 → 13/13 |
| `windowbuf`, `currentwindow` | 0x801485AC | 312, 156 | `eacpsxz/movf.c` | 2 | 1/1 → 1/1 |
| `sndmm` | 0x80148780 | 524 | `sndpsxz/smemman.c` | 1 | 4/4 → 4/4 |

Consumer spot-check, all unchanged: sdriver 4/4, sdplapat 1/1, spatkey 10/10, sdmemman 2/3
(pre-existing 97.76% `iSNDpsxmalloc`), sdtimrem 1/1, spvoices 4/4, fastmovf 1/1, spchrand 4/4,
spchbank 8/8, sdma 6/6.

⚠ `sndmm` size = `sizeof(SNDMemState)` = 524; the VA delta to `D_8014899C` is 540, so **16
trailing bytes are unattributed** — recorded, not invented.

### 4.2 the 37 COMMONs — batch 2 (`deae02d7`)

| TU | symbols | run(s) | gate |
|---|---|---|---|
| `libcd/stream.c` | 21 `St*`/`CChannel` | 0x80144874 (8 B) · 0x80146C7C (72 B) · 0x801489CC (4 B) | 3/3 → 3/3 |
| `libcd/iso9660.c` | `_cd_dir` 1536, `_cd_pathtbl` 5632, `_cd_secbuf` 2048 | 0x8014487C, 9216 B | 4/6 → 4/6 |
| `libcd/drv.c` | `D_8014899C/A4/AC` + `D_801489B4/B8/BC` | 0x8014899C, 36 B | 11/13 → 11/13 |
| `libcd/streamhelp.c` | `_ds_word0/_ds_word1/_ds_ready_cb` | 0x801489D0 (+8 B gap) | 5/6 → 5/6 |
| `libcd/stcdint.c` | `_st_slot` | 0x80144864 | 1/3 → 1/3 |
| `libgpu/SYS.c` | `_gp1_shadow` 256 (+ `D_8013EAD8` 32) | 0x8013EAD8, 288 B | 39/44 → 39/44 |
| `libetc/INTR.c` | `g_intr` 4200 | → alias `D_80134AF8` | 10/13 → 10/13 |
| `libetc/INTR_VB.c` | `vsync_cb` 32 | → alias `D_80137CF0` | 4/4 → 4/4 |
| `libcd/event.c` | `CD_cbread`, `CD_read_dma_mode` | blob already defines them **under these exact names** → demoted to `extern` (also removed a blob-vs-TU double definition) | 5/5 → 5/5 |

🔑 **The `iso9660` run is doubly pinned, so its sizes are proven and not assumed**: it starts
at `StFunc2`+4 and `1536+5632+2048 = 9216` lands *exactly* on `StEmu_Addr` @0x80146C7C. That
also explains why the SYM has no record for these three — PSYLINK gave COMMONs no symbol
entries, which is independent evidence that they were COMMON in retail too.

Same batch, the casing/name-only class: `DAT_80134a6c`→`D_80134A6C` (ssysreal.c, 2/2),
`DAT_8013bd50`→`D_8013BD50` (isqrttbl.c, 2/2), `_cd_search_nopen`/`_cd_cached_dir` →
`D_80136C6C`/`D_80136C68` (iso9660.c).

### 4.3 the blob-alias sweep — batch 3 (`6a848896`) and batch 4 (`055f6550`)

13 syslib + 7 game/frontend symbols aliased to the blob label that already defines their VA:

```
INTR.c   g_hooks_ptr D_80135B80 · g_istat_ptr D_80135B84 · g_imask_ptr D_80135B88
         g_dpcr_ptr  D_80135B8C · g_intr_timeout D_80135B90
INTR_DMA g_dicr_ptr  D_8013BD20 · g_madr_ptr D_8013BD44
VSYNC    g_vsync_gp1_ptr D_80134A88 · g_vsync_t1_ptr D_80134A8C · vsync_lastcount D_80134A94
INTR_VB  g_rcnt_ptr  D_80137D14        FONT  _fnt_count D_80135FD8 · _fnt_active D_80135FDC
simqueue output D_8013DDC8 · psxcontroller hoff D_8013DAC0 · cario CarIO_textureName D_8011E804
drawc hilight_colors D_8011F4B4 · loading loading_languageNames D_80120D00
feinput nextTick D_80051738 · debounce D_80052B60
```

For the 7 game/frontend rows the SYM supplies **both** the VA and the retail size
(`96 Def2 class STAT type ARY … size N`), so each alias was verified against a typed record,
not a bare address: `output` ARY STRUCT size 8 · `hoff` ARY INT size 8 ·
`CarIO_textureName` ARY STRUCT size 612 · `hilight_colors` ARY ULONG size 20 ·
`loading_languageNames` ARY PTR CHAR size 24.

⚠ **W64-A19 §3.3's recipe for the 11 `g_*_ptr` names ("project-invented, file-local by
nature → define them `static` in the owning TU") would have been wrong for these.** They are
not invented storage; they are real in-image data the blob owns, and a `static` definition
would have shadowed it with a private copy. The recipe still stands for the four that
genuinely have no dlabel (§5).

### 4.4 BSS materialization, batch 4

| symbol | VA | size | owner | binding | gate |
|---|---|---|---|---|---|
| `_first_save`, `_first_devname` | 0x80148A7C | 8, 40 | `libapi/FIRST.c` | global | 1/2 → 1/2 |
| `D_80148AC4` | 0x80148AC4 | 4 | `libcard/PATCH.c` | global | 4/4 → 4/4 |
| `D_80148AD4` | 0x80148AD4 | 4 | `libcard/END.c` | global | 1/1 → 1/1 |
| `systemtasksubs` | 0x8013E980 | 256 | `eacpsxz/systask.c` | **local (SYM type 6)** | 3/3 → 3/3 |
| `inputQueue` | 0x8013E0F4 | 524 | `game/common/simqueue.cpp` | SYM type 6 | 7/8 → 7/8 |

🔑 **The SYM's record type is the ownership oracle for statics.** `6` = STATIC ⇒ the symbol is
a file-static of exactly one object, which is *why* nothing else could define it. Both were
emitted with no `.globl`. (`systemtasksubs` comes out `b` = local as intended; `inputQueue`
comes out `B` in the C++ lane — noted, harmless, no competing definition.)

---

## 5. STILL OPEN — 18 undefined + 1 COMMON, each with its reason

* **4 are linker-provided absolutes, not data — do NOT materialize them:** `_gp`,
  `__last_org` (= the SYM's `endofcode` @0x80148B04, the bss end marker `2mbyte.c`'s heap init
  reads), `D_80000004`, `D_1000001`.
* **7 are in-image data with NO dlabel at their VA** — nothing to alias to; the blob must be
  cut first (data-ownership lane's files, actively edited by a peer this wave):
  `_cdr` @0x8013C290 (34 sites — see §6), `_rsincos` @0x80137D20 (16), `_fnt` @0x80135E58 (8),
  `dma_cb` @0x80106878 (6), `g_videomode` @0x800F1784 (6), `g_bootGP` @0x800EB080 (2),
  `CD_init` @0x80108140 (1). ⚠ several of those VAs fall in `.text` ranges — they are
  code-adjacent constants, so classify per methodology §3.9b **before** cutting.
* **5 need a VA determination first:** `bigBuf` (23; SYM says EXT @0x80010000 = the overlay
  load buffer base, so almost certainly a `.ld` symbol rather than storage), `showRoomFlag`
  (17; SYM EXT @0x80051260, front overlay, no dlabel), `gSndState` (8), `ticksA` (4),
  `FECredits_lastFadeTick` (4).
* **2 are invented ctor/flattened-method spellings** wanting the W58-10B CTOR_ALIAS device:
  `__20tDialogMessageString`, `tScreen_ProcessInput__FP7tScreen…`.
* **The last COMMON, `debug_cause` @0x80136AE0** (stcdint.c), is in-image data the blob emits
  but *inside a larger dlabel run*, so there is no name to alias to. It is left as a COMMON
  **deliberately**: demoting it would only convert a COMMON into an undefined symbol. Exact
  follow-up recorded in-source — cut a `dlabel D_80136AE0` in
  `asm/data/data_8010CCD4_r17.data.s`, then the line becomes
  `extern int debug_cause __asm__("D_80136AE0");`.

---

## 6. FALSIFIED — receipted so nobody re-fights them

1. 🔴 **`__attribute__((section(".bss")))` on a 4-byte global does not produce a global .bss
   symbol.** Probed on `sndchanreserved` in `salloc.c`: the symbol stays **local** (`b`) and
   the TU goes **4/4 → 2/4** (`iSNDallocchan` 65 diffs, `iSNDischanreserved` 4). A plain C
   tentative definition of the same symbol is identical (local, 2/4). Only the file-scope asm
   form is both global and byte-neutral. *This is the same attribute the four syslib `ST_BSS`
   macros relied on — it has never worked in this tree.*
2. 🔴 **The blob alias on `_cdr` is NOT byte-neutral, uniquely.** `extern volatile CdrEnv _cdr
   __asm__("D_8013C290");` costs `cdread.c` **3/6 → 2/6** (`CdReadSync` PASS→FAIL, 2 diffs),
   measured twice, other residuals unmoved. **Reverted**; receipt left in `cdread.c` with the
   mechanism hypothesis (this is the TU built on a `volatile` state block, so the
   volatile-MEM ordering class is the suspect) and the recommended next attempt: rename the
   **blob label** to `_cdr` (oracle-side, zero effect on this object) instead of aliasing the
   C declaration. The identical device was zero-delta on the other 20 symbols.

---

## 7. FOR THE LINK LANE (A5) — three concrete hand-offs

### 7.1 🔴 `linkers/undefined_syms_auto.txt` now shadows **132** real definitions

A linker-script assignment **beats** an object definition, so every one of these rows
silently orphans the storage behind it. 52 of the 132 are symbols this belt just defined; the
other **80 were already stale before this wave** (`_que`, `readcmd`, `currentdirectory`,
`_waitTime`, `_startTime`, and 75 `D_<VA>`/named rows at lines 13-80) — i.e. this is a
pre-existing systemic defect that the belt merely made measurable. This is exactly the
"ld-provided absolute whose VA is also covered by a real definition" class W62-A18 §3 said
must be re-checked after every `.ld` regeneration.

Exact line numbers: `python scratchpad/w65a6/stale_absolutes.py` (re-run it — it reads the
live census, so it stays correct as more symbols land). I did not edit `linkers/`: it is A5's
file this wave.

### 7.2 Runs that one object cannot reproduce

`stream.c`'s 21 symbols form **three disjoint retail runs** (0x80144874 / 0x80146C7C /
0x801489CC) and `streamhelp.c`'s form **two** (0x801489D0 and 0x801489E4, the latter being
`GlobalCallback`+4). One object's `.bss` is contiguous, so retail's LIBCD split them across
objects our TUs merge. Every run's base VA and byte count is recorded in-source at the
definition; splitting the TU (or per-run sections) is a placement decision, not a
symbol-definition one.

### 7.3 Placement is now trivial for everything else

Each object's `.bss` reproduces its retail run **byte-for-byte** — verified with `nm` after
every landing: `gPadinfo`@0 `Padglobal`@0x54 · `sndss`@0 `sndStreamMap`@4 · `sndgs`@0
`D_80147871`@0x11 `D_80147898`@0x38 `DAT_801478f4`@0x94 · `sndpd`@0 `D_801479F0`@0xD8
`D_80147A0C`@0xF4 `DAT_80147e28`@0x510 `D_80147E34`@0x51C · the three spch runs · the drv
36-byte run · `_cd_dir`@0 `_cd_pathtbl`@0x600 `_cd_secbuf`@0x1C00 · `D_8013EAD8`@0
`_gp1_shadow`@0x20. The `.ld` only has to place the object base.

---

## 8. TWO LATENT BUGS FIXED ON THE WAY (gate-invisible, correctness)

1. **`sst.c`'s `unsigned char sndStreamMap[64]` overran its retail run by 60 bytes** — into
   `gFileMgr`/`gFileDevice`'s storage @0x8013EA88. Retail: `sndss` 4 + `sndStreamMap` 4 = 8
   bytes, ending exactly at `gFileDevice`. In a recompiled image, writes past index 3 would
   have corrupted the file manager.
2. **`spchinit.c`'s `int gRepeatCount;`** was an *unreferenced* tentative definition → a
   private 4-byte LOCAL `.sbss` object at an address retail does not have. Retail's
   `gRepeatCount` **is** `gVoxInGame+4`; it is now an interior label of that run in
   `spchevnt.c`, and the stale definition is gone (deleting an unreferenced `.comm` is
   codegen-neutral: 7/7 PASS both sides).

Plus the four COMMON-over-real-data cases of §1(c), of which `g_intr` is the serious one:
4200 bytes of the retail image would have been shadowed by a zero-filled COMMON.

---

## 9. CATALOG-ROW CANDIDATES (orchestrator harvests; the memory dir is read-only to me)

1. **`section(".bss")` IS INERT for an uninitialised object on gcc-2.7.2/2.8** — it never
   prevents `.comm`. Any in-source claim that it "pins the symbol to regular .bss" is false;
   on the maspsx lane the `.comm` is rewritten to real `.bss` *by maspsx*, which is what made
   the idiom look like it worked. Detection: `nm` shows `C`. (Falsification receipt: §6.1.)
2. **maspsx's `-G` routing is the hidden gate on tentative definitions**: `.comm` with
   `size <= -G` → `.section .sbss` **without** the `.globl` guard = a LOCAL symbol (and cc1
   goes gp-relative); `size > -G` → `.section .bss` **with** `.globl` = a real global
   definition. So "define the global in its owning TU" only works above the `-G` threshold;
   below it, the file-scope asm `.bss` block is the only spelling that is both global and
   byte-neutral.
3. **The `D_<VA>` interior-label device**: an undefined `DAT_`/`D_` name whose VA lies inside
   an already-known block is not a missing object — emit it as an extra LABEL at its offset
   inside that block's `.bss`/data run. Never `sym = base+N`: ASPSX has no symbol-assignment
   form. 10 symbols closed this way, 4 seal-criterion violations retired.
4. **SYM record type 6 = STATIC is the ownership oracle for an undefined data symbol** — it
   names the single object that can define it, and it says the definition must be emitted
   **without** `.globl`.
5. **The interleaving argument decides multi-referencer ownership**: ld places whole object
   sections, so symbols that alternate in VA between two TUs' reference sets provably came
   from one retail object; the reference count then picks the owner. (Used for the three spch
   runs and the sndgs/sndchanreserved/sndpd run.)
6. **A doubly-pinned run proves its own sizes**: `iso9660`'s three buffers were sized from
   nothing but the two endpoints and the sum closing exactly — a technique for any COMMON
   whose VA the SYM omits.

## 10. HAZARDS ENCOUNTERED

* **Heredoc backslash collapse fired once** (bash `<<'PY'` collapsed `\\t`/`\\n` inside a
  quoted heredoc, planting real tabs/newlines into a C string literal). Everything
  escape-bearing after that went through the Edit tool or a Write-tool script.
* **A peer's `git add -A` swept batch 1 into commit `cd0c6f64`** before my own commit ran
  (which then exited 1 on an empty index). Batches 2-4 were staged and committed in one step
  to shrink the window.
* **`build/**` churns under concurrent belts**: `cdread.c` once failed to compile from a
  clean, unmodified checkout and compiled again a minute later. Every regression in this
  ledger was reproduced twice before being believed (and the `_cdr` one was).
* **Mixed line endings inside single files** (drv.c, INTR.c, SYS.c, streamhelp.c are ~50/50
  CRLF/LF) — pre-existing, verified against the backups; the appliers work in byte mode.
* Backups of every touched file: `scratchpad/w65a6/bak/`.

## 11. TOOLS LEFT BEHIND (`scratchpad/w65a6/`)

| file | what it does |
|---|---|
| `census.py` | reloc-filtered, exact-name, batched symbol census of the recon lane (from W64-A19; the belt's acceptance sheet) |
| `plan.py` | classifies every remaining unresolved symbol: recovers its VA from `symbol_addrs` or an `@0xVA` breadcrumb, splits **BSS vs in-image**, and looks the VA up in a full index of splat blob `dlabel`s → tells you instantly whether the answer is "materialize" or "alias" |
| `alias.py`, `alias2.py` | the alias landers (byte-mode, size-grew assert, `os.replace`, endings preserved; refuse any symbol with ≠ 1 matching declaration) |
| `stale_absolutes.py` | **promote-worthy**: every `linkers/undefined_syms_auto.txt` row that now shadows a real definition, with line numbers. Should be a standing gate — it is the class that silently freezes a datum at a stale address. |
| `bak/` | pre-edit copy of every touched file |
