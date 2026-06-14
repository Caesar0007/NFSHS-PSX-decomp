.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Weather_CheckAndResetParticles__FP7SVECTOR, 0x37C

glabel Weather_CheckAndResetParticles__FP7SVECTOR
    /* D31D4 800E29D4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D31D8 800E29D8 1800B2AF */  sw         $s2, 0x18($sp)
    /* D31DC 800E29DC 21908000 */  addu       $s2, $a0, $zero
    /* D31E0 800E29E0 1280023C */  lui        $v0, %hi(Weather_gSys)
    /* D31E4 800E29E4 1400B1AF */  sw         $s1, 0x14($sp)
    /* D31E8 800E29E8 08345124 */  addiu      $s1, $v0, %lo(Weather_gSys)
    /* D31EC 800E29EC 1000B0AF */  sw         $s0, 0x10($sp)
    /* D31F0 800E29F0 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* D31F4 800E29F4 00004586 */  lh         $a1, 0x0($s2)
    /* D31F8 800E29F8 20002486 */  lh         $a0, 0x20($s1)
    /* D31FC 800E29FC 20002396 */  lhu        $v1, 0x20($s1)
    /* D3200 800E2A00 2A108500 */  slt        $v0, $a0, $a1
    /* D3204 800E2A04 1B004010 */  beqz       $v0, .L800E2A74
    /* D3208 800E2A08 21800000 */   addu      $s0, $zero, $zero
    /* D320C 800E2A0C 23100300 */  negu       $v0, $v1
    /* D3210 800E2A10 40004224 */  addiu      $v0, $v0, 0x40
    /* D3214 800E2A14 EA9D030C */  jal        random
    /* D3218 800E2A18 000042A6 */   sh        $v0, 0x0($s2)
    /* D321C 800E2A1C 1E002386 */  lh         $v1, 0x1E($s1)
    /* D3220 800E2A20 00000000 */  nop
    /* D3224 800E2A24 1B004300 */  divu       $zero, $v0, $v1
    /* D3228 800E2A28 02006014 */  bnez       $v1, .L800E2A34
    /* D322C 800E2A2C 00000000 */   nop
    /* D3230 800E2A30 0D000700 */  break      7
  .L800E2A34:
    /* D3234 800E2A34 10180000 */  mfhi       $v1
    /* D3238 800E2A38 1A002296 */  lhu        $v0, 0x1A($s1)
    /* D323C 800E2A3C 00000000 */  nop
    /* D3240 800E2A40 21104300 */  addu       $v0, $v0, $v1
    /* D3244 800E2A44 EA9D030C */  jal        random
    /* D3248 800E2A48 020042A6 */   sh        $v0, 0x2($s2)
    /* D324C 800E2A4C 18002386 */  lh         $v1, 0x18($s1)
    /* D3250 800E2A50 00000000 */  nop
    /* D3254 800E2A54 1B004300 */  divu       $zero, $v0, $v1
    /* D3258 800E2A58 02006014 */  bnez       $v1, .L800E2A64
    /* D325C 800E2A5C 00000000 */   nop
    /* D3260 800E2A60 0D000700 */  break      7
  .L800E2A64:
    /* D3264 800E2A64 10180000 */  mfhi       $v1
    /* D3268 800E2A68 14002296 */  lhu        $v0, 0x14($s1)
    /* D326C 800E2A6C B88A0308 */  j          .L800E2AE0
    /* D3270 800E2A70 01001024 */   addiu     $s0, $zero, 0x1
  .L800E2A74:
    /* D3274 800E2A74 23100400 */  negu       $v0, $a0
    /* D3278 800E2A78 2A10A200 */  slt        $v0, $a1, $v0
    /* D327C 800E2A7C 1A004010 */  beqz       $v0, .L800E2AE8
    /* D3280 800E2A80 C0FF6224 */   addiu     $v0, $v1, -0x40
    /* D3284 800E2A84 EA9D030C */  jal        random
    /* D3288 800E2A88 000042A6 */   sh        $v0, 0x0($s2)
    /* D328C 800E2A8C 1E002386 */  lh         $v1, 0x1E($s1)
    /* D3290 800E2A90 00000000 */  nop
    /* D3294 800E2A94 1B004300 */  divu       $zero, $v0, $v1
    /* D3298 800E2A98 02006014 */  bnez       $v1, .L800E2AA4
    /* D329C 800E2A9C 00000000 */   nop
    /* D32A0 800E2AA0 0D000700 */  break      7
  .L800E2AA4:
    /* D32A4 800E2AA4 10180000 */  mfhi       $v1
    /* D32A8 800E2AA8 1A002296 */  lhu        $v0, 0x1A($s1)
    /* D32AC 800E2AAC 00000000 */  nop
    /* D32B0 800E2AB0 21104300 */  addu       $v0, $v0, $v1
    /* D32B4 800E2AB4 EA9D030C */  jal        random
    /* D32B8 800E2AB8 020042A6 */   sh        $v0, 0x2($s2)
    /* D32BC 800E2ABC 18002386 */  lh         $v1, 0x18($s1)
    /* D32C0 800E2AC0 00000000 */  nop
    /* D32C4 800E2AC4 1B004300 */  divu       $zero, $v0, $v1
    /* D32C8 800E2AC8 02006014 */  bnez       $v1, .L800E2AD4
    /* D32CC 800E2ACC 00000000 */   nop
    /* D32D0 800E2AD0 0D000700 */  break      7
  .L800E2AD4:
    /* D32D4 800E2AD4 10180000 */  mfhi       $v1
    /* D32D8 800E2AD8 14002296 */  lhu        $v0, 0x14($s1)
    /* D32DC 800E2ADC 02001024 */  addiu      $s0, $zero, 0x2
  .L800E2AE0:
    /* D32E0 800E2AE0 21104300 */  addu       $v0, $v0, $v1
    /* D32E4 800E2AE4 040042A6 */  sh         $v0, 0x4($s2)
  .L800E2AE8:
    /* D32E8 800E2AE8 1280023C */  lui        $v0, %hi(Weather_gSys)
    /* D32EC 800E2AEC 08345124 */  addiu      $s1, $v0, %lo(Weather_gSys)
    /* D32F0 800E2AF0 04004386 */  lh         $v1, 0x4($s2)
    /* D32F4 800E2AF4 16002286 */  lh         $v0, 0x16($s1)
    /* D32F8 800E2AF8 00000000 */  nop
    /* D32FC 800E2AFC 2A104300 */  slt        $v0, $v0, $v1
    /* D3300 800E2B00 1C004010 */  beqz       $v0, .L800E2B74
    /* D3304 800E2B04 00000000 */   nop
    /* D3308 800E2B08 14002296 */  lhu        $v0, 0x14($s1)
    /* D330C 800E2B0C 00000000 */  nop
    /* D3310 800E2B10 40004224 */  addiu      $v0, $v0, 0x40
    /* D3314 800E2B14 EA9D030C */  jal        random
    /* D3318 800E2B18 040042A6 */   sh        $v0, 0x4($s2)
    /* D331C 800E2B1C 20002386 */  lh         $v1, 0x20($s1)
    /* D3320 800E2B20 00000000 */  nop
    /* D3324 800E2B24 1B004300 */  divu       $zero, $v0, $v1
    /* D3328 800E2B28 02006014 */  bnez       $v1, .L800E2B34
    /* D332C 800E2B2C 00000000 */   nop
    /* D3330 800E2B30 0D000700 */  break      7
  .L800E2B34:
    /* D3334 800E2B34 10180000 */  mfhi       $v1
    /* D3338 800E2B38 20002296 */  lhu        $v0, 0x20($s1)
    /* D333C 800E2B3C 40180300 */  sll        $v1, $v1, 1
    /* D3340 800E2B40 23186200 */  subu       $v1, $v1, $v0
    /* D3344 800E2B44 EA9D030C */  jal        random
    /* D3348 800E2B48 000043A6 */   sh        $v1, 0x0($s2)
    /* D334C 800E2B4C 1E002386 */  lh         $v1, 0x1E($s1)
    /* D3350 800E2B50 00000000 */  nop
    /* D3354 800E2B54 1B004300 */  divu       $zero, $v0, $v1
    /* D3358 800E2B58 02006014 */  bnez       $v1, .L800E2B64
    /* D335C 800E2B5C 00000000 */   nop
    /* D3360 800E2B60 0D000700 */  break      7
  .L800E2B64:
    /* D3364 800E2B64 10180000 */  mfhi       $v1
    /* D3368 800E2B68 1A002296 */  lhu        $v0, 0x1A($s1)
    /* D336C 800E2B6C 098B0308 */  j          .L800E2C24
    /* D3370 800E2B70 03001024 */   addiu     $s0, $zero, 0x3
  .L800E2B74:
    /* D3374 800E2B74 14002286 */  lh         $v0, 0x14($s1)
    /* D3378 800E2B78 00000000 */  nop
    /* D337C 800E2B7C 2A106200 */  slt        $v0, $v1, $v0
    /* D3380 800E2B80 2C004010 */  beqz       $v0, .L800E2C34
    /* D3384 800E2B84 1280023C */   lui       $v0, %hi(Weather_gSys)
    /* D3388 800E2B88 EA9D030C */  jal        random
    /* D338C 800E2B8C 04001024 */   addiu     $s0, $zero, 0x4
    /* D3390 800E2B90 16002396 */  lhu        $v1, 0x16($s1)
    /* D3394 800E2B94 00000000 */  nop
    /* D3398 800E2B98 001C0300 */  sll        $v1, $v1, 16
    /* D339C 800E2B9C 03240300 */  sra        $a0, $v1, 16
    /* D33A0 800E2BA0 C21F0300 */  srl        $v1, $v1, 31
    /* D33A4 800E2BA4 21208300 */  addu       $a0, $a0, $v1
    /* D33A8 800E2BA8 43200400 */  sra        $a0, $a0, 1
    /* D33AC 800E2BAC 1B004400 */  divu       $zero, $v0, $a0
    /* D33B0 800E2BB0 02008014 */  bnez       $a0, .L800E2BBC
    /* D33B4 800E2BB4 00000000 */   nop
    /* D33B8 800E2BB8 0D000700 */  break      7
  .L800E2BBC:
    /* D33BC 800E2BBC 10180000 */  mfhi       $v1
    /* D33C0 800E2BC0 14002296 */  lhu        $v0, 0x14($s1)
    /* D33C4 800E2BC4 00000000 */  nop
    /* D33C8 800E2BC8 21104300 */  addu       $v0, $v0, $v1
    /* D33CC 800E2BCC EA9D030C */  jal        random
    /* D33D0 800E2BD0 040042A6 */   sh        $v0, 0x4($s2)
    /* D33D4 800E2BD4 20002386 */  lh         $v1, 0x20($s1)
    /* D33D8 800E2BD8 00000000 */  nop
    /* D33DC 800E2BDC 1B004300 */  divu       $zero, $v0, $v1
    /* D33E0 800E2BE0 02006014 */  bnez       $v1, .L800E2BEC
    /* D33E4 800E2BE4 00000000 */   nop
    /* D33E8 800E2BE8 0D000700 */  break      7
  .L800E2BEC:
    /* D33EC 800E2BEC 10180000 */  mfhi       $v1
    /* D33F0 800E2BF0 20002296 */  lhu        $v0, 0x20($s1)
    /* D33F4 800E2BF4 40180300 */  sll        $v1, $v1, 1
    /* D33F8 800E2BF8 23186200 */  subu       $v1, $v1, $v0
    /* D33FC 800E2BFC EA9D030C */  jal        random
    /* D3400 800E2C00 000043A6 */   sh        $v1, 0x0($s2)
    /* D3404 800E2C04 1E002386 */  lh         $v1, 0x1E($s1)
    /* D3408 800E2C08 00000000 */  nop
    /* D340C 800E2C0C 1B004300 */  divu       $zero, $v0, $v1
    /* D3410 800E2C10 02006014 */  bnez       $v1, .L800E2C1C
    /* D3414 800E2C14 00000000 */   nop
    /* D3418 800E2C18 0D000700 */  break      7
  .L800E2C1C:
    /* D341C 800E2C1C 10180000 */  mfhi       $v1
    /* D3420 800E2C20 1A002296 */  lhu        $v0, 0x1A($s1)
  .L800E2C24:
    /* D3424 800E2C24 00000000 */  nop
    /* D3428 800E2C28 21104300 */  addu       $v0, $v0, $v1
    /* D342C 800E2C2C 020042A6 */  sh         $v0, 0x2($s2)
    /* D3430 800E2C30 1280023C */  lui        $v0, %hi(Weather_gSys)
  .L800E2C34:
    /* D3434 800E2C34 08345124 */  addiu      $s1, $v0, %lo(Weather_gSys)
    /* D3438 800E2C38 02004486 */  lh         $a0, 0x2($s2)
    /* D343C 800E2C3C 1C002286 */  lh         $v0, 0x1C($s1)
    /* D3440 800E2C40 1C002396 */  lhu        $v1, 0x1C($s1)
    /* D3444 800E2C44 2A104400 */  slt        $v0, $v0, $a0
    /* D3448 800E2C48 1C004010 */  beqz       $v0, .L800E2CBC
    /* D344C 800E2C4C 00000000 */   nop
    /* D3450 800E2C50 1A002296 */  lhu        $v0, 0x1A($s1)
    /* D3454 800E2C54 00000000 */  nop
    /* D3458 800E2C58 40004224 */  addiu      $v0, $v0, 0x40
    /* D345C 800E2C5C EA9D030C */  jal        random
    /* D3460 800E2C60 020042A6 */   sh        $v0, 0x2($s2)
    /* D3464 800E2C64 20002386 */  lh         $v1, 0x20($s1)
    /* D3468 800E2C68 00000000 */  nop
    /* D346C 800E2C6C 1B004300 */  divu       $zero, $v0, $v1
    /* D3470 800E2C70 02006014 */  bnez       $v1, .L800E2C7C
    /* D3474 800E2C74 00000000 */   nop
    /* D3478 800E2C78 0D000700 */  break      7
  .L800E2C7C:
    /* D347C 800E2C7C 10180000 */  mfhi       $v1
    /* D3480 800E2C80 20002296 */  lhu        $v0, 0x20($s1)
    /* D3484 800E2C84 40180300 */  sll        $v1, $v1, 1
    /* D3488 800E2C88 23186200 */  subu       $v1, $v1, $v0
    /* D348C 800E2C8C EA9D030C */  jal        random
    /* D3490 800E2C90 000043A6 */   sh        $v1, 0x0($s2)
    /* D3494 800E2C94 18002386 */  lh         $v1, 0x18($s1)
    /* D3498 800E2C98 00000000 */  nop
    /* D349C 800E2C9C 1B004300 */  divu       $zero, $v0, $v1
    /* D34A0 800E2CA0 02006014 */  bnez       $v1, .L800E2CAC
    /* D34A4 800E2CA4 00000000 */   nop
    /* D34A8 800E2CA8 0D000700 */  break      7
  .L800E2CAC:
    /* D34AC 800E2CAC 10180000 */  mfhi       $v1
    /* D34B0 800E2CB0 14002296 */  lhu        $v0, 0x14($s1)
    /* D34B4 800E2CB4 4B8B0308 */  j          .L800E2D2C
    /* D34B8 800E2CB8 05001024 */   addiu     $s0, $zero, 0x5
  .L800E2CBC:
    /* D34BC 800E2CBC 1A002286 */  lh         $v0, 0x1A($s1)
    /* D34C0 800E2CC0 00000000 */  nop
    /* D34C4 800E2CC4 2A108200 */  slt        $v0, $a0, $v0
    /* D34C8 800E2CC8 1A004010 */  beqz       $v0, .L800E2D34
    /* D34CC 800E2CCC C0FF6224 */   addiu     $v0, $v1, -0x40
    /* D34D0 800E2CD0 EA9D030C */  jal        random
    /* D34D4 800E2CD4 020042A6 */   sh        $v0, 0x2($s2)
    /* D34D8 800E2CD8 20002386 */  lh         $v1, 0x20($s1)
    /* D34DC 800E2CDC 00000000 */  nop
    /* D34E0 800E2CE0 1B004300 */  divu       $zero, $v0, $v1
    /* D34E4 800E2CE4 02006014 */  bnez       $v1, .L800E2CF0
    /* D34E8 800E2CE8 00000000 */   nop
    /* D34EC 800E2CEC 0D000700 */  break      7
  .L800E2CF0:
    /* D34F0 800E2CF0 10180000 */  mfhi       $v1
    /* D34F4 800E2CF4 20002296 */  lhu        $v0, 0x20($s1)
    /* D34F8 800E2CF8 40180300 */  sll        $v1, $v1, 1
    /* D34FC 800E2CFC 23186200 */  subu       $v1, $v1, $v0
    /* D3500 800E2D00 EA9D030C */  jal        random
    /* D3504 800E2D04 000043A6 */   sh        $v1, 0x0($s2)
    /* D3508 800E2D08 18002386 */  lh         $v1, 0x18($s1)
    /* D350C 800E2D0C 00000000 */  nop
    /* D3510 800E2D10 1B004300 */  divu       $zero, $v0, $v1
    /* D3514 800E2D14 02006014 */  bnez       $v1, .L800E2D20
    /* D3518 800E2D18 00000000 */   nop
    /* D351C 800E2D1C 0D000700 */  break      7
  .L800E2D20:
    /* D3520 800E2D20 10180000 */  mfhi       $v1
    /* D3524 800E2D24 14002296 */  lhu        $v0, 0x14($s1)
    /* D3528 800E2D28 06001024 */  addiu      $s0, $zero, 0x6
  .L800E2D2C:
    /* D352C 800E2D2C 21104300 */  addu       $v0, $v0, $v1
    /* D3530 800E2D30 040042A6 */  sh         $v0, 0x4($s2)
  .L800E2D34:
    /* D3534 800E2D34 21100002 */  addu       $v0, $s0, $zero
    /* D3538 800E2D38 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* D353C 800E2D3C 1800B28F */  lw         $s2, 0x18($sp)
    /* D3540 800E2D40 1400B18F */  lw         $s1, 0x14($sp)
    /* D3544 800E2D44 1000B08F */  lw         $s0, 0x10($sp)
    /* D3548 800E2D48 0800E003 */  jr         $ra
    /* D354C 800E2D4C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Weather_CheckAndResetParticles__FP7SVECTOR
