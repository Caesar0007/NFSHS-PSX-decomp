.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_DirectRequest__FillP8Car_tObjPc, 0xAC

glabel CopSpeak_DirectRequest__FillP8Car_tObjPc
    /* 8A3EC 80099BEC D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 8A3F0 80099BF0 1800B2AF */  sw         $s2, 0x18($sp)
    /* 8A3F4 80099BF4 21908000 */  addu       $s2, $a0, $zero
    /* 8A3F8 80099BF8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 8A3FC 80099BFC 2198A000 */  addu       $s3, $a1, $zero
    /* 8A400 80099C00 2000B4AF */  sw         $s4, 0x20($sp)
    /* 8A404 80099C04 21A0C000 */  addu       $s4, $a2, $zero
    /* 8A408 80099C08 2400B5AF */  sw         $s5, 0x24($sp)
    /* 8A40C 80099C0C 21A8E000 */  addu       $s5, $a3, $zero
    /* 8A410 80099C10 1400B1AF */  sw         $s1, 0x14($sp)
    /* 8A414 80099C14 1180033C */  lui        $v1, %hi(CopSpeak_gQueue)
    /* 8A418 80099C18 7C0B848F */  lw         $a0, %gp_rel(CopSpeak_gQueueHead)($gp)
    /* 8A41C 80099C1C 241F6324 */  addiu      $v1, $v1, %lo(CopSpeak_gQueue)
    /* 8A420 80099C20 2800BFAF */  sw         $ra, 0x28($sp)
    /* 8A424 80099C24 1000B0AF */  sw         $s0, 0x10($sp)
    /* 8A428 80099C28 40110400 */  sll        $v0, $a0, 5
    /* 8A42C 80099C2C 21804300 */  addu       $s0, $v0, $v1
    /* 8A430 80099C30 3F008228 */  slti       $v0, $a0, 0x3F
    /* 8A434 80099C34 02004010 */  beqz       $v0, .L80099C40
    /* 8A438 80099C38 21880000 */   addu      $s1, $zero, $zero
    /* 8A43C 80099C3C 01009124 */  addiu      $s1, $a0, 0x1
  .L80099C40:
    /* 8A440 80099C40 800B828F */  lw         $v0, %gp_rel(CopSpeak_gQueuePlay)($gp)
    /* 8A444 80099C44 00000000 */  nop
    /* 8A448 80099C48 0A002212 */  beq        $s1, $v0, .L80099C74
    /* 8A44C 80099C4C 00000000 */   nop
    /* 8A450 80099C50 7C65020C */  jal        CopSpeak_InitRequest__FP17CopSpeak_tRequest
    /* 8A454 80099C54 21200002 */   addu      $a0, $s0, $zero
    /* 8A458 80099C58 7F000224 */  addiu      $v0, $zero, 0x7F
    /* 8A45C 80099C5C 100012AE */  sw         $s2, 0x10($s0)
    /* 8A460 80099C60 080013AE */  sw         $s3, 0x8($s0)
    /* 8A464 80099C64 0C0014AE */  sw         $s4, 0xC($s0)
    /* 8A468 80099C68 1F0002A2 */  sb         $v0, 0x1F($s0)
    /* 8A46C 80099C6C 000015AE */  sw         $s5, 0x0($s0)
    /* 8A470 80099C70 7C0B91AF */  sw         $s1, %gp_rel(CopSpeak_gQueueHead)($gp)
  .L80099C74:
    /* 8A474 80099C74 2800BF8F */  lw         $ra, 0x28($sp)
    /* 8A478 80099C78 2400B58F */  lw         $s5, 0x24($sp)
    /* 8A47C 80099C7C 2000B48F */  lw         $s4, 0x20($sp)
    /* 8A480 80099C80 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 8A484 80099C84 1800B28F */  lw         $s2, 0x18($sp)
    /* 8A488 80099C88 1400B18F */  lw         $s1, 0x14($sp)
    /* 8A48C 80099C8C 1000B08F */  lw         $s0, 0x10($sp)
    /* 8A490 80099C90 0800E003 */  jr         $ra
    /* 8A494 80099C94 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel CopSpeak_DirectRequest__FillP8Car_tObjPc
