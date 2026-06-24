.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_SentenceGetChoices, 0x140

glabel iSPCH_SentenceGetChoices
    /* F178C 80100F8C C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* F1790 80100F90 2400B5AF */  sw         $s5, 0x24($sp)
    /* F1794 80100F94 21A88000 */  addu       $s5, $a0, $zero
    /* F1798 80100F98 2C00B7AF */  sw         $s7, 0x2C($sp)
    /* F179C 80100F9C 21B8A000 */  addu       $s7, $a1, $zero
    /* F17A0 80100FA0 1000B0AF */  sw         $s0, 0x10($sp)
    /* F17A4 80100FA4 2180C000 */  addu       $s0, $a2, $zero
    /* F17A8 80100FA8 1400B1AF */  sw         $s1, 0x14($sp)
    /* F17AC 80100FAC 2188E000 */  addu       $s1, $a3, $zero
    /* F17B0 80100FB0 2000B4AF */  sw         $s4, 0x20($sp)
    /* F17B4 80100FB4 01001424 */  addiu      $s4, $zero, 0x1
    /* F17B8 80100FB8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* F17BC 80100FBC 21980000 */  addu       $s3, $zero, $zero
    /* F17C0 80100FC0 3000BFAF */  sw         $ra, 0x30($sp)
    /* F17C4 80100FC4 2800B6AF */  sw         $s6, 0x28($sp)
    /* F17C8 80100FC8 CC01040C */  jal        VoxSentence_GetNumPhrases
    /* F17CC 80100FCC 1800B2AF */   sw        $s2, 0x18($sp)
    /* F17D0 80100FD0 21B04000 */  addu       $s6, $v0, $zero
    /* F17D4 80100FD4 0D00C22A */  slti       $v0, $s6, 0xD
    /* F17D8 80100FD8 31004010 */  beqz       $v0, .L801010A0
    /* F17DC 80100FDC 21108002 */   addu      $v0, $s4, $zero
    /* F17E0 80100FE0 4800A58F */  lw         $a1, 0x48($sp)
    /* F17E4 80100FE4 C903040C */  jal        iSPCH_ShortRuleStatus
    /* F17E8 80100FE8 2120A002 */   addu      $a0, $s5, $zero
    /* F17EC 80100FEC 06004010 */  beqz       $v0, .L80101008
    /* F17F0 80100FF0 FF000432 */   andi      $a0, $s0, 0xFF
    /* F17F4 80100FF4 FF002532 */  andi       $a1, $s1, 0xFF
    /* F17F8 80100FF8 632D040C */  jal        iSPCH_CheckSentenceRules
    /* F17FC 80100FFC 2130A002 */   addu      $a2, $s5, $zero
    /* F1800 80101000 03004014 */  bnez       $v0, .L80101010
    /* F1804 80101004 00000000 */   nop
  .L80101008:
    /* F1808 80101008 27040408 */  j          .L8010109C
    /* F180C 8010100C 21A00000 */   addu      $s4, $zero, $zero
  .L80101010:
    /* F1810 80101010 2200C01A */  blez       $s6, .L8010109C
    /* F1814 80101014 21900000 */   addu      $s2, $zero, $zero
    /* F1818 80101018 1580023C */  lui        $v0, %hi(ispch_gChoice)
    /* F181C 8010101C E4845024 */  addiu      $s0, $v0, %lo(ispch_gChoice)
  .L80101020:
    /* F1820 80101020 060013A6 */  sh         $s3, 0x6($s0)
    /* F1824 80101024 2120A002 */  addu       $a0, $s5, $zero
    /* F1828 80101028 0400A526 */  addiu      $a1, $s5, 0x4
    /* F182C 8010102C D201040C */  jal        iSPCH_GetOffset8
    /* F1830 80101030 21304002 */   addu      $a2, $s2, $zero
    /* F1834 80101034 21884000 */  addu       $s1, $v0, $zero
    /* F1838 80101038 21202002 */  addu       $a0, $s1, $zero
    /* F183C 8010103C 2128E002 */  addu       $a1, $s7, $zero
    /* F1840 80101040 2002040C */  jal        iSPCH_GetPhraseBank
    /* F1844 80101044 21300002 */   addu      $a2, $s0, $zero
    /* F1848 80101048 08004014 */  bnez       $v0, .L8010106C
    /* F184C 8010104C 21200002 */   addu      $a0, $s0, $zero
    /* F1850 80101050 00000386 */  lh         $v1, 0x0($s0)
    /* F1854 80101054 FEFF0224 */  addiu      $v0, $zero, -0x2
    /* F1858 80101058 10006214 */  bne        $v1, $v0, .L8010109C
    /* F185C 8010105C 21A00000 */   addu      $s4, $zero, $zero
    /* F1860 80101060 FFFF1424 */  addiu      $s4, $zero, -0x1
    /* F1864 80101064 27040408 */  j          .L8010109C
    /* F1868 80101068 000014A6 */   sh        $s4, 0x0($s0)
  .L8010106C:
    /* F186C 8010106C 64000524 */  addiu      $a1, $zero, 0x64
    /* F1870 80101070 2328B300 */  subu       $a1, $a1, $s3
    /* F1874 80101074 21302002 */  addu       $a2, $s1, $zero
    /* F1878 80101078 D302040C */  jal        iSPCH_ChooseSamples
    /* F187C 8010107C 2138E002 */   addu      $a3, $s7, $zero
    /* F1880 80101080 E1FF4010 */  beqz       $v0, .L80101008
    /* F1884 80101084 21986202 */   addu      $s3, $s3, $v0
    /* F1888 80101088 040002A6 */  sh         $v0, 0x4($s0)
    /* F188C 8010108C 01005226 */  addiu      $s2, $s2, 0x1
    /* F1890 80101090 2A105602 */  slt        $v0, $s2, $s6
    /* F1894 80101094 E2FF4014 */  bnez       $v0, .L80101020
    /* F1898 80101098 0C001026 */   addiu     $s0, $s0, 0xC
  .L8010109C:
    /* F189C 8010109C 21108002 */  addu       $v0, $s4, $zero
  .L801010A0:
    /* F18A0 801010A0 3000BF8F */  lw         $ra, 0x30($sp)
    /* F18A4 801010A4 2C00B78F */  lw         $s7, 0x2C($sp)
    /* F18A8 801010A8 2800B68F */  lw         $s6, 0x28($sp)
    /* F18AC 801010AC 2400B58F */  lw         $s5, 0x24($sp)
    /* F18B0 801010B0 2000B48F */  lw         $s4, 0x20($sp)
    /* F18B4 801010B4 1C00B38F */  lw         $s3, 0x1C($sp)
    /* F18B8 801010B8 1800B28F */  lw         $s2, 0x18($sp)
    /* F18BC 801010BC 1400B18F */  lw         $s1, 0x14($sp)
    /* F18C0 801010C0 1000B08F */  lw         $s0, 0x10($sp)
    /* F18C4 801010C4 0800E003 */  jr         $ra
    /* F18C8 801010C8 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel iSPCH_SentenceGetChoices
