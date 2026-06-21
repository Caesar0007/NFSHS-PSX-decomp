.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching PreLoad__20tScreenCarSelectDuel, 0x128

glabel PreLoad__20tScreenCarSelectDuel
    /* 2D88C 8003D08C E8FEBD27 */  addiu      $sp, $sp, -0x118
    /* 2D890 8003D090 0C01B3AF */  sw         $s3, 0x10C($sp)
    /* 2D894 8003D094 21988000 */  addu       $s3, $a0, $zero
    /* 2D898 8003D098 1001B4AF */  sw         $s4, 0x110($sp)
    /* 2D89C 8003D09C A8037426 */  addiu      $s4, $s3, 0x3A8
    /* 2D8A0 8003D0A0 21288002 */  addu       $a1, $s4, $zero
    /* 2D8A4 8003D0A4 05000624 */  addiu      $a2, $zero, 0x5
    /* 2D8A8 8003D0A8 1401BFAF */  sw         $ra, 0x114($sp)
    /* 2D8AC 8003D0AC 0801B2AF */  sw         $s2, 0x108($sp)
    /* 2D8B0 8003D0B0 0401B1AF */  sw         $s1, 0x104($sp)
    /* 2D8B4 8003D0B4 0001B0AF */  sw         $s0, 0x100($sp)
    /* 2D8B8 8003D0B8 FB98000C */  jal        InitializeShapes__7tScreenR17tShapeInformationUi
    /* 2D8BC 8003D0BC A80360AE */   sw        $zero, 0x3A8($s3)
    /* 2D8C0 8003D0C0 E099000C */  jal        PreLoad__7tScreen
    /* 2D8C4 8003D0C4 21206002 */   addu      $a0, $s3, $zero
    /* 2D8C8 8003D0C8 803E0424 */  addiu      $a0, $zero, 0x3E80
    /* 2D8CC 8003D0CC 0180053C */  lui        $a1, %hi(D_80011AE0)
    /* 2D8D0 8003D0D0 2D71030C */  jal        Platform_GetDCTBuffer__FiPc
    /* 2D8D4 8003D0D4 E01AA524 */   addiu     $a1, $a1, %lo(D_80011AE0)
    /* 2D8D8 8003D0D8 803E0424 */  addiu      $a0, $zero, 0x3E80
    /* 2D8DC 8003D0DC 0180053C */  lui        $a1, %hi(D_80011B18)
    /* 2D8E0 8003D0E0 181BA524 */  addiu      $a1, $a1, %lo(D_80011B18)
    /* 2D8E4 8003D0E4 2D71030C */  jal        Platform_GetDCTBuffer__FiPc
    /* 2D8E8 8003D0E8 300062AE */   sw        $v0, 0x30($s3)
    /* 2D8EC 8003D0EC 6000638E */  lw         $v1, 0x60($s3)
    /* 2D8F0 8003D0F0 1000A527 */  addiu      $a1, $sp, 0x10
    /* 2D8F4 8003D0F4 B00362AE */  sw         $v0, 0x3B0($s3)
    /* 2D8F8 8003D0F8 68006484 */  lh         $a0, 0x68($v1)
    /* 2D8FC 8003D0FC 6C00628C */  lw         $v0, 0x6C($v1)
    /* 2D900 8003D100 00000000 */  nop
    /* 2D904 8003D104 09F84000 */  jalr       $v0
    /* 2D908 8003D108 21206402 */   addu      $a0, $s3, $a0
    /* 2D90C 8003D10C 01004238 */  xori       $v0, $v0, 0x1
    /* 2D910 8003D110 05004010 */  beqz       $v0, .L8003D128
    /* 2D914 8003D114 1180043C */   lui       $a0, %hi(carManager)
    /* 2D918 8003D118 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 2D91C 8003D11C 21280000 */  addu       $a1, $zero, $zero
    /* 2D920 8003D120 A45B000C */  jal        GetStockCar__11tCarManagersR8tCarInfo
    /* 2D924 8003D124 1000A627 */   addiu     $a2, $sp, 0x10
  .L8003D128:
    /* 2D928 8003D128 E000B127 */  addiu      $s1, $sp, 0xE0
    /* 2D92C 8003D12C 21202002 */  addu       $a0, $s1, $zero
    /* 2D930 8003D130 0180103C */  lui        $s0, %hi(D_80011B24)
    /* 2D934 8003D134 241B1026 */  addiu      $s0, $s0, %lo(D_80011B24)
    /* 2D938 8003D138 21280002 */  addu       $a1, $s0, $zero
    /* 2D93C 8003D13C 2000B227 */  addiu      $s2, $sp, 0x20
    /* 2D940 8003D140 2F91030C */  jal        sprintf
    /* 2D944 8003D144 21304002 */   addu      $a2, $s2, $zero
    /* 2D948 8003D148 21206002 */  addu       $a0, $s3, $zero
    /* 2D94C 8003D14C 21282002 */  addu       $a1, $s1, $zero
    /* 2D950 8003D150 9098000C */  jal        AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
    /* 2D954 8003D154 28006626 */   addiu     $a2, $s3, 0x28
    /* 2D958 8003D158 1180043C */  lui        $a0, %hi(carManager)
    /* 2D95C 8003D15C 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 2D960 8003D160 1180023C */  lui        $v0, %hi(D_8011491D)
    /* 2D964 8003D164 1D494590 */  lbu        $a1, %lo(D_8011491D)($v0)
    /* 2D968 8003D168 A45B000C */  jal        GetStockCar__11tCarManagersR8tCarInfo
    /* 2D96C 8003D16C 1000A627 */   addiu     $a2, $sp, 0x10
    /* 2D970 8003D170 21202002 */  addu       $a0, $s1, $zero
    /* 2D974 8003D174 21280002 */  addu       $a1, $s0, $zero
    /* 2D978 8003D178 2F91030C */  jal        sprintf
    /* 2D97C 8003D17C 21304002 */   addu      $a2, $s2, $zero
    /* 2D980 8003D180 21206002 */  addu       $a0, $s3, $zero
    /* 2D984 8003D184 21282002 */  addu       $a1, $s1, $zero
    /* 2D988 8003D188 9098000C */  jal        AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
    /* 2D98C 8003D18C 21308002 */   addu      $a2, $s4, $zero
    /* 2D990 8003D190 A40360AE */  sw         $zero, 0x3A4($s3)
    /* 2D994 8003D194 1401BF8F */  lw         $ra, 0x114($sp)
    /* 2D998 8003D198 1001B48F */  lw         $s4, 0x110($sp)
    /* 2D99C 8003D19C 0C01B38F */  lw         $s3, 0x10C($sp)
    /* 2D9A0 8003D1A0 0801B28F */  lw         $s2, 0x108($sp)
    /* 2D9A4 8003D1A4 0401B18F */  lw         $s1, 0x104($sp)
    /* 2D9A8 8003D1A8 0001B08F */  lw         $s0, 0x100($sp)
    /* 2D9AC 8003D1AC 0800E003 */  jr         $ra
    /* 2D9B0 8003D1B0 1801BD27 */   addiu     $sp, $sp, 0x118
endlabel PreLoad__20tScreenCarSelectDuel
