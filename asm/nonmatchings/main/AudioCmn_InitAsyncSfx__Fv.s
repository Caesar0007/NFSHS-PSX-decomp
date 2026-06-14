.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_InitAsyncSfx__Fv, 0x38

glabel AudioCmn_InitAsyncSfx__Fv
    /* 66D7C 8007657C 21200000 */  addu       $a0, $zero, $zero
    /* 66D80 80076580 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 66D84 80076584 1180023C */  lui        $v0, %hi(AudioCmn_gSfxSlot)
    /* 66D88 80076588 34EB4324 */  addiu      $v1, $v0, %lo(AudioCmn_gSfxSlot)
  .L8007658C:
    /* 66D8C 8007658C 20008228 */  slti       $v0, $a0, 0x20
    /* 66D90 80076590 06004010 */  beqz       $v0, .L800765AC
    /* 66D94 80076594 01008424 */   addiu     $a0, $a0, 0x1
    /* 66D98 80076598 040065AC */  sw         $a1, 0x4($v1)
    /* 66D9C 8007659C 080065AC */  sw         $a1, 0x8($v1)
    /* 66DA0 800765A0 140060AC */  sw         $zero, 0x14($v1)
    /* 66DA4 800765A4 63D90108 */  j          .L8007658C
    /* 66DA8 800765A8 18006324 */   addiu     $v1, $v1, 0x18
  .L800765AC:
    /* 66DAC 800765AC 0800E003 */  jr         $ra
    /* 66DB0 800765B0 00000000 */   nop
endlabel AudioCmn_InitAsyncSfx__Fv
