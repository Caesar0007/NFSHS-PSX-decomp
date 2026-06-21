.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetTrackAvailable__13tTrackManagersb, 0x14

glabel SetTrackAvailable__13tTrackManagersb
    /* 1248C 80021C8C 002C0500 */  sll        $a1, $a1, 16
    /* 12490 80021C90 832B0500 */  sra        $a1, $a1, 14
    /* 12494 80021C94 21208500 */  addu       $a0, $a0, $a1
    /* 12498 80021C98 0800E003 */  jr         $ra
    /* 1249C 80021C9C 080086AC */   sw        $a2, 0x8($a0)
endlabel SetTrackAvailable__13tTrackManagersb
