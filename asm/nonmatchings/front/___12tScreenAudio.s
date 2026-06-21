.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___12tScreenAudio, 0x20

glabel ___12tScreenAudio
    /* 36AFC 800462FC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 36B00 80046300 1000BFAF */  sw         $ra, 0x10($sp)
    /* 36B04 80046304 1E98000C */  jal        ___7tScreen
    /* 36B08 80046308 00000000 */   nop
    /* 36B0C 8004630C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 36B10 80046310 00000000 */  nop
    /* 36B14 80046314 0800E003 */  jr         $ra
    /* 36B18 80046318 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___12tScreenAudio
    /* 36B1C 8004631C 00000000 */  nop
