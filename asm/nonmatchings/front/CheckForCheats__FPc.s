.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckForCheats__FPc, 0x80

glabel CheckForCheats__FPc
    /* 104AC 8001FCAC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 104B0 8001FCB0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 104B4 8001FCB4 21808000 */  addu       $s0, $a0, $zero
    /* 104B8 8001FCB8 1800BFAF */  sw         $ra, 0x18($sp)
    /* 104BC 8001FCBC DDA7030C */  jal        strlen
    /* 104C0 8001FCC0 1400B1AF */   sw        $s1, 0x14($sp)
    /* 104C4 8001FCC4 21184000 */  addu       $v1, $v0, $zero
    /* 104C8 8001FCC8 08006228 */  slti       $v0, $v1, 0x8
    /* 104CC 8001FCCC 08004010 */  beqz       $v0, .L8001FCF0
    /* 104D0 8001FCD0 21880000 */   addu      $s1, $zero, $zero
    /* 104D4 8001FCD4 21100302 */  addu       $v0, $s0, $v1
  .L8001FCD8:
    /* 104D8 8001FCD8 000040A0 */  sb         $zero, 0x0($v0)
    /* 104DC 8001FCDC 01006324 */  addiu      $v1, $v1, 0x1
    /* 104E0 8001FCE0 08006228 */  slti       $v0, $v1, 0x8
    /* 104E4 8001FCE4 FCFF4014 */  bnez       $v0, .L8001FCD8
    /* 104E8 8001FCE8 21100302 */   addu      $v0, $s0, $v1
    /* 104EC 8001FCEC 21880000 */  addu       $s1, $zero, $zero
  .L8001FCF0:
    /* 104F0 8001FCF0 858D000C */  jal        FECheat_ActivateCheat__FPc
    /* 104F4 8001FCF4 21200002 */   addu      $a0, $s0, $zero
    /* 104F8 8001FCF8 05004014 */  bnez       $v0, .L8001FD10
    /* 104FC 8001FCFC 00000000 */   nop
    /* 10500 8001FD00 F88D000C */  jal        FECheat_ActivateBonusByCode__FPc
    /* 10504 8001FD04 21200002 */   addu      $a0, $s0, $zero
    /* 10508 8001FD08 03004010 */  beqz       $v0, .L8001FD18
    /* 1050C 8001FD0C 21102002 */   addu      $v0, $s1, $zero
  .L8001FD10:
    /* 10510 8001FD10 01001124 */  addiu      $s1, $zero, 0x1
    /* 10514 8001FD14 21102002 */  addu       $v0, $s1, $zero
  .L8001FD18:
    /* 10518 8001FD18 1800BF8F */  lw         $ra, 0x18($sp)
    /* 1051C 8001FD1C 1400B18F */  lw         $s1, 0x14($sp)
    /* 10520 8001FD20 1000B08F */  lw         $s0, 0x10($sp)
    /* 10524 8001FD24 0800E003 */  jr         $ra
    /* 10528 8001FD28 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel CheckForCheats__FPc
