.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PadSetAct, 0x48

glabel PadSetAct
    /* E09AC 800F01AC 1380023C */  lui        $v0, %hi(_padFuncPort2Info)
    /* E09B0 800F01B0 8C7C428C */  lw         $v0, %lo(_padFuncPort2Info)($v0)
    /* E09B4 800F01B4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E09B8 800F01B8 1000B0AF */  sw         $s0, 0x10($sp)
    /* E09BC 800F01BC 2180A000 */  addu       $s0, $a1, $zero
    /* E09C0 800F01C0 1400B1AF */  sw         $s1, 0x14($sp)
    /* E09C4 800F01C4 1800BFAF */  sw         $ra, 0x18($sp)
    /* E09C8 800F01C8 09F84000 */  jalr       $v0
    /* E09CC 800F01CC 2188C000 */   addu      $s1, $a2, $zero
    /* E09D0 800F01D0 21204000 */  addu       $a0, $v0, $zero
    /* E09D4 800F01D4 21280002 */  addu       $a1, $s0, $zero
    /* E09D8 800F01D8 7C15040C */  jal        _padSetAct
    /* E09DC 800F01DC 21302002 */   addu      $a2, $s1, $zero
    /* E09E0 800F01E0 1800BF8F */  lw         $ra, 0x18($sp)
    /* E09E4 800F01E4 1400B18F */  lw         $s1, 0x14($sp)
    /* E09E8 800F01E8 1000B08F */  lw         $s0, 0x10($sp)
    /* E09EC 800F01EC 0800E003 */  jr         $ra
    /* E09F0 800F01F0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel PadSetAct
    /* E09F4 800F01F4 00000000 */  nop
    /* E09F8 800F01F8 00000000 */  nop
