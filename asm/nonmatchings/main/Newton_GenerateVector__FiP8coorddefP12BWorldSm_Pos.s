.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos, 0x18C

glabel Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos
    /* 93498 800A2C98 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* 9349C 800A2C9C 4400B1AF */  sw         $s1, 0x44($sp)
    /* 934A0 800A2CA0 2188A000 */  addu       $s1, $a1, $zero
    /* 934A4 800A2CA4 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 934A8 800A2CA8 2400A2AF */  sw         $v0, 0x24($sp)
    /* 934AC 800A2CAC 01000224 */  addiu      $v0, $zero, 0x1
    /* 934B0 800A2CB0 4800BFAF */  sw         $ra, 0x48($sp)
    /* 934B4 800A2CB4 4000B0AF */  sw         $s0, 0x40($sp)
    /* 934B8 800A2CB8 2800A0AF */  sw         $zero, 0x28($sp)
    /* 934BC 800A2CBC 2000A0AF */  sw         $zero, 0x20($sp)
    /* 934C0 800A2CC0 0A008214 */  bne        $a0, $v0, .L800A2CEC
    /* 934C4 800A2CC4 1400A0AF */   sw        $zero, 0x14($sp)
    /* 934C8 800A2CC8 3400C28C */  lw         $v0, 0x34($a2)
    /* 934CC 800A2CCC 2800C38C */  lw         $v1, 0x28($a2)
    /* 934D0 800A2CD0 00000000 */  nop
    /* 934D4 800A2CD4 23104300 */  subu       $v0, $v0, $v1
    /* 934D8 800A2CD8 1800A2AF */  sw         $v0, 0x18($sp)
    /* 934DC 800A2CDC 2C00C28C */  lw         $v0, 0x2C($a2)
    /* 934E0 800A2CE0 2000C38C */  lw         $v1, 0x20($a2)
    /* 934E4 800A2CE4 5D8B0208 */  j          .L800A2D74
    /* 934E8 800A2CE8 23104300 */   subu      $v0, $v0, $v1
  .L800A2CEC:
    /* 934EC 800A2CEC 04000224 */  addiu      $v0, $zero, 0x4
    /* 934F0 800A2CF0 0A008214 */  bne        $a0, $v0, .L800A2D1C
    /* 934F4 800A2CF4 02000224 */   addiu     $v0, $zero, 0x2
    /* 934F8 800A2CF8 2800C28C */  lw         $v0, 0x28($a2)
    /* 934FC 800A2CFC 1C00C38C */  lw         $v1, 0x1C($a2)
    /* 93500 800A2D00 00000000 */  nop
    /* 93504 800A2D04 23104300 */  subu       $v0, $v0, $v1
    /* 93508 800A2D08 1800A2AF */  sw         $v0, 0x18($sp)
    /* 9350C 800A2D0C 2000C28C */  lw         $v0, 0x20($a2)
    /* 93510 800A2D10 1400C38C */  lw         $v1, 0x14($a2)
    /* 93514 800A2D14 5D8B0208 */  j          .L800A2D74
    /* 93518 800A2D18 23104300 */   subu      $v0, $v0, $v1
  .L800A2D1C:
    /* 9351C 800A2D1C 0A008214 */  bne        $a0, $v0, .L800A2D48
    /* 93520 800A2D20 08000224 */   addiu     $v0, $zero, 0x8
    /* 93524 800A2D24 1C00C28C */  lw         $v0, 0x1C($a2)
    /* 93528 800A2D28 1000C38C */  lw         $v1, 0x10($a2)
    /* 9352C 800A2D2C 00000000 */  nop
    /* 93530 800A2D30 23104300 */  subu       $v0, $v0, $v1
    /* 93534 800A2D34 1800A2AF */  sw         $v0, 0x18($sp)
    /* 93538 800A2D38 1400C28C */  lw         $v0, 0x14($a2)
    /* 9353C 800A2D3C 0800C38C */  lw         $v1, 0x8($a2)
    /* 93540 800A2D40 5D8B0208 */  j          .L800A2D74
    /* 93544 800A2D44 23104300 */   subu      $v0, $v0, $v1
  .L800A2D48:
    /* 93548 800A2D48 0B008214 */  bne        $a0, $v0, .L800A2D78
    /* 9354C 800A2D4C 00000000 */   nop
    /* 93550 800A2D50 1000C28C */  lw         $v0, 0x10($a2)
    /* 93554 800A2D54 3400C38C */  lw         $v1, 0x34($a2)
    /* 93558 800A2D58 00000000 */  nop
    /* 9355C 800A2D5C 23104300 */  subu       $v0, $v0, $v1
    /* 93560 800A2D60 1800A2AF */  sw         $v0, 0x18($sp)
    /* 93564 800A2D64 0800C28C */  lw         $v0, 0x8($a2)
    /* 93568 800A2D68 2C00C38C */  lw         $v1, 0x2C($a2)
    /* 9356C 800A2D6C 00000000 */  nop
    /* 93570 800A2D70 23104300 */  subu       $v0, $v0, $v1
  .L800A2D74:
    /* 93574 800A2D74 1000A2AF */  sw         $v0, 0x10($sp)
  .L800A2D78:
    /* 93578 800A2D78 F576020C */  jal        Math_NormalizeShortVector__FP8coorddef
    /* 9357C 800A2D7C 1000A427 */   addiu     $a0, $sp, 0x10
    /* 93580 800A2D80 1400A48F */  lw         $a0, 0x14($sp)
    /* 93584 800A2D84 2800A58F */  lw         $a1, 0x28($sp)
    /* 93588 800A2D88 CA90030C */  jal        fixedmult
    /* 9358C 800A2D8C 00000000 */   nop
    /* 93590 800A2D90 1800A48F */  lw         $a0, 0x18($sp)
    /* 93594 800A2D94 2400A58F */  lw         $a1, 0x24($sp)
    /* 93598 800A2D98 CA90030C */  jal        fixedmult
    /* 9359C 800A2D9C 21804000 */   addu      $s0, $v0, $zero
    /* 935A0 800A2DA0 1800A48F */  lw         $a0, 0x18($sp)
    /* 935A4 800A2DA4 2000A58F */  lw         $a1, 0x20($sp)
    /* 935A8 800A2DA8 23800202 */  subu       $s0, $s0, $v0
    /* 935AC 800A2DAC CA90030C */  jal        fixedmult
    /* 935B0 800A2DB0 3000B0AF */   sw        $s0, 0x30($sp)
    /* 935B4 800A2DB4 1000A48F */  lw         $a0, 0x10($sp)
    /* 935B8 800A2DB8 2800A58F */  lw         $a1, 0x28($sp)
    /* 935BC 800A2DBC CA90030C */  jal        fixedmult
    /* 935C0 800A2DC0 21804000 */   addu      $s0, $v0, $zero
    /* 935C4 800A2DC4 1000A48F */  lw         $a0, 0x10($sp)
    /* 935C8 800A2DC8 2400A58F */  lw         $a1, 0x24($sp)
    /* 935CC 800A2DCC 23800202 */  subu       $s0, $s0, $v0
    /* 935D0 800A2DD0 CA90030C */  jal        fixedmult
    /* 935D4 800A2DD4 3400B0AF */   sw        $s0, 0x34($sp)
    /* 935D8 800A2DD8 1400A48F */  lw         $a0, 0x14($sp)
    /* 935DC 800A2DDC 2000A58F */  lw         $a1, 0x20($sp)
    /* 935E0 800A2DE0 CA90030C */  jal        fixedmult
    /* 935E4 800A2DE4 21804000 */   addu      $s0, $v0, $zero
    /* 935E8 800A2DE8 3000A38F */  lw         $v1, 0x30($sp)
    /* 935EC 800A2DEC 23800202 */  subu       $s0, $s0, $v0
    /* 935F0 800A2DF0 3800B0AF */  sw         $s0, 0x38($sp)
    /* 935F4 800A2DF4 000023AE */  sw         $v1, 0x0($s1)
    /* 935F8 800A2DF8 3400A28F */  lw         $v0, 0x34($sp)
    /* 935FC 800A2DFC 00000000 */  nop
    /* 93600 800A2E00 040022AE */  sw         $v0, 0x4($s1)
    /* 93604 800A2E04 3800A28F */  lw         $v0, 0x38($sp)
    /* 93608 800A2E08 00000000 */  nop
    /* 9360C 800A2E0C 080022AE */  sw         $v0, 0x8($s1)
    /* 93610 800A2E10 4800BF8F */  lw         $ra, 0x48($sp)
    /* 93614 800A2E14 4400B18F */  lw         $s1, 0x44($sp)
    /* 93618 800A2E18 4000B08F */  lw         $s0, 0x40($sp)
    /* 9361C 800A2E1C 0800E003 */  jr         $ra
    /* 93620 800A2E20 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel Newton_GenerateVector__FiP8coorddefP12BWorldSm_Pos
