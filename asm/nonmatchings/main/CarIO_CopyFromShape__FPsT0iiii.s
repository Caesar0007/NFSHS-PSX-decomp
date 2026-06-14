.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CarIO_CopyFromShape__FPsT0iiii, 0x1C4

glabel CarIO_CopyFromShape__FPsT0iiii
    /* AC7F0 800BBFF0 83400600 */  sra        $t0, $a2, 2
    /* AC7F4 800BBFF4 0300C630 */  andi       $a2, $a2, 0x3
    /* AC7F8 800BBFF8 1000B88F */  lw         $t8, 0x10($sp)
    /* AC7FC 800BBFFC 1400A98F */  lw         $t1, 0x14($sp)
    /* AC800 800BC000 0200C010 */  beqz       $a2, .L800BC00C
    /* AC804 800BC004 83181800 */   sra       $v1, $t8, 2
    /* AC808 800BC008 01000825 */  addiu      $t0, $t0, 0x1
  .L800BC00C:
    /* AC80C 800BC00C 40100900 */  sll        $v0, $t1, 1
    /* AC810 800BC010 21104900 */  addu       $v0, $v0, $t1
    /* AC814 800BC014 80100200 */  sll        $v0, $v0, 2
    /* AC818 800BC018 21186200 */  addu       $v1, $v1, $v0
    /* AC81C 800BC01C 40180300 */  sll        $v1, $v1, 1
    /* AC820 800BC020 2128A300 */  addu       $a1, $a1, $v1
    /* AC824 800BC024 FFFF0D34 */  ori        $t5, $zero, 0xFFFF
    /* AC828 800BC028 0200C014 */  bnez       $a2, .L800BC034
    /* AC82C 800BC02C 2160A001 */   addu      $t4, $t5, $zero
    /* AC830 800BC030 21600000 */  addu       $t4, $zero, $zero
  .L800BC034:
    /* AC834 800BC034 FFFFC624 */  addiu      $a2, $a2, -0x1
    /* AC838 800BC038 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* AC83C 800BC03C 0500C210 */  beq        $a2, $v0, .L800BC054
    /* AC840 800BC040 21780000 */   addu      $t7, $zero, $zero
  .L800BC044:
    /* AC844 800BC044 FFFFC624 */  addiu      $a2, $a2, -0x1
    /* AC848 800BC048 FEFFC214 */  bne        $a2, $v0, .L800BC044
    /* AC84C 800BC04C 00610C00 */   sll       $t4, $t4, 4
    /* AC850 800BC050 21780000 */  addu       $t7, $zero, $zero
  .L800BC054:
    /* AC854 800BC054 03000633 */  andi       $a2, $t8, 0x3
    /* AC858 800BC058 FFFF0924 */  addiu      $t1, $zero, -0x1
  .L800BC05C:
    /* AC85C 800BC05C FFFFC624 */  addiu      $a2, $a2, -0x1
    /* AC860 800BC060 0800C910 */  beq        $a2, $t1, .L800BC084
    /* AC864 800BC064 00110F00 */   sll       $v0, $t7, 4
    /* AC868 800BC068 0F004F34 */  ori        $t7, $v0, 0xF
    /* AC86C 800BC06C 00F08331 */  andi       $v1, $t4, 0xF000
    /* AC870 800BC070 00610C00 */  sll        $t4, $t4, 4
    /* AC874 800BC074 021B0300 */  srl        $v1, $v1, 12
    /* AC878 800BC078 00110D00 */  sll        $v0, $t5, 4
    /* AC87C 800BC07C 17F00208 */  j          .L800BC05C
    /* AC880 800BC080 25684300 */   or        $t5, $v0, $v1
  .L800BC084:
    /* AC884 800BC084 FFFFA331 */  andi       $v1, $t5, 0xFFFF
    /* AC888 800BC088 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* AC88C 800BC08C 03006210 */  beq        $v1, $v0, .L800BC09C
    /* AC890 800BC090 FFFF0E24 */   addiu     $t6, $zero, -0x1
    /* AC894 800BC094 2160A001 */  addu       $t4, $t5, $zero
    /* AC898 800BC098 01000825 */  addiu      $t0, $t0, 0x1
  .L800BC09C:
    /* AC89C 800BC09C 21C80E01 */  addu       $t9, $t0, $t6
  .L800BC0A0:
    /* AC8A0 800BC0A0 FFFFE724 */  addiu      $a3, $a3, -0x1
    /* AC8A4 800BC0A4 4100EE10 */  beq        $a3, $t6, .L800BC1AC
    /* AC8A8 800BC0A8 21500000 */   addu      $t2, $zero, $zero
    /* AC8AC 800BC0AC 00008894 */  lhu        $t0, 0x0($a0)
    /* AC8B0 800BC0B0 02008424 */  addiu      $a0, $a0, 0x2
    /* AC8B4 800BC0B4 03000633 */  andi       $a2, $t8, 0x3
  .L800BC0B8:
    /* AC8B8 800BC0B8 FFFFC624 */  addiu      $a2, $a2, -0x1
    /* AC8BC 800BC0BC 0600CE10 */  beq        $a2, $t6, .L800BC0D8
    /* AC8C0 800BC0C0 00F00331 */   andi      $v1, $t0, 0xF000
    /* AC8C4 800BC0C4 00410800 */  sll        $t0, $t0, 4
    /* AC8C8 800BC0C8 021B0300 */  srl        $v1, $v1, 12
    /* AC8CC 800BC0CC 00110A00 */  sll        $v0, $t2, 4
    /* AC8D0 800BC0D0 2EF00208 */  j          .L800BC0B8
    /* AC8D4 800BC0D4 25504300 */   or        $t2, $v0, $v1
  .L800BC0D8:
    /* AC8D8 800BC0D8 01000B24 */  addiu      $t3, $zero, 0x1
    /* AC8DC 800BC0DC 0000A294 */  lhu        $v0, 0x0($a1)
    /* AC8E0 800BC0E0 0200A924 */  addiu      $t1, $a1, 0x2
    /* AC8E4 800BC0E4 24104F00 */  and        $v0, $v0, $t7
    /* AC8E8 800BC0E8 25104800 */  or         $v0, $v0, $t0
    /* AC8EC 800BC0EC 0000A2A4 */  sh         $v0, 0x0($a1)
  .L800BC0F0:
    /* AC8F0 800BC0F0 2A107901 */  slt        $v0, $t3, $t9
    /* AC8F4 800BC0F4 13004010 */  beqz       $v0, .L800BC144
    /* AC8F8 800BC0F8 03000633 */   andi      $a2, $t8, 0x3
    /* AC8FC 800BC0FC 00002AA5 */  sh         $t2, 0x0($t1)
    /* AC900 800BC100 00008894 */  lhu        $t0, 0x0($a0)
    /* AC904 800BC104 02008424 */  addiu      $a0, $a0, 0x2
    /* AC908 800BC108 21500000 */  addu       $t2, $zero, $zero
  .L800BC10C:
    /* AC90C 800BC10C FFFFC624 */  addiu      $a2, $a2, -0x1
    /* AC910 800BC110 0600CE10 */  beq        $a2, $t6, .L800BC12C
    /* AC914 800BC114 00F00331 */   andi      $v1, $t0, 0xF000
    /* AC918 800BC118 00410800 */  sll        $t0, $t0, 4
    /* AC91C 800BC11C 021B0300 */  srl        $v1, $v1, 12
    /* AC920 800BC120 00110A00 */  sll        $v0, $t2, 4
    /* AC924 800BC124 43F00208 */  j          .L800BC10C
    /* AC928 800BC128 25504300 */   or        $t2, $v0, $v1
  .L800BC12C:
    /* AC92C 800BC12C 00002295 */  lhu        $v0, 0x0($t1)
    /* AC930 800BC130 01006B25 */  addiu      $t3, $t3, 0x1
    /* AC934 800BC134 25104800 */  or         $v0, $v0, $t0
    /* AC938 800BC138 000022A5 */  sh         $v0, 0x0($t1)
    /* AC93C 800BC13C 3CF00208 */  j          .L800BC0F0
    /* AC940 800BC140 02002925 */   addiu     $t1, $t1, 0x2
  .L800BC144:
    /* AC944 800BC144 40180B00 */  sll        $v1, $t3, 1
    /* AC948 800BC148 21186500 */  addu       $v1, $v1, $a1
    /* AC94C 800BC14C 00006294 */  lhu        $v0, 0x0($v1)
    /* AC950 800BC150 00000000 */  nop
    /* AC954 800BC154 24104C00 */  and        $v0, $v0, $t4
    /* AC958 800BC158 25104A00 */  or         $v0, $v0, $t2
    /* AC95C 800BC15C 000062A4 */  sh         $v0, 0x0($v1)
    /* AC960 800BC160 FFFFA331 */  andi       $v1, $t5, 0xFFFF
    /* AC964 800BC164 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* AC968 800BC168 0E006214 */  bne        $v1, $v0, .L800BC1A4
    /* AC96C 800BC16C FFFFC624 */   addiu     $a2, $a2, -0x1
    /* AC970 800BC170 00008894 */  lhu        $t0, 0x0($a0)
    /* AC974 800BC174 0500CE10 */  beq        $a2, $t6, .L800BC18C
    /* AC978 800BC178 02008424 */   addiu     $a0, $a0, 0x2
    /* AC97C 800BC17C FFFF0224 */  addiu      $v0, $zero, -0x1
  .L800BC180:
    /* AC980 800BC180 FFFFC624 */  addiu      $a2, $a2, -0x1
    /* AC984 800BC184 FEFFC214 */  bne        $a2, $v0, .L800BC180
    /* AC988 800BC188 00410800 */   sll       $t0, $t0, 4
  .L800BC18C:
    /* AC98C 800BC18C 40180B00 */  sll        $v1, $t3, 1
    /* AC990 800BC190 21186500 */  addu       $v1, $v1, $a1
    /* AC994 800BC194 00006294 */  lhu        $v0, 0x0($v1)
    /* AC998 800BC198 00000000 */  nop
    /* AC99C 800BC19C 25104800 */  or         $v0, $v0, $t0
    /* AC9A0 800BC1A0 000062A4 */  sh         $v0, 0x0($v1)
  .L800BC1A4:
    /* AC9A4 800BC1A4 28F00208 */  j          .L800BC0A0
    /* AC9A8 800BC1A8 1800A524 */   addiu     $a1, $a1, 0x18
  .L800BC1AC:
    /* AC9AC 800BC1AC 0800E003 */  jr         $ra
    /* AC9B0 800BC1B0 00000000 */   nop
endlabel CarIO_CopyFromShape__FPsT0iiii
