.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Distance__Q26Speech12LocationBanki, 0x94

glabel Distance__Q26Speech12LocationBanki
    /* 8506C 8009486C 0000868C */  lw         $a2, 0x0($a0)
    /* 85070 80094870 0400848C */  lw         $a0, 0x4($a0)
    /* 85074 80094874 00000000 */  nop
    /* 85078 80094878 2A108600 */  slt        $v0, $a0, $a2
    /* 8507C 8009487C 0E004010 */  beqz       $v0, .L800948B8
    /* 85080 80094880 2A10A600 */   slt       $v0, $a1, $a2
    /* 85084 80094884 0A004010 */  beqz       $v0, .L800948B0
    /* 85088 80094888 2A108500 */   slt       $v0, $a0, $a1
    /* 8508C 8009488C 08004010 */  beqz       $v0, .L800948B0
    /* 85090 80094890 2318A400 */   subu      $v1, $a1, $a0
  .L80094894:
    /* 85094 80094894 2320C500 */  subu       $a0, $a2, $a1
  .L80094898:
    /* 85098 80094898 2A108300 */  slt        $v0, $a0, $v1
    /* 8509C 8009489C 02004010 */  beqz       $v0, .L800948A8
    /* 850A0 800948A0 00000000 */   nop
    /* 850A4 800948A4 21188000 */  addu       $v1, $a0, $zero
  .L800948A8:
    /* 850A8 800948A8 0800E003 */  jr         $ra
    /* 850AC 800948AC 21106000 */   addu      $v0, $v1, $zero
  .L800948B0:
    /* 850B0 800948B0 0800E003 */  jr         $ra
    /* 850B4 800948B4 21100000 */   addu      $v0, $zero, $zero
  .L800948B8:
    /* 850B8 800948B8 07004010 */  beqz       $v0, .L800948D8
    /* 850BC 800948BC 2A108500 */   slt       $v0, $a0, $a1
    /* 850C0 800948C0 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 850C4 800948C4 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 850C8 800948C8 00000000 */  nop
    /* 850CC 800948CC 2110A200 */  addu       $v0, $a1, $v0
    /* 850D0 800948D0 25520208 */  j          .L80094894
    /* 850D4 800948D4 23184400 */   subu      $v1, $v0, $a0
  .L800948D8:
    /* 850D8 800948D8 07004010 */  beqz       $v0, .L800948F8
    /* 850DC 800948DC 2320A400 */   subu      $a0, $a1, $a0
    /* 850E0 800948E0 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 850E4 800948E4 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 850E8 800948E8 00000000 */  nop
    /* 850EC 800948EC 2110C200 */  addu       $v0, $a2, $v0
    /* 850F0 800948F0 26520208 */  j          .L80094898
    /* 850F4 800948F4 23184500 */   subu      $v1, $v0, $a1
  .L800948F8:
    /* 850F8 800948F8 0800E003 */  jr         $ra
    /* 850FC 800948FC 21100000 */   addu      $v0, $zero, $zero
endlabel Distance__Q26Speech12LocationBanki
