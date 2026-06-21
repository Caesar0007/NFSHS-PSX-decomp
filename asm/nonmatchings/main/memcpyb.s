.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching memcpyb, 0x20

glabel memcpyb
    /* E5A34 800F5234 0000A290 */  lbu        $v0, 0x0($a1)
    /* E5A38 800F5238 0100A524 */  addiu      $a1, $a1, 0x1
    /* E5A3C 800F523C FFFFC624 */  addiu      $a2, $a2, -0x1
    /* E5A40 800F5240 000082A0 */  sb         $v0, 0x0($a0)
    /* E5A44 800F5244 FBFFC014 */  bnez       $a2, memcpyb
    /* E5A48 800F5248 01008424 */   addiu     $a0, $a0, 0x1
    /* E5A4C 800F524C 0800E003 */  jr         $ra
    /* E5A50 800F5250 00000000 */   nop
endlabel memcpyb
