.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_PlayerHornOff__Fi, 0xBC

glabel AudioCmn_PlayerHornOff__Fi
    /* 69D48 80079548 F800828F */  lw         $v0, %gp_rel(AudioCmn_kAudioOn)($gp)
    /* 69D4C 8007954C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 69D50 80079550 1400BFAF */  sw         $ra, 0x14($sp)
    /* 69D54 80079554 26004010 */  beqz       $v0, .L800795F0
    /* 69D58 80079558 1000B0AF */   sw        $s0, 0x10($sp)
    /* 69D5C 8007955C 07008010 */  beqz       $a0, .L8007957C
    /* 69D60 80079560 29001024 */   addiu     $s0, $zero, 0x29
    /* 69D64 80079564 1180023C */  lui        $v0, %hi(D_801131F8)
    /* 69D68 80079568 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* 69D6C 8007956C 01000224 */  addiu      $v0, $zero, 0x1
    /* 69D70 80079570 07006214 */  bne        $v1, $v0, .L80079590
    /* 69D74 80079574 1180033C */   lui       $v1, %hi(Cars_gList)
    /* 69D78 80079578 2A001024 */  addiu      $s0, $zero, 0x2A
  .L8007957C:
    /* 69D7C 8007957C 1180023C */  lui        $v0, %hi(D_801131F8)
    /* 69D80 80079580 F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* 69D84 80079584 01000224 */  addiu      $v0, $zero, 0x1
    /* 69D88 80079588 17006210 */  beq        $v1, $v0, .L800795E8
    /* 69D8C 8007958C 1180033C */   lui       $v1, %hi(Cars_gList)
  .L80079590:
    /* 69D90 80079590 DCF96324 */  addiu      $v1, $v1, %lo(Cars_gList)
    /* 69D94 80079594 80100400 */  sll        $v0, $a0, 2
    /* 69D98 80079598 21104300 */  addu       $v0, $v0, $v1
    /* 69D9C 8007959C 0000428C */  lw         $v0, 0x0($v0)
    /* 69DA0 800795A0 00000000 */  nop
    /* 69DA4 800795A4 8802428C */  lw         $v0, 0x288($v0)
    /* 69DA8 800795A8 00000000 */  nop
    /* 69DAC 800795AC 0000438C */  lw         $v1, 0x0($v0)
    /* 69DB0 800795B0 14000224 */  addiu      $v0, $zero, 0x14
    /* 69DB4 800795B4 0C006214 */  bne        $v1, $v0, .L800795E8
    /* 69DB8 800795B8 1180023C */   lui       $v0, %hi(gaChannel)
    /* 69DBC 800795BC FCE84224 */  addiu      $v0, $v0, %lo(gaChannel)
    /* 69DC0 800795C0 C0181000 */  sll        $v1, $s0, 3
    /* 69DC4 800795C4 21186200 */  addu       $v1, $v1, $v0
    /* 69DC8 800795C8 0000648C */  lw         $a0, 0x0($v1)
    /* 69DCC 800795CC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 69DD0 800795D0 05008210 */  beq        $a0, $v0, .L800795E8
    /* 69DD4 800795D4 00000000 */   nop
    /* 69DD8 800795D8 C59E030C */  jal        SNDover
    /* 69DDC 800795DC 00000000 */   nop
    /* 69DE0 800795E0 04004010 */  beqz       $v0, .L800795F4
    /* 69DE4 800795E4 01000224 */   addiu     $v0, $zero, 0x1
  .L800795E8:
    /* 69DE8 800795E8 34E0010C */  jal        freeVoiceChannel__Fi
    /* 69DEC 800795EC 21200002 */   addu      $a0, $s0, $zero
  .L800795F0:
    /* 69DF0 800795F0 21100000 */  addu       $v0, $zero, $zero
  .L800795F4:
    /* 69DF4 800795F4 1400BF8F */  lw         $ra, 0x14($sp)
    /* 69DF8 800795F8 1000B08F */  lw         $s0, 0x10($sp)
    /* 69DFC 800795FC 0800E003 */  jr         $ra
    /* 69E00 80079600 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AudioCmn_PlayerHornOff__Fi
