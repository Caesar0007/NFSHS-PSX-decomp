.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AILife_SetInitialSlicePositionOrientationEtc__FP8Car_tObj, 0x54

glabel AILife_SetInitialSlicePositionOrientationEtc__FP8Car_tObj
    /* 5848C 80067C8C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 58490 80067C90 2000B0AF */  sw         $s0, 0x20($sp)
    /* 58494 80067C94 21808000 */  addu       $s0, $a0, $zero
    /* 58498 80067C98 1000A427 */  addiu      $a0, $sp, 0x10
    /* 5849C 80067C9C 21280000 */  addu       $a1, $zero, $zero
    /* 584A0 80067CA0 2400BFAF */  sw         $ra, 0x24($sp)
    /* 584A4 80067CA4 C690030C */  jal        memset
    /* 584A8 80067CA8 0C000624 */   addiu     $a2, $zero, 0xC
    /* 584AC 80067CAC 21200002 */  addu       $a0, $s0, $zero
    /* 584B0 80067CB0 5805838C */  lw         $v1, 0x558($a0)
    /* 584B4 80067CB4 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 584B8 80067CB8 1400A2AF */  sw         $v0, 0x14($sp)
    /* 584BC 80067CBC 1000A3AF */  sw         $v1, 0x10($sp)
    /* 584C0 80067CC0 08008584 */  lh         $a1, 0x8($a0)
    /* 584C4 80067CC4 5405878C */  lw         $a3, 0x554($a0)
    /* 584C8 80067CC8 E785020C */  jal        Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi
    /* 584CC 80067CCC 1000A627 */   addiu     $a2, $sp, 0x10
    /* 584D0 80067CD0 2400BF8F */  lw         $ra, 0x24($sp)
    /* 584D4 80067CD4 2000B08F */  lw         $s0, 0x20($sp)
    /* 584D8 80067CD8 0800E003 */  jr         $ra
    /* 584DC 80067CDC 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel AILife_SetInitialSlicePositionOrientationEtc__FP8Car_tObj
