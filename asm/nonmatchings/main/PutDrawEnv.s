.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PutDrawEnv, 0xC0

glabel PutDrawEnv
    /* DE524 800EDD24 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DE528 800EDD28 1800B2AF */  sw         $s2, 0x18($sp)
    /* DE52C 800EDD2C 1280123C */  lui        $s2, %hi(D_8012369E)
    /* DE530 800EDD30 9E365226 */  addiu      $s2, $s2, %lo(D_8012369E)
    /* DE534 800EDD34 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* DE538 800EDD38 1400B1AF */  sw         $s1, 0x14($sp)
    /* DE53C 800EDD3C 1000B0AF */  sw         $s0, 0x10($sp)
    /* DE540 800EDD40 00004292 */  lbu        $v0, 0x0($s2)
    /* DE544 800EDD44 00000000 */  nop
    /* DE548 800EDD48 0200422C */  sltiu      $v0, $v0, 0x2
    /* DE54C 800EDD4C 08004014 */  bnez       $v0, .L800EDD70
    /* DE550 800EDD50 21888000 */   addu      $s1, $a0, $zero
    /* DE554 800EDD54 0580043C */  lui        $a0, %hi(D_80056E6C)
    /* DE558 800EDD58 6C6E8424 */  addiu      $a0, $a0, %lo(D_80056E6C)
    /* DE55C 800EDD5C 1280023C */  lui        $v0, %hi(GPU_printf)
    /* DE560 800EDD60 9836428C */  lw         $v0, %lo(GPU_printf)($v0)
    /* DE564 800EDD64 00000000 */  nop
    /* DE568 800EDD68 09F84000 */  jalr       $v0
    /* DE56C 800EDD6C 21282002 */   addu      $a1, $s1, $zero
  .L800EDD70:
    /* DE570 800EDD70 1C003026 */  addiu      $s0, $s1, 0x1C
    /* DE574 800EDD74 21200002 */  addu       $a0, $s0, $zero
    /* DE578 800EDD78 82B9030C */  jal        _set_drawenv
    /* DE57C 800EDD7C 21282002 */   addu      $a1, $s1, $zero
    /* DE580 800EDD80 FF00043C */  lui        $a0, (0xFFFFFF >> 16)
    /* DE584 800EDD84 FFFF8434 */  ori        $a0, $a0, (0xFFFFFF & 0xFFFF)
    /* DE588 800EDD88 21280002 */  addu       $a1, $s0, $zero
    /* DE58C 800EDD8C 40000624 */  addiu      $a2, $zero, 0x40
    /* DE590 800EDD90 1C00228E */  lw         $v0, 0x1C($s1)
    /* DE594 800EDD94 1280033C */  lui        $v1, %hi(D_80123694)
    /* DE598 800EDD98 9436638C */  lw         $v1, %lo(D_80123694)($v1)
    /* DE59C 800EDD9C 25104400 */  or         $v0, $v0, $a0
    /* DE5A0 800EDDA0 1C0022AE */  sw         $v0, 0x1C($s1)
    /* DE5A4 800EDDA4 1800648C */  lw         $a0, 0x18($v1)
    /* DE5A8 800EDDA8 0800628C */  lw         $v0, 0x8($v1)
    /* DE5AC 800EDDAC 00000000 */  nop
    /* DE5B0 800EDDB0 09F84000 */  jalr       $v0
    /* DE5B4 800EDDB4 21380000 */   addu      $a3, $zero, $zero
    /* DE5B8 800EDDB8 0E004426 */  addiu      $a0, $s2, 0xE
    /* DE5BC 800EDDBC 21282002 */  addu       $a1, $s1, $zero
    /* DE5C0 800EDDC0 B1AA030C */  jal        memcpy
    /* DE5C4 800EDDC4 5C000624 */   addiu     $a2, $zero, 0x5C
    /* DE5C8 800EDDC8 21102002 */  addu       $v0, $s1, $zero
    /* DE5CC 800EDDCC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* DE5D0 800EDDD0 1800B28F */  lw         $s2, 0x18($sp)
    /* DE5D4 800EDDD4 1400B18F */  lw         $s1, 0x14($sp)
    /* DE5D8 800EDDD8 1000B08F */  lw         $s0, 0x10($sp)
    /* DE5DC 800EDDDC 0800E003 */  jr         $ra
    /* DE5E0 800EDDE0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel PutDrawEnv
