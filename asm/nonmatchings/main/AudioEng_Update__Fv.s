.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioEng_Update__Fv, 0x5B8

glabel AudioEng_Update__Fv
    /* 6C024 8007B824 A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* 6C028 8007B828 1180023C */  lui        $v0, %hi(Xfade)
    /* 6C02C 8007B82C 5000BEAF */  sw         $fp, 0x50($sp)
    /* 6C030 8007B830 8CE65E24 */  addiu      $fp, $v0, %lo(Xfade)
    /* 6C034 8007B834 4C00B7AF */  sw         $s7, 0x4C($sp)
    /* 6C038 8007B838 FFFF1724 */  addiu      $s7, $zero, -0x1
    /* 6C03C 8007B83C 5400BFAF */  sw         $ra, 0x54($sp)
    /* 6C040 8007B840 4800B6AF */  sw         $s6, 0x48($sp)
    /* 6C044 8007B844 4400B5AF */  sw         $s5, 0x44($sp)
    /* 6C048 8007B848 4000B4AF */  sw         $s4, 0x40($sp)
    /* 6C04C 8007B84C 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* 6C050 8007B850 3800B2AF */  sw         $s2, 0x38($sp)
    /* 6C054 8007B854 3400B1AF */  sw         $s1, 0x34($sp)
    /* 6C058 8007B858 3000B0AF */  sw         $s0, 0x30($sp)
    /* 6C05C 8007B85C 2800A0AF */  sw         $zero, 0x28($sp)
  .L8007B860:
    /* 6C060 8007B860 2800A78F */  lw         $a3, 0x28($sp)
    /* 6C064 8007B864 00000000 */  nop
    /* 6C068 8007B868 0200E228 */  slti       $v0, $a3, 0x2
    /* 6C06C 8007B86C 4F014010 */  beqz       $v0, .L8007BDAC
    /* 6C070 8007B870 80100700 */   sll       $v0, $a3, 2
    /* 6C074 8007B874 1480033C */  lui        $v1, %hi(AudioEng_g)
    /* 6C078 8007B878 34C76324 */  addiu      $v1, $v1, %lo(AudioEng_g)
    /* 6C07C 8007B87C 21104300 */  addu       $v0, $v0, $v1
    /* 6C080 8007B880 0000518C */  lw         $s1, 0x0($v0)
    /* 6C084 8007B884 00000000 */  nop
    /* 6C088 8007B888 48012012 */  beqz       $s1, .L8007BDAC
    /* 6C08C 8007B88C 00000000 */   nop
    /* 6C090 8007B890 1B012392 */  lbu        $v1, 0x11B($s1)
    /* 6C094 8007B894 00000000 */  nop
    /* 6C098 8007B898 40100300 */  sll        $v0, $v1, 1
    /* 6C09C 8007B89C 21104300 */  addu       $v0, $v0, $v1
    /* 6C0A0 8007B8A0 80100200 */  sll        $v0, $v0, 2
    /* 6C0A4 8007B8A4 5A004224 */  addiu      $v0, $v0, 0x5A
    /* 6C0A8 8007B8A8 88A0030C */  jal        gettick
    /* 6C0AC 8007B8AC 21802202 */   addu      $s0, $s1, $v0
    /* 6C0B0 8007B8B0 1B012492 */  lbu        $a0, 0x11B($s1)
    /* 6C0B4 8007B8B4 1A012392 */  lbu        $v1, 0x11A($s1)
    /* 6C0B8 8007B8B8 00000000 */  nop
    /* 6C0BC 8007B8BC 6E008310 */  beq        $a0, $v1, .L8007BA78
    /* 6C0C0 8007B8C0 21904000 */   addu      $s2, $v0, $zero
    /* 6C0C4 8007B8C4 88A0030C */  jal        gettick
    /* 6C0C8 8007B8C8 00000000 */   nop
    /* 6C0CC 8007B8CC 0800238E */  lw         $v1, 0x8($s1)
    /* 6C0D0 8007B8D0 00000000 */  nop
    /* 6C0D4 8007B8D4 2A186200 */  slt        $v1, $v1, $v0
    /* 6C0D8 8007B8D8 67006010 */  beqz       $v1, .L8007BA78
    /* 6C0DC 8007B8DC 02004226 */   addiu     $v0, $s2, 0x2
    /* 6C0E0 8007B8E0 080022AE */  sw         $v0, 0x8($s1)
    /* 6C0E4 8007B8E4 21B00000 */  addu       $s6, $zero, $zero
    /* 6C0E8 8007B8E8 21302002 */  addu       $a2, $s1, $zero
    /* 6C0EC 8007B8EC 21282002 */  addu       $a1, $s1, $zero
  .L8007B8F0:
    /* 6C0F0 8007B8F0 1000C22A */  slti       $v0, $s6, 0x10
    /* 6C0F4 8007B8F4 5B004010 */  beqz       $v0, .L8007BA64
    /* 6C0F8 8007B8F8 00000000 */   nop
    /* 6C0FC 8007B8FC 2401A280 */  lb         $v0, 0x124($a1)
    /* 6C100 8007B900 00000000 */  nop
    /* 6C104 8007B904 53004004 */  bltz       $v0, .L8007BA54
    /* 6C108 8007B908 00000000 */   nop
    /* 6C10C 8007B90C 08000396 */  lhu        $v1, 0x8($s0)
    /* 6C110 8007B910 1C01A484 */  lh         $a0, 0x11C($a1)
    /* 6C114 8007B914 00000000 */  nop
    /* 6C118 8007B918 2A106400 */  slt        $v0, $v1, $a0
    /* 6C11C 8007B91C 0C004014 */  bnez       $v0, .L8007B950
    /* 6C120 8007B920 00000000 */   nop
    /* 6C124 8007B924 1E01A284 */  lh         $v0, 0x11E($a1)
    /* 6C128 8007B928 00000000 */  nop
    /* 6C12C 8007B92C 2A106200 */  slt        $v0, $v1, $v0
    /* 6C130 8007B930 07004010 */  beqz       $v0, .L8007B950
    /* 6C134 8007B934 23186400 */   subu      $v1, $v1, $a0
    /* 6C138 8007B938 2001A28C */  lw         $v0, 0x120($a1)
    /* 6C13C 8007B93C 00000000 */  nop
    /* 6C140 8007B940 21104300 */  addu       $v0, $v0, $v1
    /* 6C144 8007B944 00004480 */  lb         $a0, 0x0($v0)
    /* 6C148 8007B948 55EE0108 */  j          .L8007B954
    /* 6C14C 8007B94C 00000000 */   nop
  .L8007B950:
    /* 6C150 8007B950 21200000 */  addu       $a0, $zero, $zero
  .L8007B954:
    /* 6C154 8007B954 2C008010 */  beqz       $a0, .L8007BA08
    /* 6C158 8007B958 0800C22A */   slti      $v0, $s6, 0x8
    /* 6C15C 8007B95C 04004010 */  beqz       $v0, .L8007B970
    /* 6C160 8007B960 80000724 */   addiu     $a3, $zero, 0x80
    /* 6C164 8007B964 0B000292 */  lbu        $v0, 0xB($s0)
    /* 6C168 8007B968 5DEE0108 */  j          .L8007B974
    /* 6C16C 8007B96C 2310E200 */   subu      $v0, $a3, $v0
  .L8007B970:
    /* 6C170 8007B970 0B000292 */  lbu        $v0, 0xB($s0)
  .L8007B974:
    /* 6C174 8007B974 00000000 */  nop
    /* 6C178 8007B978 21105E00 */  addu       $v0, $v0, $fp
    /* 6C17C 8007B97C 00004290 */  lbu        $v0, 0x0($v0)
    /* 6C180 8007B980 00000000 */  nop
    /* 6C184 8007B984 18008200 */  mult       $a0, $v0
    /* 6C188 8007B988 12200000 */  mflo       $a0
    /* 6C18C 8007B98C 2401A280 */  lb         $v0, 0x124($a1)
    /* 6C190 8007B990 00000000 */  nop
    /* 6C194 8007B994 40004228 */  slti       $v0, $v0, 0x40
    /* 6C198 8007B998 14004014 */  bnez       $v0, .L8007B9EC
    /* 6C19C 8007B99C 00000000 */   nop
    /* 6C1A0 8007B9A0 06000296 */  lhu        $v0, 0x6($s0)
    /* 6C1A4 8007B9A4 00000000 */  nop
    /* 6C1A8 8007B9A8 0D004010 */  beqz       $v0, .L8007B9E0
    /* 6C1AC 8007B9AC 80000724 */   addiu     $a3, $zero, 0x80
    /* 6C1B0 8007B9B0 0A000292 */  lbu        $v0, 0xA($s0)
    /* 6C1B4 8007B9B4 00000000 */  nop
    /* 6C1B8 8007B9B8 2310E200 */  subu       $v0, $a3, $v0
    /* 6C1BC 8007B9BC 21105E00 */  addu       $v0, $v0, $fp
    /* 6C1C0 8007B9C0 00004390 */  lbu        $v1, 0x0($v0)
    /* 6C1C4 8007B9C4 00000000 */  nop
    /* 6C1C8 8007B9C8 40100300 */  sll        $v0, $v1, 1
    /* 6C1CC 8007B9CC 21104300 */  addu       $v0, $v0, $v1
    /* 6C1D0 8007B9D0 00110200 */  sll        $v0, $v0, 4
    /* 6C1D4 8007B9D4 23104300 */  subu       $v0, $v0, $v1
    /* 6C1D8 8007B9D8 7FEE0108 */  j          .L8007B9FC
    /* 6C1DC 8007B9DC 83110200 */   sra       $v0, $v0, 6
  .L8007B9E0:
    /* 6C1E0 8007B9E0 0A000292 */  lbu        $v0, 0xA($s0)
    /* 6C1E4 8007B9E4 7CEE0108 */  j          .L8007B9F0
    /* 6C1E8 8007B9E8 2310E200 */   subu      $v0, $a3, $v0
  .L8007B9EC:
    /* 6C1EC 8007B9EC 0A000292 */  lbu        $v0, 0xA($s0)
  .L8007B9F0:
    /* 6C1F0 8007B9F0 00000000 */  nop
    /* 6C1F4 8007B9F4 21105E00 */  addu       $v0, $v0, $fp
    /* 6C1F8 8007B9F8 00004290 */  lbu        $v0, 0x0($v0)
  .L8007B9FC:
    /* 6C1FC 8007B9FC 00000000 */  nop
    /* 6C200 8007BA00 18008200 */  mult       $a0, $v0
    /* 6C204 8007BA04 12200000 */  mflo       $a0
  .L8007BA08:
    /* 6C208 8007BA08 00000296 */  lhu        $v0, 0x0($s0)
    /* 6C20C 8007BA0C 00000000 */  nop
    /* 6C210 8007BA10 18008200 */  mult       $a0, $v0
    /* 6C214 8007BA14 12200000 */  mflo       $a0
    /* 6C218 8007BA18 42250400 */  srl        $a0, $a0, 21
    /* 6C21C 8007BA1C 8000822C */  sltiu      $v0, $a0, 0x80
    /* 6C220 8007BA20 02004014 */  bnez       $v0, .L8007BA2C
    /* 6C224 8007BA24 00000000 */   nop
    /* 6C228 8007BA28 7F000424 */  addiu      $a0, $zero, 0x7F
  .L8007BA2C:
    /* 6C22C 8007BA2C 0C00C4AC */  sw         $a0, 0xC($a2)
    /* 6C230 8007BA30 04000296 */  lhu        $v0, 0x4($s0)
    /* 6C234 8007BA34 00000000 */  nop
    /* 6C238 8007BA38 4C0022AE */  sw         $v0, 0x4C($s1)
    /* 6C23C 8007BA3C 06000296 */  lhu        $v0, 0x6($s0)
    /* 6C240 8007BA40 00000000 */  nop
    /* 6C244 8007BA44 500022AE */  sw         $v0, 0x50($s1)
    /* 6C248 8007BA48 02000296 */  lhu        $v0, 0x2($s0)
    /* 6C24C 8007BA4C 00000000 */  nop
    /* 6C250 8007BA50 540022AE */  sw         $v0, 0x54($s1)
  .L8007BA54:
    /* 6C254 8007BA54 0400C624 */  addiu      $a2, $a2, 0x4
    /* 6C258 8007BA58 0C00A524 */  addiu      $a1, $a1, 0xC
    /* 6C25C 8007BA5C 3CEE0108 */  j          .L8007B8F0
    /* 6C260 8007BA60 0100D626 */   addiu     $s6, $s6, 0x1
  .L8007BA64:
    /* 6C264 8007BA64 1B012292 */  lbu        $v0, 0x11B($s1)
    /* 6C268 8007BA68 00000000 */  nop
    /* 6C26C 8007BA6C 01004224 */  addiu      $v0, $v0, 0x1
    /* 6C270 8007BA70 0F004230 */  andi       $v0, $v0, 0xF
    /* 6C274 8007BA74 1B0122A2 */  sb         $v0, 0x11B($s1)
  .L8007BA78:
    /* 6C278 8007BA78 21B00000 */  addu       $s6, $zero, $zero
    /* 6C27C 8007BA7C 21802002 */  addu       $s0, $s1, $zero
    /* 6C280 8007BA80 21A00002 */  addu       $s4, $s0, $zero
    /* 6C284 8007BA84 21A80002 */  addu       $s5, $s0, $zero
  .L8007BA88:
    /* 6C288 8007BA88 1000C22A */  slti       $v0, $s6, 0x10
    /* 6C28C 8007BA8C C2004010 */  beqz       $v0, .L8007BD98
    /* 6C290 8007BA90 00000000 */   nop
    /* 6C294 8007BA94 24010382 */  lb         $v1, 0x124($s0)
    /* 6C298 8007BA98 00000000 */  nop
    /* 6C29C 8007BA9C B9006004 */  bltz       $v1, .L8007BD84
    /* 6C2A0 8007BAA0 00000000 */   nop
    /* 6C2A4 8007BAA4 0C00A28E */  lw         $v0, 0xC($s5)
    /* 6C2A8 8007BAA8 00000000 */  nop
    /* 6C2AC 8007BAAC A7004010 */  beqz       $v0, .L8007BD4C
    /* 6C2B0 8007BAB0 40006228 */   slti      $v0, $v1, 0x40
    /* 6C2B4 8007BAB4 07004014 */  bnez       $v0, .L8007BAD4
    /* 6C2B8 8007BAB8 00000000 */   nop
    /* 6C2BC 8007BABC 4C002396 */  lhu        $v1, 0x4C($s1)
    /* 6C2C0 8007BAC0 50002296 */  lhu        $v0, 0x50($s1)
    /* 6C2C4 8007BAC4 00000000 */  nop
    /* 6C2C8 8007BAC8 23906200 */  subu       $s2, $v1, $v0
    /* 6C2CC 8007BACC B8EE0108 */  j          .L8007BAE0
    /* 6C2D0 8007BAD0 21986200 */   addu      $s3, $v1, $v0
  .L8007BAD4:
    /* 6C2D4 8007BAD4 4C003396 */  lhu        $s3, 0x4C($s1)
    /* 6C2D8 8007BAD8 00000000 */  nop
    /* 6C2DC 8007BADC 21906002 */  addu       $s2, $s3, $zero
  .L8007BAE0:
    /* 6C2E0 8007BAE0 0D9A030C */  jal        SNDplaysetdef
    /* 6C2E4 8007BAE4 1000A427 */   addiu     $a0, $sp, 0x10
    /* 6C2E8 8007BAE8 58002292 */  lbu        $v0, 0x58($s1)
    /* 6C2EC 8007BAEC 00000000 */  nop
    /* 6C2F0 8007BAF0 1400A2A3 */  sb         $v0, 0x14($sp)
    /* 6C2F4 8007BAF4 24010282 */  lb         $v0, 0x124($s0)
    /* 6C2F8 8007BAF8 1800A0A3 */  sb         $zero, 0x18($sp)
    /* 6C2FC 8007BAFC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 6C300 8007BB00 54002396 */  lhu        $v1, 0x54($s1)
    /* 6C304 8007BB04 01000224 */  addiu      $v0, $zero, 0x1
    /* 6C308 8007BB08 1B00A2A3 */  sb         $v0, 0x1B($sp)
    /* 6C30C 8007BB0C 2200A0A7 */  sh         $zero, 0x22($sp)
    /* 6C310 8007BB10 1C00A3A7 */  sh         $v1, 0x1C($sp)
    /* 6C314 8007BB14 E401028E */  lw         $v0, 0x1E4($s0)
    /* 6C318 8007BB18 00000000 */  nop
    /* 6C31C 8007BB1C 0B005714 */  bne        $v0, $s7, .L8007BB4C
    /* 6C320 8007BB20 1000A427 */   addiu     $a0, $sp, 0x10
    /* 6C324 8007BB24 8C9E030C */  jal        SNDplay
    /* 6C328 8007BB28 2000B2A7 */   sh        $s2, 0x20($sp)
    /* 6C32C 8007BB2C E40102AE */  sw         $v0, 0x1E4($s0)
    /* 6C330 8007BB30 02000224 */  addiu      $v0, $zero, 0x2
    /* 6C334 8007BB34 5C0382A2 */  sb         $v0, 0x35C($s4)
    /* 6C338 8007BB38 DC0100A2 */  sb         $zero, 0x1DC($s0)
    /* 6C33C 8007BB3C E00112A6 */  sh         $s2, 0x1E0($s0)
    /* 6C340 8007BB40 54002296 */  lhu        $v0, 0x54($s1)
    /* 6C344 8007BB44 61EF0108 */  j          .L8007BD84
    /* 6C348 8007BB48 DE0102A6 */   sh        $v0, 0x1DE($s0)
  .L8007BB4C:
    /* 6C34C 8007BB4C 5000228E */  lw         $v0, 0x50($s1)
    /* 6C350 8007BB50 00000000 */  nop
    /* 6C354 8007BB54 0A004010 */  beqz       $v0, .L8007BB80
    /* 6C358 8007BB58 00000000 */   nop
    /* 6C35C 8007BB5C 24010282 */  lb         $v0, 0x124($s0)
    /* 6C360 8007BB60 00000000 */  nop
    /* 6C364 8007BB64 40004228 */  slti       $v0, $v0, 0x40
    /* 6C368 8007BB68 05004014 */  bnez       $v0, .L8007BB80
    /* 6C36C 8007BB6C 00000000 */   nop
    /* 6C370 8007BB70 A402028E */  lw         $v0, 0x2A4($s0)
    /* 6C374 8007BB74 00000000 */  nop
    /* 6C378 8007BB78 15005710 */  beq        $v0, $s7, .L8007BBD0
    /* 6C37C 8007BB7C 00000000 */   nop
  .L8007BB80:
    /* 6C380 8007BB80 DC010382 */  lb         $v1, 0x1DC($s0)
    /* 6C384 8007BB84 0C00A48E */  lw         $a0, 0xC($s5)
    /* 6C388 8007BB88 00000000 */  nop
    /* 6C38C 8007BB8C 10006410 */  beq        $v1, $a0, .L8007BBD0
    /* 6C390 8007BB90 2A108300 */   slt       $v0, $a0, $v1
    /* 6C394 8007BB94 04004010 */  beqz       $v0, .L8007BBA8
    /* 6C398 8007BB98 00000000 */   nop
    /* 6C39C 8007BB9C FEFF6324 */  addiu      $v1, $v1, -0x2
    /* 6C3A0 8007BBA0 ECEE0108 */  j          .L8007BBB0
    /* 6C3A4 8007BBA4 2A106400 */   slt       $v0, $v1, $a0
  .L8007BBA8:
    /* 6C3A8 8007BBA8 02006324 */  addiu      $v1, $v1, 0x2
    /* 6C3AC 8007BBAC 2A108300 */  slt        $v0, $a0, $v1
  .L8007BBB0:
    /* 6C3B0 8007BBB0 02004010 */  beqz       $v0, .L8007BBBC
    /* 6C3B4 8007BBB4 00000000 */   nop
    /* 6C3B8 8007BBB8 21188000 */  addu       $v1, $a0, $zero
  .L8007BBBC:
    /* 6C3BC 8007BBBC DC0103A2 */  sb         $v1, 0x1DC($s0)
    /* 6C3C0 8007BBC0 E401048E */  lw         $a0, 0x1E4($s0)
    /* 6C3C4 8007BBC4 DC010582 */  lb         $a1, 0x1DC($s0)
    /* 6C3C8 8007BBC8 A59A030C */  jal        SNDvol
    /* 6C3CC 8007BBCC 00000000 */   nop
  .L8007BBD0:
    /* 6C3D0 8007BBD0 E0010296 */  lhu        $v0, 0x1E0($s0)
    /* 6C3D4 8007BBD4 FFFF4532 */  andi       $a1, $s2, 0xFFFF
    /* 6C3D8 8007BBD8 05004510 */  beq        $v0, $a1, .L8007BBF0
    /* 6C3DC 8007BBDC 00000000 */   nop
    /* 6C3E0 8007BBE0 E401048E */  lw         $a0, 0x1E4($s0)
    /* 6C3E4 8007BBE4 39A0030C */  jal        SND3dpos
    /* 6C3E8 8007BBE8 21300000 */   addu      $a2, $zero, $zero
    /* 6C3EC 8007BBEC E00112A6 */  sh         $s2, 0x1E0($s0)
  .L8007BBF0:
    /* 6C3F0 8007BBF0 DE010296 */  lhu        $v0, 0x1DE($s0)
    /* 6C3F4 8007BBF4 5400258E */  lw         $a1, 0x54($s1)
    /* 6C3F8 8007BBF8 00000000 */  nop
    /* 6C3FC 8007BBFC 07004510 */  beq        $v0, $a1, .L8007BC1C
    /* 6C400 8007BC00 00000000 */   nop
    /* 6C404 8007BC04 E401048E */  lw         $a0, 0x1E4($s0)
    /* 6C408 8007BC08 C29F030C */  jal        SNDpitchmult
    /* 6C40C 8007BC0C 00000000 */   nop
    /* 6C410 8007BC10 54002296 */  lhu        $v0, 0x54($s1)
    /* 6C414 8007BC14 00000000 */  nop
    /* 6C418 8007BC18 DE0102A6 */  sh         $v0, 0x1DE($s0)
  .L8007BC1C:
    /* 6C41C 8007BC1C 24010282 */  lb         $v0, 0x124($s0)
    /* 6C420 8007BC20 00000000 */  nop
    /* 6C424 8007BC24 40004228 */  slti       $v0, $v0, 0x40
    /* 6C428 8007BC28 3E004014 */  bnez       $v0, .L8007BD24
    /* 6C42C 8007BC2C 00000000 */   nop
    /* 6C430 8007BC30 5000228E */  lw         $v0, 0x50($s1)
    /* 6C434 8007BC34 00000000 */  nop
    /* 6C438 8007BC38 3A004010 */  beqz       $v0, .L8007BD24
    /* 6C43C 8007BC3C 00000000 */   nop
    /* 6C440 8007BC40 A402028E */  lw         $v0, 0x2A4($s0)
    /* 6C444 8007BC44 00000000 */  nop
    /* 6C448 8007BC48 0F005714 */  bne        $v0, $s7, .L8007BC88
    /* 6C44C 8007BC4C 00000000 */   nop
    /* 6C450 8007BC50 5C038292 */  lbu        $v0, 0x35C($s4)
    /* 6C454 8007BC54 00000000 */  nop
    /* 6C458 8007BC58 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 6C45C 8007BC5C 5C0382A2 */  sb         $v0, 0x35C($s4)
    /* 6C460 8007BC60 00160200 */  sll        $v0, $v0, 24
    /* 6C464 8007BC64 03160200 */  sra        $v0, $v0, 24
    /* 6C468 8007BC68 46005714 */  bne        $v0, $s7, .L8007BD84
    /* 6C46C 8007BC6C 1000A427 */   addiu     $a0, $sp, 0x10
    /* 6C470 8007BC70 8C9E030C */  jal        SNDplay
    /* 6C474 8007BC74 2000B3A7 */   sh        $s3, 0x20($sp)
    /* 6C478 8007BC78 A40202AE */  sw         $v0, 0x2A4($s0)
    /* 6C47C 8007BC7C 9C0200A2 */  sb         $zero, 0x29C($s0)
    /* 6C480 8007BC80 46EF0108 */  j          .L8007BD18
    /* 6C484 8007BC84 A00213A6 */   sh        $s3, 0x2A0($s0)
  .L8007BC88:
    /* 6C488 8007BC88 9C020382 */  lb         $v1, 0x29C($s0)
    /* 6C48C 8007BC8C 0C00A48E */  lw         $a0, 0xC($s5)
    /* 6C490 8007BC90 00000000 */  nop
    /* 6C494 8007BC94 10006410 */  beq        $v1, $a0, .L8007BCD8
    /* 6C498 8007BC98 2A108300 */   slt       $v0, $a0, $v1
    /* 6C49C 8007BC9C 04004010 */  beqz       $v0, .L8007BCB0
    /* 6C4A0 8007BCA0 00000000 */   nop
    /* 6C4A4 8007BCA4 FEFF6324 */  addiu      $v1, $v1, -0x2
    /* 6C4A8 8007BCA8 2EEF0108 */  j          .L8007BCB8
    /* 6C4AC 8007BCAC 2A106400 */   slt       $v0, $v1, $a0
  .L8007BCB0:
    /* 6C4B0 8007BCB0 02006324 */  addiu      $v1, $v1, 0x2
    /* 6C4B4 8007BCB4 2A108300 */  slt        $v0, $a0, $v1
  .L8007BCB8:
    /* 6C4B8 8007BCB8 02004010 */  beqz       $v0, .L8007BCC4
    /* 6C4BC 8007BCBC 00000000 */   nop
    /* 6C4C0 8007BCC0 21188000 */  addu       $v1, $a0, $zero
  .L8007BCC4:
    /* 6C4C4 8007BCC4 9C0203A2 */  sb         $v1, 0x29C($s0)
    /* 6C4C8 8007BCC8 A402048E */  lw         $a0, 0x2A4($s0)
    /* 6C4CC 8007BCCC 9C020582 */  lb         $a1, 0x29C($s0)
    /* 6C4D0 8007BCD0 A59A030C */  jal        SNDvol
    /* 6C4D4 8007BCD4 00000000 */   nop
  .L8007BCD8:
    /* 6C4D8 8007BCD8 A0020296 */  lhu        $v0, 0x2A0($s0)
    /* 6C4DC 8007BCDC FFFF6532 */  andi       $a1, $s3, 0xFFFF
    /* 6C4E0 8007BCE0 05004510 */  beq        $v0, $a1, .L8007BCF8
    /* 6C4E4 8007BCE4 00000000 */   nop
    /* 6C4E8 8007BCE8 A402048E */  lw         $a0, 0x2A4($s0)
    /* 6C4EC 8007BCEC 39A0030C */  jal        SND3dpos
    /* 6C4F0 8007BCF0 21300000 */   addu      $a2, $zero, $zero
    /* 6C4F4 8007BCF4 A00213A6 */  sh         $s3, 0x2A0($s0)
  .L8007BCF8:
    /* 6C4F8 8007BCF8 9E020296 */  lhu        $v0, 0x29E($s0)
    /* 6C4FC 8007BCFC 5400258E */  lw         $a1, 0x54($s1)
    /* 6C500 8007BD00 00000000 */  nop
    /* 6C504 8007BD04 1F004510 */  beq        $v0, $a1, .L8007BD84
    /* 6C508 8007BD08 00000000 */   nop
    /* 6C50C 8007BD0C A402048E */  lw         $a0, 0x2A4($s0)
    /* 6C510 8007BD10 C29F030C */  jal        SNDpitchmult
    /* 6C514 8007BD14 00000000 */   nop
  .L8007BD18:
    /* 6C518 8007BD18 54002296 */  lhu        $v0, 0x54($s1)
    /* 6C51C 8007BD1C 61EF0108 */  j          .L8007BD84
    /* 6C520 8007BD20 9E0202A6 */   sh        $v0, 0x29E($s0)
  .L8007BD24:
    /* 6C524 8007BD24 A402048E */  lw         $a0, 0x2A4($s0)
    /* 6C528 8007BD28 00000000 */  nop
    /* 6C52C 8007BD2C 15009710 */  beq        $a0, $s7, .L8007BD84
    /* 6C530 8007BD30 00000000 */   nop
    /* 6C534 8007BD34 A09F030C */  jal        SNDstop
    /* 6C538 8007BD38 00000000 */   nop
    /* 6C53C 8007BD3C 02000224 */  addiu      $v0, $zero, 0x2
    /* 6C540 8007BD40 A40217AE */  sw         $s7, 0x2A4($s0)
    /* 6C544 8007BD44 61EF0108 */  j          .L8007BD84
    /* 6C548 8007BD48 5C0382A2 */   sb        $v0, 0x35C($s4)
  .L8007BD4C:
    /* 6C54C 8007BD4C E401048E */  lw         $a0, 0x1E4($s0)
    /* 6C550 8007BD50 00000000 */  nop
    /* 6C554 8007BD54 0B009710 */  beq        $a0, $s7, .L8007BD84
    /* 6C558 8007BD58 00000000 */   nop
    /* 6C55C 8007BD5C A09F030C */  jal        SNDstop
    /* 6C560 8007BD60 00000000 */   nop
    /* 6C564 8007BD64 A402048E */  lw         $a0, 0x2A4($s0)
    /* 6C568 8007BD68 00000000 */  nop
    /* 6C56C 8007BD6C 03009710 */  beq        $a0, $s7, .L8007BD7C
    /* 6C570 8007BD70 00000000 */   nop
    /* 6C574 8007BD74 A09F030C */  jal        SNDstop
    /* 6C578 8007BD78 00000000 */   nop
  .L8007BD7C:
    /* 6C57C 8007BD7C E40117AE */  sw         $s7, 0x1E4($s0)
    /* 6C580 8007BD80 A40217AE */  sw         $s7, 0x2A4($s0)
  .L8007BD84:
    /* 6C584 8007BD84 01009426 */  addiu      $s4, $s4, 0x1
    /* 6C588 8007BD88 0C001026 */  addiu      $s0, $s0, 0xC
    /* 6C58C 8007BD8C 0400B526 */  addiu      $s5, $s5, 0x4
    /* 6C590 8007BD90 A2EE0108 */  j          .L8007BA88
    /* 6C594 8007BD94 0100D626 */   addiu     $s6, $s6, 0x1
  .L8007BD98:
    /* 6C598 8007BD98 2800A78F */  lw         $a3, 0x28($sp)
    /* 6C59C 8007BD9C 00000000 */  nop
    /* 6C5A0 8007BDA0 0100E724 */  addiu      $a3, $a3, 0x1
    /* 6C5A4 8007BDA4 18EE0108 */  j          .L8007B860
    /* 6C5A8 8007BDA8 2800A7AF */   sw        $a3, 0x28($sp)
  .L8007BDAC:
    /* 6C5AC 8007BDAC 5400BF8F */  lw         $ra, 0x54($sp)
    /* 6C5B0 8007BDB0 5000BE8F */  lw         $fp, 0x50($sp)
    /* 6C5B4 8007BDB4 4C00B78F */  lw         $s7, 0x4C($sp)
    /* 6C5B8 8007BDB8 4800B68F */  lw         $s6, 0x48($sp)
    /* 6C5BC 8007BDBC 4400B58F */  lw         $s5, 0x44($sp)
    /* 6C5C0 8007BDC0 4000B48F */  lw         $s4, 0x40($sp)
    /* 6C5C4 8007BDC4 3C00B38F */  lw         $s3, 0x3C($sp)
    /* 6C5C8 8007BDC8 3800B28F */  lw         $s2, 0x38($sp)
    /* 6C5CC 8007BDCC 3400B18F */  lw         $s1, 0x34($sp)
    /* 6C5D0 8007BDD0 3000B08F */  lw         $s0, 0x30($sp)
    /* 6C5D4 8007BDD4 0800E003 */  jr         $ra
    /* 6C5D8 8007BDD8 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel AudioEng_Update__Fv
