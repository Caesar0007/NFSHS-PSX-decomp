.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___22ObjectFinishedSignAnim, 0x34

glabel ___22ObjectFinishedSignAnim
    /* 974C4 800A6CC4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 974C8 800A6CC8 0580023C */  lui        $v0, %hi(D_800560E8)
    /* 974CC 800A6CCC E8604224 */  addiu      $v0, $v0, %lo(D_800560E8)
    /* 974D0 800A6CD0 0100A530 */  andi       $a1, $a1, 0x1
    /* 974D4 800A6CD4 1000BFAF */  sw         $ra, 0x10($sp)
    /* 974D8 800A6CD8 0300A010 */  beqz       $a1, .L800A6CE8
    /* 974DC 800A6CDC 000082AC */   sw        $v0, 0x0($a0)
    /* 974E0 800A6CE0 6B8F020C */  jal        __builtin_delete
    /* 974E4 800A6CE4 00000000 */   nop
  .L800A6CE8:
    /* 974E8 800A6CE8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 974EC 800A6CEC 00000000 */  nop
    /* 974F0 800A6CF0 0800E003 */  jr         $ra
    /* 974F4 800A6CF4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___22ObjectFinishedSignAnim
