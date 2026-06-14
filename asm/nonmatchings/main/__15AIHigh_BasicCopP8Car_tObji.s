.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __15AIHigh_BasicCopP8Car_tObji, 0x88

glabel __15AIHigh_BasicCopP8Car_tObji
    /* 4C964 8005C164 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 4C968 8005C168 1800B2AF */  sw         $s2, 0x18($sp)
    /* 4C96C 8005C16C 21908000 */  addu       $s2, $a0, $zero
    /* 4C970 8005C170 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4C974 8005C174 2180A000 */  addu       $s0, $a1, $zero
    /* 4C978 8005C178 1400B1AF */  sw         $s1, 0x14($sp)
    /* 4C97C 8005C17C 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 4C980 8005C180 C66C010C */  jal        __11AIHigh_BaseP8Car_tObj
    /* 4C984 8005C184 2188C000 */   addu      $s1, $a2, $zero
    /* 4C988 8005C188 0580023C */  lui        $v0, %hi(D_80054E9C)
    /* 4C98C 8005C18C 9C4E4224 */  addiu      $v0, $v0, %lo(D_80054E9C)
    /* 4C990 8005C190 140042AE */  sw         $v0, 0x14($s2)
    /* 4C994 8005C194 1C0051AE */  sw         $s1, 0x1C($s2)
    /* 4C998 8005C198 6002028E */  lw         $v0, 0x260($s0)
    /* 4C99C 8005C19C 00000000 */  nop
    /* 4C9A0 8005C1A0 40004230 */  andi       $v0, $v0, 0x40
    /* 4C9A4 8005C1A4 03004010 */  beqz       $v0, .L8005C1B4
    /* 4C9A8 8005C1A8 01000224 */   addiu     $v0, $zero, 0x1
    /* 4C9AC 8005C1AC 6E700108 */  j          .L8005C1B8
    /* 4C9B0 8005C1B0 180042AE */   sw        $v0, 0x18($s2)
  .L8005C1B4:
    /* 4C9B4 8005C1B4 180040AE */  sw         $zero, 0x18($s2)
  .L8005C1B8:
    /* 4C9B8 8005C1B8 21104002 */  addu       $v0, $s2, $zero
    /* 4C9BC 8005C1BC FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 4C9C0 8005C1C0 200040AC */  sw         $zero, 0x20($v0)
    /* 4C9C4 8005C1C4 240040AC */  sw         $zero, 0x24($v0)
    /* 4C9C8 8005C1C8 300043AC */  sw         $v1, 0x30($v0)
    /* 4C9CC 8005C1CC 500040A4 */  sh         $zero, 0x50($v0)
    /* 4C9D0 8005C1D0 540040AC */  sw         $zero, 0x54($v0)
    /* 4C9D4 8005C1D4 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 4C9D8 8005C1D8 1800B28F */  lw         $s2, 0x18($sp)
    /* 4C9DC 8005C1DC 1400B18F */  lw         $s1, 0x14($sp)
    /* 4C9E0 8005C1E0 1000B08F */  lw         $s0, 0x10($sp)
    /* 4C9E4 8005C1E4 0800E003 */  jr         $ra
    /* 4C9E8 8005C1E8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __15AIHigh_BasicCopP8Car_tObji
