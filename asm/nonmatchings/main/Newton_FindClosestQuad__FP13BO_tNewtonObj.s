.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Newton_FindClosestQuad__FP13BO_tNewtonObj, 0x2C

glabel Newton_FindClosestQuad__FP13BO_tNewtonObj
    /* 8FF04 8009F704 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8FF08 8009F708 21288000 */  addu       $a1, $a0, $zero
    /* 8FF0C 8009F70C A000A424 */  addiu      $a0, $a1, 0xA0
    /* 8FF10 8009F710 0800A524 */  addiu      $a1, $a1, 0x8
    /* 8FF14 8009F714 1000BFAF */  sw         $ra, 0x10($sp)
    /* 8FF18 8009F718 B1FE010C */  jal        BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
    /* 8FF1C 8009F71C 01000624 */   addiu     $a2, $zero, 0x1
    /* 8FF20 8009F720 1000BF8F */  lw         $ra, 0x10($sp)
    /* 8FF24 8009F724 00000000 */  nop
    /* 8FF28 8009F728 0800E003 */  jr         $ra
    /* 8FF2C 8009F72C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Newton_FindClosestQuad__FP13BO_tNewtonObj
