.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_InitRain__Fv, 0x60

glabel Weather_InitRain__Fv
    /* D2778 800E1F78 1280023C */  lui        $v0, %hi(Weather_gSys)
    /* D277C 800E1F7C 96000324 */  addiu      $v1, $zero, 0x96
    /* D2780 800E1F80 083443AC */  sw         $v1, %lo(Weather_gSys)($v0)
    /* D2784 800E1F84 08344224 */  addiu      $v0, $v0, %lo(Weather_gSys)
    /* D2788 800E1F88 40040424 */  addiu      $a0, $zero, 0x440
    /* D278C 800E1F8C 80010324 */  addiu      $v1, $zero, 0x180
    /* D2790 800E1F90 140043A4 */  sh         $v1, 0x14($v0)
    /* D2794 800E1F94 000A0324 */  addiu      $v1, $zero, 0xA00
    /* D2798 800E1F98 160043A4 */  sh         $v1, 0x16($v0)
    /* D279C 800E1F9C 80080324 */  addiu      $v1, $zero, 0x880
    /* D27A0 800E1FA0 180043A4 */  sh         $v1, 0x18($v0)
    /* D27A4 800E1FA4 C0FE0324 */  addiu      $v1, $zero, -0x140
    /* D27A8 800E1FA8 1A0043A4 */  sh         $v1, 0x1A($v0)
    /* D27AC 800E1FAC 80050324 */  addiu      $v1, $zero, 0x580
    /* D27B0 800E1FB0 1E0043A4 */  sh         $v1, 0x1E($v0)
    /* D27B4 800E1FB4 98FF0324 */  addiu      $v1, $zero, -0x68
    /* D27B8 800E1FB8 0A0043A4 */  sh         $v1, 0xA($v0)
    /* D27BC 800E1FBC A0000324 */  addiu      $v1, $zero, 0xA0
    /* D27C0 800E1FC0 200044A4 */  sh         $a0, 0x20($v0)
    /* D27C4 800E1FC4 1C0044A4 */  sh         $a0, 0x1C($v0)
    /* D27C8 800E1FC8 080040A4 */  sh         $zero, 0x8($v0)
    /* D27CC 800E1FCC 0C0040A4 */  sh         $zero, 0xC($v0)
    /* D27D0 800E1FD0 0800E003 */  jr         $ra
    /* D27D4 800E1FD4 100043AC */   sw        $v1, 0x10($v0)
endlabel Weather_InitRain__Fv
