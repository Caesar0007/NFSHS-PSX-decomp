.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Quick_DD__Fiii, 0x44

glabel Quick_DD__Fiii
    /* 3DF78 8004D778 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 3DF7C 8004D77C 1000A4AF */  sw         $a0, 0x10($sp)
    /* 3DF80 8004D780 21200000 */  addu       $a0, $zero, $zero
    /* 3DF84 8004D784 1400A5AF */  sw         $a1, 0x14($sp)
    /* 3DF88 8004D788 21288000 */  addu       $a1, $a0, $zero
    /* 3DF8C 8004D78C 1800A6AF */  sw         $a2, 0x18($sp)
    /* 3DF90 8004D790 00020624 */  addiu      $a2, $zero, 0x200
    /* 3DF94 8004D794 F0000724 */  addiu      $a3, $zero, 0xF0
    /* 3DF98 8004D798 2800BFAF */  sw         $ra, 0x28($sp)
    /* 3DF9C 8004D79C 1C00A0AF */  sw         $zero, 0x1C($sp)
    /* 3DFA0 8004D7A0 2000A0AF */  sw         $zero, 0x20($sp)
    /* 3DFA4 8004D7A4 1EF9020C */  jal        Draw_DirectSetEnvironment__Fiiiiiiiiii
    /* 3DFA8 8004D7A8 2400A0AF */   sw        $zero, 0x24($sp)
    /* 3DFAC 8004D7AC 2800BF8F */  lw         $ra, 0x28($sp)
    /* 3DFB0 8004D7B0 00000000 */  nop
    /* 3DFB4 8004D7B4 0800E003 */  jr         $ra
    /* 3DFB8 8004D7B8 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Quick_DD__Fiii
