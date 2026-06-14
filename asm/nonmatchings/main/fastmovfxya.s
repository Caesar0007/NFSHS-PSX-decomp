.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching fastmovfxya, 0x124

glabel fastmovfxya
    /* F6884 80106084 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* F6888 80106088 2140A000 */  addu       $t0, $a1, $zero
    /* F688C 8010608C 2148C000 */  addu       $t1, $a2, $zero
    /* F6890 80106090 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* F6894 80106094 1800B0AF */  sw         $s0, 0x18($sp)
    /* F6898 80106098 04008584 */  lh         $a1, 0x4($a0)
    /* F689C 8010609C 0C00838C */  lw         $v1, 0xC($a0)
    /* F68A0 801060A0 06008484 */  lh         $a0, 0x6($a0)
    /* F68A4 801060A4 00150300 */  sll        $v0, $v1, 20
    /* F68A8 801060A8 033D0200 */  sra        $a3, $v0, 20
    /* F68AC 801060AC 00310300 */  sll        $a2, $v1, 4
    /* F68B0 801060B0 1580023C */  lui        $v0, %hi(currentwindow)
    /* F68B4 801060B4 E4864A24 */  addiu      $t2, $v0, %lo(currentwindow)
    /* F68B8 801060B8 1800428D */  lw         $v0, 0x18($t2)
    /* F68BC 801060BC 00000000 */  nop
    /* F68C0 801060C0 23104800 */  subu       $v0, $v0, $t0
    /* F68C4 801060C4 04004018 */  blez       $v0, .L801060D8
    /* F68C8 801060C8 03350600 */   sra       $a2, $a2, 20
    /* F68CC 801060CC 21400201 */  addu       $t0, $t0, $v0
    /* F68D0 801060D0 2138E200 */  addu       $a3, $a3, $v0
    /* F68D4 801060D4 2328A200 */  subu       $a1, $a1, $v0
  .L801060D8:
    /* F68D8 801060D8 2000438D */  lw         $v1, 0x20($t2)
    /* F68DC 801060DC 21100501 */  addu       $v0, $t0, $a1
    /* F68E0 801060E0 23104300 */  subu       $v0, $v0, $v1
    /* F68E4 801060E4 02004018 */  blez       $v0, .L801060F0
    /* F68E8 801060E8 00000000 */   nop
    /* F68EC 801060EC 2328A200 */  subu       $a1, $a1, $v0
  .L801060F0:
    /* F68F0 801060F0 1C00428D */  lw         $v0, 0x1C($t2)
    /* F68F4 801060F4 00000000 */  nop
    /* F68F8 801060F8 23104900 */  subu       $v0, $v0, $t1
    /* F68FC 801060FC 04004018 */  blez       $v0, .L80106110
    /* F6900 80106100 00000000 */   nop
    /* F6904 80106104 21482201 */  addu       $t1, $t1, $v0
    /* F6908 80106108 2130C200 */  addu       $a2, $a2, $v0
    /* F690C 8010610C 23208200 */  subu       $a0, $a0, $v0
  .L80106110:
    /* F6910 80106110 2400438D */  lw         $v1, 0x24($t2)
    /* F6914 80106114 21102401 */  addu       $v0, $t1, $a0
    /* F6918 80106118 23104300 */  subu       $v0, $v0, $v1
    /* F691C 8010611C 02004018 */  blez       $v0, .L80106128
    /* F6920 80106120 00000000 */   nop
    /* F6924 80106124 23208200 */  subu       $a0, $a0, $v0
  .L80106128:
    /* F6928 80106128 1000A7A7 */  sh         $a3, 0x10($sp)
    /* F692C 8010612C 1200A6A7 */  sh         $a2, 0x12($sp)
    /* F6930 80106130 1400A5A7 */  sh         $a1, 0x14($sp)
    /* F6934 80106134 1800A018 */  blez       $a1, .L80106198
    /* F6938 80106138 1600A4A7 */   sh        $a0, 0x16($sp)
    /* F693C 8010613C 16008018 */  blez       $a0, .L80106198
    /* F6940 80106140 1000A527 */   addiu     $a1, $sp, 0x10
    /* F6944 80106144 1480103C */  lui        $s0, %hi(primptr)
    /* F6948 80106148 80DE108E */  lw         $s0, %lo(primptr)($s0)
    /* F694C 8010614C 0400468D */  lw         $a2, 0x4($t2)
    /* F6950 80106150 0800478D */  lw         $a3, 0x8($t2)
    /* F6954 80106154 18000226 */  addiu      $v0, $s0, 0x18
    /* F6958 80106158 21200002 */  addu       $a0, $s0, $zero
    /* F695C 8010615C 2130C800 */  addu       $a2, $a2, $t0
    /* F6960 80106160 1480013C */  lui        $at, %hi(primptr)
    /* F6964 80106164 80DE22AC */  sw         $v0, %lo(primptr)($at)
    /* F6968 80106168 A631040C */  jal        SetDrawMove
    /* F696C 8010616C 2138E900 */   addu      $a3, $a3, $t1
    /* F6970 80106170 1480023C */  lui        $v0, %hi(nextprim)
    /* F6974 80106174 78DE428C */  lw         $v0, %lo(nextprim)($v0)
    /* F6978 80106178 14800D3C */  lui        $t5, %hi(nextprim)
    /* F697C 8010617C 78DEAD8D */  lw         $t5, %lo(nextprim)($t5)
    /* F6980 80106180 02004E88 */  lwl        $t6, 0x2($v0)
    /* F6984 80106184 007A1000 */  sll        $t7, $s0, 8
    /* F6988 80106188 02000EAA */  swl        $t6, 0x2($s0)
    /* F698C 8010618C 02004FA8 */  swl        $t7, 0x2($v0)
    /* F6990 80106190 1480013C */  lui        $at, %hi(nextprim)
    /* F6994 80106194 78DE30AC */  sw         $s0, %lo(nextprim)($at)
  .L80106198:
    /* F6998 80106198 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* F699C 8010619C 1800B08F */  lw         $s0, 0x18($sp)
    /* F69A0 801061A0 0800E003 */  jr         $ra
    /* F69A4 801061A4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel fastmovfxya
