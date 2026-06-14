.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni, 0x88

glabel AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni
    /* 5FF68 8006F768 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 5FF6C 8006F76C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5FF70 8006F770 21808000 */  addu       $s0, $a0, $zero
    /* 5FF74 8006F774 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 5FF78 8006F778 2198A000 */  addu       $s3, $a1, $zero
    /* 5FF7C 8006F77C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 5FF80 8006F780 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5FF84 8006F784 2188E000 */  addu       $s1, $a3, $zero
    /* 5FF88 8006F788 2000BFAF */  sw         $ra, 0x20($sp)
    /* 5FF8C 8006F78C 3C00028E */  lw         $v0, 0x3C($s0)
    /* 5FF90 8006F790 00FB2326 */  addiu      $v1, $s1, -0x500
    /* 5FF94 8006F794 2A104300 */  slt        $v0, $v0, $v1
    /* 5FF98 8006F798 03004010 */  beqz       $v0, .L8006F7A8
    /* 5FF9C 8006F79C 2190C000 */   addu      $s2, $a2, $zero
    /* 5FFA0 8006F7A0 C0BD010C */  jal        AIScript_ClearLastReactionIndex__FP10AIScript_t
    /* 5FFA4 8006F7A4 00000000 */   nop
  .L8006F7A8:
    /* 5FFA8 8006F7A8 0800038E */  lw         $v1, 0x8($s0)
    /* 5FFAC 8006F7AC 07000224 */  addiu      $v0, $zero, 0x7
    /* 5FFB0 8006F7B0 08006214 */  bne        $v1, $v0, .L8006F7D4
    /* 5FFB4 8006F7B4 3C0011AE */   sw        $s1, 0x3C($s0)
    /* 5FFB8 8006F7B8 0000028E */  lw         $v0, 0x0($s0)
    /* 5FFBC 8006F7BC 00000000 */  nop
    /* 5FFC0 8006F7C0 2A104202 */  slt        $v0, $s2, $v0
    /* 5FFC4 8006F7C4 03004010 */  beqz       $v0, .L8006F7D4
    /* 5FFC8 8006F7C8 00000000 */   nop
    /* 5FFCC 8006F7CC 000012AE */  sw         $s2, 0x0($s0)
    /* 5FFD0 8006F7D0 040013AE */  sw         $s3, 0x4($s0)
  .L8006F7D4:
    /* 5FFD4 8006F7D4 2000BF8F */  lw         $ra, 0x20($sp)
    /* 5FFD8 8006F7D8 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 5FFDC 8006F7DC 1800B28F */  lw         $s2, 0x18($sp)
    /* 5FFE0 8006F7E0 1400B18F */  lw         $s1, 0x14($sp)
    /* 5FFE4 8006F7E4 1000B08F */  lw         $s0, 0x10($sp)
    /* 5FFE8 8006F7E8 0800E003 */  jr         $ra
    /* 5FFEC 8006F7EC 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel AIScript_SubmitPlayerAction__FP10AIScript_ti20AIScript_tPlayActioni
