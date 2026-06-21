.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Front_ResetSettingsMenu__Fi, 0x48

glabel Front_ResetSettingsMenu__Fi
    /* 1789C 8002709C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 178A0 800270A0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 178A4 800270A4 21888000 */  addu       $s1, $a0, $zero
    /* 178A8 800270A8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 178AC 800270AC 21800000 */  addu       $s0, $zero, $zero
    /* 178B0 800270B0 1800BFAF */  sw         $ra, 0x18($sp)
    /* 178B4 800270B4 21202002 */  addu       $a0, $s1, $zero
  .L800270B8:
    /* 178B8 800270B8 139C000C */  jal        Front_ResetSettingsForCar__Fii
    /* 178BC 800270BC 21280002 */   addu      $a1, $s0, $zero
    /* 178C0 800270C0 01001026 */  addiu      $s0, $s0, 0x1
    /* 178C4 800270C4 3000022A */  slti       $v0, $s0, 0x30
    /* 178C8 800270C8 FBFF4014 */  bnez       $v0, .L800270B8
    /* 178CC 800270CC 21202002 */   addu      $a0, $s1, $zero
    /* 178D0 800270D0 1800BF8F */  lw         $ra, 0x18($sp)
    /* 178D4 800270D4 1400B18F */  lw         $s1, 0x14($sp)
    /* 178D8 800270D8 1000B08F */  lw         $s0, 0x10($sp)
    /* 178DC 800270DC 0800E003 */  jr         $ra
    /* 178E0 800270E0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Front_ResetSettingsMenu__Fi
