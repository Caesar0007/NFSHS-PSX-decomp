.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDrandom, 0x100

glabel iSNDrandom
    /* FC680 8010BE80 1480023C */  lui        $v0, %hi(sndseed)
    /* FC684 8010BE84 F0C24224 */  addiu      $v0, $v0, %lo(sndseed)
    /* FC688 8010BE88 1400438C */  lw         $v1, 0x14($v0)
    /* FC68C 8010BE8C 1000428C */  lw         $v0, 0x10($v0)
    /* FC690 8010BE90 00000000 */  nop
    /* FC694 8010BE94 21306200 */  addu       $a2, $v1, $v0
    /* FC698 8010BE98 2B18C300 */  sltu       $v1, $a2, $v1
    /* FC69C 8010BE9C 04006014 */  bnez       $v1, .L8010BEB0
    /* FC6A0 8010BEA0 21380000 */   addu      $a3, $zero, $zero
    /* FC6A4 8010BEA4 2B10C200 */  sltu       $v0, $a2, $v0
    /* FC6A8 8010BEA8 03004010 */  beqz       $v0, .L8010BEB8
    /* FC6AC 8010BEAC 1480093C */   lui       $t1, %hi(sndseed)
  .L8010BEB0:
    /* FC6B0 8010BEB0 01000724 */  addiu      $a3, $zero, 0x1
    /* FC6B4 8010BEB4 1480093C */  lui        $t1, %hi(sndseed)
  .L8010BEB8:
    /* FC6B8 8010BEB8 F0C22825 */  addiu      $t0, $t1, %lo(sndseed)
    /* FC6BC 8010BEBC 0C00038D */  lw         $v1, 0xC($t0)
    /* FC6C0 8010BEC0 0800048D */  lw         $a0, 0x8($t0)
    /* FC6C4 8010BEC4 0400058D */  lw         $a1, 0x4($t0)
    /* FC6C8 8010BEC8 100006AD */  sw         $a2, 0x10($t0)
    /* FC6CC 8010BECC 2110C300 */  addu       $v0, $a2, $v1
    /* FC6D0 8010BED0 21304700 */  addu       $a2, $v0, $a3
    /* FC6D4 8010BED4 2B38C300 */  sltu       $a3, $a2, $v1
    /* FC6D8 8010BED8 2110C400 */  addu       $v0, $a2, $a0
    /* FC6DC 8010BEDC 0C0006AD */  sw         $a2, 0xC($t0)
    /* FC6E0 8010BEE0 21304700 */  addu       $a2, $v0, $a3
    /* FC6E4 8010BEE4 2B38C400 */  sltu       $a3, $a2, $a0
    /* FC6E8 8010BEE8 2110C500 */  addu       $v0, $a2, $a1
    /* FC6EC 8010BEEC 080006AD */  sw         $a2, 0x8($t0)
    /* FC6F0 8010BEF0 21304700 */  addu       $a2, $v0, $a3
    /* FC6F4 8010BEF4 F0C2238D */  lw         $v1, %lo(sndseed)($t1)
    /* FC6F8 8010BEF8 1400028D */  lw         $v0, 0x14($t0)
    /* FC6FC 8010BEFC 2B38C500 */  sltu       $a3, $a2, $a1
    /* FC700 8010BF00 040006AD */  sw         $a2, 0x4($t0)
    /* FC704 8010BF04 2118C300 */  addu       $v1, $a2, $v1
    /* FC708 8010BF08 21306700 */  addu       $a2, $v1, $a3
    /* FC70C 8010BF0C 01004224 */  addiu      $v0, $v0, 0x1
    /* FC710 8010BF10 F0C226AD */  sw         $a2, %lo(sndseed)($t1)
    /* FC714 8010BF14 18004014 */  bnez       $v0, .L8010BF78
    /* FC718 8010BF18 140002AD */   sw        $v0, 0x14($t0)
    /* FC71C 8010BF1C 1000028D */  lw         $v0, 0x10($t0)
    /* FC720 8010BF20 00000000 */  nop
    /* FC724 8010BF24 01004224 */  addiu      $v0, $v0, 0x1
    /* FC728 8010BF28 13004014 */  bnez       $v0, .L8010BF78
    /* FC72C 8010BF2C 100002AD */   sw        $v0, 0x10($t0)
    /* FC730 8010BF30 0C00028D */  lw         $v0, 0xC($t0)
    /* FC734 8010BF34 00000000 */  nop
    /* FC738 8010BF38 01004224 */  addiu      $v0, $v0, 0x1
    /* FC73C 8010BF3C 0E004014 */  bnez       $v0, .L8010BF78
    /* FC740 8010BF40 0C0002AD */   sw        $v0, 0xC($t0)
    /* FC744 8010BF44 0800028D */  lw         $v0, 0x8($t0)
    /* FC748 8010BF48 00000000 */  nop
    /* FC74C 8010BF4C 01004224 */  addiu      $v0, $v0, 0x1
    /* FC750 8010BF50 09004014 */  bnez       $v0, .L8010BF78
    /* FC754 8010BF54 080002AD */   sw        $v0, 0x8($t0)
    /* FC758 8010BF58 0400028D */  lw         $v0, 0x4($t0)
    /* FC75C 8010BF5C 00000000 */  nop
    /* FC760 8010BF60 01004224 */  addiu      $v0, $v0, 0x1
    /* FC764 8010BF64 04004014 */  bnez       $v0, .L8010BF78
    /* FC768 8010BF68 040002AD */   sw        $v0, 0x4($t0)
    /* FC76C 8010BF6C 0100C224 */  addiu      $v0, $a2, 0x1
    /* FC770 8010BF70 F0C222AD */  sw         $v0, %lo(sndseed)($t1)
    /* FC774 8010BF74 21304000 */  addu       $a2, $v0, $zero
  .L8010BF78:
    /* FC778 8010BF78 0800E003 */  jr         $ra
    /* FC77C 8010BF7C 2110C000 */   addu      $v0, $a2, $zero
endlabel iSNDrandom
