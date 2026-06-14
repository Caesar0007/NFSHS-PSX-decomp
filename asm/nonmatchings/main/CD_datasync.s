.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CD_datasync, 0x168

glabel CD_datasync
    /* F8B20 80108320 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* F8B24 80108324 2000B2AF */  sw         $s2, 0x20($sp)
    /* F8B28 80108328 21908000 */  addu       $s2, $a0, $zero
    /* F8B2C 8010832C FFFF0424 */  addiu      $a0, $zero, -0x1
    /* F8B30 80108330 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* F8B34 80108334 2800B4AF */  sw         $s4, 0x28($sp)
    /* F8B38 80108338 2400B3AF */  sw         $s3, 0x24($sp)
    /* F8B3C 8010833C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* F8B40 80108340 C7C8030C */  jal        VSync
    /* F8B44 80108344 1800B0AF */   sw        $s0, 0x18($sp)
    /* F8B48 80108348 3C00143C */  lui        $s4, (0x3C0000 >> 16)
    /* F8B4C 8010834C 1480133C */  lui        $s3, %hi(CD_comstr)
    /* F8B50 80108350 6CBF7326 */  addiu      $s3, $s3, %lo(CD_comstr)
    /* F8B54 80108354 1480113C */  lui        $s1, %hi(D_8013C224)
    /* F8B58 80108358 24C23126 */  addiu      $s1, $s1, %lo(D_8013C224)
    /* F8B5C 8010835C 1480103C */  lui        $s0, %hi(CD_intstr)
    /* F8B60 80108360 ECBF1026 */  addiu      $s0, $s0, %lo(CD_intstr)
    /* F8B64 80108364 C0034224 */  addiu      $v0, $v0, 0x3C0
    /* F8B68 80108368 1580013C */  lui        $at, %hi(D_801489B4)
    /* F8B6C 8010836C B48922AC */  sw         $v0, %lo(D_801489B4)($at)
    /* F8B70 80108370 0580023C */  lui        $v0, %hi(D_80057880)
    /* F8B74 80108374 80784224 */  addiu      $v0, $v0, %lo(D_80057880)
    /* F8B78 80108378 1580013C */  lui        $at, %hi(D_801489B8)
    /* F8B7C 8010837C B88920AC */  sw         $zero, %lo(D_801489B8)($at)
    /* F8B80 80108380 1580013C */  lui        $at, %hi(D_801489BC)
    /* F8B84 80108384 BC8922AC */  sw         $v0, %lo(D_801489BC)($at)
  .L80108388:
    /* F8B88 80108388 C7C8030C */  jal        VSync
    /* F8B8C 8010838C FFFF0424 */   addiu     $a0, $zero, -0x1
    /* F8B90 80108390 1580033C */  lui        $v1, %hi(D_801489B4)
    /* F8B94 80108394 B489638C */  lw         $v1, %lo(D_801489B4)($v1)
    /* F8B98 80108398 00000000 */  nop
    /* F8B9C 8010839C 2A186200 */  slt        $v1, $v1, $v0
    /* F8BA0 801083A0 0A006014 */  bnez       $v1, .L801083CC
    /* F8BA4 801083A4 00000000 */   nop
    /* F8BA8 801083A8 1580023C */  lui        $v0, %hi(D_801489B8)
    /* F8BAC 801083AC B889428C */  lw         $v0, %lo(D_801489B8)($v0)
    /* F8BB0 801083B0 00000000 */  nop
    /* F8BB4 801083B4 21184000 */  addu       $v1, $v0, $zero
    /* F8BB8 801083B8 01004224 */  addiu      $v0, $v0, 0x1
    /* F8BBC 801083BC 2A188302 */  slt        $v1, $s4, $v1
    /* F8BC0 801083C0 1580013C */  lui        $at, %hi(D_801489B8)
    /* F8BC4 801083C4 1B006010 */  beqz       $v1, .L80108434
    /* F8BC8 801083C8 B88922AC */   sw        $v0, %lo(D_801489B8)($at)
  .L801083CC:
    /* F8BCC 801083CC 0580043C */  lui        $a0, %hi(D_80057774)
    /* F8BD0 801083D0 33A0030C */  jal        puts
    /* F8BD4 801083D4 74778424 */   addiu     $a0, $a0, %lo(D_80057774)
    /* F8BD8 801083D8 00002492 */  lbu        $a0, 0x0($s1)
    /* F8BDC 801083DC 01002292 */  lbu        $v0, 0x1($s1)
    /* F8BE0 801083E0 1580053C */  lui        $a1, %hi(D_801489BC)
    /* F8BE4 801083E4 BC89A58C */  lw         $a1, %lo(D_801489BC)($a1)
    /* F8BE8 801083E8 80100200 */  sll        $v0, $v0, 2
    /* F8BEC 801083EC 21105000 */  addu       $v0, $v0, $s0
    /* F8BF0 801083F0 80200400 */  sll        $a0, $a0, 2
    /* F8BF4 801083F4 0000438C */  lw         $v1, 0x0($v0)
    /* F8BF8 801083F8 1480023C */  lui        $v0, %hi(CD_com)
    /* F8BFC 801083FC 65BF4290 */  lbu        $v0, %lo(CD_com)($v0)
    /* F8C00 80108400 21209000 */  addu       $a0, $a0, $s0
    /* F8C04 80108404 80100200 */  sll        $v0, $v0, 2
    /* F8C08 80108408 21105300 */  addu       $v0, $v0, $s3
    /* F8C0C 8010840C 1000A3AF */  sw         $v1, 0x10($sp)
    /* F8C10 80108410 0000468C */  lw         $a2, 0x0($v0)
    /* F8C14 80108414 0000878C */  lw         $a3, 0x0($a0)
    /* F8C18 80108418 0580043C */  lui        $a0, %hi(D_80057784)
    /* F8C1C 8010841C 2B0A040C */  jal        printf
    /* F8C20 80108420 84778424 */   addiu     $a0, $a0, %lo(D_80057784)
    /* F8C24 80108424 CC1F040C */  jal        CD_flush
    /* F8C28 80108428 00000000 */   nop
    /* F8C2C 8010842C 0E210408 */  j          .L80108438
    /* F8C30 80108430 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L80108434:
    /* F8C34 80108434 21100000 */  addu       $v0, $zero, $zero
  .L80108438:
    /* F8C38 80108438 0B004014 */  bnez       $v0, .L80108468
    /* F8C3C 8010843C FFFF0224 */   addiu     $v0, $zero, -0x1
    /* F8C40 80108440 1480023C */  lui        $v0, %hi(D_8013C250)
    /* F8C44 80108444 50C2428C */  lw         $v0, %lo(D_8013C250)($v0)
    /* F8C48 80108448 00000000 */  nop
    /* F8C4C 8010844C 0000428C */  lw         $v0, 0x0($v0)
    /* F8C50 80108450 0001033C */  lui        $v1, (0x1000000 >> 16)
    /* F8C54 80108454 24104300 */  and        $v0, $v0, $v1
    /* F8C58 80108458 03004010 */  beqz       $v0, .L80108468
    /* F8C5C 8010845C 21100000 */   addu      $v0, $zero, $zero
    /* F8C60 80108460 C9FF4012 */  beqz       $s2, .L80108388
    /* F8C64 80108464 01000224 */   addiu     $v0, $zero, 0x1
  .L80108468:
    /* F8C68 80108468 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* F8C6C 8010846C 2800B48F */  lw         $s4, 0x28($sp)
    /* F8C70 80108470 2400B38F */  lw         $s3, 0x24($sp)
    /* F8C74 80108474 2000B28F */  lw         $s2, 0x20($sp)
    /* F8C78 80108478 1C00B18F */  lw         $s1, 0x1C($sp)
    /* F8C7C 8010847C 1800B08F */  lw         $s0, 0x18($sp)
    /* F8C80 80108480 0800E003 */  jr         $ra
    /* F8C84 80108484 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel CD_datasync
