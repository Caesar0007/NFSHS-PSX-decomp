.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InitCARD2, 0x3C

glabel InitCARD2
    /* FD1C0 8010C9C0 B0000A24 */  addiu      $t2, $zero, 0xB0
    /* FD1C4 8010C9C4 08004001 */  jr         $t2
    /* FD1C8 8010C9C8 4A000924 */   addiu     $t1, $zero, 0x4A
    /* FD1CC 8010C9CC 00000000 */  nop
    /* FD1D0 8010C9D0 0A006F94 */  lhu        $t7, 0xA($v1)
    /* FD1D4 8010C9D4 0000083C */  lui        $t0, (0x0 >> 16)
    /* FD1D8 8010C9D8 25C0E201 */  or         $t8, $t7, $v0
    /* FD1DC 8010C9DC 12001937 */  ori        $t9, $t8, 0x12
    /* FD1E0 8010C9E0 0A0079A4 */  sh         $t9, 0xA($v1)
    /* FD1E4 8010C9E4 28000824 */  addiu      $t0, $zero, 0x28
  .L8010C9E8:
    /* FD1E8 8010C9E8 FFFF0825 */  addiu      $t0, $t0, -0x1
    /* FD1EC 8010C9EC FEFF0015 */  bnez       $t0, .L8010C9E8
    /* FD1F0 8010C9F0 00000000 */   nop
    /* FD1F4 8010C9F4 0800E003 */  jr         $ra
    /* FD1F8 8010C9F8 00000000 */   nop
endlabel InitCARD2
