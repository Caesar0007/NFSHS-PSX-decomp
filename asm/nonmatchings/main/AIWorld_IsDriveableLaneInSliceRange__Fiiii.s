.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_IsDriveableLaneInSliceRange__Fiiii, 0xB8

glabel AIWorld_IsDriveableLaneInSliceRange__Fiiii
    /* 63AF0 800732F0 07000224 */  addiu      $v0, $zero, 0x7
    /* 63AF4 800732F4 23104700 */  subu       $v0, $v0, $a3
    /* 63AF8 800732F8 08000324 */  addiu      $v1, $zero, 0x8
    /* 63AFC 800732FC 23186200 */  subu       $v1, $v1, $v0
    /* 63B00 80073300 03006104 */  bgez       $v1, .L80073310
    /* 63B04 80073304 10006228 */   slti      $v0, $v1, 0x10
    /* 63B08 80073308 21180000 */  addu       $v1, $zero, $zero
    /* 63B0C 8007330C 10006228 */  slti       $v0, $v1, 0x10
  .L80073310:
    /* 63B10 80073310 02004014 */  bnez       $v0, .L8007331C
    /* 63B14 80073314 0F000224 */   addiu     $v0, $zero, 0xF
    /* 63B18 80073318 0F000324 */  addiu      $v1, $zero, 0xF
  .L8007331C:
    /* 63B1C 8007331C 23104300 */  subu       $v0, $v0, $v1
    /* 63B20 80073320 01000324 */  addiu      $v1, $zero, 0x1
    /* 63B24 80073324 04184300 */  sllv       $v1, $v1, $v0
    /* 63B28 80073328 21500000 */  addu       $t2, $zero, $zero
    /* 63B2C 8007332C 21404001 */  addu       $t0, $t2, $zero
    /* 63B30 80073330 1480093C */  lui        $t1, %hi(gNumSlices)
    /* 63B34 80073334 C8C7298D */  lw         $t1, %lo(gNumSlices)($t1)
    /* 63B38 80073338 14800B3C */  lui        $t3, %hi(BWorldSm_slices)
    /* 63B3C 8007333C C0C76B8D */  lw         $t3, %lo(BWorldSm_slices)($t3)
  .L80073340:
    /* 63B40 80073340 2A104501 */  slt        $v0, $t2, $a1
    /* 63B44 80073344 16004010 */  beqz       $v0, .L800733A0
    /* 63B48 80073348 00000000 */   nop
    /* 63B4C 8007334C 06000005 */  bltz       $t0, .L80073368
    /* 63B50 80073350 21388800 */   addu      $a3, $a0, $t0
    /* 63B54 80073354 2A10E900 */  slt        $v0, $a3, $t1
    /* 63B58 80073358 07004014 */  bnez       $v0, .L80073378
    /* 63B5C 8007335C 40110700 */   sll       $v0, $a3, 5
    /* 63B60 80073360 DDCC0108 */  j          .L80073374
    /* 63B64 80073364 2338E900 */   subu      $a3, $a3, $t1
  .L80073368:
    /* 63B68 80073368 0300E104 */  bgez       $a3, .L80073378
    /* 63B6C 8007336C 40110700 */   sll       $v0, $a3, 5
    /* 63B70 80073370 2138E900 */  addu       $a3, $a3, $t1
  .L80073374:
    /* 63B74 80073374 40110700 */  sll        $v0, $a3, 5
  .L80073378:
    /* 63B78 80073378 21104B00 */  addu       $v0, $v0, $t3
    /* 63B7C 8007337C 16004284 */  lh         $v0, 0x16($v0)
    /* 63B80 80073380 00000000 */  nop
    /* 63B84 80073384 24104300 */  and        $v0, $v0, $v1
    /* 63B88 80073388 03004014 */  bnez       $v0, .L80073398
    /* 63B8C 8007338C 21400601 */   addu      $t0, $t0, $a2
    /* 63B90 80073390 0800E003 */  jr         $ra
    /* 63B94 80073394 21100000 */   addu      $v0, $zero, $zero
  .L80073398:
    /* 63B98 80073398 D0CC0108 */  j          .L80073340
    /* 63B9C 8007339C 01004A25 */   addiu     $t2, $t2, 0x1
  .L800733A0:
    /* 63BA0 800733A0 0800E003 */  jr         $ra
    /* 63BA4 800733A4 01000224 */   addiu     $v0, $zero, 0x1
endlabel AIWorld_IsDriveableLaneInSliceRange__Fiiii
