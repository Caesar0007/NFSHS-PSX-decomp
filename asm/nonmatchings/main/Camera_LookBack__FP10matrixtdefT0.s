.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Camera_LookBack__FP10matrixtdefT0, 0x88

glabel Camera_LookBack__FP10matrixtdefT0
    /* 70F3C 8008073C 0000828C */  lw         $v0, 0x0($a0)
    /* 70F40 80080740 00000000 */  nop
    /* 70F44 80080744 23100200 */  negu       $v0, $v0
    /* 70F48 80080748 0000A2AC */  sw         $v0, 0x0($a1)
    /* 70F4C 8008074C 0400828C */  lw         $v0, 0x4($a0)
    /* 70F50 80080750 00000000 */  nop
    /* 70F54 80080754 23100200 */  negu       $v0, $v0
    /* 70F58 80080758 0400A2AC */  sw         $v0, 0x4($a1)
    /* 70F5C 8008075C 0800828C */  lw         $v0, 0x8($a0)
    /* 70F60 80080760 00000000 */  nop
    /* 70F64 80080764 23100200 */  negu       $v0, $v0
    /* 70F68 80080768 0800A2AC */  sw         $v0, 0x8($a1)
    /* 70F6C 8008076C 0C00828C */  lw         $v0, 0xC($a0)
    /* 70F70 80080770 00000000 */  nop
    /* 70F74 80080774 0C00A2AC */  sw         $v0, 0xC($a1)
    /* 70F78 80080778 1000828C */  lw         $v0, 0x10($a0)
    /* 70F7C 8008077C 00000000 */  nop
    /* 70F80 80080780 1000A2AC */  sw         $v0, 0x10($a1)
    /* 70F84 80080784 1400828C */  lw         $v0, 0x14($a0)
    /* 70F88 80080788 00000000 */  nop
    /* 70F8C 8008078C 1400A2AC */  sw         $v0, 0x14($a1)
    /* 70F90 80080790 1800828C */  lw         $v0, 0x18($a0)
    /* 70F94 80080794 00000000 */  nop
    /* 70F98 80080798 23100200 */  negu       $v0, $v0
    /* 70F9C 8008079C 1800A2AC */  sw         $v0, 0x18($a1)
    /* 70FA0 800807A0 1C00828C */  lw         $v0, 0x1C($a0)
    /* 70FA4 800807A4 00000000 */  nop
    /* 70FA8 800807A8 23100200 */  negu       $v0, $v0
    /* 70FAC 800807AC 1C00A2AC */  sw         $v0, 0x1C($a1)
    /* 70FB0 800807B0 2000828C */  lw         $v0, 0x20($a0)
    /* 70FB4 800807B4 00000000 */  nop
    /* 70FB8 800807B8 23100200 */  negu       $v0, $v0
    /* 70FBC 800807BC 0800E003 */  jr         $ra
    /* 70FC0 800807C0 2000A2AC */   sw        $v0, 0x20($a1)
endlabel Camera_LookBack__FP10matrixtdefT0
