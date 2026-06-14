.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching blockclear, 0x4

glabel blockclear
    /* E1FA0 800F17A0 00000624 */  addiu      $a2, $zero, 0x0
endlabel blockclear
