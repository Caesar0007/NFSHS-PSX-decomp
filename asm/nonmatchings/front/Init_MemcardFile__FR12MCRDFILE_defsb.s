.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Init_MemcardFile__FR12MCRDFILE_defsb, 0xE8

glabel Init_MemcardFile__FR12MCRDFILE_defsb
    /* 250A0 800348A0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 250A4 800348A4 1800B2AF */  sw         $s2, 0x18($sp)
    /* 250A8 800348A8 21908000 */  addu       $s2, $a0, $zero
    /* 250AC 800348AC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 250B0 800348B0 2188A000 */  addu       $s1, $a1, $zero
    /* 250B4 800348B4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 250B8 800348B8 2180C000 */  addu       $s0, $a2, $zero
    /* 250BC 800348BC 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 250C0 800348C0 E8C5030C */  jal        blockclear
    /* 250C4 800348C4 2C000524 */   addiu     $a1, $zero, 0x2C
    /* 250C8 800348C8 0180023C */  lui        $v0, %hi(D_800116DC)
    /* 250CC 800348CC DC164224 */  addiu      $v0, $v0, %lo(D_800116DC)
    /* 250D0 800348D0 04000012 */  beqz       $s0, .L800348E4
    /* 250D4 800348D4 000042AE */   sw        $v0, 0x0($s2)
    /* 250D8 800348D8 0580023C */  lui        $v0, %hi(D_80052B68)
    /* 250DC 800348DC 56D20008 */  j          .L80034958
    /* 250E0 800348E0 682B40A0 */   sb        $zero, %lo(D_80052B68)($v0)
  .L800348E4:
    /* 250E4 800348E4 00141100 */  sll        $v0, $s1, 16
    /* 250E8 800348E8 03140200 */  sra        $v0, $v0, 16
    /* 250EC 800348EC 05004238 */  xori       $v0, $v0, 0x5
    /* 250F0 800348F0 0100502C */  sltiu      $s0, $v0, 0x1
    /* 250F4 800348F4 74AE000C */  jal        PlayerNameExist__Fi
    /* 250F8 800348F8 21200002 */   addu      $a0, $s0, $zero
    /* 250FC 800348FC 0F004010 */  beqz       $v0, .L8003493C
    /* 25100 80034900 00000000 */   nop
    /* 25104 80034904 94E4020C */  jal        TextSys_Word__Fi
    /* 25108 80034908 78020424 */   addiu     $a0, $zero, 0x278
    /* 2510C 8003490C 21200002 */  addu       $a0, $s0, $zero
    /* 25110 80034910 7FAE000C */  jal        PlayerName__Fi
    /* 25114 80034914 21804000 */   addu      $s0, $v0, $zero
    /* 25118 80034918 0580043C */  lui        $a0, %hi(D_80052B68)
    /* 2511C 8003491C 682B8424 */  addiu      $a0, $a0, %lo(D_80052B68)
    /* 25120 80034920 0180053C */  lui        $a1, %hi(D_800116E4)
    /* 25124 80034924 E416A524 */  addiu      $a1, $a1, %lo(D_800116E4)
    /* 25128 80034928 21300002 */  addu       $a2, $s0, $zero
    /* 2512C 8003492C 2F91030C */  jal        sprintf
    /* 25130 80034930 21384000 */   addu      $a3, $v0, $zero
    /* 25134 80034934 56D20008 */  j          .L80034958
    /* 25138 80034938 0580023C */   lui       $v0, %hi(D_80052B68)
  .L8003493C:
    /* 2513C 8003493C 94E4020C */  jal        TextSys_Word__Fi
    /* 25140 80034940 79020424 */   addiu     $a0, $zero, 0x279
    /* 25144 80034944 0580043C */  lui        $a0, %hi(D_80052B68)
    /* 25148 80034948 682B8424 */  addiu      $a0, $a0, %lo(D_80052B68)
    /* 2514C 8003494C 2F91030C */  jal        sprintf
    /* 25150 80034950 21284000 */   addu      $a1, $v0, $zero
    /* 25154 80034954 0580023C */  lui        $v0, %hi(D_80052B68)
  .L80034958:
    /* 25158 80034958 682B4224 */  addiu      $v0, $v0, %lo(D_80052B68)
    /* 2515C 8003495C 040042AE */  sw         $v0, 0x4($s2)
    /* 25160 80034960 00150224 */  addiu      $v0, $zero, 0x1500
    /* 25164 80034964 080042AE */  sw         $v0, 0x8($s2)
    /* 25168 80034968 0C0040AE */  sw         $zero, 0xC($s2)
    /* 2516C 8003496C 100040AE */  sw         $zero, 0x10($s2)
    /* 25170 80034970 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 25174 80034974 1800B28F */  lw         $s2, 0x18($sp)
    /* 25178 80034978 1400B18F */  lw         $s1, 0x14($sp)
    /* 2517C 8003497C 1000B08F */  lw         $s0, 0x10($sp)
    /* 25180 80034980 0800E003 */  jr         $ra
    /* 25184 80034984 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Init_MemcardFile__FR12MCRDFILE_defsb
