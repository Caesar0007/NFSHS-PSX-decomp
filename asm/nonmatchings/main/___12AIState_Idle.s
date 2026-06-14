.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___12AIState_Idle, 0x58

glabel ___12AIState_Idle
    /* 62FA4 800727A4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 62FA8 800727A8 21308000 */  addu       $a2, $a0, $zero
    /* 62FAC 800727AC 0580023C */  lui        $v0, %hi(_vt_12AIState_Idle)
    /* 62FB0 800727B0 00564224 */  addiu      $v0, $v0, %lo(_vt_12AIState_Idle)
    /* 62FB4 800727B4 1000BFAF */  sw         $ra, 0x10($sp)
    /* 62FB8 800727B8 0000C48C */  lw         $a0, 0x0($a2)
    /* 62FBC 800727BC FFFB0324 */  addiu      $v1, $zero, -0x401
    /* 62FC0 800727C0 0400C2AC */  sw         $v0, 0x4($a2)
    /* 62FC4 800727C4 6002828C */  lw         $v0, 0x260($a0)
    /* 62FC8 800727C8 0100A530 */  andi       $a1, $a1, 0x1
    /* 62FCC 800727CC 24104300 */  and        $v0, $v0, $v1
    /* 62FD0 800727D0 600282AC */  sw         $v0, 0x260($a0)
    /* 62FD4 800727D4 0580023C */  lui        $v0, %hi(D_80055640)
    /* 62FD8 800727D8 40564224 */  addiu      $v0, $v0, %lo(D_80055640)
    /* 62FDC 800727DC 0300A010 */  beqz       $a1, .L800727EC
    /* 62FE0 800727E0 0400C2AC */   sw        $v0, 0x4($a2)
    /* 62FE4 800727E4 6B8F020C */  jal        __builtin_delete
    /* 62FE8 800727E8 2120C000 */   addu      $a0, $a2, $zero
  .L800727EC:
    /* 62FEC 800727EC 1000BF8F */  lw         $ra, 0x10($sp)
    /* 62FF0 800727F0 00000000 */  nop
    /* 62FF4 800727F4 0800E003 */  jr         $ra
    /* 62FF8 800727F8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___12AIState_Idle
