.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Roger__Q26Speech13MobileSpeaker, 0x178

glabel Roger__Q26Speech13MobileSpeaker
    /* 8956C 80098D6C 3808828F */  lw         $v0, %gp_rel(_6Speech_fgSpeech)($gp)
    /* 89570 80098D70 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 89574 80098D74 1800B2AF */  sw         $s2, 0x18($sp)
    /* 89578 80098D78 21908000 */  addu       $s2, $a0, $zero
    /* 8957C 80098D7C 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 89580 80098D80 1400B1AF */  sw         $s1, 0x14($sp)
    /* 89584 80098D84 1000B0AF */  sw         $s0, 0x10($sp)
    /* 89588 80098D88 6000438E */  lw         $v1, 0x60($s2)
    /* 8958C 80098D8C 00000000 */  nop
    /* 89590 80098D90 8C0343AC */  sw         $v1, 0x38C($v0)
    /* 89594 80098D94 4800428E */  lw         $v0, 0x48($s2)
    /* 89598 80098D98 00000000 */  nop
    /* 8959C 80098D9C 0E004010 */  beqz       $v0, .L80098DD8
    /* 895A0 80098DA0 21180000 */   addu      $v1, $zero, $zero
    /* 895A4 80098DA4 BC57020C */  jal        Dispatch__6Speech
    /* 895A8 80098DA8 00000000 */   nop
    /* 895AC 80098DAC 4C00438C */  lw         $v1, 0x4C($v0)
    /* 895B0 80098DB0 00000000 */  nop
    /* 895B4 80098DB4 B0006484 */  lh         $a0, 0xB0($v1)
    /* 895B8 80098DB8 B400638C */  lw         $v1, 0xB4($v1)
    /* 895BC 80098DBC 00000000 */  nop
    /* 895C0 80098DC0 09F86000 */  jalr       $v1
    /* 895C4 80098DC4 21204400 */   addu      $a0, $v0, $a0
    /* 895C8 80098DC8 4800438E */  lw         $v1, 0x48($s2)
    /* 895CC 80098DCC 00000000 */  nop
    /* 895D0 80098DD0 26104300 */  xor        $v0, $v0, $v1
    /* 895D4 80098DD4 0100432C */  sltiu      $v1, $v0, 0x1
  .L80098DD8:
    /* 895D8 80098DD8 2E006010 */  beqz       $v1, .L80098E94
    /* 895DC 80098DDC 00000000 */   nop
    /* 895E0 80098DE0 919D030C */  jal        SPCH_PlaySpeech
    /* 895E4 80098DE4 50005126 */   addiu     $s1, $s2, 0x50
    /* 895E8 80098DE8 4C00428E */  lw         $v0, 0x4C($s2)
    /* 895EC 80098DEC 00000000 */  nop
    /* 895F0 80098DF0 F0004484 */  lh         $a0, 0xF0($v0)
    /* 895F4 80098DF4 F400428C */  lw         $v0, 0xF4($v0)
    /* 895F8 80098DF8 00000000 */  nop
    /* 895FC 80098DFC 09F84000 */  jalr       $v0
    /* 89600 80098E00 21204402 */   addu      $a0, $s2, $a0
    /* 89604 80098E04 4800438E */  lw         $v1, 0x48($s2)
    /* 89608 80098E08 00000000 */  nop
    /* 8960C 80098E0C 4C00658C */  lw         $a1, 0x4C($v1)
    /* 89610 80098E10 00000000 */  nop
    /* 89614 80098E14 8800A484 */  lh         $a0, 0x88($a1)
    /* 89618 80098E18 00000000 */  nop
    /* 8961C 80098E1C 21206400 */  addu       $a0, $v1, $a0
    /* 89620 80098E20 8C00A38C */  lw         $v1, 0x8C($a1)
    /* 89624 80098E24 00000000 */  nop
    /* 89628 80098E28 09F86000 */  jalr       $v1
    /* 8962C 80098E2C 21804000 */   addu      $s0, $v0, $zero
    /* 89630 80098E30 21202002 */  addu       $a0, $s1, $zero
    /* 89634 80098E34 80100200 */  sll        $v0, $v0, 2
    /* 89638 80098E38 21800202 */  addu       $s0, $s0, $v0
    /* 8963C 80098E3C 0800058E */  lw         $a1, 0x8($s0)
    /* 89640 80098E40 1C004626 */  addiu      $a2, $s2, 0x1C
    /* 89644 80098E44 D54B020C */  jal        SPCHNFS_C_A_CONFIRM
    /* 89648 80098E48 3C0045AE */   sw        $a1, 0x3C($s2)
    /* 8964C 80098E4C 919D030C */  jal        SPCH_PlaySpeech
    /* 89650 80098E50 00000000 */   nop
    /* 89654 80098E54 4C00428E */  lw         $v0, 0x4C($s2)
    /* 89658 80098E58 00000000 */  nop
    /* 8965C 80098E5C D8004484 */  lh         $a0, 0xD8($v0)
    /* 89660 80098E60 DC00428C */  lw         $v0, 0xDC($v0)
    /* 89664 80098E64 00000000 */  nop
    /* 89668 80098E68 09F84000 */  jalr       $v0
    /* 8966C 80098E6C 21204402 */   addu      $a0, $s2, $a0
    /* 89670 80098E70 21204002 */  addu       $a0, $s2, $zero
    /* 89674 80098E74 7651020C */  jal        SetCar__Q26Speech7SpeakerP8Car_tObj
    /* 89678 80098E78 21284000 */   addu      $a1, $v0, $zero
    /* 8967C 80098E7C 21202002 */  addu       $a0, $s1, $zero
    /* 89680 80098E80 3000468E */  lw         $a2, 0x30($s2)
    /* 89684 80098E84 664C020C */  jal        SPCHNFS_C_C_IN_PURS_NEAR_PERP
    /* 89688 80098E88 08004526 */   addiu     $a1, $s2, 0x8
    /* 8968C 80098E8C B1630208 */  j          .L80098EC4
    /* 89690 80098E90 00000000 */   nop
  .L80098E94:
    /* 89694 80098E94 4C00428E */  lw         $v0, 0x4C($s2)
    /* 89698 80098E98 00000000 */  nop
    /* 8969C 80098E9C F0004484 */  lh         $a0, 0xF0($v0)
    /* 896A0 80098EA0 F400428C */  lw         $v0, 0xF4($v0)
    /* 896A4 80098EA4 00000000 */  nop
    /* 896A8 80098EA8 09F84000 */  jalr       $v0
    /* 896AC 80098EAC 21204402 */   addu      $a0, $s2, $a0
    /* 896B0 80098EB0 50004426 */  addiu      $a0, $s2, 0x50
    /* 896B4 80098EB4 0400458C */  lw         $a1, 0x4($v0)
    /* 896B8 80098EB8 1C004626 */  addiu      $a2, $s2, 0x1C
    /* 896BC 80098EBC D54B020C */  jal        SPCHNFS_C_A_CONFIRM
    /* 896C0 80098EC0 3C0045AE */   sw        $a1, 0x3C($s2)
  .L80098EC4:
    /* 896C4 80098EC4 919D030C */  jal        SPCH_PlaySpeech
    /* 896C8 80098EC8 00000000 */   nop
    /* 896CC 80098ECC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 896D0 80098ED0 1800B28F */  lw         $s2, 0x18($sp)
    /* 896D4 80098ED4 1400B18F */  lw         $s1, 0x14($sp)
    /* 896D8 80098ED8 1000B08F */  lw         $s0, 0x10($sp)
    /* 896DC 80098EDC 0800E003 */  jr         $ra
    /* 896E0 80098EE0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Roger__Q26Speech13MobileSpeaker
