.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ScaleGouraudShape__FP18tTexture_ShapeInfoiiiiiPii, 0x2BC

glabel ScaleGouraudShape__FP18tTexture_ShapeInfoiiiiiPii
    /* 3EF7C 8004E77C C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 3EF80 8004E780 2800B4AF */  sw         $s4, 0x28($sp)
    /* 3EF84 8004E784 21A08000 */  addu       $s4, $a0, $zero
    /* 3EF88 8004E788 3400B7AF */  sw         $s7, 0x34($sp)
    /* 3EF8C 8004E78C 21B8A000 */  addu       $s7, $a1, $zero
    /* 3EF90 8004E790 3000B6AF */  sw         $s6, 0x30($sp)
    /* 3EF94 8004E794 21B0C000 */  addu       $s6, $a2, $zero
    /* 3EF98 8004E798 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* 3EF9C 8004E79C 21A8E000 */  addu       $s5, $a3, $zero
    /* 3EFA0 8004E7A0 801F083C */  lui        $t0, (0x1F800004 >> 16)
    /* 3EFA4 8004E7A4 04000835 */  ori        $t0, $t0, (0x1F800004 & 0xFFFF)
    /* 3EFA8 8004E7A8 FF00053C */  lui        $a1, (0xFFFFFF >> 16)
    /* 3EFAC 8004E7AC FFFFA534 */  ori        $a1, $a1, (0xFFFFFF & 0xFFFF)
    /* 3EFB0 8004E7B0 3C00BFAF */  sw         $ra, 0x3C($sp)
    /* 3EFB4 8004E7B4 3800BEAF */  sw         $fp, 0x38($sp)
    /* 3EFB8 8004E7B8 2400B3AF */  sw         $s3, 0x24($sp)
    /* 3EFBC 8004E7BC 2000B2AF */  sw         $s2, 0x20($sp)
    /* 3EFC0 8004E7C0 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 3EFC4 8004E7C4 1800B0AF */  sw         $s0, 0x18($sp)
    /* 3EFC8 8004E7C8 10009296 */  lhu        $s2, 0x10($s4)
    /* 3EFCC 8004E7CC 12009196 */  lhu        $s1, 0x12($s4)
    /* 3EFD0 8004E7D0 0000138D */  lw         $s3, 0x0($t0)
    /* 3EFD4 8004E7D4 801F063C */  lui        $a2, (0x1F800000 >> 16)
    /* 3EFD8 8004E7D8 0000C68C */  lw         $a2, (0x1F800000 & 0xFFFF)($a2)
    /* 3EFDC 8004E7DC 08008992 */  lbu        $t1, 0x8($s4)
    /* 3EFE0 8004E7E0 0000628E */  lw         $v0, 0x0($s3)
    /* 3EFE4 8004E7E4 0000C38C */  lw         $v1, 0x0($a2)
    /* 3EFE8 8004E7E8 00FF073C */  lui        $a3, (0xFF000000 >> 16)
    /* 3EFEC 8004E7EC 1000A9A7 */  sh         $t1, 0x10($sp)
    /* 3EFF0 8004E7F0 24104700 */  and        $v0, $v0, $a3
    /* 3EFF4 8004E7F4 24186500 */  and        $v1, $v1, $a1
    /* 3EFF8 8004E7F8 25104300 */  or         $v0, $v0, $v1
    /* 3EFFC 8004E7FC 34006326 */  addiu      $v1, $s3, 0x34
    /* 3F000 8004E800 000062AE */  sw         $v0, 0x0($s3)
    /* 3F004 8004E804 5800A48F */  lw         $a0, 0x58($sp)
    /* 3F008 8004E808 5C00B08F */  lw         $s0, 0x5C($sp)
    /* 3F00C 8004E80C 0000C28C */  lw         $v0, 0x0($a2)
    /* 3F010 8004E810 24286502 */  and        $a1, $s3, $a1
    /* 3F014 8004E814 000003AD */  sw         $v1, 0x0($t0)
    /* 3F018 8004E818 24104700 */  and        $v0, $v0, $a3
    /* 3F01C 8004E81C 25104500 */  or         $v0, $v0, $a1
    /* 3F020 8004E820 0000C2AC */  sw         $v0, 0x0($a2)
    /* 3F024 8004E824 0000828C */  lw         $v0, 0x0($a0)
    /* 3F028 8004E828 00000000 */  nop
    /* 3F02C 8004E82C 040062AE */  sw         $v0, 0x4($s3)
    /* 3F030 8004E830 0400828C */  lw         $v0, 0x4($a0)
    /* 3F034 8004E834 00000000 */  nop
    /* 3F038 8004E838 100062AE */  sw         $v0, 0x10($s3)
    /* 3F03C 8004E83C 0800828C */  lw         $v0, 0x8($a0)
    /* 3F040 8004E840 00000000 */  nop
    /* 3F044 8004E844 1C0062AE */  sw         $v0, 0x1C($s3)
    /* 3F048 8004E848 0C00828C */  lw         $v0, 0xC($a0)
    /* 3F04C 8004E84C 21206002 */  addu       $a0, $s3, $zero
    /* 3F050 8004E850 24CD030C */  jal        SetPolyGT4
    /* 3F054 8004E854 280062AE */   sw        $v0, 0x28($s3)
    /* 3F058 8004E858 21206002 */  addu       $a0, $s3, $zero
    /* 3F05C 8004E85C 3FCC030C */  jal        SetSemiTrans
    /* 3F060 8004E860 0100E532 */   andi      $a1, $s7, 0x1
    /* 3F064 8004E864 0400858E */  lw         $a1, 0x4($s4)
    /* 3F068 8004E868 00000000 */  nop
    /* 3F06C 8004E86C 3F00A430 */  andi       $a0, $a1, 0x3F
    /* 3F070 8004E870 00210400 */  sll        $a0, $a0, 4
    /* 3F074 8004E874 14D1030C */  jal        GetClut
    /* 3F078 8004E878 83290500 */   sra       $a1, $a1, 6
    /* 3F07C 8004E87C 03001032 */  andi       $s0, $s0, 0x3
    /* 3F080 8004E880 40811000 */  sll        $s0, $s0, 5
    /* 3F084 8004E884 0400FE32 */  andi       $fp, $s7, 0x4
    /* 3F088 8004E888 0E0062A6 */  sh         $v0, 0xE($s3)
    /* 3F08C 8004E88C 09008492 */  lbu        $a0, 0x9($s4)
    /* 3F090 8004E890 1A008596 */  lhu        $a1, 0x1A($s4)
    /* 3F094 8004E894 18008396 */  lhu        $v1, 0x18($s4)
    /* 3F098 8004E898 03008430 */  andi       $a0, $a0, 0x3
    /* 3F09C 8004E89C C0210400 */  sll        $a0, $a0, 7
    /* 3F0A0 8004E8A0 25209000 */  or         $a0, $a0, $s0
    /* 3F0A4 8004E8A4 0001A230 */  andi       $v0, $a1, 0x100
    /* 3F0A8 8004E8A8 00140200 */  sll        $v0, $v0, 16
    /* 3F0AC 8004E8AC 03150200 */  sra        $v0, $v0, 20
    /* 3F0B0 8004E8B0 25208200 */  or         $a0, $a0, $v0
    /* 3F0B4 8004E8B4 C0036330 */  andi       $v1, $v1, 0x3C0
    /* 3F0B8 8004E8B8 82190300 */  srl        $v1, $v1, 6
    /* 3F0BC 8004E8BC 25208300 */  or         $a0, $a0, $v1
    /* 3F0C0 8004E8C0 0002A530 */  andi       $a1, $a1, 0x200
    /* 3F0C4 8004E8C4 80280500 */  sll        $a1, $a1, 2
    /* 3F0C8 8004E8C8 25208500 */  or         $a0, $a0, $a1
    /* 3F0CC 8004E8CC 0700C013 */  beqz       $fp, .L8004E8EC
    /* 3F0D0 8004E8D0 1A0064A6 */   sh        $a0, 0x1A($s3)
    /* 3F0D4 8004E8D4 5000A48F */  lw         $a0, 0x50($sp)
    /* 3F0D8 8004E8D8 002C1200 */  sll        $a1, $s2, 16
    /* 3F0DC 8004E8DC CA90030C */  jal        fixedmult
    /* 3F0E0 8004E8E0 032C0500 */   sra       $a1, $a1, 16
    /* 3F0E4 8004E8E4 21B0C202 */  addu       $s6, $s6, $v0
    /* 3F0E8 8004E8E8 23901200 */  negu       $s2, $s2
  .L8004E8EC:
    /* 3F0EC 8004E8EC 0200F732 */  andi       $s7, $s7, 0x2
    /* 3F0F0 8004E8F0 0700E012 */  beqz       $s7, .L8004E910
    /* 3F0F4 8004E8F4 00000000 */   nop
    /* 3F0F8 8004E8F8 5400A48F */  lw         $a0, 0x54($sp)
    /* 3F0FC 8004E8FC 002C1100 */  sll        $a1, $s1, 16
    /* 3F100 8004E900 CA90030C */  jal        fixedmult
    /* 3F104 8004E904 032C0500 */   sra       $a1, $a1, 16
    /* 3F108 8004E908 21A8A202 */  addu       $s5, $s5, $v0
    /* 3F10C 8004E90C 23881100 */  negu       $s1, $s1
  .L8004E910:
    /* 3F110 8004E910 00941200 */  sll        $s2, $s2, 16
    /* 3F114 8004E914 03941200 */  sra        $s2, $s2, 16
    /* 3F118 8004E918 5000A48F */  lw         $a0, 0x50($sp)
    /* 3F11C 8004E91C 21284002 */  addu       $a1, $s2, $zero
    /* 3F120 8004E920 080076A6 */  sh         $s6, 0x8($s3)
    /* 3F124 8004E924 CA90030C */  jal        fixedmult
    /* 3F128 8004E928 0A0075A6 */   sh        $s5, 0xA($s3)
    /* 3F12C 8004E92C 008C1100 */  sll        $s1, $s1, 16
    /* 3F130 8004E930 038C1100 */  sra        $s1, $s1, 16
    /* 3F134 8004E934 21282002 */  addu       $a1, $s1, $zero
    /* 3F138 8004E938 FFFFD026 */  addiu      $s0, $s6, -0x1
    /* 3F13C 8004E93C 5400A48F */  lw         $a0, 0x54($sp)
    /* 3F140 8004E940 21100202 */  addu       $v0, $s0, $v0
    /* 3F144 8004E944 140062A6 */  sh         $v0, 0x14($s3)
    /* 3F148 8004E948 160075A6 */  sh         $s5, 0x16($s3)
    /* 3F14C 8004E94C CA90030C */  jal        fixedmult
    /* 3F150 8004E950 200076A6 */   sh        $s6, 0x20($s3)
    /* 3F154 8004E954 21284002 */  addu       $a1, $s2, $zero
    /* 3F158 8004E958 5000A48F */  lw         $a0, 0x50($sp)
    /* 3F15C 8004E95C 2110A202 */  addu       $v0, $s5, $v0
    /* 3F160 8004E960 CA90030C */  jal        fixedmult
    /* 3F164 8004E964 220062A6 */   sh        $v0, 0x22($s3)
    /* 3F168 8004E968 21282002 */  addu       $a1, $s1, $zero
    /* 3F16C 8004E96C 5400A48F */  lw         $a0, 0x54($sp)
    /* 3F170 8004E970 21800202 */  addu       $s0, $s0, $v0
    /* 3F174 8004E974 CA90030C */  jal        fixedmult
    /* 3F178 8004E978 2C0070A6 */   sh        $s0, 0x2C($s3)
    /* 3F17C 8004E97C 2110A202 */  addu       $v0, $s5, $v0
    /* 3F180 8004E980 2E0062A6 */  sh         $v0, 0x2E($s3)
    /* 3F184 8004E984 18008296 */  lhu        $v0, 0x18($s4)
    /* 3F188 8004E988 1000A997 */  lhu        $t1, 0x10($sp)
    /* 3F18C 8004E98C 3F004230 */  andi       $v0, $v0, 0x3F
    /* 3F190 8004E990 00110200 */  sll        $v0, $v0, 4
    /* 3F194 8004E994 1A004900 */  div        $zero, $v0, $t1
    /* 3F198 8004E998 02002015 */  bnez       $t1, .L8004E9A4
    /* 3F19C 8004E99C 00000000 */   nop
    /* 3F1A0 8004E9A0 0D000700 */  break      7
  .L8004E9A4:
    /* 3F1A4 8004E9A4 FFFF0124 */  addiu      $at, $zero, -0x1
    /* 3F1A8 8004E9A8 04002115 */  bne        $t1, $at, .L8004E9BC
    /* 3F1AC 8004E9AC 0080013C */   lui       $at, (0x80000000 >> 16)
    /* 3F1B0 8004E9B0 02004114 */  bne        $v0, $at, .L8004E9BC
    /* 3F1B4 8004E9B4 00000000 */   nop
    /* 3F1B8 8004E9B8 0D000600 */  break      6
  .L8004E9BC:
    /* 3F1BC 8004E9BC 12180000 */  mflo       $v1
    /* 3F1C0 8004E9C0 10008692 */  lbu        $a2, 0x10($s4)
    /* 3F1C4 8004E9C4 12008492 */  lbu        $a0, 0x12($s4)
    /* 3F1C8 8004E9C8 1A008292 */  lbu        $v0, 0x1A($s4)
    /* 3F1CC 8004E9CC 0200C013 */  beqz       $fp, .L8004E9D8
    /* 3F1D0 8004E9D0 21286000 */   addu      $a1, $v1, $zero
    /* 3F1D4 8004E9D4 FFFF6524 */  addiu      $a1, $v1, -0x1
  .L8004E9D8:
    /* 3F1D8 8004E9D8 0200E012 */  beqz       $s7, .L8004E9E4
    /* 3F1DC 8004E9DC 2118A600 */   addu      $v1, $a1, $a2
    /* 3F1E0 8004E9E0 FFFF4224 */  addiu      $v0, $v0, -0x1
  .L8004E9E4:
    /* 3F1E4 8004E9E4 0D0062A2 */  sb         $v0, 0xD($s3)
    /* 3F1E8 8004E9E8 190062A2 */  sb         $v0, 0x19($s3)
    /* 3F1EC 8004E9EC 21104400 */  addu       $v0, $v0, $a0
    /* 3F1F0 8004E9F0 0C0065A2 */  sb         $a1, 0xC($s3)
    /* 3F1F4 8004E9F4 180063A2 */  sb         $v1, 0x18($s3)
    /* 3F1F8 8004E9F8 240065A2 */  sb         $a1, 0x24($s3)
    /* 3F1FC 8004E9FC 250062A2 */  sb         $v0, 0x25($s3)
    /* 3F200 8004EA00 300063A2 */  sb         $v1, 0x30($s3)
    /* 3F204 8004EA04 310062A2 */  sb         $v0, 0x31($s3)
    /* 3F208 8004EA08 3C00BF8F */  lw         $ra, 0x3C($sp)
    /* 3F20C 8004EA0C 3800BE8F */  lw         $fp, 0x38($sp)
    /* 3F210 8004EA10 3400B78F */  lw         $s7, 0x34($sp)
    /* 3F214 8004EA14 3000B68F */  lw         $s6, 0x30($sp)
    /* 3F218 8004EA18 2C00B58F */  lw         $s5, 0x2C($sp)
    /* 3F21C 8004EA1C 2800B48F */  lw         $s4, 0x28($sp)
    /* 3F220 8004EA20 2400B38F */  lw         $s3, 0x24($sp)
    /* 3F224 8004EA24 2000B28F */  lw         $s2, 0x20($sp)
    /* 3F228 8004EA28 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 3F22C 8004EA2C 1800B08F */  lw         $s0, 0x18($sp)
    /* 3F230 8004EA30 0800E003 */  jr         $ra
    /* 3F234 8004EA34 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel ScaleGouraudShape__FP18tTexture_ShapeInfoiiiiiPii
