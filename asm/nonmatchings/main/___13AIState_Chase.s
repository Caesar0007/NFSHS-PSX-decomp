.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___13AIState_Chase, 0x88

glabel ___13AIState_Chase
    /* 60504 8006FD04 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 60508 8006FD08 0580023C */  lui        $v0, %hi(_vt_13AIState_Chase)
    /* 6050C 8006FD0C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 60510 8006FD10 0000838C */  lw         $v1, 0x0($a0)
    /* 60514 8006FD14 E0554224 */  addiu      $v0, $v0, %lo(_vt_13AIState_Chase)
    /* 60518 8006FD18 040082AC */  sw         $v0, 0x4($a0)
    /* 6051C 8006FD1C 100760AC */  sw         $zero, 0x710($v1)
    /* 60520 8006FD20 0C0760AC */  sw         $zero, 0x70C($v1)
    /* 60524 8006FD24 080760AC */  sw         $zero, 0x708($v1)
    /* 60528 8006FD28 0000828C */  lw         $v0, 0x0($a0)
    /* 6052C 8006FD2C 00000000 */  nop
    /* 60530 8006FD30 140740AC */  sw         $zero, 0x714($v0)
    /* 60534 8006FD34 0000828C */  lw         $v0, 0x0($a0)
    /* 60538 8006FD38 00000000 */  nop
    /* 6053C 8006FD3C 1C0740AC */  sw         $zero, 0x71C($v0)
    /* 60540 8006FD40 0000828C */  lw         $v0, 0x0($a0)
    /* 60544 8006FD44 00000000 */  nop
    /* 60548 8006FD48 200740AC */  sw         $zero, 0x720($v0)
    /* 6054C 8006FD4C 0000828C */  lw         $v0, 0x0($a0)
    /* 60550 8006FD50 0100033C */  lui        $v1, (0x10000 >> 16)
    /* 60554 8006FD54 3C0743AC */  sw         $v1, 0x73C($v0)
    /* 60558 8006FD58 0000828C */  lw         $v0, 0x0($a0)
    /* 6055C 8006FD5C 0100A530 */  andi       $a1, $a1, 0x1
    /* 60560 8006FD60 400743AC */  sw         $v1, 0x740($v0)
    /* 60564 8006FD64 0580023C */  lui        $v0, %hi(D_80055640)
    /* 60568 8006FD68 40564224 */  addiu      $v0, $v0, %lo(D_80055640)
    /* 6056C 8006FD6C 0300A010 */  beqz       $a1, .L8006FD7C
    /* 60570 8006FD70 040082AC */   sw        $v0, 0x4($a0)
    /* 60574 8006FD74 6B8F020C */  jal        __builtin_delete
    /* 60578 8006FD78 00000000 */   nop
  .L8006FD7C:
    /* 6057C 8006FD7C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 60580 8006FD80 00000000 */  nop
    /* 60584 8006FD84 0800E003 */  jr         $ra
    /* 60588 8006FD88 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___13AIState_Chase
