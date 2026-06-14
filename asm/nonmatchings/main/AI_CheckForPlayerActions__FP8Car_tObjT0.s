.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_CheckForPlayerActions__FP8Car_tObjT0, 0x240

glabel AI_CheckForPlayerActions__FP8Car_tObjT0
    /* 485D4 80057DD4 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 485D8 80057DD8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 485DC 80057DDC 21888000 */  addu       $s1, $a0, $zero
    /* 485E0 80057DE0 1800B2AF */  sw         $s2, 0x18($sp)
    /* 485E4 80057DE4 2190A000 */  addu       $s2, $a1, $zero
    /* 485E8 80057DE8 2400BFAF */  sw         $ra, 0x24($sp)
    /* 485EC 80057DEC 2000B4AF */  sw         $s4, 0x20($sp)
    /* 485F0 80057DF0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 485F4 80057DF4 2ECC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObjT0
    /* 485F8 80057DF8 1000B0AF */   sw        $s0, 0x10($sp)
    /* 485FC 80057DFC 02004104 */  bgez       $v0, .L80057E08
    /* 48600 80057E00 21A04000 */   addu      $s4, $v0, $zero
    /* 48604 80057E04 23A01400 */  negu       $s4, $s4
  .L80057E08:
    /* 48608 80057E08 B6CC010C */  jal        AIWorld_GameOdometer__FP8Car_tObj
    /* 4860C 80057E0C 21202002 */   addu      $a0, $s1, $zero
    /* 48610 80057E10 1F03033C */  lui        $v1, (0x31FFFFF >> 16)
    /* 48614 80057E14 FFFF6334 */  ori        $v1, $v1, (0x31FFFFF & 0xFFFF)
    /* 48618 80057E18 2A186200 */  slt        $v1, $v1, $v0
    /* 4861C 80057E1C 75006010 */  beqz       $v1, .L80057FF4
    /* 48620 80057E20 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 48624 80057E24 B0E0478C */  lw         $a3, %lo(D_8011E0B0)($v0)
    /* 48628 80057E28 B801428E */  lw         $v0, 0x1B8($s2)
    /* 4862C 80057E2C 00000000 */  nop
    /* 48630 80057E30 2310E200 */  subu       $v0, $a3, $v0
    /* 48634 80057E34 0F004228 */  slti       $v0, $v0, 0xF
    /* 48638 80057E38 0A004010 */  beqz       $v0, .L80057E64
    /* 4863C 80057E3C 00000000 */   nop
    /* 48640 80057E40 B001428E */  lw         $v0, 0x1B0($s2)
    /* 48644 80057E44 00000000 */  nop
    /* 48648 80057E48 06004010 */  beqz       $v0, .L80057E64
    /* 4864C 80057E4C 00000000 */   nop
    /* 48650 80057E50 04005114 */  bne        $v0, $s1, .L80057E64
    /* 48654 80057E54 F4042426 */   addiu     $a0, $s1, 0x4F4
    /* 48658 80057E58 5402458E */  lw         $a1, 0x254($s2)
    /* 4865C 80057E5C DABD010C */  jal        AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni
    /* 48660 80057E60 21300000 */   addu      $a2, $zero, $zero
  .L80057E64:
    /* 48664 80057E64 5405238E */  lw         $v1, 0x554($s1)
    /* 48668 80057E68 6405428E */  lw         $v0, 0x564($s2)
    /* 4866C 80057E6C 00000000 */  nop
    /* 48670 80057E70 18004300 */  mult       $v0, $v1
    /* 48674 80057E74 12200000 */  mflo       $a0
    /* 48678 80057E78 6405228E */  lw         $v0, 0x564($s1)
    /* 4867C 80057E7C 00000000 */  nop
    /* 48680 80057E80 18004300 */  mult       $v0, $v1
    /* 48684 80057E84 2800023C */  lui        $v0, (0x280000 >> 16)
    /* 48688 80057E88 21108200 */  addu       $v0, $a0, $v0
    /* 4868C 80057E8C 12180000 */  mflo       $v1
    /* 48690 80057E90 2A104300 */  slt        $v0, $v0, $v1
    /* 48694 80057E94 0A004010 */  beqz       $v0, .L80057EC0
    /* 48698 80057E98 0B00023C */   lui       $v0, (0xBFFFF >> 16)
    /* 4869C 80057E9C FFFF4234 */  ori        $v0, $v0, (0xBFFFF & 0xFFFF)
    /* 486A0 80057EA0 2A105400 */  slt        $v0, $v0, $s4
    /* 486A4 80057EA4 23004014 */  bnez       $v0, .L80057F34
    /* 486A8 80057EA8 F4042426 */   addiu     $a0, $s1, 0x4F4
    /* 486AC 80057EAC 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 486B0 80057EB0 5402458E */  lw         $a1, 0x254($s2)
    /* 486B4 80057EB4 B0E0478C */  lw         $a3, %lo(D_8011E0B0)($v0)
    /* 486B8 80057EB8 DABD010C */  jal        AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni
    /* 486BC 80057EBC 01000624 */   addiu     $a2, $zero, 0x1
  .L80057EC0:
    /* 486C0 80057EC0 0B00023C */  lui        $v0, (0xBFFFF >> 16)
    /* 486C4 80057EC4 FFFF4234 */  ori        $v0, $v0, (0xBFFFF & 0xFFFF)
    /* 486C8 80057EC8 2A105400 */  slt        $v0, $v0, $s4
    /* 486CC 80057ECC 19004014 */  bnez       $v0, .L80057F34
    /* 486D0 80057ED0 00000000 */   nop
    /* 486D4 80057ED4 C406438E */  lw         $v1, 0x6C4($s2)
    /* 486D8 80057ED8 C406228E */  lw         $v0, 0x6C4($s1)
    /* 486DC 80057EDC 00000000 */  nop
    /* 486E0 80057EE0 14006214 */  bne        $v1, $v0, .L80057F34
    /* 486E4 80057EE4 00000000 */   nop
    /* 486E8 80057EE8 B6CC010C */  jal        AIWorld_GameOdometer__FP8Car_tObj
    /* 486EC 80057EEC 21204002 */   addu      $a0, $s2, $zero
    /* 486F0 80057EF0 21202002 */  addu       $a0, $s1, $zero
    /* 486F4 80057EF4 B6CC010C */  jal        AIWorld_GameOdometer__FP8Car_tObj
    /* 486F8 80057EF8 21804000 */   addu      $s0, $v0, $zero
    /* 486FC 80057EFC 2A105000 */  slt        $v0, $v0, $s0
    /* 48700 80057F00 06004010 */  beqz       $v0, .L80057F1C
    /* 48704 80057F04 F4042426 */   addiu     $a0, $s1, 0x4F4
    /* 48708 80057F08 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 4870C 80057F0C 5402458E */  lw         $a1, 0x254($s2)
    /* 48710 80057F10 B0E0478C */  lw         $a3, %lo(D_8011E0B0)($v0)
    /* 48714 80057F14 CB5F0108 */  j          .L80057F2C
    /* 48718 80057F18 02000624 */   addiu     $a2, $zero, 0x2
  .L80057F1C:
    /* 4871C 80057F1C 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 48720 80057F20 5402458E */  lw         $a1, 0x254($s2)
    /* 48724 80057F24 B0E0478C */  lw         $a3, %lo(D_8011E0B0)($v0)
    /* 48728 80057F28 03000624 */  addiu      $a2, $zero, 0x3
  .L80057F2C:
    /* 4872C 80057F2C DABD010C */  jal        AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni
    /* 48730 80057F30 00000000 */   nop
  .L80057F34:
    /* 48734 80057F34 8002428E */  lw         $v0, 0x280($s2)
    /* 48738 80057F38 00000000 */  nop
    /* 4873C 80057F3C 1C005114 */  bne        $v0, $s1, .L80057FB0
    /* 48740 80057F40 1D00023C */   lui       $v0, (0x1DFFFF >> 16)
    /* 48744 80057F44 1280023C */  lui        $v0, %hi(simGlobal)
    /* 48748 80057F48 ACE05324 */  addiu      $s3, $v0, %lo(simGlobal)
    /* 4874C 80057F4C 0400628E */  lw         $v0, 0x4($s3)
    /* 48750 80057F50 8402238E */  lw         $v1, 0x284($s1)
    /* 48754 80057F54 00000000 */  nop
    /* 48758 80057F58 23104300 */  subu       $v0, $v0, $v1
    /* 4875C 80057F5C 0F004228 */  slti       $v0, $v0, 0xF
    /* 48760 80057F60 13004010 */  beqz       $v0, .L80057FB0
    /* 48764 80057F64 1D00023C */   lui       $v0, (0x1DFFFF >> 16)
    /* 48768 80057F68 B6CC010C */  jal        AIWorld_GameOdometer__FP8Car_tObj
    /* 4876C 80057F6C 21202002 */   addu      $a0, $s1, $zero
    /* 48770 80057F70 21204002 */  addu       $a0, $s2, $zero
    /* 48774 80057F74 B6CC010C */  jal        AIWorld_GameOdometer__FP8Car_tObj
    /* 48778 80057F78 21804000 */   addu      $s0, $v0, $zero
    /* 4877C 80057F7C 2A105000 */  slt        $v0, $v0, $s0
    /* 48780 80057F80 05004010 */  beqz       $v0, .L80057F98
    /* 48784 80057F84 F4042426 */   addiu     $a0, $s1, 0x4F4
    /* 48788 80057F88 5402458E */  lw         $a1, 0x254($s2)
    /* 4878C 80057F8C 0400678E */  lw         $a3, 0x4($s3)
    /* 48790 80057F90 E95F0108 */  j          .L80057FA4
    /* 48794 80057F94 04000624 */   addiu     $a2, $zero, 0x4
  .L80057F98:
    /* 48798 80057F98 5402458E */  lw         $a1, 0x254($s2)
    /* 4879C 80057F9C 0400678E */  lw         $a3, 0x4($s3)
    /* 487A0 80057FA0 05000624 */  addiu      $a2, $zero, 0x5
  .L80057FA4:
    /* 487A4 80057FA4 DABD010C */  jal        AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni
    /* 487A8 80057FA8 00000000 */   nop
    /* 487AC 80057FAC 1D00023C */  lui        $v0, (0x1DFFFF >> 16)
  .L80057FB0:
    /* 487B0 80057FB0 FFFF4234 */  ori        $v0, $v0, (0x1DFFFF & 0xFFFF)
    /* 487B4 80057FB4 2A105400 */  slt        $v0, $v0, $s4
    /* 487B8 80057FB8 0E004014 */  bnez       $v0, .L80057FF4
    /* 487BC 80057FBC 00000000 */   nop
    /* 487C0 80057FC0 46044292 */  lbu        $v0, 0x446($s2)
    /* 487C4 80057FC4 00000000 */  nop
    /* 487C8 80057FC8 0A004010 */  beqz       $v0, .L80057FF4
    /* 487CC 80057FCC 1180023C */   lui       $v0, %hi(D_80113240)
    /* 487D0 80057FD0 4032428C */  lw         $v0, %lo(D_80113240)($v0)
    /* 487D4 80057FD4 00000000 */  nop
    /* 487D8 80057FD8 06004014 */  bnez       $v0, .L80057FF4
    /* 487DC 80057FDC F4042426 */   addiu     $a0, $s1, 0x4F4
    /* 487E0 80057FE0 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 487E4 80057FE4 5402458E */  lw         $a1, 0x254($s2)
    /* 487E8 80057FE8 B0E0478C */  lw         $a3, %lo(D_8011E0B0)($v0)
    /* 487EC 80057FEC DABD010C */  jal        AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni
    /* 487F0 80057FF0 06000624 */   addiu     $a2, $zero, 0x6
  .L80057FF4:
    /* 487F4 80057FF4 2400BF8F */  lw         $ra, 0x24($sp)
    /* 487F8 80057FF8 2000B48F */  lw         $s4, 0x20($sp)
    /* 487FC 80057FFC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 48800 80058000 1800B28F */  lw         $s2, 0x18($sp)
    /* 48804 80058004 1400B18F */  lw         $s1, 0x14($sp)
    /* 48808 80058008 1000B08F */  lw         $s0, 0x10($sp)
    /* 4880C 8005800C 0800E003 */  jr         $ra
    /* 48810 80058010 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel AI_CheckForPlayerActions__FP8Car_tObjT0
