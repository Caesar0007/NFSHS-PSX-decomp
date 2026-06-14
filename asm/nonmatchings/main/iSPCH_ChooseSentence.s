.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_ChooseSentence, 0x1A0

glabel iSPCH_ChooseSentence
    /* F1F54 80101754 50FFBD27 */  addiu      $sp, $sp, -0xB0
    /* F1F58 80101758 A400B7AF */  sw         $s7, 0xA4($sp)
    /* F1F5C 8010175C 21B88000 */  addu       $s7, $a0, $zero
    /* F1F60 80101760 9C00B5AF */  sw         $s5, 0x9C($sp)
    /* F1F64 80101764 21A80000 */  addu       $s5, $zero, $zero
    /* F1F68 80101768 AC00BFAF */  sw         $ra, 0xAC($sp)
    /* F1F6C 8010176C A800BEAF */  sw         $fp, 0xA8($sp)
    /* F1F70 80101770 A000B6AF */  sw         $s6, 0xA0($sp)
    /* F1F74 80101774 9800B4AF */  sw         $s4, 0x98($sp)
    /* F1F78 80101778 9400B3AF */  sw         $s3, 0x94($sp)
    /* F1F7C 8010177C 9000B2AF */  sw         $s2, 0x90($sp)
    /* F1F80 80101780 8C00B1AF */  sw         $s1, 0x8C($sp)
    /* F1F84 80101784 8800B0AF */  sw         $s0, 0x88($sp)
    /* F1F88 80101788 8000A0A3 */  sb         $zero, 0x80($sp)
    /* F1F8C 8010178C 0000E48E */  lw         $a0, 0x0($s7)
    /* F1F90 80101790 D39B030C */  jal        iSPCH_FindEvent
    /* F1F94 80101794 2190A002 */   addu      $s2, $s5, $zero
    /* F1F98 80101798 21984000 */  addu       $s3, $v0, $zero
    /* F1F9C 8010179C 49006012 */  beqz       $s3, .L801018C4
    /* F1FA0 801017A0 21104002 */   addu      $v0, $s2, $zero
    /* F1FA4 801017A4 B803040C */  jal        iSPCH_RepeatEvent
    /* F1FA8 801017A8 21206002 */   addu      $a0, $s3, $zero
    /* F1FAC 801017AC 45004010 */  beqz       $v0, .L801018C4
    /* F1FB0 801017B0 21104002 */   addu      $v0, $s2, $zero
    /* F1FB4 801017B4 9405040C */  jal        iSPCH_ClearChosen
    /* F1FB8 801017B8 00000000 */   nop
    /* F1FBC 801017BC 1580023C */  lui        $v0, %hi(gFilterSetting)
    /* F1FC0 801017C0 2C84548C */  lw         $s4, %lo(gFilterSetting)($v0)
    /* F1FC4 801017C4 1580023C */  lui        $v0, %hi(D_80148064)
    /* F1FC8 801017C8 6480438C */  lw         $v1, %lo(D_80148064)($v0)
    /* F1FCC 801017CC 01000224 */  addiu      $v0, $zero, 0x1
    /* F1FD0 801017D0 06006214 */  bne        $v1, $v0, .L801017EC
    /* F1FD4 801017D4 00000000 */   nop
    /* F1FD8 801017D8 21A08202 */  addu       $s4, $s4, $v0
    /* F1FDC 801017DC 0300822A */  slti       $v0, $s4, 0x3
    /* F1FE0 801017E0 02004014 */  bnez       $v0, .L801017EC
    /* F1FE4 801017E4 00000000 */   nop
    /* F1FE8 801017E8 02001424 */  addiu      $s4, $zero, 0x2
  .L801017EC:
    /* F1FEC 801017EC CF01040C */  jal        func_8010073C
    /* F1FF0 801017F0 21206002 */   addu      $a0, $s3, $zero
    /* F1FF4 801017F4 FF004230 */  andi       $v0, $v0, 0xFF
    /* F1FF8 801017F8 04004010 */  beqz       $v0, .L8010180C
    /* F1FFC 801017FC 01000224 */   addiu     $v0, $zero, 0x1
    /* F2000 80101800 03008216 */  bne        $s4, $v0, .L80101810
    /* F2004 80101804 21206002 */   addu      $a0, $s3, $zero
    /* F2008 80101808 21A00000 */  addu       $s4, $zero, $zero
  .L8010180C:
    /* F200C 8010180C 21206002 */  addu       $a0, $s3, $zero
  .L80101810:
    /* F2010 80101810 2128E002 */  addu       $a1, $s7, $zero
    /* F2014 80101814 F32C040C */  jal        iSPCH_GetRuleSettings
    /* F2018 80101818 8000A627 */   addiu     $a2, $sp, 0x80
    /* F201C 8010181C 21206002 */  addu       $a0, $s3, $zero
    /* F2020 80101820 1800A527 */  addiu      $a1, $sp, 0x18
    /* F2024 80101824 6503040C */  jal        iSPCH_OrderSentences
    /* F2028 80101828 21F04000 */   addu      $fp, $v0, $zero
    /* F202C 8010182C 06007692 */  lbu        $s6, 0x6($s3)
    /* F2030 80101830 00000000 */  nop
    /* F2034 80101834 2200C01A */  blez       $s6, .L801018C0
    /* F2038 80101838 FFFF1224 */   addiu     $s2, $zero, -0x1
    /* F203C 8010183C 21900000 */  addu       $s2, $zero, $zero
  .L80101840:
    /* F2040 80101840 2A10B602 */  slt        $v0, $s5, $s6
    /* F2044 80101844 1E004010 */  beqz       $v0, .L801018C0
    /* F2048 80101848 2110B503 */   addu      $v0, $sp, $s5
    /* F204C 8010184C 18005190 */  lbu        $s1, 0x18($v0)
    /* F2050 80101850 00000000 */  nop
    /* F2054 80101854 1A002006 */  bltz       $s1, .L801018C0
    /* F2058 80101858 2A103602 */   slt       $v0, $s1, $s6
    /* F205C 8010185C 18004010 */  beqz       $v0, .L801018C0
    /* F2060 80101860 21206002 */   addu      $a0, $s3, $zero
    /* F2064 80101864 0C006526 */  addiu      $a1, $s3, 0xC
    /* F2068 80101868 D801040C */  jal        func_80100760
    /* F206C 8010186C 21302002 */   addu      $a2, $s1, $zero
    /* F2070 80101870 21804000 */  addu       $s0, $v0, $zero
    /* F2074 80101874 21200002 */  addu       $a0, $s0, $zero
    /* F2078 80101878 2128E002 */  addu       $a1, $s7, $zero
    /* F207C 8010187C 8000A793 */  lbu        $a3, 0x80($sp)
    /* F2080 80101880 FF00C633 */  andi       $a2, $fp, 0xFF
    /* F2084 80101884 E303040C */  jal        iSPCH_SentenceGetChoices
    /* F2088 80101888 1000B4AF */   sw        $s4, 0x10($sp)
    /* F208C 8010188C 0A004018 */  blez       $v0, .L801018B8
    /* F2090 80101890 21200002 */   addu      $a0, $s0, $zero
    /* F2094 80101894 C404040C */  jal        iSPCH_SentenceMakeChoice
    /* F2098 80101898 21288002 */   addu      $a1, $s4, $zero
    /* F209C 8010189C 21904000 */  addu       $s2, $v0, $zero
    /* F20A0 801018A0 05004012 */  beqz       $s2, .L801018B8
    /* F20A4 801018A4 21206002 */   addu      $a0, $s3, $zero
    /* F20A8 801018A8 21280002 */  addu       $a1, $s0, $zero
    /* F20AC 801018AC 21302002 */  addu       $a2, $s1, $zero
    /* F20B0 801018B0 9705040C */  jal        iSPCH_SaveChosenSentence
    /* F20B4 801018B4 2138E002 */   addu      $a3, $s7, $zero
  .L801018B8:
    /* F20B8 801018B8 E1FF4012 */  beqz       $s2, .L80101840
    /* F20BC 801018BC 0100B526 */   addiu     $s5, $s5, 0x1
  .L801018C0:
    /* F20C0 801018C0 21104002 */  addu       $v0, $s2, $zero
  .L801018C4:
    /* F20C4 801018C4 AC00BF8F */  lw         $ra, 0xAC($sp)
    /* F20C8 801018C8 A800BE8F */  lw         $fp, 0xA8($sp)
    /* F20CC 801018CC A400B78F */  lw         $s7, 0xA4($sp)
    /* F20D0 801018D0 A000B68F */  lw         $s6, 0xA0($sp)
    /* F20D4 801018D4 9C00B58F */  lw         $s5, 0x9C($sp)
    /* F20D8 801018D8 9800B48F */  lw         $s4, 0x98($sp)
    /* F20DC 801018DC 9400B38F */  lw         $s3, 0x94($sp)
    /* F20E0 801018E0 9000B28F */  lw         $s2, 0x90($sp)
    /* F20E4 801018E4 8C00B18F */  lw         $s1, 0x8C($sp)
    /* F20E8 801018E8 8800B08F */  lw         $s0, 0x88($sp)
    /* F20EC 801018EC 0800E003 */  jr         $ra
    /* F20F0 801018F0 B000BD27 */   addiu     $sp, $sp, 0xB0
endlabel iSPCH_ChooseSentence
