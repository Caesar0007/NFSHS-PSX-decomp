.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioEng_StartServer__Fv, 0x24

glabel AudioEng_StartServer__Fv
    /* 6CC34 8007C434 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6CC38 8007C438 0880043C */  lui        $a0, %hi(AudioEng_Update__Fv)
    /* 6CC3C 8007C43C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 6CC40 8007C440 7CA9030C */  jal        iSNDserveradd100hzclient
    /* 6CC44 8007C444 24B88424 */   addiu     $a0, $a0, %lo(AudioEng_Update__Fv)
    /* 6CC48 8007C448 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6CC4C 8007C44C 00000000 */  nop
    /* 6CC50 8007C450 0800E003 */  jr         $ra
    /* 6CC54 8007C454 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioEng_StartServer__Fv
