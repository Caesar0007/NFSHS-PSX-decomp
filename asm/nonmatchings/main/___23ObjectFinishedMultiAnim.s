.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___23ObjectFinishedMultiAnim, 0x34

glabel ___23ObjectFinishedMultiAnim
    /* 975AC 800A6DAC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 975B0 800A6DB0 0580023C */  lui        $v0, %hi(D_800560E8)
    /* 975B4 800A6DB4 E8604224 */  addiu      $v0, $v0, %lo(D_800560E8)
    /* 975B8 800A6DB8 0100A530 */  andi       $a1, $a1, 0x1
    /* 975BC 800A6DBC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 975C0 800A6DC0 0300A010 */  beqz       $a1, .L800A6DD0
    /* 975C4 800A6DC4 000082AC */   sw        $v0, 0x0($a0)
    /* 975C8 800A6DC8 6B8F020C */  jal        __builtin_delete
    /* 975CC 800A6DCC 00000000 */   nop
  .L800A6DD0:
    /* 975D0 800A6DD0 1000BF8F */  lw         $ra, 0x10($sp)
    /* 975D4 800A6DD4 00000000 */  nop
    /* 975D8 800A6DD8 0800E003 */  jr         $ra
    /* 975DC 800A6DDC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___23ObjectFinishedMultiAnim
