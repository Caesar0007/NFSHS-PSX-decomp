.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching InTargetSliceRange__17AIState_GotoSlicei, 0x44

glabel InTargetSliceRange__17AIState_GotoSlicei
    /* 62CD8 800724D8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 62CDC 800724DC 21108000 */  addu       $v0, $a0, $zero
    /* 62CE0 800724E0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 62CE4 800724E4 2180A000 */  addu       $s0, $a1, $zero
    /* 62CE8 800724E8 1400BFAF */  sw         $ra, 0x14($sp)
    /* 62CEC 800724EC 0000448C */  lw         $a0, 0x0($v0)
    /* 62CF0 800724F0 0800458C */  lw         $a1, 0x8($v0)
    /* 62CF4 800724F4 4ACC010C */  jal        AIWorld_ApxSplineDistance__FP8Car_tObji
    /* 62CF8 800724F8 00000000 */   nop
    /* 62CFC 800724FC 02004104 */  bgez       $v0, .L80072508
    /* 62D00 80072500 00000000 */   nop
    /* 62D04 80072504 23100200 */  negu       $v0, $v0
  .L80072508:
    /* 62D08 80072508 2A105000 */  slt        $v0, $v0, $s0
    /* 62D0C 8007250C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 62D10 80072510 1000B08F */  lw         $s0, 0x10($sp)
    /* 62D14 80072514 0800E003 */  jr         $ra
    /* 62D18 80072518 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel InTargetSliceRange__17AIState_GotoSlicei
