.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Track_AnimateTextures__Fv, 0x198

glabel Track_AnimateTextures__Fv
    /* AA1DC 800B99DC FFFF0C24 */  addiu      $t4, $zero, -0x1
    /* AA1E0 800B99E0 80000B24 */  addiu      $t3, $zero, 0x80
    /* AA1E4 800B99E4 1280023C */  lui        $v0, %hi(simGlobal)
    /* AA1E8 800B99E8 ACE04924 */  addiu      $t1, $v0, %lo(simGlobal)
    /* AA1EC 800B99EC 1280023C */  lui        $v0, %hi(gInitialArt)
    /* AA1F0 800B99F0 58E14A24 */  addiu      $t2, $v0, %lo(gInitialArt)
    /* AA1F4 800B99F4 9C0F878F */  lw         $a3, %gp_rel(Track_gMatController)($gp)
    /* AA1F8 800B99F8 980F888F */  lw         $t0, %gp_rel(Track_gControllerCount)($gp)
    /* AA1FC 800B99FC 0A00E624 */  addiu      $a2, $a3, 0xA
  .L800B9A00:
    /* AA200 800B9A00 FFFF0825 */  addiu      $t0, $t0, -0x1
    /* AA204 800B9A04 59000C11 */  beq        $t0, $t4, .L800B9B6C
    /* AA208 800B9A08 00000000 */   nop
    /* AA20C 800B9A0C 0000E384 */  lh         $v1, 0x0($a3)
    /* AA210 800B9A10 00000000 */  nop
    /* AA214 800B9A14 31006B14 */  bne        $v1, $t3, .L800B9ADC
    /* AA218 800B9A18 04000224 */   addiu     $v0, $zero, 0x4
    /* AA21C 800B9A1C FFFFC390 */  lbu        $v1, -0x1($a2)
    /* AA220 800B9A20 0400228D */  lw         $v0, 0x4($t1)
    /* AA224 800B9A24 00000000 */  nop
    /* AA228 800B9A28 1A004300 */  div        $zero, $v0, $v1
    /* AA22C 800B9A2C 02006014 */  bnez       $v1, .L800B9A38
    /* AA230 800B9A30 00000000 */   nop
    /* AA234 800B9A34 0D000700 */  break      7
  .L800B9A38:
    /* AA238 800B9A38 FFFF0124 */  addiu      $at, $zero, -0x1
    /* AA23C 800B9A3C 04006114 */  bne        $v1, $at, .L800B9A50
    /* AA240 800B9A40 0080013C */   lui       $at, (0x80000000 >> 16)
    /* AA244 800B9A44 02004114 */  bne        $v0, $at, .L800B9A50
    /* AA248 800B9A48 00000000 */   nop
    /* AA24C 800B9A4C 0D000600 */  break      6
  .L800B9A50:
    /* AA250 800B9A50 12100000 */  mflo       $v0
    /* AA254 800B9A54 F8FFC390 */  lbu        $v1, -0x8($a2)
    /* AA258 800B9A58 00000000 */  nop
    /* AA25C 800B9A5C 1A004300 */  div        $zero, $v0, $v1
    /* AA260 800B9A60 02006014 */  bnez       $v1, .L800B9A6C
    /* AA264 800B9A64 00000000 */   nop
    /* AA268 800B9A68 0D000700 */  break      7
  .L800B9A6C:
    /* AA26C 800B9A6C FFFF0124 */  addiu      $at, $zero, -0x1
    /* AA270 800B9A70 04006114 */  bne        $v1, $at, .L800B9A84
    /* AA274 800B9A74 0080013C */   lui       $at, (0x80000000 >> 16)
    /* AA278 800B9A78 02004114 */  bne        $v0, $at, .L800B9A84
    /* AA27C 800B9A7C 00000000 */   nop
    /* AA280 800B9A80 0D000600 */  break      6
  .L800B9A84:
    /* AA284 800B9A84 10280000 */  mfhi       $a1
    /* AA288 800B9A88 0200C28C */  lw         $v0, 0x2($a2)
    /* AA28C 800B9A8C 0C00448D */  lw         $a0, 0xC($t2)
    /* AA290 800B9A90 02004384 */  lh         $v1, 0x2($v0)
    /* AA294 800B9A94 FAFFC290 */  lbu        $v0, -0x6($a2)
    /* AA298 800B9A98 00190300 */  sll        $v1, $v1, 4
    /* AA29C 800B9A9C 21208300 */  addu       $a0, $a0, $v1
    /* AA2A0 800B9AA0 21104500 */  addu       $v0, $v0, $a1
    /* AA2A4 800B9AA4 010082A0 */  sb         $v0, 0x1($a0)
    /* AA2A8 800B9AA8 FBFFC290 */  lbu        $v0, -0x5($a2)
    /* AA2AC 800B9AAC 00000000 */  nop
    /* AA2B0 800B9AB0 21104500 */  addu       $v0, $v0, $a1
    /* AA2B4 800B9AB4 050082A0 */  sb         $v0, 0x5($a0)
    /* AA2B8 800B9AB8 FCFFC290 */  lbu        $v0, -0x4($a2)
    /* AA2BC 800B9ABC 00000000 */  nop
    /* AA2C0 800B9AC0 21104500 */  addu       $v0, $v0, $a1
    /* AA2C4 800B9AC4 090082A0 */  sb         $v0, 0x9($a0)
    /* AA2C8 800B9AC8 FDFFC290 */  lbu        $v0, -0x3($a2)
    /* AA2CC 800B9ACC 00000000 */  nop
    /* AA2D0 800B9AD0 21104500 */  addu       $v0, $v0, $a1
    /* AA2D4 800B9AD4 D8E60208 */  j          .L800B9B60
    /* AA2D8 800B9AD8 0D0082A0 */   sb        $v0, 0xD($a0)
  .L800B9ADC:
    /* AA2DC 800B9ADC 20006214 */  bne        $v1, $v0, .L800B9B60
    /* AA2E0 800B9AE0 00000000 */   nop
    /* AA2E4 800B9AE4 FFFFC390 */  lbu        $v1, -0x1($a2)
    /* AA2E8 800B9AE8 0400228D */  lw         $v0, 0x4($t1)
    /* AA2EC 800B9AEC 00000000 */  nop
    /* AA2F0 800B9AF0 1A004300 */  div        $zero, $v0, $v1
    /* AA2F4 800B9AF4 02006014 */  bnez       $v1, .L800B9B00
    /* AA2F8 800B9AF8 00000000 */   nop
    /* AA2FC 800B9AFC 0D000700 */  break      7
  .L800B9B00:
    /* AA300 800B9B00 FFFF0124 */  addiu      $at, $zero, -0x1
    /* AA304 800B9B04 04006114 */  bne        $v1, $at, .L800B9B18
    /* AA308 800B9B08 0080013C */   lui       $at, (0x80000000 >> 16)
    /* AA30C 800B9B0C 02004114 */  bne        $v0, $at, .L800B9B18
    /* AA310 800B9B10 00000000 */   nop
    /* AA314 800B9B14 0D000600 */  break      6
  .L800B9B18:
    /* AA318 800B9B18 12100000 */  mflo       $v0
    /* AA31C 800B9B1C FEFFC390 */  lbu        $v1, -0x2($a2)
    /* AA320 800B9B20 00000000 */  nop
    /* AA324 800B9B24 1A004300 */  div        $zero, $v0, $v1
    /* AA328 800B9B28 02006014 */  bnez       $v1, .L800B9B34
    /* AA32C 800B9B2C 00000000 */   nop
    /* AA330 800B9B30 0D000700 */  break      7
  .L800B9B34:
    /* AA334 800B9B34 FFFF0124 */  addiu      $at, $zero, -0x1
    /* AA338 800B9B38 04006114 */  bne        $v1, $at, .L800B9B4C
    /* AA33C 800B9B3C 0080013C */   lui       $at, (0x80000000 >> 16)
    /* AA340 800B9B40 02004114 */  bne        $v0, $at, .L800B9B4C
    /* AA344 800B9B44 00000000 */   nop
    /* AA348 800B9B48 0D000600 */  break      6
  .L800B9B4C:
    /* AA34C 800B9B4C 10200000 */  mfhi       $a0
    /* AA350 800B9B50 0000C294 */  lhu        $v0, 0x0($a2)
    /* AA354 800B9B54 0200C38C */  lw         $v1, 0x2($a2)
    /* AA358 800B9B58 21104400 */  addu       $v0, $v0, $a0
    /* AA35C 800B9B5C 020062A4 */  sh         $v0, 0x2($v1)
  .L800B9B60:
    /* AA360 800B9B60 1000C624 */  addiu      $a2, $a2, 0x10
    /* AA364 800B9B64 80E60208 */  j          .L800B9A00
    /* AA368 800B9B68 1000E724 */   addiu     $a3, $a3, 0x10
  .L800B9B6C:
    /* AA36C 800B9B6C 0800E003 */  jr         $ra
    /* AA370 800B9B70 00000000 */   nop
endlabel Track_AnimateTextures__Fv
