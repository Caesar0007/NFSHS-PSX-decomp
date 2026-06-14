.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_InitSnow__Fv, 0x60

glabel Weather_InitSnow__Fv
    /* D2718 800E1F18 1280023C */  lui        $v0, %hi(Weather_gSys)
    /* D271C 800E1F1C 96000324 */  addiu      $v1, $zero, 0x96
    /* D2720 800E1F20 083443AC */  sw         $v1, %lo(Weather_gSys)($v0)
    /* D2724 800E1F24 08344224 */  addiu      $v0, $v0, %lo(Weather_gSys)
    /* D2728 800E1F28 80020324 */  addiu      $v1, $zero, 0x280
    /* D272C 800E1F2C 200043A4 */  sh         $v1, 0x20($v0)
    /* D2730 800E1F30 40010324 */  addiu      $v1, $zero, 0x140
    /* D2734 800E1F34 140043A4 */  sh         $v1, 0x14($v0)
    /* D2738 800E1F38 40060324 */  addiu      $v1, $zero, 0x640
    /* D273C 800E1F3C 00050424 */  addiu      $a0, $zero, 0x500
    /* D2740 800E1F40 160043A4 */  sh         $v1, 0x16($v0)
    /* D2744 800E1F44 C0FE0324 */  addiu      $v1, $zero, -0x140
    /* D2748 800E1F48 1A0043A4 */  sh         $v1, 0x1A($v0)
    /* D274C 800E1F4C C0030324 */  addiu      $v1, $zero, 0x3C0
    /* D2750 800E1F50 1C0043A4 */  sh         $v1, 0x1C($v0)
    /* D2754 800E1F54 EEFF0324 */  addiu      $v1, $zero, -0x12
    /* D2758 800E1F58 0A0043A4 */  sh         $v1, 0xA($v0)
    /* D275C 800E1F5C A0000324 */  addiu      $v1, $zero, 0xA0
    /* D2760 800E1F60 180044A4 */  sh         $a0, 0x18($v0)
    /* D2764 800E1F64 1E0044A4 */  sh         $a0, 0x1E($v0)
    /* D2768 800E1F68 080040A4 */  sh         $zero, 0x8($v0)
    /* D276C 800E1F6C 0C0040A4 */  sh         $zero, 0xC($v0)
    /* D2770 800E1F70 0800E003 */  jr         $ra
    /* D2774 800E1F74 100043AC */   sw        $v1, 0x10($v0)
endlabel Weather_InitSnow__Fv
