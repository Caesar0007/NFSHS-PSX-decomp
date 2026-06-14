.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InGame_GetPSXPadValue__Fii, 0x3A4

glabel InGame_GetPSXPadValue__Fii
    /* CD190 800DC990 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* CD194 800DC994 1400B1AF */  sw         $s1, 0x14($sp)
    /* CD198 800DC998 2188A000 */  addu       $s1, $a1, $zero
    /* CD19C 800DC99C 1000B0AF */  sw         $s0, 0x10($sp)
    /* CD1A0 800DC9A0 1800BFAF */  sw         $ra, 0x18($sp)
    /* CD1A4 800DC9A4 8490030C */  jal        PAD_update
    /* CD1A8 800DC9A8 21808000 */   addu      $s0, $a0, $zero
    /* CD1AC 800DC9AC 1480023C */  lui        $v0, %hi(gPadinfo)
    /* CD1B0 800DC9B0 9CE84224 */  addiu      $v0, $v0, %lo(gPadinfo)
    /* CD1B4 800DC9B4 40191100 */  sll        $v1, $s1, 5
    /* CD1B8 800DC9B8 21186200 */  addu       $v1, $v1, $v0
    /* CD1BC 800DC9BC 04006290 */  lbu        $v0, 0x4($v1)
    /* CD1C0 800DC9C0 00000000 */  nop
    /* CD1C4 800DC9C4 04004014 */  bnez       $v0, .L800DC9D8
    /* CD1C8 800DC9C8 53000224 */   addiu     $v0, $zero, 0x53
    /* CD1CC 800DC9CC 05006390 */  lbu        $v1, 0x5($v1)
    /* CD1D0 800DC9D0 77720308 */  j          .L800DC9DC
    /* CD1D4 800DC9D4 00000000 */   nop
  .L800DC9D8:
    /* CD1D8 800DC9D8 21180000 */  addu       $v1, $zero, $zero
  .L800DC9DC:
    /* CD1DC 800DC9DC 0A006210 */  beq        $v1, $v0, .L800DCA08
    /* CD1E0 800DC9E0 54006228 */   slti      $v0, $v1, 0x54
    /* CD1E4 800DC9E4 05004010 */  beqz       $v0, .L800DC9FC
    /* CD1E8 800DC9E8 23000224 */   addiu     $v0, $zero, 0x23
    /* CD1EC 800DC9EC 84006210 */  beq        $v1, $v0, .L800DCC00
    /* CD1F0 800DC9F0 80161100 */   sll       $v0, $s1, 26
    /* CD1F4 800DC9F4 46730308 */  j          .L800DCD18
    /* CD1F8 800DC9F8 001A1000 */   sll       $v1, $s0, 8
  .L800DC9FC:
    /* CD1FC 800DC9FC 73000224 */  addiu      $v0, $zero, 0x73
    /* CD200 800DCA00 C4006214 */  bne        $v1, $v0, .L800DCD14
    /* CD204 800DCA04 80161100 */   sll       $v0, $s1, 26
  .L800DCA08:
    /* CD208 800DCA08 4000023C */  lui        $v0, (0x400000 >> 16)
    /* CD20C 800DCA0C 43000212 */  beq        $s0, $v0, .L800DCB1C
    /* CD210 800DCA10 80281100 */   sll       $a1, $s1, 2
    /* CD214 800DCA14 2A105000 */  slt        $v0, $v0, $s0
    /* CD218 800DCA18 10004014 */  bnez       $v0, .L800DCA5C
    /* CD21C 800DCA1C 0010023C */   lui       $v0, (0x10000000 >> 16)
    /* CD220 800DCA20 1000023C */  lui        $v0, (0x100000 >> 16)
    /* CD224 800DCA24 32000212 */  beq        $s0, $v0, .L800DCAF0
    /* CD228 800DCA28 80000424 */   addiu     $a0, $zero, 0x80
    /* CD22C 800DCA2C 2A105000 */  slt        $v0, $v0, $s0
    /* CD230 800DCA30 06004014 */  bnez       $v0, .L800DCA4C
    /* CD234 800DCA34 2000023C */   lui       $v0, (0x200000 >> 16)
    /* CD238 800DCA38 0080023C */  lui        $v0, (0x80000000 >> 16)
    /* CD23C 800DCA3C 42000212 */  beq        $s0, $v0, .L800DCB48
    /* CD240 800DCA40 80371100 */   sll       $a2, $s1, 30
    /* CD244 800DCA44 45730308 */  j          .L800DCD14
    /* CD248 800DCA48 80161100 */   sll       $v0, $s1, 26
  .L800DCA4C:
    /* CD24C 800DCA4C 1C000212 */  beq        $s0, $v0, .L800DCAC0
    /* CD250 800DCA50 80281100 */   sll       $a1, $s1, 2
    /* CD254 800DCA54 45730308 */  j          .L800DCD14
    /* CD258 800DCA58 80161100 */   sll       $v0, $s1, 26
  .L800DCA5C:
    /* CD25C 800DCA5C 48000212 */  beq        $s0, $v0, .L800DCB80
    /* CD260 800DCA60 80281100 */   sll       $a1, $s1, 2
    /* CD264 800DCA64 2A105000 */  slt        $v0, $v0, $s0
    /* CD268 800DCA68 06004014 */  bnez       $v0, .L800DCA84
    /* CD26C 800DCA6C 0020023C */   lui       $v0, (0x20000000 >> 16)
    /* CD270 800DCA70 8000023C */  lui        $v0, (0x800000 >> 16)
    /* CD274 800DCA74 0A000212 */  beq        $s0, $v0, .L800DCAA0
    /* CD278 800DCA78 80201100 */   sll       $a0, $s1, 2
    /* CD27C 800DCA7C 45730308 */  j          .L800DCD14
    /* CD280 800DCA80 80161100 */   sll       $v0, $s1, 26
  .L800DCA84:
    /* CD284 800DCA84 37000212 */  beq        $s0, $v0, .L800DCB64
    /* CD288 800DCA88 80281100 */   sll       $a1, $s1, 2
    /* CD28C 800DCA8C 0040023C */  lui        $v0, (0x40000000 >> 16)
    /* CD290 800DCA90 4C000212 */  beq        $s0, $v0, .L800DCBC4
    /* CD294 800DCA94 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* CD298 800DCA98 45730308 */  j          .L800DCD14
    /* CD29C 800DCA9C 80161100 */   sll       $v0, $s1, 26
  .L800DCAA0:
    /* CD2A0 800DCAA0 802F1100 */  sll        $a1, $s1, 30
    /* CD2A4 800DCAA4 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* CD2A8 800DCAA8 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* CD2AC 800DCAAC 21208200 */  addu       $a0, $a0, $v0
    /* CD2B0 800DCAB0 8800828C */  lw         $v0, 0x88($a0)
    /* CD2B4 800DCAB4 9000848C */  lw         $a0, 0x90($a0)
    /* CD2B8 800DCAB8 1A730308 */  j          .L800DCC68
    /* CD2BC 800DCABC 80000324 */   addiu     $v1, $zero, 0x80
  .L800DCAC0:
    /* CD2C0 800DCAC0 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* CD2C4 800DCAC4 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* CD2C8 800DCAC8 2128A200 */  addu       $a1, $a1, $v0
    /* CD2CC 800DCACC 80271100 */  sll        $a0, $s1, 30
    /* CD2D0 800DCAD0 8800A38C */  lw         $v1, 0x88($a1)
    /* CD2D4 800DCAD4 9000A28C */  lw         $v0, 0x90($a1)
    /* CD2D8 800DCAD8 80006324 */  addiu      $v1, $v1, 0x80
    /* CD2DC 800DCADC 001C0300 */  sll        $v1, $v1, 16
    /* CD2E0 800DCAE0 25208300 */  or         $a0, $a0, $v1
    /* CD2E4 800DCAE4 80004224 */  addiu      $v0, $v0, 0x80
    /* CD2E8 800DCAE8 3D730308 */  j          .L800DCCF4
    /* CD2EC 800DCAEC 00120200 */   sll       $v0, $v0, 8
  .L800DCAF0:
    /* CD2F0 800DCAF0 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* CD2F4 800DCAF4 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* CD2F8 800DCAF8 2128A200 */  addu       $a1, $a1, $v0
    /* CD2FC 800DCAFC 8800A28C */  lw         $v0, 0x88($a1)
    /* CD300 800DCB00 0001033C */  lui        $v1, (0x1000001 >> 16)
    /* CD304 800DCB04 23108200 */  subu       $v0, $a0, $v0
    /* CD308 800DCB08 00140200 */  sll        $v0, $v0, 16
    /* CD30C 800DCB0C 25104300 */  or         $v0, $v0, $v1
    /* CD310 800DCB10 9000A38C */  lw         $v1, 0x90($a1)
    /* CD314 800DCB14 EB720308 */  j          .L800DCBAC
    /* CD318 800DCB18 80371100 */   sll       $a2, $s1, 30
  .L800DCB1C:
    /* CD31C 800DCB1C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* CD320 800DCB20 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* CD324 800DCB24 2128A200 */  addu       $a1, $a1, $v0
    /* CD328 800DCB28 8800A28C */  lw         $v0, 0x88($a1)
    /* CD32C 800DCB2C 0001033C */  lui        $v1, (0x1000001 >> 16)
    /* CD330 800DCB30 80004224 */  addiu      $v0, $v0, 0x80
    /* CD334 800DCB34 00140200 */  sll        $v0, $v0, 16
    /* CD338 800DCB38 25104300 */  or         $v0, $v0, $v1
    /* CD33C 800DCB3C 9000A38C */  lw         $v1, 0x90($a1)
    /* CD340 800DCB40 FA720308 */  j          .L800DCBE8
    /* CD344 800DCB44 80271100 */   sll       $a0, $s1, 30
  .L800DCB48:
    /* CD348 800DCB48 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* CD34C 800DCB4C EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* CD350 800DCB50 2128A200 */  addu       $a1, $a1, $v0
    /* CD354 800DCB54 80000424 */  addiu      $a0, $zero, 0x80
    /* CD358 800DCB58 9800A28C */  lw         $v0, 0x98($a1)
    /* CD35C 800DCB5C E7720308 */  j          .L800DCB9C
    /* CD360 800DCB60 0002033C */   lui       $v1, (0x2000001 >> 16)
  .L800DCB64:
    /* CD364 800DCB64 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* CD368 800DCB68 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* CD36C 800DCB6C 2128A200 */  addu       $a1, $a1, $v0
    /* CD370 800DCB70 80271100 */  sll        $a0, $s1, 30
    /* CD374 800DCB74 9800A28C */  lw         $v0, 0x98($a1)
    /* CD378 800DCB78 F6720308 */  j          .L800DCBD8
    /* CD37C 800DCB7C 0002033C */   lui       $v1, (0x2000001 >> 16)
  .L800DCB80:
    /* CD380 800DCB80 80371100 */  sll        $a2, $s1, 30
    /* CD384 800DCB84 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* CD388 800DCB88 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* CD38C 800DCB8C 2128A200 */  addu       $a1, $a1, $v0
    /* CD390 800DCB90 80000424 */  addiu      $a0, $zero, 0x80
    /* CD394 800DCB94 9800A28C */  lw         $v0, 0x98($a1)
    /* CD398 800DCB98 0003033C */  lui        $v1, (0x3000001 >> 16)
  .L800DCB9C:
    /* CD39C 800DCB9C 23108200 */  subu       $v0, $a0, $v0
    /* CD3A0 800DCBA0 00140200 */  sll        $v0, $v0, 16
    /* CD3A4 800DCBA4 25104300 */  or         $v0, $v0, $v1
    /* CD3A8 800DCBA8 A000A38C */  lw         $v1, 0xA0($a1)
  .L800DCBAC:
    /* CD3AC 800DCBAC 2530C200 */  or         $a2, $a2, $v0
    /* CD3B0 800DCBB0 23208300 */  subu       $a0, $a0, $v1
    /* CD3B4 800DCBB4 00220400 */  sll        $a0, $a0, 8
    /* CD3B8 800DCBB8 2530C400 */  or         $a2, $a2, $a0
    /* CD3BC 800DCBBC 48730308 */  j          .L800DCD20
    /* CD3C0 800DCBC0 0100C234 */   ori       $v0, $a2, (0x3000001 & 0xFFFF)
  .L800DCBC4:
    /* CD3C4 800DCBC4 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* CD3C8 800DCBC8 2128A200 */  addu       $a1, $a1, $v0
    /* CD3CC 800DCBCC 80271100 */  sll        $a0, $s1, 30
    /* CD3D0 800DCBD0 9800A28C */  lw         $v0, 0x98($a1)
    /* CD3D4 800DCBD4 0003033C */  lui        $v1, (0x3000001 >> 16)
  .L800DCBD8:
    /* CD3D8 800DCBD8 80004224 */  addiu      $v0, $v0, 0x80
    /* CD3DC 800DCBDC 00140200 */  sll        $v0, $v0, 16
    /* CD3E0 800DCBE0 25104300 */  or         $v0, $v0, $v1
    /* CD3E4 800DCBE4 A000A38C */  lw         $v1, 0xA0($a1)
  .L800DCBE8:
    /* CD3E8 800DCBE8 25208200 */  or         $a0, $a0, $v0
    /* CD3EC 800DCBEC 80006324 */  addiu      $v1, $v1, 0x80
    /* CD3F0 800DCBF0 001A0300 */  sll        $v1, $v1, 8
    /* CD3F4 800DCBF4 25208300 */  or         $a0, $a0, $v1
    /* CD3F8 800DCBF8 48730308 */  j          .L800DCD20
    /* CD3FC 800DCBFC 01008234 */   ori       $v0, $a0, (0x3000001 & 0xFFFF)
  .L800DCC00:
    /* CD400 800DCC00 00800234 */  ori        $v0, $zero, 0x8000
    /* CD404 800DCC04 33000212 */  beq        $s0, $v0, .L800DCCD4
    /* CD408 800DCC08 80181100 */   sll       $v1, $s1, 2
    /* CD40C 800DCC0C 2A105000 */  slt        $v0, $v0, $s0
    /* CD410 800DCC10 09004014 */  bnez       $v0, .L800DCC38
    /* CD414 800DCC14 2000023C */   lui       $v0, (0x200000 >> 16)
    /* CD418 800DCC18 00040224 */  addiu      $v0, $zero, 0x400
    /* CD41C 800DCC1C 38000212 */  beq        $s0, $v0, .L800DCD00
    /* CD420 800DCC20 0A03033C */   lui       $v1, (0x30AFF01 >> 16)
    /* CD424 800DCC24 00400224 */  addiu      $v0, $zero, 0x4000
    /* CD428 800DCC28 23000212 */  beq        $s0, $v0, .L800DCCB8
    /* CD42C 800DCC2C 80181100 */   sll       $v1, $s1, 2
    /* CD430 800DCC30 45730308 */  j          .L800DCD14
    /* CD434 800DCC34 80161100 */   sll       $v0, $s1, 26
  .L800DCC38:
    /* CD438 800DCC38 13000212 */  beq        $s0, $v0, .L800DCC88
    /* CD43C 800DCC3C 80281100 */   sll       $a1, $s1, 2
    /* CD440 800DCC40 8000023C */  lui        $v0, (0x800000 >> 16)
    /* CD444 800DCC44 32000216 */  bne        $s0, $v0, .L800DCD10
    /* CD448 800DCC48 80201100 */   sll       $a0, $s1, 2
    /* CD44C 800DCC4C 802F1100 */  sll        $a1, $s1, 30
    /* CD450 800DCC50 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* CD454 800DCC54 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* CD458 800DCC58 21208200 */  addu       $a0, $a0, $v0
    /* CD45C 800DCC5C 80000324 */  addiu      $v1, $zero, 0x80
    /* CD460 800DCC60 6800828C */  lw         $v0, 0x68($a0)
    /* CD464 800DCC64 7000848C */  lw         $a0, 0x70($a0)
  .L800DCC68:
    /* CD468 800DCC68 23106200 */  subu       $v0, $v1, $v0
    /* CD46C 800DCC6C 00140200 */  sll        $v0, $v0, 16
    /* CD470 800DCC70 2528A200 */  or         $a1, $a1, $v0
    /* CD474 800DCC74 23186400 */  subu       $v1, $v1, $a0
    /* CD478 800DCC78 001A0300 */  sll        $v1, $v1, 8
    /* CD47C 800DCC7C 2528A300 */  or         $a1, $a1, $v1
    /* CD480 800DCC80 48730308 */  j          .L800DCD20
    /* CD484 800DCC84 0100A234 */   ori       $v0, $a1, 0x1
  .L800DCC88:
    /* CD488 800DCC88 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* CD48C 800DCC8C EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* CD490 800DCC90 2128A200 */  addu       $a1, $a1, $v0
    /* CD494 800DCC94 80271100 */  sll        $a0, $s1, 30
    /* CD498 800DCC98 6800A38C */  lw         $v1, 0x68($a1)
    /* CD49C 800DCC9C 7000A28C */  lw         $v0, 0x70($a1)
    /* CD4A0 800DCCA0 80006324 */  addiu      $v1, $v1, 0x80
    /* CD4A4 800DCCA4 001C0300 */  sll        $v1, $v1, 16
    /* CD4A8 800DCCA8 25208300 */  or         $a0, $a0, $v1
    /* CD4AC 800DCCAC 80004224 */  addiu      $v0, $v0, 0x80
    /* CD4B0 800DCCB0 3D730308 */  j          .L800DCCF4
    /* CD4B4 800DCCB4 00120200 */   sll       $v0, $v0, 8
  .L800DCCB8:
    /* CD4B8 800DCCB8 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* CD4BC 800DCCBC EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* CD4C0 800DCCC0 21186200 */  addu       $v1, $v1, $v0
    /* CD4C4 800DCCC4 8000628C */  lw         $v0, 0x80($v1)
    /* CD4C8 800DCCC8 80271100 */  sll        $a0, $s1, 30
    /* CD4CC 800DCCCC 3B730308 */  j          .L800DCCEC
    /* CD4D0 800DCCD0 0001033C */   lui       $v1, (0x1000001 >> 16)
  .L800DCCD4:
    /* CD4D4 800DCCD4 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* CD4D8 800DCCD8 EC314224 */  addiu      $v0, $v0, %lo(GameSetup_gData)
    /* CD4DC 800DCCDC 21186200 */  addu       $v1, $v1, $v0
    /* CD4E0 800DCCE0 7800628C */  lw         $v0, 0x78($v1)
    /* CD4E4 800DCCE4 80271100 */  sll        $a0, $s1, 30
    /* CD4E8 800DCCE8 0002033C */  lui        $v1, (0x2000001 >> 16)
  .L800DCCEC:
    /* CD4EC 800DCCEC 00120200 */  sll        $v0, $v0, 8
    /* CD4F0 800DCCF0 25104300 */  or         $v0, $v0, $v1
  .L800DCCF4:
    /* CD4F4 800DCCF4 25208200 */  or         $a0, $a0, $v0
    /* CD4F8 800DCCF8 48730308 */  j          .L800DCD20
    /* CD4FC 800DCCFC 01008234 */   ori       $v0, $a0, (0x2000001 & 0xFFFF)
  .L800DCD00:
    /* CD500 800DCD00 01FF6334 */  ori        $v1, $v1, (0x30AFF01 & 0xFFFF)
    /* CD504 800DCD04 80171100 */  sll        $v0, $s1, 30
    /* CD508 800DCD08 48730308 */  j          .L800DCD20
    /* CD50C 800DCD0C 25104300 */   or        $v0, $v0, $v1
  .L800DCD10:
    /* CD510 800DCD10 80161100 */  sll        $v0, $s1, 26
  .L800DCD14:
    /* CD514 800DCD14 001A1000 */  sll        $v1, $s0, 8
  .L800DCD18:
    /* CD518 800DCD18 25104300 */  or         $v0, $v0, $v1
    /* CD51C 800DCD1C 02004234 */  ori        $v0, $v0, 0x2
  .L800DCD20:
    /* CD520 800DCD20 1800BF8F */  lw         $ra, 0x18($sp)
    /* CD524 800DCD24 1400B18F */  lw         $s1, 0x14($sp)
    /* CD528 800DCD28 1000B08F */  lw         $s0, 0x10($sp)
    /* CD52C 800DCD2C 0800E003 */  jr         $ra
    /* CD530 800DCD30 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel InGame_GetPSXPadValue__Fii
