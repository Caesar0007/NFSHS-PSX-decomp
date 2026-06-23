.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iMCRD_timersub, 0x30

glabel iMCRD_timersub
    /* 40A8C 8005028C 21200000 */  addu       $a0, $zero, $zero
    /* 40A90 80050290 0580023C */  lui        $v0, %hi(gMemCardInfo)
    /* 40A94 80050294 682D4324 */  addiu      $v1, $v0, %lo(gMemCardInfo)
  .L80050298:
    /* 40A98 80050298 4000628C */  lw         $v0, 0x40($v1)
    /* 40A9C 8005029C 01008424 */  addiu      $a0, $a0, 0x1
    /* 40AA0 800502A0 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 40AA4 800502A4 400062AC */  sw         $v0, 0x40($v1)
    /* 40AA8 800502A8 08008228 */  slti       $v0, $a0, 0x8
    /* 40AAC 800502AC FAFF4014 */  bnez       $v0, .L80050298
    /* 40AB0 800502B0 04006324 */   addiu     $v1, $v1, 0x4
    /* 40AB4 800502B4 0800E003 */  jr         $ra
    /* 40AB8 800502B8 00000000 */   nop
endlabel iMCRD_timersub
