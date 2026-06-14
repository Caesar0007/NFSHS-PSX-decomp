.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AISpeeds_GetScriptFactor__FP8Car_tObj, 0x68

glabel AISpeeds_GetScriptFactor__FP8Car_tObj
    /* 5F8A4 8006F0A4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 5F8A8 8006F0A8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5F8AC 8006F0AC F4049024 */  addiu      $s0, $a0, 0x4F4
    /* 5F8B0 8006F0B0 21200002 */  addu       $a0, $s0, $zero
    /* 5F8B4 8006F0B4 04000524 */  addiu      $a1, $zero, 0x4
    /* 5F8B8 8006F0B8 1800BFAF */  sw         $ra, 0x18($sp)
    /* 5F8BC 8006F0BC 56BE010C */  jal        AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
    /* 5F8C0 8006F0C0 1400B1AF */   sw        $s1, 0x14($sp)
    /* 5F8C4 8006F0C4 21884000 */  addu       $s1, $v0, $zero
    /* 5F8C8 8006F0C8 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 5F8CC 8006F0CC 08002216 */  bne        $s1, $v0, .L8006F0F0
    /* 5F8D0 8006F0D0 21200002 */   addu      $a0, $s0, $zero
    /* 5F8D4 8006F0D4 56BE010C */  jal        AIScript_DoReAction__FP10AIScript_t20AIScript_tAIReaction
    /* 5F8D8 8006F0D8 10000524 */   addiu     $a1, $zero, 0x10
    /* 5F8DC 8006F0DC 21184000 */  addu       $v1, $v0, $zero
    /* 5F8E0 8006F0E0 05007114 */  bne        $v1, $s1, .L8006F0F8
    /* 5F8E4 8006F0E4 00800234 */   ori       $v0, $zero, 0x8000
    /* 5F8E8 8006F0E8 3EBC0108 */  j          .L8006F0F8
    /* 5F8EC 8006F0EC 0100023C */   lui       $v0, (0x10000 >> 16)
  .L8006F0F0:
    /* 5F8F0 8006F0F0 0100023C */  lui        $v0, (0x18000 >> 16)
    /* 5F8F4 8006F0F4 00804234 */  ori        $v0, $v0, (0x18000 & 0xFFFF)
  .L8006F0F8:
    /* 5F8F8 8006F0F8 1800BF8F */  lw         $ra, 0x18($sp)
    /* 5F8FC 8006F0FC 1400B18F */  lw         $s1, 0x14($sp)
    /* 5F900 8006F100 1000B08F */  lw         $s0, 0x10($sp)
    /* 5F904 8006F104 0800E003 */  jr         $ra
    /* 5F908 8006F108 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AISpeeds_GetScriptFactor__FP8Car_tObj
