.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CountLocations__6Speech, 0x70

glabel CountLocations__6Speech
    /* 84EF8 800946F8 1180033C */  lui        $v1, %hi(Speech_gLocationDescription)
    /* 84EFC 800946FC 1180023C */  lui        $v0, %hi(D_80113228)
    /* 84F00 80094700 600380AC */  sw         $zero, 0x360($a0)
    /* 84F04 80094704 2832428C */  lw         $v0, %lo(D_80113228)($v0)
    /* 84F08 80094708 DC1D6324 */  addiu      $v1, $v1, %lo(Speech_gLocationDescription)
    /* 84F0C 8009470C 80100200 */  sll        $v0, $v0, 2
    /* 84F10 80094710 21104300 */  addu       $v0, $v0, $v1
    /* 84F14 80094714 0000458C */  lw         $a1, 0x0($v0)
    /* 84F18 80094718 00000000 */  nop
    /* 84F1C 8009471C 1000A010 */  beqz       $a1, .L80094760
    /* 84F20 80094720 00000000 */   nop
    /* 84F24 80094724 0000A28C */  lw         $v0, 0x0($a1)
    /* 84F28 80094728 00000000 */  nop
    /* 84F2C 8009472C 0C004010 */  beqz       $v0, .L80094760
    /* 84F30 80094730 00000000 */   nop
  .L80094734:
    /* 84F34 80094734 6003838C */  lw         $v1, 0x360($a0)
    /* 84F38 80094738 00000000 */  nop
    /* 84F3C 8009473C 10006228 */  slti       $v0, $v1, 0x10
    /* 84F40 80094740 07004010 */  beqz       $v0, .L80094760
    /* 84F44 80094744 0800A524 */   addiu     $a1, $a1, 0x8
    /* 84F48 80094748 01006224 */  addiu      $v0, $v1, 0x1
    /* 84F4C 8009474C 600382AC */  sw         $v0, 0x360($a0)
    /* 84F50 80094750 0000A28C */  lw         $v0, 0x0($a1)
    /* 84F54 80094754 00000000 */  nop
    /* 84F58 80094758 F6FF4014 */  bnez       $v0, .L80094734
    /* 84F5C 8009475C 00000000 */   nop
  .L80094760:
    /* 84F60 80094760 0800E003 */  jr         $ra
    /* 84F64 80094764 00000000 */   nop
endlabel CountLocations__6Speech
