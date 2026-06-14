.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDmastervol, 0xD4

glabel SNDmastervol
    /* D87F0 800E7FF0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D87F4 800E7FF4 1480023C */  lui        $v0, %hi(sndgs)
    /* D87F8 800E7FF8 1000B0AF */  sw         $s0, 0x10($sp)
    /* D87FC 800E7FFC 60785024 */  addiu      $s0, $v0, %lo(sndgs)
    /* D8800 800E8000 2000BFAF */  sw         $ra, 0x20($sp)
    /* D8804 800E8004 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D8808 800E8008 1800B2AF */  sw         $s2, 0x18($sp)
    /* D880C 800E800C 1400B1AF */  sw         $s1, 0x14($sp)
    /* D8810 800E8010 3C000282 */  lb         $v0, 0x3C($s0)
    /* D8814 800E8014 00000000 */  nop
    /* D8818 800E8018 03004014 */  bnez       $v0, .L800E8028
    /* D881C 800E801C 21908000 */   addu      $s2, $a0, $zero
    /* D8820 800E8020 2AA00308 */  j          .L800E80A8
    /* D8824 800E8024 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E8028:
    /* D8828 800E8028 4DA9030C */  jal        iSNDenteraudio
    /* D882C 800E802C 21880000 */   addu      $s1, $zero, $zero
    /* D8830 800E8030 11000292 */  lbu        $v0, 0x11($s0)
    /* D8834 800E8034 00000000 */  nop
    /* D8838 800E8038 18004010 */  beqz       $v0, .L800E809C
    /* D883C 800E803C 3D0012A2 */   sb        $s2, 0x3D($s0)
    /* D8840 800E8040 21980002 */  addu       $s3, $s0, $zero
    /* D8844 800E8044 21902002 */  addu       $s2, $s1, $zero
  .L800E8048:
    /* D8848 800E8048 9400628E */  lw         $v0, 0x94($s3)
    /* D884C 800E804C 00000000 */  nop
    /* D8850 800E8050 21805200 */  addu       $s0, $v0, $s2
    /* D8854 800E8054 0B000382 */  lb         $v1, 0xB($s0)
    /* D8858 800E8058 01000224 */  addiu      $v0, $zero, 0x1
    /* D885C 800E805C 0A006214 */  bne        $v1, $v0, .L800E8088
    /* D8860 800E8060 00000000 */   nop
    /* D8864 800E8064 0000028E */  lw         $v0, 0x0($s0)
    /* D8868 800E8068 00000000 */  nop
    /* D886C 800E806C 06004004 */  bltz       $v0, .L800E8088
    /* D8870 800E8070 00000000 */   nop
    /* D8874 800E8074 14FC030C */  jal        iSNDcalcvol
    /* D8878 800E8078 21202002 */   addu      $a0, $s1, $zero
    /* D887C 800E807C 2D000582 */  lb         $a1, 0x2D($s0)
    /* D8880 800E8080 3E00040C */  jal        iSNDvol
    /* D8884 800E8084 21202002 */   addu      $a0, $s1, $zero
  .L800E8088:
    /* D8888 800E8088 11006292 */  lbu        $v0, 0x11($s3)
    /* D888C 800E808C 01003126 */  addiu      $s1, $s1, 0x1
    /* D8890 800E8090 2A102202 */  slt        $v0, $s1, $v0
    /* D8894 800E8094 ECFF4014 */  bnez       $v0, .L800E8048
    /* D8898 800E8098 64005226 */   addiu     $s2, $s2, 0x64
  .L800E809C:
    /* D889C 800E809C 5BA9030C */  jal        iSNDleaveaudio
    /* D88A0 800E80A0 00000000 */   nop
    /* D88A4 800E80A4 21100000 */  addu       $v0, $zero, $zero
  .L800E80A8:
    /* D88A8 800E80A8 2000BF8F */  lw         $ra, 0x20($sp)
    /* D88AC 800E80AC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D88B0 800E80B0 1800B28F */  lw         $s2, 0x18($sp)
    /* D88B4 800E80B4 1400B18F */  lw         $s1, 0x14($sp)
    /* D88B8 800E80B8 1000B08F */  lw         $s0, 0x10($sp)
    /* D88BC 800E80BC 0800E003 */  jr         $ra
    /* D88C0 800E80C0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel SNDmastervol
