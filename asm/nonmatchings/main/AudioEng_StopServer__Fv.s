.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioEng_StopServer__Fv, 0x24

glabel AudioEng_StopServer__Fv
    /* 6CC58 8007C458 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6CC5C 8007C45C 0880043C */  lui        $a0, %hi(AudioEng_Update__Fv)
    /* 6CC60 8007C460 1000BFAF */  sw         $ra, 0x10($sp)
    /* 6CC64 8007C464 88A9030C */  jal        iSNDserverremove100hzclient
    /* 6CC68 8007C468 24B88424 */   addiu     $a0, $a0, %lo(AudioEng_Update__Fv)
    /* 6CC6C 8007C46C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 6CC70 8007C470 00000000 */  nop
    /* 6CC74 8007C474 0800E003 */  jr         $ra
    /* 6CC78 8007C478 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioEng_StopServer__Fv
