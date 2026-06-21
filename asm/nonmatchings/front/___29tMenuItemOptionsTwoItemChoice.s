.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___29tMenuItemOptionsTwoItemChoice, 0x20

glabel ___29tMenuItemOptionsTwoItemChoice
    /* C700 8001BF00 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* C704 8001BF04 1000BFAF */  sw         $ra, 0x10($sp)
    /* C708 8001BF08 5592000C */  jal        ___24tMenuItemLeftRightChoice
    /* C70C 8001BF0C 00000000 */   nop
    /* C710 8001BF10 1000BF8F */  lw         $ra, 0x10($sp)
    /* C714 8001BF14 00000000 */  nop
    /* C718 8001BF18 0800E003 */  jr         $ra
    /* C71C 8001BF1C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___29tMenuItemOptionsTwoItemChoice
