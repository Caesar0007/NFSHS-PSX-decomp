.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___15AIHigh_BasicCop, 0x20

glabel ___15AIHigh_BasicCop
    /* 4D34C 8005CB4C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4D350 8005CB50 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4D354 8005CB54 F16C010C */  jal        ___11AIHigh_Base
    /* 4D358 8005CB58 00000000 */   nop
    /* 4D35C 8005CB5C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4D360 8005CB60 00000000 */  nop
    /* 4D364 8005CB64 0800E003 */  jr         $ra
    /* 4D368 8005CB68 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___15AIHigh_BasicCop
