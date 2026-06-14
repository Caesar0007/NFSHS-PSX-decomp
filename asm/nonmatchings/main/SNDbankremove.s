.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDbankremove, 0x20

glabel SNDbankremove
    /* D6E74 800E6674 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D6E78 800E6678 1000BFAF */  sw         $ra, 0x10($sp)
    /* D6E7C 800E667C A599030C */  jal        cSNDbankremove
    /* D6E80 800E6680 21280000 */   addu      $a1, $zero, $zero
    /* D6E84 800E6684 1000BF8F */  lw         $ra, 0x10($sp)
    /* D6E88 800E6688 00000000 */  nop
    /* D6E8C 800E668C 0800E003 */  jr         $ra
    /* D6E90 800E6690 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SNDbankremove
