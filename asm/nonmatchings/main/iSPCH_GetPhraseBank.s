.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_GetPhraseBank, 0x114

glabel iSPCH_GetPhraseBank
    /* F1080 80100880 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* F1084 80100884 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* F1088 80100888 2198A000 */  addu       $s3, $a1, $zero
    /* F108C 8010088C 1800B2AF */  sw         $s2, 0x18($sp)
    /* F1090 80100890 2190C000 */  addu       $s2, $a2, $zero
    /* F1094 80100894 2000BFAF */  sw         $ra, 0x20($sp)
    /* F1098 80100898 1400B1AF */  sw         $s1, 0x14($sp)
    /* F109C 8010089C 1000B0AF */  sw         $s0, 0x10($sp)
    /* F10A0 801008A0 00008594 */  lhu        $a1, 0x0($a0)
    /* F10A4 801008A4 02008390 */  lbu        $v1, 0x2($a0)
    /* F10A8 801008A8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* F10AC 801008AC 020042A6 */  sh         $v0, 0x2($s2)
    /* F10B0 801008B0 000042A6 */  sh         $v0, 0x0($s2)
    /* F10B4 801008B4 01000224 */  addiu      $v0, $zero, 0x1
    /* F10B8 801008B8 02210300 */  srl        $a0, $v1, 4
    /* F10BC 801008BC 0B008210 */  beq        $a0, $v0, .L801008EC
    /* F10C0 801008C0 0F007130 */   andi      $s1, $v1, 0xF
    /* F10C4 801008C4 05008010 */  beqz       $a0, .L801008DC
    /* F10C8 801008C8 02000224 */   addiu     $v0, $zero, 0x2
    /* F10CC 801008CC 18008210 */  beq        $a0, $v0, .L80100930
    /* F10D0 801008D0 00000000 */   nop
    /* F10D4 801008D4 5B020408 */  j          .L8010096C
    /* F10D8 801008D8 00000000 */   nop
  .L801008DC:
    /* F10DC 801008DC C4AC030C */  jal        iSPCH_FindBank
    /* F10E0 801008E0 FFFFA430 */   andi      $a0, $a1, 0xFFFF
    /* F10E4 801008E4 5B020408 */  j          .L8010096C
    /* F10E8 801008E8 000042A6 */   sh        $v0, 0x0($s2)
  .L801008EC:
    /* F10EC 801008EC 80101100 */  sll        $v0, $s1, 2
    /* F10F0 801008F0 21105300 */  addu       $v0, $v0, $s3
    /* F10F4 801008F4 0000508C */  lw         $s0, 0x0($v0)
    /* F10F8 801008F8 00000000 */  nop
    /* F10FC 801008FC 1A000006 */  bltz       $s0, .L80100968
    /* F1100 80100900 1380023C */   lui       $v0, %hi(gVoxBanks)
    /* F1104 80100904 B470438C */  lw         $v1, %lo(gVoxBanks)($v0)
    /* F1108 80100908 80101000 */  sll        $v0, $s0, 2
    /* F110C 8010090C 21104300 */  addu       $v0, $v0, $v1
    /* F1110 80100910 0000428C */  lw         $v0, 0x0($v0)
    /* F1114 80100914 00000000 */  nop
    /* F1118 80100918 00004394 */  lhu        $v1, 0x0($v0)
    /* F111C 8010091C FFFFA230 */  andi       $v0, $a1, 0xFFFF
    /* F1120 80100920 11006210 */  beq        $v1, $v0, .L80100968
    /* F1124 80100924 00000000 */   nop
    /* F1128 80100928 5A020408 */  j          .L80100968
    /* F112C 8010092C FFFF1024 */   addiu     $s0, $zero, -0x1
  .L80100930:
    /* F1130 80100930 C4AC030C */  jal        iSPCH_FindBank
    /* F1134 80100934 FFFFA430 */   andi      $a0, $a1, 0xFFFF
    /* F1138 80100938 21804000 */  addu       $s0, $v0, $zero
    /* F113C 8010093C 80101100 */  sll        $v0, $s1, 2
    /* F1140 80100940 21885300 */  addu       $s1, $v0, $s3
    /* F1144 80100944 0000258E */  lw         $a1, 0x0($s1)
    /* F1148 80100948 DFAC030C */  jal        iSPCH_TestSubBankBounds
    /* F114C 8010094C 21200002 */   addu      $a0, $s0, $zero
    /* F1150 80100950 04004010 */  beqz       $v0, .L80100964
    /* F1154 80100954 00000000 */   nop
    /* F1158 80100958 00002296 */  lhu        $v0, 0x0($s1)
    /* F115C 8010095C 5A020408 */  j          .L80100968
    /* F1160 80100960 020042A6 */   sh        $v0, 0x2($s2)
  .L80100964:
    /* F1164 80100964 FFFF1024 */  addiu      $s0, $zero, -0x1
  .L80100968:
    /* F1168 80100968 000050A6 */  sh         $s0, 0x0($s2)
  .L8010096C:
    /* F116C 8010096C 00004286 */  lh         $v0, 0x0($s2)
    /* F1170 80100970 2000BF8F */  lw         $ra, 0x20($sp)
    /* F1174 80100974 1C00B38F */  lw         $s3, 0x1C($sp)
    /* F1178 80100978 1800B28F */  lw         $s2, 0x18($sp)
    /* F117C 8010097C 1400B18F */  lw         $s1, 0x14($sp)
    /* F1180 80100980 1000B08F */  lw         $s0, 0x10($sp)
    /* F1184 80100984 27100200 */  nor        $v0, $zero, $v0
    /* F1188 80100988 C2170200 */  srl        $v0, $v0, 31
    /* F118C 8010098C 0800E003 */  jr         $ra
    /* F1190 80100990 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel iSPCH_GetPhraseBank
