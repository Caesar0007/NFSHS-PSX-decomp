.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___17AIState_NonActive, 0x4C

glabel ___17AIState_NonActive
    /* 4FE2C 8005F62C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4FE30 8005F630 0580023C */  lui        $v0, %hi(D_80054F24)
    /* 4FE34 8005F634 244F4224 */  addiu      $v0, $v0, %lo(D_80054F24)
    /* 4FE38 8005F638 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4FE3C 8005F63C 040082AC */  sw         $v0, 0x4($a0)
    /* 4FE40 8005F640 01000224 */  addiu      $v0, $zero, 0x1
    /* 4FE44 8005F644 0000838C */  lw         $v1, 0x0($a0)
    /* 4FE48 8005F648 0100A530 */  andi       $a1, $a1, 0x1
    /* 4FE4C 8005F64C 910062A0 */  sb         $v0, 0x91($v1)
    /* 4FE50 8005F650 0580023C */  lui        $v0, %hi(D_80054F44)
    /* 4FE54 8005F654 444F4224 */  addiu      $v0, $v0, %lo(D_80054F44)
    /* 4FE58 8005F658 0300A010 */  beqz       $a1, .L8005F668
    /* 4FE5C 8005F65C 040082AC */   sw        $v0, 0x4($a0)
    /* 4FE60 8005F660 6B8F020C */  jal        __builtin_delete
    /* 4FE64 8005F664 00000000 */   nop
  .L8005F668:
    /* 4FE68 8005F668 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4FE6C 8005F66C 00000000 */  nop
    /* 4FE70 8005F670 0800E003 */  jr         $ra
    /* 4FE74 8005F674 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___17AIState_NonActive
