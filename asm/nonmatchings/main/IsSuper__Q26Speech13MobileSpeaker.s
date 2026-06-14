.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching IsSuper__Q26Speech13MobileSpeaker, 0x1C

glabel IsSuper__Q26Speech13MobileSpeaker
    /* 89AD8 800992D8 6000828C */  lw         $v0, 0x60($a0)
    /* 89ADC 800992DC 00000000 */  nop
    /* 89AE0 800992E0 6002428C */  lw         $v0, 0x260($v0)
    /* 89AE4 800992E4 00000000 */  nop
    /* 89AE8 800992E8 82110200 */  srl        $v0, $v0, 6
    /* 89AEC 800992EC 0800E003 */  jr         $ra
    /* 89AF0 800992F0 01004230 */   andi      $v0, $v0, 0x1
endlabel IsSuper__Q26Speech13MobileSpeaker
