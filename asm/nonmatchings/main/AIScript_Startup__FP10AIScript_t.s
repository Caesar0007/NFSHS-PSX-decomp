.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIScript_Startup__FP10AIScript_t, 0x3C

glabel AIScript_Startup__FP10AIScript_t
    /* 5FF24 8006F724 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5FF28 8006F728 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5FF2C 8006F72C 21808000 */  addu       $s0, $a0, $zero
    /* 5FF30 8006F730 07000224 */  addiu      $v0, $zero, 0x7
    /* 5FF34 8006F734 1400BFAF */  sw         $ra, 0x14($sp)
    /* 5FF38 8006F738 080002AE */  sw         $v0, 0x8($s0)
    /* 5FF3C 8006F73C 000002AE */  sw         $v0, 0x0($s0)
    /* 5FF40 8006F740 01000224 */  addiu      $v0, $zero, 0x1
    /* 5FF44 8006F744 C0BD010C */  jal        AIScript_ClearLastReactionIndex__FP10AIScript_t
    /* 5FF48 8006F748 140002AE */   sw        $v0, 0x14($s0)
    /* 5FF4C 8006F74C 3C0000AE */  sw         $zero, 0x3C($s0)
    /* 5FF50 8006F750 1400BF8F */  lw         $ra, 0x14($sp)
    /* 5FF54 8006F754 1000B08F */  lw         $s0, 0x10($sp)
    /* 5FF58 8006F758 0800E003 */  jr         $ra
    /* 5FF5C 8006F75C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIScript_Startup__FP10AIScript_t
