.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDstreamparsedata, 0x184

glabel iSNDstreamparsedata
    /* D98AC 800E90AC C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* D98B0 800E90B0 3400BFAF */  sw         $ra, 0x34($sp)
    /* D98B4 800E90B4 3000B0AF */  sw         $s0, 0x30($sp)
    /* D98B8 800E90B8 0C00A28C */  lw         $v0, 0xC($a1)
    /* D98BC 800E90BC 21408000 */  addu       $t0, $a0, $zero
    /* D98C0 800E90C0 1400A2AF */  sw         $v0, 0x14($sp)
    /* D98C4 800E90C4 2F000291 */  lbu        $v0, 0x2F($t0)
    /* D98C8 800E90C8 00000000 */  nop
    /* D98CC 800E90CC 11004014 */  bnez       $v0, .L800E9114
    /* D98D0 800E90D0 21480000 */   addu      $t1, $zero, $zero
    /* D98D4 800E90D4 1000A724 */  addiu      $a3, $a1, 0x10
    /* D98D8 800E90D8 1E000291 */  lbu        $v0, 0x1E($t0)
    /* D98DC 800E90DC 00000000 */  nop
    /* D98E0 800E90E0 1D004010 */  beqz       $v0, .L800E9158
    /* D98E4 800E90E4 21202001 */   addu      $a0, $t1, $zero
    /* D98E8 800E90E8 2130E000 */  addu       $a2, $a3, $zero
    /* D98EC 800E90EC 1000A327 */  addiu      $v1, $sp, 0x10
  .L800E90F0:
    /* D98F0 800E90F0 0C0066AC */  sw         $a2, 0xC($v1)
    /* D98F4 800E90F4 2130C900 */  addu       $a2, $a2, $t1
    /* D98F8 800E90F8 1E000291 */  lbu        $v0, 0x1E($t0)
    /* D98FC 800E90FC 01008424 */  addiu      $a0, $a0, 0x1
    /* D9900 800E9100 2A108200 */  slt        $v0, $a0, $v0
    /* D9904 800E9104 FAFF4014 */  bnez       $v0, .L800E90F0
    /* D9908 800E9108 04006324 */   addiu     $v1, $v1, 0x4
    /* D990C 800E910C 57A40308 */  j          .L800E915C
    /* D9910 800E9110 4992033C */   lui       $v1, (0x92492493 >> 16)
  .L800E9114:
    /* D9914 800E9114 1000A624 */  addiu      $a2, $a1, 0x10
    /* D9918 800E9118 1E000391 */  lbu        $v1, 0x1E($t0)
    /* D991C 800E911C 21200000 */  addu       $a0, $zero, $zero
    /* D9920 800E9120 80100300 */  sll        $v0, $v1, 2
    /* D9924 800E9124 0C006010 */  beqz       $v1, .L800E9158
    /* D9928 800E9128 2138C200 */   addu      $a3, $a2, $v0
    /* D992C 800E912C 1000A327 */  addiu      $v1, $sp, 0x10
  .L800E9130:
    /* D9930 800E9130 0000C28C */  lw         $v0, 0x0($a2)
    /* D9934 800E9134 0400C624 */  addiu      $a2, $a2, 0x4
    /* D9938 800E9138 01008424 */  addiu      $a0, $a0, 0x1
    /* D993C 800E913C 2110E200 */  addu       $v0, $a3, $v0
    /* D9940 800E9140 0C0062AC */  sw         $v0, 0xC($v1)
    /* D9944 800E9144 1E000291 */  lbu        $v0, 0x1E($t0)
    /* D9948 800E9148 00000000 */  nop
    /* D994C 800E914C 2A108200 */  slt        $v0, $a0, $v0
    /* D9950 800E9150 F7FF4014 */  bnez       $v0, .L800E9130
    /* D9954 800E9154 04006324 */   addiu     $v1, $v1, 0x4
  .L800E9158:
    /* D9958 800E9158 4992033C */  lui        $v1, (0x92492493 >> 16)
  .L800E915C:
    /* D995C 800E915C 1400A28F */  lw         $v0, 0x14($sp)
    /* D9960 800E9160 93246334 */  ori        $v1, $v1, (0x92492493 & 0xFFFF)
    /* D9964 800E9164 1B004224 */  addiu      $v0, $v0, 0x1B
    /* D9968 800E9168 18004300 */  mult       $v0, $v1
    /* D996C 800E916C 1C00A68F */  lw         $a2, 0x1C($sp)
    /* D9970 800E9170 10500000 */  mfhi       $t2
    /* D9974 800E9174 21184201 */  addu       $v1, $t2, $v0
    /* D9978 800E9178 03190300 */  sra        $v1, $v1, 4
    /* D997C 800E917C C3170200 */  sra        $v0, $v0, 31
    /* D9980 800E9180 23186200 */  subu       $v1, $v1, $v0
    /* D9984 800E9184 C0100300 */  sll        $v0, $v1, 3
    /* D9988 800E9188 23104300 */  subu       $v0, $v0, $v1
    /* D998C 800E918C 80100200 */  sll        $v0, $v0, 2
    /* D9990 800E9190 1400A2AF */  sw         $v0, 0x14($sp)
    /* D9994 800E9194 17000391 */  lbu        $v1, 0x17($t0)
    /* D9998 800E9198 0000048D */  lw         $a0, 0x0($t0)
    /* D999C 800E919C FCFFC5AC */  sw         $a1, -0x4($a2)
    /* D99A0 800E91A0 001E0300 */  sll        $v1, $v1, 24
    /* D99A4 800E91A4 031E0300 */  sra        $v1, $v1, 24
    /* D99A8 800E91A8 40100300 */  sll        $v0, $v1, 1
    /* D99AC 800E91AC 21104300 */  addu       $v0, $v0, $v1
    /* D99B0 800E91B0 80100200 */  sll        $v0, $v0, 2
    /* D99B4 800E91B4 23104300 */  subu       $v0, $v0, $v1
    /* D99B8 800E91B8 80100200 */  sll        $v0, $v0, 2
    /* D99BC 800E91BC 21808200 */  addu       $s0, $a0, $v0
    /* D99C0 800E91C0 0400028E */  lw         $v0, 0x4($s0)
    /* D99C4 800E91C4 00000000 */  nop
    /* D99C8 800E91C8 0000A2AC */  sw         $v0, 0x0($a1)
    /* D99CC 800E91CC 1C00028E */  lw         $v0, 0x1C($s0)
    /* D99D0 800E91D0 1400A38F */  lw         $v1, 0x14($sp)
    /* D99D4 800E91D4 00000000 */  nop
    /* D99D8 800E91D8 21104300 */  addu       $v0, $v0, $v1
    /* D99DC 800E91DC 1C0002AE */  sw         $v0, 0x1C($s0)
    /* D99E0 800E91E0 2000028E */  lw         $v0, 0x20($s0)
    /* D99E4 800E91E4 00000000 */  nop
    /* D99E8 800E91E8 01004224 */  addiu      $v0, $v0, 0x1
    /* D99EC 800E91EC 200002AE */  sw         $v0, 0x20($s0)
    /* D99F0 800E91F0 0C00048D */  lw         $a0, 0xC($t0)
    /* D99F4 800E91F4 3F0B040C */  jal        SNDPKTPLAY_submit
    /* D99F8 800E91F8 1000A527 */   addiu     $a1, $sp, 0x10
    /* D99FC 800E91FC 0C0002AE */  sw         $v0, 0xC($s0)
    /* D9A00 800E9200 0800028E */  lw         $v0, 0x8($s0)
    /* D9A04 800E9204 00000000 */  nop
    /* D9A08 800E9208 04004104 */  bgez       $v0, .L800E921C
    /* D9A0C 800E920C 00000000 */   nop
    /* D9A10 800E9210 0C00028E */  lw         $v0, 0xC($s0)
    /* D9A14 800E9214 00000000 */  nop
    /* D9A18 800E9218 080002AE */  sw         $v0, 0x8($s0)
  .L800E921C:
    /* D9A1C 800E921C 3400BF8F */  lw         $ra, 0x34($sp)
    /* D9A20 800E9220 3000B08F */  lw         $s0, 0x30($sp)
    /* D9A24 800E9224 01000224 */  addiu      $v0, $zero, 0x1
    /* D9A28 800E9228 0800E003 */  jr         $ra
    /* D9A2C 800E922C 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel iSNDstreamparsedata
