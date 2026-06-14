.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_GetUpgradeAccMult__Fi, 0xBC

glabel AISpeeds_GetUpgradeAccMult__Fi
    /* 5F90C 8006F10C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 5F910 8006F110 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 5F914 8006F114 DCF94224 */  addiu      $v0, $v0, %lo(Cars_gList)
    /* 5F918 8006F118 80200400 */  sll        $a0, $a0, 2
    /* 5F91C 8006F11C 21208200 */  addu       $a0, $a0, $v0
    /* 5F920 8006F120 1800BFAF */  sw         $ra, 0x18($sp)
    /* 5F924 8006F124 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5F928 8006F128 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5F92C 8006F12C 0000908C */  lw         $s0, 0x0($a0)
    /* 5F930 8006F130 00000000 */  nop
    /* 5F934 8006F134 8802028E */  lw         $v0, 0x288($s0)
    /* 5F938 8006F138 00000000 */  nop
    /* 5F93C 8006F13C 3C00428C */  lw         $v0, 0x3C($v0)
    /* 5F940 8006F140 01001124 */  addiu      $s1, $zero, 0x1
    /* 5F944 8006F144 06005114 */  bne        $v0, $s1, .L8006F160
    /* 5F948 8006F148 0100043C */   lui       $a0, (0x10000 >> 16)
    /* 5F94C 8006F14C 1180023C */  lui        $v0, %hi(engineUpgrade)
    /* 5F950 8006F150 E0DC458C */  lw         $a1, %lo(engineUpgrade)($v0)
    /* 5F954 8006F154 CA90030C */  jal        fixedmult
    /* 5F958 8006F158 00000000 */   nop
    /* 5F95C 8006F15C 21204000 */  addu       $a0, $v0, $zero
  .L8006F160:
    /* 5F960 8006F160 8802028E */  lw         $v0, 0x288($s0)
    /* 5F964 8006F164 00000000 */  nop
    /* 5F968 8006F168 4000428C */  lw         $v0, 0x40($v0)
    /* 5F96C 8006F16C 00000000 */  nop
    /* 5F970 8006F170 05005114 */  bne        $v0, $s1, .L8006F188
    /* 5F974 8006F174 1180023C */   lui       $v0, %hi(suspensionUpgrade)
    /* 5F978 8006F178 F0DC458C */  lw         $a1, %lo(suspensionUpgrade)($v0)
    /* 5F97C 8006F17C CA90030C */  jal        fixedmult
    /* 5F980 8006F180 00000000 */   nop
    /* 5F984 8006F184 21204000 */  addu       $a0, $v0, $zero
  .L8006F188:
    /* 5F988 8006F188 8802028E */  lw         $v0, 0x288($s0)
    /* 5F98C 8006F18C 00000000 */  nop
    /* 5F990 8006F190 4400428C */  lw         $v0, 0x44($v0)
    /* 5F994 8006F194 00000000 */  nop
    /* 5F998 8006F198 05005114 */  bne        $v0, $s1, .L8006F1B0
    /* 5F99C 8006F19C 1180023C */   lui       $v0, %hi(aeroUpgrade)
    /* 5F9A0 8006F1A0 00DD458C */  lw         $a1, %lo(aeroUpgrade)($v0)
    /* 5F9A4 8006F1A4 CA90030C */  jal        fixedmult
    /* 5F9A8 8006F1A8 00000000 */   nop
    /* 5F9AC 8006F1AC 21204000 */  addu       $a0, $v0, $zero
  .L8006F1B0:
    /* 5F9B0 8006F1B0 1800BF8F */  lw         $ra, 0x18($sp)
    /* 5F9B4 8006F1B4 1400B18F */  lw         $s1, 0x14($sp)
    /* 5F9B8 8006F1B8 1000B08F */  lw         $s0, 0x10($sp)
    /* 5F9BC 8006F1BC 21108000 */  addu       $v0, $a0, $zero
    /* 5F9C0 8006F1C0 0800E003 */  jr         $ra
    /* 5F9C4 8006F1C4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AISpeeds_GetUpgradeAccMult__Fi
