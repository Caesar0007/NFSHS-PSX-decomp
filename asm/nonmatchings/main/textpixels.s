.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching textpixels, 0x20

glabel textpixels
    /* D4620 800E3E20 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D4624 800E3E24 1000BFAF */  sw         $ra, 0x10($sp)
    /* D4628 800E3E28 638F030C */  jal        textnpixels
    /* D462C 800E3E2C 00010524 */   addiu     $a1, $zero, 0x100
    /* D4630 800E3E30 1000BF8F */  lw         $ra, 0x10($sp)
    /* D4634 800E3E34 00000000 */  nop
    /* D4638 800E3E38 0800E003 */  jr         $ra
    /* D463C 800E3E3C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel textpixels
