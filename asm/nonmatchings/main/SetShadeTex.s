.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetShadeTex, 0x28

glabel SetShadeTex
    /* E691C 800F611C 0400A010 */  beqz       $a1, .L800F6130
    /* E6920 800F6120 00000000 */   nop
    /* E6924 800F6124 07008290 */  lbu        $v0, 0x7($a0)
    /* E6928 800F6128 4FD80308 */  j          .L800F613C
    /* E692C 800F612C 01004234 */   ori       $v0, $v0, 0x1
  .L800F6130:
    /* E6930 800F6130 07008290 */  lbu        $v0, 0x7($a0)
    /* E6934 800F6134 00000000 */  nop
    /* E6938 800F6138 FE004230 */  andi       $v0, $v0, 0xFE
  .L800F613C:
    /* E693C 800F613C 0800E003 */  jr         $ra
    /* E6940 800F6140 070082A0 */   sb        $v0, 0x7($a0)
endlabel SetShadeTex
    /* E6944 800F6144 00000000 */  nop
    /* E6948 800F6148 00000000 */  nop
