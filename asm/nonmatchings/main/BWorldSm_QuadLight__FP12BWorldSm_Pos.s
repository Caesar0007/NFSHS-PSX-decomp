.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching BWorldSm_QuadLight__FP12BWorldSm_Pos, 0x190

glabel BWorldSm_QuadLight__FP12BWorldSm_Pos
    /* 70644 8007FE44 77008380 */  lb         $v1, 0x77($a0)
    /* 70648 8007FE48 02000224 */  addiu      $v0, $zero, 0x2
    /* 7064C 8007FE4C 04006210 */  beq        $v1, $v0, .L8007FE60
    /* 70650 8007FE50 D8FFBD27 */   addiu     $sp, $sp, -0x28
    /* 70654 8007FE54 7F00023C */  lui        $v0, (0x7F7F7F >> 16)
    /* 70658 8007FE58 F3FF0108 */  j          .L8007FFCC
    /* 7065C 8007FE5C 7F7F4234 */   ori       $v0, $v0, (0x7F7F7F & 0xFFFF)
  .L8007FE60:
    /* 70660 8007FE60 7C00828C */  lw         $v0, 0x7C($a0)
    /* 70664 8007FE64 02008684 */  lh         $a2, 0x2($a0)
    /* 70668 8007FE68 75008490 */  lbu        $a0, 0x75($a0)
    /* 7066C 8007FE6C 00004390 */  lbu        $v1, 0x0($v0)
    /* 70670 8007FE70 01004590 */  lbu        $a1, 0x1($v0)
    /* 70674 8007FE74 C0100400 */  sll        $v0, $a0, 3
    /* 70678 8007FE78 23104400 */  subu       $v0, $v0, $a0
    /* 7067C 8007FE7C 00110200 */  sll        $v0, $v0, 4
    /* 70680 8007FE80 1480043C */  lui        $a0, %hi(Track_chunkList)
    /* 70684 8007FE84 B8D4848C */  lw         $a0, %lo(Track_chunkList)($a0)
    /* 70688 8007FE88 21186600 */  addu       $v1, $v1, $a2
    /* 7068C 8007FE8C 21104400 */  addu       $v0, $v0, $a0
    /* 70690 8007FE90 2128A600 */  addu       $a1, $a1, $a2
    /* 70694 8007FE94 C0180300 */  sll        $v1, $v1, 3
    /* 70698 8007FE98 C0280500 */  sll        $a1, $a1, 3
    /* 7069C 8007FE9C 6C00428C */  lw         $v0, 0x6C($v0)
    /* 706A0 8007FEA0 1480063C */  lui        $a2, %hi(Chunk_lightTable)
    /* 706A4 8007FEA4 18C8C68C */  lw         $a2, %lo(Chunk_lightTable)($a2)
    /* 706A8 8007FEA8 04004224 */  addiu      $v0, $v0, 0x4
    /* 706AC 8007FEAC 21186200 */  addu       $v1, $v1, $v0
    /* 706B0 8007FEB0 2128A200 */  addu       $a1, $a1, $v0
    /* 706B4 8007FEB4 0E006484 */  lh         $a0, 0xE($v1)
    /* 706B8 8007FEB8 06006294 */  lhu        $v0, 0x6($v1)
    /* 706BC 8007FEBC 0600A394 */  lhu        $v1, 0x6($a1)
    /* 706C0 8007FEC0 0E00A594 */  lhu        $a1, 0xE($a1)
    /* 706C4 8007FEC4 80200400 */  sll        $a0, $a0, 2
    /* 706C8 8007FEC8 21208600 */  addu       $a0, $a0, $a2
    /* 706CC 8007FECC 00140200 */  sll        $v0, $v0, 16
    /* 706D0 8007FED0 83130200 */  sra        $v0, $v0, 14
    /* 706D4 8007FED4 001C0300 */  sll        $v1, $v1, 16
    /* 706D8 8007FED8 03008788 */  lwl        $a3, 0x3($a0)
    /* 706DC 8007FEDC 00008798 */  lwr        $a3, 0x0($a0)
    /* 706E0 8007FEE0 00000000 */  nop
    /* 706E4 8007FEE4 0B00A7AB */  swl        $a3, 0xB($sp)
    /* 706E8 8007FEE8 0800A7BB */  swr        $a3, 0x8($sp)
    /* 706EC 8007FEEC 1480043C */  lui        $a0, %hi(Chunk_lightTable)
    /* 706F0 8007FEF0 18C8848C */  lw         $a0, %lo(Chunk_lightTable)($a0)
    /* 706F4 8007FEF4 831B0300 */  sra        $v1, $v1, 14
    /* 706F8 8007FEF8 21104400 */  addu       $v0, $v0, $a0
    /* 706FC 8007FEFC 03004788 */  lwl        $a3, 0x3($v0)
    /* 70700 8007FF00 00004798 */  lwr        $a3, 0x0($v0)
    /* 70704 8007FF04 00000000 */  nop
    /* 70708 8007FF08 1300A7AB */  swl        $a3, 0x13($sp)
    /* 7070C 8007FF0C 1000A7BB */  swr        $a3, 0x10($sp)
    /* 70710 8007FF10 1480023C */  lui        $v0, %hi(Chunk_lightTable)
    /* 70714 8007FF14 18C8428C */  lw         $v0, %lo(Chunk_lightTable)($v0)
    /* 70718 8007FF18 002C0500 */  sll        $a1, $a1, 16
    /* 7071C 8007FF1C 21186200 */  addu       $v1, $v1, $v0
    /* 70720 8007FF20 1480023C */  lui        $v0, %hi(Chunk_lightTable)
    /* 70724 8007FF24 18C8428C */  lw         $v0, %lo(Chunk_lightTable)($v0)
    /* 70728 8007FF28 832B0500 */  sra        $a1, $a1, 14
    /* 7072C 8007FF2C 03006788 */  lwl        $a3, 0x3($v1)
    /* 70730 8007FF30 00006798 */  lwr        $a3, 0x0($v1)
    /* 70734 8007FF34 00000000 */  nop
    /* 70738 8007FF38 1B00A7AB */  swl        $a3, 0x1B($sp)
    /* 7073C 8007FF3C 1800A7BB */  swr        $a3, 0x18($sp)
    /* 70740 8007FF40 2128A200 */  addu       $a1, $a1, $v0
    /* 70744 8007FF44 0300A788 */  lwl        $a3, 0x3($a1)
    /* 70748 8007FF48 0000A798 */  lwr        $a3, 0x0($a1)
    /* 7074C 8007FF4C 00000000 */  nop
    /* 70750 8007FF50 2300A7AB */  swl        $a3, 0x23($sp)
    /* 70754 8007FF54 2000A7BB */  swr        $a3, 0x20($sp)
    /* 70758 8007FF58 0800A293 */  lbu        $v0, 0x8($sp)
    /* 7075C 8007FF5C 1000A393 */  lbu        $v1, 0x10($sp)
    /* 70760 8007FF60 00000000 */  nop
    /* 70764 8007FF64 21104300 */  addu       $v0, $v0, $v1
    /* 70768 8007FF68 1800A393 */  lbu        $v1, 0x18($sp)
    /* 7076C 8007FF6C 2000A493 */  lbu        $a0, 0x20($sp)
    /* 70770 8007FF70 21104300 */  addu       $v0, $v0, $v1
    /* 70774 8007FF74 21104400 */  addu       $v0, $v0, $a0
    /* 70778 8007FF78 0900A393 */  lbu        $v1, 0x9($sp)
    /* 7077C 8007FF7C 1100A493 */  lbu        $a0, 0x11($sp)
    /* 70780 8007FF80 83100200 */  sra        $v0, $v0, 2
    /* 70784 8007FF84 0000A2A3 */  sb         $v0, 0x0($sp)
    /* 70788 8007FF88 1900A293 */  lbu        $v0, 0x19($sp)
    /* 7078C 8007FF8C 21186400 */  addu       $v1, $v1, $a0
    /* 70790 8007FF90 21186200 */  addu       $v1, $v1, $v0
    /* 70794 8007FF94 2100A493 */  lbu        $a0, 0x21($sp)
    /* 70798 8007FF98 0A00A293 */  lbu        $v0, 0xA($sp)
    /* 7079C 8007FF9C 21186400 */  addu       $v1, $v1, $a0
    /* 707A0 8007FFA0 1200A493 */  lbu        $a0, 0x12($sp)
    /* 707A4 8007FFA4 83180300 */  sra        $v1, $v1, 2
    /* 707A8 8007FFA8 0100A3A3 */  sb         $v1, 0x1($sp)
    /* 707AC 8007FFAC 1A00A393 */  lbu        $v1, 0x1A($sp)
    /* 707B0 8007FFB0 21104400 */  addu       $v0, $v0, $a0
    /* 707B4 8007FFB4 2200A493 */  lbu        $a0, 0x22($sp)
    /* 707B8 8007FFB8 21104300 */  addu       $v0, $v0, $v1
    /* 707BC 8007FFBC 21104400 */  addu       $v0, $v0, $a0
    /* 707C0 8007FFC0 83100200 */  sra        $v0, $v0, 2
    /* 707C4 8007FFC4 0200A2A3 */  sb         $v0, 0x2($sp)
    /* 707C8 8007FFC8 0000A28F */  lw         $v0, 0x0($sp)
  .L8007FFCC:
    /* 707CC 8007FFCC 0800E003 */  jr         $ra
    /* 707D0 8007FFD0 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel BWorldSm_QuadLight__FP12BWorldSm_Pos
