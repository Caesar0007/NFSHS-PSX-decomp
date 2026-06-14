.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_GenericBankRequest__FiP8Car_tObj, 0xA4

glabel CopSpeak_GenericBankRequest__FiP8Car_tObj
    /* 8A498 80099C98 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 8A49C 80099C9C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 8A4A0 80099CA0 21908000 */  addu       $s2, $a0, $zero
    /* 8A4A4 80099CA4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 8A4A8 80099CA8 2198A000 */  addu       $s3, $a1, $zero
    /* 8A4AC 80099CAC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 8A4B0 80099CB0 1180033C */  lui        $v1, %hi(CopSpeak_gQueue)
    /* 8A4B4 80099CB4 7C0B848F */  lw         $a0, %gp_rel(CopSpeak_gQueueHead)($gp)
    /* 8A4B8 80099CB8 241F6324 */  addiu      $v1, $v1, %lo(CopSpeak_gQueue)
    /* 8A4BC 80099CBC 2000BFAF */  sw         $ra, 0x20($sp)
    /* 8A4C0 80099CC0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 8A4C4 80099CC4 40110400 */  sll        $v0, $a0, 5
    /* 8A4C8 80099CC8 21804300 */  addu       $s0, $v0, $v1
    /* 8A4CC 80099CCC 3F008228 */  slti       $v0, $a0, 0x3F
    /* 8A4D0 80099CD0 02004010 */  beqz       $v0, .L80099CDC
    /* 8A4D4 80099CD4 21880000 */   addu      $s1, $zero, $zero
    /* 8A4D8 80099CD8 01009124 */  addiu      $s1, $a0, 0x1
  .L80099CDC:
    /* 8A4DC 80099CDC 800B828F */  lw         $v0, %gp_rel(CopSpeak_gQueuePlay)($gp)
    /* 8A4E0 80099CE0 00000000 */  nop
    /* 8A4E4 80099CE4 0E002212 */  beq        $s1, $v0, .L80099D20
    /* 8A4E8 80099CE8 00000000 */   nop
    /* 8A4EC 80099CEC 900B828F */  lw         $v0, %gp_rel(CopSpeak_gQueueReady)($gp)
    /* 8A4F0 80099CF0 00000000 */  nop
    /* 8A4F4 80099CF4 0A002212 */  beq        $s1, $v0, .L80099D20
    /* 8A4F8 80099CF8 00000000 */   nop
    /* 8A4FC 80099CFC 7C65020C */  jal        CopSpeak_InitRequest__FP17CopSpeak_tRequest
    /* 8A500 80099D00 21200002 */   addu      $a0, $s0, $zero
    /* 8A504 80099D04 03000224 */  addiu      $v0, $zero, 0x3
    /* 8A508 80099D08 1E0002A2 */  sb         $v0, 0x1E($s0)
    /* 8A50C 80099D0C 7F000224 */  addiu      $v0, $zero, 0x7F
    /* 8A510 80099D10 180012AE */  sw         $s2, 0x18($s0)
    /* 8A514 80099D14 1F0002A2 */  sb         $v0, 0x1F($s0)
    /* 8A518 80099D18 000013AE */  sw         $s3, 0x0($s0)
    /* 8A51C 80099D1C 7C0B91AF */  sw         $s1, %gp_rel(CopSpeak_gQueueHead)($gp)
  .L80099D20:
    /* 8A520 80099D20 2000BF8F */  lw         $ra, 0x20($sp)
    /* 8A524 80099D24 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 8A528 80099D28 1800B28F */  lw         $s2, 0x18($sp)
    /* 8A52C 80099D2C 1400B18F */  lw         $s1, 0x14($sp)
    /* 8A530 80099D30 1000B08F */  lw         $s0, 0x10($sp)
    /* 8A534 80099D34 0800E003 */  jr         $ra
    /* 8A538 80099D38 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel CopSpeak_GenericBankRequest__FiP8Car_tObj
