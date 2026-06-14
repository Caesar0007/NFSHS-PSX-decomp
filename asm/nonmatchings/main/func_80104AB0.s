.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_80104AB0, 0x16C

glabel func_80104AB0
    /* F52B0 80104AB0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F52B4 80104AB4 1380033C */  lui        $v1, %hi(_padChanStart)
    /* F52B8 80104AB8 C87C638C */  lw         $v1, %lo(_padChanStart)($v1)
    /* F52BC 80104ABC 01000224 */  addiu      $v0, $zero, 0x1
    /* F52C0 80104AC0 1000BFAF */  sw         $ra, 0x10($sp)
    /* F52C4 80104AC4 1380013C */  lui        $at, %hi(D_80137CE0)
    /* F52C8 80104AC8 09006010 */  beqz       $v1, .L80104AF0
    /* F52CC 80104ACC E07C22AC */   sw        $v0, %lo(D_80137CE0)($at)
    /* F52D0 80104AD0 1580043C */  lui        $a0, %hi(D_8014858C)
    /* F52D4 80104AD4 8C858424 */  addiu      $a0, $a0, %lo(D_8014858C)
    /* F52D8 80104AD8 0000838C */  lw         $v1, 0x0($a0)
    /* F52DC 80104ADC 00000000 */  nop
    /* F52E0 80104AE0 96006228 */  slti       $v0, $v1, 0x96
    /* F52E4 80104AE4 02004010 */  beqz       $v0, .L80104AF0
    /* F52E8 80104AE8 01006224 */   addiu     $v0, $v1, 0x1
    /* F52EC 80104AEC 000082AC */  sw         $v0, 0x0($a0)
  .L80104AF0:
    /* F52F0 80104AF0 1380023C */  lui        $v0, %hi(_padChanStop)
    /* F52F4 80104AF4 CC7C428C */  lw         $v0, %lo(_padChanStop)($v0)
    /* F52F8 80104AF8 00000000 */  nop
    /* F52FC 80104AFC 09004014 */  bnez       $v0, .L80104B24
    /* F5300 80104B00 00000000 */   nop
    /* F5304 80104B04 1580043C */  lui        $a0, %hi(D_80148590)
    /* F5308 80104B08 90858424 */  addiu      $a0, $a0, %lo(D_80148590)
    /* F530C 80104B0C 0000838C */  lw         $v1, 0x0($a0)
    /* F5310 80104B10 00000000 */  nop
    /* F5314 80104B14 96006228 */  slti       $v0, $v1, 0x96
    /* F5318 80104B18 02004010 */  beqz       $v0, .L80104B24
    /* F531C 80104B1C 01006224 */   addiu     $v0, $v1, 0x1
    /* F5320 80104B20 000082AC */  sw         $v0, 0x0($a0)
  .L80104B24:
    /* F5324 80104B24 1380023C */  lui        $v0, %hi(_padIntExec)
    /* F5328 80104B28 B07C428C */  lw         $v0, %lo(_padIntExec)($v0)
    /* F532C 80104B2C 00000000 */  nop
    /* F5330 80104B30 36004010 */  beqz       $v0, .L80104C0C
    /* F5334 80104B34 00000000 */   nop
    /* F5338 80104B38 1380033C */  lui        $v1, %hi(_padChanStart)
    /* F533C 80104B3C C87C638C */  lw         $v1, %lo(_padChanStart)($v1)
    /* F5340 80104B40 1380023C */  lui        $v0, %hi(_padChanStop)
    /* F5344 80104B44 CC7C428C */  lw         $v0, %lo(_padChanStop)($v0)
    /* F5348 80104B48 00000000 */  nop
    /* F534C 80104B4C 2A104300 */  slt        $v0, $v0, $v1
    /* F5350 80104B50 2E004014 */  bnez       $v0, .L80104C0C
    /* F5354 80104B54 00210300 */   sll       $a0, $v1, 4
    /* F5358 80104B58 23208300 */  subu       $a0, $a0, $v1
    /* F535C 80104B5C 1380023C */  lui        $v0, %hi(_padInfoDir)
    /* F5360 80104B60 AC7C428C */  lw         $v0, %lo(_padInfoDir)($v0)
    /* F5364 80104B64 00210400 */  sll        $a0, $a0, 4
    /* F5368 80104B68 1380013C */  lui        $at, %hi(_padSioState)
    /* F536C 80104B6C BC7C20AC */  sw         $zero, %lo(_padSioState)($at)
    /* F5370 80104B70 1380013C */  lui        $at, %hi(_padSioChan)
    /* F5374 80104B74 B87C23AC */  sw         $v1, %lo(_padSioChan)($at)
    /* F5378 80104B78 4B13040C */  jal        _padInitSioMode
    /* F537C 80104B7C 21204400 */   addu      $a0, $v0, $a0
    /* F5380 80104B80 06004014 */  bnez       $v0, .L80104B9C
    /* F5384 80104B84 00000000 */   nop
    /* F5388 80104B88 1380023C */  lui        $v0, %hi(_padFuncNextPort)
    /* F538C 80104B8C 787C428C */  lw         $v0, %lo(_padFuncNextPort)($v0)
    /* F5390 80104B90 00000000 */  nop
    /* F5394 80104B94 09F84000 */  jalr       $v0
    /* F5398 80104B98 FFFF0434 */   ori       $a0, $zero, 0xFFFF
  .L80104B9C:
    /* F539C 80104B9C 1380033C */  lui        $v1, %hi(_padSioChan)
    /* F53A0 80104BA0 B87C638C */  lw         $v1, %lo(_padSioChan)($v1)
    /* F53A4 80104BA4 1380023C */  lui        $v0, %hi(_padChanStop)
    /* F53A8 80104BA8 CC7C428C */  lw         $v0, %lo(_padChanStop)($v0)
    /* F53AC 80104BAC 1380013C */  lui        $at, %hi(_padTotalCurr)
    /* F53B0 80104BB0 C07C20AC */  sw         $zero, %lo(_padTotalCurr)($at)
    /* F53B4 80104BB4 2A104300 */  slt        $v0, $v0, $v1
    /* F53B8 80104BB8 10004014 */  bnez       $v0, .L80104BFC
    /* F53BC 80104BBC 00000000 */   nop
  .L80104BC0:
    /* F53C0 80104BC0 00210300 */  sll        $a0, $v1, 4
    /* F53C4 80104BC4 23208300 */  subu       $a0, $a0, $v1
    /* F53C8 80104BC8 1380023C */  lui        $v0, %hi(_padInfoDir)
    /* F53CC 80104BCC AC7C428C */  lw         $v0, %lo(_padInfoDir)($v0)
    /* F53D0 80104BD0 00210400 */  sll        $a0, $a0, 4
    /* F53D4 80104BD4 1814040C */  jal        func_80105060
    /* F53D8 80104BD8 21204400 */   addu      $a0, $v0, $a0
    /* F53DC 80104BDC 1380033C */  lui        $v1, %hi(_padSioChan)
    /* F53E0 80104BE0 B87C638C */  lw         $v1, %lo(_padSioChan)($v1)
    /* F53E4 80104BE4 1380023C */  lui        $v0, %hi(_padChanStop)
    /* F53E8 80104BE8 CC7C428C */  lw         $v0, %lo(_padChanStop)($v0)
    /* F53EC 80104BEC 00000000 */  nop
    /* F53F0 80104BF0 2A104300 */  slt        $v0, $v0, $v1
    /* F53F4 80104BF4 F2FF4010 */  beqz       $v0, .L80104BC0
    /* F53F8 80104BF8 00000000 */   nop
  .L80104BFC:
    /* F53FC 80104BFC 1380033C */  lui        $v1, %hi(D_80137CDC)
    /* F5400 80104C00 DC7C638C */  lw         $v1, %lo(D_80137CDC)($v1)
    /* F5404 80104C04 88000224 */  addiu      $v0, $zero, 0x88
    /* F5408 80104C08 0E0062A4 */  sh         $v0, 0xE($v1)
  .L80104C0C:
    /* F540C 80104C0C 1000BF8F */  lw         $ra, 0x10($sp)
    /* F5410 80104C10 21100000 */  addu       $v0, $zero, $zero
    /* F5414 80104C14 0800E003 */  jr         $ra
    /* F5418 80104C18 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_80104AB0
