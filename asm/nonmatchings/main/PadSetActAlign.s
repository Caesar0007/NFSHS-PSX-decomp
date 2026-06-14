.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PadSetActAlign, 0x38

glabel PadSetActAlign
    /* E092C 800F012C 1380023C */  lui        $v0, %hi(_padFuncPort2Info)
    /* E0930 800F0130 8C7C428C */  lw         $v0, %lo(_padFuncPort2Info)($v0)
    /* E0934 800F0134 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E0938 800F0138 1000B0AF */  sw         $s0, 0x10($sp)
    /* E093C 800F013C 1400BFAF */  sw         $ra, 0x14($sp)
    /* E0940 800F0140 09F84000 */  jalr       $v0
    /* E0944 800F0144 2180A000 */   addu      $s0, $a1, $zero
    /* E0948 800F0148 21204000 */  addu       $a0, $v0, $zero
    /* E094C 800F014C FD16040C */  jal        _padSetActAlign
    /* E0950 800F0150 21280002 */   addu      $a1, $s0, $zero
    /* E0954 800F0154 1400BF8F */  lw         $ra, 0x14($sp)
    /* E0958 800F0158 1000B08F */  lw         $s0, 0x10($sp)
    /* E095C 800F015C 0800E003 */  jr         $ra
    /* E0960 800F0160 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel PadSetActAlign
