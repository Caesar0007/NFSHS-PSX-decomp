.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSTRM_queuefile, 0x20

glabel SNDSTRM_queuefile
    /* DA438 800E9C38 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DA43C 800E9C3C 1800BFAF */  sw         $ra, 0x18($sp)
    /* DA440 800E9C40 5CA6030C */  jal        iSNDstreamqueue
    /* DA444 800E9C44 1000A0AF */   sw        $zero, 0x10($sp)
    /* DA448 800E9C48 1800BF8F */  lw         $ra, 0x18($sp)
    /* DA44C 800E9C4C 00000000 */  nop
    /* DA450 800E9C50 0800E003 */  jr         $ra
    /* DA454 800E9C54 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SNDSTRM_queuefile
