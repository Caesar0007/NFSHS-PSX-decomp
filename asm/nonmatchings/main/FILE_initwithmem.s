.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_initwithmem, 0xFC

glabel FILE_initwithmem
    /* DC478 800EBC78 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DC47C 800EBC7C 1400B1AF */  sw         $s1, 0x14($sp)
    /* DC480 800EBC80 2188A000 */  addu       $s1, $a1, $zero
    /* DC484 800EBC84 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* DC488 800EBC88 1800B2AF */  sw         $s2, 0x18($sp)
    /* DC48C 800EBC8C 02008014 */  bnez       $a0, .L800EBC98
    /* DC490 800EBC90 1000B0AF */   sw        $s0, 0x10($sp)
    /* DC494 800EBC94 18000424 */  addiu      $a0, $zero, 0x18
  .L800EBC98:
    /* DC498 800EBC98 02002016 */  bnez       $s1, .L800EBCA4
    /* DC49C 800EBC9C 00000000 */   nop
    /* DC4A0 800EBCA0 00081124 */  addiu      $s1, $zero, 0x800
  .L800EBCA4:
    /* DC4A4 800EBCA4 0200C014 */  bnez       $a2, .L800EBCB0
    /* DC4A8 800EBCA8 1480123C */   lui       $s2, %hi(gFileDevice)
    /* DC4AC 800EBCAC 0A000624 */  addiu      $a2, $zero, 0xA
  .L800EBCB0:
    /* DC4B0 800EBCB0 88EA428E */  lw         $v0, %lo(gFileDevice)($s2)
    /* DC4B4 800EBCB4 00000000 */  nop
    /* DC4B8 800EBCB8 27004014 */  bnez       $v0, .L800EBD58
    /* DC4BC 800EBCBC 88EA5026 */   addiu     $s0, $s2, %lo(gFileDevice)
    /* DC4C0 800EBCC0 21282002 */  addu       $a1, $s1, $zero
    /* DC4C4 800EBCC4 FF000224 */  addiu      $v0, $zero, 0xFF
    /* DC4C8 800EBCC8 88EA46AE */  sw         $a2, %lo(gFileDevice)($s2)
    /* DC4CC 800EBCCC 040004AE */  sw         $a0, 0x4($s0)
    /* DC4D0 800EBCD0 080002AE */  sw         $v0, 0x8($s0)
    /* DC4D4 800EBCD4 5DAF030C */  jal        FILE_overhead
    /* DC4D8 800EBCD8 180007AE */   sw        $a3, 0x18($s0)
    /* DC4DC 800EBCDC 1800048E */  lw         $a0, 0x18($s0)
    /* DC4E0 800EBCE0 E8C5030C */  jal        blockclear
    /* DC4E4 800EBCE4 21284000 */   addu      $a1, $v0, $zero
    /* DC4E8 800EBCE8 88EA438E */  lw         $v1, %lo(gFileDevice)($s2)
    /* DC4EC 800EBCEC 1480043C */  lui        $a0, %hi(disablecd)
    /* DC4F0 800EBCF0 58DC848C */  lw         $a0, %lo(disablecd)($a0)
    /* DC4F4 800EBCF4 40100300 */  sll        $v0, $v1, 1
    /* DC4F8 800EBCF8 21104300 */  addu       $v0, $v0, $v1
    /* DC4FC 800EBCFC 1800038E */  lw         $v1, 0x18($s0)
    /* DC500 800EBD00 00110200 */  sll        $v0, $v0, 4
    /* DC504 800EBD04 21186200 */  addu       $v1, $v1, $v0
    /* DC508 800EBD08 0F008014 */  bnez       $a0, .L800EBD48
    /* DC50C 800EBD0C 1C0003AE */   sw        $v1, 0x1C($s0)
    /* DC510 800EBD10 21282002 */  addu       $a1, $s1, $zero
    /* DC514 800EBD14 0F80073C */  lui        $a3, %hi(iFILE_CommandCompleteCallback)
    /* DC518 800EBD18 0400048E */  lw         $a0, 0x4($s0)
    /* DC51C 800EBD1C 20D0E724 */  addiu      $a3, $a3, %lo(iFILE_CommandCompleteCallback)
    /* DC520 800EBD20 80300400 */  sll        $a2, $a0, 2
    /* DC524 800EBD24 2130C400 */  addu       $a2, $a2, $a0
    /* DC528 800EBD28 80300600 */  sll        $a2, $a2, 2
    /* DC52C 800EBD2C 2330C400 */  subu       $a2, $a2, $a0
    /* DC530 800EBD30 80300600 */  sll        $a2, $a2, 2
    /* DC534 800EBD34 E5E8030C */  jal        CD_Init
    /* DC538 800EBD38 21306600 */   addu      $a2, $v1, $a2
    /* DC53C 800EBD3C 0100422C */  sltiu      $v0, $v0, 0x1
    /* DC540 800EBD40 1480013C */  lui        $at, %hi(disablecd)
    /* DC544 800EBD44 58DC22AC */  sw         $v0, %lo(disablecd)($at)
  .L800EBD48:
    /* DC548 800EBD48 8DCE030C */  jal        initfileio
    /* DC54C 800EBD4C 00000000 */   nop
    /* DC550 800EBD50 57AF0308 */  j          .L800EBD5C
    /* DC554 800EBD54 01000224 */   addiu     $v0, $zero, 0x1
  .L800EBD58:
    /* DC558 800EBD58 21100000 */  addu       $v0, $zero, $zero
  .L800EBD5C:
    /* DC55C 800EBD5C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* DC560 800EBD60 1800B28F */  lw         $s2, 0x18($sp)
    /* DC564 800EBD64 1400B18F */  lw         $s1, 0x14($sp)
    /* DC568 800EBD68 1000B08F */  lw         $s0, 0x10($sp)
    /* DC56C 800EBD6C 0800E003 */  jr         $ra
    /* DC570 800EBD70 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FILE_initwithmem
