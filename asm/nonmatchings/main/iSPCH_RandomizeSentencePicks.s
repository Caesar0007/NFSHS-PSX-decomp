.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_RandomizeSentencePicks, 0xE0

glabel iSPCH_RandomizeSentencePicks
    /* F18CC 801010CC C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* F18D0 801010D0 3000BFAF */  sw         $ra, 0x30($sp)
    /* F18D4 801010D4 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* F18D8 801010D8 2800B6AF */  sw         $s6, 0x28($sp)
    /* F18DC 801010DC 2400B5AF */  sw         $s5, 0x24($sp)
    /* F18E0 801010E0 2000B4AF */  sw         $s4, 0x20($sp)
    /* F18E4 801010E4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* F18E8 801010E8 1800B2AF */  sw         $s2, 0x18($sp)
    /* F18EC 801010EC 1400B1AF */  sw         $s1, 0x14($sp)
    /* F18F0 801010F0 CC01040C */  jal        func_80100730
    /* F18F4 801010F4 1000B0AF */   sw        $s0, 0x10($sp)
    /* F18F8 801010F8 21B04000 */  addu       $s6, $v0, $zero
    /* F18FC 801010FC 2000C01A */  blez       $s6, .L80101180
    /* F1900 80101100 21A80000 */   addu      $s5, $zero, $zero
    /* F1904 80101104 1580023C */  lui        $v0, %hi(ispch_gPickSamples)
    /* F1908 80101108 7C845724 */  addiu      $s7, $v0, %lo(ispch_gPickSamples)
    /* F190C 8010110C 1580023C */  lui        $v0, %hi(ispch_gChoice)
    /* F1910 80101110 E4845224 */  addiu      $s2, $v0, %lo(ispch_gChoice)
  .L80101114:
    /* F1914 80101114 21800000 */  addu       $s0, $zero, $zero
    /* F1918 80101118 04004296 */  lhu        $v0, 0x4($s2)
    /* F191C 8010111C 06004386 */  lh         $v1, 0x6($s2)
    /* F1920 80101120 00140200 */  sll        $v0, $v0, 16
    /* F1924 80101124 03A40200 */  sra        $s4, $v0, 16
    /* F1928 80101128 C2170200 */  srl        $v0, $v0, 31
    /* F192C 8010112C 21108202 */  addu       $v0, $s4, $v0
    /* F1930 80101130 43100200 */  sra        $v0, $v0, 1
    /* F1934 80101134 0E004018 */  blez       $v0, .L80101170
    /* F1938 80101138 21887700 */   addu      $s1, $v1, $s7
    /* F193C 8010113C 21984000 */  addu       $s3, $v0, $zero
  .L80101140:
    /* F1940 80101140 CCAE030C */  jal        iSPCH_Rand
    /* F1944 80101144 21208002 */   addu      $a0, $s4, $zero
    /* F1948 80101148 21203002 */  addu       $a0, $s1, $s0
    /* F194C 8010114C 21102202 */  addu       $v0, $s1, $v0
    /* F1950 80101150 00008590 */  lbu        $a1, 0x0($a0)
    /* F1954 80101154 00004390 */  lbu        $v1, 0x0($v0)
    /* F1958 80101158 01001026 */  addiu      $s0, $s0, 0x1
    /* F195C 8010115C 000083A0 */  sb         $v1, 0x0($a0)
    /* F1960 80101160 000045A0 */  sb         $a1, 0x0($v0)
    /* F1964 80101164 2A101302 */  slt        $v0, $s0, $s3
    /* F1968 80101168 F5FF4014 */  bnez       $v0, .L80101140
    /* F196C 8010116C 00000000 */   nop
  .L80101170:
    /* F1970 80101170 0100B526 */  addiu      $s5, $s5, 0x1
    /* F1974 80101174 2A10B602 */  slt        $v0, $s5, $s6
    /* F1978 80101178 E6FF4014 */  bnez       $v0, .L80101114
    /* F197C 8010117C 0C005226 */   addiu     $s2, $s2, 0xC
  .L80101180:
    /* F1980 80101180 3000BF8F */  lw         $ra, 0x30($sp)
    /* F1984 80101184 2C00B78F */  lw         $s7, 0x2C($sp)
    /* F1988 80101188 2800B68F */  lw         $s6, 0x28($sp)
    /* F198C 8010118C 2400B58F */  lw         $s5, 0x24($sp)
    /* F1990 80101190 2000B48F */  lw         $s4, 0x20($sp)
    /* F1994 80101194 1C00B38F */  lw         $s3, 0x1C($sp)
    /* F1998 80101198 1800B28F */  lw         $s2, 0x18($sp)
    /* F199C 8010119C 1400B18F */  lw         $s1, 0x14($sp)
    /* F19A0 801011A0 1000B08F */  lw         $s0, 0x10($sp)
    /* F19A4 801011A4 0800E003 */  jr         $ra
    /* F19A8 801011A8 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel iSPCH_RandomizeSentencePicks
