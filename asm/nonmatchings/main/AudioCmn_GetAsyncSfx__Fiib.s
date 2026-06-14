.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioCmn_GetAsyncSfx__Fiib, 0x174

glabel AudioCmn_GetAsyncSfx__Fiib
    /* 67100 80076900 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* 67104 80076904 3400B1AF */  sw         $s1, 0x34($sp)
    /* 67108 80076908 21888000 */  addu       $s1, $a0, $zero
    /* 6710C 8007690C 3800B2AF */  sw         $s2, 0x38($sp)
    /* 67110 80076910 2190A000 */  addu       $s2, $a1, $zero
    /* 67114 80076914 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* 67118 80076918 2198C000 */  addu       $s3, $a2, $zero
    /* 6711C 8007691C 3000B0AF */  sw         $s0, 0x30($sp)
    /* 67120 80076920 21800000 */  addu       $s0, $zero, $zero
    /* 67124 80076924 1180023C */  lui        $v0, %hi(AudioCmn_gSfxSlot)
    /* 67128 80076928 34EB4424 */  addiu      $a0, $v0, %lo(AudioCmn_gSfxSlot)
    /* 6712C 8007692C 4000BFAF */  sw         $ra, 0x40($sp)
  .L80076930:
    /* 67130 80076930 2000022A */  slti       $v0, $s0, 0x20
    /* 67134 80076934 0C004010 */  beqz       $v0, .L80076968
    /* 67138 80076938 21188000 */   addu      $v1, $a0, $zero
    /* 6713C 8007693C 0400628C */  lw         $v0, 0x4($v1)
    /* 67140 80076940 00000000 */  nop
    /* 67144 80076944 05004216 */  bne        $s2, $v0, .L8007695C
    /* 67148 80076948 00000000 */   nop
    /* 6714C 8007694C 0000628C */  lw         $v0, 0x0($v1)
    /* 67150 80076950 00000000 */  nop
    /* 67154 80076954 1F002212 */  beq        $s1, $v0, .L800769D4
    /* 67158 80076958 00000000 */   nop
  .L8007695C:
    /* 6715C 8007695C 18006424 */  addiu      $a0, $v1, 0x18
    /* 67160 80076960 4CDA0108 */  j          .L80076930
    /* 67164 80076964 01001026 */   addiu     $s0, $s0, 0x1
  .L80076968:
    /* 67168 80076968 21800000 */  addu       $s0, $zero, $zero
    /* 6716C 8007696C FFFF0424 */  addiu      $a0, $zero, -0x1
    /* 67170 80076970 1180023C */  lui        $v0, %hi(AudioCmn_gSfxSlot)
    /* 67174 80076974 34EB4324 */  addiu      $v1, $v0, %lo(AudioCmn_gSfxSlot)
  .L80076978:
    /* 67178 80076978 0400628C */  lw         $v0, 0x4($v1)
    /* 6717C 8007697C 00000000 */  nop
    /* 67180 80076980 05004410 */  beq        $v0, $a0, .L80076998
    /* 67184 80076984 00000000 */   nop
    /* 67188 80076988 01001026 */  addiu      $s0, $s0, 0x1
    /* 6718C 8007698C 2000022A */  slti       $v0, $s0, 0x20
    /* 67190 80076990 F9FF4014 */  bnez       $v0, .L80076978
    /* 67194 80076994 18006324 */   addiu     $v1, $v1, 0x18
  .L80076998:
    /* 67198 80076998 08006016 */  bnez       $s3, .L800769BC
    /* 6719C 8007699C 2000022E */   sltiu     $v0, $s0, 0x20
    /* 671A0 800769A0 20000224 */  addiu      $v0, $zero, 0x20
    /* 671A4 800769A4 05000216 */  bne        $s0, $v0, .L800769BC
    /* 671A8 800769A8 2000022E */   sltiu     $v0, $s0, 0x20
    /* 671AC 800769AC 9DD9010C */  jal        AudioCmn_RemoveOldestAsyncSfx__Fi
    /* 671B0 800769B0 21202002 */   addu      $a0, $s1, $zero
    /* 671B4 800769B4 21804000 */  addu       $s0, $v0, $zero
    /* 671B8 800769B8 2000022E */  sltiu      $v0, $s0, 0x20
  .L800769BC:
    /* 671BC 800769BC 26004010 */  beqz       $v0, .L80076A58
    /* 671C0 800769C0 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 671C4 800769C4 08006012 */  beqz       $s3, .L800769E8
    /* 671C8 800769C8 1180033C */   lui       $v1, %hi(AudioCmn_gSfxSlot)
    /* 671CC 800769CC 8BDA0108 */  j          .L80076A2C
    /* 671D0 800769D0 34EB6324 */   addiu     $v1, $v1, %lo(AudioCmn_gSfxSlot)
  .L800769D4:
    /* 671D4 800769D4 1280033C */  lui        $v1, %hi(D_8011E0B0)
    /* 671D8 800769D8 B0E0638C */  lw         $v1, %lo(D_8011E0B0)($v1)
    /* 671DC 800769DC 0800828C */  lw         $v0, 0x8($a0)
    /* 671E0 800769E0 96DA0108 */  j          .L80076A58
    /* 671E4 800769E4 0C0083AC */   sw        $v1, 0xC($a0)
  .L800769E8:
    /* 671E8 800769E8 186B020C */  jal        CopSpeak_SfxQueued__Fv
    /* 671EC 800769EC 00000000 */   nop
    /* 671F0 800769F0 06004228 */  slti       $v0, $v0, 0x6
    /* 671F4 800769F4 18004010 */  beqz       $v0, .L80076A58
    /* 671F8 800769F8 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* 671FC 800769FC 7C65020C */  jal        CopSpeak_InitRequest__FP17CopSpeak_tRequest
    /* 67200 80076A00 1000A427 */   addiu     $a0, $sp, 0x10
    /* 67204 80076A04 1000A427 */  addiu      $a0, $sp, 0x10
    /* 67208 80076A08 01000224 */  addiu      $v0, $zero, 0x1
    /* 6720C 80076A0C 2800B2AF */  sw         $s2, 0x28($sp)
    /* 67210 80076A10 2D00A2A3 */  sb         $v0, 0x2D($sp)
    /* 67214 80076A14 3269020C */  jal        CopSpeak_Request__FP17CopSpeak_tRequest
    /* 67218 80076A18 2E00B1A3 */   sb        $s1, 0x2E($sp)
    /* 6721C 80076A1C FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 67220 80076A20 0C004310 */  beq        $v0, $v1, .L80076A54
    /* 67224 80076A24 1180033C */   lui       $v1, %hi(AudioCmn_gSfxSlot)
    /* 67228 80076A28 34EB6324 */  addiu      $v1, $v1, %lo(AudioCmn_gSfxSlot)
  .L80076A2C:
    /* 6722C 80076A2C 40101000 */  sll        $v0, $s0, 1
    /* 67230 80076A30 21105000 */  addu       $v0, $v0, $s0
    /* 67234 80076A34 C0100200 */  sll        $v0, $v0, 3
    /* 67238 80076A38 21104300 */  addu       $v0, $v0, $v1
    /* 6723C 80076A3C 1280033C */  lui        $v1, %hi(D_8011E0B0)
    /* 67240 80076A40 000051AC */  sw         $s1, 0x0($v0)
    /* 67244 80076A44 040052AC */  sw         $s2, 0x4($v0)
    /* 67248 80076A48 B0E0638C */  lw         $v1, %lo(D_8011E0B0)($v1)
    /* 6724C 80076A4C 00000000 */  nop
    /* 67250 80076A50 0C0043AC */  sw         $v1, 0xC($v0)
  .L80076A54:
    /* 67254 80076A54 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L80076A58:
    /* 67258 80076A58 4000BF8F */  lw         $ra, 0x40($sp)
    /* 6725C 80076A5C 3C00B38F */  lw         $s3, 0x3C($sp)
    /* 67260 80076A60 3800B28F */  lw         $s2, 0x38($sp)
    /* 67264 80076A64 3400B18F */  lw         $s1, 0x34($sp)
    /* 67268 80076A68 3000B08F */  lw         $s0, 0x30($sp)
    /* 6726C 80076A6C 0800E003 */  jr         $ra
    /* 67270 80076A70 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel AudioCmn_GetAsyncSfx__Fiib
