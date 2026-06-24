.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CD_cw, 0x40C

glabel CD_cw
    /* F8324 80107B24 1480023C */  lui        $v0, %hi(CD_debug)
    /* F8328 80107B28 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* F832C 80107B2C C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* F8330 80107B30 1800B0AF */  sw         $s0, 0x18($sp)
    /* F8334 80107B34 2180A000 */  addu       $s0, $a1, $zero
    /* F8338 80107B38 3000B6AF */  sw         $s6, 0x30($sp)
    /* F833C 80107B3C 21B0C000 */  addu       $s6, $a2, $zero
    /* F8340 80107B40 2000B2AF */  sw         $s2, 0x20($sp)
    /* F8344 80107B44 2190E000 */  addu       $s2, $a3, $zero
    /* F8348 80107B48 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* F834C 80107B4C 21888000 */  addu       $s1, $a0, $zero
    /* F8350 80107B50 3400BFAF */  sw         $ra, 0x34($sp)
    /* F8354 80107B54 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* F8358 80107B58 2800B4AF */  sw         $s4, 0x28($sp)
    /* F835C 80107B5C 02004228 */  slti       $v0, $v0, 0x2
    /* F8360 80107B60 09004014 */  bnez       $v0, .L80107B88
    /* F8364 80107B64 2400B3AF */   sw        $s3, 0x24($sp)
    /* F8368 80107B68 FF002232 */  andi       $v0, $s1, 0xFF
    /* F836C 80107B6C 80100200 */  sll        $v0, $v0, 2
    /* F8370 80107B70 1480053C */  lui        $a1, %hi(CD_comstr)
    /* F8374 80107B74 2128A200 */  addu       $a1, $a1, $v0
    /* F8378 80107B78 6CBFA58C */  lw         $a1, %lo(CD_comstr)($a1)
    /* F837C 80107B7C 0580043C */  lui        $a0, %hi(D_80057810)
    /* F8380 80107B80 2B0A040C */  jal        printf
    /* F8384 80107B84 10788424 */   addiu     $a0, $a0, %lo(D_80057810)
  .L80107B88:
    /* F8388 80107B88 FF002232 */  andi       $v0, $s1, 0xFF
    /* F838C 80107B8C 80180200 */  sll        $v1, $v0, 2
    /* F8390 80107B90 1480023C */  lui        $v0, %hi(D_8013C18C)
    /* F8394 80107B94 21104300 */  addu       $v0, $v0, $v1
    /* F8398 80107B98 8CC1428C */  lw         $v0, %lo(D_8013C18C)($v0)
    /* F839C 80107B9C 00000000 */  nop
    /* F83A0 80107BA0 10004010 */  beqz       $v0, .L80107BE4
    /* F83A4 80107BA4 21200000 */   addu      $a0, $zero, $zero
    /* F83A8 80107BA8 0E000016 */  bnez       $s0, .L80107BE4
    /* F83AC 80107BAC 00000000 */   nop
    /* F83B0 80107BB0 1480023C */  lui        $v0, %hi(CD_debug)
    /* F83B4 80107BB4 50BF428C */  lw         $v0, %lo(CD_debug)($v0)
    /* F83B8 80107BB8 00000000 */  nop
    /* F83BC 80107BBC D2004018 */  blez       $v0, .L80107F08
    /* F83C0 80107BC0 FEFF0224 */   addiu     $v0, $zero, -0x2
    /* F83C4 80107BC4 1480053C */  lui        $a1, %hi(CD_comstr)
    /* F83C8 80107BC8 2128A300 */  addu       $a1, $a1, $v1
    /* F83CC 80107BCC 6CBFA58C */  lw         $a1, %lo(CD_comstr)($a1)
    /* F83D0 80107BD0 0580043C */  lui        $a0, %hi(D_80057818)
    /* F83D4 80107BD4 2B0A040C */  jal        printf
    /* F83D8 80107BD8 18788424 */   addiu     $a0, $a0, %lo(D_80057818)
    /* F83DC 80107BDC C21F0408 */  j          .L80107F08
    /* F83E0 80107BE0 FEFF0224 */   addiu     $v0, $zero, -0x2
  .L80107BE4:
    /* F83E4 80107BE4 771D040C */  jal        CD_sync
    /* F83E8 80107BE8 21280000 */   addu      $a1, $zero, $zero
    /* F83EC 80107BEC FF002332 */  andi       $v1, $s1, 0xFF
    /* F83F0 80107BF0 02000224 */  addiu      $v0, $zero, 0x2
    /* F83F4 80107BF4 0D006214 */  bne        $v1, $v0, .L80107C2C
    /* F83F8 80107BF8 0E000224 */   addiu     $v0, $zero, 0xE
    /* F83FC 80107BFC 21200000 */  addu       $a0, $zero, $zero
    /* F8400 80107C00 21100402 */  addu       $v0, $s0, $a0
  .L80107C04:
    /* F8404 80107C04 00004290 */  lbu        $v0, 0x0($v0)
    /* F8408 80107C08 1480013C */  lui        $at, %hi(CD_pos)
    /* F840C 80107C0C 21082400 */  addu       $at, $at, $a0
    /* F8410 80107C10 60BF22A0 */  sb         $v0, %lo(CD_pos)($at)
    /* F8414 80107C14 01008424 */  addiu      $a0, $a0, 0x1
    /* F8418 80107C18 04008228 */  slti       $v0, $a0, 0x4
    /* F841C 80107C1C F9FF4014 */  bnez       $v0, .L80107C04
    /* F8420 80107C20 21100402 */   addu      $v0, $s0, $a0
    /* F8424 80107C24 FF002332 */  andi       $v1, $s1, 0xFF
    /* F8428 80107C28 0E000224 */  addiu      $v0, $zero, 0xE
  .L80107C2C:
    /* F842C 80107C2C 04006214 */  bne        $v1, $v0, .L80107C40
    /* F8430 80107C30 00000000 */   nop
    /* F8434 80107C34 00000292 */  lbu        $v0, 0x0($s0)
    /* F8438 80107C38 1480013C */  lui        $at, %hi(CD_mode)
    /* F843C 80107C3C 64BF22A0 */  sb         $v0, %lo(CD_mode)($at)
  .L80107C40:
    /* F8440 80107C40 1480053C */  lui        $a1, %hi(D_8013C224)
    /* F8444 80107C44 24C2A524 */  addiu      $a1, $a1, %lo(D_8013C224)
    /* F8448 80107C48 80200300 */  sll        $a0, $v1, 2
    /* F844C 80107C4C 0000A0A0 */  sb         $zero, 0x0($a1)
    /* F8450 80107C50 1480023C */  lui        $v0, %hi(D_8013C08C)
    /* F8454 80107C54 21104400 */  addu       $v0, $v0, $a0
    /* F8458 80107C58 8CC0428C */  lw         $v0, %lo(D_8013C08C)($v0)
    /* F845C 80107C5C 1480033C */  lui        $v1, %hi(D_8013C08C)
    /* F8460 80107C60 02004010 */  beqz       $v0, .L80107C6C
    /* F8464 80107C64 8CC06324 */   addiu     $v1, $v1, %lo(D_8013C08C)
    /* F8468 80107C68 0100A0A0 */  sb         $zero, 0x1($a1)
  .L80107C6C:
    /* F846C 80107C6C 1480023C */  lui        $v0, %hi(D_8013C20C)
    /* F8470 80107C70 0CC2428C */  lw         $v0, %lo(D_8013C20C)($v0)
    /* F8474 80107C74 00000000 */  nop
    /* F8478 80107C78 000040A0 */  sb         $zero, 0x0($v0)
    /* F847C 80107C7C 00016224 */  addiu      $v0, $v1, 0x100
    /* F8480 80107C80 21188200 */  addu       $v1, $a0, $v0
    /* F8484 80107C84 0000628C */  lw         $v0, 0x0($v1)
    /* F8488 80107C88 00000000 */  nop
    /* F848C 80107C8C 0D004018 */  blez       $v0, .L80107CC4
    /* F8490 80107C90 21200000 */   addu      $a0, $zero, $zero
    /* F8494 80107C94 21286000 */  addu       $a1, $v1, $zero
    /* F8498 80107C98 21100402 */  addu       $v0, $s0, $a0
  .L80107C9C:
    /* F849C 80107C9C 1480033C */  lui        $v1, %hi(D_8013C214)
    /* F84A0 80107CA0 14C2638C */  lw         $v1, %lo(D_8013C214)($v1)
    /* F84A4 80107CA4 00004290 */  lbu        $v0, 0x0($v0)
    /* F84A8 80107CA8 00000000 */  nop
    /* F84AC 80107CAC 000062A0 */  sb         $v0, 0x0($v1)
    /* F84B0 80107CB0 0000A28C */  lw         $v0, 0x0($a1)
    /* F84B4 80107CB4 01008424 */  addiu      $a0, $a0, 0x1
    /* F84B8 80107CB8 2A108200 */  slt        $v0, $a0, $v0
    /* F84BC 80107CBC F7FF4014 */  bnez       $v0, .L80107C9C
    /* F84C0 80107CC0 21100402 */   addu      $v0, $s0, $a0
  .L80107CC4:
    /* F84C4 80107CC4 1480023C */  lui        $v0, %hi(D_8013C210)
    /* F84C8 80107CC8 10C2428C */  lw         $v0, %lo(D_8013C210)($v0)
    /* F84CC 80107CCC 1480013C */  lui        $at, %hi(CD_com)
    /* F84D0 80107CD0 65BF31A0 */  sb         $s1, %lo(CD_com)($at)
    /* F84D4 80107CD4 000051A0 */  sb         $s1, 0x0($v0)
    /* F84D8 80107CD8 8B004016 */  bnez       $s2, .L80107F08
    /* F84DC 80107CDC 21100000 */   addu      $v0, $zero, $zero
    /* F84E0 80107CE0 C7C8030C */  jal        VSync
    /* F84E4 80107CE4 FFFF0424 */   addiu     $a0, $zero, -0x1
    /* F84E8 80107CE8 C0034224 */  addiu      $v0, $v0, 0x3C0
    /* F84EC 80107CEC 1480043C */  lui        $a0, %hi(D_8013C224)
    /* F84F0 80107CF0 24C28424 */  addiu      $a0, $a0, %lo(D_8013C224)
    /* F84F4 80107CF4 1580013C */  lui        $at, %hi(D_801489B4)
    /* F84F8 80107CF8 B48922AC */  sw         $v0, %lo(D_801489B4)($at)
    /* F84FC 80107CFC 1580013C */  lui        $at, %hi(D_801489B8)
    /* F8500 80107D00 B88920AC */  sw         $zero, %lo(D_801489B8)($at)
    /* F8504 80107D04 00008390 */  lbu        $v1, 0x0($a0)
    /* F8508 80107D08 0580023C */  lui        $v0, %hi(D_80057828)
    /* F850C 80107D0C 28784224 */  addiu      $v0, $v0, %lo(D_80057828)
    /* F8510 80107D10 1580013C */  lui        $at, %hi(D_801489BC)
    /* F8514 80107D14 BC8922AC */  sw         $v0, %lo(D_801489BC)($at)
    /* F8518 80107D18 67006014 */  bnez       $v1, .L80107EB8
    /* F851C 80107D1C 2130C002 */   addu      $a2, $s6, $zero
    /* F8520 80107D20 1480153C */  lui        $s5, %hi(CD_comstr)
    /* F8524 80107D24 6CBFB526 */  addiu      $s5, $s5, %lo(CD_comstr)
    /* F8528 80107D28 1480133C */  lui        $s3, %hi(CD_intstr)
    /* F852C 80107D2C ECBF7326 */  addiu      $s3, $s3, %lo(CD_intstr)
    /* F8530 80107D30 21908000 */  addu       $s2, $a0, $zero
    /* F8534 80107D34 01005426 */  addiu      $s4, $s2, 0x1
  .L80107D38:
    /* F8538 80107D38 C7C8030C */  jal        VSync
    /* F853C 80107D3C FFFF0424 */   addiu     $a0, $zero, -0x1
    /* F8540 80107D40 1580033C */  lui        $v1, %hi(D_801489B4)
    /* F8544 80107D44 B489638C */  lw         $v1, %lo(D_801489B4)($v1)
    /* F8548 80107D48 00000000 */  nop
    /* F854C 80107D4C 2A186200 */  slt        $v1, $v1, $v0
    /* F8550 80107D50 0C006014 */  bnez       $v1, .L80107D84
    /* F8554 80107D54 00000000 */   nop
    /* F8558 80107D58 1580023C */  lui        $v0, %hi(D_801489B8)
    /* F855C 80107D5C B889428C */  lw         $v0, %lo(D_801489B8)($v0)
    /* F8560 80107D60 00000000 */  nop
    /* F8564 80107D64 21184000 */  addu       $v1, $v0, $zero
    /* F8568 80107D68 01004224 */  addiu      $v0, $v0, 0x1
    /* F856C 80107D6C 1580013C */  lui        $at, %hi(D_801489B8)
    /* F8570 80107D70 B88922AC */  sw         $v0, %lo(D_801489B8)($at)
    /* F8574 80107D74 3C00023C */  lui        $v0, (0x3C0000 >> 16)
    /* F8578 80107D78 2A104300 */  slt        $v0, $v0, $v1
    /* F857C 80107D7C 1B004010 */  beqz       $v0, .L80107DEC
    /* F8580 80107D80 00000000 */   nop
  .L80107D84:
    /* F8584 80107D84 0580043C */  lui        $a0, %hi(D_80057774)
    /* F8588 80107D88 33A0030C */  jal        puts
    /* F858C 80107D8C 74778424 */   addiu     $a0, $a0, %lo(D_80057774)
    /* F8590 80107D90 00004492 */  lbu        $a0, 0x0($s2)
    /* F8594 80107D94 01004292 */  lbu        $v0, 0x1($s2)
    /* F8598 80107D98 1580053C */  lui        $a1, %hi(D_801489BC)
    /* F859C 80107D9C BC89A58C */  lw         $a1, %lo(D_801489BC)($a1)
    /* F85A0 80107DA0 80100200 */  sll        $v0, $v0, 2
    /* F85A4 80107DA4 21105300 */  addu       $v0, $v0, $s3
    /* F85A8 80107DA8 80200400 */  sll        $a0, $a0, 2
    /* F85AC 80107DAC 0000438C */  lw         $v1, 0x0($v0)
    /* F85B0 80107DB0 1480023C */  lui        $v0, %hi(CD_com)
    /* F85B4 80107DB4 65BF4290 */  lbu        $v0, %lo(CD_com)($v0)
    /* F85B8 80107DB8 21209300 */  addu       $a0, $a0, $s3
    /* F85BC 80107DBC 80100200 */  sll        $v0, $v0, 2
    /* F85C0 80107DC0 21105500 */  addu       $v0, $v0, $s5
    /* F85C4 80107DC4 1000A3AF */  sw         $v1, 0x10($sp)
    /* F85C8 80107DC8 0000468C */  lw         $a2, 0x0($v0)
    /* F85CC 80107DCC 0000878C */  lw         $a3, 0x0($a0)
    /* F85D0 80107DD0 0580043C */  lui        $a0, %hi(D_80057784)
    /* F85D4 80107DD4 2B0A040C */  jal        printf
    /* F85D8 80107DD8 84778424 */   addiu     $a0, $a0, %lo(D_80057784)
    /* F85DC 80107DDC CC1F040C */  jal        CD_flush
    /* F85E0 80107DE0 00000000 */   nop
    /* F85E4 80107DE4 7C1F0408 */  j          .L80107DF0
    /* F85E8 80107DE8 FFFF0224 */   addiu     $v0, $zero, -0x1
  .L80107DEC:
    /* F85EC 80107DEC 21100000 */  addu       $v0, $zero, $zero
  .L80107DF0:
    /* F85F0 80107DF0 45004014 */  bnez       $v0, .L80107F08
    /* F85F4 80107DF4 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* F85F8 80107DF8 50CA030C */  jal        CheckCallback
    /* F85FC 80107DFC 00000000 */   nop
    /* F8600 80107E00 29004010 */  beqz       $v0, .L80107EA8
    /* F8604 80107E04 00000000 */   nop
    /* F8608 80107E08 1480023C */  lui        $v0, %hi(D_8013C20C)
    /* F860C 80107E0C 0CC2428C */  lw         $v0, %lo(D_8013C20C)($v0)
    /* F8610 80107E10 00000000 */  nop
    /* F8614 80107E14 00004290 */  lbu        $v0, 0x0($v0)
    /* F8618 80107E18 00000000 */  nop
    /* F861C 80107E1C 03005130 */  andi       $s1, $v0, 0x3
  .L80107E20:
    /* F8620 80107E20 201C040C */  jal        CD_get_intr
    /* F8624 80107E24 00000000 */   nop
    /* F8628 80107E28 21804000 */  addu       $s0, $v0, $zero
    /* F862C 80107E2C 1A000012 */  beqz       $s0, .L80107E98
    /* F8630 80107E30 04000232 */   andi      $v0, $s0, 0x4
    /* F8634 80107E34 0B004010 */  beqz       $v0, .L80107E64
    /* F8638 80107E38 02000232 */   andi      $v0, $s0, 0x2
    /* F863C 80107E3C 1480023C */  lui        $v0, %hi(CD_cbready)
    /* F8640 80107E40 4CBF428C */  lw         $v0, %lo(CD_cbready)($v0)
    /* F8644 80107E44 00000000 */  nop
    /* F8648 80107E48 05004010 */  beqz       $v0, .L80107E60
    /* F864C 80107E4C 00000000 */   nop
    /* F8650 80107E50 00008492 */  lbu        $a0, 0x0($s4)
    /* F8654 80107E54 1580053C */  lui        $a1, %hi(D_801489A4)
    /* F8658 80107E58 09F84000 */  jalr       $v0
    /* F865C 80107E5C A489A524 */   addiu     $a1, $a1, %lo(D_801489A4)
  .L80107E60:
    /* F8660 80107E60 02000232 */  andi       $v0, $s0, 0x2
  .L80107E64:
    /* F8664 80107E64 EEFF4010 */  beqz       $v0, .L80107E20
    /* F8668 80107E68 00000000 */   nop
    /* F866C 80107E6C 1480023C */  lui        $v0, %hi(CD_cbsync)
    /* F8670 80107E70 48BF428C */  lw         $v0, %lo(CD_cbsync)($v0)
    /* F8674 80107E74 00000000 */  nop
    /* F8678 80107E78 E9FF4010 */  beqz       $v0, .L80107E20
    /* F867C 80107E7C 00000000 */   nop
    /* F8680 80107E80 00004492 */  lbu        $a0, 0x0($s2)
    /* F8684 80107E84 1580053C */  lui        $a1, %hi(D_8014899C)
    /* F8688 80107E88 09F84000 */  jalr       $v0
    /* F868C 80107E8C 9C89A524 */   addiu     $a1, $a1, %lo(D_8014899C)
    /* F8690 80107E90 881F0408 */  j          .L80107E20
    /* F8694 80107E94 00000000 */   nop
  .L80107E98:
    /* F8698 80107E98 1480023C */  lui        $v0, %hi(D_8013C20C)
    /* F869C 80107E9C 0CC2428C */  lw         $v0, %lo(D_8013C20C)($v0)
    /* F86A0 80107EA0 00000000 */  nop
    /* F86A4 80107EA4 000051A0 */  sb         $s1, 0x0($v0)
  .L80107EA8:
    /* F86A8 80107EA8 00004292 */  lbu        $v0, 0x0($s2)
    /* F86AC 80107EAC 00000000 */  nop
    /* F86B0 80107EB0 A1FF4010 */  beqz       $v0, .L80107D38
    /* F86B4 80107EB4 2130C002 */   addu      $a2, $s6, $zero
  .L80107EB8:
    /* F86B8 80107EB8 1580043C */  lui        $a0, %hi(D_8014899C)
    /* F86BC 80107EBC 9C898424 */  addiu      $a0, $a0, %lo(D_8014899C)
    /* F86C0 80107EC0 0800C010 */  beqz       $a2, .L80107EE4
    /* F86C4 80107EC4 07000324 */   addiu     $v1, $zero, 0x7
    /* F86C8 80107EC8 FFFF0524 */  addiu      $a1, $zero, -0x1
  .L80107ECC:
    /* F86CC 80107ECC 00008290 */  lbu        $v0, 0x0($a0)
    /* F86D0 80107ED0 01008424 */  addiu      $a0, $a0, 0x1
    /* F86D4 80107ED4 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* F86D8 80107ED8 0000C2A0 */  sb         $v0, 0x0($a2)
    /* F86DC 80107EDC FBFF6514 */  bne        $v1, $a1, .L80107ECC
    /* F86E0 80107EE0 0100C624 */   addiu     $a2, $a2, 0x1
  .L80107EE4:
    /* F86E4 80107EE4 21200000 */  addu       $a0, $zero, $zero
    /* F86E8 80107EE8 1480023C */  lui        $v0, %hi(D_8013C224)
    /* F86EC 80107EEC 24C24224 */  addiu      $v0, $v0, %lo(D_8013C224)
    /* F86F0 80107EF0 00004390 */  lbu        $v1, 0x0($v0)
    /* F86F4 80107EF4 05000224 */  addiu      $v0, $zero, 0x5
    /* F86F8 80107EF8 03006214 */  bne        $v1, $v0, .L80107F08
    /* F86FC 80107EFC 21108000 */   addu      $v0, $a0, $zero
    /* F8700 80107F00 FFFF0424 */  addiu      $a0, $zero, -0x1
    /* F8704 80107F04 21108000 */  addu       $v0, $a0, $zero
  .L80107F08:
    /* F8708 80107F08 3400BF8F */  lw         $ra, 0x34($sp)
    /* F870C 80107F0C 3000B68F */  lw         $s6, 0x30($sp)
    /* F8710 80107F10 2C00B58F */  lw         $s5, 0x2C($sp)
    /* F8714 80107F14 2800B48F */  lw         $s4, 0x28($sp)
    /* F8718 80107F18 2400B38F */  lw         $s3, 0x24($sp)
    /* F871C 80107F1C 2000B28F */  lw         $s2, 0x20($sp)
    /* F8720 80107F20 1C00B18F */  lw         $s1, 0x1C($sp)
    /* F8724 80107F24 1800B08F */  lw         $s0, 0x18($sp)
    /* F8728 80107F28 0800E003 */  jr         $ra
    /* F872C 80107F2C 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel CD_cw
