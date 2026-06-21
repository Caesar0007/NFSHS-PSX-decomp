.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DoneLoadingBackground__11tScreenMain, 0x7C

glabel DoneLoadingBackground__11tScreenMain
    /* 278DC 800370DC A805858C */  lw         $a1, 0x5A8($a0)
    /* 278E0 800370E0 00000000 */  nop
    /* 278E4 800370E4 80100500 */  sll        $v0, $a1, 2
    /* 278E8 800370E8 21104500 */  addu       $v0, $v0, $a1
    /* 278EC 800370EC C0100200 */  sll        $v0, $v0, 3
    /* 278F0 800370F0 21188200 */  addu       $v1, $a0, $v0
    /* 278F4 800370F4 6405628C */  lw         $v0, 0x564($v1)
    /* 278F8 800370F8 00000000 */  nop
    /* 278FC 800370FC 14004014 */  bnez       $v0, .L80037150
    /* 27900 80037100 21100000 */   addu      $v0, $zero, $zero
    /* 27904 80037104 5C05628C */  lw         $v0, 0x55C($v1)
    /* 27908 80037108 00000000 */  nop
    /* 2790C 8003710C 10004014 */  bnez       $v0, .L80037150
    /* 27910 80037110 21100000 */   addu      $v0, $zero, $zero
    /* 27914 80037114 01000224 */  addiu      $v0, $zero, 0x1
    /* 27918 80037118 23104500 */  subu       $v0, $v0, $a1
    /* 2791C 8003711C 80180200 */  sll        $v1, $v0, 2
    /* 27920 80037120 21186200 */  addu       $v1, $v1, $v0
    /* 27924 80037124 C0180300 */  sll        $v1, $v1, 3
    /* 27928 80037128 21208300 */  addu       $a0, $a0, $v1
    /* 2792C 8003712C 6405828C */  lw         $v0, 0x564($a0)
    /* 27930 80037130 00000000 */  nop
    /* 27934 80037134 06004014 */  bnez       $v0, .L80037150
    /* 27938 80037138 21100000 */   addu      $v0, $zero, $zero
    /* 2793C 8003713C 5C05838C */  lw         $v1, 0x55C($a0)
    /* 27940 80037140 00000000 */  nop
    /* 27944 80037144 02006010 */  beqz       $v1, .L80037150
    /* 27948 80037148 01000224 */   addiu     $v0, $zero, 0x1
    /* 2794C 8003714C 21100000 */  addu       $v0, $zero, $zero
  .L80037150:
    /* 27950 80037150 0800E003 */  jr         $ra
    /* 27954 80037154 00000000 */   nop
endlabel DoneLoadingBackground__11tScreenMain
