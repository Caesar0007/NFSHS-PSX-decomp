.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_ShowQueue__Fv, 0x1D0

glabel CopSpeak_ShowQueue__Fv
    /* 8B4CC 8009ACCC 88FFBD27 */  addiu      $sp, $sp, -0x78
    /* 8B4D0 8009ACD0 2200A427 */  addiu      $a0, $sp, 0x22
    /* 8B4D4 8009ACD4 21280000 */  addu       $a1, $zero, $zero
    /* 8B4D8 8009ACD8 6800B0AF */  sw         $s0, 0x68($sp)
    /* 8B4DC 8009ACDC 800B908F */  lw         $s0, %gp_rel(CopSpeak_gQueuePlay)($gp)
    /* 8B4E0 8009ACE0 0580023C */  lui        $v0, %hi(D_80055F84)
    /* 8B4E4 8009ACE4 7000BFAF */  sw         $ra, 0x70($sp)
    /* 8B4E8 8009ACE8 6C00B1AF */  sw         $s1, 0x6C($sp)
    /* 8B4EC 8009ACEC 845F4B24 */  addiu      $t3, $v0, %lo(D_80055F84)
    /* 8B4F0 8009ACF0 00006881 */  lb         $t0, 0x0($t3)
    /* 8B4F4 8009ACF4 01006981 */  lb         $t1, 0x1($t3)
    /* 8B4F8 8009ACF8 2000A8A3 */  sb         $t0, 0x20($sp)
    /* 8B4FC 8009ACFC 2100A9A3 */  sb         $t1, 0x21($sp)
    /* 8B500 8009AD00 C690030C */  jal        memset
    /* 8B504 8009AD04 40000624 */   addiu     $a2, $zero, 0x40
    /* 8B508 8009AD08 7C0B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueHead)($gp)
    /* 8B50C 8009AD0C 00000000 */  nop
    /* 8B510 8009AD10 48000212 */  beq        $s0, $v0, .L8009AE34
    /* 8B514 8009AD14 1180023C */   lui       $v0, %hi(CopSpeak_gQueue)
    /* 8B518 8009AD18 241F5124 */  addiu      $s1, $v0, %lo(CopSpeak_gQueue)
    /* 8B51C 8009AD1C 40111000 */  sll        $v0, $s0, 5
  .L8009AD20:
    /* 8B520 8009AD20 21185100 */  addu       $v1, $v0, $s1
    /* 8B524 8009AD24 1E006480 */  lb         $a0, 0x1E($v1)
    /* 8B528 8009AD28 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 8B52C 8009AD2C 06008214 */  bne        $a0, $v0, .L8009AD48
    /* 8B530 8009AD30 1480053C */   lui       $a1, %hi(D_8013D0A8)
    /* 8B534 8009AD34 2000A427 */  addiu      $a0, $sp, 0x20
    /* 8B538 8009AD38 3A9E030C */  jal        strcat
    /* 8B53C 8009AD3C A8D0A524 */   addiu     $a1, $a1, %lo(D_8013D0A8)
    /* 8B540 8009AD40 796B0208 */  j          .L8009ADE4
    /* 8B544 8009AD44 00000000 */   nop
  .L8009AD48:
    /* 8B548 8009AD48 1D006290 */  lbu        $v0, 0x1D($v1)
    /* 8B54C 8009AD4C 00000000 */  nop
    /* 8B550 8009AD50 06004010 */  beqz       $v0, .L8009AD6C
    /* 8B554 8009AD54 1480053C */   lui       $a1, %hi(D_8013D0AC)
    /* 8B558 8009AD58 2000A427 */  addiu      $a0, $sp, 0x20
    /* 8B55C 8009AD5C 3A9E030C */  jal        strcat
    /* 8B560 8009AD60 ACD0A524 */   addiu     $a1, $a1, %lo(D_8013D0AC)
    /* 8B564 8009AD64 796B0208 */  j          .L8009ADE4
    /* 8B568 8009AD68 00000000 */   nop
  .L8009AD6C:
    /* 8B56C 8009AD6C 03000224 */  addiu      $v0, $zero, 0x3
    /* 8B570 8009AD70 06008214 */  bne        $a0, $v0, .L8009AD8C
    /* 8B574 8009AD74 2000A427 */   addiu     $a0, $sp, 0x20
    /* 8B578 8009AD78 1480053C */  lui        $a1, %hi(D_8013D0B0)
    /* 8B57C 8009AD7C 3A9E030C */  jal        strcat
    /* 8B580 8009AD80 B0D0A524 */   addiu     $a1, $a1, %lo(D_8013D0B0)
    /* 8B584 8009AD84 796B0208 */  j          .L8009ADE4
    /* 8B588 8009AD88 00000000 */   nop
  .L8009AD8C:
    /* 8B58C 8009AD8C 1800628C */  lw         $v0, 0x18($v1)
    /* 8B590 8009AD90 00000000 */  nop
    /* 8B594 8009AD94 05004004 */  bltz       $v0, .L8009ADAC
    /* 8B598 8009AD98 1480053C */   lui       $a1, %hi(D_8013D0B4)
    /* 8B59C 8009AD9C 3A9E030C */  jal        strcat
    /* 8B5A0 8009ADA0 B4D0A524 */   addiu     $a1, $a1, %lo(D_8013D0B4)
    /* 8B5A4 8009ADA4 796B0208 */  j          .L8009ADE4
    /* 8B5A8 8009ADA8 00000000 */   nop
  .L8009ADAC:
    /* 8B5AC 8009ADAC 0000628C */  lw         $v0, 0x0($v1)
    /* 8B5B0 8009ADB0 00000000 */  nop
    /* 8B5B4 8009ADB4 06004014 */  bnez       $v0, .L8009ADD0
    /* 8B5B8 8009ADB8 2000A427 */   addiu     $a0, $sp, 0x20
    /* 8B5BC 8009ADBC 1480053C */  lui        $a1, %hi(D_8013D0B8)
    /* 8B5C0 8009ADC0 3A9E030C */  jal        strcat
    /* 8B5C4 8009ADC4 B8D0A524 */   addiu     $a1, $a1, %lo(D_8013D0B8)
    /* 8B5C8 8009ADC8 796B0208 */  j          .L8009ADE4
    /* 8B5CC 8009ADCC 00000000 */   nop
  .L8009ADD0:
    /* 8B5D0 8009ADD0 1480053C */  lui        $a1, %hi(D_8013D0BC)
    /* 8B5D4 8009ADD4 BCD0A524 */  addiu      $a1, $a1, %lo(D_8013D0BC)
    /* 8B5D8 8009ADD8 5402478C */  lw         $a3, 0x254($v0)
    /* 8B5DC 8009ADDC 2F91030C */  jal        sprintf
    /* 8B5E0 8009ADE0 21308000 */   addu      $a2, $a0, $zero
  .L8009ADE4:
    /* 8B5E4 8009ADE4 900B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueReady)($gp)
    /* 8B5E8 8009ADE8 00000000 */  nop
    /* 8B5EC 8009ADEC 06000212 */  beq        $s0, $v0, .L8009AE08
    /* 8B5F0 8009ADF0 2000A427 */   addiu     $a0, $sp, 0x20
    /* 8B5F4 8009ADF4 8C0B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueLoad)($gp)
    /* 8B5F8 8009ADF8 00000000 */  nop
    /* 8B5FC 8009ADFC 06000216 */  bne        $s0, $v0, .L8009AE18
    /* 8B600 8009AE00 3F00022A */   slti      $v0, $s0, 0x3F
    /* 8B604 8009AE04 2000A427 */  addiu      $a0, $sp, 0x20
  .L8009AE08:
    /* 8B608 8009AE08 1480053C */  lui        $a1, %hi(D_8013D0C4)
    /* 8B60C 8009AE0C 3A9E030C */  jal        strcat
    /* 8B610 8009AE10 C4D0A524 */   addiu     $a1, $a1, %lo(D_8013D0C4)
    /* 8B614 8009AE14 3F00022A */  slti       $v0, $s0, 0x3F
  .L8009AE18:
    /* 8B618 8009AE18 02004010 */  beqz       $v0, .L8009AE24
    /* 8B61C 8009AE1C 21180000 */   addu      $v1, $zero, $zero
    /* 8B620 8009AE20 01000326 */  addiu      $v1, $s0, 0x1
  .L8009AE24:
    /* 8B624 8009AE24 7C0B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueHead)($gp)
    /* 8B628 8009AE28 21806000 */  addu       $s0, $v1, $zero
    /* 8B62C 8009AE2C BCFF0216 */  bne        $s0, $v0, .L8009AD20
    /* 8B630 8009AE30 40111000 */   sll       $v0, $s0, 5
  .L8009AE34:
    /* 8B634 8009AE34 DDA7030C */  jal        strlen
    /* 8B638 8009AE38 2000A427 */   addiu     $a0, $sp, 0x20
    /* 8B63C 8009AE3C 12004010 */  beqz       $v0, .L8009AE88
    /* 8B640 8009AE40 2000A427 */   addiu     $a0, $sp, 0x20
    /* 8B644 8009AE44 0A000524 */  addiu      $a1, $zero, 0xA
    /* 8B648 8009AE48 A42E030C */  jal        Font_TextXY__FPcii
    /* 8B64C 8009AE4C 06000624 */   addiu     $a2, $zero, 0x6
    /* 8B650 8009AE50 888F030C */  jal        textpixels
    /* 8B654 8009AE54 2000A427 */   addiu     $a0, $sp, 0x20
    /* 8B658 8009AE58 1900033C */  lui        $v1, (0x190505 >> 16)
    /* 8B65C 8009AE5C 05056334 */  ori        $v1, $v1, (0x190505 & 0xFFFF)
    /* 8B660 8009AE60 01000424 */  addiu      $a0, $zero, 0x1
    /* 8B664 8009AE64 08000524 */  addiu      $a1, $zero, 0x8
    /* 8B668 8009AE68 09000624 */  addiu      $a2, $zero, 0x9
    /* 8B66C 8009AE6C 05004724 */  addiu      $a3, $v0, 0x5
    /* 8B670 8009AE70 2110C000 */  addu       $v0, $a2, $zero
    /* 8B674 8009AE74 1000A2AF */  sw         $v0, 0x10($sp)
    /* 8B678 8009AE78 1400A3AF */  sw         $v1, 0x14($sp)
    /* 8B67C 8009AE7C 1800A0AF */  sw         $zero, 0x18($sp)
    /* 8B680 8009AE80 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* 8B684 8009AE84 1C00A0AF */   sw        $zero, 0x1C($sp)
  .L8009AE88:
    /* 8B688 8009AE88 7000BF8F */  lw         $ra, 0x70($sp)
    /* 8B68C 8009AE8C 6C00B18F */  lw         $s1, 0x6C($sp)
    /* 8B690 8009AE90 6800B08F */  lw         $s0, 0x68($sp)
    /* 8B694 8009AE94 0800E003 */  jr         $ra
    /* 8B698 8009AE98 7800BD27 */   addiu     $sp, $sp, 0x78
endlabel CopSpeak_ShowQueue__Fv
