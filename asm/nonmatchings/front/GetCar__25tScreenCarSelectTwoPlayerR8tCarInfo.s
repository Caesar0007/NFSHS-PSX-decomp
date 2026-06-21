.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetCar__25tScreenCarSelectTwoPlayerR8tCarInfo, 0x150

glabel GetCar__25tScreenCarSelectTwoPlayerR8tCarInfo
    /* 2E840 8003E040 0580023C */  lui        $v0, %hi(FEApp)
    /* 2E844 8003E044 C014428C */  lw         $v0, %lo(FEApp)($v0)
    /* 2E848 8003E048 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 2E84C 8003E04C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 2E850 8003E050 2190A000 */  addu       $s2, $a1, $zero
    /* 2E854 8003E054 2800BFAF */  sw         $ra, 0x28($sp)
    /* 2E858 8003E058 2400B5AF */  sw         $s5, 0x24($sp)
    /* 2E85C 8003E05C 2000B4AF */  sw         $s4, 0x20($sp)
    /* 2E860 8003E060 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 2E864 8003E064 1400B1AF */  sw         $s1, 0x14($sp)
    /* 2E868 8003E068 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2E86C 8003E06C 2C025090 */  lbu        $s0, 0x22C($v0)
    /* 2E870 8003E070 1180023C */  lui        $v0, %hi(frontEnd)
    /* 2E874 8003E074 00465424 */  addiu      $s4, $v0, %lo(frontEnd)
    /* 2E878 8003E078 2A018292 */  lbu        $v0, 0x12A($s4)
    /* 2E87C 8003E07C 21980002 */  addu       $s3, $s0, $zero
    /* 2E880 8003E080 10004014 */  bnez       $v0, .L8003E0C4
    /* 2E884 8003E084 21A80002 */   addu      $s5, $s0, $zero
    /* 2E888 8003E088 1180043C */  lui        $a0, %hi(carManager)
    /* 2E88C 8003E08C 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 2E890 8003E090 21101402 */  addu       $v0, $s0, $s4
    /* 2E894 8003E094 5C004590 */  lbu        $a1, 0x5C($v0)
    /* 2E898 8003E098 A45B000C */  jal        GetStockCar__11tCarManagersR8tCarInfo
    /* 2E89C 8003E09C 21304002 */   addu      $a2, $s2, $zero
    /* 2E8A0 8003E0A0 40101000 */  sll        $v0, $s0, 1
    /* 2E8A4 8003E0A4 21105000 */  addu       $v0, $v0, $s0
    /* 2E8A8 8003E0A8 00004382 */  lb         $v1, 0x0($s2)
    /* 2E8AC 8003E0AC 00110200 */  sll        $v0, $v0, 4
    /* 2E8B0 8003E0B0 21186200 */  addu       $v1, $v1, $v0
    /* 2E8B4 8003E0B4 21187400 */  addu       $v1, $v1, $s4
    /* 2E8B8 8003E0B8 60006290 */  lbu        $v0, 0x60($v1)
    /* 2E8BC 8003E0BC 4AF80008 */  j          .L8003E128
    /* 2E8C0 8003E0C0 21104202 */   addu      $v0, $s2, $v0
  .L8003E0C4:
    /* 2E8C4 8003E0C4 1180023C */  lui        $v0, %hi(carManager)
    /* 2E8C8 8003E0C8 74425124 */  addiu      $s1, $v0, %lo(carManager)
    /* 2E8CC 8003E0CC 21202002 */  addu       $a0, $s1, $zero
    /* 2E8D0 8003E0D0 CD5C000C */  jal        GetNumOwnedCars__11tCarManagers
    /* 2E8D4 8003E0D4 21280002 */   addu      $a1, $s0, $zero
    /* 2E8D8 8003E0D8 00140200 */  sll        $v0, $v0, 16
    /* 2E8DC 8003E0DC 0200401C */  bgtz       $v0, .L8003E0E8
    /* 2E8E0 8003E0E0 21202002 */   addu      $a0, $s1, $zero
    /* 2E8E4 8003E0E4 21980000 */  addu       $s3, $zero, $zero
  .L8003E0E8:
    /* 2E8E8 8003E0E8 21806002 */  addu       $s0, $s3, $zero
    /* 2E8EC 8003E0EC CD5C000C */  jal        GetNumOwnedCars__11tCarManagers
    /* 2E8F0 8003E0F0 21280002 */   addu      $a1, $s0, $zero
    /* 2E8F4 8003E0F4 00140200 */  sll        $v0, $v0, 16
    /* 2E8F8 8003E0F8 0300401C */  bgtz       $v0, .L8003E108
    /* 2E8FC 8003E0FC 21202002 */   addu      $a0, $s1, $zero
    /* 2E900 8003E100 5BF80008 */  j          .L8003E16C
    /* 2E904 8003E104 21100000 */   addu      $v0, $zero, $zero
  .L8003E108:
    /* 2E908 8003E108 21304002 */  addu       $a2, $s2, $zero
    /* 2E90C 8003E10C 2110B402 */  addu       $v0, $s5, $s4
    /* 2E910 8003E110 23014590 */  lbu        $a1, 0x123($v0)
    /* 2E914 8003E114 D35B000C */  jal        GetGarageCar__11tCarManagersR8tCarInfos
    /* 2E918 8003E118 21380002 */   addu      $a3, $s0, $zero
    /* 2E91C 8003E11C C5004292 */  lbu        $v0, 0xC5($s2)
    /* 2E920 8003E120 00000000 */  nop
    /* 2E924 8003E124 21104202 */  addu       $v0, $s2, $v0
  .L8003E128:
    /* 2E928 8003E128 AF004290 */  lbu        $v0, 0xAF($v0)
    /* 2E92C 8003E12C 00000000 */  nop
    /* 2E930 8003E130 C50042A2 */  sb         $v0, 0xC5($s2)
    /* 2E934 8003E134 0580023C */  lui        $v0, %hi(FEApp)
    /* 2E938 8003E138 C014428C */  lw         $v0, %lo(FEApp)($v0)
    /* 2E93C 8003E13C 1180043C */  lui        $a0, %hi(frontEnd)
    /* 2E940 8003E140 2C024390 */  lbu        $v1, 0x22C($v0)
    /* 2E944 8003E144 00468424 */  addiu      $a0, $a0, %lo(frontEnd)
    /* 2E948 8003E148 40100300 */  sll        $v0, $v1, 1
    /* 2E94C 8003E14C 21104300 */  addu       $v0, $v0, $v1
    /* 2E950 8003E150 00004382 */  lb         $v1, 0x0($s2)
    /* 2E954 8003E154 00110200 */  sll        $v0, $v0, 4
    /* 2E958 8003E158 21186200 */  addu       $v1, $v1, $v0
    /* 2E95C 8003E15C 21186400 */  addu       $v1, $v1, $a0
    /* 2E960 8003E160 C0006390 */  lbu        $v1, 0xC0($v1)
    /* 2E964 8003E164 01000224 */  addiu      $v0, $zero, 0x1
    /* 2E968 8003E168 C70043A2 */  sb         $v1, 0xC7($s2)
  .L8003E16C:
    /* 2E96C 8003E16C 2800BF8F */  lw         $ra, 0x28($sp)
    /* 2E970 8003E170 2400B58F */  lw         $s5, 0x24($sp)
    /* 2E974 8003E174 2000B48F */  lw         $s4, 0x20($sp)
    /* 2E978 8003E178 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 2E97C 8003E17C 1800B28F */  lw         $s2, 0x18($sp)
    /* 2E980 8003E180 1400B18F */  lw         $s1, 0x14($sp)
    /* 2E984 8003E184 1000B08F */  lw         $s0, 0x10($sp)
    /* 2E988 8003E188 0800E003 */  jr         $ra
    /* 2E98C 8003E18C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel GetCar__25tScreenCarSelectTwoPlayerR8tCarInfo
