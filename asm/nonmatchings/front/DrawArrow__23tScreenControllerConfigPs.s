.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawArrow__23tScreenControllerConfigPs, 0x100

glabel DrawArrow__23tScreenControllerConfigPs
    /* 35540 80044D40 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 35544 80044D44 1000B0AF */  sw         $s0, 0x10($sp)
    /* 35548 80044D48 21808000 */  addu       $s0, $a0, $zero
    /* 3554C 80044D4C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 35550 80044D50 2188A000 */  addu       $s1, $a1, $zero
    /* 35554 80044D54 01000424 */  addiu      $a0, $zero, 0x1
    /* 35558 80044D58 1800BFAF */  sw         $ra, 0x18($sp)
    /* 3555C 80044D5C C3C1030C */  jal        settrans
    /* 35560 80044D60 B40000A6 */   sh        $zero, 0xB4($s0)
    /* 35564 80044D64 B635010C */  jal        FeDraw_SetABRMode__Fi
    /* 35568 80044D68 21200000 */   addu      $a0, $zero, $zero
    /* 3556C 80044D6C 00002286 */  lh         $v0, 0x0($s1)
    /* 35570 80044D70 00000000 */  nop
    /* 35574 80044D74 13004010 */  beqz       $v0, .L80044DC4
    /* 35578 80044D78 00000000 */   nop
    /* 3557C 80044D7C AA000286 */  lh         $v0, 0xAA($s0)
    /* 35580 80044D80 00000000 */  nop
    /* 35584 80044D84 0A004104 */  bgez       $v0, .L80044DB0
    /* 35588 80044D88 40000224 */   addiu     $v0, $zero, 0x40
    /* 3558C 80044D8C A8000396 */  lhu        $v1, 0xA8($s0)
    /* 35590 80044D90 40000224 */  addiu      $v0, $zero, 0x40
    /* 35594 80044D94 23104300 */  subu       $v0, $v0, $v1
    /* 35598 80044D98 B40002A6 */  sh         $v0, 0xB4($s0)
    /* 3559C 80044D9C 00140200 */  sll        $v0, $v0, 16
    /* 355A0 80044DA0 05004104 */  bgez       $v0, .L80044DB8
    /* 355A4 80044DA4 21200002 */   addu      $a0, $s0, $zero
    /* 355A8 80044DA8 6E130108 */  j          .L80044DB8
    /* 355AC 80044DAC B40000A6 */   sh        $zero, 0xB4($s0)
  .L80044DB0:
    /* 355B0 80044DB0 B40002A6 */  sh         $v0, 0xB4($s0)
    /* 355B4 80044DB4 21200002 */  addu       $a0, $s0, $zero
  .L80044DB8:
    /* 355B8 80044DB8 21282002 */  addu       $a1, $s1, $zero
    /* 355BC 80044DBC BD12010C */  jal        HorzVertLine__23tScreenControllerConfigPsb
    /* 355C0 80044DC0 01000624 */   addiu     $a2, $zero, 0x1
  .L80044DC4:
    /* 355C4 80044DC4 AA000286 */  lh         $v0, 0xAA($s0)
    /* 355C8 80044DC8 00000000 */  nop
    /* 355CC 80044DCC 0E004104 */  bgez       $v0, .L80044E08
    /* 355D0 80044DD0 40000224 */   addiu     $v0, $zero, 0x40
    /* 355D4 80044DD4 A8000296 */  lhu        $v0, 0xA8($s0)
    /* 355D8 80044DD8 80000324 */  addiu      $v1, $zero, 0x80
    /* 355DC 80044DDC 23186200 */  subu       $v1, $v1, $v0
    /* 355E0 80044DE0 00140300 */  sll        $v0, $v1, 16
    /* 355E4 80044DE4 03240200 */  sra        $a0, $v0, 16
    /* 355E8 80044DE8 04008018 */  blez       $a0, .L80044DFC
    /* 355EC 80044DEC B40003A6 */   sh        $v1, 0xB4($s0)
    /* 355F0 80044DF0 40008228 */  slti       $v0, $a0, 0x40
    /* 355F4 80044DF4 04004010 */  beqz       $v0, .L80044E08
    /* 355F8 80044DF8 40000224 */   addiu     $v0, $zero, 0x40
  .L80044DFC:
    /* 355FC 80044DFC 02008104 */  bgez       $a0, .L80044E08
    /* 35600 80044E00 21106000 */   addu      $v0, $v1, $zero
    /* 35604 80044E04 21100000 */  addu       $v0, $zero, $zero
  .L80044E08:
    /* 35608 80044E08 B40002A6 */  sh         $v0, 0xB4($s0)
    /* 3560C 80044E0C 21200002 */  addu       $a0, $s0, $zero
    /* 35610 80044E10 21282002 */  addu       $a1, $s1, $zero
    /* 35614 80044E14 BD12010C */  jal        HorzVertLine__23tScreenControllerConfigPsb
    /* 35618 80044E18 21300000 */   addu      $a2, $zero, $zero
    /* 3561C 80044E1C B635010C */  jal        FeDraw_SetABRMode__Fi
    /* 35620 80044E20 01000424 */   addiu     $a0, $zero, 0x1
    /* 35624 80044E24 C3C1030C */  jal        settrans
    /* 35628 80044E28 21200000 */   addu      $a0, $zero, $zero
    /* 3562C 80044E2C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 35630 80044E30 1400B18F */  lw         $s1, 0x14($sp)
    /* 35634 80044E34 1000B08F */  lw         $s0, 0x10($sp)
    /* 35638 80044E38 0800E003 */  jr         $ra
    /* 3563C 80044E3C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel DrawArrow__23tScreenControllerConfigPs
