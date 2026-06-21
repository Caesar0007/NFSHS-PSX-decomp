.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FontUpsideDownBlit__FiiPviiP12charactertbli, 0x148

glabel FontUpsideDownBlit__FiiPviiP12charactertbli
    /* 3F7B4 8004EFB4 F8FFBD27 */  addiu      $sp, $sp, -0x8
    /* 3F7B8 8004EFB8 801F033C */  lui        $v1, (0x1F800004 >> 16)
    /* 3F7BC 8004EFBC 04006334 */  ori        $v1, $v1, (0x1F800004 & 0xFFFF)
    /* 3F7C0 8004EFC0 FF000B3C */  lui        $t3, (0xFFFFFF >> 16)
    /* 3F7C4 8004EFC4 FFFF6B35 */  ori        $t3, $t3, (0xFFFFFF & 0xFFFF)
    /* 3F7C8 8004EFC8 1C00A28F */  lw         $v0, 0x1C($sp)
    /* 3F7CC 8004EFCC 00FF0D3C */  lui        $t5, (0xFF000000 >> 16)
    /* 3F7D0 8004EFD0 0000B0AF */  sw         $s0, 0x0($sp)
    /* 3F7D4 8004EFD4 1800B08F */  lw         $s0, 0x18($sp)
    /* 3F7D8 8004EFD8 0000698C */  lw         $t1, 0x0($v1)
    /* 3F7DC 8004EFDC 02004F90 */  lbu        $t7, 0x2($v0)
    /* 3F7E0 8004EFE0 03004E90 */  lbu        $t6, 0x3($v0)
    /* 3F7E4 8004EFE4 0A004C80 */  lb         $t4, 0xA($v0)
    /* 3F7E8 8004EFE8 28002225 */  addiu      $v0, $t1, 0x28
    /* 3F7EC 8004EFEC 000062AC */  sw         $v0, 0x0($v1)
    /* 3F7F0 8004EFF0 0000238D */  lw         $v1, 0x0($t1)
    /* 3F7F4 8004EFF4 801F0A3C */  lui        $t2, (0x1F800000 >> 16)
    /* 3F7F8 8004EFF8 00004A8D */  lw         $t2, (0x1F800000 & 0xFFFF)($t2)
    /* 3F7FC 8004EFFC 0C00C88C */  lw         $t0, 0xC($a2)
    /* 3F800 8004F000 24186D00 */  and        $v1, $v1, $t5
    /* 3F804 8004F004 23C0AC00 */  subu       $t8, $a1, $t4
    /* 3F808 8004F008 2160CC01 */  addu       $t4, $t6, $t4
    /* 3F80C 8004F00C 00410800 */  sll        $t0, $t0, 4
    /* 3F810 8004F010 03450800 */  sra        $t0, $t0, 20
    /* 3F814 8004F014 21401001 */  addu       $t0, $t0, $s0
    /* 3F818 8004F018 FF000831 */  andi       $t0, $t0, 0xFF
    /* 3F81C 8004F01C 0000428D */  lw         $v0, 0x0($t2)
    /* 3F820 8004F020 FFFF0825 */  addiu      $t0, $t0, -0x1
    /* 3F824 8004F024 24104B00 */  and        $v0, $v0, $t3
    /* 3F828 8004F028 25186200 */  or         $v1, $v1, $v0
    /* 3F82C 8004F02C 24582B01 */  and        $t3, $t1, $t3
    /* 3F830 8004F030 1480023C */  lui        $v0, %hi(font_tint)
    /* 3F834 8004F034 000023AD */  sw         $v1, 0x0($t1)
    /* 3F838 8004F038 0000438D */  lw         $v1, 0x0($t2)
    /* 3F83C 8004F03C 5CD8428C */  lw         $v0, %lo(font_tint)($v0)
    /* 3F840 8004F040 24186D00 */  and        $v1, $v1, $t5
    /* 3F844 8004F044 25186B00 */  or         $v1, $v1, $t3
    /* 3F848 8004F048 000043AD */  sw         $v1, 0x0($t2)
    /* 3F84C 8004F04C 09000324 */  addiu      $v1, $zero, 0x9
    /* 3F850 8004F050 040022AD */  sw         $v0, 0x4($t1)
    /* 3F854 8004F054 2C000224 */  addiu      $v0, $zero, 0x2C
    /* 3F858 8004F058 030023A1 */  sb         $v1, 0x3($t1)
    /* 3F85C 8004F05C 05000327 */  addiu      $v1, $t8, 0x5
    /* 3F860 8004F060 070022A1 */  sb         $v0, 0x7($t1)
    /* 3F864 8004F064 1480023C */  lui        $v0, %hi(gFontClut)
    /* 3F868 8004F068 64D84294 */  lhu        $v0, %lo(gFontClut)($v0)
    /* 3F86C 8004F06C 23C06C00 */  subu       $t8, $v1, $t4
    /* 3F870 8004F070 0E0022A5 */  sh         $v0, 0xE($t1)
    /* 3F874 8004F074 0000C390 */  lbu        $v1, 0x0($a2)
    /* 3F878 8004F078 0C00C58C */  lw         $a1, 0xC($a2)
    /* 3F87C 8004F07C 2110EF00 */  addu       $v0, $a3, $t7
    /* 3F880 8004F080 0D0028A1 */  sb         $t0, 0xD($t1)
    /* 3F884 8004F084 150028A1 */  sb         $t0, 0x15($t1)
    /* 3F888 8004F088 21400E01 */  addu       $t0, $t0, $t6
    /* 3F88C 8004F08C 21700E03 */  addu       $t6, $t8, $t6
    /* 3F890 8004F090 21788F00 */  addu       $t7, $a0, $t7
    /* 3F894 8004F094 0C0027A1 */  sb         $a3, 0xC($t1)
    /* 3F898 8004F098 140022A1 */  sb         $v0, 0x14($t1)
    /* 3F89C 8004F09C 1C0027A1 */  sb         $a3, 0x1C($t1)
    /* 3F8A0 8004F0A0 1D0028A1 */  sb         $t0, 0x1D($t1)
    /* 3F8A4 8004F0A4 240022A1 */  sb         $v0, 0x24($t1)
    /* 3F8A8 8004F0A8 250028A1 */  sb         $t0, 0x25($t1)
    /* 3F8AC 8004F0AC 080024A5 */  sh         $a0, 0x8($t1)
    /* 3F8B0 8004F0B0 03006330 */  andi       $v1, $v1, 0x3
    /* 3F8B4 8004F0B4 C0190300 */  sll        $v1, $v1, 7
    /* 3F8B8 8004F0B8 02150500 */  srl        $v0, $a1, 20
    /* 3F8BC 8004F0BC 10004230 */  andi       $v0, $v0, 0x10
    /* 3F8C0 8004F0C0 25186200 */  or         $v1, $v1, $v0
    /* 3F8C4 8004F0C4 FF03A530 */  andi       $a1, $a1, 0x3FF
    /* 3F8C8 8004F0C8 83290500 */  sra        $a1, $a1, 6
    /* 3F8CC 8004F0CC 25186500 */  or         $v1, $v1, $a1
    /* 3F8D0 8004F0D0 160023A5 */  sh         $v1, 0x16($t1)
    /* 3F8D4 8004F0D4 0A002EA5 */  sh         $t6, 0xA($t1)
    /* 3F8D8 8004F0D8 10002FA5 */  sh         $t7, 0x10($t1)
    /* 3F8DC 8004F0DC 12002EA5 */  sh         $t6, 0x12($t1)
    /* 3F8E0 8004F0E0 180024A5 */  sh         $a0, 0x18($t1)
    /* 3F8E4 8004F0E4 1A0038A5 */  sh         $t8, 0x1A($t1)
    /* 3F8E8 8004F0E8 20002FA5 */  sh         $t7, 0x20($t1)
    /* 3F8EC 8004F0EC 220038A5 */  sh         $t8, 0x22($t1)
    /* 3F8F0 8004F0F0 0000B08F */  lw         $s0, 0x0($sp)
    /* 3F8F4 8004F0F4 0800E003 */  jr         $ra
    /* 3F8F8 8004F0F8 0800BD27 */   addiu     $sp, $sp, 0x8
endlabel FontUpsideDownBlit__FiiPviiP12charactertbli
    /* 3F8FC 8004F0FC 00000000 */  nop
