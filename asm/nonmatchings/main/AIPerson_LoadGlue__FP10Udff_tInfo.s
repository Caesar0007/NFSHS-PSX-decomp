.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPerson_LoadGlue__FP10Udff_tInfo, 0x10C

glabel AIPerson_LoadGlue__FP10Udff_tInfo
    /* 59780 80068F80 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 59784 80068F84 1000B0AF */  sw         $s0, 0x10($sp)
    /* 59788 80068F88 21808000 */  addu       $s0, $a0, $zero
    /* 5978C 80068F8C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 59790 80068F90 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 59794 80068F94 1400B1AF */   sw        $s1, 0x14($sp)
    /* 59798 80068F98 21200002 */  addu       $a0, $s0, $zero
    /* 5979C 80068F9C 1180053C */  lui        $a1, %hi(AIPerson_glueTable)
    /* 597A0 80068FA0 14D7A524 */  addiu      $a1, $a1, %lo(AIPerson_glueTable)
    /* 597A4 80068FA4 CFEE020C */  jal        Udff_GetBuffer__FP10Udff_tInfoPci
    /* 597A8 80068FA8 54000624 */   addiu     $a2, $zero, 0x54
    /* 597AC 80068FAC 1480023C */  lui        $v0, %hi(Cars_gNumCopCars)
    /* 597B0 80068FB0 0CC8428C */  lw         $v0, %lo(Cars_gNumCopCars)($v0)
    /* 597B4 80068FB4 00000000 */  nop
    /* 597B8 80068FB8 2F004010 */  beqz       $v0, .L80069078
    /* 597BC 80068FBC 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* 597C0 80068FC0 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 597C4 80068FC4 01000224 */  addiu      $v0, $zero, 0x1
    /* 597C8 80068FC8 03006210 */  beq        $v1, $v0, .L80068FD8
    /* 597CC 80068FCC 05000224 */   addiu     $v0, $zero, 0x5
    /* 597D0 80068FD0 15006214 */  bne        $v1, $v0, .L80069028
    /* 597D4 80068FD4 21880000 */   addu      $s1, $zero, $zero
  .L80068FD8:
    /* 597D8 80068FD8 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* 597DC 80068FDC 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* 597E0 80068FE0 00000000 */  nop
    /* 597E4 80068FE4 6002428C */  lw         $v0, 0x260($v0)
    /* 597E8 80068FE8 00000000 */  nop
    /* 597EC 80068FEC 00024230 */  andi       $v0, $v0, 0x200
    /* 597F0 80068FF0 21004014 */  bnez       $v0, .L80069078
    /* 597F4 80068FF4 48FA6424 */   addiu     $a0, $v1, %lo(Cars_gHumanRaceCarList)
    /* 597F8 80068FF8 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* 597FC 80068FFC 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* 59800 80069000 02000224 */  addiu      $v0, $zero, 0x2
    /* 59804 80069004 08006214 */  bne        $v1, $v0, .L80069028
    /* 59808 80069008 21880000 */   addu      $s1, $zero, $zero
    /* 5980C 8006900C 0400828C */  lw         $v0, 0x4($a0)
    /* 59810 80069010 00000000 */  nop
    /* 59814 80069014 6002428C */  lw         $v0, 0x260($v0)
    /* 59818 80069018 00000000 */  nop
    /* 5981C 8006901C 00024230 */  andi       $v0, $v0, 0x200
    /* 59820 80069020 15004014 */  bnez       $v0, .L80069078
    /* 59824 80069024 00000000 */   nop
  .L80069028:
    /* 59828 80069028 1180023C */  lui        $v0, %hi(AIPerson_glueTable)
    /* 5982C 8006902C 14D75024 */  addiu      $s0, $v0, %lo(AIPerson_glueTable)
  .L80069030:
    /* 59830 80069030 0000048E */  lw         $a0, 0x0($s0)
    /* 59834 80069034 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 59838 80069038 2A104400 */  slt        $v0, $v0, $a0
    /* 5983C 8006903C 03004010 */  beqz       $v0, .L8006904C
    /* 59840 80069040 0100053C */   lui       $a1, (0x12666 >> 16)
    /* 59844 80069044 17A40108 */  j          .L8006905C
    /* 59848 80069048 6626A534 */   ori       $a1, $a1, (0x12666 & 0xFFFF)
  .L8006904C:
    /* 5984C 8006904C FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 59850 80069050 2A104400 */  slt        $v0, $v0, $a0
    /* 59854 80069054 04004014 */  bnez       $v0, .L80069068
    /* 59858 80069058 99D90534 */   ori       $a1, $zero, 0xD999
  .L8006905C:
    /* 5985C 8006905C CA90030C */  jal        fixedmult
    /* 59860 80069060 00000000 */   nop
    /* 59864 80069064 000002AE */  sw         $v0, 0x0($s0)
  .L80069068:
    /* 59868 80069068 01003126 */  addiu      $s1, $s1, 0x1
    /* 5986C 8006906C 1500222A */  slti       $v0, $s1, 0x15
    /* 59870 80069070 EFFF4014 */  bnez       $v0, .L80069030
    /* 59874 80069074 04001026 */   addiu     $s0, $s0, 0x4
  .L80069078:
    /* 59878 80069078 1800BF8F */  lw         $ra, 0x18($sp)
    /* 5987C 8006907C 1400B18F */  lw         $s1, 0x14($sp)
    /* 59880 80069080 1000B08F */  lw         $s0, 0x10($sp)
    /* 59884 80069084 0800E003 */  jr         $ra
    /* 59888 80069088 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AIPerson_LoadGlue__FP10Udff_tInfo
