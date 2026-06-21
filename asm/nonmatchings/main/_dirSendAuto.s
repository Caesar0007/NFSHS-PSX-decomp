.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _dirSendAuto, 0x100

glabel _dirSendAuto
    /* FA8E4 8010A0E4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FA8E8 8010A0E8 1000B0AF */  sw         $s0, 0x10($sp)
    /* FA8EC 8010A0EC 21808000 */  addu       $s0, $a0, $zero
    /* FA8F0 8010A0F0 1400BFAF */  sw         $ra, 0x14($sp)
    /* FA8F4 8010A0F4 3C00028E */  lw         $v0, 0x3C($s0)
    /* FA8F8 8010A0F8 00000000 */  nop
    /* FA8FC 8010A0FC 00004390 */  lbu        $v1, 0x0($v0)
    /* FA900 8010A100 F3000224 */  addiu      $v0, $zero, 0xF3
    /* FA904 8010A104 0E006214 */  bne        $v1, $v0, .L8010A140
    /* FA908 8010A108 00000000 */   nop
    /* FA90C 8010A10C E8000292 */  lbu        $v0, 0xE8($s0)
    /* FA910 8010A110 00000000 */  nop
    /* FA914 8010A114 20004010 */  beqz       $v0, .L8010A198
    /* FA918 8010A118 02000224 */   addiu     $v0, $zero, 0x2
    /* FA91C 8010A11C 49000392 */  lbu        $v1, 0x49($s0)
    /* FA920 8010A120 00000000 */  nop
    /* FA924 8010A124 06006214 */  bne        $v1, $v0, .L8010A140
    /* FA928 8010A128 00000000 */   nop
    /* FA92C 8010A12C 1380023C */  lui        $v0, %hi(_padFuncClrInfo)
    /* FA930 8010A130 7C7C428C */  lw         $v0, %lo(_padFuncClrInfo)($v0)
    /* FA934 8010A134 00000000 */  nop
    /* FA938 8010A138 09F84000 */  jalr       $v0
    /* FA93C 8010A13C 21200002 */   addu      $a0, $s0, $zero
  .L8010A140:
    /* FA940 8010A140 46000392 */  lbu        $v1, 0x46($s0)
    /* FA944 8010A144 01000224 */  addiu      $v0, $zero, 0x1
    /* FA948 8010A148 0D006210 */  beq        $v1, $v0, .L8010A180
    /* FA94C 8010A14C 02006228 */   slti      $v0, $v1, 0x2
    /* FA950 8010A150 05004010 */  beqz       $v0, .L8010A168
    /* FA954 8010A154 FE000224 */   addiu     $v0, $zero, 0xFE
    /* FA958 8010A158 1E006010 */  beqz       $v1, .L8010A1D4
    /* FA95C 8010A15C 21100000 */   addu      $v0, $zero, $zero
    /* FA960 8010A160 6A280408 */  j          .L8010A1A8
    /* FA964 8010A164 00000000 */   nop
  .L8010A168:
    /* FA968 8010A168 0A006210 */  beq        $v1, $v0, .L8010A194
    /* FA96C 8010A16C FF000224 */   addiu     $v0, $zero, 0xFF
    /* FA970 8010A170 18006210 */  beq        $v1, $v0, .L8010A1D4
    /* FA974 8010A174 21100000 */   addu      $v0, $zero, $zero
    /* FA978 8010A178 6A280408 */  j          .L8010A1A8
    /* FA97C 8010A17C 00000000 */   nop
  .L8010A180:
    /* FA980 8010A180 21200002 */  addu       $a0, $s0, $zero
    /* FA984 8010A184 A317040C */  jal        _padCmdParaMode
    /* FA988 8010A188 01000524 */   addiu     $a1, $zero, 0x1
    /* FA98C 8010A18C 75280408 */  j          .L8010A1D4
    /* FA990 8010A190 21100000 */   addu      $v0, $zero, $zero
  .L8010A194:
    /* FA994 8010A194 21200002 */  addu       $a0, $s0, $zero
  .L8010A198:
    /* FA998 8010A198 A317040C */  jal        _padCmdParaMode
    /* FA99C 8010A19C 21280000 */   addu      $a1, $zero, $zero
    /* FA9A0 8010A1A0 75280408 */  j          .L8010A1D4
    /* FA9A4 8010A1A4 21100000 */   addu      $v0, $zero, $zero
  .L8010A1A8:
    /* FA9A8 8010A1A8 1400028E */  lw         $v0, 0x14($s0)
    /* FA9AC 8010A1AC 00000000 */  nop
    /* FA9B0 8010A1B0 05004010 */  beqz       $v0, .L8010A1C8
    /* FA9B4 8010A1B4 00000000 */   nop
    /* FA9B8 8010A1B8 09F84000 */  jalr       $v0
    /* FA9BC 8010A1BC 21200002 */   addu      $a0, $s0, $zero
    /* FA9C0 8010A1C0 75280408 */  j          .L8010A1D4
    /* FA9C4 8010A1C4 21100000 */   addu      $v0, $zero, $zero
  .L8010A1C8:
    /* FA9C8 8010A1C8 7F15040C */  jal        _padSendAtLoadInfo
    /* FA9CC 8010A1CC 21200002 */   addu      $a0, $s0, $zero
    /* FA9D0 8010A1D0 21100000 */  addu       $v0, $zero, $zero
  .L8010A1D4:
    /* FA9D4 8010A1D4 1400BF8F */  lw         $ra, 0x14($sp)
    /* FA9D8 8010A1D8 1000B08F */  lw         $s0, 0x10($sp)
    /* FA9DC 8010A1DC 0800E003 */  jr         $ra
    /* FA9E0 8010A1E0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel _dirSendAuto
