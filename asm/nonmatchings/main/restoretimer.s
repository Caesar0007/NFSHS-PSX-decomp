.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching restoretimer, 0x24

glabel restoretimer
    /* E4B04 800F4304 7819848F */  lw         $a0, %gp_rel(timerevent)($gp)
    /* E4B08 800F4308 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E4B0C 800F430C 1000BFAF */  sw         $ra, 0x10($sp)
    /* E4B10 800F4310 8C1B040C */  jal        DisableEvent
    /* E4B14 800F4314 00000000 */   nop
    /* E4B18 800F4318 1000BF8F */  lw         $ra, 0x10($sp)
    /* E4B1C 800F431C 001880AF */  sw         $zero, %gp_rel(timerflag)($gp)
    /* E4B20 800F4320 0800E003 */  jr         $ra
    /* E4B24 800F4324 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel restoretimer
