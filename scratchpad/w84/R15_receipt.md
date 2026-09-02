# W84 R15 receipt — regional-variant matching

Agent R15. Rows: `scratchpad/w84/R15_rows.tsv` (17 rows).
Gate: `python regiondiff/tools/verify_region.py <REGION> <candidate> <fn> --lane-as=recon/<unit>.<ext>`

## Status table (live)

| # | fn | region | class | status |
|---|---|---|---|---|
| 1 | DeInit_Memcard__Fv | USA | CHANGED | **REGION-PASS (42 insns)** |
| 2 | Init_Memcard__FbT0 | USA | CHANGED | **REGION-PASS (89 insns)** |
| 3 | LoadGame__FsbT1 | USA | CHANGED | count-exact 387/388, FAIL 3 (cross-jump residual) |
| 4 | SaveGame__Fs | USA | CHANGED | count-exact 298/298; 16 residual diffs = ORACLE-CORPUS DEFECT (see below) |
| 5 | SavePinkSlipsCars__Fss | USA | CHANGED | count-exact 236/236, FAIL 88 (LICM hoist+spill) |
| 6 | Cleanup__16tScreenPinkSlips | USA | CHANGED | **REGION-PASS (31 insns)** |
| 7 | DrawBackground__16tScreenPinkSlips | USA | CHANGED | **REGION-PASS (390 insns)** |
| 8 | DrawC_PrimHalo__… | USA | CHANGED | **REGION-PASS (301 insns)** — pre-existing candidate re-verified |
| 9 | DrawCongratsMessage__23tScreenTournamentTrophy | JPN | CHANGED | count-exact 200/200, FAIL 4 (sched2 residual) |
| 10 | AudioEng_Set__Fiiiiiiii | USA | CHANGED | **REGION-PASS (164 insns)** — pre-existing candidate re-verified |
| 11 | PAD_restore | USA | CHANGED | **REGION-PASS (17 insns)** |
| 12 | PAD_state | USA | CHANGED | **REGION-PASS (20 insns)** |
| 13 | PAD_update | USA | CHANGED | **REGION-PASS (63 insns)** |
| 14 | padinit | USA | CHANGED | **REGION-PASS (27 insns)** |
| 15 | LoadDescription__15tMissionManagerb | USA | CHANGED | **REGION-PASS (77 insns)** — pre-existing candidate re-verified |
| 16 | Object_KillStatus__Fv | USA | CHANGED | **REGION-PASS (28 insns)** — pre-existing candidate re-verified |
| 17 | func_800A778C | AU | REGION-ONLY | **REGION-PASS (14 insns)** — pre-existing candidate re-verified |

## Verified-on-entry (no edits needed)

Five rows already had candidates under `regiondiff/recon/` from earlier waves and were
re-confirmed green with the gate this session:

```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/psx/drawc.cpp DrawC_PrimHalo__FP10matrixtdefP8coorddefP16Transformer_zObjiiiP13Draw_CarCache --lane-as=recon/game/psx/drawc.cpp
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/audioeng.cpp AudioEng_Set__Fiiiiiiii --lane-as=recon/game/common/audioeng.cpp
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/femission.cpp LoadDescription__15tMissionManagerb --lane-as=recon/frontend/common/femission.cpp
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/object.cpp Object_KillStatus__Fv --lane-as=recon/game/common/object.cpp
python regiondiff/tools/verify_region.py AU  regiondiff/recon/NFS4-R-AU/regiononly/func_800A778C.cpp func_800A778C
```

## Per-row detail

### Rows 11-14 — `eaclib/psx/pad` (padinit, PAD_restore, PAD_state, PAD_update) — 4/4 REGION-PASS

Candidate: `regiondiff/recon/NFS4-R-USA/eaclib/psx/pad.c` (self-contained: pad_types.h
inlined verbatim so it can be compiled from any base directory).

**Gate (authoritative, reproduced twice):**
```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/eaclib/psx/pad.c padinit,PAD_restore,PAD_state,PAD_update --lane-as=recon/eaclib/psx/eacpsxz/addtimer.c
  padinit: REGION-PASS (27 insns)
  PAD_restore: REGION-PASS (17 insns)
  PAD_state: REGION-PASS (20 insns)
  PAD_update: REGION-PASS (63 insns)
```

**🔴 LANE DEVIATION — read this before consolidating.** The manifest lane
(`--lane-as=recon/eaclib/psx/pad.c`) is the WRONG build identity for the regional
PAD.OBJ, which `regiondiff/README.md` already flags as a different library vintage
("different lib vintages ... PAD* ... CHANGED"). Two independent oracle-side
falsifications of the base lane, present in all four regional slices:

* **Address lowering.** Every regional slice reaches `gPadinfo` through the SPLIT
  form with a shared `%hi` — e.g. padinit `lui $s0,0x8014; lw $v0,-1116($s0);
  addiu $s1,$s0,-1116`. The base object's `no_split_addresses` unfused `la`
  (`lui;addiu` then `0($s0)`) does not appear anywhere regionally.
* **Delay-slot fill.** Every regional epilogue is FILLED (`jr $ra; addiu $sp,$sp,N`).
  The base object's is the unfilled `addiu $sp; jr $ra; nop` that
  `PER_FN_EPILOGUE_UNFILL` + the per-fn 2.7.2 splice exist to produce.

`recon/eaclib/psx/eacpsxz/addtimer.c` is used purely as a LANE PROXY — it is the
nearest base TU carrying no `PER_TU_FLAGS` / `PER_FN_*` entry at all, so the
candidate compiles on the plain default lane (2.8.0, split addresses, gcc's own
delay-slot filling). No tool was edited; `--lane-as` is the only lane control a
regional agent has.

**Control, SAME source on the manifest lane** (proves the residual is the lane,
not the source):
```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/eaclib/psx/pad.c padinit,PAD_restore,PAD_state,PAD_update --lane-as=recon/eaclib/psx/pad.c
  padinit FAIL 27 (28/27) | PAD_restore FAIL 14 (21/17) | PAD_state FAIL 16 (20/20) | PAD_update FAIL 45 (70/63)
```

**Regional source deltas (three, each measured):**

1. **`Padglobal` element widened 8 → 34 bytes** (new `PAD_BUFFER` type; `PAD_COMMON`
   stays 8 bytes and remains `gPadinfo.buf`'s element type). Evidence: padinit's
   `addiu $a1,$a0,34` where the base has `addiu $a1,$a0,8` (PadInitDirect's two
   port buffers), and PAD_update loop-1's walker advancing `addiu $s0,$s0,34`
   (m2c `var_s0 += 0x22`). Every other stride is unchanged, and `blockclear`'s
   size is still `0x54`, so `gPadinfo` itself did not move. The retail vintage
   simply gave PadInitDirect the real 34-byte PsyQ direct-mode port buffer. The
   26-byte tail member is `[INFERRED]` — only the stride is observable here.
   Seed diff before this fix carried `- addiu a1,a0,8 / + addiu a1,a0,34`; after
   it, that pair is gone (29 → 27 diffs on the seed lane).
2. **PAD_state = FLAT early-return guard chain.** The regional oracle materializes
   TWO independent zeros: one in the first `beqz`'s delay slot (reorg steals the
   zero block's `move $v0,$zero` and redirects the branch to the epilogue) and one
   out-of-line at `.L800E4DE0`. The base's `&&` funnel and a plain nested-if both
   let `sw $ra,16($sp)` win the delay slot, leaving ONE shared zero (19/20, 3 diffs).
   `if (init == 0) return 0; if ((u_int)padID >= 8) return 0; return conv;` emits
   the oracle byte-for-byte. Falsified on the way: nested-if without early return
   (3 diffs, identical to the `&&` form); a `u_short ret` accumulator variable
   (worse — `ret` becomes a real `$a1` pseudo, `andi` sinks to the epilogue).
3. **PAD_update loop 2 = INDEX form + `u_char` counter.** Regional loop 2 walks two
   givs off `&gPadinfo` (`$a2` stride 8 read at `+4`, `$a0` stride 2 read/written at
   `+68/+69`), which is what `gPadinfo.buf[i]` / `gPadinfo.state[i]` produce; the
   base object's explicit `pt`/`pa`/`btnOff` byte walkers give `lbu 0(reg)` plus a
   third stride-8 giv. And the regional guard is `addiu $v1,$v0,1; andi $v0,$v0,0xff;
   sltiu $v0,$v0,6` — the re-masking `andi` of a **`u_char`** local (methodology
   §3.12 #9); the base's `u_int debCount` drops that mask. Loop 1 needed no change
   (it already matched on the plain lane). 27 → 0 diffs, 66 → 63 insns.

Notes: `PAD_convert` has no regional oracle (unchanged by the retail vintage).
Scratch helper used for reading our own stream: `scratchpad/w84/r15_dump.py`
(read-only w.r.t. `tools/` and the base tree).


### Rows 6-7 — `frontend/common/screenpinkslips` (Cleanup, DrawBackground) — 2/2 REGION-PASS

Candidate: `regiondiff/recon/NFS4-R-USA/frontend/common/screenpinkslips.cpp`
(verbatim copy of the base TU + the two regional blocks + local decls).

```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/screenpinkslips.cpp DrawBackground__16tScreenPinkSlips,Cleanup__16tScreenPinkSlips --lane-as=recon/frontend/common/screenpinkslips.cpp
  DrawBackground__16tScreenPinkSlips: REGION-PASS (390 insns)
  Cleanup__16tScreenPinkSlips: REGION-PASS (31 insns)
```
Manifest lane, no deviation. Both were one-shot: the seed measured 31 diffs (18/31)
and 42 diffs (364/390); the regional deltas are pure ADDED code, the base bodies
needed no change at all.

**Cleanup (+13 insns): a music-buffer drain wait**, inserted between
`frontEnd.pinkSlipsTrackIndex = 0` and `tScreen::Cleanup()`:
```c
while (AudioMus_Buffered() < AudioMus_Threshold()) { FeAudio_systemtask(0); }
```

**DrawBackground (+26 insns): a faded-in screen-info caption + underline**,
inserted just before `i = 0;`:
```c
if (this->fScreenFadeVal >= 100) {
  FETextRender_MenuTextPositionedJustify(638, 480, 220, 1, textState_Selected, textType_ScreenInfo);
  PSXDrawSquare(0, 480, 220, -textpixels(TextSys_Word(638)) - 5, 7);
}
```
Codegen note (why the oracle shows `move $s2,$zero` TWICE, at `800E4DA0` in the
`bnez` delay slot and again at `80038DF8`): that is reorg stealing the branch
target's first insn (`i = 0`) into the slot and redirecting the branch past it —
the fall-through still runs the original. So `i = 0;` stays a single source
statement placed AFTER the new `if`, exactly as the base has it.

**Callee identification** (regional VAs are never resolved through
`configs/symbol_addrs.txt`; the delta was bracketed from the neighbouring
`INDEX.tsv` rows and then confirmed by a base symbol at exactly that delta):

| regional VA | delta | base symbol | corroboration |
|---|---|---|---|
| `func_8007AA48` | 0xA6C | `AudioMus_Buffered__Fv` | same delta as the next row, AudioMus_Fail |
| `func_8007A9C4` | 0xA6C | `AudioMus_Threshold__Fv` | ditto; and the pair is the base tree's own idiom in `tScreenMemcard::LoadIcon` |
| `func_80015A70` | 0x128 | `FeAudio_systemtask__Fi` | same delta as the next row, GetCarFromID |
| `func_800212E0` | 0x160 | `FETextRender_MenuTextPositionedJustify` | also appears in the UNCHANGED part of DrawBackground's own body |
| `func_80021F34` | 0x160 | `TextValue__18tListIteratorTrack7tPlayer` | ditto (unchanged body) |
| `func_8004F12C` | 0x4E8 | `PSXDrawSquare__Fiiiii` | same delta as videodecode; arity 5 matches |
| `func_800E4A2C` | 0xC0C | `textpixels` | same delta as padinit |
| `func_800B9F18` | 0xCF0 | `TextSys_Word__Fi` | semantic pin: its result feeds `textpixels`, and `textpixels(TextSys_Word(id))` is a verbatim base-tree idiom (feapp.cpp:224) |

Control cross-check on the same slice: the three callees whose identity is fixed by
the base body (`VIDEO_destroy` 0x4E8, `purgememadr` 0xBEC, `Cleanup__7tScreen` 0x20)
all land on a base symbol at their bracketed delta too, so the method is validated
on this slice before being used for the unknowns.

### Rows 1-5 — `frontend/common/fememcard` (USA) — 2 REGION-PASS, 3 count-exact near-misses

Candidate: `regiondiff/recon/NFS4-R-USA/frontend/common/fememcard.cpp`. Manifest lane
(`--lane-as=recon/frontend/common/fememcard.cpp`), no deviation.

```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/fememcard.cpp DeInit_Memcard__Fv,Init_Memcard__FbT0,LoadGame__FsbT1,SaveGame__Fs,SavePinkSlipsCars__Fss --lane-as=recon/frontend/common/fememcard.cpp
  DeInit_Memcard__Fv:     REGION-PASS (42 insns)
  Init_Memcard__FbT0:     REGION-PASS (89 insns)
  LoadGame__FsbT1:        FAIL 3  (ours 387 / oracle 388)
  SaveGame__Fs:           FAIL 16 (ours 298 / oracle 298)  <- ORACLE-CORPUS DEFECT, see below
  SavePinkSlipsCars__Fss: FAIL 94 (ours 236 / oracle 236)
```

**The TU-wide regional delta: an added NULLSUB `func_800DCEA4`.** Its own regional slice
(`regiondiff/oracles/NFS4-R-USA/func_800DCEA4.s`) is a bare `jr $ra; nop` — a release-
compiled-out debug/log hook, class REGION-ONLY, so it keeps the mechanical
`func_<region_va>` name. Every call site is `jal; nop` with NO `$aN` setup, so the
signature is genuinely `void(void)` (methodology 3.2's "a compiled-out nullsub still takes
its real args" caveat does NOT bite here — checked at all 13 sites; the one apparent arg,
`move $a0,$s8` before `8003576C`, is a `bne` DELAY SLOT belonging to the following call).
Sites: Init_Memcard 1, DeInit_Memcard 1, SaveGame 3, SavePinkSlipsCars 5, LoadGame 3 —
always as the first statement of a card-event wait/poll loop body.

**Row 1 DeInit_Memcard (+2 insns):** the nullsub after `padinit()`. One shot.

**Row 2 Init_Memcard (+2 insns):** the nullsub after the trailing `timedwait(0x14)`. One shot.

**Row 4 SaveGame (+6 insns): 3 nullsub sites + a +1 TEXT-ID SHIFT.** Every TextSys id in
the function moves up by one: `0x276->0x277` (the warning-dialog prompt), `0x28b->0x28c`
(x2), `0x29d->0x29e`, `0x325->0x326`, `0x32b->0x32c`. The retail text table gained an entry
ahead of this block. After those two edits the function is **count-exact 298/298 with 16
residual diffs, and all 16 are an ORACLE-CORPUS DEFECT, not a code difference**:

> `regionrecon`'s jump-table symbolization rewrote EIGHT `$sp`-based epilogue restores as
> `%lo(jtbl_...)` because the frame displacements collide with the jump table's addresses:
> `lw $s7,%lo(jtbl_800116EC)($sp)` etc. The gate normalizes `%lo(...)` to 0 on the oracle
> side, so it compares `lw s7,0(sp)` against our `lw s7,5868(sp)`. The oracle line's OWN
> encoded word is `8fb716ec` — immediate `0x16ec` = **5868**, i.e. byte-identical to ours;
> likewise `0x16d0..0x16e8` = 5840..5864 for `$s0..$s6`. All 8 pairs check out.
> FIX BELONGS IN `regionrecon.py`: never symbolize a displacement whose base register is
> `$sp`. I did NOT touch the oracle. The 9th `%lo(jtbl_...)` in the file
> (`addiu $t2,$t2,%lo(jtbl_800116A0)`, line 203) is a genuine table-address materialization
> and masks correctly on both sides. SavePinkSlipsCars and LoadGame each carry only genuine
> ones and are unaffected.

**Row 3 LoadGame (+14 insns): 3 nullsubs, the +1 text-id shift, a LANGUAGE SNAPSHOT, an
icon-cache invalidate, a statement swap, and a REPLACED read-failure arm.** Count-exact
388/388, 3 diffs.

* text ids `0x276->0x277`, `0x28d->0x28e` (x3), `0x329->0x32a` (x2), `0x29f->0x2a0`, `0x32b->0x32c`.
* NEW at entry: `savedLanguage = frontEnd.language;` (`lbu` of frontEnd+0x340, spilled to
  `sp+5776`). NEW at the tail: `screenMemcard->fGetNewIcons = 1;` (unconditional — it sits
  in the guard's branch delay slot) followed by
  `if (RDAT_8013E560 != 0) frontEnd.language = savedLanguage;`. Reads as the localized-release
  "don't let a foreign save switch the UI language" fix. `RDAT_8013E560` is a REGION-LAYOUT
  global I could not identify: its bracketed delta lands on the base's `gCheckTotalTime`,
  which is a CHAR while the regional reads a WORD — so it is a retail-added global or the far
  side of a bss shift. Mechanical name + `[INFERRED]` role comment per the README.
* `MakeWayForMemoryCard()` now runs BEFORE `count = count + 1` (base has them swapped).
* The `case 0xf` VerifySuccessfulRead-FAILED arm no longer displays a message dialog; retail
  replaced it with the SAME `MCRD_getcard`/status classification the 2/3/7/a/b/10/17 arm runs
  (m2c shows them sharing the block_31/block_33/block_35 tails).
* DECL POSITION IS LOAD-BEARING: `int savedLanguage;` must be the FIRST local, otherwise it
  and `count` swap spill slots (5776 vs 5780) — 52 -> 38 diffs from that one move.
* The success arm must set `finished = true;` ITSELF rather than the base's
  `goto finish_card_event;`; that alone took 38 -> 3.
* RESIDUAL 3 (ours 387 / oracle 388): retail keeps TWO copies of the 2-insn tail
  `li $s1,1; j <loop top>` — one for the success arm (`800352F0`) and one shared by the two
  failure paths (`.L80035380`). gcc-2.8 cross-jumps ours into a single copy, so the failure
  arms jump straight at the success arm's tail. Falsified while chasing it, each measured:
  `SetPads()` before/after `returnmessage = 0x28e` (both 3, identical diff); giving EVERY arm
  its own `finished = true` (FAIL 15 @393 — the -2/-1 blocks then stop sharing, +5 insns);
  spelling the shared -2/-1 blocks as explicit `goto card_not_formatted/card_not_found`
  labels inside the status arm (FAIL 25 @387 — legal only after splitting
  `CARDINFO_def *pCI`'s decl from its initializer, and that split shifts pseudo numbering
  and re-rotates $s4/$s5). Class: gcc cross-jumping a duplicate 2-insn tail.

**Row 5 SavePinkSlipsCars (+10 insns): 5 nullsub sites.** Count-exact 236/236, 94 diffs —
see its own section below.

Inherited from the base TU (NOT introduced by this agent, and left untouched under the
"preserve user edits / do not rewrite what already matches" rule): SaveGame and
SavePinkSlipsCars each carry one `__asm__("")` scheduling boundary from earlier waves.

### Row 9 — `frontend/common/screencongrats` (JPN) DrawCongratsMessage — count-exact 200/200, FAIL 4

Candidate: `regiondiff/recon/NFS4-R-JPN/frontend/common/screencongrats.cpp`. Manifest lane.

Seed measured FAIL 58 (ours 182 / oracle 200). The JPN deltas, all inside
`tScreenTournamentTrophy::DrawCongratsMessage`:

* RECT init `r.y 0x3c -> 0x50`, `r.w 200 -> 420`.
* text ids +1: `0x3b3->0x3b4`, `0x3e1->0x3e2`, `0x3c6->0x3c7`, `800->801` (both the
  `TextSys_WordY` and the `TextSys_Word` call).
* both congrats renders switch `textState_Selected -> textState_Hilighted`.
* the first render's advance gains a -14 bias applied to the OLD `r.y`.
* the second render narrows the box first (`r.w = 200;`).
* the award block is repositioned (`r.y 200 -> 100`, `r.w 0xf0 -> 220`), renders the
  FORMATTED `buffer` instead of re-fetching the raw `TextSys_Word(0x40)` format string
  (a real retail bug fix), then shrink-wraps `r` (`r.h = height+6; r.y = 0x61; r.x -= 5;
  r.w += 10;`) and paints `DrawShape_NFS4TransRectangle(r,1)` behind it.

Callee identification (delta bracketing from `oracles/NFS4-R-JPN/INDEX.tsv`, each confirmed
by a base symbol at exactly a neighbouring row's delta): `func_800B9CCC`/`func_800B9D2C` =
`TextSys_Word`/`TextSys_WordY` (both delta 0xA7C — same object, mutually corroborating),
`func_80021600`/`func_80021788`/`func_80020C0C` = `FETextRender_WordWrapTextFade` /
`WordWrapHeight` / `FullTextRGB` (all delta -0x140), `func_80026948` = `FeTools_FormatMoney`
(-0x398), `func_800E4E94` = `sprintf` (0x9D8), `func_80033630` = `GetAwardInformation`
(-0x2A4), `func_8004C484` = `DrawShape_NFS4TransRectangle__FR4RECTs` (-0x58; the 2-arg
arity matches the oracle's `addiu $a0,$sp,24; li $a1,1`).

Two gotchas worth banking:

1. `DrawShape_NFS4TransRectangle` is declared in NO header this TU includes, so cc1plus
   implicitly typed it and passed the RECT **by value** (packed into `$a0/$a1`, opacity in
   `$a2`). A TU-local `void DrawShape_NFS4TransRectangle(RECT &, short);` — the base tree's
   own signature from `recon/frontend/psx/drawshp.cpp` — fixed 19 -> 7. **A silently wrong
   implicit declaration is invisible to the compile gate; only the arg-register shape in
   the diff catches it.**
2. The -14 bias needs `(short)(r.y - 14) + (short)WordWrapHeight(...)`. Without the inner
   cast gcc reassociates and folds the -14 onto the CALL RESULT (`addiu $v0,$v0,-14`) where
   retail applies it to `r.y` (`lhu $v1; addiu $v1,-14; addu $v1,$v1,$v0`). Measured:
   `(r.y - 14) + (short)f(...)`, `(r.y - 14) + f(...)`, `(short)f(...) + (r.y - 14)` and
   `r.y - 14 + (short)f(...)` all = FAIL 7 @199; the double cast = FAIL 4 @200.

RESIDUAL 4 (count-exact): retail schedules the `lhu $v0,24($sp)` (r.x) load one slot EARLIER
than the `li 97`, which pushes the 97 into `$v1`; ours materializes 97 into `$v0` first and
loads r.x after. Pure sched2 placement. Falsified, each measured: statement orders
`r.x-=5` before `r.y=0x61` (4), `r.w+=10` before `r.x-=5` (16), compound-assignment spelling
(4), a `short newx = r.x;` read hoisted above `r.y = 0x61` (4), and `short newx = r.x - 5;`
(4).

### Row 5 (detail) — `SavePinkSlipsCars__Fss` (USA) — count-exact 236/236, FAIL 88

Seed measured FAIL 104 (ours 226 / oracle 236). Two source deltas applied:

1. **5 added `func_800DCEA4()` nullsub sites** (+10 insns, making the count exact): the two
   `MCRD_handlecardevents(cardNum) == 0x15` wait loops, the inner `!= 0x16` drain loop, and
   the first statement of BOTH poll-loop bodies (outer `if (finished) break;` and inner
   `if (finishedsave) break;`).
2. **`int cardSlot = player * 4;` computed in the outer loop's PREHEADER** (right after the
   first wait loop) and used by both `MCRD_getcard(cardSlot + 1)` sites. Retail shares one
   `player*4` in `$s4` (`addiu $a0,$s4,1` at each getcard) where the base object recomputes
   `sll` per site. Measured 94 -> 88 with the carrier in the preheader; 72 diffs but 238
   insns (count NOT exact) with it computed at function entry instead — the preheader
   position is the right one because retail's entry-side `cardNum = player*4+1` is a
   SEPARATE multiply off a SEPARATE sign-extension (the oracle sign-extends `player` twice,
   once at entry into `$s0` and once in the preheader into `$s7`).

**RESIDUAL 88, one class: retail LICM-hoists `&frontEnd + player*4` out of the poll loop and
SPILLS it** (`lui/addiu %hi/%lo(frontEnd); addu $v0,$s4,$v0; sw $v0,5696($sp)` in the
preheader; `lw $t0,5696($sp); lw $v1,1084($t0)` at the use). That extra frame slot is the
whole 5736-vs-5744 frame delta, and the resulting pressure is what rotates our
`{player=$fp, shapeFile=$s7, sext=$s4, player*4=$s6}` into retail's
`{player=$s7, shapeFile=$fp, sext=$s5, player*4=$s6}`. Our build computes the address inside
the `case 0xf` arm instead. Falsified, each measured:

| angle | result |
|---|---|
| declaration-order permutations of `shapeFile` (first / 4th / 2nd) | 94, 94, 94 — inert (these are all REG allocnos; gcc-2.8 priority is usage/live-length, not decl order) |
| `int playerIdx = player;` sext carrier + all in-loop uses through it | FAIL 99 @235 — the raw copy dies but the count drops |
| explicit hand hoist `char *fePlayerBase = (char *)&frontEnd + cardSlot;` + `*(u_long *)(fePlayerBase + 0x43c)` | FAIL 56 @238 — gcc keeps the base in a REGISTER (retail spills it), so still not the oracle, AND it is the magic-offset anti-pattern the methodology warns against (§3.12 "do NOT chase with magic-offset pointer arithmetic"). NOT shipped. |

The base object's own tool for tuning LICM at this exact site is an operand-free
`__asm__("")` boundary (see the `MATCH (2026-08-15, 25 -> PASS)` note the base TU carries in
this very function — "the two operand-free boundaries add four live units to the
LICM-hoisted inner jump-table base"). **This wave's rules bar me from adding a new one**, so
the regional variant's different LICM budget has no legal lever available to me. That is the
honest state of this row: structurally complete and count-exact; the residual is one
LICM-hoist-plus-spill decision.

---

## Summary

**13 of 17 rows REGION-PASS.** The four open rows are all count-exact and each has a single,
named residual class:

| row | state | residual class |
|---|---|---|
| SaveGame__Fs | 298/298, FAIL 16 | **not a code diff** — `regionrecon.py` mis-symbolized 8 `$sp` epilogue displacements as `%lo(jtbl_...)`; oracle bytes are identical to ours |
| LoadGame__FsbT1 | 387/388, FAIL 3 | gcc-2.8 cross-jumped a duplicate 2-insn `li $s1,1; j <loop>` tail that retail keeps twice |
| DrawCongratsMessage (JPN) | 200/200, FAIL 4 | sched2 places retail's `lhu` one slot earlier, pushing a constant from `$v0` to `$v1` |
| SavePinkSlipsCars__Fss | 236/236, FAIL 88 | retail LICM-hoists + spills `&frontEnd + player*4`; no legal lever without an `__asm__("")` LICM fence |

### Actions for the orchestrator

1. **`regionrecon.py` jtbl-symbolization bug** (blocks SaveGame, and any other slice whose
   frame displacements collide with a jump table): never rewrite a displacement as
   `%lo(jtbl_...)` when the base register is `$sp`. `SaveGame__Fs.s` lines 310-317 are the
   evidence; the encoded words (`8fb716ec` etc.) prove the oracle's real immediates.
2. **PAD lane**: the four PAD rows gate REGION-PASS only on the plain default lane
   (`--lane-as=recon/eaclib/psx/eacpsxz/addtimer.c` as a proxy). If the pipeline wants a
   first-class lane, the regional PAD.OBJ needs its own entry with NO `no_split_addresses`,
   NO per-fn 2.7.2 splice and NO epilogue unfill — the opposite of the base object's.
3. `RDAT_8013E560` (LoadGame's language-restore guard) is an unidentified regional global;
   a per-region link map would settle it.

### Files touched (nothing outside these)

```
regiondiff/recon/NFS4-R-USA/eaclib/psx/pad.c                       (new)
regiondiff/recon/NFS4-R-USA/frontend/common/screenpinkslips.cpp    (new)
regiondiff/recon/NFS4-R-USA/frontend/common/fememcard.cpp          (new)
regiondiff/recon/NFS4-R-JPN/frontend/common/screencongrats.cpp     (new)
scratchpad/w84/R15_receipt.md                                      (this file)
scratchpad/w84/r15_dump.py                                         (read-only helper)
```
No git operations, no `tools/**` or `regiondiff/tools/**` edits, no MANIFEST/PROGRESS edits,
no base-tree edits, no memory-dir edits. `update_region_progress.py` was NOT run (per the
wave guide). The user-live files `recon/syslib/psx/libgpu/FONT.c` and
`recon/syslib/psx/libmcrd/LIBMCRD.c` were never opened.
