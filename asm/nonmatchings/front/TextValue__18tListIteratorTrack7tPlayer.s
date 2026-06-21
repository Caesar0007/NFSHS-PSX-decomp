.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TextValue__18tListIteratorTrack7tPlayer, 0x40

glabel TextValue__18tListIteratorTrack7tPlayer
    /* 125D4 80021DD4 1000828C */  lw         $v0, 0x10($a0)
    /* 125D8 80021DD8 00000000 */  nop
    /* 125DC 80021DDC 00004390 */  lbu        $v1, 0x0($v0)
    /* 125E0 80021DE0 0400828C */  lw         $v0, 0x4($a0)
    /* 125E4 80021DE4 00000000 */  nop
    /* 125E8 80021DE8 21104300 */  addu       $v0, $v0, $v1
    /* 125EC 80021DEC 00004290 */  lbu        $v0, 0x0($v0)
    /* 125F0 80021DF0 1400848C */  lw         $a0, 0x14($a0)
    /* 125F4 80021DF4 40180200 */  sll        $v1, $v0, 1
    /* 125F8 80021DF8 21186200 */  addu       $v1, $v1, $v0
    /* 125FC 80021DFC 0400828C */  lw         $v0, 0x4($a0)
    /* 12600 80021E00 00190300 */  sll        $v1, $v1, 4
    /* 12604 80021E04 21104300 */  addu       $v0, $v0, $v1
    /* 12608 80021E08 00004280 */  lb         $v0, 0x0($v0)
    /* 1260C 80021E0C 0800E003 */  jr         $ra
    /* 12610 80021E10 D5004224 */   addiu     $v0, $v0, 0xD5
endlabel TextValue__18tListIteratorTrack7tPlayer
