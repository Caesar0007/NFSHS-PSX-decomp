.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CopSpeak_Skip__Fv, 0x6C

glabel CopSpeak_Skip__Fv
    /* 8AC5C 8009A45C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8AC60 8009A460 1180023C */  lui        $v0, %hi(CopSpeak_gQueue)
    /* 8AC64 8009A464 8C0B838F */  lw         $v1, %gp_rel(CopSpeak_gQueueLoad)($gp)
    /* 8AC68 8009A468 241F4224 */  addiu      $v0, $v0, %lo(CopSpeak_gQueue)
    /* 8AC6C 8009A46C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 8AC70 8009A470 40190300 */  sll        $v1, $v1, 5
    /* 8AC74 8009A474 21206200 */  addu       $a0, $v1, $v0
    /* 8AC78 8009A478 1D008390 */  lbu        $v1, 0x1D($a0)
    /* 8AC7C 8009A47C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 8AC80 8009A480 040082AC */  sw         $v0, 0x4($a0)
    /* 8AC84 8009A484 06006010 */  beqz       $v1, .L8009A4A0
    /* 8AC88 8009A488 180082AC */   sw        $v0, 0x18($a0)
    /* 8AC8C 8009A48C 1E008480 */  lb         $a0, 0x1E($a0)
    /* 8AC90 8009A490 21284000 */  addu       $a1, $v0, $zero
    /* 8AC94 8009A494 21300000 */  addu       $a2, $zero, $zero
    /* 8AC98 8009A498 D7D9010C */  jal        AudioCmn_LoadAsyncSfx__FiiPvi
    /* 8AC9C 8009A49C 2138C000 */   addu      $a3, $a2, $zero
  .L8009A4A0:
    /* 8ACA0 8009A4A0 8C0B848F */  lw         $a0, %gp_rel(CopSpeak_gQueueLoad)($gp)
    /* 8ACA4 8009A4A4 00000000 */  nop
    /* 8ACA8 8009A4A8 3F008228 */  slti       $v0, $a0, 0x3F
    /* 8ACAC 8009A4AC 02004010 */  beqz       $v0, .L8009A4B8
    /* 8ACB0 8009A4B0 21180000 */   addu      $v1, $zero, $zero
    /* 8ACB4 8009A4B4 01008324 */  addiu      $v1, $a0, 0x1
  .L8009A4B8:
    /* 8ACB8 8009A4B8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 8ACBC 8009A4BC 8C0B83AF */  sw         $v1, %gp_rel(CopSpeak_gQueueLoad)($gp)
    /* 8ACC0 8009A4C0 0800E003 */  jr         $ra
    /* 8ACC4 8009A4C4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel CopSpeak_Skip__Fv
