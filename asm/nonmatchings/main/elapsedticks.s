.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching elapsedticks, 0x30

glabel elapsedticks
    /* D8A30 800E8230 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D8A34 800E8234 1000B0AF */  sw         $s0, 0x10($sp)
    /* D8A38 800E8238 F816908F */  lw         $s0, %gp_rel(tickval)($gp)
    /* D8A3C 800E823C 1400BFAF */  sw         $ra, 0x14($sp)
    /* D8A40 800E8240 88A0030C */  jal        gettick
    /* D8A44 800E8244 00000000 */   nop
    /* D8A48 800E8248 1400BF8F */  lw         $ra, 0x14($sp)
    /* D8A4C 800E824C F81682AF */  sw         $v0, %gp_rel(tickval)($gp)
    /* D8A50 800E8250 23105000 */  subu       $v0, $v0, $s0
    /* D8A54 800E8254 1000B08F */  lw         $s0, 0x10($sp)
    /* D8A58 800E8258 0800E003 */  jr         $ra
    /* D8A5C 800E825C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel elapsedticks
