.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Flare_Moon__FP7SVECTORP15Draw_FlareCache, 0xB8

glabel Flare_Moon__FP7SVECTORP15Draw_FlareCache
    /* BFCBC 800CF4BC C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* BFCC0 800CF4C0 78000624 */  addiu      $a2, $zero, 0x78
    /* BFCC4 800CF4C4 1180023C */  lui        $v0, %hi(D_801131F8)
    /* BFCC8 800CF4C8 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* BFCCC 800CF4CC 01000224 */  addiu      $v0, $zero, 0x1
    /* BFCD0 800CF4D0 02006214 */  bne        $v1, $v0, .L800CF4DC
    /* BFCD4 800CF4D4 3800BFAF */   sw        $ra, 0x38($sp)
    /* BFCD8 800CF4D8 3C000624 */  addiu      $a2, $zero, 0x3C
  .L800CF4DC:
    /* BFCDC 800CF4DC 000080C8 */  lwc2       $0, 0x0($a0)
    /* BFCE0 800CF4E0 040081C8 */  lwc2       $1, 0x4($a0)
    /* BFCE4 800CF4E4 00000000 */  nop
    /* BFCE8 800CF4E8 00000000 */  nop
    /* BFCEC 800CF4EC 0100184A */  .word 0x4A180001  /* rtps */
    /* BFCF0 800CF4F0 8000023C */  lui        $v0, (0x808080 >> 16)
    /* BFCF4 800CF4F4 80804234 */  ori        $v0, $v0, (0x808080 & 0xFFFF)
    /* BFCF8 800CF4F8 2800A2AF */  sw         $v0, 0x28($sp)
    /* BFCFC 800CF4FC 1800A227 */  addiu      $v0, $sp, 0x18
    /* BFD00 800CF500 000059E8 */  swc2       $25, 0x0($v0)
    /* BFD04 800CF504 04005AE8 */  swc2       $26, 0x4($v0) /* handwritten instruction */
    /* BFD08 800CF508 08005BE8 */  swc2       $27, 0x8($v0) /* handwritten instruction */
    /* BFD0C 800CF50C 3000A427 */  addiu      $a0, $sp, 0x30
    /* BFD10 800CF510 00008EE8 */  swc2       $14, 0x0($a0)
    /* BFD14 800CF514 1C00A28F */  lw         $v0, 0x1C($sp)
    /* BFD18 800CF518 1800A38F */  lw         $v1, 0x18($sp)
    /* BFD1C 800CF51C 2000A58F */  lw         $a1, 0x20($sp)
    /* BFD20 800CF520 83100200 */  sra        $v0, $v0, 2
    /* BFD24 800CF524 21104600 */  addu       $v0, $v0, $a2
    /* BFD28 800CF528 3200A2A7 */  sh         $v0, 0x32($sp)
    /* BFD2C 800CF52C 2A10A300 */  slt        $v0, $a1, $v1
    /* BFD30 800CF530 0C004014 */  bnez       $v0, .L800CF564
    /* BFD34 800CF534 23100300 */   negu      $v0, $v1
    /* BFD38 800CF538 2A10A200 */  slt        $v0, $a1, $v0
    /* BFD3C 800CF53C 09004014 */  bnez       $v0, .L800CF564
    /* BFD40 800CF540 2800A527 */   addiu     $a1, $sp, 0x28
    /* BFD44 800CF544 10000624 */  addiu      $a2, $zero, 0x10
    /* BFD48 800CF548 1480023C */  lui        $v0, %hi(Draw_gViewOtSize)
    /* BFD4C 800CF54C B0D7428C */  lw         $v0, %lo(Draw_gViewOtSize)($v0)
    /* BFD50 800CF550 2138C000 */  addu       $a3, $a2, $zero
    /* BFD54 800CF554 1000A0AF */  sw         $zero, 0x10($sp)
    /* BFD58 800CF558 FEFF4224 */  addiu      $v0, $v0, -0x2
    /* BFD5C 800CF55C BE39030C */  jal        Flare_SingleColorTex__FP7DVECTORP7CVECTORiici
    /* BFD60 800CF560 1400A2AF */   sw        $v0, 0x14($sp)
  .L800CF564:
    /* BFD64 800CF564 3800BF8F */  lw         $ra, 0x38($sp)
    /* BFD68 800CF568 00000000 */  nop
    /* BFD6C 800CF56C 0800E003 */  jr         $ra
    /* BFD70 800CF570 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel Flare_Moon__FP7SVECTORP15Draw_FlareCache
