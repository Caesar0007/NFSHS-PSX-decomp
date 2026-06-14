.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorldSm_SetSlice__FiP12BWorldSm_Pos, 0x54

glabel BWorldSm_SetSlice__FiP12BWorldSm_Pos
    /* 6F564 8007ED64 0000A4A4 */  sh         $a0, 0x0($a1)
    /* 6F568 8007ED68 0000A284 */  lh         $v0, 0x0($a1)
    /* 6F56C 8007ED6C 5800A0A0 */  sb         $zero, 0x58($a1)
    /* 6F570 8007ED70 5900A0A0 */  sb         $zero, 0x59($a1)
    /* 6F574 8007ED74 5A00A0A0 */  sb         $zero, 0x5A($a1)
    /* 6F578 8007ED78 7402838F */  lw         $v1, %gp_rel(BWorldSm_slices)($gp)
    /* 6F57C 8007ED7C 8000A0AC */  sw         $zero, 0x80($a1)
    /* 6F580 8007ED80 7800A0AC */  sw         $zero, 0x78($a1)
    /* 6F584 8007ED84 0400A0A4 */  sh         $zero, 0x4($a1)
    /* 6F588 8007ED88 40110200 */  sll        $v0, $v0, 5
    /* 6F58C 8007ED8C 21104300 */  addu       $v0, $v0, $v1
    /* 6F590 8007ED90 1C004390 */  lbu        $v1, 0x1C($v0)
    /* 6F594 8007ED94 FEFF0224 */  addiu      $v0, $zero, -0x2
    /* 6F598 8007ED98 7600A2A0 */  sb         $v0, 0x76($a1)
    /* 6F59C 8007ED9C 01000224 */  addiu      $v0, $zero, 0x1
    /* 6F5A0 8007EDA0 7700A2A0 */  sb         $v0, 0x77($a1)
    /* 6F5A4 8007EDA4 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 6F5A8 8007EDA8 5B00A0A0 */  sb         $zero, 0x5B($a1)
    /* 6F5AC 8007EDAC 7400A2A0 */  sb         $v0, 0x74($a1)
    /* 6F5B0 8007EDB0 0800E003 */  jr         $ra
    /* 6F5B4 8007EDB4 7500A3A0 */   sb        $v1, 0x75($a1)
endlabel BWorldSm_SetSlice__FiP12BWorldSm_Pos
