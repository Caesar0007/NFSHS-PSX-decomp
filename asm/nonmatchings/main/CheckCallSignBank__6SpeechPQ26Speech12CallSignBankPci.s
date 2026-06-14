.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckCallSignBank__6SpeechPQ26Speech12CallSignBankPci, 0x138

glabel CheckCallSignBank__6SpeechPQ26Speech12CallSignBankPci
    /* 854D0 80094CD0 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 854D4 80094CD4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 854D8 80094CD8 1180103C */  lui        $s0, %hi(Speech_gCallSignDescription)
    /* 854DC 80094CDC 081E048E */  lw         $a0, %lo(Speech_gCallSignDescription)($s0)
    /* 854E0 80094CE0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 854E4 80094CE4 2188A000 */  addu       $s1, $a1, $zero
    /* 854E8 80094CE8 2000B4AF */  sw         $s4, 0x20($sp)
    /* 854EC 80094CEC 21A0C000 */  addu       $s4, $a2, $zero
    /* 854F0 80094CF0 2400B5AF */  sw         $s5, 0x24($sp)
    /* 854F4 80094CF4 21A8E000 */  addu       $s5, $a3, $zero
    /* 854F8 80094CF8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 854FC 80094CFC 21980000 */  addu       $s3, $zero, $zero
    /* 85500 80094D00 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 85504 80094D04 2800B6AF */  sw         $s6, 0x28($sp)
    /* 85508 80094D08 DDA7030C */  jal        strlen
    /* 8550C 80094D0C 1800B2AF */   sw        $s2, 0x18($sp)
    /* 85510 80094D10 21208002 */  addu       $a0, $s4, $zero
    /* 85514 80094D14 21304000 */  addu       $a2, $v0, $zero
    /* 85518 80094D18 081E058E */  lw         $a1, %lo(Speech_gCallSignDescription)($s0)
    /* 8551C 80094D1C 74AC030C */  jal        strncmp
    /* 85520 80094D20 081E1626 */   addiu     $s6, $s0, %lo(Speech_gCallSignDescription)
    /* 85524 80094D24 03004014 */  bnez       $v0, .L80094D34
    /* 85528 80094D28 6666043C */   lui       $a0, (0x66666667 >> 16)
    /* 8552C 80094D2C 000035AE */  sw         $s5, 0x0($s1)
    /* 85530 80094D30 01001324 */  addiu      $s3, $zero, 0x1
  .L80094D34:
    /* 85534 80094D34 1180023C */  lui        $v0, %hi(D_80113228)
    /* 85538 80094D38 2832438C */  lw         $v1, %lo(D_80113228)($v0)
    /* 8553C 80094D3C 67668434 */  ori        $a0, $a0, (0x66666667 & 0xFFFF)
    /* 85540 80094D40 18006400 */  mult       $v1, $a0
    /* 85544 80094D44 C3170300 */  sra        $v0, $v1, 31
    /* 85548 80094D48 10400000 */  mfhi       $t0
    /* 8554C 80094D4C 43200800 */  sra        $a0, $t0, 1
    /* 85550 80094D50 23208200 */  subu       $a0, $a0, $v0
    /* 85554 80094D54 80100400 */  sll        $v0, $a0, 2
    /* 85558 80094D58 21104400 */  addu       $v0, $v0, $a0
    /* 8555C 80094D5C 23206200 */  subu       $a0, $v1, $v0
    /* 85560 80094D60 80800400 */  sll        $s0, $a0, 2
    /* 85564 80094D64 21801602 */  addu       $s0, $s0, $s6
    /* 85568 80094D68 0400048E */  lw         $a0, 0x4($s0)
    /* 8556C 80094D6C DDA7030C */  jal        strlen
    /* 85570 80094D70 00000000 */   nop
    /* 85574 80094D74 21208002 */  addu       $a0, $s4, $zero
    /* 85578 80094D78 0400058E */  lw         $a1, 0x4($s0)
    /* 8557C 80094D7C 74AC030C */  jal        strncmp
    /* 85580 80094D80 21304000 */   addu      $a2, $v0, $zero
    /* 85584 80094D84 03004014 */  bnez       $v0, .L80094D94
    /* 85588 80094D88 21900000 */   addu      $s2, $zero, $zero
    /* 8558C 80094D8C 040035AE */  sw         $s5, 0x4($s1)
    /* 85590 80094D90 01001324 */  addiu      $s3, $zero, 0x1
  .L80094D94:
    /* 85594 80094D94 2180C002 */  addu       $s0, $s6, $zero
  .L80094D98:
    /* 85598 80094D98 0F00422A */  slti       $v0, $s2, 0xF
    /* 8559C 80094D9C 10004010 */  beqz       $v0, .L80094DE0
    /* 855A0 80094DA0 21106002 */   addu      $v0, $s3, $zero
    /* 855A4 80094DA4 1800048E */  lw         $a0, 0x18($s0)
    /* 855A8 80094DA8 DDA7030C */  jal        strlen
    /* 855AC 80094DAC 00000000 */   nop
    /* 855B0 80094DB0 21208002 */  addu       $a0, $s4, $zero
    /* 855B4 80094DB4 1800058E */  lw         $a1, 0x18($s0)
    /* 855B8 80094DB8 74AC030C */  jal        strncmp
    /* 855BC 80094DBC 21304000 */   addu      $a2, $v0, $zero
    /* 855C0 80094DC0 03004014 */  bnez       $v0, .L80094DD0
    /* 855C4 80094DC4 00000000 */   nop
    /* 855C8 80094DC8 080035AE */  sw         $s5, 0x8($s1)
    /* 855CC 80094DCC 01001324 */  addiu      $s3, $zero, 0x1
  .L80094DD0:
    /* 855D0 80094DD0 04003126 */  addiu      $s1, $s1, 0x4
    /* 855D4 80094DD4 04001026 */  addiu      $s0, $s0, 0x4
    /* 855D8 80094DD8 66530208 */  j          .L80094D98
    /* 855DC 80094DDC 01005226 */   addiu     $s2, $s2, 0x1
  .L80094DE0:
    /* 855E0 80094DE0 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 855E4 80094DE4 2800B68F */  lw         $s6, 0x28($sp)
    /* 855E8 80094DE8 2400B58F */  lw         $s5, 0x24($sp)
    /* 855EC 80094DEC 2000B48F */  lw         $s4, 0x20($sp)
    /* 855F0 80094DF0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 855F4 80094DF4 1800B28F */  lw         $s2, 0x18($sp)
    /* 855F8 80094DF8 1400B18F */  lw         $s1, 0x14($sp)
    /* 855FC 80094DFC 1000B08F */  lw         $s0, 0x10($sp)
    /* 85600 80094E00 0800E003 */  jr         $ra
    /* 85604 80094E04 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel CheckCallSignBank__6SpeechPQ26Speech12CallSignBankPci
