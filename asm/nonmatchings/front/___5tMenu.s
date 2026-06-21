.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___5tMenu, 0x34

glabel ___5tMenu
    /* 15CB0 800254B0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 15CB4 800254B4 0180023C */  lui        $v0, %hi(_vt_5tMenu)
    /* 15CB8 800254B8 C8104224 */  addiu      $v0, $v0, %lo(_vt_5tMenu)
    /* 15CBC 800254BC 0100A530 */  andi       $a1, $a1, 0x1
    /* 15CC0 800254C0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 15CC4 800254C4 0300A010 */  beqz       $a1, .L800254D4
    /* 15CC8 800254C8 680082AC */   sw        $v0, 0x68($a0)
    /* 15CCC 800254CC 6B8F020C */  jal        __builtin_delete
    /* 15CD0 800254D0 00000000 */   nop
  .L800254D4:
    /* 15CD4 800254D4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 15CD8 800254D8 00000000 */  nop
    /* 15CDC 800254DC 0800E003 */  jr         $ra
    /* 15CE0 800254E0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___5tMenu
