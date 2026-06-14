.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_SampleExists, 0x8C

glabel iSPCH_SampleExists
    /* F12C0 80100AC0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* F12C4 80100AC4 1000B0AF */  sw         $s0, 0x10($sp)
    /* F12C8 80100AC8 2180A000 */  addu       $s0, $a1, $zero
    /* F12CC 80100ACC 1400B1AF */  sw         $s1, 0x14($sp)
    /* F12D0 80100AD0 2188C000 */  addu       $s1, $a2, $zero
    /* F12D4 80100AD4 1800BFAF */  sw         $ra, 0x18($sp)
    /* F12D8 80100AD8 03000292 */  lbu        $v0, 0x3($s0)
    /* F12DC 80100ADC 00000000 */  nop
    /* F12E0 80100AE0 2A105100 */  slt        $v0, $v0, $s1
    /* F12E4 80100AE4 03004010 */  beqz       $v0, .L80100AF4
    /* F12E8 80100AE8 01000524 */   addiu     $a1, $zero, 0x1
    /* F12EC 80100AEC CD020408 */  j          .L80100B34
    /* F12F0 80100AF0 21280000 */   addu      $a1, $zero, $zero
  .L80100AF4:
    /* F12F4 80100AF4 02008384 */  lh         $v1, 0x2($a0)
    /* F12F8 80100AF8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* F12FC 80100AFC 05006210 */  beq        $v1, $v0, .L80100B14
    /* F1300 80100B00 00000000 */   nop
    /* F1304 80100B04 21280002 */  addu       $a1, $s0, $zero
    /* F1308 80100B08 9C02040C */  jal        iSPCH_CheckTemplateSample
    /* F130C 80100B0C 21302002 */   addu      $a2, $s1, $zero
    /* F1310 80100B10 21284000 */  addu       $a1, $v0, $zero
  .L80100B14:
    /* F1314 80100B14 02000292 */  lbu        $v0, 0x2($s0)
    /* F1318 80100B18 00000000 */  nop
    /* F131C 80100B1C F0004230 */  andi       $v0, $v0, 0xF0
    /* F1320 80100B20 04004010 */  beqz       $v0, .L80100B34
    /* F1324 80100B24 21200002 */   addu      $a0, $s0, $zero
    /* F1328 80100B28 8702040C */  jal        iSPCH_CheckBankBit
    /* F132C 80100B2C 08002526 */   addiu     $a1, $s1, 0x8
    /* F1330 80100B30 21284000 */  addu       $a1, $v0, $zero
  .L80100B34:
    /* F1334 80100B34 1800BF8F */  lw         $ra, 0x18($sp)
    /* F1338 80100B38 1400B18F */  lw         $s1, 0x14($sp)
    /* F133C 80100B3C 1000B08F */  lw         $s0, 0x10($sp)
    /* F1340 80100B40 2110A000 */  addu       $v0, $a1, $zero
    /* F1344 80100B44 0800E003 */  jr         $ra
    /* F1348 80100B48 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iSPCH_SampleExists
