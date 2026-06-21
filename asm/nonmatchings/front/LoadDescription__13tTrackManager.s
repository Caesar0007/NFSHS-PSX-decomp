.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching LoadDescription__13tTrackManager, 0x138

glabel LoadDescription__13tTrackManager
    /* 12314 80021B14 90FFBD27 */  addiu      $sp, $sp, -0x70
    /* 12318 80021B18 6000B0AF */  sw         $s0, 0x60($sp)
    /* 1231C 80021B1C 21808000 */  addu       $s0, $a0, $zero
    /* 12320 80021B20 1000A427 */  addiu      $a0, $sp, 0x10
    /* 12324 80021B24 0180053C */  lui        $a1, %hi(D_80010FC8)
    /* 12328 80021B28 C80FA524 */  addiu      $a1, $a1, %lo(D_80010FC8)
    /* 1232C 80021B2C 1180023C */  lui        $v0, %hi(D_801164FC)
    /* 12330 80021B30 0180073C */  lui        $a3, %hi(D_80010FD0)
    /* 12334 80021B34 FC64468C */  lw         $a2, %lo(D_801164FC)($v0)
    /* 12338 80021B38 D00FE724 */  addiu      $a3, $a3, %lo(D_80010FD0)
    /* 1233C 80021B3C 6800BFAF */  sw         $ra, 0x68($sp)
    /* 12340 80021B40 2F91030C */  jal        sprintf
    /* 12344 80021B44 6400B1AF */   sw        $s1, 0x64($sp)
    /* 12348 80021B48 1387000C */  jal        ReleaseDescription__13tTrackManager
    /* 1234C 80021B4C 21200002 */   addu      $a0, $s0, $zero
    /* 12350 80021B50 1000A427 */  addiu      $a0, $sp, 0x10
    /* 12354 80021B54 FA95030C */  jal        loadfileadr
    /* 12358 80021B58 10000524 */   addiu     $a1, $zero, 0x10
    /* 1235C 80021B5C 0180043C */  lui        $a0, %hi(D_80010FDC)
    /* 12360 80021B60 DC0F8424 */  addiu      $a0, $a0, %lo(D_80010FDC)
    /* 12364 80021B64 21884000 */  addu       $s1, $v0, $zero
    /* 12368 80021B68 0000228E */  lw         $v0, 0x0($s1)
    /* 1236C 80021B6C 21300000 */  addu       $a2, $zero, $zero
    /* 12370 80021B70 40280200 */  sll        $a1, $v0, 1
    /* 12374 80021B74 2128A200 */  addu       $a1, $a1, $v0
    /* 12378 80021B78 00290500 */  sll        $a1, $a1, 4
    /* 1237C 80021B7C CF94030C */  jal        reservememadr
    /* 12380 80021B80 000002AE */   sw        $v0, 0x0($s0)
    /* 12384 80021B84 04002426 */  addiu      $a0, $s1, 0x4
    /* 12388 80021B88 0000038E */  lw         $v1, 0x0($s0)
    /* 1238C 80021B8C 21284000 */  addu       $a1, $v0, $zero
    /* 12390 80021B90 040005AE */  sw         $a1, 0x4($s0)
    /* 12394 80021B94 40300300 */  sll        $a2, $v1, 1
    /* 12398 80021B98 2130C300 */  addu       $a2, $a2, $v1
    /* 1239C 80021B9C B798030C */  jal        blockmove
    /* 123A0 80021BA0 00310600 */   sll       $a2, $a2, 4
    /* 123A4 80021BA4 0000028E */  lw         $v0, 0x0($s0)
    /* 123A8 80021BA8 00000000 */  nop
    /* 123AC 80021BAC 20004010 */  beqz       $v0, .L80021C30
    /* 123B0 80021BB0 21280000 */   addu      $a1, $zero, $zero
    /* 123B4 80021BB4 01000624 */  addiu      $a2, $zero, 0x1
    /* 123B8 80021BB8 2120A000 */  addu       $a0, $a1, $zero
  .L80021BBC:
    /* 123BC 80021BBC 0400028E */  lw         $v0, 0x4($s0)
    /* 123C0 80021BC0 00000000 */  nop
    /* 123C4 80021BC4 21188200 */  addu       $v1, $a0, $v0
    /* 123C8 80021BC8 03006290 */  lbu        $v0, 0x3($v1)
    /* 123CC 80021BCC 00000000 */  nop
    /* 123D0 80021BD0 06004010 */  beqz       $v0, .L80021BEC
    /* 123D4 80021BD4 00000000 */   nop
    /* 123D8 80021BD8 00006280 */  lb         $v0, 0x0($v1)
    /* 123DC 80021BDC 00000000 */  nop
    /* 123E0 80021BE0 80100200 */  sll        $v0, $v0, 2
    /* 123E4 80021BE4 21100202 */  addu       $v0, $s0, $v0
    /* 123E8 80021BE8 080046AC */  sw         $a2, 0x8($v0)
  .L80021BEC:
    /* 123EC 80021BEC 0400028E */  lw         $v0, 0x4($s0)
    /* 123F0 80021BF0 00000000 */  nop
    /* 123F4 80021BF4 21188200 */  addu       $v1, $a0, $v0
    /* 123F8 80021BF8 04006290 */  lbu        $v0, 0x4($v1)
    /* 123FC 80021BFC 00000000 */  nop
    /* 12400 80021C00 06004014 */  bnez       $v0, .L80021C1C
    /* 12404 80021C04 00000000 */   nop
    /* 12408 80021C08 00006280 */  lb         $v0, 0x0($v1)
    /* 1240C 80021C0C 00000000 */  nop
    /* 12410 80021C10 80100200 */  sll        $v0, $v0, 2
    /* 12414 80021C14 21100202 */  addu       $v0, $s0, $v0
    /* 12418 80021C18 480046AC */  sw         $a2, 0x48($v0)
  .L80021C1C:
    /* 1241C 80021C1C 0000028E */  lw         $v0, 0x0($s0)
    /* 12420 80021C20 0100A524 */  addiu      $a1, $a1, 0x1
    /* 12424 80021C24 2B10A200 */  sltu       $v0, $a1, $v0
    /* 12428 80021C28 E4FF4014 */  bnez       $v0, .L80021BBC
    /* 1242C 80021C2C 30008424 */   addiu     $a0, $a0, 0x30
  .L80021C30:
    /* 12430 80021C30 5095030C */  jal        purgememadr
    /* 12434 80021C34 21202002 */   addu      $a0, $s1, $zero
    /* 12438 80021C38 6800BF8F */  lw         $ra, 0x68($sp)
    /* 1243C 80021C3C 6400B18F */  lw         $s1, 0x64($sp)
    /* 12440 80021C40 6000B08F */  lw         $s0, 0x60($sp)
    /* 12444 80021C44 0800E003 */  jr         $ra
    /* 12448 80021C48 7000BD27 */   addiu     $sp, $sp, 0x70
endlabel LoadDescription__13tTrackManager
