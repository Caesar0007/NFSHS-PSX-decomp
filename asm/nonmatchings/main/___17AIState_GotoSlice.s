.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___17AIState_GotoSlice, 0x34

glabel ___17AIState_GotoSlice
    /* 62E90 80072690 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 62E94 80072694 0580023C */  lui        $v0, %hi(D_80055640)
    /* 62E98 80072698 40564224 */  addiu      $v0, $v0, %lo(D_80055640)
    /* 62E9C 8007269C 0100A530 */  andi       $a1, $a1, 0x1
    /* 62EA0 800726A0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 62EA4 800726A4 0300A010 */  beqz       $a1, .L800726B4
    /* 62EA8 800726A8 040082AC */   sw        $v0, 0x4($a0)
    /* 62EAC 800726AC 6B8F020C */  jal        __builtin_delete
    /* 62EB0 800726B0 00000000 */   nop
  .L800726B4:
    /* 62EB4 800726B4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 62EB8 800726B8 00000000 */  nop
    /* 62EBC 800726BC 0800E003 */  jr         $ra
    /* 62EC0 800726C0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___17AIState_GotoSlice
