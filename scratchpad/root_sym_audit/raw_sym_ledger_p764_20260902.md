# Exhaustive raw SYM record ledger

Input: `C:\Temp\nfs4-clean\nfs4-f-v3.txt`

Parsing a record is not source validation. `Parsed` below means the
record has a stable identity and typed family; semantic source checks
remain explicitly pending where listed.

## Coverage summary

- Raw decoded records: 340483
- Parsed into a known record family: 340483
- Unknown opcodes: 0
- Malformed Def/Def2 records: 0
- Function spans paired: 2581
- Header-owned function spans: 122
- Function structural errors: 0
- Lexical block maximum nesting: 22
- Lexical block structural errors: 0
- SLD streams paired: 215
- SLD line events: 79139
- SLD events mapped to a debug function address span: 74661
- SLD events outside debug function address spans: 4478
- SLD structural errors: 0

## Opcode ledger

| Opcode | Family | Records | Semantic validation |
|---|---|---:|---|
| `1` | linker_symbol | 127 | pending linker/section ownership |
| `2` | public_symbol | 4503 | pending exhaustive function/data classification |
| `6` | static_symbol | 372 | pending exhaustive static function/data classification |
| `80` | sld_inc_line | 19891 | pending source statement-order comparison |
| `82` | sld_inc_byte | 51916 | pending source statement-order comparison |
| `84` | sld_inc_word | 56 | pending source statement-order comparison |
| `86` | sld_set_line | 7276 | pending source statement-order comparison |
| `88` | sld_start | 215 | parsed stream ownership; source comparison pending |
| `8a` | sld_end | 215 | parsed stream boundary; source comparison pending |
| `8c` | function_start | 2581 | paired; header and declaration comparison pending |
| `8e` | function_end | 2581 | paired; source range comparison pending |
| `90` | block_start | 11206 | balanced; lexical source-scope comparison pending |
| `92` | block_end | 11206 | balanced; lexical source-scope comparison pending |
| `94` | definition | 140022 | class parsed; complete source type graph pending |
| `96` | definition2 | 88316 | class parsed; complete source type graph pending |

## Def/Def2 class ledger

- `MOS`: 125966
- `TPDEF`: 40875
- `EOS`: 14561
- `STRTAG`: 13041
- `MOE`: 11454
- `REG`: 7098
- `REGPARM`: 4099
- `EXT`: 3390
- `FIELD`: 2218
- `AUTO`: 1476
- `ENTAG`: 1348
- `FILE`: 1038
- `MOU`: 720
- `ARG`: 545
- `STAT`: 332
- `UNTAG`: 172
- `LABEL`: 5

## Header-emitted function queue

- `C:\nfs4\FRONTEND\COMMON\FEDIALOG.H`: 10
- `C:\nfs4\FRONTEND\COMMON\FEMENU.H`: 2
- `C:\nfs4\FRONTEND\COMMON\FEMENUEXTENDED.H`: 7
- `C:\nfs4\FRONTEND\COMMON\FEMENUOPTIONS.H`: 13
- `C:\nfs4\FRONTEND\COMMON\FESCREEN.H`: 2
- `C:\nfs4\FRONTEND\COMMON\SCREENAUDIO.H`: 1
- `C:\nfs4\FRONTEND\COMMON\SCREENCARSELECT.H`: 3
- `C:\nfs4\FRONTEND\COMMON\SCREENCONGRATS.H`: 5
- `C:\nfs4\FRONTEND\COMMON\SCREENCONTROLLER.H`: 1
- `C:\nfs4\FRONTEND\COMMON\SCREENDISPLAY.H`: 1
- `C:\nfs4\FRONTEND\COMMON\SCREENMAIN.H`: 1
- `C:\nfs4\FRONTEND\COMMON\SCREENMEMCARD.H`: 1
- `C:\nfs4\FRONTEND\COMMON\SCREENPINKSLIPS.H`: 1
- `C:\nfs4\FRONTEND\COMMON\SCREENPOST.H`: 4
- `C:\nfs4\FRONTEND\COMMON\SCREENTRACKINFO.H`: 1
- `C:\nfs4\FRONTEND\COMMON\SCREENTRACKRECORDS.H`: 1
- `C:\nfs4\FRONTEND\COMMON\SCREENTRACKS.H`: 1
- `C:\nfs4\FRONTEND\COMMON\SCREENTROPHYINFO.H`: 1
- `C:\nfs4\FRONTEND\COMMON\SCREENUSERNAME.H`: 1
- `C:\nfs4\GAME\COMMON\AIDATARECORD.H`: 6
- `C:\nfs4\GAME\COMMON\AIHIGH.H`: 15
- `C:\nfs4\GAME\COMMON\AISTATE.H`: 22
- `C:\nfs4\GAME\COMMON\OBJECT.H`: 5
- `C:\nfs4\GAME\COMMON\PAUSEMENU.H`: 2
- `C:\nfs4\GAME\COMMON\SPEECH.H`: 15

## SLD source streams

- `C:\LIB\PSX\BLKFILL.ASM`: 366 line events
- `C:\LIB\PSX\BLKMOV.ASM`: 724 line events
- `C:\LIB\PSX\CRC.ASM`: 312 line events
- `C:\LIB\PSX\FIXDDIV.ASM`: 200 line events
- `C:\LIB\PSX\FIXDINV.ASM`: 120 line events
- `C:\LIB\PSX\FIXDMULT.ASM`: 138 line events
- `C:\LIB\PSX\FIXDSQRT.ASM`: 204 line events
- `C:\LIB\PSX\GETM.ASM`: 760 line events
- `C:\LIB\PSX\MATH64.ASM`: 156 line events
- `C:\LIB\PSX\NULLFUNC.ASM`: 176 line events
- `C:\LIB\PSX\RANDOM.ASM`: 338 line events
- `C:\LIB\PSX\SAVEGP.ASM`: 202 line events
- `C:\LIB\PSX\SHPDEPTH.ASM`: 120 line events
- `C:\LIB\PSX\SHPSUBS.ASM`: 284 line events
- `C:\LIB\PSX\SINFUNC.ASM`: 368 line events
- `C:\nfs4\FRONTEND\COMMON\FEAPP.CPP`: 724 line events
- `C:\nfs4\FRONTEND\COMMON\FEAUDIO.CPP`: 280 line events
- `C:\nfs4\FRONTEND\COMMON\FECARS.CPP`: 809 line events
- `C:\nfs4\FRONTEND\COMMON\FECHEATS.CPP`: 200 line events
- `C:\nfs4\FRONTEND\COMMON\FECREDITS.CPP`: 328 line events
- `C:\nfs4\FRONTEND\COMMON\FEDIALOG.CPP`: 599 line events
- `C:\nfs4\FRONTEND\COMMON\FEDIALOG.H`: 26 line events
- `C:\nfs4\FRONTEND\COMMON\FEFADES.CPP`: 62 line events
- `C:\nfs4\FRONTEND\COMMON\FEINPUT.CPP`: 90 line events
- `C:\nfs4\FRONTEND\COMMON\FELINES.CPP`: 38 line events
- `C:\nfs4\FRONTEND\COMMON\FEMEMCARD.CPP`: 652 line events
- `C:\nfs4\FRONTEND\COMMON\FEMENU.CPP`: 664 line events
- `C:\nfs4\FRONTEND\COMMON\FEMENU.H`: 7 line events
- `C:\nfs4\FRONTEND\COMMON\FEMENUDEFS.CPP`: 1128 line events
- `C:\nfs4\FRONTEND\COMMON\FEMENUEXTENDED.CPP`: 720 line events
- `C:\nfs4\FRONTEND\COMMON\FEMENUEXTENDED.H`: 17 line events
- `C:\nfs4\FRONTEND\COMMON\FEMENUOPTIONS.CPP`: 1585 line events
- `C:\nfs4\FRONTEND\COMMON\FEMENUOPTIONS.H`: 39 line events
- `C:\nfs4\FRONTEND\COMMON\FEMISSION.CPP`: 57 line events
- `C:\nfs4\FRONTEND\COMMON\FESCREEN.CPP`: 406 line events
- `C:\nfs4\FRONTEND\COMMON\FESCREEN.H`: 7 line events
- `C:\nfs4\FRONTEND\COMMON\FETEXTRENDER.CPP`: 330 line events
- `C:\nfs4\FRONTEND\COMMON\FETOOLS.CPP`: 122 line events
- `C:\nfs4\FRONTEND\COMMON\FETOURN.CPP`: 656 line events
- `C:\nfs4\FRONTEND\COMMON\FETRACKS.CPP`: 165 line events
- `C:\nfs4\FRONTEND\COMMON\FETV.CPP`: 311 line events
- `C:\nfs4\FRONTEND\COMMON\FEVIDEOWALL.CPP`: 194 line events
- `C:\nfs4\FRONTEND\COMMON\FRONT.CPP`: 1872 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENAUDIO.CPP`: 210 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENAUDIO.H`: 1 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENCARSELECT.CPP`: 1711 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENCARSELECT.H`: 7 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENCONGRATS.CPP`: 623 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENCONGRATS.H`: 13 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENCONTROLLER.CPP`: 943 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENCONTROLLER.H`: 4 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENDISPLAY.CPP`: 21 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENDISPLAY.H`: 1 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENMAIN.CPP`: 563 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENMAIN.H`: 1 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENMEMCARD.CPP`: 602 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENMEMCARD.H`: 4 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENPINKSLIPS.CPP`: 308 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENPINKSLIPS.H`: 1 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENPOST.CPP`: 233 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENPOST.H`: 10 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENTOURNSELECT.CPP`: 296 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENTRACKINFO.CPP`: 75 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENTRACKINFO.H`: 1 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENTRACKRECORDS.CPP`: 154 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENTRACKRECORDS.H`: 1 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENTRACKS.CPP`: 311 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENTRACKS.H`: 1 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENTROPHYINFO.CPP`: 82 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENTROPHYINFO.H`: 1 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENTROPHYROOM.CPP`: 191 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENUSERNAME.CPP`: 137 line events
- `C:\nfs4\FRONTEND\COMMON\SCREENUSERNAME.H`: 4 line events
- `C:\nfs4\FRONTEND\COMMON\STATCHK.CPP`: 285 line events
- `C:\nfs4\FRONTEND\COMMON\STATTOOL.CPP`: 197 line events
- `C:\NFS4\FRONTEND\PSX\ADDRESS.ASM`: 10 line events
- `C:\nfs4\FRONTEND\PSX\DRAWSHP.CPP`: 131 line events
- `C:\nfs4\FRONTEND\PSX\FETEXTURE.CPP`: 81 line events
- `C:\nfs4\FRONTEND\PSX\MDEC.CPP`: 131 line events
- `C:\nfs4\FRONTEND\PSX\MEMCARD.C`: 634 line events
- `C:\nfs4\FRONTEND\PSX\MMEFFECT.CPP`: 10 line events
- `C:\nfs4\FRONTEND\PSX\MOVIE.CPP`: 416 line events
- `C:\nfs4\FRONTEND\PSX\PSXFRONT.CPP`: 625 line events
- `C:\nfs4\FRONTEND\PSX\VIDEO.CPP`: 167 line events
- `C:\nfs4\GAME\COMMON\AI.CPP`: 1045 line events
- `C:\nfs4\GAME\COMMON\AICOP.CPP`: 72 line events
- `C:\nfs4\GAME\COMMON\AIDATARECORD.CPP`: 227 line events
- `C:\nfs4\GAME\COMMON\AIDATARECORD.H`: 17 line events
- `C:\nfs4\GAME\COMMON\AIDELAYCAR.CPP`: 84 line events
- `C:\nfs4\GAME\COMMON\AIH_BASICCOP.CPP`: 311 line events
- `C:\nfs4\GAME\COMMON\AIH_BASICPERP.CPP`: 224 line events
- `C:\nfs4\GAME\COMMON\AIH_BTCCOP.CPP`: 935 line events
- `C:\nfs4\GAME\COMMON\AIH_BTCPERP.CPP`: 640 line events
- `C:\nfs4\GAME\COMMON\AIH_COP.CPP`: 609 line events
- `C:\nfs4\GAME\COMMON\AIH_HUM.CPP`: 14 line events
- `C:\nfs4\GAME\COMMON\AIH_OPP.CPP`: 184 line events
- `C:\nfs4\GAME\COMMON\AIH_PLAY.CPP`: 571 line events
- `C:\nfs4\GAME\COMMON\AIH_TRAF.CPP`: 245 line events
- `C:\nfs4\GAME\COMMON\AIHIGH.CPP`: 115 line events
- `C:\nfs4\GAME\COMMON\AIHIGH.H`: 37 line events
- `C:\nfs4\GAME\COMMON\AIINIT.CPP`: 442 line events
- `C:\nfs4\GAME\COMMON\AILIFE.CPP`: 471 line events
- `C:\nfs4\GAME\COMMON\AIPERSON.CPP`: 236 line events
- `C:\nfs4\GAME\COMMON\AIPHYSIC.CPP`: 1241 line events
- `C:\nfs4\GAME\COMMON\AISCRIPT.CPP`: 112 line events
- `C:\nfs4\GAME\COMMON\AISPEEDS.CPP`: 717 line events
- `C:\nfs4\GAME\COMMON\AISTATE.CPP`: 980 line events
- `C:\nfs4\GAME\COMMON\AISTATE.H`: 70 line events
- `C:\nfs4\GAME\COMMON\AITRIGER.CPP`: 155 line events
- `C:\nfs4\GAME\COMMON\AITUNE.CPP`: 44 line events
- `C:\nfs4\GAME\COMMON\AIWORLD.CPP`: 310 line events
- `C:\nfs4\GAME\COMMON\ANIM.CPP`: 329 line events
- `C:\nfs4\GAME\COMMON\AUDEDIT.CPP`: 16 line events
- `C:\nfs4\GAME\COMMON\AUDIOCLC.CPP`: 614 line events
- `C:\nfs4\GAME\COMMON\AUDIOCMN.CPP`: 1470 line events
- `C:\nfs4\GAME\COMMON\AUDIOENG.CPP`: 462 line events
- `C:\nfs4\GAME\COMMON\AUDIOMUS.CPP`: 667 line events
- `C:\nfs4\GAME\COMMON\AUDIOTRK.CPP`: 422 line events
- `C:\nfs4\GAME\COMMON\BWORLD.CPP`: 593 line events
- `C:\nfs4\GAME\COMMON\BWORLDSM.CPP`: 760 line events
- `C:\nfs4\GAME\COMMON\CAMERA.CPP`: 1761 line events
- `C:\nfs4\GAME\COMMON\CARS.CPP`: 1692 line events
- `C:\nfs4\GAME\COMMON\CHUNK.CPP`: 166 line events
- `C:\nfs4\GAME\COMMON\CLOCK.CPP`: 56 line events
- `C:\nfs4\GAME\COMMON\COLLIDE.CPP`: 1424 line events
- `C:\nfs4\GAME\COMMON\COLOR.CPP`: 26 line events
- `C:\nfs4\GAME\COMMON\CONTROL.CPP`: 139 line events
- `C:\nfs4\GAME\COMMON\COPSPEAK.CPP`: 760 line events
- `C:\nfs4\GAME\COMMON\DASHHUD.CPP`: 142 line events
- `C:\nfs4\GAME\COMMON\FASTRAND.CPP`: 19 line events
- `C:\nfs4\GAME\COMMON\GENERICPMX.CPP`: 189 line events
- `C:\nfs4\GAME\COMMON\GMESETUP.CPP`: 95 line events
- `C:\nfs4\GAME\COMMON\GROUP.CPP`: 74 line events
- `C:\nfs4\GAME\COMMON\HUDPMX.CPP`: 118 line events
- `C:\nfs4\GAME\COMMON\INPUT.CPP`: 368 line events
- `C:\nfs4\GAME\COMMON\MATHNFS.CPP`: 332 line events
- `C:\nfs4\GAME\COMMON\MINFRONT.CPP`: 8 line events
- `C:\nfs4\GAME\COMMON\MPAUSE.CPP`: 286 line events
- `C:\nfs4\GAME\COMMON\NEW.CPP`: 21 line events
- `C:\nfs4\GAME\COMMON\NEWTON.CPP`: 2021 line events
- `C:\nfs4\GAME\COMMON\NFS3.CPP`: 350 line events
- `C:\nfs4\GAME\COMMON\OBJECT.CPP`: 980 line events
- `C:\nfs4\GAME\COMMON\OBJECT.H`: 27 line events
- `C:\nfs4\GAME\COMMON\PATHS.CPP`: 10 line events
- `C:\nfs4\GAME\COMMON\PAUSEMENU.CPP`: 552 line events
- `C:\nfs4\GAME\COMMON\PAUSEMENU.H`: 7 line events
- `C:\nfs4\GAME\COMMON\PHYSICS.CPP`: 1639 line events
- `C:\nfs4\GAME\COMMON\QUATERN.CPP`: 151 line events
- `C:\nfs4\GAME\COMMON\R3DCAR.CPP`: 2068 line events
- `C:\nfs4\GAME\COMMON\RENDER.CPP`: 339 line events
- `C:\nfs4\GAME\COMMON\REPLAY.CPP`: 623 line events
- `C:\nfs4\GAME\COMMON\SCENE.CPP`: 65 line events
- `C:\nfs4\GAME\COMMON\SCHEDULE.CPP`: 121 line events
- `C:\nfs4\GAME\COMMON\SIM.CPP`: 387 line events
- `C:\nfs4\GAME\COMMON\SIMPLEMEM.CPP`: 29 line events
- `C:\nfs4\GAME\COMMON\SIMQUEUE.CPP`: 113 line events
- `C:\nfs4\GAME\COMMON\SOUFFLE.CPP`: 246 line events
- `C:\nfs4\GAME\COMMON\SPCHEVNT.C`: 870 line events
- `C:\nfs4\GAME\COMMON\SPEECH.CPP`: 1792 line events
- `C:\nfs4\GAME\COMMON\SPEECH.H`: 52 line events
- `C:\nfs4\GAME\COMMON\STATS.CPP`: 375 line events
- `C:\nfs4\GAME\COMMON\TEXTSYS.CPP`: 63 line events
- `C:\nfs4\GAME\COMMON\TRACK.CPP`: 762 line events
- `C:\nfs4\GAME\COMMON\TRGSFX.CPP`: 224 line events
- `C:\nfs4\GAME\COMMON\UDFF.CPP`: 46 line events
- `C:\nfs4\GAME\PSX\AUDIO.CPP`: 113 line events
- `C:\nfs4\GAME\PSX\CARIO.CPP`: 559 line events
- `C:\nfs4\GAME\PSX\DEVICE.CPP`: 198 line events
- `C:\nfs4\GAME\PSX\DRAW.CPP`: 342 line events
- `C:\nfs4\GAME\PSX\DRAWC.CPP`: 2652 line events
- `C:\nfs4\GAME\PSX\DRAWW.CPP`: 2654 line events
- `C:\nfs4\GAME\PSX\FE3DMENU.CPP`: 221 line events
- `C:\nfs4\GAME\PSX\FLARE.CPP`: 1235 line events
- `C:\nfs4\GAME\PSX\FONT.CPP`: 341 line events
- `C:\nfs4\GAME\PSX\FORCE.CPP`: 219 line events
- `C:\nfs4\GAME\PSX\HRZSKU.CPP`: 1038 line events
- `C:\nfs4\GAME\PSX\HUD.CPP`: 2749 line events
- `C:\nfs4\GAME\PSX\LOADING.CPP`: 49 line events
- `C:\nfs4\GAME\PSX\NIGHT.CPP`: 519 line events
- `C:\nfs4\GAME\PSX\OVERLAYS.CPP`: 409 line events
- `C:\nfs4\GAME\PSX\PLATFORM.CPP`: 75 line events
- `C:\nfs4\GAME\PSX\PSXCONTROLLER.CPP`: 124 line events
- `C:\nfs4\GAME\PSX\RPAUSE.CPP`: 39 line events
- `C:\nfs4\GAME\PSX\SFX.CPP`: 277 line events
- `C:\nfs4\GAME\PSX\SKIDMARK.CPP`: 304 line events
- `C:\nfs4\GAME\PSX\TEXTPIX.C`: 30 line events
- `C:\nfs4\GAME\PSX\TEXTPSX.C`: 13 line events
- `C:\nfs4\GAME\PSX\TEXTURE.CPP`: 599 line events
- `C:\nfs4\GAME\PSX\TEXTUREPROCESS.CPP`: 343 line events
- `C:\nfs4\GAME\PSX\TRACKSPEC.CPP`: 162 line events
- `C:\nfs4\GAME\PSX\TRSPROJ.CPP`: 130 line events
- `C:\nfs4\GAME\PSX\UNPACK.C`: 43 line events
- `C:\nfs4\GAME\PSX\WEATHER.CPP`: 841 line events
- `D:\nfs4\EACLIB\PSX\PAD.C`: 79 line events

## SLD events outside debug function spans

- `C:\LIB\PSX\BLKFILL.ASM`: 366
- `C:\LIB\PSX\BLKMOV.ASM`: 724
- `C:\LIB\PSX\CRC.ASM`: 312
- `C:\LIB\PSX\FIXDDIV.ASM`: 200
- `C:\LIB\PSX\FIXDINV.ASM`: 120
- `C:\LIB\PSX\FIXDMULT.ASM`: 138
- `C:\LIB\PSX\FIXDSQRT.ASM`: 204
- `C:\LIB\PSX\GETM.ASM`: 760
- `C:\LIB\PSX\MATH64.ASM`: 156
- `C:\LIB\PSX\NULLFUNC.ASM`: 176
- `C:\LIB\PSX\RANDOM.ASM`: 338
- `C:\LIB\PSX\SAVEGP.ASM`: 202
- `C:\LIB\PSX\SHPDEPTH.ASM`: 120
- `C:\LIB\PSX\SHPSUBS.ASM`: 284
- `C:\LIB\PSX\SINFUNC.ASM`: 368
- `C:\NFS4\FRONTEND\PSX\ADDRESS.ASM`: 10

## Structural errors

- None; all parsed function, block, and SLD boundaries are balanced.

## Unknown/malformed records

- None.

## Semantic symbol surface

This cross-check covers the compact/linker symbol families that are
not equivalent to `8c/8e` debug functions or `Def/Def2` declarations.

### Function provenance

- debug-function: 2581
- compact-only-function: 800
- map-only-function: 107

### Compact symbols versus `configs/symbol_addrs.txt`

| Opcode | Records | Exact name+VA | VA alias only | Absent VA |
|---|---:|---:|---:|---:|
| `2` | 4503 | 4237 | 266 | 0 |
| `6` | 372 | 147 | 38 | 187 |

Compact records absent from the config by VA:

- typed-exact: 153
- typed-va-alias: 0
- debug-function: 0
- source-restored: 34
- compact-only: 0

Evidence-reviewed compact-only source homes:

- `sym@0x012b8d` `0x800fc4e4` `locaterequest` -> `recon/eaclib/psx/eacpsxz/stream.c` (`locaterequest`; file-static function)
- `sym@0x019464` `0x8013dd88` `lastX.64` -> `recon/game/common/camera.cpp` (`lastX`; Camera_UpdateTVCam function-local static int[2])
- `sym@0x019472` `0x8013dd90` `lastY.65` -> `recon/game/common/camera.cpp` (`lastY`; Camera_UpdateTVCam function-local static int[2])
- `sym@0x0194d3` `0x8013ddb0` `resethud.28` -> `recon/game/common/dashhud.cpp` (`resethud`; DashHUD_HUDCalc function-local static int)
- `sym@0x0194e4` `0x8013ddb4` `tick32.32` -> `recon/game/common/dashhud.cpp` (`tick32`; DashHUD_HUDCalc function-local static int)
- `sym@0x0195d2` `0x8013dde4` `failtime.98` -> `recon/game/psx/device.cpp` (`failtime`; Device_Fail function-local static u_char[2])
- `sym@0x019633` `0x8013de00` `countdownTick.216` -> `recon/game/psx/hud.cpp` (`countdownTick`; Hud_Render321Go function-local static u_long)
- `sym@0x01978c` `0x8013de60` `bighandle` -> `recon/eaclib/psx/eacpsxz/locatbig.c` (`bighandle`; file-static int)
- `sym@0x019804` `0x8013de90` `readblocksize` -> `recon/eaclib/psx/eacpsxz/nasync.c` (`readblocksize`; file-static int)
- `sym@0x019817` `0x8013de94` `numrequests` -> `recon/eaclib/psx/eacpsxz/nasync.c` (`numrequests`; file-static int)
- `sym@0x019828` `0x8013de98` `request` -> `recon/eaclib/psx/eacpsxz/nasync.c` (`request`; file-static AsyncReq pointer)
- `sym@0x019835` `0x8013dea0` `freequeue` -> `recon/eaclib/psx/eacpsxz/nasync.c` (`freequeue`; file-static AsyncQueue)
- `sym@0x019844` `0x8013dea8` `callqueue` -> `recon/eaclib/psx/eacpsxz/nasync.c` (`callqueue`; file-static AsyncQueue)
- `sym@0x019853` `0x8013deb0` `asyncfilehandle` -> `recon/eaclib/psx/eacpsxz/nasync.c` (`asyncfilehandle`; file-static int)
- `sym@0x019868` `0x8013deb4` `asyncfileoffset` -> `recon/eaclib/psx/eacpsxz/nasync.c` (`asyncfileoffset`; file-static int)
- `sym@0x01987d` `0x8013deb8` `requestidcounter` -> `recon/eaclib/psx/eacpsxz/nasync.c` (`requestidcounter`; file-static int)
- `sym@0x019893` `0x8013debc` `mutex` -> `recon/eaclib/psx/eacpsxz/nasync.c` (`mutex`; file-static void pointer)
- `sym@0x0198bf` `0x8013dec8` `SQVclue` -> `recon/eaclib/psx/eacpsxz/unbtree.c + recon/eaclib/psx/eacpsxz/unref.c` (`SQVclue`; shared tentative signed-char pointer, unbtree decompressor state)
- `sym@0x0198cc` `0x8013decc` `SQVleft` -> `recon/eaclib/psx/eacpsxz/unbtree.c + recon/eaclib/psx/eacpsxz/unref.c` (`SQVleft`; shared tentative unsigned-char pointer, unbtree decompressor state)
- `sym@0x0198d9` `0x8013ded0` `SQVright` -> `recon/eaclib/psx/eacpsxz/unbtree.c + recon/eaclib/psx/eacpsxz/unref.c` (`SQVright`; shared tentative unsigned-char pointer, unbtree decompressor state)
- `sym@0x0198e7` `0x8013ded4` `SQVs` -> `recon/eaclib/psx/eacpsxz/unbtree.c + recon/eaclib/psx/eacpsxz/unref.c` (`SQVs`; shared tentative unsigned-char source pointer, unbtree decompressor state)
- `sym@0x0198f1` `0x8013ded8` `SQVd` -> `recon/eaclib/psx/eacpsxz/unbtree.c + recon/eaclib/psx/eacpsxz/unref.c` (`SQVd`; shared tentative unsigned-char destination pointer, unbtree decompressor state)
- `sym@0x0198fb` `0x8013dedc` `requestidcounter` -> `recon/eaclib/psx/eacpsxz/stream.c` (`requestidcounter`; file-static unsigned int)
- `sym@0x019935` `0x8013dfc4` `corrPt.47` -> `recon/game/common/bworldSm.cpp` (`corrPt`; FindClosestQuad function-local static coorddef)
- `sym@0x019944` `0x8013dfd0` `lastOppVector.106` -> `recon/game/common/camera.cpp` (`lastOppVector`; Camera_OpponentLookBehind function-local static coorddef[2])
- `sym@0x0199c0` `0x8013e0b0` `Copspeak_gTimeString.308` -> `recon/game/common/copspeak.cpp` (`Copspeak_gTimeString`; CopSpeak_Debug function-local static char[16])
- `sym@0x0199ed` `0x8013e0d8` `dummy.124` -> `recon/game/common/newton.cpp` (`dummy`; Newton_CalcDistToClosestPlayerCar block-local static coorddef)
- `sym@0x0199fc` `0x8013e0e8` `dummy.133` -> `recon/game/common/newton.cpp` (`dummy`; Newton_SetInitialSlicePositionOrientationEtc block-local static coorddef)
- `sym@0x019a1b` `0x8013e300` `strspc.42` -> `recon/game/common/track.cpp` (`strspc`; Track_MakeTrackPathName function-local static char[64])
- `sym@0x019a2a` `0x8013e340` `strspc.45` -> `recon/game/common/track.cpp` (`strspc`; Track_MakeTrackDataPathName function-local static char[64])
- `sym@0x019aa3` `0x8013e85c` `fogstrspc.36` -> `recon/game/psx/textureprocess.cpp` (`fogstrspc`; Fog_MakeTrackPathName function-local static char[64])
- `sym@0x019ae0` `0x8013e940` `bigfilename` -> `recon/eaclib/psx/eacpsxz/locatbig.c` (`bigfilename`; file-static char[64])
- `sym@0x019af1` `0x8013e980` `systemtasksubs` -> `recon/eaclib/psx/eacpsxz/systask.c` (`systemtasksubs`; file-static SYSTEM_TASK_SUB[16])
- `sym@0x024e45` `0x80052bf0` `flareextra.248` -> `recon/frontend/common/femenuoptions.cpp` (`flareextra`; tMenuItemSlidingMenu::Draw function-local static int)

Compact-only static/data backlog:


Static compact records covered only by a different config name at
the same VA (exact retail spelling still requires disposition):

- `sym@0x001624` `0x8005b438` `_._15AIHigh_BTC_Perp` -> `___15AIHigh_BTC_Perp`
- `sym@0x00165e` `0x8005b468` `_._11AIHigh_None` -> `___11AIHigh_None`
- `sym@0x001691` `0x8005b490` `_._12AIState_None` -> `___12AIState_None`
- `sym@0x0016cc` `0x8005b4cc` `_._12AIState_Base` -> `___12AIState_Base`
- `sym@0x0019a8` `0x8005cb4c` `_._15AIHigh_BasicCop` -> `___15AIHigh_BasicCop`
- `sym@0x0020ab` `0x8005f62c` `_._17AIState_NonActive` -> `___17AIState_NonActive`
- `sym@0x0020c7` `0x8005f678` `TestForRelease__12AIState_Base` -> `TestForRelease__12AIState_Base_8005F678`
- `sym@0x0020eb` `0x8005f680` `_._12AIState_Base` -> `___12AIState_Base_8005F680`
- `sym@0x002495` `0x80061348` `_._15AIHigh_BTC_Perp` -> `___15AIHigh_BTC_Perp_80061348`
- `sym@0x0024af` `0x80061370` `Execute__17AIState_NonActive` -> `Execute__17AIState_NonActive_80061370`
- `sym@0x0024d1` `0x80061378` `_._17AIState_NonActive` -> `___17AIState_NonActive_80061378`
- `sym@0x0024ed` `0x800613c4` `TestForRelease__12AIState_Base` -> `TestForRelease__12AIState_Base_800613C4`
- `sym@0x002511` `0x800613cc` `_._12AIState_Base` -> `___12AIState_Base_800613CC`
- `sym@0x002684` `0x80063248` `_._13AIHigh_Player` -> `___13AIHigh_Player`
- `sym@0x003c6c` `0x8006d514` `_._26AIDataRecord_CarTracking_t` -> `___26AIDataRecord_CarTracking_t`
- `sym@0x003c91` `0x8006d534` `_._30AIDataRecord_CurveSpeedTable_t` -> `___30AIDataRecord_CurveSpeedTable_t`
- `sym@0x003cba` `0x8006d554` `_._25AIDataRecord_TrackCurve_t` -> `___25AIDataRecord_TrackCurve_t`
- `sym@0x003cde` `0x8006d574` `_._23AIDataRecord_BestLine_t` -> `___23AIDataRecord_BestLine_t`
- `sym@0x004aa7` `0x80072750` `Execute__17AIState_NonActive` -> `Execute__17AIState_NonActive_80072750`
- `sym@0x004ac9` `0x80072758` `_._17AIState_NonActive` -> `___17AIState_NonActive_80072758`
- `sym@0x004b15` `0x80072830` `TestForRelease__12AIState_Base` -> `TestForRelease__12AIState_Base_80072830`
- `sym@0x004b39` `0x80072838` `_._12AIState_Base` -> `___12AIState_Base_80072838`
- `sym@0x00a8f4` `0x800a6de0` `_._10ObjectAnim` -> `___10ObjectAnim`
- `sym@0x013177` `0x8010073c` `VoxEvent_GetFilterLengthFlag` -> `VoxEvent_GetFilterLengthFlag_8010073C`
- `sym@0x0131af` `0x80100760` `iSPCH_GetOffset16` -> `iSPCH_GetOffset16_80100760`
- `sym@0x01425d` `0x8010b100` `VoxSentence_GetNumPhrases` -> `VoxSentence_GetNumPhrases_8010B100`
- `sym@0x01427c` `0x8010b10c` `iSPCH_GetOffset8` -> `iSPCH_GetOffset8_8010B10C`
- `sym@0x014292` `0x8010b124` `iSPCH_GetOffset16` -> `iSPCH_GetOffset16_8010B124`
- `sym@0x019418` `0x8013dd7c` `AIState_Purgatory_numTrafficCarsInPurgatory` -> `_bss_obj`
- `sym@0x019621` `0x8013ddf8` `moonPosInSky` -> `moonPosInSky_vx`
- `sym@0x019911` `0x8013dee0` `spos.118` -> `__bss_org`
- `sym@0x01aa59` `0x80015760` `_._31tDialogMessageStringWithTimeout` -> `___31tDialogMessageStringWithTimeout`
- `sym@0x01b817` `0x80019f24` `_._18tDialogInteractive` -> `___18tDialogInteractive`
- `sym@0x01f213` `0x8002bf0c` `_._11tAllScreens` -> `___11tAllScreens`
- `sym@0x01fe04` `0x800321d8` `_._32tBlankMenuItemGoToMenuNFS4Button` -> `___32tBlankMenuItemGoToMenuNFS4Button`
- `sym@0x01fea0` `0x80032208` `_._33tBlankMenuItemNFS4LeftRightChoice` -> `___33tBlankMenuItemNFS4LeftRightChoice`
- `sym@0x0210d4` `0x8003a8f0` `TransformVector__FRA4_iRA4_A4_iT0` -> `TransformVector`
- `sym@0x024dd0` `0x80052b38` `DialogVisibilityList` -> `_front_data_orgend`

### Linker/section symbols

- Opcode-1 records: 127
- Exact name+VA in symbol config: 14
- Name declared by retail linker-alias script: 113
- Name declared by a linker/assembly source unit: 0
- No exact config, alias, linker, or assembly declaration: 0

Unrestored linker/section names:


## Completion boundary

This ledger proves exhaustive parsing and structural accounting only.
The active restoration goal remains incomplete until every pending
semantic state in the opcode table is validated against C/C++ source,
all SLD line/block ownership is checked, and synthetic identifiers are
eliminated or converted to evidenced semantic carriers.
