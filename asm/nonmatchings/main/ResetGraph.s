.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ResetGraph, 0x174

glabel ResetGraph
    /* DDE70 800ED670 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DDE74 800ED674 1400B1AF */  sw         $s1, 0x14($sp)
    /* DDE78 800ED678 21888000 */  addu       $s1, $a0, $zero
    /* DDE7C 800ED67C 07002332 */  andi       $v1, $s1, 0x7
    /* DDE80 800ED680 03000224 */  addiu      $v0, $zero, 0x3
    /* DDE84 800ED684 1800BFAF */  sw         $ra, 0x18($sp)
    /* DDE88 800ED688 0C006210 */  beq        $v1, $v0, .L800ED6BC
    /* DDE8C 800ED68C 1000B0AF */   sw        $s0, 0x10($sp)
    /* DDE90 800ED690 04006228 */  slti       $v0, $v1, 0x4
    /* DDE94 800ED694 05004010 */  beqz       $v0, .L800ED6AC
    /* DDE98 800ED698 05000224 */   addiu     $v0, $zero, 0x5
    /* DDE9C 800ED69C 07006010 */  beqz       $v1, .L800ED6BC
    /* DDEA0 800ED6A0 00000000 */   nop
    /* DDEA4 800ED6A4 E0B50308 */  j          .L800ED780
    /* DDEA8 800ED6A8 00000000 */   nop
  .L800ED6AC:
    /* DDEAC 800ED6AC 0A006210 */  beq        $v1, $v0, .L800ED6D8
    /* DDEB0 800ED6B0 00000000 */   nop
    /* DDEB4 800ED6B4 E0B50308 */  j          .L800ED780
    /* DDEB8 800ED6B8 00000000 */   nop
  .L800ED6BC:
    /* DDEBC 800ED6BC 0580043C */  lui        $a0, %hi(D_80056D10)
    /* DDEC0 800ED6C0 106D8424 */  addiu      $a0, $a0, %lo(D_80056D10)
    /* DDEC4 800ED6C4 1280053C */  lui        $a1, %hi(D_80123654)
    /* DDEC8 800ED6C8 5436A524 */  addiu      $a1, $a1, %lo(D_80123654)
    /* DDECC 800ED6CC 1280063C */  lui        $a2, %hi(GEnv)
    /* DDED0 800ED6D0 2B0A040C */  jal        printf
    /* DDED4 800ED6D4 9C36C624 */   addiu     $a2, $a2, %lo(GEnv)
  .L800ED6D8:
    /* DDED8 800ED6D8 1280103C */  lui        $s0, %hi(GEnv)
    /* DDEDC 800ED6DC 9C361026 */  addiu      $s0, $s0, %lo(GEnv)
    /* DDEE0 800ED6E0 21200002 */  addu       $a0, $s0, $zero
    /* DDEE4 800ED6E4 21280000 */  addu       $a1, $zero, $zero
    /* DDEE8 800ED6E8 8DBF030C */  jal        _memset
    /* DDEEC 800ED6EC 80000624 */   addiu     $a2, $zero, 0x80
    /* DDEF0 800ED6F0 13CA030C */  jal        ResetCallback
    /* DDEF4 800ED6F4 00000000 */   nop
    /* DDEF8 800ED6F8 FF00023C */  lui        $v0, (0xFFFFFF >> 16)
    /* DDEFC 800ED6FC 1280043C */  lui        $a0, %hi(D_80123694)
    /* DDF00 800ED700 9436848C */  lw         $a0, %lo(D_80123694)($a0)
    /* DDF04 800ED704 FFFF4234 */  ori        $v0, $v0, (0xFFFFFF & 0xFFFF)
    /* DDF08 800ED708 8312040C */  jal        GPU_cw
    /* DDF0C 800ED70C 24208200 */   and       $a0, $a0, $v0
    /* DDF10 800ED710 1BBE030C */  jal        _reset
    /* DDF14 800ED714 21202002 */   addu      $a0, $s1, $zero
    /* DDF18 800ED718 10000426 */  addiu      $a0, $s0, 0x10
    /* DDF1C 800ED71C 000002A2 */  sb         $v0, 0x0($s0)
    /* DDF20 800ED720 00000292 */  lbu        $v0, 0x0($s0)
    /* DDF24 800ED724 01000324 */  addiu      $v1, $zero, 0x1
    /* DDF28 800ED728 010003A2 */  sb         $v1, 0x1($s0)
    /* DDF2C 800ED72C 80100200 */  sll        $v0, $v0, 2
    /* DDF30 800ED730 1280033C */  lui        $v1, %hi(D_8012371C)
    /* DDF34 800ED734 21186200 */  addu       $v1, $v1, $v0
    /* DDF38 800ED738 1C376394 */  lhu        $v1, %lo(D_8012371C)($v1)
    /* DDF3C 800ED73C 00000292 */  lbu        $v0, 0x0($s0)
    /* DDF40 800ED740 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* DDF44 800ED744 80100200 */  sll        $v0, $v0, 2
    /* DDF48 800ED748 040003A6 */  sh         $v1, 0x4($s0)
    /* DDF4C 800ED74C 1280013C */  lui        $at, %hi(D_80123728)
    /* DDF50 800ED750 21082200 */  addu       $at, $at, $v0
    /* DDF54 800ED754 28372294 */  lhu        $v0, %lo(D_80123728)($at)
    /* DDF58 800ED758 5C000624 */  addiu      $a2, $zero, 0x5C
    /* DDF5C 800ED75C 8DBF030C */  jal        _memset
    /* DDF60 800ED760 060002A6 */   sh        $v0, 0x6($s0)
    /* DDF64 800ED764 6C000426 */  addiu      $a0, $s0, 0x6C
    /* DDF68 800ED768 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* DDF6C 800ED76C 8DBF030C */  jal        _memset
    /* DDF70 800ED770 14000624 */   addiu     $a2, $zero, 0x14
    /* DDF74 800ED774 00000292 */  lbu        $v0, 0x0($s0)
    /* DDF78 800ED778 F4B50308 */  j          .L800ED7D0
    /* DDF7C 800ED77C 00000000 */   nop
  .L800ED780:
    /* DDF80 800ED780 1280023C */  lui        $v0, %hi(D_8012369E)
    /* DDF84 800ED784 9E364290 */  lbu        $v0, %lo(D_8012369E)($v0)
    /* DDF88 800ED788 00000000 */  nop
    /* DDF8C 800ED78C 0200422C */  sltiu      $v0, $v0, 0x2
    /* DDF90 800ED790 08004014 */  bnez       $v0, .L800ED7B4
    /* DDF94 800ED794 00000000 */   nop
    /* DDF98 800ED798 0580043C */  lui        $a0, %hi(D_80056D30)
    /* DDF9C 800ED79C 306D8424 */  addiu      $a0, $a0, %lo(D_80056D30)
    /* DDFA0 800ED7A0 1280023C */  lui        $v0, %hi(GPU_printf)
    /* DDFA4 800ED7A4 9836428C */  lw         $v0, %lo(GPU_printf)($v0)
    /* DDFA8 800ED7A8 00000000 */  nop
    /* DDFAC 800ED7AC 09F84000 */  jalr       $v0
    /* DDFB0 800ED7B0 21282002 */   addu      $a1, $s1, $zero
  .L800ED7B4:
    /* DDFB4 800ED7B4 1280023C */  lui        $v0, %hi(D_80123694)
    /* DDFB8 800ED7B8 9436428C */  lw         $v0, %lo(D_80123694)($v0)
    /* DDFBC 800ED7BC 00000000 */  nop
    /* DDFC0 800ED7C0 3400428C */  lw         $v0, 0x34($v0)
    /* DDFC4 800ED7C4 00000000 */  nop
    /* DDFC8 800ED7C8 09F84000 */  jalr       $v0
    /* DDFCC 800ED7CC 01000424 */   addiu     $a0, $zero, 0x1
  .L800ED7D0:
    /* DDFD0 800ED7D0 1800BF8F */  lw         $ra, 0x18($sp)
    /* DDFD4 800ED7D4 1400B18F */  lw         $s1, 0x14($sp)
    /* DDFD8 800ED7D8 1000B08F */  lw         $s0, 0x10($sp)
    /* DDFDC 800ED7DC 0800E003 */  jr         $ra
    /* DDFE0 800ED7E0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ResetGraph
