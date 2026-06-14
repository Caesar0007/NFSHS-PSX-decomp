.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8010C1C8, 0xC0

glabel func_8010C1C8
    /* FC9C8 8010C1C8 1480023C */  lui        $v0, %hi(D_8013C310)
    /* FC9CC 8010C1CC 10C3428C */  lw         $v0, %lo(D_8013C310)($v0)
    /* FC9D0 8010C1D0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FC9D4 8010C1D4 1000B0AF */  sw         $s0, 0x10($sp)
    /* FC9D8 8010C1D8 21808000 */  addu       $s0, $a0, $zero
    /* FC9DC 8010C1DC 0D004010 */  beqz       $v0, .L8010C214
    /* FC9E0 8010C1E0 1400BFAF */   sw        $ra, 0x14($sp)
    /* FC9E4 8010C1E4 0C00048E */  lw         $a0, 0xC($s0)
    /* FC9E8 8010C1E8 1380023C */  lui        $v0, %hi(_padFuncSendAuto)
    /* FC9EC 8010C1EC 907C428C */  lw         $v0, %lo(_padFuncSendAuto)($v0)
    /* FC9F0 8010C1F0 00000000 */  nop
    /* FC9F4 8010C1F4 09F84000 */  jalr       $v0
    /* FC9F8 8010C1F8 E0018424 */   addiu     $a0, $a0, 0x1E0
    /* FC9FC 8010C1FC 0C00048E */  lw         $a0, 0xC($s0)
    /* FCA00 8010C200 1380023C */  lui        $v0, %hi(_padFuncSendAuto)
    /* FCA04 8010C204 907C428C */  lw         $v0, %lo(_padFuncSendAuto)($v0)
    /* FCA08 8010C208 00000000 */  nop
    /* FCA0C 8010C20C 09F84000 */  jalr       $v0
    /* FCA10 8010C210 D0028424 */   addiu     $a0, $a0, 0x2D0
  .L8010C214:
    /* FCA14 8010C214 36000292 */  lbu        $v0, 0x36($s0)
    /* FCA18 8010C218 00000000 */  nop
    /* FCA1C 8010C21C 03004014 */  bnez       $v0, .L8010C22C
    /* FCA20 8010C220 21280000 */   addu      $a1, $zero, $zero
    /* FCA24 8010C224 1380053C */  lui        $a1, %hi(_padModeMtap)
    /* FCA28 8010C228 C47CA58C */  lw         $a1, %lo(_padModeMtap)($a1)
  .L8010C22C:
    /* FCA2C 8010C22C C014040C */  jal        _padSioRW2
    /* FCA30 8010C230 21200002 */   addu      $a0, $s0, $zero
    /* FCA34 8010C234 21184000 */  addu       $v1, $v0, $zero
    /* FCA38 8010C238 0F006004 */  bltz       $v1, .L8010C278
    /* FCA3C 8010C23C 00000000 */   nop
    /* FCA40 8010C240 F0006230 */  andi       $v0, $v1, 0xF0
    /* FCA44 8010C244 03004014 */  bnez       $v0, .L8010C254
    /* FCA48 8010C248 0F006230 */   andi      $v0, $v1, 0xF
    /* FCA4C 8010C24C 9E300408 */  j          .L8010C278
    /* FCA50 8010C250 F7FF0224 */   addiu     $v0, $zero, -0x9
  .L8010C254:
    /* FCA54 8010C254 40100200 */  sll        $v0, $v0, 1
    /* FCA58 8010C258 1480013C */  lui        $at, %hi(D_8013C308)
    /* FCA5C 8010C25C 08C322AC */  sw         $v0, %lo(D_8013C308)($at)
    /* FCA60 8010C260 05004014 */  bnez       $v0, .L8010C278
    /* FCA64 8010C264 21100000 */   addu      $v0, $zero, $zero
    /* FCA68 8010C268 20000224 */  addiu      $v0, $zero, 0x20
    /* FCA6C 8010C26C 1480013C */  lui        $at, %hi(D_8013C308)
    /* FCA70 8010C270 08C322AC */  sw         $v0, %lo(D_8013C308)($at)
    /* FCA74 8010C274 21100000 */  addu       $v0, $zero, $zero
  .L8010C278:
    /* FCA78 8010C278 1400BF8F */  lw         $ra, 0x14($sp)
    /* FCA7C 8010C27C 1000B08F */  lw         $s0, 0x10($sp)
    /* FCA80 8010C280 0800E003 */  jr         $ra
    /* FCA84 8010C284 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_8010C1C8
