.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MCRD_restore, 0x44

glabel MCRD_restore
    /* 3FCD8 8004F4D8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 3FCDC 8004F4DC 0580043C */  lui        $a0, %hi(func_8005028C)
    /* 3FCE0 8004F4E0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 3FCE4 8004F4E4 12AC030C */  jal        deltimer
    /* 3FCE8 8004F4E8 8C028424 */   addiu     $a0, $a0, %lo(func_8005028C)
    /* 3FCEC 8004F4EC 21200000 */  addu       $a0, $zero, $zero
    /* 3FCF0 8004F4F0 21288000 */  addu       $a1, $a0, $zero
    /* 3FCF4 8004F4F4 BFEE030C */  jal        MemCardSync
    /* 3FCF8 8004F4F8 21308000 */   addu      $a2, $a0, $zero
    /* 3FCFC 8004F4FC D2EA030C */  jal        MemCardStop
    /* 3FD00 8004F500 00000000 */   nop
    /* 3FD04 8004F504 B6EA030C */  jal        MemCardEnd
    /* 3FD08 8004F508 00000000 */   nop
    /* 3FD0C 8004F50C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 3FD10 8004F510 00000000 */  nop
    /* 3FD14 8004F514 0800E003 */  jr         $ra
    /* 3FD18 8004F518 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MCRD_restore
