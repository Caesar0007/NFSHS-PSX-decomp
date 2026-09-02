# W85-S4 receipt — device purity for recon/game/psx/{draww,hud,drawc,flare,night,weather,hrzsku}.cpp

Gate = `python tools/tugate.py <file>` (whole-TU; it re-uses verify_asm's own
normalizers and its w59-a9 dead-%hi collapse, so it is the authoritative per-fn
PASS/FAIL table for a whole TU). Run identically before and after every edit.
Pre-wave copies of all seven files: `scratchpad/w85/S4_bak/*.cpp.bak`.
Probe drivers (scratchpad-local, **no tool file was edited**):
`S4_probe.py` (drop lines + gate + restore), `S4_strip.py` (strip whole `__asm__`
STATEMENTS starting on given lines, multi-line aware, + gate + restore),
`S4_try.py` (apply a list of exact (old,new) source substitutions + gate + restore),
`S4_vd.py` (vdiff one fn with lines removed).

---

## 1. BASELINE and FINAL — NO PASS WAS LOST (iron rule satisfied)

| file | BEFORE | AFTER |
|---|---|---|
| recon/game/psx/draww.cpp   | 35/35 PASS | 35/35 PASS |
| recon/game/psx/hud.cpp     | 62/62 PASS | 62/62 PASS |
| recon/game/psx/drawc.cpp   | 20/20 PASS | 20/20 PASS |
| recon/game/psx/flare.cpp   | 27/27 PASS | 27/27 PASS |
| recon/game/psx/night.cpp   | 19/19 PASS | 19/19 PASS |
| recon/game/psx/weather.cpp | 25/25 PASS | 25/25 PASS |
| recon/game/psx/hrzsku.cpp  | 22/22 PASS | 22/22 PASS |
| **total** | **210/210 PASS** | **210/210 PASS** |

**11 devices cleared, 0 regressions.** Diff vs backups is confined to the 11 sites
plus their receipt comments (`diff` line counts: hud 27, weather 38, night 10,
drawc 8, draww/flare/hrzsku 0).

---

## 2. PIN CENSUS (the assignment's three flagged pins) — ALL THREE ARE COMMENT TEXT

`grep -nE 'register[^;]*asm *\(' ` over the seven files returns exactly three hits, and
every one sits inside a `/* ... */` block:

- `draww.cpp:1613` — ``(`register s32 clutReg asm("$16")`, `register u8 *stackPointer asm("$29")`)``: prose in the Draw_kCtrlChopper ledger, a *falsified-angle* entry.
- `draww.cpp:6047` — ``*  - PIN LANE PRICED: `register int ccount_local asm("s5")` over the``: prose, a priced-and-rejected lane.
- `hud.cpp:3907`  — ``* `register char *t asm("$4")` copy above the branch lands [addu][beqz]``: prose.

A comment-stripped rescan (`perl -0777 -pe 's{/\*.*?\*/}{}gs; s{//.*}{}g'`) shows
**zero** `register … asm("$N")` declarations in all seven files.
⇒ **0 asm pins exist in this assignment's scope**; the real device population is
zero-insn fences / launders, one funnel `volatile`, and asm-label storage views.

Likewise the "25 non-MMIO volatile" figure was a raw-grep artifact: after comment
masking there are only **4** non-asm `volatile` uses in the seven files
(hud 3, drawc 1) — all four are itemised in §4/§5.

---

## 3. DEVICES CLEARED (11) — each removed, whole file re-gated, still 100% PASS

| # | file:line (pre-edit) | device | evidence it is now scaffolding |
|---|---|---|---|
| 1 | weather.cpp:1056 | `__asm__ __volatile__("")` — CreateSnow dial (1) of the w46-a9 three-dial packet-bump fix | removed → `Weather_CreateSnow` PASS, TU 25/25. The split bump (`next`) + split palette RMW carry it alone. |
| 2 | weather.cpp:1241 | `__asm__ __volatile__("")` — CreateSplat dial (3) | removed → PASS, TU 25/25. The two SPLITS already pin the `addiu $v1,$t0,0x28`. |
| 3 | weather.cpp:1776 | `__asm__("" : "=r"(ab) : "0"(ab))` opacity fence (w50-a10, was 40→36) | removed → `Weather_DoWeather` PASS, count still EXACT 197/197. Subsumed by the later w63-a13 dead-pseudo staging rewrite. |
| 4 | weather.cpp:1262 | `__asm__ __volatile__("")` in `Weather_CreateSplat`'s colour/shift tie | **RE-CRACKED source-only** — see §3a. |
| 5 | night.cpp:1609 | the W71-A5 **7-operand** read-only ref-step fence `__asm__("" : : "r"(color) ×7)` | removed → `Night_AdditiveNightCalc` PASS 64/64, TU 19/19. The W71 flr2 ref step was needed against the *then* basin; later structural work moved `color`'s allocno ahead of xdist/zfar by itself. |
| 6 | hud.cpp:1053 | `__asm__("" : : "r"(w2))` read-only fence | removed → TU 62/62. |
| 7 | hud.cpp:1744 | `__asm__("" : : "i"(0))` w55-a9 else-arm-exit fence in `Hud_BuildTach` | removed → PASS; subsumed by the later w75-a3 tail rewrite. |
| 8 | hud.cpp:1822 | `__asm__("" : : "i"(0))` w75-a3 lever-4 store-pairing fence | removed → PASS; the w50-a1 statement ORDER holds the pairing alone. |
| 9 | hud.cpp:3393 | `__asm__("" : : "i"(0))` void fence pinning the map-marker funnel store at the join | removed → PASS; the (kept) volatile funnel store carries it. |
| 10 | hud.cpp:4709 | `__asm__ volatile("")` w45-a7 reorg barrier in `Stats`-position early-return | removed → PASS; the unsized-array `D_8011321C` view now carries the eager fill alone. |
| 11 | drawc.cpp:5229 | `*(int volatile *)&sd->otz` — a **non-MMIO volatile** on a scratchpad cache field | replaced by a plain `sd->otz` read → identical reload, `DrawC_PrimShadow` PASS, TU 20/20. `sd` is a Draw cache object, not MMIO/IRQ state, so the qualifier was a codegen crutch. |

### 3a. The one genuine SOURCE-LEVEL RE-CRACK (device removed AND the match re-won)

`weather.cpp` `Weather_CreateSplat` — retail issues `li $v0,-128 / subu $v0,$v0,$a0`
before `sra $v1,$v1,3` (a sched2 ready-list tie). w46-a9 held that with a
`__asm__ __volatile__("")` between the two statements. Ledger measured this wave
from the fence-free basin (whole-TU gate each time):

```
fence removed, nothing else changed .......................... 2 diffs
store-before-shift, no new temp .............................. 2 diffs
inline `(u_char)(-0x80 - splatTick*4)` then shift ............. 2 diffs
SECOND NAMED CARRIER `int sh = splatTick >> 3;` declared AFTER
  `col`, stores in retail order, `splatTick = sh;` ............ PASS   <- SHIPPED
```
Landed shape (device-free):
```c
int col = -0x80 - splatTick * 4;   /* SYM-CODEGEN-CARRIER */
int sh  = splatTick >> 3;          /* SYM-CODEGEN-CARRIER, must be declared AFTER col */
prim->r0 = prim->g0 = prim->b0 = (u_char)col;
splatTick = sh;
```
Mechanism: giving the shift its own named pseudo, born *after* `col`'s, puts the
subu ahead of the sra in the RTL stream, so sched2's tie breaks retail's way at
zero instructions. **Generalisable**: a "two independent ops, wrong issue order"
sched tie that a fence currently holds is worth one attempt at *naming the second
operand too*, with declaration ORDER as the dial (methodology §3.12 #15's
"declaration scope + order are load-bearing", applied to a tie rather than a loop).

---

## 4. DEVICES KEPT — SANCTIONED CLASSES (never candidates; per GUIDE.md "KEEP")

- **EA DMPSX / tool-expanded OT-link templates** (methodology §3.25-2), fixed
  `$12/$13/$14` (= `$t4/$t5/$t6`) scratch + the 24-bit `lwl/swl` link:
  `draww.cpp:998, 1991, 6065, 6468`; `drawc.cpp` macros `DRAWC_OTLINK_FT3` (36),
  `DRAWC_UVTINT_ID` (80), `DRAWC_UVTINT_VT` (86), `DRAWC_OTLINK_FT3B` (89),
  `DRAWC_OTLINK_MODE` (95), `DRAWC_VTZ` (127). Verified by inspection: every one
  is the fixed-register template, not compiler codegen.
- **GTE/COP2 macro block**: `drawc.cpp:716` `mfc2 $12,$19 / nop / sra / sw`
  (the sub_otz depth-key read) — the user's explicit exception.
- **asm-label STORAGE/NAMING declarations** (not inline asm, not volatile; these
  are the §3.12 #5 storage-shape family and, for the definition, the *symbol name*):
  `night.cpp:22` (`Night_gCopCarTypeColorIdx_cell asm("Night_gCopCarTypeColorIdx")`
  — removing the label renames the symbol, so this is correctness, not codegen),
  `night.cpp:51/79/99`, `weather.cpp:60-63`, `draww.cpp:5267` (`gClutDepth_v`),
  `hud.cpp:5810` (`DashHUD_view`). Left untouched: GUIDE.md's CLEAR list does not
  name them and they are declaration shape, not an emitted device.

---

## 5. DEVICES KEPT — MEASURED LOAD-BEARING (removal regresses; re-crack attempted or ledger already exhaustive)

Every row below was probed THIS wave with `S4_strip.py` (statement removed, WHOLE
file re-gated). "diffs" = the regression on that one function; all other functions
in the TU stayed PASS in every probe.

### draww.cpp (14 clear-class sites, all load-bearing)
| line | device | diffs if removed |
|---|---|---|
| 1026 | 5× `"r"(sd)` priced ref dial (w64-a2, `DrawW_SubdividFacet`) | 94 |
| 1313 | `"=r"(lt)/"0"(lt)` launder (`Night_NightCalc`) | 2 |
| 1981 | `"i"(0)` void fence (`DrawW_DrawQuad`) | 5 |
| 2196-2206 | the **66-ref `sd` dial** (`DRAWW_SD_REF10()`×6 + 6, `DrawW_DrawQuad`) | **194** |
| 2780 | `"=r"(off7d)` launder (`DrawW_DoTrough`) | 44 |
| 3412 | `"=r"(objInstance)` launder (`BuildObjectFacets`) | 34 |
| 3486 | `"i"(0)` void fence (`BuildObjectFacets`) | 4 |
| 3488 | `"=r"(g)` launder (`BuildObjectFacets`) | 6 |
| 3559 | `"=r"(objInstance)` launder | 37 |
| 3920 | `"=r"(objInstance)` launder (`BuildCustomObjectFacets`) | 44 |
| 3929 | `"i"(0)` loop-top fence | 1 |
| 3995 | `"=r"(g)` launder | 68 |
| 4103 | `"=r"(objInstance)` launder | 45 |
| 4615 | `"i"(0)` loop-top fence (`BuildChunkObjectFacets`) | 1 |

Re-crack attempts executed this wave (all re-gated, all failed):
- **4615 (1 diff)** — the residual is a *reorg* delay-slot decision: retail copies the
  taken-target `addu v0,s7,zero` into the `beqz` slot; without the fence ours fills with
  the fall-through goffsets `lui`. Tried: swapping `type = objInstance->type;` above the
  goffsets load (**1**, unchanged), index-term-first address spelling
  `(int)goffsets + (zoffset<<2)` (**11**), `*(int*)((zoffset<<2)+(int)goffsets)` (**16**).
  🔴 **Named mechanism for the whole `"i"(0)` class**: gcc-2.8 `reorg.c` `stop_search_p`
  returns 1 only for `SEQUENCE`, `ASM_INPUT` or `asm_noperands(...) >= 0` — i.e. **an asm
  is the only RTL object that stops the delay-slot search**; no `volatile` MEM, no C
  statement shape can. So sites 3929/4615 (and hud 2084/5499, hrzsku 2489) are asm-only
  by construction unless the surrounding CFG changes.
- **2196-2206 (194 diffs)** — the file's own comment names the open natural-source angle
  ("retail simply re-reads `sd` more times than our CSE'd body does"): reaching the
  `floor_log2` step at 128 refs needs ~66 extra `sd` references, i.e. de-CSE-ing a
  ~700-line function's cached locals back into direct `sd->field` reads. That is a
  research project, not a lever; left as the documented open angle.

### hud.cpp (15 asm sites + 3 volatile, all load-bearing)
| line (post-edit) | device | diffs if removed |
|---|---|---|
| 1108 | `"=r"(g4),"=r"(one)` staged-literal launder (`Hud_Init`) | 4 |
| 1115 | `"=r"(one)` staged-literal launder | 2 |
| 1734 | `"r"(clutx)` fence (`Hud_BuildTach`) | 7 |
| 2079 | `"=r"(str)` launder (`Hud_BuildString`) | 33 |
| 2084 | `"i"(0)` void fence | 4 |
| 2302 | `"r"(j)` fence (`Hud_BuildNumbers0`) | 24 |
| 3363 | `"=r"(pktcell)` launder (`Hud_BuildMapMarkers`) | 38 |
| 3438 | `"=r"(pktcell)` + `"$5"` clobber | 44 |
| 3464 | `*(volatile long *)&currentSpriteColor` funnel STORE | 9 |
| 3467 | `"i"(0)` void fence pinning that store | 8 |
| 4126 | `"=r"(lt)` + `"$3"` clobber (`Hud_BuildCdPlayer`) | 14 |
| 4139 | `"r"(lt4)×2` fence | 8 |
| 4212/4215 | `((volatile u_char *)title)[i]` reads | 18 |
| 5151 | `volatile "" : : "r"(by)` (`Hud_Draw321Num`) | 65 |
| 5499 | `"i"(0)` void fence (`Hud_RenderHudView`) | 4 |
| 5540 | `"r"(pw)×2` fence | 4 |
| 6116 | `volatile "" : : "r"(countamount)` (`Hud_Render`) | 4 |

Re-crack attempts this wave (failed, both 2): `Hud_Init`'s staged `one` literal —
`Hud_BuildF4(HudF4+3, 1, x += w2, …)` (side-effect-in-arg spelling) and a split
`xx = x + w2; x = xx;` carrier. Both leave the `li a1,1` after the `addu`.

### drawc.cpp (15 clear-class sites, all load-bearing)
`1233` envMapOffset launder **28** · `2372` facet_flag+ff laundry **31** ·
`2539` 5×`"r"(i)` ref dial **194** · `2587` **120** · `3889` **31** · `4100` **99** ·
`4228` facet_flag launder + `$9/$10/$11` clobber **60** · `4594` `"r"(tex)` **7** ·
`4877` `"r"(facet)` **26** · `5061/5069/5074/5082` `"r"(ovs)` fences **37/33/38/33** ·
`5696` bare `__asm__("" : : )` load-order fence in `DrawC_ShowroomPrims` **2**.

Re-crack attempts on 5696 (the cheapest): the block's three `Fe3D_lightsVertex[index*2].x/.y/.z`
loads respelled as a `COORD16 *z0` pointer local (**2**) and as a `short *z0` word-pointer
local matching the sibling blocks (**2**); interleaving the first store between the loads
(**23**). Retail's x-before-y load order is a sched2 ready-list drain the fence pins.

### flare.cpp (5 sites, all load-bearing)
`707` `volatile "" : : "r"(c)` (`Flare_CarShapedHalo`) **3** ·
`1184` `volatile "" : : "r"(rgb)` (`Flare_2DSpike`) **2** ·
`1953` `"r"(pp),"r"(cp)` (`Flare_LensFlare`) **2** ·
`1958` `volatile "r"(vx0),"r"(vy0)` **12** · `1961` `volatile "r"(otSize),"m"(col)` **4**.

Re-crack ledger for `Flare_2DSpike` (count-exact 43/43; residual = the sched1 issue
position of `lw v1,%gp_rel(gfrgb2)(gp)` one slot before the packet-cursor bump):
```
fence removed, nothing else ................................. 2
packet bump moved AFTER the prim+4 colour store ............. 6
`u_int rgb` declared before `prim` .......................... 2
bump BEFORE the rgb read (source order swapped) ............. 2
`& 0xffffffffu` on the read ................................. 2
bump moved to the very END of the function .................. 4
byte-wise `gfrgb2.r | g<<8 | b<<16 | cd<<24` ................ 41
```
⇒ source POSITION is provably irrelevant here (read-before-bump and bump-before-read
both emit bump-first), so the tie is priority-driven, not LUID-driven; the fence is
the only zero-insn way to pin it.

### night.cpp (5 sites, all load-bearing)
`1441-1444` — four `"r"(tgt)` refs, the **W80 QTY_CMP_PRI ref dial** (tgt 7/18 vs zn2
3/4). Probed every subset: **any** single removal **8**; 1441+1442 **8**;
1441-1443 **8**; 1442-1444 **8**; **all four 2**; all four + the zn2 fence **8**.
`1446` `"r"(zn2)` read-only fence: alone **8**.
Re-cracks from the all-four-removed (2-diff) basin: moving `Night_gXDistShift = 10;`
below the tgt read (**16**), hoisting the guard byte into a `u_char flg` (**9**).
The 2-diff residual is the documented sched2 pair (retail issues `lw v0,4(v0)` before
`li v1,128`); the four zero-byte refs are what reorders the two local-alloc qtys.

### weather.cpp (4 sites left, all load-bearing)
| line (post-edit) | device | diffs |
|---|---|---|
| 426 | `__asm__ __volatile__("")` — breaks `cross_jump` tail equality in `Weather_ChangeIntensityBasedOnTime` | 6 |
| 1454 | `"r"(i)` fence (`Weather_DoSplats`) | 14 |
| 1463 | `"=r"(q)` launder (`Weather_DoSplats`) | 36 |
| 1772 | `"r"(player),"r"(wdp)` fence (`Weather_DoWeather`) | 16 |

`426` is structurally asm-only: guard 1 and guard 2 both end in the byte-identical
2-insn tail `slt v0,v0,v1 / bnez v0,L239C / j L2390` (58 ours vs 62 oracle after the
merge), and the *post-reload* `jump_optimize` cross-jump pass merges them. A source
spelling that makes the tails differ (`subu`+`bltz` instead of `slt`+`bnez`) would
emit the wrong instructions; a zero-byte asm is the only thing that breaks the
equality without changing the emitted stream.

### hrzsku.cpp (9 sites, all load-bearing — the heaviest ledgers in the set)
`163` `volatile "" : : "r"(i)` (`Horizon_InterpolateLineSCoords`) **26** ·
`419` `"r"(height),"r"(radius)` loop-depth ref dial (`Hrz_InitSky`) **16** ·
`2472` `"r"(i)` **52** · `2489` `"i"(0)` **3** · `2604` `"=r"(cw)…"r"((int)mpts[0].vx)`
delay-slot-feed launder **19** · `2620` twin on `ch`/vy **44** · `2643` `"=r"(pp)`
**72** · `2669` `"r"(m24)` **18** · `2704` `"=r"(q)` **48**
(all in `Hrz_BuildHorizon`, count-exact 473/473 basin).
`2604`/`2620` are the catalog's "give the asm the value you want in the slot as an
EXTRA INPUT" device — the extra `"r"((int)mpts[0].vx)` operand forces the `lh` to be
scheduled ABOVE the asm so it lands in the branch delay slot. Removing them costs
19/44 diffs; the file already carries a multi-page falsification ledger for every
non-asm spelling of these RMWs (24-first/40-first orders, reqdelta arithmetic,
`volatile short` on both = 251).

---

## 6. SUMMARY OF THE DEVICE POPULATION AFTER THIS WAVE

| file | pins | sanctioned (DMPSX/GTE/asm-label) | clear-class devices left | cleared this wave |
|---|---|---|---|---|
| draww.cpp | 0 | 4 OT-link templates + 1 asm-label view | 14 | 0 |
| hud.cpp | 0 | 1 asm-label view | 15 asm + 3 volatile | **5** |
| drawc.cpp | 0 | 6 OT-link/UV-tint macros + 1 GTE | 15 | **1** (the last non-MMIO volatile in the TU) |
| flare.cpp | 0 | 0 | 5 | 0 |
| night.cpp | 0 | 4 asm-label decls | 5 | **1** |
| weather.cpp | 0 | 4 asm-label views | 4 | **4** (3 free + 1 re-cracked) |
| hrzsku.cpp | 0 | 0 | 9 | 0 |

**Every remaining clear-class device has a measured regression number in §5.**
Nothing was left in a broken state; nothing was removed on faith.

### Transferable findings for the rest of the wave
1. **Re-measure before believing a ledger.** 6 of the 11 clears were devices whose own
   comment said they were load-bearing — later structural work in the same TU had
   subsumed them. A device census is only true at the basin it was measured in.
2. **`reorg.c:stop_search_p` is the hard wall for the `"i"(0)` void-fence class**: only
   `ASM_INPUT`/`asm_operands` stops the delay-slot search, so those sites cannot be
   re-cracked by any C spelling — they need a CFG change or stay.
3. **The `S4_try/S4_strip` pattern is cheap**: a whole-TU gate on these files costs
   2-20 s, so an exhaustive per-device probe of a 60-function TU is ~5 minutes. Do the
   census FIRST; it finds the free devices immediately and prices the rest.
4. ⚠️ **Line numbers shift after every applied edit** — always re-census
   (comment-masked) before the next probe; a stale line number made one probe strip an
   `__asm__` occurrence out of a *comment* and produce a bogus compile failure.
