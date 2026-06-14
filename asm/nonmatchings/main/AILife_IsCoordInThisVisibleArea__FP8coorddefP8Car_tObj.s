.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AILife_IsCoordInThisVisibleArea__FP8coorddefP8Car_tObj, 0x64

glabel AILife_IsCoordInThisVisibleArea__FP8coorddefP8Car_tObj
    /* 58F88 80068788 0800838C */  lw         $v1, 0x8($a0)
    /* 58F8C 8006878C A800A28C */  lw         $v0, 0xA8($a1)
    /* 58F90 80068790 00000000 */  nop
    /* 58F94 80068794 23306200 */  subu       $a2, $v1, $v0
    /* 58F98 80068798 0000838C */  lw         $v1, 0x0($a0)
    /* 58F9C 8006879C A000A28C */  lw         $v0, 0xA0($a1)
    /* 58FA0 800687A0 0200C104 */  bgez       $a2, .L800687AC
    /* 58FA4 800687A4 00000000 */   nop
    /* 58FA8 800687A8 23300600 */  negu       $a2, $a2
  .L800687AC:
    /* 58FAC 800687AC 23186200 */  subu       $v1, $v1, $v0
    /* 58FB0 800687B0 02006104 */  bgez       $v1, .L800687BC
    /* 58FB4 800687B4 00000000 */   nop
    /* 58FB8 800687B8 23180300 */  negu       $v1, $v1
  .L800687BC:
    /* 58FBC 800687BC 2A10C300 */  slt        $v0, $a2, $v1
    /* 58FC0 800687C0 04004010 */  beqz       $v0, .L800687D4
    /* 58FC4 800687C4 00000000 */   nop
    /* 58FC8 800687C8 83100600 */  sra        $v0, $a2, 2
    /* 58FCC 800687CC F7A10108 */  j          .L800687DC
    /* 58FD0 800687D0 21186200 */   addu      $v1, $v1, $v0
  .L800687D4:
    /* 58FD4 800687D4 83100300 */  sra        $v0, $v1, 2
    /* 58FD8 800687D8 2118C200 */  addu       $v1, $a2, $v0
  .L800687DC:
    /* 58FDC 800687DC AC00023C */  lui        $v0, (0xAC0000 >> 16)
    /* 58FE0 800687E0 2A104300 */  slt        $v0, $v0, $v1
    /* 58FE4 800687E4 0800E003 */  jr         $ra
    /* 58FE8 800687E8 01004238 */   xori      $v0, $v0, 0x1
endlabel AILife_IsCoordInThisVisibleArea__FP8coorddefP8Car_tObj
