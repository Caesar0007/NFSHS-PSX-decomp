.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSTRM_create, 0x2C

glabel SNDSTRM_create
    /* DA344 800E9B44 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* DA348 800E9B48 3800A28F */  lw         $v0, 0x38($sp)
    /* DA34C 800E9B4C 2000BFAF */  sw         $ra, 0x20($sp)
    /* DA350 800E9B50 1400A0AF */  sw         $zero, 0x14($sp)
    /* DA354 800E9B54 1800A0AF */  sw         $zero, 0x18($sp)
    /* DA358 800E9B58 CCA5030C */  jal        iSNDstreamcreate
    /* DA35C 800E9B5C 1000A2AF */   sw        $v0, 0x10($sp)
    /* DA360 800E9B60 2000BF8F */  lw         $ra, 0x20($sp)
    /* DA364 800E9B64 00000000 */  nop
    /* DA368 800E9B68 0800E003 */  jr         $ra
    /* DA36C 800E9B6C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel SNDSTRM_create
