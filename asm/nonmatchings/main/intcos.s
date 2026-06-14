.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching intcos, 0x4

glabel intcos
    /* E20E4 800F18E4 00018424 */  addiu      $a0, $a0, 0x100
endlabel intcos
