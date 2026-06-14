.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDstreamgetstreamptr, 0x1C

glabel iSNDstreamgetstreamptr
    /* D9448 800E8C48 04008014 */  bnez       $a0, .L800E8C5C
    /* D944C 800E8C4C 1480023C */   lui       $v0, %hi(sndss)
    /* D9450 800E8C50 80EA428C */  lw         $v0, %lo(sndss)($v0)
    /* D9454 800E8C54 0800E003 */  jr         $ra
    /* D9458 800E8C58 00000000 */   nop
  .L800E8C5C:
    /* D945C 800E8C5C 0800E003 */  jr         $ra
    /* D9460 800E8C60 21100000 */   addu      $v0, $zero, $zero
endlabel iSNDstreamgetstreamptr
