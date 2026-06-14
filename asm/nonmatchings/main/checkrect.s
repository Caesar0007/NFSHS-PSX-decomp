.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching checkrect, 0x2C

glabel checkrect
    /* E7134 800F6934 04008294 */  lhu        $v0, 0x4($a0)
    /* E7138 800F6938 00000000 */  nop
    /* E713C 800F693C 01004230 */  andi       $v0, $v0, 0x1
    /* E7140 800F6940 05004010 */  beqz       $v0, .L800F6958
    /* E7144 800F6944 00000000 */   nop
    /* E7148 800F6948 06008294 */  lhu        $v0, 0x6($a0)
    /* E714C 800F694C 00000000 */  nop
    /* E7150 800F6950 01004234 */  ori        $v0, $v0, 0x1
    /* E7154 800F6954 060082A4 */  sh         $v0, 0x6($a0)
  .L800F6958:
    /* E7158 800F6958 0800E003 */  jr         $ra
    /* E715C 800F695C 00000000 */   nop
endlabel checkrect
