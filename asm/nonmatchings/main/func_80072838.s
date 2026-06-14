.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80072838, 0x34

glabel func_80072838
    /* 63038 80072838 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 6303C 8007283C 0580023C */  lui        $v0, %hi(D_80055640)
    /* 63040 80072840 40564224 */  addiu      $v0, $v0, %lo(D_80055640)
    /* 63044 80072844 0100A530 */  andi       $a1, $a1, 0x1
    /* 63048 80072848 1000BFAF */  sw         $ra, 0x10($sp)
    /* 6304C 8007284C 0300A010 */  beqz       $a1, .L8007285C
    /* 63050 80072850 040082AC */   sw        $v0, 0x4($a0)
    /* 63054 80072854 6B8F020C */  jal        __builtin_delete
    /* 63058 80072858 00000000 */   nop
  .L8007285C:
    /* 6305C 8007285C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 63060 80072860 00000000 */  nop
    /* 63064 80072864 0800E003 */  jr         $ra
    /* 63068 80072868 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_80072838
