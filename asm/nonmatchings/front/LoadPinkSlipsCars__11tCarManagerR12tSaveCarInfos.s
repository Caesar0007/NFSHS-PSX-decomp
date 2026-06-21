.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching LoadPinkSlipsCars__11tCarManagerR12tSaveCarInfos, 0xA4

glabel LoadPinkSlipsCars__11tCarManagerR12tSaveCarInfos
    /* 7368 80016B68 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 736C 80016B6C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 7370 80016B70 21888000 */  addu       $s1, $a0, $zero
    /* 7374 80016B74 1800B2AF */  sw         $s2, 0x18($sp)
    /* 7378 80016B78 2190A000 */  addu       $s2, $a1, $zero
    /* 737C 80016B7C 00340600 */  sll        $a2, $a2, 16
    /* 7380 80016B80 1000B0AF */  sw         $s0, 0x10($sp)
    /* 7384 80016B84 03840600 */  sra        $s0, $a2, 16
    /* 7388 80016B88 C0291000 */  sll        $a1, $s0, 7
    /* 738C 80016B8C 0801A524 */  addiu      $a1, $a1, 0x108
    /* 7390 80016B90 21204002 */  addu       $a0, $s2, $zero
    /* 7394 80016B94 21282502 */  addu       $a1, $s1, $a1
    /* 7398 80016B98 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 739C 80016B9C B798030C */  jal        blockmove
    /* 73A0 80016BA0 80000624 */   addiu     $a2, $zero, 0x80
    /* 73A4 80016BA4 0000228E */  lw         $v0, 0x0($s1)
    /* 73A8 80016BA8 00000000 */  nop
    /* 73AC 80016BAC 11004010 */  beqz       $v0, .L80016BF4
    /* 73B0 80016BB0 21280000 */   addu      $a1, $zero, $zero
    /* 73B4 80016BB4 40101000 */  sll        $v0, $s0, 1
    /* 73B8 80016BB8 21105000 */  addu       $v0, $v0, $s0
    /* 73BC 80016BBC 00310200 */  sll        $a2, $v0, 4
    /* 73C0 80016BC0 2118A600 */  addu       $v1, $a1, $a2
  .L80016BC4:
    /* 73C4 80016BC4 21204502 */  addu       $a0, $s2, $a1
    /* 73C8 80016BC8 80008290 */  lbu        $v0, 0x80($a0)
    /* 73CC 80016BCC 21182302 */  addu       $v1, $s1, $v1
    /* 73D0 80016BD0 680262A0 */  sb         $v0, 0x268($v1)
    /* 73D4 80016BD4 B0008290 */  lbu        $v0, 0xB0($a0)
    /* 73D8 80016BD8 00000000 */  nop
    /* 73DC 80016BDC C80262A0 */  sb         $v0, 0x2C8($v1)
    /* 73E0 80016BE0 0000228E */  lw         $v0, 0x0($s1)
    /* 73E4 80016BE4 0100A524 */  addiu      $a1, $a1, 0x1
    /* 73E8 80016BE8 2B10A200 */  sltu       $v0, $a1, $v0
    /* 73EC 80016BEC F5FF4014 */  bnez       $v0, .L80016BC4
    /* 73F0 80016BF0 2118A600 */   addu      $v1, $a1, $a2
  .L80016BF4:
    /* 73F4 80016BF4 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 73F8 80016BF8 1800B28F */  lw         $s2, 0x18($sp)
    /* 73FC 80016BFC 1400B18F */  lw         $s1, 0x14($sp)
    /* 7400 80016C00 1000B08F */  lw         $s0, 0x10($sp)
    /* 7404 80016C04 0800E003 */  jr         $ra
    /* 7408 80016C08 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel LoadPinkSlipsCars__11tCarManagerR12tSaveCarInfos
