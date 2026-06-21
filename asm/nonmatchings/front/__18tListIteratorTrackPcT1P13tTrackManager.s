.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __18tListIteratorTrackPcT1P13tTrackManager, 0x58

glabel __18tListIteratorTrackPcT1P13tTrackManager
    /* 12554 80021D54 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 12558 80021D58 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1255C 80021D5C 21808000 */  addu       $s0, $a0, $zero
    /* 12560 80021D60 2110A000 */  addu       $v0, $a1, $zero
    /* 12564 80021D64 2118C000 */  addu       $v1, $a2, $zero
    /* 12568 80021D68 1400B1AF */  sw         $s1, 0x14($sp)
    /* 1256C 80021D6C 2188E000 */  addu       $s1, $a3, $zero
    /* 12570 80021D70 21280000 */  addu       $a1, $zero, $zero
    /* 12574 80021D74 21304000 */  addu       $a2, $v0, $zero
    /* 12578 80021D78 1800BFAF */  sw         $ra, 0x18($sp)
    /* 1257C 80021D7C D88F000C */  jal        __20tListIteratorIndexedPsPcT2
    /* 12580 80021D80 21386000 */   addu      $a3, $v1, $zero
    /* 12584 80021D84 21100002 */  addu       $v0, $s0, $zero
    /* 12588 80021D88 0180033C */  lui        $v1, %hi(_vt_18tListIteratorTrack)
    /* 1258C 80021D8C E80F6324 */  addiu      $v1, $v1, %lo(_vt_18tListIteratorTrack)
    /* 12590 80021D90 0C0043AC */  sw         $v1, 0xC($v0)
    /* 12594 80021D94 140051AC */  sw         $s1, 0x14($v0)
    /* 12598 80021D98 1800BF8F */  lw         $ra, 0x18($sp)
    /* 1259C 80021D9C 1400B18F */  lw         $s1, 0x14($sp)
    /* 125A0 80021DA0 1000B08F */  lw         $s0, 0x10($sp)
    /* 125A4 80021DA4 0800E003 */  jr         $ra
    /* 125A8 80021DA8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __18tListIteratorTrackPcT1P13tTrackManager
