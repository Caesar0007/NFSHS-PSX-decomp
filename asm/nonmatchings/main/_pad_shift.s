.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _pad_shift, 0x10

glabel _pad_shift
    /* EE7E4 800FDFE4 36008290 */  lbu        $v0, 0x36($a0)
    /* EE7E8 800FDFE8 360080A0 */  sb         $zero, 0x36($a0)
    /* EE7EC 800FDFEC 0800E003 */  jr         $ra
    /* EE7F0 800FDFF0 370082A0 */   sb        $v0, 0x37($a0)
endlabel _pad_shift
