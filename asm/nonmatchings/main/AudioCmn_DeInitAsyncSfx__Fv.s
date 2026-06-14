.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_DeInitAsyncSfx__Fv, 0x38

glabel AudioCmn_DeInitAsyncSfx__Fv
    /* 66E3C 8007663C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 66E40 80076640 1000B0AF */  sw         $s0, 0x10($sp)
    /* 66E44 80076644 21800000 */  addu       $s0, $zero, $zero
    /* 66E48 80076648 1400BFAF */  sw         $ra, 0x14($sp)
  .L8007664C:
    /* 66E4C 8007664C 6DD9010C */  jal        AudioCmn_RemoveAsyncSfx__Fi
    /* 66E50 80076650 21200002 */   addu      $a0, $s0, $zero
    /* 66E54 80076654 01001026 */  addiu      $s0, $s0, 0x1
    /* 66E58 80076658 2000022A */  slti       $v0, $s0, 0x20
    /* 66E5C 8007665C FBFF4014 */  bnez       $v0, .L8007664C
    /* 66E60 80076660 00000000 */   nop
    /* 66E64 80076664 1400BF8F */  lw         $ra, 0x14($sp)
    /* 66E68 80076668 1000B08F */  lw         $s0, 0x10($sp)
    /* 66E6C 8007666C 0800E003 */  jr         $ra
    /* 66E70 80076670 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioCmn_DeInitAsyncSfx__Fv
