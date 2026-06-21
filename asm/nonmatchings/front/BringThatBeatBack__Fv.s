.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BringThatBeatBack__Fv, 0x24

glabel BringThatBeatBack__Fv
    /* 24C14 80034414 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 24C18 80034418 0980043C */  lui        $a0, %hi(Clock_MasterInterruptHandler__Fv)
    /* 24C1C 8003441C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 24C20 80034420 FAAB030C */  jal        addtimer
    /* 24C24 80034424 38B98424 */   addiu     $a0, $a0, %lo(Clock_MasterInterruptHandler__Fv)
    /* 24C28 80034428 1000BF8F */  lw         $ra, 0x10($sp)
    /* 24C2C 8003442C 00000000 */  nop
    /* 24C30 80034430 0800E003 */  jr         $ra
    /* 24C34 80034434 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel BringThatBeatBack__Fv
