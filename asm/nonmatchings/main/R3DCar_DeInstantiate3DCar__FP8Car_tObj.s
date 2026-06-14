.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_DeInstantiate3DCar__FP8Car_tObj, 0x3C

glabel R3DCar_DeInstantiate3DCar__FP8Car_tObj
    /* 9F478 800AEC78 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 9F47C 800AEC7C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 9F480 800AEC80 21808000 */  addu       $s0, $a0, $zero
    /* 9F484 800AEC84 1400BFAF */  sw         $ra, 0x14($sp)
    /* 9F488 800AEC88 8408048E */  lw         $a0, 0x884($s0)
    /* 9F48C 800AEC8C 00000000 */  nop
    /* 9F490 800AEC90 03008010 */  beqz       $a0, .L800AECA0
    /* 9F494 800AEC94 00000000 */   nop
    /* 9F498 800AEC98 5095030C */  jal        purgememadr
    /* 9F49C 800AEC9C 00000000 */   nop
  .L800AECA0:
    /* 9F4A0 800AECA0 840800AE */  sw         $zero, 0x884($s0)
    /* 9F4A4 800AECA4 1400BF8F */  lw         $ra, 0x14($sp)
    /* 9F4A8 800AECA8 1000B08F */  lw         $s0, 0x10($sp)
    /* 9F4AC 800AECAC 0800E003 */  jr         $ra
    /* 9F4B0 800AECB0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel R3DCar_DeInstantiate3DCar__FP8Car_tObj
