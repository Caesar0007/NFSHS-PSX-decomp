.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___31tMenuItemOptionsLeftRightChoice, 0x20

glabel ___31tMenuItemOptionsLeftRightChoice
    /* C720 8001BF20 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* C724 8001BF24 1000BFAF */  sw         $ra, 0x10($sp)
    /* C728 8001BF28 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* C72C 8001BF2C 00000000 */   nop
    /* C730 8001BF30 1000BF8F */  lw         $ra, 0x10($sp)
    /* C734 8001BF34 00000000 */  nop
    /* C738 8001BF38 0800E003 */  jr         $ra
    /* C73C 8001BF3C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___31tMenuItemOptionsLeftRightChoice
