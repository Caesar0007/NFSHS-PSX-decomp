.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BworldSm_IsSimQuadValid__FP12BWorldSm_Pos, 0x30

glabel BworldSm_IsSimQuadValid__FP12BWorldSm_Pos
    /* 6F91C 8007F11C 7800828C */  lw         $v0, 0x78($a0)
    /* 6F920 8007F120 00000000 */  nop
    /* 6F924 8007F124 03004014 */  bnez       $v0, .L8007F134
    /* 6F928 8007F128 00000000 */   nop
    /* 6F92C 8007F12C 0800E003 */  jr         $ra
    /* 6F930 8007F130 21100000 */   addu      $v0, $zero, $zero
  .L8007F134:
    /* 6F934 8007F134 00004290 */  lbu        $v0, 0x0($v0)
    /* 6F938 8007F138 00000000 */  nop
    /* 6F93C 8007F13C 0F004230 */  andi       $v0, $v0, 0xF
    /* 6F940 8007F140 0E004238 */  xori       $v0, $v0, 0xE
    /* 6F944 8007F144 0800E003 */  jr         $ra
    /* 6F948 8007F148 2B100200 */   sltu      $v0, $zero, $v0
endlabel BworldSm_IsSimQuadValid__FP12BWorldSm_Pos
