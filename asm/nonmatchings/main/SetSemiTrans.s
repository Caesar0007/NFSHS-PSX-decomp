.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetSemiTrans, 0x28

glabel SetSemiTrans
    /* E38FC 800F30FC 0400A010 */  beqz       $a1, .L800F3110
    /* E3900 800F3100 00000000 */   nop
    /* E3904 800F3104 07008290 */  lbu        $v0, 0x7($a0)
    /* E3908 800F3108 47CC0308 */  j          .L800F311C
    /* E390C 800F310C 02004234 */   ori       $v0, $v0, 0x2
  .L800F3110:
    /* E3910 800F3110 07008290 */  lbu        $v0, 0x7($a0)
    /* E3914 800F3114 00000000 */  nop
    /* E3918 800F3118 FD004230 */  andi       $v0, $v0, 0xFD
  .L800F311C:
    /* E391C 800F311C 0800E003 */  jr         $ra
    /* E3920 800F3120 070082A0 */   sb        $v0, 0x7($a0)
endlabel SetSemiTrans
    /* E3924 800F3124 00000000 */  nop
    /* E3928 800F3128 00000000 */  nop
