.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetTrackToRace__18tTournamentManagerR10tTrackInfo, 0xF8

glabel GetTrackToRace__18tTournamentManagerR10tTrackInfo
    /* 22E8C 8003268C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 22E90 80032690 1000B0AF */  sw         $s0, 0x10($sp)
    /* 22E94 80032694 21808000 */  addu       $s0, $a0, $zero
    /* 22E98 80032698 1400B1AF */  sw         $s1, 0x14($sp)
    /* 22E9C 8003269C 2188A000 */  addu       $s1, $a1, $zero
    /* 22EA0 800326A0 1800BFAF */  sw         $ra, 0x18($sp)
    /* 22EA4 800326A4 0400038E */  lw         $v1, 0x4($s0)
    /* 22EA8 800326A8 1800058E */  lw         $a1, 0x18($s0)
    /* 22EAC 800326AC 40100300 */  sll        $v0, $v1, 1
    /* 22EB0 800326B0 21104300 */  addu       $v0, $v0, $v1
    /* 22EB4 800326B4 80100200 */  sll        $v0, $v0, 2
    /* 22EB8 800326B8 2110A200 */  addu       $v0, $a1, $v0
    /* 22EBC 800326BC 02004390 */  lbu        $v1, 0x2($v0)
    /* 22EC0 800326C0 0800028E */  lw         $v0, 0x8($s0)
    /* 22EC4 800326C4 00000000 */  nop
    /* 22EC8 800326C8 21186200 */  addu       $v1, $v1, $v0
    /* 22ECC 800326CC 80100300 */  sll        $v0, $v1, 2
    /* 22ED0 800326D0 21104300 */  addu       $v0, $v0, $v1
    /* 22ED4 800326D4 80100200 */  sll        $v0, $v0, 2
    /* 22ED8 800326D8 21104300 */  addu       $v0, $v0, $v1
    /* 22EDC 800326DC 80100200 */  sll        $v0, $v0, 2
    /* 22EE0 800326E0 21104500 */  addu       $v0, $v0, $a1
    /* 22EE4 800326E4 26004290 */  lbu        $v0, 0x26($v0)
    /* 22EE8 800326E8 0C00038E */  lw         $v1, 0xC($s0)
    /* 22EEC 800326EC 28000624 */  addiu      $a2, $zero, 0x28
    /* 22EF0 800326F0 21104300 */  addu       $v0, $v0, $v1
    /* 22EF4 800326F4 80200200 */  sll        $a0, $v0, 2
    /* 22EF8 800326F8 21208200 */  addu       $a0, $a0, $v0
    /* 22EFC 800326FC C0200400 */  sll        $a0, $a0, 3
    /* 22F00 80032700 24158424 */  addiu      $a0, $a0, 0x1524
    /* 22F04 80032704 2120A400 */  addu       $a0, $a1, $a0
    /* 22F08 80032708 B798030C */  jal        blockmove
    /* 22F0C 8003270C 21282002 */   addu      $a1, $s1, $zero
    /* 22F10 80032710 0C00028E */  lw         $v0, 0xC($s0)
    /* 22F14 80032714 00000000 */  nop
    /* 22F18 80032718 21100202 */  addu       $v0, $s0, $v0
    /* 22F1C 8003271C D8004290 */  lbu        $v0, 0xD8($v0)
    /* 22F20 80032720 00000000 */  nop
    /* 22F24 80032724 010022A2 */  sb         $v0, 0x1($s1)
    /* 22F28 80032728 0C00028E */  lw         $v0, 0xC($s0)
    /* 22F2C 8003272C 00000000 */  nop
    /* 22F30 80032730 21100202 */  addu       $v0, $s0, $v0
    /* 22F34 80032734 E8004290 */  lbu        $v0, 0xE8($v0)
    /* 22F38 80032738 00000000 */  nop
    /* 22F3C 8003273C 020022A2 */  sb         $v0, 0x2($s1)
    /* 22F40 80032740 0C00028E */  lw         $v0, 0xC($s0)
    /* 22F44 80032744 00000000 */  nop
    /* 22F48 80032748 21100202 */  addu       $v0, $s0, $v0
    /* 22F4C 8003274C F8004290 */  lbu        $v0, 0xF8($v0)
    /* 22F50 80032750 00000000 */  nop
    /* 22F54 80032754 030022A2 */  sb         $v0, 0x3($s1)
    /* 22F58 80032758 0C00028E */  lw         $v0, 0xC($s0)
    /* 22F5C 8003275C 00000000 */  nop
    /* 22F60 80032760 21800202 */  addu       $s0, $s0, $v0
    /* 22F64 80032764 08010292 */  lbu        $v0, 0x108($s0)
    /* 22F68 80032768 00000000 */  nop
    /* 22F6C 8003276C 040022A2 */  sb         $v0, 0x4($s1)
    /* 22F70 80032770 1800BF8F */  lw         $ra, 0x18($sp)
    /* 22F74 80032774 1400B18F */  lw         $s1, 0x14($sp)
    /* 22F78 80032778 1000B08F */  lw         $s0, 0x10($sp)
    /* 22F7C 8003277C 0800E003 */  jr         $ra
    /* 22F80 80032780 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel GetTrackToRace__18tTournamentManagerR10tTrackInfo
