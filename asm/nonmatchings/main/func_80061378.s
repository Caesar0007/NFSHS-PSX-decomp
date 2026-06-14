.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80061378, 0x4C

glabel func_80061378
    /* 51B78 80061378 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 51B7C 8006137C 0580023C */  lui        $v0, %hi(D_80055000)
    /* 51B80 80061380 00504224 */  addiu      $v0, $v0, %lo(D_80055000)
    /* 51B84 80061384 1000BFAF */  sw         $ra, 0x10($sp)
    /* 51B88 80061388 040082AC */  sw         $v0, 0x4($a0)
    /* 51B8C 8006138C 01000224 */  addiu      $v0, $zero, 0x1
    /* 51B90 80061390 0000838C */  lw         $v1, 0x0($a0)
    /* 51B94 80061394 0100A530 */  andi       $a1, $a1, 0x1
    /* 51B98 80061398 910062A0 */  sb         $v0, 0x91($v1)
    /* 51B9C 8006139C 0580023C */  lui        $v0, %hi(D_80055020)
    /* 51BA0 800613A0 20504224 */  addiu      $v0, $v0, %lo(D_80055020)
    /* 51BA4 800613A4 0300A010 */  beqz       $a1, .L800613B4
    /* 51BA8 800613A8 040082AC */   sw        $v0, 0x4($a0)
    /* 51BAC 800613AC 6B8F020C */  jal        __builtin_delete
    /* 51BB0 800613B0 00000000 */   nop
  .L800613B4:
    /* 51BB4 800613B4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 51BB8 800613B8 00000000 */  nop
    /* 51BBC 800613BC 0800E003 */  jr         $ra
    /* 51BC0 800613C0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_80061378
