.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckForWingmanRequest__19AIHigh_BTC_HumanCop, 0x24

glabel CheckForWingmanRequest__19AIHigh_BTC_HumanCop
    /* 4E6EC 8005DEEC 7800838C */  lw         $v1, 0x78($a0)
    /* 4E6F0 8005DEF0 01000224 */  addiu      $v0, $zero, 0x1
    /* 4E6F4 8005DEF4 04006214 */  bne        $v1, $v0, .L8005DF08
    /* 4E6F8 8005DEF8 04000224 */   addiu     $v0, $zero, 0x4
    /* 4E6FC 8005DEFC 780082AC */  sw         $v0, 0x78($a0)
    /* 4E700 8005DF00 0800E003 */  jr         $ra
    /* 4E704 8005DF04 01000224 */   addiu     $v0, $zero, 0x1
  .L8005DF08:
    /* 4E708 8005DF08 0800E003 */  jr         $ra
    /* 4E70C 8005DF0C 21100000 */   addu      $v0, $zero, $zero
endlabel CheckForWingmanRequest__19AIHigh_BTC_HumanCop
