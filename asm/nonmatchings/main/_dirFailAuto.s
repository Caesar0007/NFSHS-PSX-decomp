.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _dirFailAuto, 0xDC

glabel _dirFailAuto
    /* FAC34 8010A434 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FAC38 8010A438 1000B0AF */  sw         $s0, 0x10($sp)
    /* FAC3C 8010A43C 21808000 */  addu       $s0, $a0, $zero
    /* FAC40 8010A440 1400BFAF */  sw         $ra, 0x14($sp)
    /* FAC44 8010A444 4C00028E */  lw         $v0, 0x4C($s0)
    /* FAC48 8010A448 46000392 */  lbu        $v1, 0x46($s0)
    /* FAC4C 8010A44C 01004224 */  addiu      $v0, $v0, 0x1
    /* FAC50 8010A450 1E006010 */  beqz       $v1, .L8010A4CC
    /* FAC54 8010A454 4C0002AE */   sw        $v0, 0x4C($s0)
    /* FAC58 8010A458 01000224 */  addiu      $v0, $zero, 0x1
    /* FAC5C 8010A45C 0B006214 */  bne        $v1, $v0, .L8010A48C
    /* FAC60 8010A460 00000000 */   nop
    /* FAC64 8010A464 4A000392 */  lbu        $v1, 0x4A($s0)
    /* FAC68 8010A468 00000000 */  nop
    /* FAC6C 8010A46C 0200622C */  sltiu      $v0, $v1, 0x2
    /* FAC70 8010A470 0B004014 */  bnez       $v0, .L8010A4A0
    /* FAC74 8010A474 01006224 */   addiu     $v0, $v1, 0x1
    /* FAC78 8010A478 02000224 */  addiu      $v0, $zero, 0x2
    /* FAC7C 8010A47C 490002A2 */  sb         $v0, 0x49($s0)
    /* FAC80 8010A480 FF000224 */  addiu      $v0, $zero, 0xFF
    /* FAC84 8010A484 40290408 */  j          .L8010A500
    /* FAC88 8010A488 460002A2 */   sb        $v0, 0x46($s0)
  .L8010A48C:
    /* FAC8C 8010A48C 4A000392 */  lbu        $v1, 0x4A($s0)
    /* FAC90 8010A490 00000000 */  nop
    /* FAC94 8010A494 0400622C */  sltiu      $v0, $v1, 0x4
    /* FAC98 8010A498 03004010 */  beqz       $v0, .L8010A4A8
    /* FAC9C 8010A49C 01006224 */   addiu     $v0, $v1, 0x1
  .L8010A4A0:
    /* FACA0 8010A4A0 40290408 */  j          .L8010A500
    /* FACA4 8010A4A4 4A0002A2 */   sb        $v0, 0x4A($s0)
  .L8010A4A8:
    /* FACA8 8010A4A8 49000292 */  lbu        $v0, 0x49($s0)
    /* FACAC 8010A4AC 00000000 */  nop
    /* FACB0 8010A4B0 06004010 */  beqz       $v0, .L8010A4CC
    /* FACB4 8010A4B4 00000000 */   nop
    /* FACB8 8010A4B8 1380023C */  lui        $v0, %hi(_padFuncClrInfo)
    /* FACBC 8010A4BC 7C7C428C */  lw         $v0, %lo(_padFuncClrInfo)($v0)
    /* FACC0 8010A4C0 00000000 */  nop
    /* FACC4 8010A4C4 09F84000 */  jalr       $v0
    /* FACC8 8010A4C8 21200002 */   addu      $a0, $s0, $zero
  .L8010A4CC:
    /* FACCC 8010A4CC 3C00028E */  lw         $v0, 0x3C($s0)
    /* FACD0 8010A4D0 00000000 */  nop
    /* FACD4 8010A4D4 00004390 */  lbu        $v1, 0x0($v0)
    /* FACD8 8010A4D8 F3000224 */  addiu      $v0, $zero, 0xF3
    /* FACDC 8010A4DC 08006210 */  beq        $v1, $v0, .L8010A500
    /* FACE0 8010A4E0 FF000324 */   addiu     $v1, $zero, 0xFF
    /* FACE4 8010A4E4 3000028E */  lw         $v0, 0x30($s0)
    /* FACE8 8010A4E8 00000000 */  nop
    /* FACEC 8010A4EC 000043A0 */  sb         $v1, 0x0($v0)
    /* FACF0 8010A4F0 3000028E */  lw         $v0, 0x30($s0)
    /* FACF4 8010A4F4 00000000 */  nop
    /* FACF8 8010A4F8 010040A0 */  sb         $zero, 0x1($v0)
    /* FACFC 8010A4FC E80000A2 */  sb         $zero, 0xE8($s0)
  .L8010A500:
    /* FAD00 8010A500 1400BF8F */  lw         $ra, 0x14($sp)
    /* FAD04 8010A504 1000B08F */  lw         $s0, 0x10($sp)
    /* FAD08 8010A508 0800E003 */  jr         $ra
    /* FAD0C 8010A50C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel _dirFailAuto
