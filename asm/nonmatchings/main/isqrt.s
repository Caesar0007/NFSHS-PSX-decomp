.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching isqrt, 0x1C4

glabel isqrt
    /* E3ACC 800F32CC 21308000 */  addu       $a2, $a0, $zero
    /* E3AD0 800F32D0 FFFF023C */  lui        $v0, (0xFFFF0000 >> 16)
    /* E3AD4 800F32D4 2410C200 */  and        $v0, $a2, $v0
    /* E3AD8 800F32D8 27004010 */  beqz       $v0, .L800F3378
    /* E3ADC 800F32DC 00FF023C */   lui       $v0, (0xFF000000 >> 16)
    /* E3AE0 800F32E0 2410C200 */  and        $v0, $a2, $v0
    /* E3AE4 800F32E4 0B004010 */  beqz       $v0, .L800F3314
    /* E3AE8 800F32E8 1480023C */   lui       $v0, %hi(isqrttbl)
    /* E3AEC 800F32EC 10BE4224 */  addiu      $v0, $v0, %lo(isqrttbl)
    /* E3AF0 800F32F0 021E0600 */  srl        $v1, $a2, 24
    /* E3AF4 800F32F4 21206200 */  addu       $a0, $v1, $v0
    /* E3AF8 800F32F8 21188000 */  addu       $v1, $a0, $zero
    /* E3AFC 800F32FC FFFF8490 */  lbu        $a0, -0x1($a0)
    /* E3B00 800F3300 00006290 */  lbu        $v0, 0x0($v1)
    /* E3B04 800F3304 00220400 */  sll        $a0, $a0, 8
    /* E3B08 800F3308 01004224 */  addiu      $v0, $v0, 0x1
    /* E3B0C 800F330C D8CC0308 */  j          .L800F3360
    /* E3B10 800F3310 002A0200 */   sll       $a1, $v0, 8
  .L800F3314:
    /* E3B14 800F3314 10BE4224 */  addiu      $v0, $v0, %lo(isqrttbl)
    /* E3B18 800F3318 021C0600 */  srl        $v1, $a2, 16
    /* E3B1C 800F331C 21206200 */  addu       $a0, $v1, $v0
    /* E3B20 800F3320 21188000 */  addu       $v1, $a0, $zero
    /* E3B24 800F3324 FFFF8490 */  lbu        $a0, -0x1($a0)
    /* E3B28 800F3328 00006290 */  lbu        $v0, 0x0($v1)
    /* E3B2C 800F332C 00210400 */  sll        $a0, $a0, 4
    /* E3B30 800F3330 01004224 */  addiu      $v0, $v0, 0x1
    /* E3B34 800F3334 D8CC0308 */  j          .L800F3360
    /* E3B38 800F3338 00290200 */   sll       $a1, $v0, 4
  .L800F333C:
    /* E3B3C 800F333C 42180200 */  srl        $v1, $v0, 1
    /* E3B40 800F3340 18006300 */  mult       $v1, $v1
    /* E3B44 800F3344 12380000 */  mflo       $a3
    /* E3B48 800F3348 2B10C700 */  sltu       $v0, $a2, $a3
    /* E3B4C 800F334C 03004010 */  beqz       $v0, .L800F335C
    /* E3B50 800F3350 00000000 */   nop
    /* E3B54 800F3354 D8CC0308 */  j          .L800F3360
    /* E3B58 800F3358 21286000 */   addu      $a1, $v1, $zero
  .L800F335C:
    /* E3B5C 800F335C 21206000 */  addu       $a0, $v1, $zero
  .L800F3360:
    /* E3B60 800F3360 2310A400 */  subu       $v0, $a1, $a0
    /* E3B64 800F3364 0200422C */  sltiu      $v0, $v0, 0x2
    /* E3B68 800F3368 F4FF4010 */  beqz       $v0, .L800F333C
    /* E3B6C 800F336C 21108500 */   addu      $v0, $a0, $a1
  .L800F3370:
    /* E3B70 800F3370 0800E003 */  jr         $ra
    /* E3B74 800F3374 21108000 */   addu      $v0, $a0, $zero
  .L800F3378:
    /* E3B78 800F3378 00FFC230 */  andi       $v0, $a2, 0xFF00
    /* E3B7C 800F337C 39004010 */  beqz       $v0, .L800F3464
    /* E3B80 800F3380 00F0C230 */   andi      $v0, $a2, 0xF000
    /* E3B84 800F3384 15004010 */  beqz       $v0, .L800F33DC
    /* E3B88 800F3388 00C0C230 */   andi      $v0, $a2, 0xC000
    /* E3B8C 800F338C 09004010 */  beqz       $v0, .L800F33B4
    /* E3B90 800F3390 1480033C */   lui       $v1, %hi(isqrttbl)
    /* E3B94 800F3394 10BE6324 */  addiu      $v1, $v1, %lo(isqrttbl)
    /* E3B98 800F3398 02120600 */  srl        $v0, $a2, 8
    /* E3B9C 800F339C 21204300 */  addu       $a0, $v0, $v1
    /* E3BA0 800F33A0 21108000 */  addu       $v0, $a0, $zero
    /* E3BA4 800F33A4 00004290 */  lbu        $v0, 0x0($v0)
    /* E3BA8 800F33A8 FFFF8490 */  lbu        $a0, -0x1($a0)
    /* E3BAC 800F33AC 0CCD0308 */  j          .L800F3430
    /* E3BB0 800F33B0 01004524 */   addiu     $a1, $v0, 0x1
  .L800F33B4:
    /* E3BB4 800F33B4 1480023C */  lui        $v0, %hi(isqrttbl)
    /* E3BB8 800F33B8 10BE4224 */  addiu      $v0, $v0, %lo(isqrttbl)
    /* E3BBC 800F33BC 82190600 */  srl        $v1, $a2, 6
    /* E3BC0 800F33C0 21206200 */  addu       $a0, $v1, $v0
    /* E3BC4 800F33C4 21188000 */  addu       $v1, $a0, $zero
    /* E3BC8 800F33C8 FFFF8490 */  lbu        $a0, -0x1($a0)
    /* E3BCC 800F33CC 00006290 */  lbu        $v0, 0x0($v1)
    /* E3BD0 800F33D0 42200400 */  srl        $a0, $a0, 1
    /* E3BD4 800F33D4 0BCD0308 */  j          .L800F342C
    /* E3BD8 800F33D8 42100200 */   srl       $v0, $v0, 1
  .L800F33DC:
    /* E3BDC 800F33DC 000CC230 */  andi       $v0, $a2, 0xC00
    /* E3BE0 800F33E0 0A004010 */  beqz       $v0, .L800F340C
    /* E3BE4 800F33E4 1480023C */   lui       $v0, %hi(isqrttbl)
    /* E3BE8 800F33E8 10BE4224 */  addiu      $v0, $v0, %lo(isqrttbl)
    /* E3BEC 800F33EC 02190600 */  srl        $v1, $a2, 4
    /* E3BF0 800F33F0 21206200 */  addu       $a0, $v1, $v0
    /* E3BF4 800F33F4 21188000 */  addu       $v1, $a0, $zero
    /* E3BF8 800F33F8 FFFF8490 */  lbu        $a0, -0x1($a0)
    /* E3BFC 800F33FC 00006290 */  lbu        $v0, 0x0($v1)
    /* E3C00 800F3400 82200400 */  srl        $a0, $a0, 2
    /* E3C04 800F3404 0BCD0308 */  j          .L800F342C
    /* E3C08 800F3408 82100200 */   srl       $v0, $v0, 2
  .L800F340C:
    /* E3C0C 800F340C 10BE4224 */  addiu      $v0, $v0, %lo(isqrttbl)
    /* E3C10 800F3410 82180600 */  srl        $v1, $a2, 2
    /* E3C14 800F3414 21206200 */  addu       $a0, $v1, $v0
    /* E3C18 800F3418 21188000 */  addu       $v1, $a0, $zero
    /* E3C1C 800F341C FFFF8490 */  lbu        $a0, -0x1($a0)
    /* E3C20 800F3420 00006290 */  lbu        $v0, 0x0($v1)
    /* E3C24 800F3424 C2200400 */  srl        $a0, $a0, 3
    /* E3C28 800F3428 C2100200 */  srl        $v0, $v0, 3
  .L800F342C:
    /* E3C2C 800F342C 01004524 */  addiu      $a1, $v0, 0x1
  .L800F3430:
    /* E3C30 800F3430 2310A400 */  subu       $v0, $a1, $a0
    /* E3C34 800F3434 0200422C */  sltiu      $v0, $v0, 0x2
    /* E3C38 800F3438 CDFF4014 */  bnez       $v0, .L800F3370
    /* E3C3C 800F343C 21108500 */   addu      $v0, $a0, $a1
    /* E3C40 800F3440 42180200 */  srl        $v1, $v0, 1
    /* E3C44 800F3444 18006300 */  mult       $v1, $v1
    /* E3C48 800F3448 21106000 */  addu       $v0, $v1, $zero
    /* E3C4C 800F344C 12380000 */  mflo       $a3
    /* E3C50 800F3450 2B18C700 */  sltu       $v1, $a2, $a3
    /* E3C54 800F3454 0C006010 */  beqz       $v1, .L800F3488
    /* E3C58 800F3458 00000000 */   nop
    /* E3C5C 800F345C DCCC0308 */  j          .L800F3370
    /* E3C60 800F3460 00000000 */   nop
  .L800F3464:
    /* E3C64 800F3464 0300C014 */  bnez       $a2, .L800F3474
    /* E3C68 800F3468 1480023C */   lui       $v0, %hi(isqrttbl)
    /* E3C6C 800F346C 0800E003 */  jr         $ra
    /* E3C70 800F3470 21100000 */   addu      $v0, $zero, $zero
  .L800F3474:
    /* E3C74 800F3474 10BE4224 */  addiu      $v0, $v0, %lo(isqrttbl)
    /* E3C78 800F3478 2110C200 */  addu       $v0, $a2, $v0
    /* E3C7C 800F347C FFFF4290 */  lbu        $v0, -0x1($v0)
    /* E3C80 800F3480 00000000 */  nop
    /* E3C84 800F3484 02110200 */  srl        $v0, $v0, 4
  .L800F3488:
    /* E3C88 800F3488 0800E003 */  jr         $ra
    /* E3C8C 800F348C 00000000 */   nop
endlabel isqrt
