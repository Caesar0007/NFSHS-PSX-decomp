.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

/* Handwritten function */
nonmatching DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi, 0x320

glabel DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi
    /* B839C 800C7B9C 80FFBD27 */  addiu      $sp, $sp, -0x80
    /* B83A0 800C7BA0 6800B4AF */  sw         $s4, 0x68($sp)
    /* B83A4 800C7BA4 0400F424 */  addiu      $s4, $a3, 0x4
    /* B83A8 800C7BA8 7C00BFAF */  sw         $ra, 0x7C($sp)
    /* B83AC 800C7BAC 7800BEAF */  sw         $fp, 0x78($sp)
    /* B83B0 800C7BB0 7400B7AF */  sw         $s7, 0x74($sp)
    /* B83B4 800C7BB4 7000B6AF */  sw         $s6, 0x70($sp)
    /* B83B8 800C7BB8 6C00B5AF */  sw         $s5, 0x6C($sp)
    /* B83BC 800C7BBC 6400B3AF */  sw         $s3, 0x64($sp)
    /* B83C0 800C7BC0 6000B2AF */  sw         $s2, 0x60($sp)
    /* B83C4 800C7BC4 5C00B1AF */  sw         $s1, 0x5C($sp)
    /* B83C8 800C7BC8 5800B0AF */  sw         $s0, 0x58($sp)
    /* B83CC 800C7BCC 8000A4AF */  sw         $a0, 0x80($sp)
    /* B83D0 800C7BD0 8400A5AF */  sw         $a1, 0x84($sp)
    /* B83D4 800C7BD4 8800A6AF */  sw         $a2, 0x88($sp)
    /* B83D8 800C7BD8 5000A0AF */  sw         $zero, 0x50($sp)
    /* B83DC 800C7BDC 0000E78C */  lw         $a3, 0x0($a3)
    /* B83E0 800C7BE0 00000000 */  nop
    /* B83E4 800C7BE4 0300E014 */  bnez       $a3, .L800C7BF4
    /* B83E8 800C7BE8 5400A7AF */   sw        $a3, 0x54($sp)
    /* B83EC 800C7BEC A31F0308 */  j          .L800C7E8C
    /* B83F0 800C7BF0 21100000 */   addu      $v0, $zero, $zero
  .L800C7BF4:
    /* B83F4 800C7BF4 8400A88F */  lw         $t0, 0x84($sp)
    /* B83F8 800C7BF8 00000000 */  nop
    /* B83FC 800C7BFC 14000225 */  addiu      $v0, $t0, 0x14
    /* B8400 800C7C00 1C0040AC */  sw         $zero, 0x1C($v0)
    /* B8404 800C7C04 180040AC */  sw         $zero, 0x18($v0)
    /* B8408 800C7C08 280000AD */  sw         $zero, 0x28($t0)
    /* B840C 800C7C0C 14004C8C */  lw         $t4, 0x14($v0)
    /* B8410 800C7C10 18004D8C */  lw         $t5, 0x18($v0)
    /* B8414 800C7C14 0028CC48 */  ctc2       $t4, $5 /* handwritten instruction */
    /* B8418 800C7C18 1C004E8C */  lw         $t6, 0x1C($v0)
    /* B841C 800C7C1C 0030CD48 */  ctc2       $t5, $6 /* handwritten instruction */
    /* B8420 800C7C20 0038CE48 */  ctc2       $t6, $7 /* handwritten instruction */
    /* B8424 800C7C24 21B80000 */  addu       $s7, $zero, $zero
  .L800C7C28:
    /* B8428 800C7C28 5400A98F */  lw         $t1, 0x54($sp)
    /* B842C 800C7C2C 00000000 */  nop
    /* B8430 800C7C30 2A10E902 */  slt        $v0, $s7, $t1
    /* B8434 800C7C34 94004010 */  beqz       $v0, .L800C7E88
    /* B8438 800C7C38 00000000 */   nop
    /* B843C 800C7C3C 1480033C */  lui        $v1, %hi(D_8013D828)
    /* B8440 800C7C40 28D86324 */  addiu      $v1, $v1, %lo(D_8013D828)
    /* B8444 800C7C44 04008292 */  lbu        $v0, 0x4($s4)
    /* B8448 800C7C48 02008492 */  lbu        $a0, 0x2($s4)
    /* B844C 800C7C4C 21104300 */  addu       $v0, $v0, $v1
    /* B8450 800C7C50 05000324 */  addiu      $v1, $zero, 0x5
    /* B8454 800C7C54 00005680 */  lb         $s6, 0x0($v0)
    /* B8458 800C7C58 03008310 */  beq        $a0, $v1, .L800C7C68
    /* B845C 800C7C5C 02000A24 */   addiu     $t2, $zero, 0x2
    /* B8460 800C7C60 84008A14 */  bne        $a0, $t2, .L800C7E74
    /* B8464 800C7C64 00000000 */   nop
  .L800C7C68:
    /* B8468 800C7C68 02000B24 */  addiu      $t3, $zero, 0x2
    /* B846C 800C7C6C 06008286 */  lh         $v0, 0x6($s4)
    /* B8470 800C7C70 1480033C */  lui        $v1, %hi(Track_gObjDefs)
    /* B8474 800C7C74 D4D4638C */  lw         $v1, %lo(Track_gObjDefs)($v1)
    /* B8478 800C7C78 80100200 */  sll        $v0, $v0, 2
    /* B847C 800C7C7C 21104300 */  addu       $v0, $v0, $v1
    /* B8480 800C7C80 00005E8C */  lw         $fp, 0x0($v0)
    /* B8484 800C7C84 0A008B10 */  beq        $a0, $t3, .L800C7CB0
    /* B8488 800C7C88 21908002 */   addu      $s2, $s4, $zero
    /* B848C 800C7C8C 22008292 */  lbu        $v0, 0x22($s4)
    /* B8490 800C7C90 8800A88F */  lw         $t0, 0x88($sp)
    /* B8494 800C7C94 04206201 */  sllv       $a0, $v0, $t3
    /* B8498 800C7C98 21208200 */  addu       $a0, $a0, $v0
    /* B849C 800C7C9C 04206401 */  sllv       $a0, $a0, $t3
    /* B84A0 800C7CA0 B194020C */  jal        Object_GetAnim__FP13Trk_SimObject
    /* B84A4 800C7CA4 21200401 */   addu      $a0, $t0, $a0
    /* B84A8 800C7CA8 62004014 */  bnez       $v0, .L800C7E34
    /* B84AC 800C7CAC 00000000 */   nop
  .L800C7CB0:
    /* B84B0 800C7CB0 08009026 */  addiu      $s0, $s4, 0x8
    /* B84B4 800C7CB4 8000A98F */  lw         $t1, 0x80($sp)
    /* B84B8 800C7CB8 21200002 */  addu       $a0, $s0, $zero
    /* B84BC 800C7CBC 71F5010C */  jal        xzsquaredist32__FP8coorddefT0
    /* B84C0 800C7CC0 08002525 */   addiu     $a1, $t1, 0x8
    /* B84C4 800C7CC4 9000AA8F */  lw         $t2, 0x90($sp)
    /* B84C8 800C7CC8 00000000 */  nop
    /* B84CC 800C7CCC 2A104A00 */  slt        $v0, $v0, $t2
    /* B84D0 800C7CD0 0C004010 */  beqz       $v0, .L800C7D04
    /* B84D4 800C7CD4 21880000 */   addu      $s1, $zero, $zero
    /* B84D8 800C7CD8 02008292 */  lbu        $v0, 0x2($s4)
    /* B84DC 800C7CDC 02000B24 */  addiu      $t3, $zero, 0x2
    /* B84E0 800C7CE0 09004B14 */  bne        $v0, $t3, .L800C7D08
    /* B84E4 800C7CE4 00000000 */   nop
    /* B84E8 800C7CE8 8000A48F */  lw         $a0, 0x80($sp)
    /* B84EC 800C7CEC 06008586 */  lh         $a1, 0x6($s4)
    /* B84F0 800C7CF0 8400A78F */  lw         $a3, 0x84($sp)
    /* B84F4 800C7CF4 F422030C */  jal        ObjectClipped__FP13DRender_tViewiP8coorddefP25Draw_tGiveShelbyMoreCache
    /* B84F8 800C7CF8 21300002 */   addu      $a2, $s0, $zero
    /* B84FC 800C7CFC 02004010 */  beqz       $v0, .L800C7D08
    /* B8500 800C7D00 00000000 */   nop
  .L800C7D04:
    /* B8504 800C7D04 01001124 */  addiu      $s1, $zero, 0x1
  .L800C7D08:
    /* B8508 800C7D08 5A002016 */  bnez       $s1, .L800C7E74
    /* B850C 800C7D0C 4800A427 */   addiu     $a0, $sp, 0x48
    /* B8510 800C7D10 1700488A */  lwl        $t0, 0x17($s2)
    /* B8514 800C7D14 1400489A */  lwr        $t0, 0x14($s2)
    /* B8518 800C7D18 1B00498A */  lwl        $t1, 0x1B($s2)
    /* B851C 800C7D1C 1800499A */  lwr        $t1, 0x18($s2)
    /* B8520 800C7D20 4B00A8AB */  swl        $t0, 0x4B($sp)
    /* B8524 800C7D24 4800A8BB */  swr        $t0, 0x48($sp)
    /* B8528 800C7D28 4F00A9AB */  swl        $t1, 0x4F($sp)
    /* B852C 800C7D2C 4C00A9BB */  swr        $t1, 0x4C($sp)
    /* B8530 800C7D30 E0B5020C */  jal        Quatern_QuatToMat__FP5tQuatP10matrixtdef
    /* B8534 800C7D34 2000A527 */   addiu     $a1, $sp, 0x20
    /* B8538 800C7D38 1C005086 */  lh         $s0, 0x1C($s2)
    /* B853C 800C7D3C 2000A48F */  lw         $a0, 0x20($sp)
    /* B8540 800C7D40 1E005186 */  lh         $s1, 0x1E($s2)
    /* B8544 800C7D44 20005286 */  lh         $s2, 0x20($s2)
    /* B8548 800C7D48 00821000 */  sll        $s0, $s0, 8
    /* B854C 800C7D4C 21280002 */  addu       $a1, $s0, $zero
    /* B8550 800C7D50 008A1100 */  sll        $s1, $s1, 8
    /* B8554 800C7D54 CA90030C */  jal        fixedmult
    /* B8558 800C7D58 00921200 */   sll       $s2, $s2, 8
    /* B855C 800C7D5C 21A84000 */  addu       $s5, $v0, $zero
    /* B8560 800C7D60 2C00A48F */  lw         $a0, 0x2C($sp)
    /* B8564 800C7D64 CA90030C */  jal        fixedmult
    /* B8568 800C7D68 21280002 */   addu      $a1, $s0, $zero
    /* B856C 800C7D6C 21984000 */  addu       $s3, $v0, $zero
    /* B8570 800C7D70 3800A48F */  lw         $a0, 0x38($sp)
    /* B8574 800C7D74 CA90030C */  jal        fixedmult
    /* B8578 800C7D78 21280002 */   addu      $a1, $s0, $zero
    /* B857C 800C7D7C 2400A48F */  lw         $a0, 0x24($sp)
    /* B8580 800C7D80 21282002 */  addu       $a1, $s1, $zero
    /* B8584 800C7D84 2000B5AF */  sw         $s5, 0x20($sp)
    /* B8588 800C7D88 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* B858C 800C7D8C CA90030C */  jal        fixedmult
    /* B8590 800C7D90 3800A2AF */   sw        $v0, 0x38($sp)
    /* B8594 800C7D94 21A84000 */  addu       $s5, $v0, $zero
    /* B8598 800C7D98 3000A48F */  lw         $a0, 0x30($sp)
    /* B859C 800C7D9C CA90030C */  jal        fixedmult
    /* B85A0 800C7DA0 21282002 */   addu      $a1, $s1, $zero
    /* B85A4 800C7DA4 21984000 */  addu       $s3, $v0, $zero
    /* B85A8 800C7DA8 3C00A48F */  lw         $a0, 0x3C($sp)
    /* B85AC 800C7DAC CA90030C */  jal        fixedmult
    /* B85B0 800C7DB0 21282002 */   addu      $a1, $s1, $zero
    /* B85B4 800C7DB4 2800A48F */  lw         $a0, 0x28($sp)
    /* B85B8 800C7DB8 21284002 */  addu       $a1, $s2, $zero
    /* B85BC 800C7DBC 2400B5AF */  sw         $s5, 0x24($sp)
    /* B85C0 800C7DC0 3000B3AF */  sw         $s3, 0x30($sp)
    /* B85C4 800C7DC4 CA90030C */  jal        fixedmult
    /* B85C8 800C7DC8 3C00A2AF */   sw        $v0, 0x3C($sp)
    /* B85CC 800C7DCC 21A84000 */  addu       $s5, $v0, $zero
    /* B85D0 800C7DD0 3400A48F */  lw         $a0, 0x34($sp)
    /* B85D4 800C7DD4 CA90030C */  jal        fixedmult
    /* B85D8 800C7DD8 21284002 */   addu      $a1, $s2, $zero
    /* B85DC 800C7DDC 21984000 */  addu       $s3, $v0, $zero
    /* B85E0 800C7DE0 4000A48F */  lw         $a0, 0x40($sp)
    /* B85E4 800C7DE4 CA90030C */  jal        fixedmult
    /* B85E8 800C7DE8 21284002 */   addu      $a1, $s2, $zero
    /* B85EC 800C7DEC 2000A627 */  addiu      $a2, $sp, 0x20
    /* B85F0 800C7DF0 8000A48F */  lw         $a0, 0x80($sp)
    /* B85F4 800C7DF4 8400A58F */  lw         $a1, 0x84($sp)
    /* B85F8 800C7DF8 2138C003 */  addu       $a3, $fp, $zero
    /* B85FC 800C7DFC 4000A2AF */  sw         $v0, 0x40($sp)
    /* B8600 800C7E00 08008226 */  addiu      $v0, $s4, 0x8
    /* B8604 800C7E04 2800B5AF */  sw         $s5, 0x28($sp)
    /* B8608 800C7E08 3400B3AF */  sw         $s3, 0x34($sp)
    /* B860C 800C7E0C 1000A2AF */  sw         $v0, 0x10($sp)
    /* B8610 800C7E10 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* B8614 800C7E14 1400B6AF */  sw         $s6, 0x14($sp)
    /* B8618 800C7E18 AF1F030C */  jal        DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis
    /* B861C 800C7E1C 1800A2AF */   sw        $v0, 0x18($sp)
    /* B8620 800C7E20 5000A88F */  lw         $t0, 0x50($sp)
    /* B8624 800C7E24 00000000 */  nop
    /* B8628 800C7E28 21400201 */  addu       $t0, $t0, $v0
    /* B862C 800C7E2C 9D1F0308 */  j          .L800C7E74
    /* B8630 800C7E30 5000A8AF */   sw        $t0, 0x50($sp)
  .L800C7E34:
    /* B8634 800C7E34 22008292 */  lbu        $v0, 0x22($s4)
    /* B8638 800C7E38 8800A98F */  lw         $t1, 0x88($sp)
    /* B863C 800C7E3C 80200200 */  sll        $a0, $v0, 2
    /* B8640 800C7E40 21208200 */  addu       $a0, $a0, $v0
    /* B8644 800C7E44 80200400 */  sll        $a0, $a0, 2
    /* B8648 800C7E48 B194020C */  jal        Object_GetAnim__FP13Trk_SimObject
    /* B864C 800C7E4C 21202401 */   addu      $a0, $t1, $a0
    /* B8650 800C7E50 2138C002 */  addu       $a3, $s6, $zero
    /* B8654 800C7E54 8000A58F */  lw         $a1, 0x80($sp)
    /* B8658 800C7E58 0000438C */  lw         $v1, 0x0($v0)
    /* B865C 800C7E5C 8400A68F */  lw         $a2, 0x84($sp)
    /* B8660 800C7E60 10006484 */  lh         $a0, 0x10($v1)
    /* B8664 800C7E64 1400638C */  lw         $v1, 0x14($v1)
    /* B8668 800C7E68 00000000 */  nop
    /* B866C 800C7E6C 09F86000 */  jalr       $v1
    /* B8670 800C7E70 21204400 */   addu      $a0, $v0, $a0
  .L800C7E74:
    /* B8674 800C7E74 00008286 */  lh         $v0, 0x0($s4)
    /* B8678 800C7E78 00000000 */  nop
    /* B867C 800C7E7C 21A08202 */  addu       $s4, $s4, $v0
    /* B8680 800C7E80 0A1F0308 */  j          .L800C7C28
    /* B8684 800C7E84 0100F726 */   addiu     $s7, $s7, 0x1
  .L800C7E88:
    /* B8688 800C7E88 5000A28F */  lw         $v0, 0x50($sp)
  .L800C7E8C:
    /* B868C 800C7E8C 7C00BF8F */  lw         $ra, 0x7C($sp)
    /* B8690 800C7E90 7800BE8F */  lw         $fp, 0x78($sp)
    /* B8694 800C7E94 7400B78F */  lw         $s7, 0x74($sp)
    /* B8698 800C7E98 7000B68F */  lw         $s6, 0x70($sp)
    /* B869C 800C7E9C 6C00B58F */  lw         $s5, 0x6C($sp)
    /* B86A0 800C7EA0 6800B48F */  lw         $s4, 0x68($sp)
    /* B86A4 800C7EA4 6400B38F */  lw         $s3, 0x64($sp)
    /* B86A8 800C7EA8 6000B28F */  lw         $s2, 0x60($sp)
    /* B86AC 800C7EAC 5C00B18F */  lw         $s1, 0x5C($sp)
    /* B86B0 800C7EB0 5800B08F */  lw         $s0, 0x58($sp)
    /* B86B4 800C7EB4 0800E003 */  jr         $ra
    /* B86B8 800C7EB8 8000BD27 */   addiu     $sp, $sp, 0x80
endlabel DrawW_BuildCustomObjectFacets__FP13DRender_tViewP11Draw_DCacheP13Trk_SimObjectP5Groupi
