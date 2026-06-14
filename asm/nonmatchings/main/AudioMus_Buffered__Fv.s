.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioMus_Buffered__Fv, 0x4C

glabel AudioMus_Buffered__Fv
    /* 6A7DC 80079FDC D401838F */  lw         $v1, %gp_rel(AudioMus_g)($gp)
    /* 6A7E0 80079FE0 00000000 */  nop
    /* 6A7E4 80079FE4 05006010 */  beqz       $v1, .L80079FFC
    /* 6A7E8 80079FE8 00000000 */   nop
    /* 6A7EC 80079FEC 8C00628C */  lw         $v0, 0x8C($v1)
    /* 6A7F0 80079FF0 00000000 */  nop
    /* 6A7F4 80079FF4 03004014 */  bnez       $v0, .L8007A004
    /* 6A7F8 80079FF8 00000000 */   nop
  .L80079FFC:
    /* 6A7FC 80079FFC 0800E003 */  jr         $ra
    /* 6A800 8007A000 21100000 */   addu      $v0, $zero, $zero
  .L8007A004:
    /* 6A804 8007A004 9000628C */  lw         $v0, 0x90($v1)
    /* 6A808 8007A008 00000000 */  nop
    /* 6A80C 8007A00C 04004010 */  beqz       $v0, .L8007A020
    /* 6A810 8007A010 00000000 */   nop
    /* 6A814 8007A014 A800628C */  lw         $v0, 0xA8($v1)
    /* 6A818 8007A018 0800E003 */  jr         $ra
    /* 6A81C 8007A01C 00000000 */   nop
  .L8007A020:
    /* 6A820 8007A020 0800E003 */  jr         $ra
    /* 6A824 8007A024 21100000 */   addu      $v0, $zero, $zero
endlabel AudioMus_Buffered__Fv
