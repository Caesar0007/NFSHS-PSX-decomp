.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DecDCToutCallback, 0x24

glabel DecDCToutCallback
    /* E92D4 800F8AD4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E92D8 800F8AD8 1000BFAF */  sw         $ra, 0x10($sp)
    /* E92DC 800F8ADC 21288000 */  addu       $a1, $a0, $zero
    /* E92E0 800F8AE0 2BCA030C */  jal        DMACallback
    /* E92E4 800F8AE4 01000424 */   addiu     $a0, $zero, 0x1
    /* E92E8 800F8AE8 1000BF8F */  lw         $ra, 0x10($sp)
    /* E92EC 800F8AEC 1800BD27 */  addiu      $sp, $sp, 0x18
    /* E92F0 800F8AF0 0800E003 */  jr         $ra
    /* E92F4 800F8AF4 00000000 */   nop
endlabel DecDCToutCallback
