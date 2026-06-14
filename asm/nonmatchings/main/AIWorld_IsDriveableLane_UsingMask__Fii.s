.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_IsDriveableLane_UsingMask__Fii, 0x1C

glabel AIWorld_IsDriveableLane_UsingMask__Fii
    /* 63C3C 8007343C 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 63C40 80073440 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 63C44 80073444 40210400 */  sll        $a0, $a0, 5
    /* 63C48 80073448 21208200 */  addu       $a0, $a0, $v0
    /* 63C4C 8007344C 16008284 */  lh         $v0, 0x16($a0)
    /* 63C50 80073450 0800E003 */  jr         $ra
    /* 63C54 80073454 24104500 */   and       $v0, $v0, $a1
endlabel AIWorld_IsDriveableLane_UsingMask__Fii
