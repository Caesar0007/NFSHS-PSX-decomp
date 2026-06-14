.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPerson_LoadScriptData__FP10Udff_tInfo, 0xDC

glabel AIPerson_LoadScriptData__FP10Udff_tInfo
    /* 596A4 80068EA4 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* 596A8 80068EA8 2800B6AF */  sw         $s6, 0x28($sp)
    /* 596AC 80068EAC 21B08000 */  addu       $s6, $a0, $zero
    /* 596B0 80068EB0 3400BFAF */  sw         $ra, 0x34($sp)
    /* 596B4 80068EB4 3000BEAF */  sw         $fp, 0x30($sp)
    /* 596B8 80068EB8 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* 596BC 80068EBC 2400B5AF */  sw         $s5, 0x24($sp)
    /* 596C0 80068EC0 2000B4AF */  sw         $s4, 0x20($sp)
    /* 596C4 80068EC4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 596C8 80068EC8 1800B2AF */  sw         $s2, 0x18($sp)
    /* 596CC 80068ECC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 596D0 80068ED0 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 596D4 80068ED4 1000B0AF */   sw        $s0, 0x10($sp)
    /* 596D8 80068ED8 21B80000 */  addu       $s7, $zero, $zero
    /* 596DC 80068EDC 1180023C */  lui        $v0, %hi(AIPerson_ScriptData)
    /* 596E0 80068EE0 5CDA5E24 */  addiu      $fp, $v0, %lo(AIPerson_ScriptData)
    /* 596E4 80068EE4 21A8E002 */  addu       $s5, $s7, $zero
  .L80068EE8:
    /* 596E8 80068EE8 0900E22A */  slti       $v0, $s7, 0x9
    /* 596EC 80068EEC 18004010 */  beqz       $v0, .L80068F50
    /* 596F0 80068EF0 21900000 */   addu      $s2, $zero, $zero
  .L80068EF4:
    /* 596F4 80068EF4 0700422A */  slti       $v0, $s2, 0x7
    /* 596F8 80068EF8 12004010 */  beqz       $v0, .L80068F44
    /* 596FC 80068EFC 21880000 */   addu      $s1, $zero, $zero
    /* 59700 80068F00 C0A01200 */  sll        $s4, $s2, 3
    /* 59704 80068F04 2198A002 */  addu       $s3, $s5, $zero
  .L80068F08:
    /* 59708 80068F08 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5970C 80068F0C 2120C002 */   addu      $a0, $s6, $zero
    /* 59710 80068F10 2120C002 */  addu       $a0, $s6, $zero
    /* 59714 80068F14 21803402 */  addu       $s0, $s1, $s4
    /* 59718 80068F18 21801302 */  addu       $s0, $s0, $s3
    /* 5971C 80068F1C 21801E02 */  addu       $s0, $s0, $fp
    /* 59720 80068F20 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 59724 80068F24 000002A2 */   sb        $v0, 0x0($s0)
    /* 59728 80068F28 01003126 */  addiu      $s1, $s1, 0x1
    /* 5972C 80068F2C 040002A2 */  sb         $v0, 0x4($s0)
    /* 59730 80068F30 0400222A */  slti       $v0, $s1, 0x4
    /* 59734 80068F34 F4FF4014 */  bnez       $v0, .L80068F08
    /* 59738 80068F38 00000000 */   nop
    /* 5973C 80068F3C BDA30108 */  j          .L80068EF4
    /* 59740 80068F40 01005226 */   addiu     $s2, $s2, 0x1
  .L80068F44:
    /* 59744 80068F44 3800B526 */  addiu      $s5, $s5, 0x38
    /* 59748 80068F48 BAA30108 */  j          .L80068EE8
    /* 5974C 80068F4C 0100F726 */   addiu     $s7, $s7, 0x1
  .L80068F50:
    /* 59750 80068F50 3400BF8F */  lw         $ra, 0x34($sp)
    /* 59754 80068F54 3000BE8F */  lw         $fp, 0x30($sp)
    /* 59758 80068F58 2C00B78F */  lw         $s7, 0x2C($sp)
    /* 5975C 80068F5C 2800B68F */  lw         $s6, 0x28($sp)
    /* 59760 80068F60 2400B58F */  lw         $s5, 0x24($sp)
    /* 59764 80068F64 2000B48F */  lw         $s4, 0x20($sp)
    /* 59768 80068F68 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 5976C 80068F6C 1800B28F */  lw         $s2, 0x18($sp)
    /* 59770 80068F70 1400B18F */  lw         $s1, 0x14($sp)
    /* 59774 80068F74 1000B08F */  lw         $s0, 0x10($sp)
    /* 59778 80068F78 0800E003 */  jr         $ra
    /* 5977C 80068F7C 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel AIPerson_LoadScriptData__FP10Udff_tInfo
