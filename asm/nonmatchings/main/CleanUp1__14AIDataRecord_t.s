.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CleanUp1__14AIDataRecord_t, 0x70

glabel CleanUp1__14AIDataRecord_t
    /* 5D814 8006D014 5400838F */  lw         $v1, %gp_rel(AIDataRecord_BestLine)($gp)
    /* 5D818 8006D018 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5D81C 8006D01C 09006010 */  beqz       $v1, .L8006D044
    /* 5D820 8006D020 1000BFAF */   sw        $ra, 0x10($sp)
    /* 5D824 8006D024 5400628C */  lw         $v0, 0x54($v1)
    /* 5D828 8006D028 03000524 */  addiu      $a1, $zero, 0x3
    /* 5D82C 8006D02C 08004484 */  lh         $a0, 0x8($v0)
    /* 5D830 8006D030 0C00428C */  lw         $v0, 0xC($v0)
    /* 5D834 8006D034 00000000 */  nop
    /* 5D838 8006D038 09F84000 */  jalr       $v0
    /* 5D83C 8006D03C 21206400 */   addu      $a0, $v1, $a0
    /* 5D840 8006D040 540080AF */  sw         $zero, %gp_rel(AIDataRecord_BestLine)($gp)
  .L8006D044:
    /* 5D844 8006D044 5800838F */  lw         $v1, %gp_rel(AIDataRecord_TrackCurve)($gp)
    /* 5D848 8006D048 00000000 */  nop
    /* 5D84C 8006D04C 09006010 */  beqz       $v1, .L8006D074
    /* 5D850 8006D050 03000524 */   addiu     $a1, $zero, 0x3
    /* 5D854 8006D054 5400628C */  lw         $v0, 0x54($v1)
    /* 5D858 8006D058 00000000 */  nop
    /* 5D85C 8006D05C 08004484 */  lh         $a0, 0x8($v0)
    /* 5D860 8006D060 0C00428C */  lw         $v0, 0xC($v0)
    /* 5D864 8006D064 00000000 */  nop
    /* 5D868 8006D068 09F84000 */  jalr       $v0
    /* 5D86C 8006D06C 21206400 */   addu      $a0, $v1, $a0
    /* 5D870 8006D070 580080AF */  sw         $zero, %gp_rel(AIDataRecord_TrackCurve)($gp)
  .L8006D074:
    /* 5D874 8006D074 1000BF8F */  lw         $ra, 0x10($sp)
    /* 5D878 8006D078 00000000 */  nop
    /* 5D87C 8006D07C 0800E003 */  jr         $ra
    /* 5D880 8006D080 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CleanUp1__14AIDataRecord_t
