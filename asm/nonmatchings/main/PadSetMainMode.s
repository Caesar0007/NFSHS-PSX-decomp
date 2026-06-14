.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PadSetMainMode, 0x48

glabel PadSetMainMode
    /* E0964 800F0164 1380023C */  lui        $v0, %hi(_padFuncPort2Info)
    /* E0968 800F0168 8C7C428C */  lw         $v0, %lo(_padFuncPort2Info)($v0)
    /* E096C 800F016C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E0970 800F0170 1000B0AF */  sw         $s0, 0x10($sp)
    /* E0974 800F0174 2180A000 */  addu       $s0, $a1, $zero
    /* E0978 800F0178 1400B1AF */  sw         $s1, 0x14($sp)
    /* E097C 800F017C 1800BFAF */  sw         $ra, 0x18($sp)
    /* E0980 800F0180 09F84000 */  jalr       $v0
    /* E0984 800F0184 2188C000 */   addu      $s1, $a2, $zero
    /* E0988 800F0188 21204000 */  addu       $a0, $v0, $zero
    /* E098C 800F018C FF000532 */  andi       $a1, $s0, 0xFF
    /* E0990 800F0190 5017040C */  jal        _padSetMainMode
    /* E0994 800F0194 FF002632 */   andi      $a2, $s1, 0xFF
    /* E0998 800F0198 1800BF8F */  lw         $ra, 0x18($sp)
    /* E099C 800F019C 1400B18F */  lw         $s1, 0x14($sp)
    /* E09A0 800F01A0 1000B08F */  lw         $s0, 0x10($sp)
    /* E09A4 800F01A4 0800E003 */  jr         $ra
    /* E09A8 800F01A8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel PadSetMainMode
