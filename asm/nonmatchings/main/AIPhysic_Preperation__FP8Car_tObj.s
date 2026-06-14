.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_Preperation__FP8Car_tObj, 0x268

glabel AIPhysic_Preperation__FP8Car_tObj
    /* 5B0B4 8006A8B4 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 5B0B8 8006A8B8 2800B2AF */  sw         $s2, 0x28($sp)
    /* 5B0BC 8006A8BC 21908000 */  addu       $s2, $a0, $zero
    /* 5B0C0 8006A8C0 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* 5B0C4 8006A8C4 2400B1AF */  sw         $s1, 0x24($sp)
    /* 5B0C8 8006A8C8 2000B0AF */  sw         $s0, 0x20($sp)
    /* 5B0CC 8006A8CC AC00448E */  lw         $a0, 0xAC($s2)
    /* 5B0D0 8006A8D0 F000458E */  lw         $a1, 0xF0($s2)
    /* 5B0D4 8006A8D4 CA90030C */  jal        fixedmult
    /* 5B0D8 8006A8D8 00000000 */   nop
    /* 5B0DC 8006A8DC B000448E */  lw         $a0, 0xB0($s2)
    /* 5B0E0 8006A8E0 F400458E */  lw         $a1, 0xF4($s2)
    /* 5B0E4 8006A8E4 CA90030C */  jal        fixedmult
    /* 5B0E8 8006A8E8 21804000 */   addu      $s0, $v0, $zero
    /* 5B0EC 8006A8EC B400448E */  lw         $a0, 0xB4($s2)
    /* 5B0F0 8006A8F0 F800458E */  lw         $a1, 0xF8($s2)
    /* 5B0F4 8006A8F4 CA90030C */  jal        fixedmult
    /* 5B0F8 8006A8F8 21884000 */   addu      $s1, $v0, $zero
    /* 5B0FC 8006A8FC 21801102 */  addu       $s0, $s0, $s1
    /* 5B100 8006A900 AC00448E */  lw         $a0, 0xAC($s2)
    /* 5B104 8006A904 FC00458E */  lw         $a1, 0xFC($s2)
    /* 5B108 8006A908 21800202 */  addu       $s0, $s0, $v0
    /* 5B10C 8006A90C CA90030C */  jal        fixedmult
    /* 5B110 8006A910 180450AE */   sw        $s0, 0x418($s2)
    /* 5B114 8006A914 B000448E */  lw         $a0, 0xB0($s2)
    /* 5B118 8006A918 0001458E */  lw         $a1, 0x100($s2)
    /* 5B11C 8006A91C CA90030C */  jal        fixedmult
    /* 5B120 8006A920 21804000 */   addu      $s0, $v0, $zero
    /* 5B124 8006A924 B400448E */  lw         $a0, 0xB4($s2)
    /* 5B128 8006A928 0401458E */  lw         $a1, 0x104($s2)
    /* 5B12C 8006A92C CA90030C */  jal        fixedmult
    /* 5B130 8006A930 21884000 */   addu      $s1, $v0, $zero
    /* 5B134 8006A934 21801102 */  addu       $s0, $s0, $s1
    /* 5B138 8006A938 AC00448E */  lw         $a0, 0xAC($s2)
    /* 5B13C 8006A93C 0801458E */  lw         $a1, 0x108($s2)
    /* 5B140 8006A940 21800202 */  addu       $s0, $s0, $v0
    /* 5B144 8006A944 CA90030C */  jal        fixedmult
    /* 5B148 8006A948 1C0450AE */   sw        $s0, 0x41C($s2)
    /* 5B14C 8006A94C B000448E */  lw         $a0, 0xB0($s2)
    /* 5B150 8006A950 0C01458E */  lw         $a1, 0x10C($s2)
    /* 5B154 8006A954 CA90030C */  jal        fixedmult
    /* 5B158 8006A958 21804000 */   addu      $s0, $v0, $zero
    /* 5B15C 8006A95C B400448E */  lw         $a0, 0xB4($s2)
    /* 5B160 8006A960 1001458E */  lw         $a1, 0x110($s2)
    /* 5B164 8006A964 CA90030C */  jal        fixedmult
    /* 5B168 8006A968 21884000 */   addu      $s1, $v0, $zero
    /* 5B16C 8006A96C 21801102 */  addu       $s0, $s0, $s1
    /* 5B170 8006A970 1401448E */  lw         $a0, 0x114($s2)
    /* 5B174 8006A974 F000458E */  lw         $a1, 0xF0($s2)
    /* 5B178 8006A978 21800202 */  addu       $s0, $s0, $v0
    /* 5B17C 8006A97C CA90030C */  jal        fixedmult
    /* 5B180 8006A980 200450AE */   sw        $s0, 0x420($s2)
    /* 5B184 8006A984 1801448E */  lw         $a0, 0x118($s2)
    /* 5B188 8006A988 F400458E */  lw         $a1, 0xF4($s2)
    /* 5B18C 8006A98C CA90030C */  jal        fixedmult
    /* 5B190 8006A990 21804000 */   addu      $s0, $v0, $zero
    /* 5B194 8006A994 1C01448E */  lw         $a0, 0x11C($s2)
    /* 5B198 8006A998 F800458E */  lw         $a1, 0xF8($s2)
    /* 5B19C 8006A99C CA90030C */  jal        fixedmult
    /* 5B1A0 8006A9A0 21884000 */   addu      $s1, $v0, $zero
    /* 5B1A4 8006A9A4 21801102 */  addu       $s0, $s0, $s1
    /* 5B1A8 8006A9A8 1401448E */  lw         $a0, 0x114($s2)
    /* 5B1AC 8006A9AC FC00458E */  lw         $a1, 0xFC($s2)
    /* 5B1B0 8006A9B0 21800202 */  addu       $s0, $s0, $v0
    /* 5B1B4 8006A9B4 CA90030C */  jal        fixedmult
    /* 5B1B8 8006A9B8 240450AE */   sw        $s0, 0x424($s2)
    /* 5B1BC 8006A9BC 1801448E */  lw         $a0, 0x118($s2)
    /* 5B1C0 8006A9C0 0001458E */  lw         $a1, 0x100($s2)
    /* 5B1C4 8006A9C4 CA90030C */  jal        fixedmult
    /* 5B1C8 8006A9C8 21804000 */   addu      $s0, $v0, $zero
    /* 5B1CC 8006A9CC 1C01448E */  lw         $a0, 0x11C($s2)
    /* 5B1D0 8006A9D0 0401458E */  lw         $a1, 0x104($s2)
    /* 5B1D4 8006A9D4 CA90030C */  jal        fixedmult
    /* 5B1D8 8006A9D8 21884000 */   addu      $s1, $v0, $zero
    /* 5B1DC 8006A9DC 21801102 */  addu       $s0, $s0, $s1
    /* 5B1E0 8006A9E0 1401448E */  lw         $a0, 0x114($s2)
    /* 5B1E4 8006A9E4 0801458E */  lw         $a1, 0x108($s2)
    /* 5B1E8 8006A9E8 21800202 */  addu       $s0, $s0, $v0
    /* 5B1EC 8006A9EC CA90030C */  jal        fixedmult
    /* 5B1F0 8006A9F0 280450AE */   sw        $s0, 0x428($s2)
    /* 5B1F4 8006A9F4 1801448E */  lw         $a0, 0x118($s2)
    /* 5B1F8 8006A9F8 0C01458E */  lw         $a1, 0x10C($s2)
    /* 5B1FC 8006A9FC CA90030C */  jal        fixedmult
    /* 5B200 8006AA00 21804000 */   addu      $s0, $v0, $zero
    /* 5B204 8006AA04 1C01448E */  lw         $a0, 0x11C($s2)
    /* 5B208 8006AA08 1001458E */  lw         $a1, 0x110($s2)
    /* 5B20C 8006AA0C CA90030C */  jal        fixedmult
    /* 5B210 8006AA10 21884000 */   addu      $s1, $v0, $zero
    /* 5B214 8006AA14 21801102 */  addu       $s0, $s0, $s1
    /* 5B218 8006AA18 1804438E */  lw         $v1, 0x418($s2)
    /* 5B21C 8006AA1C 21800202 */  addu       $s0, $s0, $v0
    /* 5B220 8006AA20 2C0450AE */  sw         $s0, 0x42C($s2)
    /* 5B224 8006AA24 02006104 */  bgez       $v1, .L8006AA30
    /* 5B228 8006AA28 21206000 */   addu      $a0, $v1, $zero
    /* 5B22C 8006AA2C 23200400 */  negu       $a0, $a0
  .L8006AA30:
    /* 5B230 8006AA30 02008104 */  bgez       $a0, .L8006AA3C
    /* 5B234 8006AA34 21188000 */   addu      $v1, $a0, $zero
    /* 5B238 8006AA38 FF008324 */  addiu      $v1, $a0, 0xFF
  .L8006AA3C:
    /* 5B23C 8006AA3C 031A0300 */  sra        $v1, $v1, 8
    /* 5B240 8006AA40 40100300 */  sll        $v0, $v1, 1
    /* 5B244 8006AA44 21104300 */  addu       $v0, $v0, $v1
    /* 5B248 8006AA48 C0100200 */  sll        $v0, $v0, 3
    /* 5B24C 8006AA4C 21104300 */  addu       $v0, $v0, $v1
    /* 5B250 8006AA50 2A104400 */  slt        $v0, $v0, $a0
    /* 5B254 8006AA54 03004010 */  beqz       $v0, .L8006AA64
    /* 5B258 8006AA58 00800234 */   ori       $v0, $zero, 0x8000
    /* 5B25C 8006AA5C 9AAA0108 */  j          .L8006AA68
    /* 5B260 8006AA60 780442AE */   sw        $v0, 0x478($s2)
  .L8006AA64:
    /* 5B264 8006AA64 780440AE */  sw         $zero, 0x478($s2)
  .L8006AA68:
    /* 5B268 8006AA68 0801468E */  lw         $a2, 0x108($s2)
    /* 5B26C 8006AA6C 0C01478E */  lw         $a3, 0x10C($s2)
    /* 5B270 8006AA70 1001488E */  lw         $t0, 0x110($s2)
    /* 5B274 8006AA74 1000A6AF */  sw         $a2, 0x10($sp)
    /* 5B278 8006AA78 1400A7AF */  sw         $a3, 0x14($sp)
    /* 5B27C 8006AA7C 1800A8AF */  sw         $t0, 0x18($sp)
    /* 5B280 8006AA80 F006438E */  lw         $v1, 0x6F0($s2)
    /* 5B284 8006AA84 01000224 */  addiu      $v0, $zero, 0x1
    /* 5B288 8006AA88 05006214 */  bne        $v1, $v0, .L8006AAA0
    /* 5B28C 8006AA8C 00000000 */   nop
    /* 5B290 8006AA90 1000A48F */  lw         $a0, 0x10($sp)
    /* 5B294 8006AA94 1800A58F */  lw         $a1, 0x18($sp)
    /* 5B298 8006AA98 ACAA0108 */  j          .L8006AAB0
    /* 5B29C 8006AA9C 00000000 */   nop
  .L8006AAA0:
    /* 5B2A0 8006AAA0 1000A48F */  lw         $a0, 0x10($sp)
    /* 5B2A4 8006AAA4 1800A58F */  lw         $a1, 0x18($sp)
    /* 5B2A8 8006AAA8 23200400 */  negu       $a0, $a0
    /* 5B2AC 8006AAAC 23280500 */  negu       $a1, $a1
  .L8006AAB0:
    /* 5B2B0 8006AAB0 CE96030C */  jal        intatan
    /* 5B2B4 8006AAB4 00000000 */   nop
    /* 5B2B8 8006AAB8 21804000 */  addu       $s0, $v0, $zero
    /* 5B2BC 8006AABC 21204002 */  addu       $a0, $s2, $zero
    /* 5B2C0 8006AAC0 0FAB010C */  jal        AIPhysic_GetDesiredVector__FP8Car_tObj
    /* 5B2C4 8006AAC4 F80650AE */   sw        $s0, 0x6F8($s2)
    /* 5B2C8 8006AAC8 D006448E */  lw         $a0, 0x6D0($s2)
    /* 5B2CC 8006AACC D806458E */  lw         $a1, 0x6D8($s2)
    /* 5B2D0 8006AAD0 CE96030C */  jal        intatan
    /* 5B2D4 8006AAD4 00000000 */   nop
    /* 5B2D8 8006AAD8 21204000 */  addu       $a0, $v0, $zero
    /* 5B2DC 8006AADC 23180402 */  subu       $v1, $s0, $a0
    /* 5B2E0 8006AAE0 00FE6228 */  slti       $v0, $v1, -0x200
    /* 5B2E4 8006AAE4 05004014 */  bnez       $v0, .L8006AAFC
    /* 5B2E8 8006AAE8 00046224 */   addiu     $v0, $v1, 0x400
    /* 5B2EC 8006AAEC 01026228 */  slti       $v0, $v1, 0x201
    /* 5B2F0 8006AAF0 03004014 */  bnez       $v0, .L8006AB00
    /* 5B2F4 8006AAF4 DC0643AE */   sw        $v1, 0x6DC($s2)
    /* 5B2F8 8006AAF8 00FC6224 */  addiu      $v0, $v1, -0x400
  .L8006AAFC:
    /* 5B2FC 8006AAFC DC0642AE */  sw         $v0, 0x6DC($s2)
  .L8006AB00:
    /* 5B300 8006AB00 FC0644AE */  sw         $a0, 0x6FC($s2)
    /* 5B304 8006AB04 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* 5B308 8006AB08 2800B28F */  lw         $s2, 0x28($sp)
    /* 5B30C 8006AB0C 2400B18F */  lw         $s1, 0x24($sp)
    /* 5B310 8006AB10 2000B08F */  lw         $s0, 0x20($sp)
    /* 5B314 8006AB14 0800E003 */  jr         $ra
    /* 5B318 8006AB18 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel AIPhysic_Preperation__FP8Car_tObj
