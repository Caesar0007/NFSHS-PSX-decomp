.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_EACrandom, 0x100

glabel iSPCH_EACrandom
    /* DC1C4 800EB9C4 1280023C */  lui        $v0, %hi(seedX)
    /* DC1C8 800EB9C8 F4354224 */  addiu      $v0, $v0, %lo(seedX)
    /* DC1CC 800EB9CC 1400438C */  lw         $v1, 0x14($v0)
    /* DC1D0 800EB9D0 1000428C */  lw         $v0, 0x10($v0)
    /* DC1D4 800EB9D4 00000000 */  nop
    /* DC1D8 800EB9D8 21306200 */  addu       $a2, $v1, $v0
    /* DC1DC 800EB9DC 2B18C300 */  sltu       $v1, $a2, $v1
    /* DC1E0 800EB9E0 04006014 */  bnez       $v1, .L800EB9F4
    /* DC1E4 800EB9E4 21380000 */   addu      $a3, $zero, $zero
    /* DC1E8 800EB9E8 2B10C200 */  sltu       $v0, $a2, $v0
    /* DC1EC 800EB9EC 03004010 */  beqz       $v0, .L800EB9FC
    /* DC1F0 800EB9F0 1280093C */   lui       $t1, %hi(seedX)
  .L800EB9F4:
    /* DC1F4 800EB9F4 01000724 */  addiu      $a3, $zero, 0x1
    /* DC1F8 800EB9F8 1280093C */  lui        $t1, %hi(seedX)
  .L800EB9FC:
    /* DC1FC 800EB9FC F4352825 */  addiu      $t0, $t1, %lo(seedX)
    /* DC200 800EBA00 0C00038D */  lw         $v1, 0xC($t0)
    /* DC204 800EBA04 0800048D */  lw         $a0, 0x8($t0)
    /* DC208 800EBA08 0400058D */  lw         $a1, 0x4($t0)
    /* DC20C 800EBA0C 100006AD */  sw         $a2, 0x10($t0)
    /* DC210 800EBA10 2110C300 */  addu       $v0, $a2, $v1
    /* DC214 800EBA14 21304700 */  addu       $a2, $v0, $a3
    /* DC218 800EBA18 2B38C300 */  sltu       $a3, $a2, $v1
    /* DC21C 800EBA1C 2110C400 */  addu       $v0, $a2, $a0
    /* DC220 800EBA20 0C0006AD */  sw         $a2, 0xC($t0)
    /* DC224 800EBA24 21304700 */  addu       $a2, $v0, $a3
    /* DC228 800EBA28 2B38C400 */  sltu       $a3, $a2, $a0
    /* DC22C 800EBA2C 2110C500 */  addu       $v0, $a2, $a1
    /* DC230 800EBA30 080006AD */  sw         $a2, 0x8($t0)
    /* DC234 800EBA34 21304700 */  addu       $a2, $v0, $a3
    /* DC238 800EBA38 F435238D */  lw         $v1, %lo(seedX)($t1)
    /* DC23C 800EBA3C 1400028D */  lw         $v0, 0x14($t0)
    /* DC240 800EBA40 2B38C500 */  sltu       $a3, $a2, $a1
    /* DC244 800EBA44 040006AD */  sw         $a2, 0x4($t0)
    /* DC248 800EBA48 2118C300 */  addu       $v1, $a2, $v1
    /* DC24C 800EBA4C 21306700 */  addu       $a2, $v1, $a3
    /* DC250 800EBA50 01004224 */  addiu      $v0, $v0, 0x1
    /* DC254 800EBA54 F43526AD */  sw         $a2, %lo(seedX)($t1)
    /* DC258 800EBA58 18004014 */  bnez       $v0, .L800EBABC
    /* DC25C 800EBA5C 140002AD */   sw        $v0, 0x14($t0)
    /* DC260 800EBA60 1000028D */  lw         $v0, 0x10($t0)
    /* DC264 800EBA64 00000000 */  nop
    /* DC268 800EBA68 01004224 */  addiu      $v0, $v0, 0x1
    /* DC26C 800EBA6C 13004014 */  bnez       $v0, .L800EBABC
    /* DC270 800EBA70 100002AD */   sw        $v0, 0x10($t0)
    /* DC274 800EBA74 0C00028D */  lw         $v0, 0xC($t0)
    /* DC278 800EBA78 00000000 */  nop
    /* DC27C 800EBA7C 01004224 */  addiu      $v0, $v0, 0x1
    /* DC280 800EBA80 0E004014 */  bnez       $v0, .L800EBABC
    /* DC284 800EBA84 0C0002AD */   sw        $v0, 0xC($t0)
    /* DC288 800EBA88 0800028D */  lw         $v0, 0x8($t0)
    /* DC28C 800EBA8C 00000000 */  nop
    /* DC290 800EBA90 01004224 */  addiu      $v0, $v0, 0x1
    /* DC294 800EBA94 09004014 */  bnez       $v0, .L800EBABC
    /* DC298 800EBA98 080002AD */   sw        $v0, 0x8($t0)
    /* DC29C 800EBA9C 0400028D */  lw         $v0, 0x4($t0)
    /* DC2A0 800EBAA0 00000000 */  nop
    /* DC2A4 800EBAA4 01004224 */  addiu      $v0, $v0, 0x1
    /* DC2A8 800EBAA8 04004014 */  bnez       $v0, .L800EBABC
    /* DC2AC 800EBAAC 040002AD */   sw        $v0, 0x4($t0)
    /* DC2B0 800EBAB0 0100C224 */  addiu      $v0, $a2, 0x1
    /* DC2B4 800EBAB4 F43522AD */  sw         $v0, %lo(seedX)($t1)
    /* DC2B8 800EBAB8 21304000 */  addu       $a2, $v0, $zero
  .L800EBABC:
    /* DC2BC 800EBABC 0800E003 */  jr         $ra
    /* DC2C0 800EBAC0 2110C000 */   addu      $v0, $a2, $zero
endlabel iSPCH_EACrandom
