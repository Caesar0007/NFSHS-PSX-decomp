.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching loadbigfileheader, 0x48

glabel loadbigfileheader
    /* D627C 800E5A7C 1480023C */  lui        $v0, %hi(abortflag)
    /* D6280 800E5A80 D4DC428C */  lw         $v0, %lo(abortflag)($v0)
    /* D6284 800E5A84 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D6288 800E5A88 2000BFAF */  sw         $ra, 0x20($sp)
    /* D628C 800E5A8C 1000A4AF */  sw         $a0, 0x10($sp)
    /* D6290 800E5A90 1800A5AF */  sw         $a1, 0x18($sp)
    /* D6294 800E5A94 45D8030C */  jal        setclipwindow
    /* D6298 800E5A98 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* D629C 800E5A9C 0E80043C */  lui        $a0, %hi(func_800E5938)
    /* D62A0 800E5AA0 38598424 */  addiu      $a0, $a0, %lo(func_800E5938)
    /* D62A4 800E5AA4 21284000 */  addu       $a1, $v0, $zero
    /* D62A8 800E5AA8 64000624 */  addiu      $a2, $zero, 0x64
    /* D62AC 800E5AAC D0B2030C */  jal        FILE_atomic
    /* D62B0 800E5AB0 1000A727 */   addiu     $a3, $sp, 0x10
    /* D62B4 800E5AB4 2000BF8F */  lw         $ra, 0x20($sp)
    /* D62B8 800E5AB8 00000000 */  nop
    /* D62BC 800E5ABC 0800E003 */  jr         $ra
    /* D62C0 800E5AC0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel loadbigfileheader
