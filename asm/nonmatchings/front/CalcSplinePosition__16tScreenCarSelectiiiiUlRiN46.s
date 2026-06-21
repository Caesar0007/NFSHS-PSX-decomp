.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CalcSplinePosition__16tScreenCarSelectiiiiUlRiN46, 0x2C0

glabel CalcSplinePosition__16tScreenCarSelectiiiiUlRiN46
    /* 2C020 8003B820 58FFBD27 */  addiu      $sp, $sp, -0xA8
    /* 2C024 8003B824 BC00A48F */  lw         $a0, 0xBC($sp)
    /* 2C028 8003B828 8400B1AF */  sw         $s1, 0x84($sp)
    /* 2C02C 8003B82C 2188A000 */  addu       $s1, $a1, $zero
    /* 2C030 8003B830 8C00B3AF */  sw         $s3, 0x8C($sp)
    /* 2C034 8003B834 2198C000 */  addu       $s3, $a2, $zero
    /* 2C038 8003B838 9400B5AF */  sw         $s5, 0x94($sp)
    /* 2C03C 8003B83C 21A8E000 */  addu       $s5, $a3, $zero
    /* 2C040 8003B840 9800B6AF */  sw         $s6, 0x98($sp)
    /* 2C044 8003B844 B800B68F */  lw         $s6, 0xB8($sp)
    /* 2C048 8003B848 5802053C */  lui        $a1, (0x2580000 >> 16)
    /* 2C04C 8003B84C A000BFAF */  sw         $ra, 0xA0($sp)
    /* 2C050 8003B850 9C00B7AF */  sw         $s7, 0x9C($sp)
    /* 2C054 8003B854 9000B4AF */  sw         $s4, 0x90($sp)
    /* 2C058 8003B858 8800B2AF */  sw         $s2, 0x88($sp)
    /* 2C05C 8003B85C 8000B0AF */  sw         $s0, 0x80($sp)
    /* 2C060 8003B860 0191030C */  jal        rdiv
    /* 2C064 8003B864 00240400 */   sll       $a0, $a0, 16
    /* 2C068 8003B868 21204000 */  addu       $a0, $v0, $zero
    /* 2C06C 8003B86C 21288000 */  addu       $a1, $a0, $zero
    /* 2C070 8003B870 CA90030C */  jal        fixedmult
    /* 2C074 8003B874 1800A4AF */   sw        $a0, 0x18($sp)
    /* 2C078 8003B878 1800A58F */  lw         $a1, 0x18($sp)
    /* 2C07C 8003B87C 21204000 */  addu       $a0, $v0, $zero
    /* 2C080 8003B880 CA90030C */  jal        fixedmult
    /* 2C084 8003B884 1400A4AF */   sw        $a0, 0x14($sp)
    /* 2C088 8003B888 21300000 */  addu       $a2, $zero, $zero
    /* 2C08C 8003B88C 2000AB27 */  addiu      $t3, $sp, 0x20
    /* 2C090 8003B890 0580033C */  lui        $v1, %hi(D_80051E78)
    /* 2C094 8003B894 781E6524 */  addiu      $a1, $v1, %lo(D_80051E78)
    /* 2C098 8003B898 80181100 */  sll        $v1, $s1, 2
    /* 2C09C 8003B89C 21187100 */  addu       $v1, $v1, $s1
    /* 2C0A0 8003B8A0 80500300 */  sll        $t2, $v1, 2
    /* 2C0A4 8003B8A4 80181300 */  sll        $v1, $s3, 2
    /* 2C0A8 8003B8A8 21187300 */  addu       $v1, $v1, $s3
    /* 2C0AC 8003B8AC 80480300 */  sll        $t1, $v1, 2
    /* 2C0B0 8003B8B0 80181500 */  sll        $v1, $s5, 2
    /* 2C0B4 8003B8B4 21187500 */  addu       $v1, $v1, $s5
    /* 2C0B8 8003B8B8 80400300 */  sll        $t0, $v1, 2
    /* 2C0BC 8003B8BC 80181600 */  sll        $v1, $s6, 2
    /* 2C0C0 8003B8C0 21187600 */  addu       $v1, $v1, $s6
    /* 2C0C4 8003B8C4 80380300 */  sll        $a3, $v1, 2
    /* 2C0C8 8003B8C8 1000A2AF */  sw         $v0, 0x10($sp)
    /* 2C0CC 8003B8CC 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 2C0D0 8003B8D0 1C00A2AF */  sw         $v0, 0x1C($sp)
  .L8003B8D4:
    /* 2C0D4 8003B8D4 001C0600 */  sll        $v1, $a2, 16
    /* 2C0D8 8003B8D8 831B0300 */  sra        $v1, $v1, 14
    /* 2C0DC 8003B8DC 21106A00 */  addu       $v0, $v1, $t2
    /* 2C0E0 8003B8E0 21104500 */  addu       $v0, $v0, $a1
    /* 2C0E4 8003B8E4 0000428C */  lw         $v0, 0x0($v0)
    /* 2C0E8 8003B8E8 21206301 */  addu       $a0, $t3, $v1
    /* 2C0EC 8003B8EC 000082AC */  sw         $v0, 0x0($a0)
    /* 2C0F0 8003B8F0 21106900 */  addu       $v0, $v1, $t1
    /* 2C0F4 8003B8F4 21104500 */  addu       $v0, $v0, $a1
    /* 2C0F8 8003B8F8 0000428C */  lw         $v0, 0x0($v0)
    /* 2C0FC 8003B8FC 00000000 */  nop
    /* 2C100 8003B900 100082AC */  sw         $v0, 0x10($a0)
    /* 2C104 8003B904 21106800 */  addu       $v0, $v1, $t0
    /* 2C108 8003B908 21104500 */  addu       $v0, $v0, $a1
    /* 2C10C 8003B90C 21186700 */  addu       $v1, $v1, $a3
    /* 2C110 8003B910 0000428C */  lw         $v0, 0x0($v0)
    /* 2C114 8003B914 21186500 */  addu       $v1, $v1, $a1
    /* 2C118 8003B918 200082AC */  sw         $v0, 0x20($a0)
    /* 2C11C 8003B91C 0100C224 */  addiu      $v0, $a2, 0x1
    /* 2C120 8003B920 21304000 */  addu       $a2, $v0, $zero
    /* 2C124 8003B924 00140200 */  sll        $v0, $v0, 16
    /* 2C128 8003B928 03140200 */  sra        $v0, $v0, 16
    /* 2C12C 8003B92C 0000638C */  lw         $v1, 0x0($v1)
    /* 2C130 8003B930 04004228 */  slti       $v0, $v0, 0x4
    /* 2C134 8003B934 E7FF4014 */  bnez       $v0, .L8003B8D4
    /* 2C138 8003B938 300083AC */   sw        $v1, 0x30($a0)
    /* 2C13C 8003B93C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 2C140 8003B940 0580023C */  lui        $v0, %hi(D_80051F18)
    /* 2C144 8003B944 181F5724 */  addiu      $s7, $v0, %lo(D_80051F18)
    /* 2C148 8003B948 2128E002 */  addu       $a1, $s7, $zero
    /* 2C14C 8003B94C 6000B027 */  addiu      $s0, $sp, 0x60
    /* 2C150 8003B950 3CEA000C */  jal        func_8003A8F0
    /* 2C154 8003B954 21300002 */   addu      $a2, $s0, $zero
    /* 2C158 8003B958 21200002 */  addu       $a0, $s0, $zero
    /* 2C15C 8003B95C 2000B427 */  addiu      $s4, $sp, 0x20
    /* 2C160 8003B960 21288002 */  addu       $a1, $s4, $zero
    /* 2C164 8003B964 7000B227 */  addiu      $s2, $sp, 0x70
    /* 2C168 8003B968 3CEA000C */  jal        func_8003A8F0
    /* 2C16C 8003B96C 21304002 */   addu      $a2, $s2, $zero
    /* 2C170 8003B970 7000A28F */  lw         $v0, 0x70($sp)
    /* 2C174 8003B974 C000A38F */  lw         $v1, 0xC0($sp)
    /* 2C178 8003B978 43100200 */  sra        $v0, $v0, 1
    /* 2C17C 8003B97C 000062AC */  sw         $v0, 0x0($v1)
    /* 2C180 8003B980 7400A28F */  lw         $v0, 0x74($sp)
    /* 2C184 8003B984 C400A38F */  lw         $v1, 0xC4($sp)
    /* 2C188 8003B988 43100200 */  sra        $v0, $v0, 1
    /* 2C18C 8003B98C 000062AC */  sw         $v0, 0x0($v1)
    /* 2C190 8003B990 7800A28F */  lw         $v0, 0x78($sp)
    /* 2C194 8003B994 00000000 */  nop
    /* 2C198 8003B998 43180200 */  sra        $v1, $v0, 1
    /* 2C19C 8003B99C 04006104 */  bgez       $v1, .L8003B9B0
    /* 2C1A0 8003B9A0 03140300 */   sra       $v0, $v1, 16
    /* 2C1A4 8003B9A4 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 2C1A8 8003B9A8 21186200 */  addu       $v1, $v1, $v0
    /* 2C1AC 8003B9AC 03140300 */  sra        $v0, $v1, 16
  .L8003B9B0:
    /* 2C1B0 8003B9B0 C800A38F */  lw         $v1, 0xC8($sp)
    /* 2C1B4 8003B9B4 00000000 */  nop
    /* 2C1B8 8003B9B8 000062AC */  sw         $v0, 0x0($v1)
    /* 2C1BC 8003B9BC 7C00A28F */  lw         $v0, 0x7C($sp)
    /* 2C1C0 8003B9C0 00000000 */  nop
    /* 2C1C4 8003B9C4 43180200 */  sra        $v1, $v0, 1
    /* 2C1C8 8003B9C8 02006104 */  bgez       $v1, .L8003B9D4
    /* 2C1CC 8003B9CC FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* 2C1D0 8003B9D0 21186200 */  addu       $v1, $v1, $v0
  .L8003B9D4:
    /* 2C1D4 8003B9D4 031C0300 */  sra        $v1, $v1, 16
    /* 2C1D8 8003B9D8 0580073C */  lui        $a3, %hi(D_80051E78)
    /* 2C1DC 8003B9DC 781EE724 */  addiu      $a3, $a3, %lo(D_80051E78)
    /* 2C1E0 8003B9E0 CC00A28F */  lw         $v0, 0xCC($sp)
    /* 2C1E4 8003B9E4 0580063C */  lui        $a2, %hi(D_80052C18)
    /* 2C1E8 8003B9E8 000043AC */  sw         $v1, 0x0($v0)
    /* 2C1EC 8003B9EC 80101100 */  sll        $v0, $s1, 2
    /* 2C1F0 8003B9F0 21105100 */  addu       $v0, $v0, $s1
    /* 2C1F4 8003B9F4 80100200 */  sll        $v0, $v0, 2
    /* 2C1F8 8003B9F8 21104700 */  addu       $v0, $v0, $a3
    /* 2C1FC 8003B9FC 1000428C */  lw         $v0, 0x10($v0)
    /* 2C200 8003BA00 182CC38C */  lw         $v1, %lo(D_80052C18)($a2)
    /* 2C204 8003BA04 182CC624 */  addiu      $a2, $a2, %lo(D_80052C18)
    /* 2C208 8003BA08 21104300 */  addu       $v0, $v0, $v1
    /* 2C20C 8003BA0C 2000A2AF */  sw         $v0, 0x20($sp)
    /* 2C210 8003BA10 80101300 */  sll        $v0, $s3, 2
    /* 2C214 8003BA14 21105300 */  addu       $v0, $v0, $s3
    /* 2C218 8003BA18 80100200 */  sll        $v0, $v0, 2
    /* 2C21C 8003BA1C 21104700 */  addu       $v0, $v0, $a3
    /* 2C220 8003BA20 1000428C */  lw         $v0, 0x10($v0)
    /* 2C224 8003BA24 0400C38C */  lw         $v1, 0x4($a2)
    /* 2C228 8003BA28 1000A427 */  addiu      $a0, $sp, 0x10
    /* 2C22C 8003BA2C 21104300 */  addu       $v0, $v0, $v1
    /* 2C230 8003BA30 3000A2AF */  sw         $v0, 0x30($sp)
    /* 2C234 8003BA34 80101500 */  sll        $v0, $s5, 2
    /* 2C238 8003BA38 21105500 */  addu       $v0, $v0, $s5
    /* 2C23C 8003BA3C 80100200 */  sll        $v0, $v0, 2
    /* 2C240 8003BA40 21104700 */  addu       $v0, $v0, $a3
    /* 2C244 8003BA44 1000428C */  lw         $v0, 0x10($v0)
    /* 2C248 8003BA48 0800C38C */  lw         $v1, 0x8($a2)
    /* 2C24C 8003BA4C 2128E002 */  addu       $a1, $s7, $zero
    /* 2C250 8003BA50 21104300 */  addu       $v0, $v0, $v1
    /* 2C254 8003BA54 4000A2AF */  sw         $v0, 0x40($sp)
    /* 2C258 8003BA58 80101600 */  sll        $v0, $s6, 2
    /* 2C25C 8003BA5C 21105600 */  addu       $v0, $v0, $s6
    /* 2C260 8003BA60 80100200 */  sll        $v0, $v0, 2
    /* 2C264 8003BA64 21104700 */  addu       $v0, $v0, $a3
    /* 2C268 8003BA68 1000428C */  lw         $v0, 0x10($v0)
    /* 2C26C 8003BA6C 0C00C38C */  lw         $v1, 0xC($a2)
    /* 2C270 8003BA70 21300002 */  addu       $a2, $s0, $zero
    /* 2C274 8003BA74 21104300 */  addu       $v0, $v0, $v1
    /* 2C278 8003BA78 3CEA000C */  jal        func_8003A8F0
    /* 2C27C 8003BA7C 5000A2AF */   sw        $v0, 0x50($sp)
    /* 2C280 8003BA80 21200002 */  addu       $a0, $s0, $zero
    /* 2C284 8003BA84 21288002 */  addu       $a1, $s4, $zero
    /* 2C288 8003BA88 3CEA000C */  jal        func_8003A8F0
    /* 2C28C 8003BA8C 21304002 */   addu      $a2, $s2, $zero
    /* 2C290 8003BA90 7000A28F */  lw         $v0, 0x70($sp)
    /* 2C294 8003BA94 00000000 */  nop
    /* 2C298 8003BA98 43180200 */  sra        $v1, $v0, 1
    /* 2C29C 8003BA9C 02006104 */  bgez       $v1, .L8003BAA8
    /* 2C2A0 8003BAA0 FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* 2C2A4 8003BAA4 21186200 */  addu       $v1, $v1, $v0
  .L8003BAA8:
    /* 2C2A8 8003BAA8 D000A28F */  lw         $v0, 0xD0($sp)
    /* 2C2AC 8003BAAC 031C0300 */  sra        $v1, $v1, 16
    /* 2C2B0 8003BAB0 000043AC */  sw         $v1, 0x0($v0)
    /* 2C2B4 8003BAB4 A000BF8F */  lw         $ra, 0xA0($sp)
    /* 2C2B8 8003BAB8 9C00B78F */  lw         $s7, 0x9C($sp)
    /* 2C2BC 8003BABC 9800B68F */  lw         $s6, 0x98($sp)
    /* 2C2C0 8003BAC0 9400B58F */  lw         $s5, 0x94($sp)
    /* 2C2C4 8003BAC4 9000B48F */  lw         $s4, 0x90($sp)
    /* 2C2C8 8003BAC8 8C00B38F */  lw         $s3, 0x8C($sp)
    /* 2C2CC 8003BACC 8800B28F */  lw         $s2, 0x88($sp)
    /* 2C2D0 8003BAD0 8400B18F */  lw         $s1, 0x84($sp)
    /* 2C2D4 8003BAD4 8000B08F */  lw         $s0, 0x80($sp)
    /* 2C2D8 8003BAD8 0800E003 */  jr         $ra
    /* 2C2DC 8003BADC A800BD27 */   addiu     $sp, $sp, 0xA8
endlabel CalcSplinePosition__16tScreenCarSelectiiiiUlRiN46
