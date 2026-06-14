.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDserver, 0x11C

glabel iSNDserver
    /* DA938 800EA138 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DA93C 800EA13C 1480023C */  lui        $v0, %hi(sndgs)
    /* DA940 800EA140 60784424 */  addiu      $a0, $v0, %lo(sndgs)
    /* DA944 800EA144 1800BFAF */  sw         $ra, 0x18($sp)
    /* DA948 800EA148 1400B1AF */  sw         $s1, 0x14($sp)
    /* DA94C 800EA14C 1000B0AF */  sw         $s0, 0x10($sp)
    /* DA950 800EA150 3E008290 */  lbu        $v0, 0x3E($a0)
    /* DA954 800EA154 00000000 */  nop
    /* DA958 800EA158 39004014 */  bnez       $v0, .L800EA240
    /* DA95C 800EA15C 00000000 */   nop
    /* DA960 800EA160 3F008290 */  lbu        $v0, 0x3F($a0)
    /* DA964 800EA164 00000000 */  nop
    /* DA968 800EA168 07004010 */  beqz       $v0, .L800EA188
    /* DA96C 800EA16C 01000224 */   addiu     $v0, $zero, 0x1
    /* DA970 800EA170 B2008294 */  lhu        $v0, 0xB2($a0)
    /* DA974 800EA174 00000000 */  nop
    /* DA978 800EA178 01004224 */  addiu      $v0, $v0, 0x1
    /* DA97C 800EA17C B20082A4 */  sh         $v0, 0xB2($a0)
    /* DA980 800EA180 90A80308 */  j          .L800EA240
    /* DA984 800EA184 00000000 */   nop
  .L800EA188:
    /* DA988 800EA188 1480033C */  lui        $v1, %hi(timerhz)
    /* DA98C 800EA18C 3E0082A0 */  sb         $v0, 0x3E($a0)
    /* DA990 800EA190 B0008294 */  lhu        $v0, 0xB0($a0)
    /* DA994 800EA194 C4DC658C */  lw         $a1, %lo(timerhz)($v1)
    /* DA998 800EA198 00140200 */  sll        $v0, $v0, 16
    /* DA99C 800EA19C 03140200 */  sra        $v0, $v0, 16
    /* DA9A0 800EA1A0 0600A210 */  beq        $a1, $v0, .L800EA1BC
    /* DA9A4 800EA1A4 00000000 */   nop
    /* DA9A8 800EA1A8 C4DC6294 */  lhu        $v0, %lo(timerhz)($v1)
    /* DA9AC 800EA1AC 00000000 */  nop
    /* DA9B0 800EA1B0 B00082A4 */  sh         $v0, 0xB0($a0)
    /* DA9B4 800EA1B4 440080AC */  sw         $zero, 0x44($a0)
    /* DA9B8 800EA1B8 AC0080AC */  sw         $zero, 0xAC($a0)
  .L800EA1BC:
    /* DA9BC 800EA1BC AC00828C */  lw         $v0, 0xAC($a0)
    /* DA9C0 800EA1C0 00000000 */  nop
    /* DA9C4 800EA1C4 01004224 */  addiu      $v0, $v0, 0x1
    /* DA9C8 800EA1C8 AC0082AC */  sw         $v0, 0xAC($a0)
    /* DA9CC 800EA1CC AC00838C */  lw         $v1, 0xAC($a0)
    /* DA9D0 800EA1D0 00000000 */  nop
    /* DA9D4 800EA1D4 40100300 */  sll        $v0, $v1, 1
    /* DA9D8 800EA1D8 21104300 */  addu       $v0, $v0, $v1
    /* DA9DC 800EA1DC C0100200 */  sll        $v0, $v0, 3
    /* DA9E0 800EA1E0 21104300 */  addu       $v0, $v0, $v1
    /* DA9E4 800EA1E4 80100200 */  sll        $v0, $v0, 2
    /* DA9E8 800EA1E8 1B004500 */  divu       $zero, $v0, $a1
    /* DA9EC 800EA1EC 0200A014 */  bnez       $a1, .L800EA1F8
    /* DA9F0 800EA1F0 00000000 */   nop
    /* DA9F4 800EA1F4 0D000700 */  break      7
  .L800EA1F8:
    /* DA9F8 800EA1F8 12880000 */  mflo       $s1
    /* DA9FC 800EA1FC 4400828C */  lw         $v0, 0x44($a0)
    /* DAA00 800EA200 00000000 */  nop
    /* DAA04 800EA204 2B102202 */  sltu       $v0, $s1, $v0
    /* DAA08 800EA208 0B004014 */  bnez       $v0, .L800EA238
    /* DAA0C 800EA20C 1480023C */   lui       $v0, %hi(sndgs)
    /* DAA10 800EA210 21808000 */  addu       $s0, $a0, $zero
  .L800EA214:
    /* DAA14 800EA214 4800028E */  lw         $v0, 0x48($s0)
    /* DAA18 800EA218 00000000 */  nop
    /* DAA1C 800EA21C 09F84000 */  jalr       $v0
    /* DAA20 800EA220 00000000 */   nop
    /* DAA24 800EA224 4400028E */  lw         $v0, 0x44($s0)
    /* DAA28 800EA228 00000000 */  nop
    /* DAA2C 800EA22C 2B102202 */  sltu       $v0, $s1, $v0
    /* DAA30 800EA230 F8FF4010 */  beqz       $v0, .L800EA214
    /* DAA34 800EA234 1480023C */   lui       $v0, %hi(sndgs)
  .L800EA238:
    /* DAA38 800EA238 60784224 */  addiu      $v0, $v0, %lo(sndgs)
    /* DAA3C 800EA23C 3E0040A0 */  sb         $zero, 0x3E($v0)
  .L800EA240:
    /* DAA40 800EA240 1800BF8F */  lw         $ra, 0x18($sp)
    /* DAA44 800EA244 1400B18F */  lw         $s1, 0x14($sp)
    /* DAA48 800EA248 1000B08F */  lw         $s0, 0x10($sp)
    /* DAA4C 800EA24C 0800E003 */  jr         $ra
    /* DAA50 800EA250 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iSNDserver
