# Function-local static scope census (2026-08-24)

Authoritative source: `C:\Temp\nfs4-clean\nfs4-f-v3.txt` (`STAT` records nested
inside function records).

The census found 54 function-local static records across the reconstructed
game/common, game/PSX, and frontend/common translation units. Every record was
checked against its owning source function.

- 40 records were already declared in the recorded function scope.
- Four game/PSX records were restored in P52: `lightningInit`, `fogstrspc`,
  `prevLookBehind`, and `prevCameraMode`.
- Seven game/common records are restored in this round: `resethud` in
  `DashHUD_HUDCalc`, plus `wasActive`, `testSFX`, `playingSFX`, `vol`,
  `SFXHandle`, and `lastplaytick` in `MPause_MusicLogic`.
- Three `audiocmn.cpp` records remain explicitly hoisted pending restoration of
  that TU's original declaration order: `compareTimes`, `lastImpactSample`, and
  `cobbleCount`.

The seven new declarations preserve both code and data layout. Detailed oracle
verification remains exact at 176/176 instructions for `DashHUD_HUDCalc` and
174/174 for `MPause_MusicLogic`. Their rebuilt object symbols are local:

```
dashhud.cpp.o .sbss+0x00 resethud.16
mpause.cpp.o  .sbss+0x00 wasActive.30
mpause.cpp.o  .sbss+0x01 testSFX.31
mpause.cpp.o  .sbss+0x02 playingSFX.32
mpause.cpp.o  .sbss+0x04 vol.33
mpause.cpp.o  .sbss+0x08 SFXHandle.34
mpause.cpp.o  .sbss+0x0c lastplaytick.35
```

The compiler-generated numeric suffixes are not source identifiers. Base names,
types, declaration order, storage class, and offsets agree with SYM.

## Measured `audiocmn.cpp` constraint

All three owning functions remain byte-exact when their declarations are moved
literally into function scope, but the rebuilt data offsets cease to match the
retail object:

| record | retail/current | literal local move |
|---|---:|---:|
| `compareTimes` | `.data+0x288` | `.data+0x954` |
| `lastImpactSample` | `.sdata+0x84` | `.sdata+0xf0` |
| `cobbleCount` | `.sdata+0x88` | `.sdata+0xf4` |

The failed literal move was reverted. This is positive evidence that the
remaining scope correction cannot be isolated: the original interleaving of
global declarations and function definitions must be restored so GCC encounters
these local statics at the retail points. Current object offsets remain exact,
and comments in `audiocmn.cpp` preserve this measured dependency.

## Gates

- `DashHUD_HUDCalc__Fi`: PASS, 176/176 instructions.
- `MPause_MusicLogic__Fc`: PASS, 174/174 instructions.
- `AudioCmn_GetTimePhrase__Fi`: PASS, 20/20 instructions.
- `ChooseImpactSample__Fi6s_typeT1`: PASS, 184/184 instructions.
- `AudioCmn_SoundCar__FP8Car_tObjiiiiiii`: PASS, 530/530 instructions.
- Frontend/common strict ownership audit: 0 missing and 0 extra globals.
- Game/PSX strict audit retains the P52 result: all four reliable hoisted
  function statics are restored; remaining extras are documented carriers.

