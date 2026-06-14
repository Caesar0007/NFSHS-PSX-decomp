.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDPKTPLAY_start, 0x2EC

glabel SNDPKTPLAY_start
    /* F3210 80102A10 A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* F3214 80102A14 4C00B7AF */  sw         $s7, 0x4C($sp)
    /* F3218 80102A18 21B88000 */  addu       $s7, $a0, $zero
    /* F321C 80102A1C 4800B6AF */  sw         $s6, 0x48($sp)
    /* F3220 80102A20 21B0A000 */  addu       $s6, $a1, $zero
    /* F3224 80102A24 4400B5AF */  sw         $s5, 0x44($sp)
    /* F3228 80102A28 21A8C000 */  addu       $s5, $a2, $zero
    /* F322C 80102A2C 1480023C */  lui        $v0, %hi(sndgs)
    /* F3230 80102A30 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* F3234 80102A34 60785324 */  addiu      $s3, $v0, %lo(sndgs)
    /* F3238 80102A38 5000BFAF */  sw         $ra, 0x50($sp)
    /* F323C 80102A3C 4000B4AF */  sw         $s4, 0x40($sp)
    /* F3240 80102A40 3800B2AF */  sw         $s2, 0x38($sp)
    /* F3244 80102A44 3400B1AF */  sw         $s1, 0x34($sp)
    /* F3248 80102A48 3000B0AF */  sw         $s0, 0x30($sp)
    /* F324C 80102A4C 3C006282 */  lb         $v0, 0x3C($s3)
    /* F3250 80102A50 00000000 */  nop
    /* F3254 80102A54 03004014 */  bnez       $v0, .L80102A64
    /* F3258 80102A58 21A0E000 */   addu      $s4, $a3, $zero
    /* F325C 80102A5C 340B0408 */  j          .L80102CD0
    /* F3260 80102A60 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L80102A64:
    /* F3264 80102A64 1580023C */  lui        $v0, %hi(sndpps)
    /* F3268 80102A68 74854224 */  addiu      $v0, $v0, %lo(sndpps)
    /* F326C 80102A6C 80181700 */  sll        $v1, $s7, 2
    /* F3270 80102A70 21186200 */  addu       $v1, $v1, $v0
    /* F3274 80102A74 0200D092 */  lbu        $s0, 0x2($s6)
    /* F3278 80102A78 0000718C */  lw         $s1, 0x0($v1)
    /* F327C 80102A7C 4DA9030C */  jal        iSNDenteraudio
    /* F3280 80102A80 00000000 */   nop
    /* F3284 80102A84 2800A727 */  addiu      $a3, $sp, 0x28
    /* F3288 80102A88 0000A48E */  lw         $a0, 0x0($s5)
    /* F328C 80102A8C 0600A682 */  lb         $a2, 0x6($s5)
    /* F3290 80102A90 D9F9030C */  jal        iSNDallocchan
    /* F3294 80102A94 21280002 */   addu      $a1, $s0, $zero
    /* F3298 80102A98 21904000 */  addu       $s2, $v0, $zero
    /* F329C 80102A9C 05004106 */  bgez       $s2, .L80102AB4
    /* F32A0 80102AA0 00000000 */   nop
    /* F32A4 80102AA4 5BA9030C */  jal        iSNDleaveaudio
    /* F32A8 80102AA8 00000000 */   nop
    /* F32AC 80102AAC 340B0408 */  j          .L80102CD0
    /* F32B0 80102AB0 F7FF0224 */   addiu     $v0, $zero, -0x9
  .L80102AB4:
    /* F32B4 80102AB4 2800A28F */  lw         $v0, 0x28($sp)
    /* F32B8 80102AB8 00000000 */  nop
    /* F32BC 80102ABC 000022AE */  sw         $v0, 0x0($s1)
    /* F32C0 80102AC0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* F32C4 80102AC4 0A0020A6 */  sh         $zero, 0xA($s1)
    /* F32C8 80102AC8 0E0020A6 */  sh         $zero, 0xE($s1)
    /* F32CC 80102ACC 100020AE */  sw         $zero, 0x10($s1)
    /* F32D0 80102AD0 040020AE */  sw         $zero, 0x4($s1)
    /* F32D4 80102AD4 140020AE */  sw         $zero, 0x14($s1)
    /* F32D8 80102AD8 0C0022A6 */  sh         $v0, 0xC($s1)
    /* F32DC 80102ADC 40101200 */  sll        $v0, $s2, 1
    /* F32E0 80102AE0 21105200 */  addu       $v0, $v0, $s2
    /* F32E4 80102AE4 C0100200 */  sll        $v0, $v0, 3
    /* F32E8 80102AE8 21105200 */  addu       $v0, $v0, $s2
    /* F32EC 80102AEC 80100200 */  sll        $v0, $v0, 2
    /* F32F0 80102AF0 0300C88A */  lwl        $t0, 0x3($s6)
    /* F32F4 80102AF4 0000C89A */  lwr        $t0, 0x0($s6)
    /* F32F8 80102AF8 00000000 */  nop
    /* F32FC 80102AFC 270028AA */  swl        $t0, 0x27($s1)
    /* F3300 80102B00 240028BA */  swr        $t0, 0x24($s1)
    /* F3304 80102B04 9400638E */  lw         $v1, 0x94($s3)
    /* F3308 80102B08 0B008482 */  lb         $a0, 0xB($s4)
    /* F330C 80102B0C 00000000 */  nop
    /* F3310 80102B10 04008010 */  beqz       $a0, .L80102B24
    /* F3314 80102B14 21806200 */   addu      $s0, $v1, $v0
    /* F3318 80102B18 10009396 */  lhu        $s3, 0x10($s4)
    /* F331C 80102B1C CF0A0408 */  j          .L80102B3C
    /* F3320 80102B20 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L80102B24:
    /* F3324 80102B24 07008282 */  lb         $v0, 0x7($s4)
    /* F3328 80102B28 00000000 */  nop
    /* F332C 80102B2C C0FF5324 */  addiu      $s3, $v0, -0x40
    /* F3330 80102B30 009A1300 */  sll        $s3, $s3, 8
    /* F3334 80102B34 FFFF7332 */  andi       $s3, $s3, 0xFFFF
    /* F3338 80102B38 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L80102B3C:
    /* F333C 80102B3C 0A0002A2 */  sb         $v0, 0xA($s0)
    /* F3340 80102B40 0400A296 */  lhu        $v0, 0x4($s5)
    /* F3344 80102B44 FF7F043C */  lui        $a0, (0x7FFFFFFF >> 16)
    /* F3348 80102B48 5C0002A6 */  sh         $v0, 0x5C($s0)
    /* F334C 80102B4C 0C008296 */  lhu        $v0, 0xC($s4)
    /* F3350 80102B50 FFFF8434 */  ori        $a0, $a0, (0x7FFFFFFF & 0xFFFF)
    /* F3354 80102B54 140000AE */  sw         $zero, 0x14($s0)
    /* F3358 80102B58 600002A6 */  sh         $v0, 0x60($s0)
    /* F335C 80102B5C 08008382 */  lb         $v1, 0x8($s4)
    /* F3360 80102B60 7F00023C */  lui        $v0, (0x7F0000 >> 16)
    /* F3364 80102B64 200000AE */  sw         $zero, 0x20($s0)
    /* F3368 80102B68 280004AE */  sw         $a0, 0x28($s0)
    /* F336C 80102B6C 240002AE */  sw         $v0, 0x24($s0)
    /* F3370 80102B70 001C0300 */  sll        $v1, $v1, 16
    /* F3374 80102B74 1C0003AE */  sw         $v1, 0x1C($s0)
    /* F3378 80102B78 0700A292 */  lbu        $v0, 0x7($s5)
    /* F337C 80102B7C 00000000 */  nop
    /* F3380 80102B80 2C0002A2 */  sb         $v0, 0x2C($s0)
    /* F3384 80102B84 0800A292 */  lbu        $v0, 0x8($s5)
    /* F3388 80102B88 00000000 */  nop
    /* F338C 80102B8C 2E0002A2 */  sb         $v0, 0x2E($s0)
    /* F3390 80102B90 09008392 */  lbu        $v1, 0x9($s4)
    /* F3394 80102B94 01000224 */  addiu      $v0, $zero, 0x1
    /* F3398 80102B98 300002A2 */  sb         $v0, 0x30($s0)
    /* F339C 80102B9C 310000A2 */  sb         $zero, 0x31($s0)
    /* F33A0 80102BA0 320000A2 */  sb         $zero, 0x32($s0)
    /* F33A4 80102BA4 330002A2 */  sb         $v0, 0x33($s0)
    /* F33A8 80102BA8 2F0003A2 */  sb         $v1, 0x2F($s0)
    /* F33AC 80102BAC 0900A292 */  lbu        $v0, 0x9($s5)
    /* F33B0 80102BB0 00000000 */  nop
    /* F33B4 80102BB4 340002A2 */  sb         $v0, 0x34($s0)
    /* F33B8 80102BB8 0A008292 */  lbu        $v0, 0xA($s4)
    /* F33BC 80102BBC 00000000 */  nop
    /* F33C0 80102BC0 350002A2 */  sb         $v0, 0x35($s0)
    /* F33C4 80102BC4 0A00A382 */  lb         $v1, 0xA($s5)
    /* F33C8 80102BC8 370000A2 */  sb         $zero, 0x37($s0)
    /* F33CC 80102BCC 360000A2 */  sb         $zero, 0x36($s0)
    /* F33D0 80102BD0 40100300 */  sll        $v0, $v1, 1
    /* F33D4 80102BD4 21104300 */  addu       $v0, $v0, $v1
    /* F33D8 80102BD8 C0100200 */  sll        $v0, $v0, 3
    /* F33DC 80102BDC 21104300 */  addu       $v0, $v0, $v1
    /* F33E0 80102BE0 80100200 */  sll        $v0, $v0, 2
    /* F33E4 80102BE4 5A0002A6 */  sh         $v0, 0x5A($s0)
    /* F33E8 80102BE8 07008292 */  lbu        $v0, 0x7($s4)
    /* F33EC 80102BEC 21204002 */  addu       $a0, $s2, $zero
    /* F33F0 80102BF0 400000AE */  sw         $zero, 0x40($s0)
    /* F33F4 80102BF4 440000AE */  sw         $zero, 0x44($s0)
    /* F33F8 80102BF8 3D0002A2 */  sb         $v0, 0x3D($s0)
    /* F33FC 80102BFC 480000AE */  sw         $zero, 0x48($s0)
    /* F3400 80102C00 4C0000AE */  sw         $zero, 0x4C($s0)
    /* F3404 80102C04 500000AE */  sw         $zero, 0x50($s0)
    /* F3408 80102C08 540000AE */  sw         $zero, 0x54($s0)
    /* F340C 80102C0C 6F06040C */  jal        iSNDcalcpitch
    /* F3410 80102C10 5E0000A6 */   sh        $zero, 0x5E($s0)
    /* F3414 80102C14 14FC030C */  jal        iSNDcalcvol
    /* F3418 80102C18 21204002 */   addu      $a0, $s2, $zero
    /* F341C 80102C1C 62000296 */  lhu        $v0, 0x62($s0)
    /* F3420 80102C20 2D000782 */  lb         $a3, 0x2D($s0)
    /* F3424 80102C24 1000A2AF */  sw         $v0, 0x10($sp)
    /* F3428 80102C28 0E008296 */  lhu        $v0, 0xE($s4)
    /* F342C 80102C2C 00000000 */  nop
    /* F3430 80102C30 1400A2AF */  sw         $v0, 0x14($sp)
    /* F3434 80102C34 1480023C */  lui        $v0, %hi(D_80147900)
    /* F3438 80102C38 34000382 */  lb         $v1, 0x34($s0)
    /* F343C 80102C3C 0079428C */  lw         $v0, %lo(D_80147900)($v0)
    /* F3440 80102C40 00000000 */  nop
    /* F3444 80102C44 18004300 */  mult       $v0, $v1
    /* F3448 80102C48 12600000 */  mflo       $t4
    /* F344C 80102C4C 35000382 */  lb         $v1, 0x35($s0)
    /* F3450 80102C50 00000000 */  nop
    /* F3454 80102C54 18008301 */  mult       $t4, $v1
    /* F3458 80102C58 12180000 */  mflo       $v1
    /* F345C 80102C5C 0682023C */  lui        $v0, (0x82061029 >> 16)
    /* F3460 80102C60 29104234 */  ori        $v0, $v0, (0x82061029 & 0xFFFF)
    /* F3464 80102C64 18006200 */  mult       $v1, $v0
    /* F3468 80102C68 2120E002 */  addu       $a0, $s7, $zero
    /* F346C 80102C6C 21284002 */  addu       $a1, $s2, $zero
    /* F3470 80102C70 21306002 */  addu       $a2, $s3, $zero
    /* F3474 80102C74 1C00B6AF */  sw         $s6, 0x1C($sp)
    /* F3478 80102C78 0C00A226 */  addiu      $v0, $s5, 0xC
    /* F347C 80102C7C 2000A2AF */  sw         $v0, 0x20($sp)
    /* F3480 80102C80 10600000 */  mfhi       $t4
    /* F3484 80102C84 21108301 */  addu       $v0, $t4, $v1
    /* F3488 80102C88 43130200 */  sra        $v0, $v0, 13
    /* F348C 80102C8C C31F0300 */  sra        $v1, $v1, 31
    /* F3490 80102C90 23104300 */  subu       $v0, $v0, $v1
    /* F3494 80102C94 C110040C */  jal        iSNDplatformpacketplay
    /* F3498 80102C98 1800A2AF */   sw        $v0, 0x18($sp)
    /* F349C 80102C9C 21804000 */  addu       $s0, $v0, $zero
    /* F34A0 80102CA0 06000006 */  bltz       $s0, .L80102CBC
    /* F34A4 80102CA4 00000000 */   nop
    /* F34A8 80102CA8 5BA9030C */  jal        iSNDleaveaudio
    /* F34AC 80102CAC 00000000 */   nop
    /* F34B0 80102CB0 0000228E */  lw         $v0, 0x0($s1)
    /* F34B4 80102CB4 340B0408 */  j          .L80102CD0
    /* F34B8 80102CB8 00000000 */   nop
  .L80102CBC:
    /* F34BC 80102CBC 03FB030C */  jal        iSNDfreechan
    /* F34C0 80102CC0 21204002 */   addu      $a0, $s2, $zero
    /* F34C4 80102CC4 5BA9030C */  jal        iSNDleaveaudio
    /* F34C8 80102CC8 00000000 */   nop
    /* F34CC 80102CCC 21100002 */  addu       $v0, $s0, $zero
  .L80102CD0:
    /* F34D0 80102CD0 5000BF8F */  lw         $ra, 0x50($sp)
    /* F34D4 80102CD4 4C00B78F */  lw         $s7, 0x4C($sp)
    /* F34D8 80102CD8 4800B68F */  lw         $s6, 0x48($sp)
    /* F34DC 80102CDC 4400B58F */  lw         $s5, 0x44($sp)
    /* F34E0 80102CE0 4000B48F */  lw         $s4, 0x40($sp)
    /* F34E4 80102CE4 3C00B38F */  lw         $s3, 0x3C($sp)
    /* F34E8 80102CE8 3800B28F */  lw         $s2, 0x38($sp)
    /* F34EC 80102CEC 3400B18F */  lw         $s1, 0x34($sp)
    /* F34F0 80102CF0 3000B08F */  lw         $s0, 0x30($sp)
    /* F34F4 80102CF4 0800E003 */  jr         $ra
    /* F34F8 80102CF8 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel SNDPKTPLAY_start
