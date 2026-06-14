.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_PlayWrongWaySFX__Fv, 0x38

glabel AudioCmn_PlayWrongWaySFX__Fv
    /* 69EAC 800796AC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 69EB0 800796B0 40000224 */  addiu      $v0, $zero, 0x40
    /* 69EB4 800796B4 1000A2AF */  sw         $v0, 0x10($sp)
    /* 69EB8 800796B8 1180023C */  lui        $v0, %hi(D_8010E8CC)
    /* 69EBC 800796BC 10000524 */  addiu      $a1, $zero, 0x10
    /* 69EC0 800796C0 21300000 */  addu       $a2, $zero, $zero
    /* 69EC4 800796C4 CCE8448C */  lw         $a0, %lo(D_8010E8CC)($v0)
    /* 69EC8 800796C8 1800BFAF */  sw         $ra, 0x18($sp)
    /* 69ECC 800796CC E8E0010C */  jal        AudioCmn_PlaySound__Fiiiii
    /* 69ED0 800796D0 7F000724 */   addiu     $a3, $zero, 0x7F
    /* 69ED4 800796D4 1800BF8F */  lw         $ra, 0x18($sp)
    /* 69ED8 800796D8 00000000 */  nop
    /* 69EDC 800796DC 0800E003 */  jr         $ra
    /* 69EE0 800796E0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AudioCmn_PlayWrongWaySFX__Fv
