.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw_DirectSetEnvironment__Fiiiiiiiiii, 0x104

glabel Draw_DirectSetEnvironment__Fiiiiiiiiii
    /* AEC78 800BE478 68FFBD27 */  addiu      $sp, $sp, -0x98
    /* AEC7C 800BE47C A800A28F */  lw         $v0, 0xA8($sp)
    /* AEC80 800BE480 8C00B5AF */  sw         $s5, 0x8C($sp)
    /* AEC84 800BE484 AC00B58F */  lw         $s5, 0xAC($sp)
    /* AEC88 800BE488 7800B0AF */  sw         $s0, 0x78($sp)
    /* AEC8C 800BE48C B000B08F */  lw         $s0, 0xB0($sp)
    /* AEC90 800BE490 7C00B1AF */  sw         $s1, 0x7C($sp)
    /* AEC94 800BE494 21888000 */  addu       $s1, $a0, $zero
    /* AEC98 800BE498 8000B2AF */  sw         $s2, 0x80($sp)
    /* AEC9C 800BE49C 2190A000 */  addu       $s2, $a1, $zero
    /* AECA0 800BE4A0 8400B3AF */  sw         $s3, 0x84($sp)
    /* AECA4 800BE4A4 2198C000 */  addu       $s3, $a2, $zero
    /* AECA8 800BE4A8 8800B4AF */  sw         $s4, 0x88($sp)
    /* AECAC 800BE4AC 21A0E000 */  addu       $s4, $a3, $zero
    /* AECB0 800BE4B0 18004010 */  beqz       $v0, .L800BE514
    /* AECB4 800BE4B4 9000BFAF */   sw        $ra, 0x90($sp)
    /* AECB8 800BE4B8 1000B4AF */  sw         $s4, 0x10($sp)
    /* AECBC 800BE4BC 1800A427 */  addiu      $a0, $sp, 0x18
    /* AECC0 800BE4C0 21282002 */  addu       $a1, $s1, $zero
    /* AECC4 800BE4C4 21304002 */  addu       $a2, $s2, $zero
    /* AECC8 800BE4C8 8BC8030C */  jal        SetDefDrawEnv
    /* AECCC 800BE4CC 21386002 */   addu      $a3, $s3, $zero
    /* AECD0 800BE4D0 0D000012 */  beqz       $s0, .L800BE508
    /* AECD4 800BE4D4 00000000 */   nop
    /* AECD8 800BE4D8 B400A28F */  lw         $v0, 0xB4($sp)
    /* AECDC 800BE4DC 00000000 */  nop
    /* AECE0 800BE4E0 3100A2A3 */  sb         $v0, 0x31($sp)
    /* AECE4 800BE4E4 B800A28F */  lw         $v0, 0xB8($sp)
    /* AECE8 800BE4E8 00000000 */  nop
    /* AECEC 800BE4EC 3200A2A3 */  sb         $v0, 0x32($sp)
    /* AECF0 800BE4F0 BC00A28F */  lw         $v0, 0xBC($sp)
    /* AECF4 800BE4F4 00000000 */  nop
    /* AECF8 800BE4F8 3300A2A3 */  sb         $v0, 0x33($sp)
    /* AECFC 800BE4FC 01000224 */  addiu      $v0, $zero, 0x1
    /* AED00 800BE500 43F90208 */  j          .L800BE50C
    /* AED04 800BE504 3000A2A3 */   sb        $v0, 0x30($sp)
  .L800BE508:
    /* AED08 800BE508 3000A0A3 */  sb         $zero, 0x30($sp)
  .L800BE50C:
    /* AED0C 800BE50C 49B7030C */  jal        PutDrawEnv
    /* AED10 800BE510 1800A427 */   addiu     $a0, $sp, 0x18
  .L800BE514:
    /* AED14 800BE514 1000A012 */  beqz       $s5, .L800BE558
    /* AED18 800BE518 21282002 */   addu      $a1, $s1, $zero
    /* AED1C 800BE51C 1800A427 */  addiu      $a0, $sp, 0x18
    /* AED20 800BE520 21304002 */  addu       $a2, $s2, $zero
    /* AED24 800BE524 21386002 */  addu       $a3, $s3, $zero
    /* AED28 800BE528 B8C8030C */  jal        SetDefDispEnv
    /* AED2C 800BE52C 1000B4AF */   sw        $s4, 0x10($sp)
    /* AED30 800BE530 F9B5030C */  jal        SetDispMask
    /* AED34 800BE534 21200000 */   addu      $a0, $zero, $zero
    /* AED38 800BE538 79B7030C */  jal        PutDispEnv
    /* AED3C 800BE53C 1800A427 */   addiu     $a0, $sp, 0x18
    /* AED40 800BE540 1480043C */  lui        $a0, %hi(timerhz)
    /* AED44 800BE544 C4DC848C */  lw         $a0, %lo(timerhz)($a0)
    /* AED48 800BE548 A1A0030C */  jal        timedwait
    /* AED4C 800BE54C 43200400 */   sra       $a0, $a0, 1
    /* AED50 800BE550 F9B5030C */  jal        SetDispMask
    /* AED54 800BE554 01000424 */   addiu     $a0, $zero, 0x1
  .L800BE558:
    /* AED58 800BE558 9000BF8F */  lw         $ra, 0x90($sp)
    /* AED5C 800BE55C 8C00B58F */  lw         $s5, 0x8C($sp)
    /* AED60 800BE560 8800B48F */  lw         $s4, 0x88($sp)
    /* AED64 800BE564 8400B38F */  lw         $s3, 0x84($sp)
    /* AED68 800BE568 8000B28F */  lw         $s2, 0x80($sp)
    /* AED6C 800BE56C 7C00B18F */  lw         $s1, 0x7C($sp)
    /* AED70 800BE570 7800B08F */  lw         $s0, 0x78($sp)
    /* AED74 800BE574 0800E003 */  jr         $ra
    /* AED78 800BE578 9800BD27 */   addiu     $sp, $sp, 0x98
endlabel Draw_DirectSetEnvironment__Fiiiiiiiiii
