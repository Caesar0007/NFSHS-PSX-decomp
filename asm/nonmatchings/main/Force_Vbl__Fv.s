.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Force_Vbl__Fv, 0x228

glabel Force_Vbl__Fv
    /* BB198 800CA998 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* BB19C 800CA99C 1800B2AF */  sw         $s2, 0x18($sp)
    /* BB1A0 800CA9A0 21900000 */  addu       $s2, $zero, $zero
    /* BB1A4 800CA9A4 1280023C */  lui        $v0, %hi(Force_rand_256)
    /* BB1A8 800CA9A8 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* BB1AC 800CA9AC 60FC5324 */  addiu      $s3, $v0, %lo(Force_rand_256)
    /* BB1B0 800CA9B0 1280023C */  lui        $v0, %hi(Force_g)
    /* BB1B4 800CA9B4 1000B0AF */  sw         $s0, 0x10($sp)
    /* BB1B8 800CA9B8 60FD5024 */  addiu      $s0, $v0, %lo(Force_g)
    /* BB1BC 800CA9BC 2000BFAF */  sw         $ra, 0x20($sp)
    /* BB1C0 800CA9C0 1400B1AF */  sw         $s1, 0x14($sp)
  .L800CA9C4:
    /* BB1C4 800CA9C4 0200422A */  slti       $v0, $s2, 0x2
    /* BB1C8 800CA9C8 73004010 */  beqz       $v0, .L800CAB98
    /* BB1CC 800CA9CC 00891200 */   sll       $s1, $s2, 4
    /* BB1D0 800CA9D0 A8BF030C */  jal        PadGetState
    /* BB1D4 800CA9D4 21202002 */   addu      $a0, $s1, $zero
    /* BB1D8 800CA9D8 21184000 */  addu       $v1, $v0, $zero
    /* BB1DC 800CA9DC 06000224 */  addiu      $v0, $zero, 0x6
    /* BB1E0 800CA9E0 05006210 */  beq        $v1, $v0, .L800CA9F8
    /* BB1E4 800CA9E4 04006228 */   slti      $v0, $v1, 0x4
    /* BB1E8 800CA9E8 10004010 */  beqz       $v0, .L800CAA2C
    /* BB1EC 800CA9EC 00000000 */   nop
    /* BB1F0 800CA9F0 8B2A0308 */  j          .L800CAA2C
    /* BB1F4 800CA9F4 000000A2 */   sb        $zero, 0x0($s0)
  .L800CA9F8:
    /* BB1F8 800CA9F8 00000292 */  lbu        $v0, 0x0($s0)
    /* BB1FC 800CA9FC 00000000 */  nop
    /* BB200 800CAA00 0A004014 */  bnez       $v0, .L800CAA2C
    /* BB204 800CAA04 06000526 */   addiu     $a1, $s0, 0x6
    /* BB208 800CAA08 21202002 */  addu       $a0, $s1, $zero
    /* BB20C 800CAA0C 6BC0030C */  jal        PadSetAct
    /* BB210 800CAA10 02000624 */   addiu     $a2, $zero, 0x2
    /* BB214 800CAA14 1480053C */  lui        $a1, %hi(Force_gActAlign)
    /* BB218 800CAA18 40D8A524 */  addiu      $a1, $a1, %lo(Force_gActAlign)
    /* BB21C 800CAA1C 4BC0030C */  jal        PadSetActAlign
    /* BB220 800CAA20 21202002 */   addu      $a0, $s1, $zero
    /* BB224 800CAA24 01000224 */  addiu      $v0, $zero, 0x1
    /* BB228 800CAA28 000002A2 */  sb         $v0, 0x0($s0)
  .L800CAA2C:
    /* BB22C 800CAA2C 04000392 */  lbu        $v1, 0x4($s0)
    /* BB230 800CAA30 05000292 */  lbu        $v0, 0x5($s0)
    /* BB234 800CAA34 00000000 */  nop
    /* BB238 800CAA38 2B104300 */  sltu       $v0, $v0, $v1
    /* BB23C 800CAA3C 0E004010 */  beqz       $v0, .L800CAA78
    /* BB240 800CAA40 FF000624 */   addiu     $a2, $zero, 0xFF
    /* BB244 800CAA44 02138297 */  lhu        $v0, %gp_rel(Force_gTick)($gp)
    /* BB248 800CAA48 01000492 */  lbu        $a0, 0x1($s0)
    /* BB24C 800CAA4C 03000392 */  lbu        $v1, 0x3($s0)
    /* BB250 800CAA50 02000592 */  lbu        $a1, 0x2($s0)
    /* BB254 800CAA54 42100200 */  srl        $v0, $v0, 1
    /* BB258 800CAA58 FF004230 */  andi       $v0, $v0, 0xFF
    /* BB25C 800CAA5C 21105300 */  addu       $v0, $v0, $s3
    /* BB260 800CAA60 21208300 */  addu       $a0, $a0, $v1
    /* BB264 800CAA64 00004290 */  lbu        $v0, 0x0($v0)
    /* BB268 800CAA68 2128A300 */  addu       $a1, $a1, $v1
    /* BB26C 800CAA6C 2A104400 */  slt        $v0, $v0, $a0
    /* BB270 800CAA70 CF2A0308 */  j          .L800CAB3C
    /* BB274 800CAA74 060002A2 */   sb        $v0, 0x6($s0)
  .L800CAA78:
    /* BB278 800CAA78 39006010 */  beqz       $v1, .L800CAB60
    /* BB27C 800CAA7C 00000000 */   nop
    /* BB280 800CAA80 03000392 */  lbu        $v1, 0x3($s0)
    /* BB284 800CAA84 04000292 */  lbu        $v0, 0x4($s0)
    /* BB288 800CAA88 00000000 */  nop
    /* BB28C 800CAA8C 18006200 */  mult       $v1, $v0
    /* BB290 800CAA90 12180000 */  mflo       $v1
    /* BB294 800CAA94 05000492 */  lbu        $a0, 0x5($s0)
    /* BB298 800CAA98 00000000 */  nop
    /* BB29C 800CAA9C 1A006400 */  div        $zero, $v1, $a0
    /* BB2A0 800CAAA0 02008014 */  bnez       $a0, .L800CAAAC
    /* BB2A4 800CAAA4 00000000 */   nop
    /* BB2A8 800CAAA8 0D000700 */  break      7
  .L800CAAAC:
    /* BB2AC 800CAAAC FFFF0124 */  addiu      $at, $zero, -0x1
    /* BB2B0 800CAAB0 04008114 */  bne        $a0, $at, .L800CAAC4
    /* BB2B4 800CAAB4 0080013C */   lui       $at, (0x80000000 >> 16)
    /* BB2B8 800CAAB8 02006114 */  bne        $v1, $at, .L800CAAC4
    /* BB2BC 800CAABC 00000000 */   nop
    /* BB2C0 800CAAC0 0D000600 */  break      6
  .L800CAAC4:
    /* BB2C4 800CAAC4 12200000 */  mflo       $a0
    /* BB2C8 800CAAC8 03000392 */  lbu        $v1, 0x3($s0)
    /* BB2CC 800CAACC 04000292 */  lbu        $v0, 0x4($s0)
    /* BB2D0 800CAAD0 00000000 */  nop
    /* BB2D4 800CAAD4 18006200 */  mult       $v1, $v0
    /* BB2D8 800CAAD8 12180000 */  mflo       $v1
    /* BB2DC 800CAADC 05000592 */  lbu        $a1, 0x5($s0)
    /* BB2E0 800CAAE0 00000000 */  nop
    /* BB2E4 800CAAE4 1A006500 */  div        $zero, $v1, $a1
    /* BB2E8 800CAAE8 0200A014 */  bnez       $a1, .L800CAAF4
    /* BB2EC 800CAAEC 00000000 */   nop
    /* BB2F0 800CAAF0 0D000700 */  break      7
  .L800CAAF4:
    /* BB2F4 800CAAF4 FFFF0124 */  addiu      $at, $zero, -0x1
    /* BB2F8 800CAAF8 0400A114 */  bne        $a1, $at, .L800CAB0C
    /* BB2FC 800CAAFC 0080013C */   lui       $at, (0x80000000 >> 16)
    /* BB300 800CAB00 02006114 */  bne        $v1, $at, .L800CAB0C
    /* BB304 800CAB04 00000000 */   nop
    /* BB308 800CAB08 0D000600 */  break      6
  .L800CAB0C:
    /* BB30C 800CAB0C 12280000 */  mflo       $a1
    /* BB310 800CAB10 02138297 */  lhu        $v0, %gp_rel(Force_gTick)($gp)
    /* BB314 800CAB14 01000392 */  lbu        $v1, 0x1($s0)
    /* BB318 800CAB18 42100200 */  srl        $v0, $v0, 1
    /* BB31C 800CAB1C FF004230 */  andi       $v0, $v0, 0xFF
    /* BB320 800CAB20 21105300 */  addu       $v0, $v0, $s3
    /* BB324 800CAB24 00004290 */  lbu        $v0, 0x0($v0)
    /* BB328 800CAB28 21208300 */  addu       $a0, $a0, $v1
    /* BB32C 800CAB2C 02000392 */  lbu        $v1, 0x2($s0)
    /* BB330 800CAB30 2A104400 */  slt        $v0, $v0, $a0
    /* BB334 800CAB34 060002A2 */  sb         $v0, 0x6($s0)
    /* BB338 800CAB38 2128A300 */  addu       $a1, $a1, $v1
  .L800CAB3C:
    /* BB33C 800CAB3C 0001A228 */  slti       $v0, $a1, 0x100
    /* BB340 800CAB40 02004010 */  beqz       $v0, .L800CAB4C
    /* BB344 800CAB44 00000000 */   nop
    /* BB348 800CAB48 2130A000 */  addu       $a2, $a1, $zero
  .L800CAB4C:
    /* BB34C 800CAB4C 04000292 */  lbu        $v0, 0x4($s0)
    /* BB350 800CAB50 070006A2 */  sb         $a2, 0x7($s0)
    /* BB354 800CAB54 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* BB358 800CAB58 E32A0308 */  j          .L800CAB8C
    /* BB35C 800CAB5C 040002A2 */   sb        $v0, 0x4($s0)
  .L800CAB60:
    /* BB360 800CAB60 030000A2 */  sb         $zero, 0x3($s0)
    /* BB364 800CAB64 02138297 */  lhu        $v0, %gp_rel(Force_gTick)($gp)
    /* BB368 800CAB68 02000492 */  lbu        $a0, 0x2($s0)
    /* BB36C 800CAB6C 01000392 */  lbu        $v1, 0x1($s0)
    /* BB370 800CAB70 42100200 */  srl        $v0, $v0, 1
    /* BB374 800CAB74 FF004230 */  andi       $v0, $v0, 0xFF
    /* BB378 800CAB78 21105300 */  addu       $v0, $v0, $s3
    /* BB37C 800CAB7C 00004290 */  lbu        $v0, 0x0($v0)
    /* BB380 800CAB80 070004A2 */  sb         $a0, 0x7($s0)
    /* BB384 800CAB84 2B104300 */  sltu       $v0, $v0, $v1
    /* BB388 800CAB88 060002A2 */  sb         $v0, 0x6($s0)
  .L800CAB8C:
    /* BB38C 800CAB8C 08001026 */  addiu      $s0, $s0, 0x8
    /* BB390 800CAB90 712A0308 */  j          .L800CA9C4
    /* BB394 800CAB94 01005226 */   addiu     $s2, $s2, 0x1
  .L800CAB98:
    /* BB398 800CAB98 02138297 */  lhu        $v0, %gp_rel(Force_gTick)($gp)
    /* BB39C 800CAB9C 2000BF8F */  lw         $ra, 0x20($sp)
    /* BB3A0 800CABA0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* BB3A4 800CABA4 1800B28F */  lw         $s2, 0x18($sp)
    /* BB3A8 800CABA8 1400B18F */  lw         $s1, 0x14($sp)
    /* BB3AC 800CABAC 1000B08F */  lw         $s0, 0x10($sp)
    /* BB3B0 800CABB0 01004224 */  addiu      $v0, $v0, 0x1
    /* BB3B4 800CABB4 021382A7 */  sh         $v0, %gp_rel(Force_gTick)($gp)
    /* BB3B8 800CABB8 0800E003 */  jr         $ra
    /* BB3BC 800CABBC 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Force_Vbl__Fv
