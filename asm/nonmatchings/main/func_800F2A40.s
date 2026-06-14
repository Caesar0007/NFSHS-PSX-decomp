.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800F2A40, 0x1D0

glabel func_800F2A40
    /* E3240 800F2A40 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* E3244 800F2A44 1400B1AF */  sw         $s1, 0x14($sp)
    /* E3248 800F2A48 1380113C */  lui        $s1, %hi(D_80134AF8)
    /* E324C 800F2A4C F84A3126 */  addiu      $s1, $s1, %lo(D_80134AF8)
    /* E3250 800F2A50 2400BFAF */  sw         $ra, 0x24($sp)
    /* E3254 800F2A54 2000B4AF */  sw         $s4, 0x20($sp)
    /* E3258 800F2A58 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* E325C 800F2A5C 1800B2AF */  sw         $s2, 0x18($sp)
    /* E3260 800F2A60 1000B0AF */  sw         $s0, 0x10($sp)
    /* E3264 800F2A64 00002296 */  lhu        $v0, 0x0($s1)
    /* E3268 800F2A68 00000000 */  nop
    /* E326C 800F2A6C 0A004014 */  bnez       $v0, .L800F2A98
    /* E3270 800F2A70 00000000 */   nop
    /* E3274 800F2A74 1380023C */  lui        $v0, %hi(D_80135B84)
    /* E3278 800F2A78 845B428C */  lw         $v0, %lo(D_80135B84)($v0)
    /* E327C 800F2A7C 00000000 */  nop
    /* E3280 800F2A80 00004594 */  lhu        $a1, 0x0($v0)
    /* E3284 800F2A84 0580043C */  lui        $a0, %hi(D_80056F80)
    /* E3288 800F2A88 2B0A040C */  jal        printf
    /* E328C 800F2A8C 806F8424 */   addiu     $a0, $a0, %lo(D_80056F80)
    /* E3290 800F2A90 5F1A040C */  jal        ReturnFromException
    /* E3294 800F2A94 00000000 */   nop
  .L800F2A98:
    /* E3298 800F2A98 1380043C */  lui        $a0, %hi(D_80135B84)
    /* E329C 800F2A9C 845B848C */  lw         $a0, %lo(D_80135B84)($a0)
    /* E32A0 800F2AA0 30002396 */  lhu        $v1, 0x30($s1)
    /* E32A4 800F2AA4 01000224 */  addiu      $v0, $zero, 0x1
    /* E32A8 800F2AA8 020022A6 */  sh         $v0, 0x2($s1)
    /* E32AC 800F2AAC 1380023C */  lui        $v0, %hi(D_80135B88)
    /* E32B0 800F2AB0 885B428C */  lw         $v0, %lo(D_80135B88)($v0)
    /* E32B4 800F2AB4 00008494 */  lhu        $a0, 0x0($a0)
    /* E32B8 800F2AB8 00004294 */  lhu        $v0, 0x0($v0)
    /* E32BC 800F2ABC 24186400 */  and        $v1, $v1, $a0
    /* E32C0 800F2AC0 24104300 */  and        $v0, $v0, $v1
    /* E32C4 800F2AC4 26004010 */  beqz       $v0, .L800F2B60
    /* E32C8 800F2AC8 21804000 */   addu      $s0, $v0, $zero
    /* E32CC 800F2ACC 01001324 */  addiu      $s3, $zero, 0x1
    /* E32D0 800F2AD0 04003426 */  addiu      $s4, $s1, 0x4
  .L800F2AD4:
    /* E32D4 800F2AD4 16000012 */  beqz       $s0, .L800F2B30
    /* E32D8 800F2AD8 21880000 */   addu      $s1, $zero, $zero
    /* E32DC 800F2ADC 21908002 */  addu       $s2, $s4, $zero
  .L800F2AE0:
    /* E32E0 800F2AE0 0B00222A */  slti       $v0, $s1, 0xB
    /* E32E4 800F2AE4 12004010 */  beqz       $v0, .L800F2B30
    /* E32E8 800F2AE8 01000232 */   andi      $v0, $s0, 0x1
    /* E32EC 800F2AEC 0B004010 */  beqz       $v0, .L800F2B1C
    /* E32F0 800F2AF0 04103302 */   sllv      $v0, $s3, $s1
    /* E32F4 800F2AF4 1380033C */  lui        $v1, %hi(D_80135B84)
    /* E32F8 800F2AF8 845B638C */  lw         $v1, %lo(D_80135B84)($v1)
    /* E32FC 800F2AFC 27100200 */  nor        $v0, $zero, $v0
    /* E3300 800F2B00 000062A4 */  sh         $v0, 0x0($v1)
    /* E3304 800F2B04 0000428E */  lw         $v0, 0x0($s2)
    /* E3308 800F2B08 00000000 */  nop
    /* E330C 800F2B0C 03004010 */  beqz       $v0, .L800F2B1C
    /* E3310 800F2B10 00000000 */   nop
    /* E3314 800F2B14 09F84000 */  jalr       $v0
    /* E3318 800F2B18 00000000 */   nop
  .L800F2B1C:
    /* E331C 800F2B1C 04005226 */  addiu      $s2, $s2, 0x4
    /* E3320 800F2B20 42801000 */  srl        $s0, $s0, 1
    /* E3324 800F2B24 FFFF0232 */  andi       $v0, $s0, 0xFFFF
    /* E3328 800F2B28 EDFF4014 */  bnez       $v0, .L800F2AE0
    /* E332C 800F2B2C 01003126 */   addiu     $s1, $s1, 0x1
  .L800F2B30:
    /* E3330 800F2B30 1380043C */  lui        $a0, %hi(D_80135B84)
    /* E3334 800F2B34 845B848C */  lw         $a0, %lo(D_80135B84)($a0)
    /* E3338 800F2B38 1380033C */  lui        $v1, %hi(D_80134B28)
    /* E333C 800F2B3C 284B6394 */  lhu        $v1, %lo(D_80134B28)($v1)
    /* E3340 800F2B40 1380023C */  lui        $v0, %hi(D_80135B88)
    /* E3344 800F2B44 885B428C */  lw         $v0, %lo(D_80135B88)($v0)
    /* E3348 800F2B48 00008494 */  lhu        $a0, 0x0($a0)
    /* E334C 800F2B4C 00004294 */  lhu        $v0, 0x0($v0)
    /* E3350 800F2B50 24186400 */  and        $v1, $v1, $a0
    /* E3354 800F2B54 24104300 */  and        $v0, $v0, $v1
    /* E3358 800F2B58 DEFF4014 */  bnez       $v0, .L800F2AD4
    /* E335C 800F2B5C 21804000 */   addu      $s0, $v0, $zero
  .L800F2B60:
    /* E3360 800F2B60 1380053C */  lui        $a1, %hi(D_80135B84)
    /* E3364 800F2B64 845BA58C */  lw         $a1, %lo(D_80135B84)($a1)
    /* E3368 800F2B68 1380063C */  lui        $a2, %hi(D_80135B88)
    /* E336C 800F2B6C 885BC68C */  lw         $a2, %lo(D_80135B88)($a2)
    /* E3370 800F2B70 0000A294 */  lhu        $v0, 0x0($a1)
    /* E3374 800F2B74 0000C394 */  lhu        $v1, 0x0($a2)
    /* E3378 800F2B78 00000000 */  nop
    /* E337C 800F2B7C 24104300 */  and        $v0, $v0, $v1
    /* E3380 800F2B80 16004010 */  beqz       $v0, .L800F2BDC
    /* E3384 800F2B84 00000000 */   nop
    /* E3388 800F2B88 1380023C */  lui        $v0, %hi(D_80135B90)
    /* E338C 800F2B8C 905B4224 */  addiu      $v0, $v0, %lo(D_80135B90)
    /* E3390 800F2B90 0000438C */  lw         $v1, 0x0($v0)
    /* E3394 800F2B94 00000000 */  nop
    /* E3398 800F2B98 21206000 */  addu       $a0, $v1, $zero
    /* E339C 800F2B9C 01006324 */  addiu      $v1, $v1, 0x1
    /* E33A0 800F2BA0 01088428 */  slti       $a0, $a0, 0x801
    /* E33A4 800F2BA4 0F008014 */  bnez       $a0, .L800F2BE4
    /* E33A8 800F2BA8 000043AC */   sw        $v1, 0x0($v0)
    /* E33AC 800F2BAC 0580043C */  lui        $a0, %hi(D_80056F9C)
    /* E33B0 800F2BB0 9C6F8424 */  addiu      $a0, $a0, %lo(D_80056F9C)
    /* E33B4 800F2BB4 0000A594 */  lhu        $a1, 0x0($a1)
    /* E33B8 800F2BB8 0000C694 */  lhu        $a2, 0x0($a2)
    /* E33BC 800F2BBC 2B0A040C */  jal        printf
    /* E33C0 800F2BC0 00000000 */   nop
    /* E33C4 800F2BC4 1380023C */  lui        $v0, %hi(D_80135B84)
    /* E33C8 800F2BC8 845B428C */  lw         $v0, %lo(D_80135B84)($v0)
    /* E33CC 800F2BCC 1380013C */  lui        $at, %hi(D_80135B90)
    /* E33D0 800F2BD0 905B20AC */  sw         $zero, %lo(D_80135B90)($at)
    /* E33D4 800F2BD4 F9CA0308 */  j          .L800F2BE4
    /* E33D8 800F2BD8 000040A4 */   sh        $zero, 0x0($v0)
  .L800F2BDC:
    /* E33DC 800F2BDC 1380013C */  lui        $at, %hi(D_80135B90)
    /* E33E0 800F2BE0 905B20AC */  sw         $zero, %lo(D_80135B90)($at)
  .L800F2BE4:
    /* E33E4 800F2BE4 1380013C */  lui        $at, %hi(D_80134AFA)
    /* E33E8 800F2BE8 5F1A040C */  jal        ReturnFromException
    /* E33EC 800F2BEC FA4A20A4 */   sh        $zero, %lo(D_80134AFA)($at)
    /* E33F0 800F2BF0 2400BF8F */  lw         $ra, 0x24($sp)
    /* E33F4 800F2BF4 2000B48F */  lw         $s4, 0x20($sp)
    /* E33F8 800F2BF8 1C00B38F */  lw         $s3, 0x1C($sp)
    /* E33FC 800F2BFC 1800B28F */  lw         $s2, 0x18($sp)
    /* E3400 800F2C00 1400B18F */  lw         $s1, 0x14($sp)
    /* E3404 800F2C04 1000B08F */  lw         $s0, 0x10($sp)
    /* E3408 800F2C08 0800E003 */  jr         $ra
    /* E340C 800F2C0C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel func_800F2A40
