.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_CleanUp__Fv, 0x94

glabel CopSpeak_CleanUp__Fv
    /* 8A2DC 80099ADC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 8A2E0 80099AE0 1800BFAF */  sw         $ra, 0x18($sp)
    /* 8A2E4 80099AE4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 8A2E8 80099AE8 AF66020C */  jal        CopSpeak_Stop__Fv
    /* 8A2EC 80099AEC 1000B0AF */   sw        $s0, 0x10($sp)
    /* 8A2F0 80099AF0 21880000 */  addu       $s1, $zero, $zero
    /* 8A2F4 80099AF4 1180023C */  lui        $v0, %hi(Copspeak_gBank)
    /* 8A2F8 80099AF8 A41E5024 */  addiu      $s0, $v0, %lo(Copspeak_gBank)
  .L80099AFC:
    /* 8A2FC 80099AFC 0400028E */  lw         $v0, 0x4($s0)
    /* 8A300 80099B00 00000000 */  nop
    /* 8A304 80099B04 05004010 */  beqz       $v0, .L80099B1C
    /* 8A308 80099B08 00000000 */   nop
    /* 8A30C 80099B0C 0000048E */  lw         $a0, 0x0($s0)
    /* 8A310 80099B10 54AA030C */  jal        FILE_closesync
    /* 8A314 80099B14 64000524 */   addiu     $a1, $zero, 0x64
    /* 8A318 80099B18 040000AE */  sw         $zero, 0x4($s0)
  .L80099B1C:
    /* 8A31C 80099B1C 0800048E */  lw         $a0, 0x8($s0)
    /* 8A320 80099B20 00000000 */  nop
    /* 8A324 80099B24 04008010 */  beqz       $a0, .L80099B38
    /* 8A328 80099B28 00000000 */   nop
    /* 8A32C 80099B2C 5095030C */  jal        purgememadr
    /* 8A330 80099B30 00000000 */   nop
    /* 8A334 80099B34 080000AE */  sw         $zero, 0x8($s0)
  .L80099B38:
    /* 8A338 80099B38 01003126 */  addiu      $s1, $s1, 0x1
    /* 8A33C 80099B3C 0400222A */  slti       $v0, $s1, 0x4
    /* 8A340 80099B40 EEFF4014 */  bnez       $v0, .L80099AFC
    /* 8A344 80099B44 10001026 */   addiu     $s0, $s0, 0x10
    /* 8A348 80099B48 980B828F */  lw         $v0, %gp_rel(CopSpeak_gBuffer)($gp)
    /* 8A34C 80099B4C 00000000 */  nop
    /* 8A350 80099B50 02004010 */  beqz       $v0, .L80099B5C
    /* 8A354 80099B54 00000000 */   nop
    /* 8A358 80099B58 980B80AF */  sw         $zero, %gp_rel(CopSpeak_gBuffer)($gp)
  .L80099B5C:
    /* 8A35C 80099B5C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 8A360 80099B60 1400B18F */  lw         $s1, 0x14($sp)
    /* 8A364 80099B64 1000B08F */  lw         $s0, 0x10($sp)
    /* 8A368 80099B68 0800E003 */  jr         $ra
    /* 8A36C 80099B6C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel CopSpeak_CleanUp__Fv
