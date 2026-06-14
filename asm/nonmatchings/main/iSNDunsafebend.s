.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDunsafebend, 0xD8

glabel iSNDunsafebend
    /* D80F8 800E78F8 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* D80FC 800E78FC 2000B2AF */  sw         $s2, 0x20($sp)
    /* D8100 800E7900 2190A000 */  addu       $s2, $a1, $zero
    /* D8104 800E7904 2800BFAF */  sw         $ra, 0x28($sp)
    /* D8108 800E7908 2400B3AF */  sw         $s3, 0x24($sp)
    /* D810C 800E790C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* D8110 800E7910 71FB030C */  jal        iSNDgetchan
    /* D8114 800E7914 1800B0AF */   sw        $s0, 0x18($sp)
    /* D8118 800E7918 21884000 */  addu       $s1, $v0, $zero
    /* D811C 800E791C 24002006 */  bltz       $s1, .L800E79B0
    /* D8120 800E7920 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* D8124 800E7924 1000A2AF */  sw         $v0, 0x10($sp)
    /* D8128 800E7928 1480023C */  lui        $v0, %hi(sndgs)
    /* D812C 800E792C 60785324 */  addiu      $s3, $v0, %lo(sndgs)
    /* D8130 800E7930 21202002 */  addu       $a0, $s1, $zero
  .L800E7934:
    /* D8134 800E7934 D3FB030C */  jal        iSNDpatchkey
    /* D8138 800E7938 1000A527 */   addiu     $a1, $sp, 0x10
    /* D813C 800E793C 1D004010 */  beqz       $v0, .L800E79B4
    /* D8140 800E7940 21102002 */   addu      $v0, $s1, $zero
    /* D8144 800E7944 1000A38F */  lw         $v1, 0x10($sp)
    /* D8148 800E7948 00000000 */  nop
    /* D814C 800E794C 40100300 */  sll        $v0, $v1, 1
    /* D8150 800E7950 21104300 */  addu       $v0, $v0, $v1
    /* D8154 800E7954 C0100200 */  sll        $v0, $v0, 3
    /* D8158 800E7958 21104300 */  addu       $v0, $v0, $v1
    /* D815C 800E795C 9400638E */  lw         $v1, 0x94($s3)
    /* D8160 800E7960 80100200 */  sll        $v0, $v0, 2
    /* D8164 800E7964 21806200 */  addu       $s0, $v1, $v0
    /* D8168 800E7968 2F000282 */  lb         $v0, 0x2F($s0)
    /* D816C 800E796C 00000000 */  nop
    /* D8170 800E7970 10005210 */  beq        $v0, $s2, .L800E79B4
    /* D8174 800E7974 21100000 */   addu      $v0, $zero, $zero
    /* D8178 800E7978 5A000286 */  lh         $v0, 0x5A($s0)
    /* D817C 800E797C 00000000 */  nop
    /* D8180 800E7980 0C004010 */  beqz       $v0, .L800E79B4
    /* D8184 800E7984 21100000 */   addu      $v0, $zero, $zero
    /* D8188 800E7988 2F0012A2 */  sb         $s2, 0x2F($s0)
    /* D818C 800E798C 1000A48F */  lw         $a0, 0x10($sp)
    /* D8190 800E7990 6F06040C */  jal        iSNDcalcpitch
    /* D8194 800E7994 5E0000A6 */   sh        $zero, 0x5E($s0)
    /* D8198 800E7998 1000A48F */  lw         $a0, 0x10($sp)
    /* D819C 800E799C 62000596 */  lhu        $a1, 0x62($s0)
    /* D81A0 800E79A0 E5FF030C */  jal        iSNDplatformpitch
    /* D81A4 800E79A4 00000000 */   nop
    /* D81A8 800E79A8 4D9E0308 */  j          .L800E7934
    /* D81AC 800E79AC 21202002 */   addu      $a0, $s1, $zero
  .L800E79B0:
    /* D81B0 800E79B0 21102002 */  addu       $v0, $s1, $zero
  .L800E79B4:
    /* D81B4 800E79B4 2800BF8F */  lw         $ra, 0x28($sp)
    /* D81B8 800E79B8 2400B38F */  lw         $s3, 0x24($sp)
    /* D81BC 800E79BC 2000B28F */  lw         $s2, 0x20($sp)
    /* D81C0 800E79C0 1C00B18F */  lw         $s1, 0x1C($sp)
    /* D81C4 800E79C4 1800B08F */  lw         $s0, 0x18($sp)
    /* D81C8 800E79C8 0800E003 */  jr         $ra
    /* D81CC 800E79CC 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel iSNDunsafebend
