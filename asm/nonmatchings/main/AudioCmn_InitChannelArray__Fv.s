.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_InitChannelArray__Fv, 0x38

glabel AudioCmn_InitChannelArray__Fv
    /* 680B0 800778B0 21200000 */  addu       $a0, $zero, $zero
    /* 680B4 800778B4 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 680B8 800778B8 1180023C */  lui        $v0, %hi(gaChannel)
    /* 680BC 800778BC FCE84324 */  addiu      $v1, $v0, %lo(gaChannel)
  .L800778C0:
    /* 680C0 800778C0 000065AC */  sw         $a1, 0x0($v1)
    /* 680C4 800778C4 040065AC */  sw         $a1, 0x4($v1)
    /* 680C8 800778C8 01008424 */  addiu      $a0, $a0, 0x1
    /* 680CC 800778CC 47008228 */  slti       $v0, $a0, 0x47
    /* 680D0 800778D0 FBFF4014 */  bnez       $v0, .L800778C0
    /* 680D4 800778D4 08006324 */   addiu     $v1, $v1, 0x8
    /* 680D8 800778D8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 680DC 800778DC 8C0182AF */  sw         $v0, %gp_rel(AudioCmn_gCursorSndHandle)($gp)
    /* 680E0 800778E0 0800E003 */  jr         $ra
    /* 680E4 800778E4 00000000 */   nop
endlabel AudioCmn_InitChannelArray__Fv
