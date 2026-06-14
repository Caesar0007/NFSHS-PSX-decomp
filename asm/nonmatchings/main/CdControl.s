.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CdControl, 0x13C

glabel CdControl
    /* E80B4 800F78B4 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* E80B8 800F78B8 1400B1AF */  sw         $s1, 0x14($sp)
    /* E80BC 800F78BC 2188A000 */  addu       $s1, $a1, $zero
    /* E80C0 800F78C0 1800B2AF */  sw         $s2, 0x18($sp)
    /* E80C4 800F78C4 2190C000 */  addu       $s2, $a2, $zero
    /* E80C8 800F78C8 2000B4AF */  sw         $s4, 0x20($sp)
    /* E80CC 800F78CC 21A08000 */  addu       $s4, $a0, $zero
    /* E80D0 800F78D0 1000B0AF */  sw         $s0, 0x10($sp)
    /* E80D4 800F78D4 03001024 */  addiu      $s0, $zero, 0x3
    /* E80D8 800F78D8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* E80DC 800F78DC FF009332 */  andi       $s3, $s4, 0xFF
    /* E80E0 800F78E0 1380033C */  lui        $v1, %hi(D_80136A18)
    /* E80E4 800F78E4 186A6324 */  addiu      $v1, $v1, %lo(D_80136A18)
    /* E80E8 800F78E8 2400B5AF */  sw         $s5, 0x24($sp)
    /* E80EC 800F78EC 1480153C */  lui        $s5, %hi(CD_cbsync)
    /* E80F0 800F78F0 48BFB58E */  lw         $s5, %lo(CD_cbsync)($s5)
    /* E80F4 800F78F4 80101300 */  sll        $v0, $s3, 2
    /* E80F8 800F78F8 2800B6AF */  sw         $s6, 0x28($sp)
    /* E80FC 800F78FC 21B04300 */  addu       $s6, $v0, $v1
    /* E8100 800F7900 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* E8104 800F7904 21B80000 */  addu       $s7, $zero, $zero
    /* E8108 800F7908 3000BEAF */  sw         $fp, 0x30($sp)
    /* E810C 800F790C FFFF1E24 */  addiu      $fp, $zero, -0x1
    /* E8110 800F7910 3400BFAF */  sw         $ra, 0x34($sp)
  .L800F7914:
    /* E8114 800F7914 1480013C */  lui        $at, %hi(CD_cbsync)
    /* E8118 800F7918 48BF20AC */  sw         $zero, %lo(CD_cbsync)($at)
    /* E811C 800F791C 01000824 */  addiu      $t0, $zero, 0x1
    /* E8120 800F7920 0B006812 */  beq        $s3, $t0, .L800F7950
    /* E8124 800F7924 00000000 */   nop
    /* E8128 800F7928 1480023C */  lui        $v0, %hi(CD_status)
    /* E812C 800F792C 54BF4290 */  lbu        $v0, %lo(CD_status)($v0)
    /* E8130 800F7930 00000000 */  nop
    /* E8134 800F7934 10004230 */  andi       $v0, $v0, 0x10
    /* E8138 800F7938 05004010 */  beqz       $v0, .L800F7950
    /* E813C 800F793C 01000424 */   addiu     $a0, $zero, 0x1
    /* E8140 800F7940 21280000 */  addu       $a1, $zero, $zero
    /* E8144 800F7944 21300000 */  addu       $a2, $zero, $zero
    /* E8148 800F7948 C91E040C */  jal        CD_cw
    /* E814C 800F794C 21380000 */   addu      $a3, $zero, $zero
  .L800F7950:
    /* E8150 800F7950 0B002012 */  beqz       $s1, .L800F7980
    /* E8154 800F7954 00000000 */   nop
    /* E8158 800F7958 0000C28E */  lw         $v0, 0x0($s6)
    /* E815C 800F795C 00000000 */  nop
    /* E8160 800F7960 07004010 */  beqz       $v0, .L800F7980
    /* E8164 800F7964 02000424 */   addiu     $a0, $zero, 0x2
    /* E8168 800F7968 21282002 */  addu       $a1, $s1, $zero
    /* E816C 800F796C 21304002 */  addu       $a2, $s2, $zero
    /* E8170 800F7970 C91E040C */  jal        CD_cw
    /* E8174 800F7974 21380000 */   addu      $a3, $zero, $zero
    /* E8178 800F7978 0A004014 */  bnez       $v0, .L800F79A4
    /* E817C 800F797C 00000000 */   nop
  .L800F7980:
    /* E8180 800F7980 1480013C */  lui        $at, %hi(CD_cbsync)
    /* E8184 800F7984 48BF35AC */  sw         $s5, %lo(CD_cbsync)($at)
    /* E8188 800F7988 FF008432 */  andi       $a0, $s4, 0xFF
    /* E818C 800F798C 21282002 */  addu       $a1, $s1, $zero
    /* E8190 800F7990 21304002 */  addu       $a2, $s2, $zero
    /* E8194 800F7994 C91E040C */  jal        CD_cw
    /* E8198 800F7998 21380000 */   addu      $a3, $zero, $zero
    /* E819C 800F799C 08004010 */  beqz       $v0, .L800F79C0
    /* E81A0 800F79A0 0100E226 */   addiu     $v0, $s7, 0x1
  .L800F79A4:
    /* E81A4 800F79A4 FFFF1026 */  addiu      $s0, $s0, -0x1
    /* E81A8 800F79A8 DAFF1E16 */  bne        $s0, $fp, .L800F7914
    /* E81AC 800F79AC 00000000 */   nop
    /* E81B0 800F79B0 1480013C */  lui        $at, %hi(CD_cbsync)
    /* E81B4 800F79B4 48BF35AC */  sw         $s5, %lo(CD_cbsync)($at)
    /* E81B8 800F79B8 FFFF1724 */  addiu      $s7, $zero, -0x1
    /* E81BC 800F79BC 0100E226 */  addiu      $v0, $s7, 0x1
  .L800F79C0:
    /* E81C0 800F79C0 3400BF8F */  lw         $ra, 0x34($sp)
    /* E81C4 800F79C4 3000BE8F */  lw         $fp, 0x30($sp)
    /* E81C8 800F79C8 2C00B78F */  lw         $s7, 0x2C($sp)
    /* E81CC 800F79CC 2800B68F */  lw         $s6, 0x28($sp)
    /* E81D0 800F79D0 2400B58F */  lw         $s5, 0x24($sp)
    /* E81D4 800F79D4 2000B48F */  lw         $s4, 0x20($sp)
    /* E81D8 800F79D8 1C00B38F */  lw         $s3, 0x1C($sp)
    /* E81DC 800F79DC 1800B28F */  lw         $s2, 0x18($sp)
    /* E81E0 800F79E0 1400B18F */  lw         $s1, 0x14($sp)
    /* E81E4 800F79E4 1000B08F */  lw         $s0, 0x10($sp)
    /* E81E8 800F79E8 0800E003 */  jr         $ra
    /* E81EC 800F79EC 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel CdControl
