# W84-R07 receipt — regional-variant matching (17 rows)

Gate (authoritative for every row below):
`python regiondiff/tools/verify_region.py <REGION> <candidate> <fn[,fns]> --lane-as=recon/<unit>.<ext>`

Baseline measurement pass in progress. Status per row is recorded as it is measured.

## audiocmn (USA, CHANGED, 8 fns) — candidate `regiondiff/recon/NFS4-R-USA/game/common/audiocmn.cpp`

Gate command:
```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/audiocmn.cpp \
  AudioCmn_LoadAsyncSfx__FiiPvi,AudioCmn_MusicLevel__Fi,AudioCmn_PlayDoppleredSound__Fiiiiii,\
AudioCmn_PlaySFX__Fiiiiii,AudioCmn_Reset__Fv,AudioCmn_SoundCar__FP8Car_tObjiiiiiii,\
AudioCmn_TrafficSFX__Fiiiiiiii,AudioCmn_UnPause__Fv --lane-as=recon/game/common/audiocmn.cpp
```

| fn | words | status |
|---|---|---|
| AudioCmn_LoadAsyncSfx__FiiPvi | 99 | REGION-PASS |
| AudioCmn_MusicLevel__Fi | 14 | REGION-PASS |
| AudioCmn_PlayDoppleredSound__Fiiiiii | 153 | REGION-PASS |
| AudioCmn_PlaySFX__Fiiiiii | 343 | REGION-PASS |
| AudioCmn_Reset__Fv | 196 | REGION-PASS |
| AudioCmn_SoundCar__FP8Car_tObjiiiiiii | 540 | REGION-PASS |
| AudioCmn_TrafficSFX__Fiiiiiiii | 177 | REGION-PASS |
| AudioCmn_UnPause__Fv | 28 | REGION-PASS |

Candidate pre-existed (earlier wave) and was re-verified unedited — no changes made.

## Other pre-existing candidates — re-verified unedited, all REGION-PASS

| region | fn | words | insns | candidate | status |
|---|---|---|---|---|---|
| USA | GameSetup_StartUp__FPi | 263 | 263 | `recon/NFS4-R-USA/game/common/gmesetup.cpp` | REGION-PASS |
| USA | DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache | 52 | 52 | `recon/NFS4-R-USA/game/psx/draww.cpp` | REGION-PASS |
| USA | DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache | 26 | 26 | same | REGION-PASS |
| JPN | Confirm__Fii | 109 | 109 | `recon/NFS4-R-JPN/frontend/common/fememcard.cpp` | REGION-PASS |
| USA | MemCardCmd_cb | 28 | 141 | `recon/NFS4-R-USA/syslib/psx/libmcrd/LIBMCRD.c` | REGION-PASS |
| USA | func_800A7788 | 14 | 14 | `recon/NFS4-R-USA/regiononly/func_800A7788.cpp` | REGION-PASS |
| USA | func_800A780C | 6 | 6 | `recon/NFS4-R-USA/regiononly/func_800A780C.cpp` | REGION-PASS |
| AU | func_8009B580 | 192 | 192 | `recon/NFS4-R-AU/regiononly/func_8009B580.cpp` | REGION-PASS |

Gate lines used (each `--lane-as=recon/<unit>.<ext>`; region-only rows take no `--lane-as`):
```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/common/gmesetup.cpp GameSetup_StartUp__FPi --lane-as=recon/game/common/gmesetup.cpp
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/game/psx/draww.cpp DrawW_StripDraw_High__FP25Draw_tGiveShelbyMoreCache,DrawW_kCtrlWorld_High__FP25Draw_tGiveShelbyMoreCache --lane-as=recon/game/psx/draww.cpp
python regiondiff/tools/verify_region.py JPN regiondiff/recon/NFS4-R-JPN/frontend/common/fememcard.cpp Confirm__Fii --lane-as=recon/frontend/common/fememcard.cpp
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/syslib/psx/libmcrd/LIBMCRD.c MemCardCmd_cb --lane-as=recon/syslib/psx/libmcrd/LIBMCRD.c
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/regiononly/func_800A7788.cpp func_800A7788
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/regiononly/func_800A780C.cpp func_800A780C
python regiondiff/tools/verify_region.py AU regiondiff/recon/NFS4-R-AU/regiononly/func_8009B580.cpp func_8009B580
```
Note: `func_8009B580.cpp` (AU) is a 2-line redirect that `#define`s the USA sibling
`func_8009B57C` to the AU name and `#include`s it — the same body at a different
regional VA. Left as-is.

## stattool (USA, CHANGED, 2 fns) — the only real work in this batch

Candidate `regiondiff/recon/NFS4-R-USA/frontend/common/stattool.cpp` did NOT exist
(both rows TODO on the board). Seeded by copying `recon/frontend/common/stattool.cpp`
verbatim.

Gate command (used for every measurement below):
```
python regiondiff/tools/verify_region.py USA regiondiff/recon/NFS4-R-USA/frontend/common/stattool.cpp Stattool_nCreateIndex__FiPiPs,UserNameUpperCaseOneLetter__FPc --lane-as=recon/frontend/common/stattool.cpp
```

### MEASURE FIRST (unedited seed = the base body)
```
Stattool_nCreateIndex__FiPiPs:    FAIL 4 diffs (ours 77 / oracle 77)
    - slt v0,t0,v1        (ours)
    - beqz v0,T
    + slt v0,v1,t0        (oracle)
    + bnez v0,T
UserNameUpperCaseOneLetter__FPc:  FAIL 1 diffs (ours 71 / oracle 72)
    + jr ra               (oracle has one MORE insn)
```

### Regional delta 1 — `Stattool_nCreateIndex__FiPiPs` (77 words, @8004AD40)
**The retail insertion sort shifts on EQUAL keys.** The base body's inner-loop guard is
`nADummy < nTemp[j]` → `slt $v0,$t0,$v1 / beqz` (exit when `nADummy >= nTemp[j]`).
Oracle `.L8004ADF4` is `lw $v1,0($a1) / slt $v0,$v1,$t0 / bnez $v0,.L8004AE24` = exit
only when `nTemp[j] < nADummy`, i.e. the source condition is `nADummy <= nTemp[j]`
(`a <= b` lowers to `!(b < a)` = the oracle's operand order + inverted branch).
FIX = one character: `<` → `<=`. Not a codegen lever — a real behavioural retail change
(the sort stops being stable). **4 → REGION-PASS 77/77.**

### Regional delta 2 — `UserNameUpperCaseOneLetter__FPc` (72 words, @8004AF8C)
**Retail has the missing `break` on the `case 0xE8` arm.** Base build (@8004AB8C) ends
that arm on a bare `sb $v0,0($a0)` and FALLS THROUGH into `case 0xEC` — hence one insn
fewer than the region. The regional oracle `.L8004B064` is
`lui/lbu/li $v0,4 / bne $v1,$v0,.L8004B008 [ds: li $v0,69] / li $v0,200 / jr $ra / sb`,
i.e. the arm RETURNS, and gcc cross-jumps the `else *c = 0x45; return;` path straight
onto `case 0xE9`'s shared `jr $ra / sb` tail at `.L8004B008` (that is why the `bne`
carries `li $v0,69` in its delay slot). FIX = add `return;` after the if/else in the
0xE8 arm (the `case 0xF9 → default` fallthrough stays, retail keeps that one).
**1 → REGION-PASS 72/72.**

### Falsified angle (measured, reverted)
Removing the base TU's zero-insn identity fence
`int one = 1; __asm__ ("" : "=r"(one) : "0"(one));` in `Stattool_nCreateIndex`
(to make the candidate asm-free per the wave rule) **regresses the region to FAIL 2**:
`- addu s0,v0,zero` vs `+ li s0,1` — cse shares the guard's live `li $v0,1` into `i`
instead of rematerializing it in the `beq` delay slot. The fence is load-bearing for the
REGION exactly as it is for the base. It is **inherited verbatim from the sealed base TU**
(W57-A7), not introduced by this agent — kept under "copy the base TU verbatim" /
"preserve user edits". Flagging it for the orchestrator: if the wave's no-`__asm__` rule
is to be enforced here, it has to be resolved in the BASE tree first, since the regional
candidate can only inherit whatever spelling the base uses.

## Summary

17/17 rows REGION-PASS. 15 were pre-existing candidates re-verified unedited; the 2
stattool rows were the only real work (seeded + 2 source-level edits, both genuine
retail source deltas, no volatile / no new asm / no pins / no post-compile moves).
Files touched by this agent (candidates only, nothing in the base tree):
- `regiondiff/recon/NFS4-R-USA/frontend/common/stattool.cpp` (new)
- `scratchpad/w84/R07_receipt.md` (this file)
