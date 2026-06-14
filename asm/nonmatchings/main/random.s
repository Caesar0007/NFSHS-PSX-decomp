.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching random, 0xD0

glabel random
    /* D7FA8 800E77A8 1280043C */  lui        $a0, %hi(seed)
    /* D7FAC 800E77AC 9C348424 */  addiu      $a0, $a0, %lo(seed)
    /* D7FB0 800E77B0 14008D8C */  lw         $t5, 0x14($a0)
    /* D7FB4 800E77B4 10008C8C */  lw         $t4, 0x10($a0)
    /* D7FB8 800E77B8 0C008B8C */  lw         $t3, 0xC($a0)
    /* D7FBC 800E77BC 08008A8C */  lw         $t2, 0x8($a0)
    /* D7FC0 800E77C0 0400898C */  lw         $t1, 0x4($a0)
    /* D7FC4 800E77C4 0000888C */  lw         $t0, 0x0($a0)
    /* D7FC8 800E77C8 21608D01 */  addu       $t4, $t4, $t5
    /* D7FCC 800E77CC 2B288D01 */  sltu       $a1, $t4, $t5
    /* D7FD0 800E77D0 21586C01 */  addu       $t3, $t3, $t4
    /* D7FD4 800E77D4 2B306C01 */  sltu       $a2, $t3, $t4
    /* D7FD8 800E77D8 21586501 */  addu       $t3, $t3, $a1
    /* D7FDC 800E77DC 2B286501 */  sltu       $a1, $t3, $a1
    /* D7FE0 800E77E0 2128A600 */  addu       $a1, $a1, $a2
    /* D7FE4 800E77E4 21504B01 */  addu       $t2, $t2, $t3
    /* D7FE8 800E77E8 2B304B01 */  sltu       $a2, $t2, $t3
    /* D7FEC 800E77EC 21504501 */  addu       $t2, $t2, $a1
    /* D7FF0 800E77F0 2B284501 */  sltu       $a1, $t2, $a1
    /* D7FF4 800E77F4 2128A600 */  addu       $a1, $a1, $a2
    /* D7FF8 800E77F8 21482A01 */  addu       $t1, $t1, $t2
    /* D7FFC 800E77FC 2B302A01 */  sltu       $a2, $t1, $t2
    /* D8000 800E7800 21482501 */  addu       $t1, $t1, $a1
    /* D8004 800E7804 2B282501 */  sltu       $a1, $t1, $a1
    /* D8008 800E7808 2128A600 */  addu       $a1, $a1, $a2
    /* D800C 800E780C 21400901 */  addu       $t0, $t0, $t1
    /* D8010 800E7810 2B300901 */  sltu       $a2, $t0, $t1
    /* D8014 800E7814 21400501 */  addu       $t0, $t0, $a1
    /* D8018 800E7818 0100AD25 */  addiu      $t5, $t5, 0x1
    /* D801C 800E781C 0E00A015 */  bnez       $t5, .L800E7858
    /* D8020 800E7820 00000000 */   nop
    /* D8024 800E7824 01008C25 */  addiu      $t4, $t4, 0x1
    /* D8028 800E7828 0B008015 */  bnez       $t4, .L800E7858
    /* D802C 800E782C 00000000 */   nop
    /* D8030 800E7830 01006B25 */  addiu      $t3, $t3, 0x1
    /* D8034 800E7834 08006015 */  bnez       $t3, .L800E7858
    /* D8038 800E7838 00000000 */   nop
    /* D803C 800E783C 01004A25 */  addiu      $t2, $t2, 0x1
    /* D8040 800E7840 05004015 */  bnez       $t2, .L800E7858
    /* D8044 800E7844 00000000 */   nop
    /* D8048 800E7848 01002925 */  addiu      $t1, $t1, 0x1
    /* D804C 800E784C 02002015 */  bnez       $t1, .L800E7858
    /* D8050 800E7850 00000000 */   nop
    /* D8054 800E7854 01000825 */  addiu      $t0, $t0, 0x1
  .L800E7858:
    /* D8058 800E7858 14008DAC */  sw         $t5, 0x14($a0)
    /* D805C 800E785C 10008CAC */  sw         $t4, 0x10($a0)
    /* D8060 800E7860 0C008BAC */  sw         $t3, 0xC($a0)
    /* D8064 800E7864 08008AAC */  sw         $t2, 0x8($a0)
    /* D8068 800E7868 040089AC */  sw         $t1, 0x4($a0)
    /* D806C 800E786C 000088AC */  sw         $t0, 0x0($a0)
    /* D8070 800E7870 0800E003 */  jr         $ra
    /* D8074 800E7874 21100001 */   addu      $v0, $t0, $zero
endlabel random
