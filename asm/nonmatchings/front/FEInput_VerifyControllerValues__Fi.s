.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FEInput_VerifyControllerValues__Fi, 0x60

glabel FEInput_VerifyControllerValues__Fi
    /* 14098 80023898 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1409C 8002389C 1480023C */  lui        $v0, %hi(gPadinfo)
    /* 140A0 800238A0 9CE84224 */  addiu      $v0, $v0, %lo(gPadinfo)
    /* 140A4 800238A4 40190400 */  sll        $v1, $a0, 5
    /* 140A8 800238A8 21286200 */  addu       $a1, $v1, $v0
    /* 140AC 800238AC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 140B0 800238B0 0400A290 */  lbu        $v0, 0x4($a1)
    /* 140B4 800238B4 00000000 */  nop
    /* 140B8 800238B8 0B004014 */  bnez       $v0, .L800238E8
    /* 140BC 800238BC 1180033C */   lui       $v1, %hi(frontEnd)
    /* 140C0 800238C0 00466324 */  addiu      $v1, $v1, %lo(frontEnd)
    /* 140C4 800238C4 40100400 */  sll        $v0, $a0, 1
    /* 140C8 800238C8 21104300 */  addu       $v0, $v0, $v1
    /* 140CC 800238CC 5E034384 */  lh         $v1, 0x35E($v0)
    /* 140D0 800238D0 0500A290 */  lbu        $v0, 0x5($a1)
    /* 140D4 800238D4 00000000 */  nop
    /* 140D8 800238D8 03006210 */  beq        $v1, $v0, .L800238E8
    /* 140DC 800238DC 00000000 */   nop
    /* 140E0 800238E0 399C000C */  jal        Front_ResetPSXController__Fii
    /* 140E4 800238E4 21280000 */   addu      $a1, $zero, $zero
  .L800238E8:
    /* 140E8 800238E8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 140EC 800238EC 00000000 */  nop
    /* 140F0 800238F0 0800E003 */  jr         $ra
    /* 140F4 800238F4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel FEInput_VerifyControllerValues__Fi
