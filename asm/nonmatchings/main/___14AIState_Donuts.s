.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___14AIState_Donuts, 0x64

glabel ___14AIState_Donuts
    /* 6260C 80071E0C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 62610 80071E10 0580023C */  lui        $v0, %hi(_vt_14AIState_Donuts)
    /* 62614 80071E14 1000BFAF */  sw         $ra, 0x10($sp)
    /* 62618 80071E18 0000838C */  lw         $v1, 0x0($a0)
    /* 6261C 80071E1C 40554224 */  addiu      $v0, $v0, %lo(_vt_14AIState_Donuts)
    /* 62620 80071E20 040082AC */  sw         $v0, 0x4($a0)
    /* 62624 80071E24 100760AC */  sw         $zero, 0x710($v1)
    /* 62628 80071E28 0C0760AC */  sw         $zero, 0x70C($v1)
    /* 6262C 80071E2C 080760AC */  sw         $zero, 0x708($v1)
    /* 62630 80071E30 0000828C */  lw         $v0, 0x0($a0)
    /* 62634 80071E34 00000000 */  nop
    /* 62638 80071E38 140740AC */  sw         $zero, 0x714($v0)
    /* 6263C 80071E3C 0000828C */  lw         $v0, 0x0($a0)
    /* 62640 80071E40 0100A530 */  andi       $a1, $a1, 0x1
    /* 62644 80071E44 500740AC */  sw         $zero, 0x750($v0)
    /* 62648 80071E48 0580023C */  lui        $v0, %hi(D_80055640)
    /* 6264C 80071E4C 40564224 */  addiu      $v0, $v0, %lo(D_80055640)
    /* 62650 80071E50 0300A010 */  beqz       $a1, .L80071E60
    /* 62654 80071E54 040082AC */   sw        $v0, 0x4($a0)
    /* 62658 80071E58 6B8F020C */  jal        __builtin_delete
    /* 6265C 80071E5C 00000000 */   nop
  .L80071E60:
    /* 62660 80071E60 1000BF8F */  lw         $ra, 0x10($sp)
    /* 62664 80071E64 00000000 */  nop
    /* 62668 80071E68 0800E003 */  jr         $ra
    /* 6266C 80071E6C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___14AIState_Donuts
