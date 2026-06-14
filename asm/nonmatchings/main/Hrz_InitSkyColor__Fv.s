.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hrz_InitSkyColor__Fv, 0x15C

glabel Hrz_InitSkyColor__Fv
    /* C00E0 800CF8E0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* C00E4 800CF8E4 21380000 */  addu       $a3, $zero, $zero
    /* C00E8 800CF8E8 2130E000 */  addu       $a2, $a3, $zero
    /* C00EC 800CF8EC 10000824 */  addiu      $t0, $zero, 0x10
    /* C00F0 800CF8F0 1280023C */  lui        $v0, %hi(gSkyColor)
    /* C00F4 800CF8F4 20064924 */  addiu      $t1, $v0, %lo(gSkyColor)
  .L800CF8F8:
    /* C00F8 800CF8F8 0500E228 */  slti       $v0, $a3, 0x5
    /* C00FC 800CF8FC 4D004010 */  beqz       $v0, .L800CFA34
    /* C0100 800CF900 80200700 */   sll       $a0, $a3, 2
    /* C0104 800CF904 4013828F */  lw         $v0, %gp_rel(Sky_gTrackSpec)($gp)
    /* C0108 800CF908 00000000 */  nop
    /* C010C 800CF90C 21184000 */  addu       $v1, $v0, $zero
    /* C0110 800CF910 21104400 */  addu       $v0, $v0, $a0
    /* C0114 800CF914 21186400 */  addu       $v1, $v1, $a0
    /* C0118 800CF918 1F004A88 */  lwl        $t2, 0x1F($v0)
    /* C011C 800CF91C 1C004A98 */  lwr        $t2, 0x1C($v0)
    /* C0120 800CF920 00000000 */  nop
    /* C0124 800CF924 0B00AAAB */  swl        $t2, 0xB($sp)
    /* C0128 800CF928 0800AABB */  swr        $t2, 0x8($sp)
    /* C012C 800CF92C 0B006A88 */  lwl        $t2, 0xB($v1)
    /* C0130 800CF930 08006A98 */  lwr        $t2, 0x8($v1)
    /* C0134 800CF934 00000000 */  nop
    /* C0138 800CF938 1300AAAB */  swl        $t2, 0x13($sp)
    /* C013C 800CF93C 1000AABB */  swr        $t2, 0x10($sp)
    /* C0140 800CF940 0800A393 */  lbu        $v1, 0x8($sp)
    /* C0144 800CF944 1000A293 */  lbu        $v0, 0x10($sp)
    /* C0148 800CF948 00000000 */  nop
    /* C014C 800CF94C 23106200 */  subu       $v0, $v1, $v0
    /* C0150 800CF950 02004104 */  bgez       $v0, .L800CF95C
    /* C0154 800CF954 00000000 */   nop
    /* C0158 800CF958 07004224 */  addiu      $v0, $v0, 0x7
  .L800CF95C:
    /* C015C 800CF95C 0900A493 */  lbu        $a0, 0x9($sp)
    /* C0160 800CF960 1100A393 */  lbu        $v1, 0x11($sp)
    /* C0164 800CF964 C3100200 */  sra        $v0, $v0, 3
    /* C0168 800CF968 0000A2A3 */  sb         $v0, 0x0($sp)
    /* C016C 800CF96C 23108300 */  subu       $v0, $a0, $v1
    /* C0170 800CF970 02004104 */  bgez       $v0, .L800CF97C
    /* C0174 800CF974 00000000 */   nop
    /* C0178 800CF978 07004224 */  addiu      $v0, $v0, 0x7
  .L800CF97C:
    /* C017C 800CF97C 0A00A493 */  lbu        $a0, 0xA($sp)
    /* C0180 800CF980 1200A393 */  lbu        $v1, 0x12($sp)
    /* C0184 800CF984 C3100200 */  sra        $v0, $v0, 3
    /* C0188 800CF988 0100A2A3 */  sb         $v0, 0x1($sp)
    /* C018C 800CF98C 23108300 */  subu       $v0, $a0, $v1
    /* C0190 800CF990 02004104 */  bgez       $v0, .L800CF99C
    /* C0194 800CF994 00000000 */   nop
    /* C0198 800CF998 07004224 */  addiu      $v0, $v0, 0x7
  .L800CF99C:
    /* C019C 800CF99C C3100200 */  sra        $v0, $v0, 3
    /* C01A0 800CF9A0 0200A2A3 */  sb         $v0, 0x2($sp)
    /* C01A4 800CF9A4 21180000 */  addu       $v1, $zero, $zero
    /* C01A8 800CF9A8 80100600 */  sll        $v0, $a2, 2
    /* C01AC 800CF9AC 21284900 */  addu       $a1, $v0, $t1
  .L800CF9B0:
    /* C01B0 800CF9B0 11006228 */  slti       $v0, $v1, 0x11
    /* C01B4 800CF9B4 1D004010 */  beqz       $v0, .L800CFA2C
    /* C01B8 800CF9B8 09006228 */   slti      $v0, $v1, 0x9
    /* C01BC 800CF9BC 02004014 */  bnez       $v0, .L800CF9C8
    /* C01C0 800CF9C0 21206000 */   addu      $a0, $v1, $zero
    /* C01C4 800CF9C4 23200301 */  subu       $a0, $t0, $v1
  .L800CF9C8:
    /* C01C8 800CF9C8 0000A293 */  lbu        $v0, 0x0($sp)
    /* C01CC 800CF9CC 00000000 */  nop
    /* C01D0 800CF9D0 18004400 */  mult       $v0, $a0
    /* C01D4 800CF9D4 1000A293 */  lbu        $v0, 0x10($sp)
    /* C01D8 800CF9D8 12500000 */  mflo       $t2
    /* C01DC 800CF9DC 21104A00 */  addu       $v0, $v0, $t2
    /* C01E0 800CF9E0 0000A2A0 */  sb         $v0, 0x0($a1)
    /* C01E4 800CF9E4 0100A293 */  lbu        $v0, 0x1($sp)
    /* C01E8 800CF9E8 00000000 */  nop
    /* C01EC 800CF9EC 18004400 */  mult       $v0, $a0
    /* C01F0 800CF9F0 1100A293 */  lbu        $v0, 0x11($sp)
    /* C01F4 800CF9F4 12500000 */  mflo       $t2
    /* C01F8 800CF9F8 21104A00 */  addu       $v0, $v0, $t2
    /* C01FC 800CF9FC 0100A2A0 */  sb         $v0, 0x1($a1)
    /* C0200 800CFA00 0200A293 */  lbu        $v0, 0x2($sp)
    /* C0204 800CFA04 00000000 */  nop
    /* C0208 800CFA08 18004400 */  mult       $v0, $a0
    /* C020C 800CFA0C 01006324 */  addiu      $v1, $v1, 0x1
    /* C0210 800CFA10 0100C624 */  addiu      $a2, $a2, 0x1
    /* C0214 800CFA14 1200A293 */  lbu        $v0, 0x12($sp)
    /* C0218 800CFA18 12500000 */  mflo       $t2
    /* C021C 800CFA1C 21104A00 */  addu       $v0, $v0, $t2
    /* C0220 800CFA20 0200A2A0 */  sb         $v0, 0x2($a1)
    /* C0224 800CFA24 6C3E0308 */  j          .L800CF9B0
    /* C0228 800CFA28 0400A524 */   addiu     $a1, $a1, 0x4
  .L800CFA2C:
    /* C022C 800CFA2C 3E3E0308 */  j          .L800CF8F8
    /* C0230 800CFA30 0100E724 */   addiu     $a3, $a3, 0x1
  .L800CFA34:
    /* C0234 800CFA34 0800E003 */  jr         $ra
    /* C0238 800CFA38 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Hrz_InitSkyColor__Fv
