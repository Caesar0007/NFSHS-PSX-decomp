.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __pure_virtual, 0x4

glabel __pure_virtual
    /* D4B54 800E4354 0D000000 */  break      0
endlabel __pure_virtual
