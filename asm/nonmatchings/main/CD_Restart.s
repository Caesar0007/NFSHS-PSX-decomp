.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CD_Restart, 0xAC

glabel CD_Restart
    /* EACA8 800FA4A8 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* EACAC 800FA4AC 2400B1AF */  sw         $s1, 0x24($sp)
    /* EACB0 800FA4B0 21888000 */  addu       $s1, $a0, $zero
    /* EACB4 800FA4B4 1480023C */  lui        $v0, %hi(Cdinfo)
    /* EACB8 800FA4B8 C46C428C */  lw         $v0, %lo(Cdinfo)($v0)
    /* EACBC 800FA4BC A0000224 */  addiu      $v0, $zero, 0xA0
    /* EACC0 800FA4C0 2800BFAF */  sw         $ra, 0x28($sp)
    /* EACC4 800FA4C4 2000B0AF */  sw         $s0, 0x20($sp)
    /* EACC8 800FA4C8 1800A2A3 */  sb         $v0, 0x18($sp)
    /* EACCC 800FA4CC 0E000424 */  addiu      $a0, $zero, 0xE
  .L800FA4D0:
    /* EACD0 800FA4D0 1800A527 */  addiu      $a1, $sp, 0x18
    /* EACD4 800FA4D4 C9DE030C */  jal        CdControlB
    /* EACD8 800FA4D8 21300000 */   addu      $a2, $zero, $zero
    /* EACDC 800FA4DC FCFF4010 */  beqz       $v0, .L800FA4D0
    /* EACE0 800FA4E0 0E000424 */   addiu     $a0, $zero, 0xE
    /* EACE4 800FA4E4 C7C8030C */  jal        VSync
    /* EACE8 800FA4E8 03000424 */   addiu     $a0, $zero, 0x3
    /* EACEC 800FA4EC 06DE030C */  jal        CdFlush
    /* EACF0 800FA4F0 00000000 */   nop
    /* EACF4 800FA4F4 21200000 */  addu       $a0, $zero, $zero
    /* EACF8 800FA4F8 13DE030C */  jal        CdSync
    /* EACFC 800FA4FC 21288000 */   addu      $a1, $a0, $zero
    /* EAD00 800FA500 02002016 */  bnez       $s1, .L800FA50C
    /* EAD04 800FA504 1080043C */   lui       $a0, %hi(CdReadyHandler)
    /* EAD08 800FA508 10001124 */  addiu      $s1, $zero, 0x10
  .L800FA50C:
    /* EAD0C 800FA50C 1480103C */  lui        $s0, %hi(Cdinfo)
    /* EAD10 800FA510 C46C1026 */  addiu      $s0, $s0, %lo(Cdinfo)
    /* EAD14 800FA514 140011AE */  sw         $s1, 0x14($s0)
    /* EAD18 800FA518 0C0011AE */  sw         $s1, 0xC($s0)
    /* EAD1C 800FA51C 28DE030C */  jal        CdReadyCallback
    /* EAD20 800FA520 A49C8424 */   addiu     $a0, $a0, %lo(CdReadyHandler)
    /* EAD24 800FA524 1400048E */  lw         $a0, 0x14($s0)
    /* EAD28 800FA528 3DDF030C */  jal        CdIntToPos
    /* EAD2C 800FA52C 1000A527 */   addiu     $a1, $sp, 0x10
    /* EAD30 800FA530 1B000424 */  addiu      $a0, $zero, 0x1B
    /* EAD34 800FA534 1000A527 */  addiu      $a1, $sp, 0x10
    /* EAD38 800FA538 2DDE030C */  jal        CdControl
    /* EAD3C 800FA53C 21300000 */   addu      $a2, $zero, $zero
    /* EAD40 800FA540 2800BF8F */  lw         $ra, 0x28($sp)
    /* EAD44 800FA544 2400B18F */  lw         $s1, 0x24($sp)
    /* EAD48 800FA548 2000B08F */  lw         $s0, 0x20($sp)
    /* EAD4C 800FA54C 0800E003 */  jr         $ra
    /* EAD50 800FA550 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel CD_Restart
