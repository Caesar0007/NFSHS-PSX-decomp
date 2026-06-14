.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80072758, 0x4C

glabel func_80072758
    /* 62F58 80072758 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 62F5C 8007275C 0580023C */  lui        $v0, %hi(D_800555A0)
    /* 62F60 80072760 A0554224 */  addiu      $v0, $v0, %lo(D_800555A0)
    /* 62F64 80072764 1000BFAF */  sw         $ra, 0x10($sp)
    /* 62F68 80072768 040082AC */  sw         $v0, 0x4($a0)
    /* 62F6C 8007276C 01000224 */  addiu      $v0, $zero, 0x1
    /* 62F70 80072770 0000838C */  lw         $v1, 0x0($a0)
    /* 62F74 80072774 0100A530 */  andi       $a1, $a1, 0x1
    /* 62F78 80072778 910062A0 */  sb         $v0, 0x91($v1)
    /* 62F7C 8007277C 0580023C */  lui        $v0, %hi(D_80055640)
    /* 62F80 80072780 40564224 */  addiu      $v0, $v0, %lo(D_80055640)
    /* 62F84 80072784 0300A010 */  beqz       $a1, .L80072794
    /* 62F88 80072788 040082AC */   sw        $v0, 0x4($a0)
    /* 62F8C 8007278C 6B8F020C */  jal        __builtin_delete
    /* 62F90 80072790 00000000 */   nop
  .L80072794:
    /* 62F94 80072794 1000BF8F */  lw         $ra, 0x10($sp)
    /* 62F98 80072798 00000000 */  nop
    /* 62F9C 8007279C 0800E003 */  jr         $ra
    /* 62FA0 800727A0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_80072758
