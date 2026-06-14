.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckForBlockaderRequest__19AIHigh_BTC_HumanCopPi, 0x44

glabel CheckForBlockaderRequest__19AIHigh_BTC_HumanCopPi
    /* 4E710 8005DF10 0000A0AC */  sw         $zero, 0x0($a1)
    /* 4E714 8005DF14 7800838C */  lw         $v1, 0x78($a0)
    /* 4E718 8005DF18 00000000 */  nop
    /* 4E71C 8005DF1C FEFF6224 */  addiu      $v0, $v1, -0x2
    /* 4E720 8005DF20 0200422C */  sltiu      $v0, $v0, 0x2
    /* 4E724 8005DF24 09004010 */  beqz       $v0, .L8005DF4C
    /* 4E728 8005DF28 03000224 */   addiu     $v0, $zero, 0x3
    /* 4E72C 8005DF2C 03006214 */  bne        $v1, $v0, .L8005DF3C
    /* 4E730 8005DF30 00000000 */   nop
    /* 4E734 8005DF34 01000224 */  addiu      $v0, $zero, 0x1
    /* 4E738 8005DF38 0000A2AC */  sw         $v0, 0x0($a1)
  .L8005DF3C:
    /* 4E73C 8005DF3C 05000224 */  addiu      $v0, $zero, 0x5
    /* 4E740 8005DF40 780082AC */  sw         $v0, 0x78($a0)
    /* 4E744 8005DF44 0800E003 */  jr         $ra
    /* 4E748 8005DF48 01000224 */   addiu     $v0, $zero, 0x1
  .L8005DF4C:
    /* 4E74C 8005DF4C 0800E003 */  jr         $ra
    /* 4E750 8005DF50 21100000 */   addu      $v0, $zero, $zero
endlabel CheckForBlockaderRequest__19AIHigh_BTC_HumanCopPi
