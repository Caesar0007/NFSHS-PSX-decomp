.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GPU_cw, 0xC

glabel GPU_cw
    /* F520C 80104A0C A0000A24 */  addiu      $t2, $zero, 0xA0
    /* F5210 80104A10 08004001 */  jr         $t2
    /* F5214 80104A14 49000924 */   addiu     $t1, $zero, 0x49
endlabel GPU_cw
    /* F5218 80104A18 00000000 */  nop
