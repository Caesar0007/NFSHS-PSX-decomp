# WAVE-46 a9 receipts — game/psx round 8 fresh modules

Base `6a43ac79`, branch `w46-a9`. Gate = `python tools/verify_asm.py <tu> <MANGLED,...>`.

## 0. Ledger (re-gated baseline -> final)

| fn | worklist fuzzy | RE-GATED baseline | final | note |
|---|---|---|---|---|
| Weather_ChangeDensityBasedOnTime | 99.91% | **PASS** | PASS | worklist row was stale — already sealed |
| Weather_ChangeIntensityBasedOnTime | 97.98% | 4 (62/62) | **PASS** | |
| Weather_Init | 98.01% | 12 (211/211) | 12 | not attacked |
| Weather_CreateSnow | 92.50% | 10 (108/108) | **PASS** | |
| Weather_CreateRain | 88.94% | 16 (113/113) | 16 | receipt + new angle |
| Weather_CreateSplat | 89.11% | 6 (74/74) | **PASS** | |
| Weather_DoSplats | 96.84% | 36 (111/113) | 36 | receipt + new angle |
| Weather_DoWeather | 93.98% | 46 (197/197) | **42** | |
| Night_CreateNightTableElement | 91.11% | 56 (113/113) | 56 | not attacked |
| Night_SetCopColor | 91.76% | 5 (38/37) | **2 (37/37)** | count now exact |
| Night_SetEnviroment | 99.71% | 8 (68/68) | 8 | receipt + new angle |
| Night_AdditiveNightCalc | 83.25% | 71 (65/64) | 71 | not attacked |
| CarIO_ReadInCarTextureData | 99.04% | 186 (491/491) | 186 | not attacked |
| CarIO_UpdateCarTextureData | 97.04% | 25 (301/298) | 25 | not attacked |
| CarIO_CopyToShape | 87.40% | 6 (40/42) | **4 (42/42)** | count now exact |
| CarIO_CreateLicense | 88.22% | 104 (229/229) | 104 | not attacked (a10 lane) |
| Sfx_AdditivePrim | 95.75% | 38 (126/126) | 38 | not attacked |
| Sfx_BuildSouffleFacet | 98.09% | 116 (938/938) | 116 | not attacked |
| Fog_InitFogTriggers | 98.95% | 2 (57/57) | **PASS** | killed a w41 "STRONG floor" |
| CV_ColorTracks | 98.45% | 72 (130/130) | 72 | not attacked |
| Fe3D_InitShowroom | 93.19% | 24 (107/107) | **14 (105/107)** | |
| HrzSetPsxMatrix | 68.80% | 62 (52/56) | 62 | not attacked |
| Hrz_InitSky | 99.76% | 16 (209/209) | 16 | receipt + new angle |
| Horizon_InterpolateLineSCoords | 98.94% | 26 (80/80) | **PASS** | |
| Hrz_BuildSky | 93.19% | 390 (458/458) | 390 | not attacked |
| Hrz_BuildHorizon | 92.15% | 214 (477/473) | 214 | not attacked |

**PASS this wave: 5** (ChangeIntensityBasedOnTime, CreateSnow, CreateSplat, Fog_InitFogTriggers,
Horizon_InterpolateLineSCoords) + 1 already-PASSing row the worklist mis-reported.
**Improved: 4** (SetCopColor 5->2, CopyToShape 6->4, InitShowroom 24->14, DoWeather 46->42).

## 1. THE WAVE'S UNIFYING LEVER — the ZERO-BYTE USE FENCE has THREE distinct jobs

`__asm__ __volatile__("")` (no operands) and `__asm__ __volatile__("" : : "r"(local))`
(reg-resident local) both emit **zero instructions** but are real RTL insns. Three
independent mechanisms, all landed this wave:

1. **REF INFLATOR at the local-alloc QTY layer** — one fence = one `REG_N_REFS` reference,
   loop-weighted inside a loop, enough to cross a `floor_log2` step.
   *Fog_InitFogTriggers 2->PASS* (counter vs address giv, the w41 "STRONG floor"),
   *Horizon_InterpolateLineSCoords 26->PASS* (counter 4 refs vs pointer 5 refs).
   This is the practical instrument for w45 §A0 (`QTY_CMP_PRI == allocno_compare`).
2. **CROSS-JUMP DE-MERGER** — breaks two arms' tail rtx equality at zero byte cost, so
   retail's duplicated tail returns. *Weather_ChangeIntensityBasedOnTime 4->PASS*
   (killed a w42 "STRONG" verdict that said no C spelling could differ the tails),
   *CarIO_CopyToShape 6->4 count-exact*.
3. **SCHED-ISSUE-POSITION FIXPOINT** (the already-catalogued w45 use) — *Weather_CreateSplat*,
   *Weather_CreateSnow*.

⚠️ It is NOT universal: a fence is **catastrophic** in `Weather_CreateRain` (16 -> 104)
and costs +1 insn wherever the local is not already reg-resident. Gate every placement.

## 2. THE PACKET-EMISSION RECIPE (3-part, now proven on 3 emitters)

For an OT-link header emitter (`prim = PACKETPTR; tag merge; bump; palette RMW`):
1. **fence** right after the header/tag store (pins the bump's `addiu` below it);
2. **SPLIT the bump** into a value statement (`u_char *next = (u_char*)prim + N;`) and its
   store;
3. **SPLIT the palette RMW** (read `palw` first) and put the **cursor store INSIDE** it,
   between the palette read and the addr24 mask.

`Weather_CreateSplat` 6->PASS, `Weather_CreateSnow` 10->PASS, `Weather_DoWeather` 46->42
(fence negative there — parts 2+3 only). **Does NOT transfer to two-armed emitters**
(`Weather_CreateRain`, 8 variants all >= baseline) — see §4.

## 3. Other levers landed

- **volatile-cast deref defeats a load hoist** (`Night_SetCopColor` 5 -> 2, count 38->37
  exact): a plain `arr[i]` ARRAY_REF of a *stack local* is provably non-aliasing with a
  gp-rel global store, so gcc hoists the load above the store and fills its load-delay slot
  — one insn SHORT of retail. `*(T *volatile*)&arr[i]` cannot be reordered, the store issues
  first, and the oracle's load-delay `nop` reappears.
- **Nested-shift spelling controls SHIFT ISSUE ORDER** (`Fe3D_InitShowroom` 24 -> 14):
  `(x<<5)+(x<<4)` evaluates the `<<5` first into `$v0` — where a call result already lives —
  forcing a save copy. `((x<<4)<<1)+(x<<4)` makes the `<<4` a real cse'd subexpression that
  issues first, killing the copy. Reversing the addends does nothing (cc1 canonicalizes
  commutative operands).
- **Honest index form for a byte-offset table read** (`Weather_CreateSnow` last 2 diffs):
  `gWeatherPixmap[((int)pt & 4) >> 2]` instead of `*(T**)((char*)tbl + ((int)pt & 4))`
  puts the table `la` before the mask like retail.

## 4. Parked, with RECEIPT BAR + NEW NAMED ANGLE (in-source at each fn)

- **Weather_CreateRain 16** — the §2 recipe falsified in 8 variants; the fence is
  catastrophic because the header is emitted from TWO ARMS and the barrier stops them
  scheduling alike. *Angle:* fix the ARM structure first (hoist the whole prim/pal/header/
  bump group above the `if (*wd)`, or deliberately de-merge with per-arm data-label address
  forms), then the single-site emission dials apply unchanged.
- **Weather_DoSplats 36 (111/113)** — 3 more falsifications (hold-global-addr across the
  loop 59/118; USE fences on `num` 37/112 and `splats` 41/112). *Angle:* attack
  `combine_givs`, not the register file — `-dL` prints the giv-worth decisions and the w43
  budget razor is a 1-RTL-insn dial; add exactly one RTL insn with a store-then-read-back.
- **Night_SetEnviroment 8 (68/68)** — 14 further spellings, all >= 8. The ref dial *does*
  reach the two quantities (inflating the target pointer moved it 8->10/12) but in the wrong
  direction, so the reachable side is the CONSTANT; every `do{}while(0)` inflator here costs
  +1 insn because its `NOTE_INSN_LOOP_BEG` splits the store group. *Angle:* a zero-insn ref
  ADD on the `0x80` value (a second consumer cse folds), after reading the two qty priorities
  off `-dl`/prio.py and `reqdelta --want` the swap.
- **Hrz_InitSky 16 (209/209)** — the REF axis is now proven CLOSED in both directions
  (+1 fence = 25 worse; splitting k across the two loops = 36 worse; splitting j = 78), and
  live-lengthening by a trailing fence has no effect (flow.c will not extend a dead value's
  range). *Angle:* LIVE LENGTH via real dataflow — k needs live 100 -> >172 at 19 refs, i.e.
  birth in the prologue region with a cse-folded seed use; or raise sin's/height's priorities
  instead of lowering k's.
- **Fe3D_InitShowroom 14 (105/107)** — the residual is retail's surviving *copy* of the
  sign-extend (`sll $v1,$s3,16; addu $a2,$v1,$zero` + two `sra`s). Every two-local copy
  spelling is copy-propagated away. *Angle:* per make_regs_eqv the copy must OUTLIVE its
  source; both consumers are inside one iteration, so sink the `.z` consumer past the second
  `sVar4++` so the old index genuinely survives a redefinition of its source.
- **Fog_InitFogTriggers / Weather_ChangeIntensityBasedOnTime** — two "STRONG floor"
  receipts were DEAD. Both were correct measurements with a missing instrument.

## 5. Tools committed here

`scratch/probe.py` (single-anchor in-place variant probe), `scratch/probe2.py`
(multi-anchor `PAIRS`), `scratch/probe3.py` (`PAIRS` with an expected occurrence COUNT —
needed for two-armed functions), `scratch/sbs.py` (ours|oracle side-by-side with a variant
applied). All patch the **REAL path** and restore in `finally` (w44 PER_TU-flags rule).

🔴 **HAZARD (new, cost one silent corruption):** a probe killed by the harness's 2-minute
timeout dies BETWEEN the write and the `finally` restore, leaving the TU modified. Wrap
every sweep in `timeout 110 bash -c '...'` and `git checkout --` the TU afterwards.
🔴 **HAZARD (re-fired):** backticks inside `git commit -m` / heredoc-python comment text
shell-expand and silently delete words from the receipt; write receipts with the Edit tool.
🔴 **HAZARD (new):** two concurrent `verify_asm` runs share build outputs — a backgrounded
gate produced a spurious `parse error at end of input` in a foreground run. One gate at a time.
