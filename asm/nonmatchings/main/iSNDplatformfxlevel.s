.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDplatformfxlevel, 0xA0

glabel iSNDplatformfxlevel
    /* F0858 80100058 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F085C 8010005C 40100400 */  sll        $v0, $a0, 1
    /* F0860 80100060 21104400 */  addu       $v0, $v0, $a0
    /* F0864 80100064 80100200 */  sll        $v0, $v0, 2
    /* F0868 80100068 23104400 */  subu       $v0, $v0, $a0
    /* F086C 8010006C 80100200 */  sll        $v0, $v0, 2
    /* F0870 80100070 1480033C */  lui        $v1, %hi(D_801479F0)
    /* F0874 80100074 F0796324 */  addiu      $v1, $v1, %lo(D_801479F0)
    /* F0878 80100078 21184300 */  addu       $v1, $v0, $v1
    /* F087C 8010007C 1000BFAF */  sw         $ra, 0x10($sp)
    /* F0880 80100080 1C006290 */  lbu        $v0, 0x1C($v1)
    /* F0884 80100084 00000000 */  nop
    /* F0888 80100088 FF004530 */  andi       $a1, $v0, 0xFF
    /* F088C 8010008C 02000224 */  addiu      $v0, $zero, 0x2
    /* F0890 80100090 0400A210 */  beq        $a1, $v0, .L801000A4
    /* F0894 80100094 01000724 */   addiu     $a3, $zero, 0x1
    /* F0898 80100098 230066A0 */  sb         $a2, 0x23($v1)
    /* F089C 8010009C 3A000408 */  j          .L801000E8
    /* F08A0 801000A0 21100000 */   addu      $v0, $zero, $zero
  .L801000A4:
    /* F08A4 801000A4 1F006290 */  lbu        $v0, 0x1F($v1)
    /* F08A8 801000A8 00000000 */  nop
    /* F08AC 801000AC 05004514 */  bne        $v0, $a1, .L801000C4
    /* F08B0 801000B0 04208700 */   sllv      $a0, $a3, $a0
    /* F08B4 801000B4 20006290 */  lbu        $v0, 0x20($v1)
    /* F08B8 801000B8 00000000 */  nop
    /* F08BC 801000BC 04104700 */  sllv       $v0, $a3, $v0
    /* F08C0 801000C0 25208200 */  or         $a0, $a0, $v0
  .L801000C4:
    /* F08C4 801000C4 0500C010 */  beqz       $a2, .L801000DC
    /* F08C8 801000C8 00000000 */   nop
    /* F08CC 801000CC 64FC030C */  jal        iSNDpsxeffecton
    /* F08D0 801000D0 00000000 */   nop
    /* F08D4 801000D4 3A000408 */  j          .L801000E8
    /* F08D8 801000D8 21100000 */   addu      $v0, $zero, $zero
  .L801000DC:
    /* F08DC 801000DC 74FC030C */  jal        iSNDpsxeffectoff
    /* F08E0 801000E0 00000000 */   nop
    /* F08E4 801000E4 21100000 */  addu       $v0, $zero, $zero
  .L801000E8:
    /* F08E8 801000E8 1000BF8F */  lw         $ra, 0x10($sp)
    /* F08EC 801000EC 00000000 */  nop
    /* F08F0 801000F0 0800E003 */  jr         $ra
    /* F08F4 801000F4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDplatformfxlevel
