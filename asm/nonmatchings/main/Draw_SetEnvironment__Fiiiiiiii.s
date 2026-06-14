.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_SetEnvironment__Fiiiiiiii, 0x5C

glabel Draw_SetEnvironment__Fiiiiiiii
    /* AED7C 800BE57C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* AED80 800BE580 21408000 */  addu       $t0, $a0, $zero
    /* AED84 800BE584 2148A000 */  addu       $t1, $a1, $zero
    /* AED88 800BE588 4000A28F */  lw         $v0, 0x40($sp)
    /* AED8C 800BE58C 4400A38F */  lw         $v1, 0x44($sp)
    /* AED90 800BE590 4800A48F */  lw         $a0, 0x48($sp)
    /* AED94 800BE594 4C00A58F */  lw         $a1, 0x4C($sp)
    /* AED98 800BE598 1000A6AF */  sw         $a2, 0x10($sp)
    /* AED9C 800BE59C 21300001 */  addu       $a2, $t0, $zero
    /* AEDA0 800BE5A0 1400A7AF */  sw         $a3, 0x14($sp)
    /* AEDA4 800BE5A4 21382001 */  addu       $a3, $t1, $zero
    /* AEDA8 800BE5A8 2800BFAF */  sw         $ra, 0x28($sp)
    /* AEDAC 800BE5AC 2000A4AF */  sw         $a0, 0x20($sp)
    /* AEDB0 800BE5B0 21200000 */  addu       $a0, $zero, $zero
    /* AEDB4 800BE5B4 2400A5AF */  sw         $a1, 0x24($sp)
    /* AEDB8 800BE5B8 00010524 */  addiu      $a1, $zero, 0x100
    /* AEDBC 800BE5BC 1800A2AF */  sw         $v0, 0x18($sp)
    /* AEDC0 800BE5C0 1EF9020C */  jal        Draw_DirectSetEnvironment__Fiiiiiiiiii
    /* AEDC4 800BE5C4 1C00A3AF */   sw        $v1, 0x1C($sp)
    /* AEDC8 800BE5C8 2800BF8F */  lw         $ra, 0x28($sp)
    /* AEDCC 800BE5CC 00000000 */  nop
    /* AEDD0 800BE5D0 0800E003 */  jr         $ra
    /* AEDD4 800BE5D4 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Draw_SetEnvironment__Fiiiiiiii
