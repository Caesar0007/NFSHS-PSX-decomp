.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDstreamqueue, 0x1D4

glabel iSNDstreamqueue
    /* DA170 800E9970 1480023C */  lui        $v0, %hi(D_8014789C)
    /* DA174 800E9974 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* DA178 800E9978 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* DA17C 800E997C 1800B2AF */  sw         $s2, 0x18($sp)
    /* DA180 800E9980 4000B28F */  lw         $s2, 0x40($sp)
    /* DA184 800E9984 2400B5AF */  sw         $s5, 0x24($sp)
    /* DA188 800E9988 21A88000 */  addu       $s5, $a0, $zero
    /* DA18C 800E998C 2800B6AF */  sw         $s6, 0x28($sp)
    /* DA190 800E9990 21B0A000 */  addu       $s6, $a1, $zero
    /* DA194 800E9994 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* DA198 800E9998 2198C000 */  addu       $s3, $a2, $zero
    /* DA19C 800E999C 2000B4AF */  sw         $s4, 0x20($sp)
    /* DA1A0 800E99A0 21A0E000 */  addu       $s4, $a3, $zero
    /* DA1A4 800E99A4 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* DA1A8 800E99A8 1400B1AF */  sw         $s1, 0x14($sp)
    /* DA1AC 800E99AC 03004014 */  bnez       $v0, .L800E99BC
    /* DA1B0 800E99B0 1000B0AF */   sw        $s0, 0x10($sp)
    /* DA1B4 800E99B4 C7A60308 */  j          .L800E9B1C
    /* DA1B8 800E99B8 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E99BC:
    /* DA1BC 800E99BC 12A3030C */  jal        iSNDstreamgetstreamptr
    /* DA1C0 800E99C0 2120A002 */   addu      $a0, $s5, $zero
    /* DA1C4 800E99C4 21884000 */  addu       $s1, $v0, $zero
    /* DA1C8 800E99C8 54002012 */  beqz       $s1, .L800E9B1C
    /* DA1CC 800E99CC F8FF0224 */   addiu     $v0, $zero, -0x8
    /* DA1D0 800E99D0 4DA9030C */  jal        iSNDenteraudio
    /* DA1D4 800E99D4 00000000 */   nop
    /* DA1D8 800E99D8 16002392 */  lbu        $v1, 0x16($s1)
    /* DA1DC 800E99DC 15002292 */  lbu        $v0, 0x15($s1)
    /* DA1E0 800E99E0 001E0300 */  sll        $v1, $v1, 24
    /* DA1E4 800E99E4 00160200 */  sll        $v0, $v0, 24
    /* DA1E8 800E99E8 2A186200 */  slt        $v1, $v1, $v0
    /* DA1EC 800E99EC 05006014 */  bnez       $v1, .L800E9A04
    /* DA1F0 800E99F0 00000000 */   nop
    /* DA1F4 800E99F4 5BA9030C */  jal        iSNDleaveaudio
    /* DA1F8 800E99F8 00000000 */   nop
    /* DA1FC 800E99FC C7A60308 */  j          .L800E9B1C
    /* DA200 800E9A00 F3FF0224 */   addiu     $v0, $zero, -0xD
  .L800E9A04:
    /* DA204 800E9A04 16002292 */  lbu        $v0, 0x16($s1)
    /* DA208 800E9A08 00000000 */  nop
    /* DA20C 800E9A0C 00160200 */  sll        $v0, $v0, 24
    /* DA210 800E9A10 03160200 */  sra        $v0, $v0, 24
    /* DA214 800E9A14 40180200 */  sll        $v1, $v0, 1
    /* DA218 800E9A18 21186200 */  addu       $v1, $v1, $v0
    /* DA21C 800E9A1C 80180300 */  sll        $v1, $v1, 2
    /* DA220 800E9A20 23186200 */  subu       $v1, $v1, $v0
    /* DA224 800E9A24 0000228E */  lw         $v0, 0x0($s1)
    /* DA228 800E9A28 80180300 */  sll        $v1, $v1, 2
    /* DA22C 800E9A2C 0A004016 */  bnez       $s2, .L800E9A58
    /* DA230 800E9A30 21804300 */   addu      $s0, $v0, $v1
    /* DA234 800E9A34 21286002 */  addu       $a1, $s3, $zero
    /* DA238 800E9A38 21308002 */  addu       $a2, $s4, $zero
    /* DA23C 800E9A3C 456C073C */  lui        $a3, (0x6C454353 >> 16)
    /* DA240 800E9A40 0400248E */  lw         $a0, 0x4($s1)
    /* DA244 800E9A44 C5F4030C */  jal        STREAM_queuefile
    /* DA248 800E9A48 5343E734 */   ori       $a3, $a3, (0x6C454353 & 0xFFFF)
    /* DA24C 800E9A4C 000002AE */  sw         $v0, 0x0($s0)
    /* DA250 800E9A50 A2A60308 */  j          .L800E9A88
    /* DA254 800E9A54 00000000 */   nop
  .L800E9A58:
    /* DA258 800E9A58 01000224 */  addiu      $v0, $zero, 0x1
    /* DA25C 800E9A5C 09004216 */  bne        $s2, $v0, .L800E9A84
    /* DA260 800E9A60 21286002 */   addu      $a1, $s3, $zero
    /* DA264 800E9A64 21300000 */  addu       $a2, $zero, $zero
    /* DA268 800E9A68 456C073C */  lui        $a3, (0x6C454353 >> 16)
    /* DA26C 800E9A6C 0400248E */  lw         $a0, 0x4($s1)
    /* DA270 800E9A70 0AF5030C */  jal        STREAM_queuemem
    /* DA274 800E9A74 5343E734 */   ori       $a3, $a3, (0x6C454353 & 0xFFFF)
    /* DA278 800E9A78 000002AE */  sw         $v0, 0x0($s0)
    /* DA27C 800E9A7C A2A60308 */  j          .L800E9A88
    /* DA280 800E9A80 00000000 */   nop
  .L800E9A84:
    /* DA284 800E9A84 000014AE */  sw         $s4, 0x0($s0)
  .L800E9A88:
    /* DA288 800E9A88 0000028E */  lw         $v0, 0x0($s0)
    /* DA28C 800E9A8C 00000000 */  nop
    /* DA290 800E9A90 05004014 */  bnez       $v0, .L800E9AA8
    /* DA294 800E9A94 00000000 */   nop
    /* DA298 800E9A98 5BA9030C */  jal        iSNDleaveaudio
    /* DA29C 800E9A9C 00000000 */   nop
    /* DA2A0 800E9AA0 C7A60308 */  j          .L800E9B1C
    /* DA2A4 800E9AA4 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L800E9AA8:
    /* DA2A8 800E9AA8 1000228E */  lw         $v0, 0x10($s1)
    /* DA2AC 800E9AAC 00000000 */  nop
    /* DA2B0 800E9AB0 00014224 */  addiu      $v0, $v0, 0x100
    /* DA2B4 800E9AB4 100022AE */  sw         $v0, 0x10($s1)
    /* DA2B8 800E9AB8 1000228E */  lw         $v0, 0x10($s1)
    /* DA2BC 800E9ABC 00000000 */  nop
    /* DA2C0 800E9AC0 02004104 */  bgez       $v0, .L800E9ACC
    /* DA2C4 800E9AC4 00000000 */   nop
    /* DA2C8 800E9AC8 100020AE */  sw         $zero, 0x10($s1)
  .L800E9ACC:
    /* DA2CC 800E9ACC 1000228E */  lw         $v0, 0x10($s1)
    /* DA2D0 800E9AD0 00000000 */  nop
    /* DA2D4 800E9AD4 25105500 */  or         $v0, $v0, $s5
    /* DA2D8 800E9AD8 040002AE */  sw         $v0, 0x4($s0)
    /* DA2DC 800E9ADC 280016A6 */  sh         $s6, 0x28($s0)
    /* DA2E0 800E9AE0 16002292 */  lbu        $v0, 0x16($s1)
    /* DA2E4 800E9AE4 00000000 */  nop
    /* DA2E8 800E9AE8 01004224 */  addiu      $v0, $v0, 0x1
    /* DA2EC 800E9AEC 160022A2 */  sb         $v0, 0x16($s1)
    /* DA2F0 800E9AF0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* DA2F4 800E9AF4 100000AE */  sw         $zero, 0x10($s0)
    /* DA2F8 800E9AF8 080002AE */  sw         $v0, 0x8($s0)
    /* DA2FC 800E9AFC 0C0002AE */  sw         $v0, 0xC($s0)
    /* DA300 800E9B00 140000AE */  sw         $zero, 0x14($s0)
    /* DA304 800E9B04 1C0000AE */  sw         $zero, 0x1C($s0)
    /* DA308 800E9B08 200000AE */  sw         $zero, 0x20($s0)
    /* DA30C 800E9B0C 240000AE */  sw         $zero, 0x24($s0)
    /* DA310 800E9B10 5BA9030C */  jal        iSNDleaveaudio
    /* DA314 800E9B14 00000000 */   nop
    /* DA318 800E9B18 0400028E */  lw         $v0, 0x4($s0)
  .L800E9B1C:
    /* DA31C 800E9B1C 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* DA320 800E9B20 2800B68F */  lw         $s6, 0x28($sp)
    /* DA324 800E9B24 2400B58F */  lw         $s5, 0x24($sp)
    /* DA328 800E9B28 2000B48F */  lw         $s4, 0x20($sp)
    /* DA32C 800E9B2C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* DA330 800E9B30 1800B28F */  lw         $s2, 0x18($sp)
    /* DA334 800E9B34 1400B18F */  lw         $s1, 0x14($sp)
    /* DA338 800E9B38 1000B08F */  lw         $s0, 0x10($sp)
    /* DA33C 800E9B3C 0800E003 */  jr         $ra
    /* DA340 800E9B40 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel iSNDstreamqueue
