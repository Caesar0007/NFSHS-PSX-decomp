.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorld_InitContexts__Fv, 0x38

glabel BWorld_InitContexts__Fv
    /* 6EC28 8007E428 FFFF0724 */  addiu      $a3, $zero, -0x1
    /* 6EC2C 8007E42C 01000624 */  addiu      $a2, $zero, 0x1
    /* 6EC30 8007E430 1180023C */  lui        $v0, %hi(gContextMan)
    /* 6EC34 8007E434 ACEE4424 */  addiu      $a0, $v0, %lo(gContextMan)
    /* 6EC38 8007E438 9C008524 */  addiu      $a1, $a0, 0x9C
    /* 6EC3C 8007E43C 2118C000 */  addu       $v1, $a2, $zero
    /* 6EC40 8007E440 ACEE43AC */  sw         $v1, %lo(gContextMan)($v0)
    /* 6EC44 8007E444 040080AC */  sw         $zero, 0x4($a0)
  .L8007E448:
    /* 6EC48 8007E448 0800A7AC */  sw         $a3, 0x8($a1)
    /* 6EC4C 8007E44C FFFFC624 */  addiu      $a2, $a2, -0x1
    /* 6EC50 8007E450 FDFFC104 */  bgez       $a2, .L8007E448
    /* 6EC54 8007E454 64FFA524 */   addiu     $a1, $a1, -0x9C
    /* 6EC58 8007E458 0800E003 */  jr         $ra
    /* 6EC5C 8007E45C 00000000 */   nop
endlabel BWorld_InitContexts__Fv
