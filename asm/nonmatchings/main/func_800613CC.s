.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800613CC, 0x34

glabel func_800613CC
    /* 51BCC 800613CC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 51BD0 800613D0 0580023C */  lui        $v0, %hi(D_80055020)
    /* 51BD4 800613D4 20504224 */  addiu      $v0, $v0, %lo(D_80055020)
    /* 51BD8 800613D8 0100A530 */  andi       $a1, $a1, 0x1
    /* 51BDC 800613DC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 51BE0 800613E0 0300A010 */  beqz       $a1, .L800613F0
    /* 51BE4 800613E4 040082AC */   sw        $v0, 0x4($a0)
    /* 51BE8 800613E8 6B8F020C */  jal        __builtin_delete
    /* 51BEC 800613EC 00000000 */   nop
  .L800613F0:
    /* 51BF0 800613F0 1000BF8F */  lw         $ra, 0x10($sp)
    /* 51BF4 800613F4 00000000 */  nop
    /* 51BF8 800613F8 0800E003 */  jr         $ra
    /* 51BFC 800613FC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_800613CC
