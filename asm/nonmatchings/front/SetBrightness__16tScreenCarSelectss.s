.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetBrightness__16tScreenCarSelectss, 0x14

glabel SetBrightness__16tScreenCarSelectss
    /* 2CCA4 8003C4A4 00340600 */  sll        $a2, $a2, 16
    /* 2CCA8 8003C4A8 C3330600 */  sra        $a2, $a2, 15
    /* 2CCAC 8003C4AC 21208600 */  addu       $a0, $a0, $a2
    /* 2CCB0 8003C4B0 0800E003 */  jr         $ra
    /* 2CCB4 8003C4B4 780385A4 */   sh        $a1, 0x378($a0)
endlabel SetBrightness__16tScreenCarSelectss
