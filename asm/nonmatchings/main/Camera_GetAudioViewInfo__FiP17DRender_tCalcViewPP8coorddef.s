.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Camera_GetAudioViewInfo__FiP17DRender_tCalcViewPP8coorddef, 0x22C

glabel Camera_GetAudioViewInfo__FiP17DRender_tCalcViewPP8coorddef
    /* 75B3C 8008533C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 75B40 80085340 1800B0AF */  sw         $s0, 0x18($sp)
    /* 75B44 80085344 21808000 */  addu       $s0, $a0, $zero
    /* 75B48 80085348 2138A000 */  addu       $a3, $a1, $zero
    /* 75B4C 8008534C 80101000 */  sll        $v0, $s0, 2
    /* 75B50 80085350 1480033C */  lui        $v1, %hi(Input_gLookBehind)
    /* 75B54 80085354 30D26324 */  addiu      $v1, $v1, %lo(Input_gLookBehind)
    /* 75B58 80085358 21104300 */  addu       $v0, $v0, $v1
    /* 75B5C 8008535C 2000BFAF */  sw         $ra, 0x20($sp)
    /* 75B60 80085360 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 75B64 80085364 0000428C */  lw         $v0, 0x0($v0)
    /* 75B68 80085368 00000000 */  nop
    /* 75B6C 8008536C 1E004014 */  bnez       $v0, .L800853E8
    /* 75B70 80085370 2188C000 */   addu      $s1, $a2, $zero
    /* 75B74 80085374 1180033C */  lui        $v1, %hi(Camera_gInfo)
    /* 75B78 80085378 ACF26324 */  addiu      $v1, $v1, %lo(Camera_gInfo)
    /* 75B7C 8008537C 00111000 */  sll        $v0, $s0, 4
    /* 75B80 80085380 21105000 */  addu       $v0, $v0, $s0
    /* 75B84 80085384 00110200 */  sll        $v0, $v0, 4
    /* 75B88 80085388 21104300 */  addu       $v0, $v0, $v1
    /* 75B8C 8008538C 0800488C */  lw         $t0, 0x8($v0)
    /* 75B90 80085390 0C00498C */  lw         $t1, 0xC($v0)
    /* 75B94 80085394 10004A8C */  lw         $t2, 0x10($v0)
    /* 75B98 80085398 0000E8AC */  sw         $t0, 0x0($a3)
    /* 75B9C 8008539C 0400E9AC */  sw         $t1, 0x4($a3)
    /* 75BA0 800853A0 0800EAAC */  sw         $t2, 0x8($a3)
    /* 75BA4 800853A4 0C00E524 */  addiu      $a1, $a3, 0xC
    /* 75BA8 800853A8 30004324 */  addiu      $v1, $v0, 0x30
    /* 75BAC 800853AC 50004224 */  addiu      $v0, $v0, 0x50
  .L800853B0:
    /* 75BB0 800853B0 0000688C */  lw         $t0, 0x0($v1)
    /* 75BB4 800853B4 0400698C */  lw         $t1, 0x4($v1)
    /* 75BB8 800853B8 08006A8C */  lw         $t2, 0x8($v1)
    /* 75BBC 800853BC 0C006B8C */  lw         $t3, 0xC($v1)
    /* 75BC0 800853C0 0000A8AC */  sw         $t0, 0x0($a1)
    /* 75BC4 800853C4 0400A9AC */  sw         $t1, 0x4($a1)
    /* 75BC8 800853C8 0800AAAC */  sw         $t2, 0x8($a1)
    /* 75BCC 800853CC 0C00ABAC */  sw         $t3, 0xC($a1)
    /* 75BD0 800853D0 10006324 */  addiu      $v1, $v1, 0x10
    /* 75BD4 800853D4 F6FF6214 */  bne        $v1, $v0, .L800853B0
    /* 75BD8 800853D8 1000A524 */   addiu     $a1, $a1, 0x10
    /* 75BDC 800853DC 0000688C */  lw         $t0, 0x0($v1)
    /* 75BE0 800853E0 37150208 */  j          .L800854DC
    /* 75BE4 800853E4 0000A8AC */   sw        $t0, 0x0($a1)
  .L800853E8:
    /* 75BE8 800853E8 1180023C */  lui        $v0, %hi(Camera_gInfo)
    /* 75BEC 800853EC ACF24424 */  addiu      $a0, $v0, %lo(Camera_gInfo)
    /* 75BF0 800853F0 00111000 */  sll        $v0, $s0, 4
    /* 75BF4 800853F4 21105000 */  addu       $v0, $v0, $s0
    /* 75BF8 800853F8 00310200 */  sll        $a2, $v0, 4
    /* 75BFC 800853FC 2118C400 */  addu       $v1, $a2, $a0
    /* 75C00 80085400 7400658C */  lw         $a1, 0x74($v1)
    /* 75C04 80085404 00000000 */  nop
    /* 75C08 80085408 42110500 */  srl        $v0, $a1, 5
    /* 75C0C 8008540C 01004230 */  andi       $v0, $v0, 0x1
    /* 75C10 80085410 17004010 */  beqz       $v0, .L80085470
    /* 75C14 80085414 30006224 */   addiu     $v0, $v1, 0x30
    /* 75C18 80085418 0800688C */  lw         $t0, 0x8($v1)
    /* 75C1C 8008541C 0C00698C */  lw         $t1, 0xC($v1)
    /* 75C20 80085420 10006A8C */  lw         $t2, 0x10($v1)
    /* 75C24 80085424 0000E8AC */  sw         $t0, 0x0($a3)
    /* 75C28 80085428 0400E9AC */  sw         $t1, 0x4($a3)
    /* 75C2C 8008542C 0800EAAC */  sw         $t2, 0x8($a3)
    /* 75C30 80085430 0C00E524 */  addiu      $a1, $a3, 0xC
    /* 75C34 80085434 50006324 */  addiu      $v1, $v1, 0x50
  .L80085438:
    /* 75C38 80085438 0000488C */  lw         $t0, 0x0($v0)
    /* 75C3C 8008543C 0400498C */  lw         $t1, 0x4($v0)
    /* 75C40 80085440 08004A8C */  lw         $t2, 0x8($v0)
    /* 75C44 80085444 0C004B8C */  lw         $t3, 0xC($v0)
    /* 75C48 80085448 0000A8AC */  sw         $t0, 0x0($a1)
    /* 75C4C 8008544C 0400A9AC */  sw         $t1, 0x4($a1)
    /* 75C50 80085450 0800AAAC */  sw         $t2, 0x8($a1)
    /* 75C54 80085454 0C00ABAC */  sw         $t3, 0xC($a1)
    /* 75C58 80085458 10004224 */  addiu      $v0, $v0, 0x10
    /* 75C5C 8008545C F6FF4314 */  bne        $v0, $v1, .L80085438
    /* 75C60 80085460 1000A524 */   addiu     $a1, $a1, 0x10
    /* 75C64 80085464 0000488C */  lw         $t0, 0x0($v0)
    /* 75C68 80085468 37150208 */  j          .L800854DC
    /* 75C6C 8008546C 0000A8AC */   sw        $t0, 0x0($a1)
  .L80085470:
    /* 75C70 80085470 C2100500 */  srl        $v0, $a1, 3
    /* 75C74 80085474 01004230 */  andi       $v0, $v0, 0x1
    /* 75C78 80085478 0E004010 */  beqz       $v0, .L800854B4
    /* 75C7C 8008547C 21280000 */   addu      $a1, $zero, $zero
    /* 75C80 80085480 21200002 */  addu       $a0, $s0, $zero
    /* 75C84 80085484 2130E000 */  addu       $a2, $a3, $zero
    /* 75C88 80085488 2000688C */  lw         $t0, 0x20($v1)
    /* 75C8C 8008548C 2400698C */  lw         $t1, 0x24($v1)
    /* 75C90 80085490 28006A8C */  lw         $t2, 0x28($v1)
    /* 75C94 80085494 0000E8AC */  sw         $t0, 0x0($a3)
    /* 75C98 80085498 0400E9AC */  sw         $t1, 0x4($a3)
    /* 75C9C 8008549C 0800EAAC */  sw         $t2, 0x8($a3)
    /* 75CA0 800854A0 0C00C724 */  addiu      $a3, $a2, 0xC
    /* 75CA4 800854A4 2612020C */  jal        Camera_AcquireTarget__FiP8coorddefT1P10matrixtdefi
    /* 75CA8 800854A8 1000A0AF */   sw        $zero, 0x10($sp)
    /* 75CAC 800854AC 38150208 */  j          .L800854E0
    /* 75CB0 800854B0 1180023C */   lui       $v0, %hi(Camera_gInfo)
  .L800854B4:
    /* 75CB4 800854B4 2000688C */  lw         $t0, 0x20($v1)
    /* 75CB8 800854B8 2400698C */  lw         $t1, 0x24($v1)
    /* 75CBC 800854BC 28006A8C */  lw         $t2, 0x28($v1)
    /* 75CC0 800854C0 0000E8AC */  sw         $t0, 0x0($a3)
    /* 75CC4 800854C4 0400E9AC */  sw         $t1, 0x4($a3)
    /* 75CC8 800854C8 0800EAAC */  sw         $t2, 0x8($a3)
    /* 75CCC 800854CC 30008424 */  addiu      $a0, $a0, 0x30
    /* 75CD0 800854D0 2120C400 */  addu       $a0, $a2, $a0
    /* 75CD4 800854D4 CF01020C */  jal        Camera_LookBack__FP10matrixtdefT0
    /* 75CD8 800854D8 0C00E524 */   addiu     $a1, $a3, 0xC
  .L800854DC:
    /* 75CDC 800854DC 1180023C */  lui        $v0, %hi(Camera_gInfo)
  .L800854E0:
    /* 75CE0 800854E0 ACF24224 */  addiu      $v0, $v0, %lo(Camera_gInfo)
    /* 75CE4 800854E4 00191000 */  sll        $v1, $s0, 4
    /* 75CE8 800854E8 21187000 */  addu       $v1, $v1, $s0
    /* 75CEC 800854EC 00190300 */  sll        $v1, $v1, 4
    /* 75CF0 800854F0 21186200 */  addu       $v1, $v1, $v0
    /* 75CF4 800854F4 70006384 */  lh         $v1, 0x70($v1)
    /* 75CF8 800854F8 00000000 */  nop
    /* 75CFC 800854FC 1300622C */  sltiu      $v0, $v1, 0x13
    /* 75D00 80085500 0A004010 */  beqz       $v0, .L8008552C
    /* 75D04 80085504 0580023C */   lui       $v0, %hi(jtbl_80055930)
    /* 75D08 80085508 30594224 */  addiu      $v0, $v0, %lo(jtbl_80055930)
    /* 75D0C 8008550C 80180300 */  sll        $v1, $v1, 2
    /* 75D10 80085510 21186200 */  addu       $v1, $v1, $v0
    /* 75D14 80085514 0000628C */  lw         $v0, 0x0($v1)
    /* 75D18 80085518 00000000 */  nop
    /* 75D1C 8008551C 08004000 */  jr         $v0
    /* 75D20 80085520 00000000 */   nop
  jlabel .L80085524
    /* 75D24 80085524 55150208 */  j          .L80085554
    /* 75D28 80085528 000020AE */   sw        $zero, 0x0($s1)
  jlabel .L8008552C
    /* 75D2C 8008552C 1180023C */  lui        $v0, %hi(Camera_gInfo)
    /* 75D30 80085530 ACF24224 */  addiu      $v0, $v0, %lo(Camera_gInfo)
    /* 75D34 80085534 00191000 */  sll        $v1, $s0, 4
    /* 75D38 80085538 21187000 */  addu       $v1, $v1, $s0
    /* 75D3C 8008553C 00190300 */  sll        $v1, $v1, 4
    /* 75D40 80085540 21186200 */  addu       $v1, $v1, $v0
    /* 75D44 80085544 0000628C */  lw         $v0, 0x0($v1)
    /* 75D48 80085548 00000000 */  nop
    /* 75D4C 8008554C AC004224 */  addiu      $v0, $v0, 0xAC
    /* 75D50 80085550 000022AE */  sw         $v0, 0x0($s1)
  .L80085554:
    /* 75D54 80085554 2000BF8F */  lw         $ra, 0x20($sp)
    /* 75D58 80085558 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 75D5C 8008555C 1800B08F */  lw         $s0, 0x18($sp)
    /* 75D60 80085560 0800E003 */  jr         $ra
    /* 75D64 80085564 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Camera_GetAudioViewInfo__FiP17DRender_tCalcViewPP8coorddef
