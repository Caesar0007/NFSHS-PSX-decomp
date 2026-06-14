.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_Restart__Fv, 0x78

glabel R3DCar_Restart__Fv
    /* 9E6C8 800ADEC8 21280000 */  addu       $a1, $zero, $zero
    /* 9E6CC 800ADECC 1480063C */  lui        $a2, %hi(Cars_gNumCars)
    /* 9E6D0 800ADED0 F4C7C68C */  lw         $a2, %lo(Cars_gNumCars)($a2)
    /* 9E6D4 800ADED4 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 9E6D8 800ADED8 EC314924 */  addiu      $t1, $v0, %lo(GameSetup_gData)
    /* 9E6DC 800ADEDC 33000824 */  addiu      $t0, $zero, 0x33
    /* 9E6E0 800ADEE0 02000724 */  addiu      $a3, $zero, 0x2
    /* 9E6E4 800ADEE4 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 9E6E8 800ADEE8 DCF94424 */  addiu      $a0, $v0, %lo(Cars_gList)
  .L800ADEEC:
    /* 9E6EC 800ADEEC 2A10A600 */  slt        $v0, $a1, $a2
    /* 9E6F0 800ADEF0 11004010 */  beqz       $v0, .L800ADF38
    /* 9E6F4 800ADEF4 00000000 */   nop
    /* 9E6F8 800ADEF8 0000838C */  lw         $v1, 0x0($a0)
    /* 9E6FC 800ADEFC 00000000 */  nop
    /* 9E700 800ADF00 B40860A4 */  sh         $zero, 0x8B4($v1)
    /* 9E704 800ADF04 B60860A4 */  sh         $zero, 0x8B6($v1)
    /* 9E708 800ADF08 5400228D */  lw         $v0, 0x54($t1)
    /* 9E70C 800ADF0C 00000000 */  nop
    /* 9E710 800ADF10 03004010 */  beqz       $v0, .L800ADF20
    /* 9E714 800ADF14 00000000 */   nop
    /* 9E718 800ADF18 B40868A4 */  sh         $t0, 0x8B4($v1)
    /* 9E71C 800ADF1C B60867A4 */  sh         $a3, 0x8B6($v1)
  .L800ADF20:
    /* 9E720 800ADF20 04008424 */  addiu      $a0, $a0, 0x4
    /* 9E724 800ADF24 0100A524 */  addiu      $a1, $a1, 0x1
    /* 9E728 800ADF28 B80860A4 */  sh         $zero, 0x8B8($v1)
    /* 9E72C 800ADF2C BA0860A4 */  sh         $zero, 0x8BA($v1)
    /* 9E730 800ADF30 BBB70208 */  j          .L800ADEEC
    /* 9E734 800ADF34 7E0860A4 */   sh        $zero, 0x87E($v1)
  .L800ADF38:
    /* 9E738 800ADF38 0800E003 */  jr         $ra
    /* 9E73C 800ADF3C 00000000 */   nop
endlabel R3DCar_Restart__Fv
