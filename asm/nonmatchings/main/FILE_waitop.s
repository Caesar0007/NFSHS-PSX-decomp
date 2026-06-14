.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_waitop, 0xF4

glabel FILE_waitop
    /* DC9BC 800EC1BC B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* DC9C0 800EC1C0 3800B4AF */  sw         $s4, 0x38($sp)
    /* DC9C4 800EC1C4 21A08000 */  addu       $s4, $a0, $zero
    /* DC9C8 800EC1C8 1480023C */  lui        $v0, %hi(gFileDevice)
    /* DC9CC 800EC1CC 88EA4624 */  addiu      $a2, $v0, %lo(gFileDevice)
    /* DC9D0 800EC1D0 021E1400 */  srl        $v1, $s4, 24
    /* DC9D4 800EC1D4 40100300 */  sll        $v0, $v1, 1
    /* DC9D8 800EC1D8 21104300 */  addu       $v0, $v0, $v1
    /* DC9DC 800EC1DC 4000BFAF */  sw         $ra, 0x40($sp)
    /* DC9E0 800EC1E0 3C00B5AF */  sw         $s5, 0x3C($sp)
    /* DC9E4 800EC1E4 3400B3AF */  sw         $s3, 0x34($sp)
    /* DC9E8 800EC1E8 3000B2AF */  sw         $s2, 0x30($sp)
    /* DC9EC 800EC1EC 2C00B1AF */  sw         $s1, 0x2C($sp)
    /* DC9F0 800EC1F0 2800B0AF */  sw         $s0, 0x28($sp)
    /* DC9F4 800EC1F4 1800C38C */  lw         $v1, 0x18($a2)
    /* DC9F8 800EC1F8 00290200 */  sll        $a1, $v0, 4
    /* DC9FC 800EC1FC 1C008012 */  beqz       $s4, .L800EC270
    /* DCA00 800EC200 21806500 */   addu      $s0, $v1, $a1
    /* DCA04 800EC204 0F00033C */  lui        $v1, (0xFFFFF >> 16)
    /* DCA08 800EC208 FFFF6334 */  ori        $v1, $v1, (0xFFFFF & 0xFFFF)
    /* DCA0C 800EC20C 0000028E */  lw         $v0, 0x0($s0)
    /* DCA10 800EC210 24208302 */  and        $a0, $s4, $v1
    /* DCA14 800EC214 24104300 */  and        $v0, $v0, $v1
    /* DCA18 800EC218 1C008214 */  bne        $a0, $v0, .L800EC28C
    /* DCA1C 800EC21C FDFF0224 */   addiu     $v0, $zero, -0x3
    /* DCA20 800EC220 0800028E */  lw         $v0, 0x8($s0)
    /* DCA24 800EC224 00000000 */  nop
    /* DCA28 800EC228 17004014 */  bnez       $v0, .L800EC288
    /* DCA2C 800EC22C 0F00133C */   lui       $s3, (0xFFFFF >> 16)
    /* DCA30 800EC230 FFFF7336 */  ori        $s3, $s3, (0xFFFFF & 0xFFFF)
    /* DCA34 800EC234 21908000 */  addu       $s2, $a0, $zero
    /* DCA38 800EC238 21A8C000 */  addu       $s5, $a2, $zero
    /* DCA3C 800EC23C 2188A000 */  addu       $s1, $a1, $zero
  .L800EC240:
    /* DCA40 800EC240 019B030C */  jal        systemtask
    /* DCA44 800EC244 21200000 */   addu      $a0, $zero, $zero
    /* DCA48 800EC248 10008012 */  beqz       $s4, .L800EC28C
    /* DCA4C 800EC24C FDFF0224 */   addiu     $v0, $zero, -0x3
    /* DCA50 800EC250 1800A28E */  lw         $v0, 0x18($s5)
    /* DCA54 800EC254 00000000 */  nop
    /* DCA58 800EC258 21102202 */  addu       $v0, $s1, $v0
    /* DCA5C 800EC25C 0000428C */  lw         $v0, 0x0($v0)
    /* DCA60 800EC260 00000000 */  nop
    /* DCA64 800EC264 24105300 */  and        $v0, $v0, $s3
    /* DCA68 800EC268 03004212 */  beq        $s2, $v0, .L800EC278
    /* DCA6C 800EC26C 00000000 */   nop
  .L800EC270:
    /* DCA70 800EC270 A3B00308 */  j          .L800EC28C
    /* DCA74 800EC274 FDFF0224 */   addiu     $v0, $zero, -0x3
  .L800EC278:
    /* DCA78 800EC278 0800028E */  lw         $v0, 0x8($s0)
    /* DCA7C 800EC27C 00000000 */  nop
    /* DCA80 800EC280 EFFF4010 */  beqz       $v0, .L800EC240
    /* DCA84 800EC284 00000000 */   nop
  .L800EC288:
    /* DCA88 800EC288 0800028E */  lw         $v0, 0x8($s0)
  .L800EC28C:
    /* DCA8C 800EC28C 4000BF8F */  lw         $ra, 0x40($sp)
    /* DCA90 800EC290 3C00B58F */  lw         $s5, 0x3C($sp)
    /* DCA94 800EC294 3800B48F */  lw         $s4, 0x38($sp)
    /* DCA98 800EC298 3400B38F */  lw         $s3, 0x34($sp)
    /* DCA9C 800EC29C 3000B28F */  lw         $s2, 0x30($sp)
    /* DCAA0 800EC2A0 2C00B18F */  lw         $s1, 0x2C($sp)
    /* DCAA4 800EC2A4 2800B08F */  lw         $s0, 0x28($sp)
    /* DCAA8 800EC2A8 0800E003 */  jr         $ra
    /* DCAAC 800EC2AC 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel FILE_waitop
