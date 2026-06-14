.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawW_DoObjectAnimations__Fv, 0xA0

glabel DrawW_DoObjectAnimations__Fv
    /* B8008 800C7808 1180023C */  lui        $v0, %hi(D_80113228)
    /* B800C 800C780C 2832438C */  lw         $v1, %lo(D_80113228)($v0)
    /* B8010 800C7810 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* B8014 800C7814 2000BFAF */  sw         $ra, 0x20($sp)
    /* B8018 800C7818 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* B801C 800C781C 1800B2AF */  sw         $s2, 0x18($sp)
    /* B8020 800C7820 1400B1AF */  sw         $s1, 0x14($sp)
    /* B8024 800C7824 04006014 */  bnez       $v1, .L800C7838
    /* B8028 800C7828 1000B0AF */   sw        $s0, 0x10($sp)
    /* B802C 800C782C 1280023C */  lui        $v0, %hi(trk0)
    /* B8030 800C7830 121E0308 */  j          .L800C7848
    /* B8034 800C7834 90F55224 */   addiu     $s2, $v0, %lo(trk0)
  .L800C7838:
    /* B8038 800C7838 04000224 */  addiu      $v0, $zero, 0x4
    /* B803C 800C783C 13006214 */  bne        $v1, $v0, .L800C788C
    /* B8040 800C7840 1280023C */   lui       $v0, %hi(trk4)
    /* B8044 800C7844 D8F55224 */  addiu      $s2, $v0, %lo(trk4)
  .L800C7848:
    /* B8048 800C7848 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* B804C 800C784C B0E0538C */  lw         $s3, %lo(D_8011E0B0)($v0)
    /* B8050 800C7850 21880000 */  addu       $s1, $zero, $zero
    /* B8054 800C7854 1180023C */  lui        $v0, %hi(Anim_gInstanceFromIndex)
    /* B8058 800C7858 CCE15024 */  addiu      $s0, $v0, %lo(Anim_gInstanceFromIndex)
  .L800C785C:
    /* B805C 800C785C 0000048E */  lw         $a0, 0x0($s0)
    /* B8060 800C7860 00000000 */  nop
    /* B8064 800C7864 03008290 */  lbu        $v0, 0x3($a0)
    /* B8068 800C7868 00000000 */  nop
    /* B806C 800C786C 03004010 */  beqz       $v0, .L800C787C
    /* B8070 800C7870 21284002 */   addu      $a1, $s2, $zero
    /* B8074 800C7874 B21D030C */  jal        DrawW_SetAnimationTime__FP15Trk_AnimateInstPii
    /* B8078 800C7878 21306002 */   addu      $a2, $s3, $zero
  .L800C787C:
    /* B807C 800C787C 01003126 */  addiu      $s1, $s1, 0x1
    /* B8080 800C7880 1000222A */  slti       $v0, $s1, 0x10
    /* B8084 800C7884 F5FF4014 */  bnez       $v0, .L800C785C
    /* B8088 800C7888 04001026 */   addiu     $s0, $s0, 0x4
  .L800C788C:
    /* B808C 800C788C 2000BF8F */  lw         $ra, 0x20($sp)
    /* B8090 800C7890 1C00B38F */  lw         $s3, 0x1C($sp)
    /* B8094 800C7894 1800B28F */  lw         $s2, 0x18($sp)
    /* B8098 800C7898 1400B18F */  lw         $s1, 0x14($sp)
    /* B809C 800C789C 1000B08F */  lw         $s0, 0x10($sp)
    /* B80A0 800C78A0 0800E003 */  jr         $ra
    /* B80A4 800C78A4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel DrawW_DoObjectAnimations__Fv
