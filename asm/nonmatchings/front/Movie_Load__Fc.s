.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Movie_Load__Fc, 0x1AC

glabel Movie_Load__Fc
    /* 3D184 8004C984 78FFBD27 */  addiu      $sp, $sp, -0x88
    /* 3D188 8004C988 7800B0AF */  sw         $s0, 0x78($sp)
    /* 3D18C 8004C98C 21808000 */  addu       $s0, $a0, $zero
    /* 3D190 8004C990 0580023C */  lui        $v0, %hi(D_80052D14)
    /* 3D194 8004C994 142D40AC */  sw         $zero, %lo(D_80052D14)($v0)
    /* 3D198 8004C998 0580023C */  lui        $v0, %hi(D_80052D1C)
    /* 3D19C 8004C99C 1C2D40AC */  sw         $zero, %lo(D_80052D1C)($v0)
    /* 3D1A0 8004C9A0 0580023C */  lui        $v0, %hi(D_80052D18)
    /* 3D1A4 8004C9A4 182D40AC */  sw         $zero, %lo(D_80052D18)($v0)
    /* 3D1A8 8004C9A8 0580023C */  lui        $v0, %hi(download)
    /* 3D1AC 8004C9AC 302A40A4 */  sh         $zero, %lo(download)($v0)
    /* 3D1B0 8004C9B0 0580023C */  lui        $v0, %hi(D_80052D20)
    /* 3D1B4 8004C9B4 8000B2AF */  sw         $s2, 0x80($sp)
    /* 3D1B8 8004C9B8 01001224 */  addiu      $s2, $zero, 0x1
    /* 3D1BC 8004C9BC 8400BFAF */  sw         $ra, 0x84($sp)
    /* 3D1C0 8004C9C0 7C00B1AF */  sw         $s1, 0x7C($sp)
    /* 3D1C4 8004C9C4 13CA030C */  jal        ResetCallback
    /* 3D1C8 8004C9C8 202D52AC */   sw        $s2, %lo(D_80052D20)($v0)
    /* 3D1CC 8004C9CC 2800A427 */  addiu      $a0, $sp, 0x28
    /* 3D1D0 8004C9D0 0580023C */  lui        $v0, %hi(movienames)
    /* 3D1D4 8004C9D4 D8294224 */  addiu      $v0, $v0, %lo(movienames)
    /* 3D1D8 8004C9D8 FF001032 */  andi       $s0, $s0, 0xFF
    /* 3D1DC 8004C9DC 80881000 */  sll        $s1, $s0, 2
    /* 3D1E0 8004C9E0 21102202 */  addu       $v0, $s1, $v0
    /* 3D1E4 8004C9E4 0180053C */  lui        $a1, %hi(D_800127B4)
    /* 3D1E8 8004C9E8 0000468C */  lw         $a2, 0x0($v0)
    /* 3D1EC 8004C9EC 2F91030C */  jal        sprintf
    /* 3D1F0 8004C9F0 B427A524 */   addiu     $a1, $a1, %lo(D_800127B4)
    /* 3D1F4 8004C9F4 0580023C */  lui        $v0, %hi(D_80052D0C)
    /* 3D1F8 8004C9F8 0C2D40AC */  sw         $zero, %lo(D_80052D0C)($v0)
    /* 3D1FC 8004C9FC 0580023C */  lui        $v0, %hi(movieframes)
    /* 3D200 8004CA00 EC294224 */  addiu      $v0, $v0, %lo(movieframes)
    /* 3D204 8004CA04 04805002 */  sllv       $s0, $s0, $s2
    /* 3D208 8004CA08 21100202 */  addu       $v0, $s0, $v0
    /* 3D20C 8004CA0C 00004284 */  lh         $v0, 0x0($v0)
    /* 3D210 8004CA10 0580033C */  lui        $v1, %hi(D_80052D10)
    /* 3D214 8004CA14 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 3D218 8004CA18 102D62AC */  sw         $v0, %lo(D_80052D10)($v1)
    /* 3D21C 8004CA1C 0580023C */  lui        $v0, %hi(movie24bit)
    /* 3D220 8004CA20 F8294224 */  addiu      $v0, $v0, %lo(movie24bit)
    /* 3D224 8004CA24 21882202 */  addu       $s1, $s1, $v0
    /* 3D228 8004CA28 0000248E */  lw         $a0, 0x0($s1)
    /* 3D22C 8004CA2C 0580023C */  lui        $v0, %hi(D_80052D04)
    /* 3D230 8004CA30 042D44AC */  sw         $a0, %lo(D_80052D04)($v0)
    /* 3D234 8004CA34 0580023C */  lui        $v0, %hi(moviewidth)
    /* 3D238 8004CA38 182A4224 */  addiu      $v0, $v0, %lo(moviewidth)
    /* 3D23C 8004CA3C 21100202 */  addu       $v0, $s0, $v0
    /* 3D240 8004CA40 00004394 */  lhu        $v1, 0x0($v0)
    /* 3D244 8004CA44 0580023C */  lui        $v0, %hi(D_80052D0A)
    /* 3D248 8004CA48 0A2D43A4 */  sh         $v1, %lo(D_80052D0A)($v0)
    /* 3D24C 8004CA4C 0580023C */  lui        $v0, %hi(movieheight)
    /* 3D250 8004CA50 0C2A4224 */  addiu      $v0, $v0, %lo(movieheight)
    /* 3D254 8004CA54 21800202 */  addu       $s0, $s0, $v0
    /* 3D258 8004CA58 00000396 */  lhu        $v1, 0x0($s0)
    /* 3D25C 8004CA5C 0580023C */  lui        $v0, %hi(D_80052D08)
    /* 3D260 8004CA60 0A008010 */  beqz       $a0, .L8004CA8C
    /* 3D264 8004CA64 082D43A4 */   sh        $v1, %lo(D_80052D08)($v0)
    /* 3D268 8004CA68 0580023C */  lui        $v0, %hi(D_80052CFC)
    /* 3D26C 8004CA6C 03000424 */  addiu      $a0, $zero, 0x3
    /* 3D270 8004CA70 0580033C */  lui        $v1, %hi(D_80052CFE)
    /* 3D274 8004CA74 FC2C44A4 */  sh         $a0, %lo(D_80052CFC)($v0)
    /* 3D278 8004CA78 02000224 */  addiu      $v0, $zero, 0x2
    /* 3D27C 8004CA7C FE2C62A4 */  sh         $v0, %lo(D_80052CFE)($v1)
    /* 3D280 8004CA80 0580023C */  lui        $v0, %hi(D_80052D00)
    /* 3D284 8004CA84 AA320108 */  j          .L8004CAA8
    /* 3D288 8004CA88 002D44A4 */   sh        $a0, %lo(D_80052D00)($v0)
  .L8004CA8C:
    /* 3D28C 8004CA8C 0580023C */  lui        $v0, %hi(D_80052CFC)
    /* 3D290 8004CA90 FC2C52A4 */  sh         $s2, %lo(D_80052CFC)($v0)
    /* 3D294 8004CA94 0580023C */  lui        $v0, %hi(D_80052CFE)
    /* 3D298 8004CA98 0580033C */  lui        $v1, %hi(D_80052D00)
    /* 3D29C 8004CA9C FE2C52A4 */  sh         $s2, %lo(D_80052CFE)($v0)
    /* 3D2A0 8004CAA0 02000224 */  addiu      $v0, $zero, 0x2
    /* 3D2A4 8004CAA4 002D62A4 */  sh         $v0, %lo(D_80052D00)($v1)
  .L8004CAA8:
    /* 3D2A8 8004CAA8 1000A427 */  addiu      $a0, $sp, 0x10
    /* 3D2AC 8004CAAC 22E4030C */  jal        CdSearchFile
    /* 3D2B0 8004CAB0 2800A527 */   addiu     $a1, $sp, 0x28
    /* 3D2B4 8004CAB4 18004010 */  beqz       $v0, .L8004CB18
    /* 3D2B8 8004CAB8 0580113C */   lui       $s1, %hi(D_80052D28)
    /* 3D2BC 8004CABC 282D3126 */  addiu      $s1, $s1, %lo(D_80052D28)
    /* 3D2C0 8004CAC0 21202002 */  addu       $a0, $s1, $zero
    /* 3D2C4 8004CAC4 1000A293 */  lbu        $v0, 0x10($sp)
    /* 3D2C8 8004CAC8 1200A393 */  lbu        $v1, 0x12($sp)
    /* 3D2CC 8004CACC 0580103C */  lui        $s0, %hi(D_80052CF8)
    /* 3D2D0 8004CAD0 F82C02A2 */  sb         $v0, %lo(D_80052CF8)($s0)
    /* 3D2D4 8004CAD4 1100A293 */  lbu        $v0, 0x11($sp)
    /* 3D2D8 8004CAD8 F82C1026 */  addiu      $s0, $s0, %lo(D_80052CF8)
    /* 3D2DC 8004CADC 020003A2 */  sb         $v1, 0x2($s0)
    /* 3D2E0 8004CAE0 C533010C */  jal        strSetDefDecEnv__FP6DECENV
    /* 3D2E4 8004CAE4 010002A2 */   sb        $v0, 0x1($s0)
    /* 3D2E8 8004CAE8 21200002 */  addu       $a0, $s0, $zero
    /* 3D2EC 8004CAEC FF0F053C */  lui        $a1, (0xFFFFFFF >> 16)
    /* 3D2F0 8004CAF0 FFFFA534 */  ori        $a1, $a1, (0xFFFFFFF & 0xFFFF)
    /* 3D2F4 8004CAF4 0580063C */  lui        $a2, %hi(strCallback__Fv)
    /* 3D2F8 8004CAF8 38D0C624 */  addiu      $a2, $a2, %lo(strCallback__Fv)
    /* 3D2FC 8004CAFC E833010C */  jal        strInit__FP6CdlLOCiPFe_vT2
    /* 3D300 8004CB00 21380000 */   addu      $a3, $zero, $zero
    /* 3D304 8004CB04 CD34010C */  jal        strNextVlc__FP6DECENV
    /* 3D308 8004CB08 21202002 */   addu      $a0, $s1, $zero
    /* 3D30C 8004CB0C 0580033C */  lui        $v1, %hi(D_80052D14)
    /* 3D310 8004CB10 01000224 */  addiu      $v0, $zero, 0x1
    /* 3D314 8004CB14 142D62AC */  sw         $v0, %lo(D_80052D14)($v1)
  .L8004CB18:
    /* 3D318 8004CB18 8400BF8F */  lw         $ra, 0x84($sp)
    /* 3D31C 8004CB1C 8000B28F */  lw         $s2, 0x80($sp)
    /* 3D320 8004CB20 7C00B18F */  lw         $s1, 0x7C($sp)
    /* 3D324 8004CB24 7800B08F */  lw         $s0, 0x78($sp)
    /* 3D328 8004CB28 0800E003 */  jr         $ra
    /* 3D32C 8004CB2C 8800BD27 */   addiu     $sp, $sp, 0x88
endlabel Movie_Load__Fc
