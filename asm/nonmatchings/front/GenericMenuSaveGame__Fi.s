.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GenericMenuSaveGame__Fi, 0x11C

glabel GenericMenuSaveGame__Fi
    /* 1D1A0 8002C9A0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 1D1A4 8002C9A4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 1D1A8 8002C9A8 21808000 */  addu       $s0, $a0, $zero
    /* 1D1AC 8002C9AC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 1D1B0 8002C9B0 0580113C */  lui        $s1, %hi(FEApp)
    /* 1D1B4 8002C9B4 0580023C */  lui        $v0, %hi(screenMemcard)
    /* 1D1B8 8002C9B8 C014248E */  lw         $a0, %lo(FEApp)($s1)
    /* 1D1BC 8002C9BC F028438C */  lw         $v1, %lo(screenMemcard)($v0)
    /* 1D1C0 8002C9C0 7E020224 */  addiu      $v0, $zero, 0x27E
    /* 1D1C4 8002C9C4 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 1D1C8 8002C9C8 1800B2AF */  sw         $s2, 0x18($sp)
    /* 1D1CC 8002C9CC CF4D000C */  jal        Redraw__14tFEApplication
    /* 1D1D0 8002C9D0 840562AC */   sw        $v0, 0x584($v1)
    /* 1D1D4 8002C9D4 0580023C */  lui        $v0, %hi(MEMCARD_INITIALIZED)
    /* 1D1D8 8002C9D8 801A428C */  lw         $v0, %lo(MEMCARD_INITIALIZED)($v0)
    /* 1D1DC 8002C9DC 00000000 */  nop
    /* 1D1E0 8002C9E0 03004010 */  beqz       $v0, .L8002C9F0
    /* 1D1E4 8002C9E4 21900000 */   addu      $s2, $zero, $zero
    /* 1D1E8 8002C9E8 1F000012 */  beqz       $s0, .L8002CA68
    /* 1D1EC 8002C9EC 00000000 */   nop
  .L8002C9F0:
    /* 1D1F0 8002C9F0 C014308E */  lw         $s0, %lo(FEApp)($s1)
    /* 1D1F4 8002C9F4 82020424 */  addiu      $a0, $zero, 0x282
    /* 1D1F8 8002C9F8 94E4020C */  jal        TextSys_Word__Fi
    /* 1D1FC 8002C9FC D0021026 */   addiu     $s0, $s0, 0x2D0
    /* 1D200 8002CA00 C014248E */  lw         $a0, %lo(FEApp)($s1)
    /* 1D204 8002CA04 900002AE */  sw         $v0, 0x90($s0)
    /* 1D208 8002CA08 1062000C */  jal        Display__11tDialogBase
    /* 1D20C 8002CA0C D0028424 */   addiu     $a0, $a0, 0x2D0
  .L8002CA10:
    /* 1D210 8002CA10 C014248E */  lw         $a0, %lo(FEApp)($s1)
    /* 1D214 8002CA14 00000000 */  nop
    /* 1D218 8002CA18 5403828C */  lw         $v0, 0x354($a0)
    /* 1D21C 8002CA1C 00000000 */  nop
    /* 1D220 8002CA20 01004238 */  xori       $v0, $v0, 0x1
    /* 1D224 8002CA24 05004010 */  beqz       $v0, .L8002CA3C
    /* 1D228 8002CA28 00000000 */   nop
    /* 1D22C 8002CA2C CF4D000C */  jal        Redraw__14tFEApplication
    /* 1D230 8002CA30 00000000 */   nop
    /* 1D234 8002CA34 84B20008 */  j          .L8002CA10
    /* 1D238 8002CA38 00000000 */   nop
  .L8002CA3C:
    /* 1D23C 8002CA3C CF4D000C */  jal        Redraw__14tFEApplication
    /* 1D240 8002CA40 00000000 */   nop
    /* 1D244 8002CA44 0580023C */  lui        $v0, %hi(MEMCARD_INITIALIZED)
    /* 1D248 8002CA48 801A428C */  lw         $v0, %lo(MEMCARD_INITIALIZED)($v0)
    /* 1D24C 8002CA4C 00000000 */  nop
    /* 1D250 8002CA50 05004014 */  bnez       $v0, .L8002CA68
    /* 1D254 8002CA54 00000000 */   nop
    /* 1D258 8002CA58 01001224 */  addiu      $s2, $zero, 0x1
    /* 1D25C 8002CA5C 21204002 */  addu       $a0, $s2, $zero
    /* 1D260 8002CA60 A9D1000C */  jal        Init_Memcard__FbT0
    /* 1D264 8002CA64 21280000 */   addu      $a1, $zero, $zero
  .L8002CA68:
    /* 1D268 8002CA68 62D2000C */  jal        SaveGame__Fs
    /* 1D26C 8002CA6C 21200000 */   addu      $a0, $zero, $zero
    /* 1D270 8002CA70 0580033C */  lui        $v1, %hi(screenMemcard)
    /* 1D274 8002CA74 F028648C */  lw         $a0, %lo(screenMemcard)($v1)
    /* 1D278 8002CA78 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 1D27C 8002CA7C 21804000 */  addu       $s0, $v0, $zero
    /* 1D280 8002CA80 03004012 */  beqz       $s2, .L8002CA90
    /* 1D284 8002CA84 840583AC */   sw        $v1, 0x584($a0)
    /* 1D288 8002CA88 00D2000C */  jal        DeInit_Memcard__Fv
    /* 1D28C 8002CA8C 00000000 */   nop
  .L8002CA90:
    /* 1D290 8002CA90 0580023C */  lui        $v0, %hi(FEApp)
    /* 1D294 8002CA94 C014448C */  lw         $a0, %lo(FEApp)($v0)
    /* 1D298 8002CA98 4162000C */  jal        Hide__11tDialogBase
    /* 1D29C 8002CA9C D0028424 */   addiu     $a0, $a0, 0x2D0
    /* 1D2A0 8002CAA0 21100002 */  addu       $v0, $s0, $zero
    /* 1D2A4 8002CAA4 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 1D2A8 8002CAA8 1800B28F */  lw         $s2, 0x18($sp)
    /* 1D2AC 8002CAAC 1400B18F */  lw         $s1, 0x14($sp)
    /* 1D2B0 8002CAB0 1000B08F */  lw         $s0, 0x10($sp)
    /* 1D2B4 8002CAB4 0800E003 */  jr         $ra
    /* 1D2B8 8002CAB8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel GenericMenuSaveGame__Fi
