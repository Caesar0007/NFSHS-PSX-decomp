.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Get__25AIDataRecord_TrackCurve_ti, 0x18

glabel Get__25AIDataRecord_TrackCurve_ti
    /* 5DBA4 8006D3A4 4800828C */  lw         $v0, 0x48($a0)
    /* 5DBA8 8006D3A8 00000000 */  nop
    /* 5DBAC 8006D3AC 21104500 */  addu       $v0, $v0, $a1
    /* 5DBB0 8006D3B0 00004290 */  lbu        $v0, 0x0($v0)
    /* 5DBB4 8006D3B4 0800E003 */  jr         $ra
    /* 5DBB8 8006D3B8 00000000 */   nop
endlabel Get__25AIDataRecord_TrackCurve_ti
