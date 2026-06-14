.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDstreamparsechunk, 0xA8

glabel iSNDstreamparsechunk
    /* D9A70 800E9270 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D9A74 800E9274 1000B0AF */  sw         $s0, 0x10($sp)
    /* D9A78 800E9278 446C023C */  lui        $v0, (0x6C444353 >> 16)
    /* D9A7C 800E927C 1400BFAF */  sw         $ra, 0x14($sp)
    /* D9A80 800E9280 0000A38C */  lw         $v1, 0x0($a1)
    /* D9A84 800E9284 53434234 */  ori        $v0, $v0, (0x6C444353 & 0xFFFF)
    /* D9A88 800E9288 05006214 */  bne        $v1, $v0, .L800E92A0
    /* D9A8C 800E928C 01001024 */   addiu     $s0, $zero, 0x1
    /* D9A90 800E9290 2BA4030C */  jal        iSNDstreamparsedata
    /* D9A94 800E9294 00000000 */   nop
    /* D9A98 800E9298 C1A40308 */  j          .L800E9304
    /* D9A9C 800E929C 21804000 */   addu      $s0, $v0, $zero
  .L800E92A0:
    /* D9AA0 800E92A0 486C023C */  lui        $v0, (0x6C484353 >> 16)
    /* D9AA4 800E92A4 53434234 */  ori        $v0, $v0, (0x6C484353 & 0xFFFF)
    /* D9AA8 800E92A8 05006214 */  bne        $v1, $v0, .L800E92C0
    /* D9AAC 800E92AC 456C023C */   lui       $v0, (0x6C454353 >> 16)
    /* D9AB0 800E92B0 A7A3030C */  jal        iSNDstreamparseheader
    /* D9AB4 800E92B4 00000000 */   nop
    /* D9AB8 800E92B8 C1A40308 */  j          .L800E9304
    /* D9ABC 800E92BC 21804000 */   addu      $s0, $v0, $zero
  .L800E92C0:
    /* D9AC0 800E92C0 53434234 */  ori        $v0, $v0, (0x6C454353 & 0xFFFF)
    /* D9AC4 800E92C4 05006214 */  bne        $v1, $v0, .L800E92DC
    /* D9AC8 800E92C8 436C023C */   lui       $v0, (0x6C434353 >> 16)
    /* D9ACC 800E92CC 8CA4030C */  jal        iSNDstreamparseend
    /* D9AD0 800E92D0 00000000 */   nop
    /* D9AD4 800E92D4 C1A40308 */  j          .L800E9304
    /* D9AD8 800E92D8 21804000 */   addu      $s0, $v0, $zero
  .L800E92DC:
    /* D9ADC 800E92DC 53434234 */  ori        $v0, $v0, (0x6C434353 & 0xFFFF)
    /* D9AE0 800E92E0 05006214 */  bne        $v1, $v0, .L800E92F8
    /* D9AE4 800E92E4 00000000 */   nop
    /* D9AE8 800E92E8 11A4030C */  jal        iSNDstreamparsenumchunks
    /* D9AEC 800E92EC 00000000 */   nop
    /* D9AF0 800E92F0 C1A40308 */  j          .L800E9304
    /* D9AF4 800E92F4 21804000 */   addu      $s0, $v0, $zero
  .L800E92F8:
    /* D9AF8 800E92F8 0400848C */  lw         $a0, 0x4($a0)
    /* D9AFC 800E92FC B4F6030C */  jal        STREAM_release
    /* D9B00 800E9300 00000000 */   nop
  .L800E9304:
    /* D9B04 800E9304 21100002 */  addu       $v0, $s0, $zero
    /* D9B08 800E9308 1400BF8F */  lw         $ra, 0x14($sp)
    /* D9B0C 800E930C 1000B08F */  lw         $s0, 0x10($sp)
    /* D9B10 800E9310 0800E003 */  jr         $ra
    /* D9B14 800E9314 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDstreamparsechunk
