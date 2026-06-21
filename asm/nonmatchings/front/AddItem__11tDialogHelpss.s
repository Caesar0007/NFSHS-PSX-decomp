.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AddItem__11tDialogHelpss, 0x84

glabel AddItem__11tDialogHelpss
    /* 930C 80018B0C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 9310 80018B10 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9314 80018B14 21808000 */  addu       $s0, $a0, $zero
    /* 9318 80018B18 1800BFAF */  sw         $ra, 0x18($sp)
    /* 931C 80018B1C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9320 80018B20 CC000286 */  lh         $v0, 0xCC($s0)
    /* 9324 80018B24 00000000 */  nop
    /* 9328 80018B28 07004228 */  slti       $v0, $v0, 0x7
    /* 932C 80018B2C 13004010 */  beqz       $v0, .L80018B7C
    /* 9330 80018B30 2188C000 */   addu      $s1, $a2, $zero
    /* 9334 80018B34 00240500 */  sll        $a0, $a1, 16
    /* 9338 80018B38 94E4020C */  jal        TextSys_Word__Fi
    /* 933C 80018B3C 03240400 */   sra       $a0, $a0, 16
    /* 9340 80018B40 CC000386 */  lh         $v1, 0xCC($s0)
    /* 9344 80018B44 00000000 */  nop
    /* 9348 80018B48 80180300 */  sll        $v1, $v1, 2
    /* 934C 80018B4C 21180302 */  addu       $v1, $s0, $v1
    /* 9350 80018B50 940062AC */  sw         $v0, 0x94($v1)
    /* 9354 80018B54 00141100 */  sll        $v0, $s1, 16
    /* 9358 80018B58 CC000386 */  lh         $v1, 0xCC($s0)
    /* 935C 80018B5C 03140200 */  sra        $v0, $v0, 16
    /* 9360 80018B60 80180300 */  sll        $v1, $v1, 2
    /* 9364 80018B64 21180302 */  addu       $v1, $s0, $v1
    /* 9368 80018B68 B00062AC */  sw         $v0, 0xB0($v1)
    /* 936C 80018B6C CC000296 */  lhu        $v0, 0xCC($s0)
    /* 9370 80018B70 00000000 */  nop
    /* 9374 80018B74 01004224 */  addiu      $v0, $v0, 0x1
    /* 9378 80018B78 CC0002A6 */  sh         $v0, 0xCC($s0)
  .L80018B7C:
    /* 937C 80018B7C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 9380 80018B80 1400B18F */  lw         $s1, 0x14($sp)
    /* 9384 80018B84 1000B08F */  lw         $s0, 0x10($sp)
    /* 9388 80018B88 0800E003 */  jr         $ra
    /* 938C 80018B8C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AddItem__11tDialogHelpss
