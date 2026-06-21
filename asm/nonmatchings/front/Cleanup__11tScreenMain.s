.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Cleanup__11tScreenMain, 0x6C

glabel Cleanup__11tScreenMain
    /* 292D8 80038AD8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 292DC 80038ADC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 292E0 80038AE0 21908000 */  addu       $s2, $a0, $zero
    /* 292E4 80038AE4 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 292E8 80038AE8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 292EC 80038AEC 1000B0AF */  sw         $s0, 0x10($sp)
    /* 292F0 80038AF0 6400448E */  lw         $a0, 0x64($s2)
    /* 292F4 80038AF4 9043010C */  jal        VIDEO_destroy__Fi
    /* 292F8 80038AF8 21880000 */   addu      $s1, $zero, $zero
    /* 292FC 80038AFC 6400448E */  lw         $a0, 0x64($s2)
    /* 29300 80038B00 5095030C */  jal        purgememadr
    /* 29304 80038B04 58051024 */   addiu     $s0, $zero, 0x558
  .L80038B08:
    /* 29308 80038B08 21204002 */  addu       $a0, $s2, $zero
    /* 2930C 80038B0C 2599000C */  jal        FreeShapes__7tScreenR17tShapeInformation
    /* 29310 80038B10 21285002 */   addu      $a1, $s2, $s0
    /* 29314 80038B14 01003126 */  addiu      $s1, $s1, 0x1
    /* 29318 80038B18 0200222A */  slti       $v0, $s1, 0x2
    /* 2931C 80038B1C FAFF4014 */  bnez       $v0, .L80038B08
    /* 29320 80038B20 28001026 */   addiu     $s0, $s0, 0x28
    /* 29324 80038B24 6898000C */  jal        Cleanup__7tScreen
    /* 29328 80038B28 21204002 */   addu      $a0, $s2, $zero
    /* 2932C 80038B2C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 29330 80038B30 1800B28F */  lw         $s2, 0x18($sp)
    /* 29334 80038B34 1400B18F */  lw         $s1, 0x14($sp)
    /* 29338 80038B38 1000B08F */  lw         $s0, 0x10($sp)
    /* 2933C 80038B3C 0800E003 */  jr         $ra
    /* 29340 80038B40 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Cleanup__11tScreenMain
