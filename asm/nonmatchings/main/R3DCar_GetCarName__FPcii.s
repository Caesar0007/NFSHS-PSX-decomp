.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_GetCarName__FPcii, 0x94

glabel R3DCar_GetCarName__FPcii
    /* 9F698 800AEE98 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 9F69C 800AEE9C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9F6A0 800AEEA0 21888000 */  addu       $s1, $a0, $zero
    /* 9F6A4 800AEEA4 1800B2AF */  sw         $s2, 0x18($sp)
    /* 9F6A8 800AEEA8 2190C000 */  addu       $s2, $a2, $zero
    /* 9F6AC 800AEEAC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9F6B0 800AEEB0 EAFFB024 */  addiu      $s0, $a1, -0x16
    /* 9F6B4 800AEEB4 1480033C */  lui        $v1, %hi(D_8013D350)
    /* 9F6B8 800AEEB8 80100500 */  sll        $v0, $a1, 2
    /* 9F6BC 800AEEBC 21104500 */  addu       $v0, $v0, $a1
    /* 9F6C0 800AEEC0 1180063C */  lui        $a2, %hi(GameSetup_gCarNames)
    /* 9F6C4 800AEEC4 4430C624 */  addiu      $a2, $a2, %lo(GameSetup_gCarNames)
    /* 9F6C8 800AEEC8 50D36524 */  addiu      $a1, $v1, %lo(D_8013D350)
    /* 9F6CC 800AEECC 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 9F6D0 800AEED0 2F91030C */  jal        sprintf
    /* 9F6D4 800AEED4 21304600 */   addu      $a2, $v0, $a2
    /* 9F6D8 800AEED8 0600022E */  sltiu      $v0, $s0, 0x6
    /* 9F6DC 800AEEDC 0D004010 */  beqz       $v0, .L800AEF14
    /* 9F6E0 800AEEE0 1180033C */   lui       $v1, %hi(R3DCar_CopIndex)
    /* 9F6E4 800AEEE4 7C686324 */  addiu      $v1, $v1, %lo(R3DCar_CopIndex)
    /* 9F6E8 800AEEE8 80101000 */  sll        $v0, $s0, 2
    /* 9F6EC 800AEEEC 21105000 */  addu       $v0, $v0, $s0
    /* 9F6F0 800AEEF0 21104202 */  addu       $v0, $s2, $v0
    /* 9F6F4 800AEEF4 21104300 */  addu       $v0, $v0, $v1
    /* 9F6F8 800AEEF8 1180033C */  lui        $v1, %hi(R3DCar_CopCountry)
    /* 9F6FC 800AEEFC 00004290 */  lbu        $v0, 0x0($v0)
    /* 9F700 800AEF00 9C686324 */  addiu      $v1, $v1, %lo(R3DCar_CopCountry)
    /* 9F704 800AEF04 21104300 */  addu       $v0, $v0, $v1
    /* 9F708 800AEF08 00004290 */  lbu        $v0, 0x0($v0)
    /* 9F70C 800AEF0C 00000000 */  nop
    /* 9F710 800AEF10 020022A2 */  sb         $v0, 0x2($s1)
  .L800AEF14:
    /* 9F714 800AEF14 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 9F718 800AEF18 1800B28F */  lw         $s2, 0x18($sp)
    /* 9F71C 800AEF1C 1400B18F */  lw         $s1, 0x14($sp)
    /* 9F720 800AEF20 1000B08F */  lw         $s0, 0x10($sp)
    /* 9F724 800AEF24 0800E003 */  jr         $ra
    /* 9F728 800AEF28 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel R3DCar_GetCarName__FPcii
