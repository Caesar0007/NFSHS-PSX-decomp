.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_SysCleanUp__Fv, 0x78

glabel AudioMus_SysCleanUp__Fv
    /* 6B58C 8007AD8C D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B590 8007AD90 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6B594 8007AD94 17004010 */  beqz       $v0, .L8007ADF4
    /* 6B598 8007AD98 1000BFAF */   sw        $ra, 0x10($sp)
    /* 6B59C 8007AD9C 44EB010C */  jal        AudioMus_DriverCleanUp__Fv
    /* 6B5A0 8007ADA0 00000000 */   nop
    /* 6B5A4 8007ADA4 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
    /* 6B5A8 8007ADA8 00000000 */  nop
    /* 6B5AC 8007ADAC 7000448C */  lw         $a0, 0x70($v0)
    /* 6B5B0 8007ADB0 00000000 */  nop
    /* 6B5B4 8007ADB4 04008010 */  beqz       $a0, .L8007ADC8
    /* 6B5B8 8007ADB8 00000000 */   nop
    /* 6B5BC 8007ADBC 5095030C */  jal        purgememadr
    /* 6B5C0 8007ADC0 00000000 */   nop
    /* 6B5C4 8007ADC4 D401828F */  lw         $v0, %gp_rel(AudioMus_g)($gp)
  .L8007ADC8:
    /* 6B5C8 8007ADC8 00000000 */  nop
    /* 6B5CC 8007ADCC 8C00448C */  lw         $a0, 0x8C($v0)
    /* 6B5D0 8007ADD0 00000000 */  nop
    /* 6B5D4 8007ADD4 03008010 */  beqz       $a0, .L8007ADE4
    /* 6B5D8 8007ADD8 00000000 */   nop
    /* 6B5DC 8007ADDC 5095030C */  jal        purgememadr
    /* 6B5E0 8007ADE0 00000000 */   nop
  .L8007ADE4:
    /* 6B5E4 8007ADE4 D401848F */  lw         $a0, %gp_rel(AudioMus_g)($gp)
    /* 6B5E8 8007ADE8 5095030C */  jal        purgememadr
    /* 6B5EC 8007ADEC 00000000 */   nop
    /* 6B5F0 8007ADF0 D40180AF */  sw         $zero, %gp_rel(AudioMus_g)($gp)
  .L8007ADF4:
    /* 6B5F4 8007ADF4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6B5F8 8007ADF8 00000000 */  nop
    /* 6B5FC 8007ADFC 0800E003 */  jr         $ra
    /* 6B600 8007AE00 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioMus_SysCleanUp__Fv
