.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8002A084, 0x298

glabel func_8002A084
    /* 1A884 8002A084 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 1A888 8002A088 1800B2AF */  sw         $s2, 0x18($sp)
    /* 1A88C 8002A08C 2190A000 */  addu       $s2, $a1, $zero
    /* 1A890 8002A090 2400BFAF */  sw         $ra, 0x24($sp)
    /* 1A894 8002A094 2000B4AF */  sw         $s4, 0x20($sp)
    /* 1A898 8002A098 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 1A89C 8002A09C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 1A8A0 8002A0A0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1A8A4 8002A0A4 5802428E */  lw         $v0, 0x258($s2)
    /* 1A8A8 8002A0A8 00000000 */  nop
    /* 1A8AC 8002A0AC 11004010 */  beqz       $v0, .L8002A0F4
    /* 1A8B0 8002A0B0 21888000 */   addu      $s1, $a0, $zero
    /* 1A8B4 8002A0B4 25000224 */  addiu      $v0, $zero, 0x25
    /* 1A8B8 8002A0B8 000022AE */  sw         $v0, 0x0($s1)
    /* 1A8BC 8002A0BC 5802428E */  lw         $v0, 0x258($s2)
    /* 1A8C0 8002A0C0 00000000 */  nop
    /* 1A8C4 8002A0C4 0A004290 */  lbu        $v0, 0xA($v0)
    /* 1A8C8 8002A0C8 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A8CC 8002A0CC 000022AE */  sw         $v0, 0x0($s1)
    /* 1A8D0 8002A0D0 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A8D4 8002A0D4 26000224 */  addiu      $v0, $zero, 0x26
    /* 1A8D8 8002A0D8 000022AE */  sw         $v0, 0x0($s1)
    /* 1A8DC 8002A0DC 5802428E */  lw         $v0, 0x258($s2)
    /* 1A8E0 8002A0E0 00000000 */  nop
    /* 1A8E4 8002A0E4 08004294 */  lhu        $v0, 0x8($v0)
    /* 1A8E8 8002A0E8 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A8EC 8002A0EC 46A80008 */  j          .L8002A118
    /* 1A8F0 8002A0F0 000022AE */   sw        $v0, 0x0($s1)
  .L8002A0F4:
    /* 1A8F4 8002A0F4 25000224 */  addiu      $v0, $zero, 0x25
    /* 1A8F8 8002A0F8 000022AE */  sw         $v0, 0x0($s1)
    /* 1A8FC 8002A0FC 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A900 8002A100 000020AE */  sw         $zero, 0x0($s1)
    /* 1A904 8002A104 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A908 8002A108 26000224 */  addiu      $v0, $zero, 0x26
    /* 1A90C 8002A10C 000022AE */  sw         $v0, 0x0($s1)
    /* 1A910 8002A110 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A914 8002A114 000020AE */  sw         $zero, 0x0($s1)
  .L8002A118:
    /* 1A918 8002A118 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A91C 8002A11C 52024286 */  lh         $v0, 0x252($s2)
    /* 1A920 8002A120 00000000 */  nop
    /* 1A924 8002A124 6F004018 */  blez       $v0, .L8002A2E4
    /* 1A928 8002A128 21980000 */   addu      $s3, $zero, $zero
    /* 1A92C 8002A12C 01001424 */  addiu      $s4, $zero, 0x1
  .L8002A130:
    /* 1A930 8002A130 1180043C */  lui        $a0, %hi(carManager)
    /* 1A934 8002A134 00841300 */  sll        $s0, $s3, 16
    /* 1A938 8002A138 43831000 */  sra        $s0, $s0, 13
    /* 1A93C 8002A13C 21805002 */  addu       $s0, $s2, $s0
    /* 1A940 8002A140 60020586 */  lh         $a1, 0x260($s0)
    /* 1A944 8002A144 9358000C */  jal        GetCarFromID__11tCarManagers
    /* 1A948 8002A148 74428424 */   addiu     $a0, $a0, %lo(carManager)
    /* 1A94C 8002A14C 04010324 */  addiu      $v1, $zero, 0x104
    /* 1A950 8002A150 000023AE */  sw         $v1, 0x0($s1)
    /* 1A954 8002A154 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A958 8002A158 01006426 */  addiu      $a0, $s3, 0x1
    /* 1A95C 8002A15C 21988000 */  addu       $s3, $a0, $zero
    /* 1A960 8002A160 04004386 */  lh         $v1, 0x4($s2)
    /* 1A964 8002A164 00240400 */  sll        $a0, $a0, 16
    /* 1A968 8002A168 000023AE */  sw         $v1, 0x0($s1)
    /* 1A96C 8002A16C 01004290 */  lbu        $v0, 0x1($v0)
    /* 1A970 8002A170 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A974 8002A174 000022AE */  sw         $v0, 0x0($s1)
    /* 1A978 8002A178 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A97C 8002A17C 06010224 */  addiu      $v0, $zero, 0x106
    /* 1A980 8002A180 000022AE */  sw         $v0, 0x0($s1)
    /* 1A984 8002A184 04004286 */  lh         $v0, 0x4($s2)
    /* 1A988 8002A188 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A98C 8002A18C 000022AE */  sw         $v0, 0x0($s1)
    /* 1A990 8002A190 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A994 8002A194 000034AE */  sw         $s4, 0x0($s1)
    /* 1A998 8002A198 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A99C 8002A19C 0A010224 */  addiu      $v0, $zero, 0x10A
    /* 1A9A0 8002A1A0 000022AE */  sw         $v0, 0x0($s1)
    /* 1A9A4 8002A1A4 04004286 */  lh         $v0, 0x4($s2)
    /* 1A9A8 8002A1A8 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A9AC 8002A1AC 000022AE */  sw         $v0, 0x0($s1)
    /* 1A9B0 8002A1B0 64020292 */  lbu        $v0, 0x264($s0)
    /* 1A9B4 8002A1B4 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A9B8 8002A1B8 000022AE */  sw         $v0, 0x0($s1)
    /* 1A9BC 8002A1BC 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A9C0 8002A1C0 0B010224 */  addiu      $v0, $zero, 0x10B
    /* 1A9C4 8002A1C4 000022AE */  sw         $v0, 0x0($s1)
    /* 1A9C8 8002A1C8 04004286 */  lh         $v0, 0x4($s2)
    /* 1A9CC 8002A1CC 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A9D0 8002A1D0 000022AE */  sw         $v0, 0x0($s1)
    /* 1A9D4 8002A1D4 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A9D8 8002A1D8 000020AE */  sw         $zero, 0x0($s1)
    /* 1A9DC 8002A1DC 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A9E0 8002A1E0 05010224 */  addiu      $v0, $zero, 0x105
    /* 1A9E4 8002A1E4 000022AE */  sw         $v0, 0x0($s1)
    /* 1A9E8 8002A1E8 04004286 */  lh         $v0, 0x4($s2)
    /* 1A9EC 8002A1EC 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A9F0 8002A1F0 000022AE */  sw         $v0, 0x0($s1)
    /* 1A9F4 8002A1F4 04003126 */  addiu      $s1, $s1, 0x4
    /* 1A9F8 8002A1F8 02000224 */  addiu      $v0, $zero, 0x2
    /* 1A9FC 8002A1FC 000022AE */  sw         $v0, 0x0($s1)
    /* 1AA00 8002A200 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AA04 8002A204 18010224 */  addiu      $v0, $zero, 0x118
    /* 1AA08 8002A208 000022AE */  sw         $v0, 0x0($s1)
    /* 1AA0C 8002A20C 04004286 */  lh         $v0, 0x4($s2)
    /* 1AA10 8002A210 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AA14 8002A214 000022AE */  sw         $v0, 0x0($s1)
    /* 1AA18 8002A218 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AA1C 8002A21C 000020AE */  sw         $zero, 0x0($s1)
    /* 1AA20 8002A220 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AA24 8002A224 0C010224 */  addiu      $v0, $zero, 0x10C
    /* 1AA28 8002A228 000022AE */  sw         $v0, 0x0($s1)
    /* 1AA2C 8002A22C 04004286 */  lh         $v0, 0x4($s2)
    /* 1AA30 8002A230 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AA34 8002A234 000022AE */  sw         $v0, 0x0($s1)
    /* 1AA38 8002A238 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AA3C 8002A23C 000034AE */  sw         $s4, 0x0($s1)
    /* 1AA40 8002A240 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AA44 8002A244 25010224 */  addiu      $v0, $zero, 0x125
    /* 1AA48 8002A248 000022AE */  sw         $v0, 0x0($s1)
    /* 1AA4C 8002A24C 04004286 */  lh         $v0, 0x4($s2)
    /* 1AA50 8002A250 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AA54 8002A254 000022AE */  sw         $v0, 0x0($s1)
    /* 1AA58 8002A258 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AA5C 8002A25C 000020AE */  sw         $zero, 0x0($s1)
    /* 1AA60 8002A260 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AA64 8002A264 10010224 */  addiu      $v0, $zero, 0x110
    /* 1AA68 8002A268 000022AE */  sw         $v0, 0x0($s1)
    /* 1AA6C 8002A26C 04004286 */  lh         $v0, 0x4($s2)
    /* 1AA70 8002A270 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AA74 8002A274 000022AE */  sw         $v0, 0x0($s1)
    /* 1AA78 8002A278 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AA7C 8002A27C 000020AE */  sw         $zero, 0x0($s1)
    /* 1AA80 8002A280 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AA84 8002A284 12010224 */  addiu      $v0, $zero, 0x112
    /* 1AA88 8002A288 000022AE */  sw         $v0, 0x0($s1)
    /* 1AA8C 8002A28C 04004286 */  lh         $v0, 0x4($s2)
    /* 1AA90 8002A290 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AA94 8002A294 000022AE */  sw         $v0, 0x0($s1)
    /* 1AA98 8002A298 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AA9C 8002A29C 000020AE */  sw         $zero, 0x0($s1)
    /* 1AAA0 8002A2A0 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AAA4 8002A2A4 0D010224 */  addiu      $v0, $zero, 0x10D
    /* 1AAA8 8002A2A8 000022AE */  sw         $v0, 0x0($s1)
    /* 1AAAC 8002A2AC 04004286 */  lh         $v0, 0x4($s2)
    /* 1AAB0 8002A2B0 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AAB4 8002A2B4 000022AE */  sw         $v0, 0x0($s1)
    /* 1AAB8 8002A2B8 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AABC 8002A2BC 000020AE */  sw         $zero, 0x0($s1)
    /* 1AAC0 8002A2C0 04004296 */  lhu        $v0, 0x4($s2)
    /* 1AAC4 8002A2C4 03240400 */  sra        $a0, $a0, 16
    /* 1AAC8 8002A2C8 01004224 */  addiu      $v0, $v0, 0x1
    /* 1AACC 8002A2CC 040042A6 */  sh         $v0, 0x4($s2)
    /* 1AAD0 8002A2D0 52024286 */  lh         $v0, 0x252($s2)
    /* 1AAD4 8002A2D4 00000000 */  nop
    /* 1AAD8 8002A2D8 2A208200 */  slt        $a0, $a0, $v0
    /* 1AADC 8002A2DC 94FF8014 */  bnez       $a0, .L8002A130
    /* 1AAE0 8002A2E0 04003126 */   addiu     $s1, $s1, 0x4
  .L8002A2E4:
    /* 1AAE4 8002A2E4 25000224 */  addiu      $v0, $zero, 0x25
    /* 1AAE8 8002A2E8 000022AE */  sw         $v0, 0x0($s1)
    /* 1AAEC 8002A2EC 04003126 */  addiu      $s1, $s1, 0x4
    /* 1AAF0 8002A2F0 54024386 */  lh         $v1, 0x254($s2)
    /* 1AAF4 8002A2F4 04002226 */  addiu      $v0, $s1, 0x4
    /* 1AAF8 8002A2F8 000023AE */  sw         $v1, 0x0($s1)
    /* 1AAFC 8002A2FC 2400BF8F */  lw         $ra, 0x24($sp)
    /* 1AB00 8002A300 2000B48F */  lw         $s4, 0x20($sp)
    /* 1AB04 8002A304 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 1AB08 8002A308 1800B28F */  lw         $s2, 0x18($sp)
    /* 1AB0C 8002A30C 1400B18F */  lw         $s1, 0x14($sp)
    /* 1AB10 8002A310 1000B08F */  lw         $s0, 0x10($sp)
    /* 1AB14 8002A314 0800E003 */  jr         $ra
    /* 1AB18 8002A318 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel func_8002A084
