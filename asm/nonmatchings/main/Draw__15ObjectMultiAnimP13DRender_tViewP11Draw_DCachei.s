.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__15ObjectMultiAnimP13DRender_tViewP11Draw_DCachei, 0x424

glabel Draw__15ObjectMultiAnimP13DRender_tViewP11Draw_DCachei
    /* 96AF8 800A62F8 30FFBD27 */  addiu      $sp, $sp, -0xD0
    /* 96AFC 800A62FC BC00B5AF */  sw         $s5, 0xBC($sp)
    /* 96B00 800A6300 21A88000 */  addu       $s5, $a0, $zero
    /* 96B04 800A6304 C800BEAF */  sw         $fp, 0xC8($sp)
    /* 96B08 800A6308 21F0A000 */  addu       $fp, $a1, $zero
    /* 96B0C 800A630C 21280000 */  addu       $a1, $zero, $zero
    /* 96B10 800A6310 D800A6AF */  sw         $a2, 0xD8($sp)
    /* 96B14 800A6314 4800A627 */  addiu      $a2, $sp, 0x48
    /* 96B18 800A6318 CC00BFAF */  sw         $ra, 0xCC($sp)
    /* 96B1C 800A631C C400B7AF */  sw         $s7, 0xC4($sp)
    /* 96B20 800A6320 C000B6AF */  sw         $s6, 0xC0($sp)
    /* 96B24 800A6324 B800B4AF */  sw         $s4, 0xB8($sp)
    /* 96B28 800A6328 B400B3AF */  sw         $s3, 0xB4($sp)
    /* 96B2C 800A632C B000B2AF */  sw         $s2, 0xB0($sp)
    /* 96B30 800A6330 AC00B1AF */  sw         $s1, 0xAC($sp)
    /* 96B34 800A6334 A800B0AF */  sw         $s0, 0xA8($sp)
    /* 96B38 800A6338 DC00A7AF */  sw         $a3, 0xDC($sp)
    /* 96B3C 800A633C 2800A48E */  lw         $a0, 0x28($s5)
    /* 96B40 800A6340 89D1010C */  jal        GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef
    /* 96B44 800A6344 2000A727 */   addiu     $a3, $sp, 0x20
    /* 96B48 800A6348 01004224 */  addiu      $v0, $v0, 0x1
    /* 96B4C 800A634C 0200422C */  sltiu      $v0, $v0, 0x2
    /* 96B50 800A6350 20004010 */  beqz       $v0, .L800A63D4
    /* 96B54 800A6354 00000000 */   nop
    /* 96B58 800A6358 1000A28E */  lw         $v0, 0x10($s5)
    /* 96B5C 800A635C 2C00B08E */  lw         $s0, 0x2C($s5)
    /* 96B60 800A6360 0E004384 */  lh         $v1, 0xE($v0)
    /* 96B64 800A6364 1180023C */  lui        $v0, %hi(gSimObjAnims)
    /* 96B68 800A6368 605D4224 */  addiu      $v0, $v0, %lo(gSimObjAnims)
    /* 96B6C 800A636C 2C00A0AE */  sw         $zero, 0x2C($s5)
    /* 96B70 800A6370 80180300 */  sll        $v1, $v1, 2
    /* 96B74 800A6374 21886200 */  addu       $s1, $v1, $v0
    /* 96B78 800A6378 0000238E */  lw         $v1, 0x0($s1)
    /* 96B7C 800A637C 00000000 */  nop
    /* 96B80 800A6380 08006010 */  beqz       $v1, .L800A63A4
    /* 96B84 800A6384 03000524 */   addiu     $a1, $zero, 0x3
    /* 96B88 800A6388 0000628C */  lw         $v0, 0x0($v1)
    /* 96B8C 800A638C 00000000 */  nop
    /* 96B90 800A6390 08004484 */  lh         $a0, 0x8($v0)
    /* 96B94 800A6394 0C00428C */  lw         $v0, 0xC($v0)
    /* 96B98 800A6398 00000000 */  nop
    /* 96B9C 800A639C 09F84000 */  jalr       $v0
    /* 96BA0 800A63A0 21206400 */   addu      $a0, $v1, $a0
  .L800A63A4:
    /* 96BA4 800A63A4 D800A68F */  lw         $a2, 0xD8($sp)
    /* 96BA8 800A63A8 2128C003 */  addu       $a1, $fp, $zero
    /* 96BAC 800A63AC 000030AE */  sw         $s0, 0x0($s1)
    /* 96BB0 800A63B0 0000028E */  lw         $v0, 0x0($s0)
    /* 96BB4 800A63B4 DC00A78F */  lw         $a3, 0xDC($sp)
    /* 96BB8 800A63B8 10004484 */  lh         $a0, 0x10($v0)
    /* 96BBC 800A63BC 1400428C */  lw         $v0, 0x14($v0)
    /* 96BC0 800A63C0 00000000 */  nop
    /* 96BC4 800A63C4 09F84000 */  jalr       $v0
    /* 96BC8 800A63C8 21200402 */   addu      $a0, $s0, $a0
    /* 96BCC 800A63CC BB990208 */  j          .L800A66EC
    /* 96BD0 800A63D0 00000000 */   nop
  .L800A63D4:
    /* 96BD4 800A63D4 2800A48E */  lw         $a0, 0x28($s5)
    /* 96BD8 800A63D8 00000000 */  nop
    /* 96BDC 800A63DC 1000828C */  lw         $v0, 0x10($a0)
    /* 96BE0 800A63E0 00000000 */  nop
    /* 96BE4 800A63E4 0000428C */  lw         $v0, 0x0($v0)
    /* 96BE8 800A63E8 00000000 */  nop
    /* 96BEC 800A63EC 0A004384 */  lh         $v1, 0xA($v0)
    /* 96BF0 800A63F0 08004284 */  lh         $v0, 0x8($v0)
    /* 96BF4 800A63F4 00000000 */  nop
    /* 96BF8 800A63F8 18006200 */  mult       $v1, $v0
    /* 96BFC 800A63FC 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 96C00 800A6400 B0E0438C */  lw         $v1, %lo(D_8011E0B0)($v0)
    /* 96C04 800A6404 0000828C */  lw         $v0, 0x0($a0)
    /* 96C08 800A6408 00000000 */  nop
    /* 96C0C 800A640C 23206200 */  subu       $a0, $v1, $v0
    /* 96C10 800A6410 1C00A28E */  lw         $v0, 0x1C($s5)
    /* 96C14 800A6414 00000000 */  nop
    /* 96C18 800A6418 0400578C */  lw         $s7, 0x4($v0)
    /* 96C1C 800A641C 12400000 */  mflo       $t0
    /* 96C20 800A6420 43280800 */  sra        $a1, $t0, 1
    /* 96C24 800A6424 2A18A400 */  slt        $v1, $a1, $a0
    /* 96C28 800A6428 02006010 */  beqz       $v1, .L800A6434
    /* 96C2C 800A642C 21B00000 */   addu      $s6, $zero, $zero
    /* 96C30 800A6430 2120A000 */  addu       $a0, $a1, $zero
  .L800A6434:
    /* 96C34 800A6434 0400A28E */  lw         $v0, 0x4($s5)
    /* 96C38 800A6438 00000000 */  nop
    /* 96C3C 800A643C 18004400 */  mult       $v0, $a0
    /* 96C40 800A6440 12400000 */  mflo       $t0
    /* 96C44 800A6444 6800A8AF */  sw         $t0, 0x68($sp)
    /* 96C48 800A6448 0800A28E */  lw         $v0, 0x8($s5)
    /* 96C4C 800A644C 00000000 */  nop
    /* 96C50 800A6450 18004400 */  mult       $v0, $a0
    /* 96C54 800A6454 12400000 */  mflo       $t0
    /* 96C58 800A6458 6C00A8AF */  sw         $t0, 0x6C($sp)
    /* 96C5C 800A645C 0C00A28E */  lw         $v0, 0xC($s5)
    /* 96C60 800A6460 00000000 */  nop
    /* 96C64 800A6464 18004400 */  mult       $v0, $a0
    /* 96C68 800A6468 12400000 */  mflo       $t0
    /* 96C6C 800A646C 7000A8AF */  sw         $t0, 0x70($sp)
    /* 96C70 800A6470 1400A68E */  lw         $a2, 0x14($s5)
    /* 96C74 800A6474 00000000 */  nop
    /* 96C78 800A6478 0200C390 */  lbu        $v1, 0x2($a2)
    /* 96C7C 800A647C 06000224 */  addiu      $v0, $zero, 0x6
    /* 96C80 800A6480 3C006210 */  beq        $v1, $v0, .L800A6574
    /* 96C84 800A6484 A000A427 */   addiu     $a0, $sp, 0xA0
    /* 96C88 800A6488 1700C988 */  lwl        $t1, 0x17($a2)
    /* 96C8C 800A648C 1400C998 */  lwr        $t1, 0x14($a2)
    /* 96C90 800A6490 1B00CA88 */  lwl        $t2, 0x1B($a2)
    /* 96C94 800A6494 1800CA98 */  lwr        $t2, 0x18($a2)
    /* 96C98 800A6498 A300A9AB */  swl        $t1, 0xA3($sp)
    /* 96C9C 800A649C A000A9BB */  swr        $t1, 0xA0($sp)
    /* 96CA0 800A64A0 A700AAAB */  swl        $t2, 0xA7($sp)
    /* 96CA4 800A64A4 A400AABB */  swr        $t2, 0xA4($sp)
    /* 96CA8 800A64A8 E0B5020C */  jal        Quatern_QuatToMat__FP5tQuatP10matrixtdef
    /* 96CAC 800A64AC 7800A527 */   addiu     $a1, $sp, 0x78
    /* 96CB0 800A64B0 1400A28E */  lw         $v0, 0x14($s5)
    /* 96CB4 800A64B4 7800A48F */  lw         $a0, 0x78($sp)
    /* 96CB8 800A64B8 1C005084 */  lh         $s0, 0x1C($v0)
    /* 96CBC 800A64BC 1E005184 */  lh         $s1, 0x1E($v0)
    /* 96CC0 800A64C0 20005284 */  lh         $s2, 0x20($v0)
    /* 96CC4 800A64C4 00821000 */  sll        $s0, $s0, 8
    /* 96CC8 800A64C8 21280002 */  addu       $a1, $s0, $zero
    /* 96CCC 800A64CC 008A1100 */  sll        $s1, $s1, 8
    /* 96CD0 800A64D0 CA90030C */  jal        fixedmult
    /* 96CD4 800A64D4 00921200 */   sll       $s2, $s2, 8
    /* 96CD8 800A64D8 21A04000 */  addu       $s4, $v0, $zero
    /* 96CDC 800A64DC 8400A48F */  lw         $a0, 0x84($sp)
    /* 96CE0 800A64E0 CA90030C */  jal        fixedmult
    /* 96CE4 800A64E4 21280002 */   addu      $a1, $s0, $zero
    /* 96CE8 800A64E8 21984000 */  addu       $s3, $v0, $zero
    /* 96CEC 800A64EC 9000A48F */  lw         $a0, 0x90($sp)
    /* 96CF0 800A64F0 CA90030C */  jal        fixedmult
    /* 96CF4 800A64F4 21280002 */   addu      $a1, $s0, $zero
    /* 96CF8 800A64F8 7C00A48F */  lw         $a0, 0x7C($sp)
    /* 96CFC 800A64FC 21282002 */  addu       $a1, $s1, $zero
    /* 96D00 800A6500 7800B4AF */  sw         $s4, 0x78($sp)
    /* 96D04 800A6504 8400B3AF */  sw         $s3, 0x84($sp)
    /* 96D08 800A6508 CA90030C */  jal        fixedmult
    /* 96D0C 800A650C 9000A2AF */   sw        $v0, 0x90($sp)
    /* 96D10 800A6510 21A04000 */  addu       $s4, $v0, $zero
    /* 96D14 800A6514 8800A48F */  lw         $a0, 0x88($sp)
    /* 96D18 800A6518 CA90030C */  jal        fixedmult
    /* 96D1C 800A651C 21282002 */   addu      $a1, $s1, $zero
    /* 96D20 800A6520 21984000 */  addu       $s3, $v0, $zero
    /* 96D24 800A6524 9400A48F */  lw         $a0, 0x94($sp)
    /* 96D28 800A6528 CA90030C */  jal        fixedmult
    /* 96D2C 800A652C 21282002 */   addu      $a1, $s1, $zero
    /* 96D30 800A6530 8000A48F */  lw         $a0, 0x80($sp)
    /* 96D34 800A6534 21284002 */  addu       $a1, $s2, $zero
    /* 96D38 800A6538 7C00B4AF */  sw         $s4, 0x7C($sp)
    /* 96D3C 800A653C 8800B3AF */  sw         $s3, 0x88($sp)
    /* 96D40 800A6540 CA90030C */  jal        fixedmult
    /* 96D44 800A6544 9400A2AF */   sw        $v0, 0x94($sp)
    /* 96D48 800A6548 21A04000 */  addu       $s4, $v0, $zero
    /* 96D4C 800A654C 8C00A48F */  lw         $a0, 0x8C($sp)
    /* 96D50 800A6550 CA90030C */  jal        fixedmult
    /* 96D54 800A6554 21284002 */   addu      $a1, $s2, $zero
    /* 96D58 800A6558 21984000 */  addu       $s3, $v0, $zero
    /* 96D5C 800A655C 9800A48F */  lw         $a0, 0x98($sp)
    /* 96D60 800A6560 CA90030C */  jal        fixedmult
    /* 96D64 800A6564 21284002 */   addu      $a1, $s2, $zero
    /* 96D68 800A6568 8000B4AF */  sw         $s4, 0x80($sp)
    /* 96D6C 800A656C 8C00B3AF */  sw         $s3, 0x8C($sp)
    /* 96D70 800A6570 9800A2AF */  sw         $v0, 0x98($sp)
  .L800A6574:
    /* 96D74 800A6574 1480023C */  lui        $v0, %hi(gPersistObjInst)
    /* 96D78 800A6578 C0D4428C */  lw         $v0, %lo(gPersistObjInst)($v0)
    /* 96D7C 800A657C 00000000 */  nop
    /* 96D80 800A6580 04005024 */  addiu      $s0, $v0, 0x4
    /* 96D84 800A6584 2A10D702 */  slt        $v0, $s6, $s7
    /* 96D88 800A6588 57004010 */  beqz       $v0, .L800A66E8
    /* 96D8C 800A658C 06001124 */   addiu     $s1, $zero, 0x6
    /* 96D90 800A6590 08001324 */  addiu      $s3, $zero, 0x8
    /* 96D94 800A6594 05001224 */  addiu      $s2, $zero, 0x5
    /* 96D98 800A6598 2128C002 */  addu       $a1, $s6, $zero
  .L800A659C:
    /* 96D9C 800A659C 4800A627 */  addiu      $a2, $sp, 0x48
    /* 96DA0 800A65A0 2800A48E */  lw         $a0, 0x28($s5)
    /* 96DA4 800A65A4 89D1010C */  jal        GetTimedAnimPosRot__10AnimScriptiP8coorddefP10matrixtdef
    /* 96DA8 800A65A8 2000A727 */   addiu     $a3, $sp, 0x20
    /* 96DAC 800A65AC 1400A28E */  lw         $v0, 0x14($s5)
    /* 96DB0 800A65B0 00000000 */  nop
    /* 96DB4 800A65B4 02004290 */  lbu        $v0, 0x2($v0)
    /* 96DB8 800A65B8 00000000 */  nop
    /* 96DBC 800A65BC 04005110 */  beq        $v0, $s1, .L800A65D0
    /* 96DC0 800A65C0 2000A427 */   addiu     $a0, $sp, 0x20
    /* 96DC4 800A65C4 7800A527 */  addiu      $a1, $sp, 0x78
    /* 96DC8 800A65C8 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 96DCC 800A65CC 21308000 */   addu      $a2, $a0, $zero
  .L800A65D0:
    /* 96DD0 800A65D0 1000A28E */  lw         $v0, 0x10($s5)
    /* 96DD4 800A65D4 00000000 */  nop
    /* 96DD8 800A65D8 0000498C */  lw         $t1, 0x0($v0)
    /* 96DDC 800A65DC 04004A8C */  lw         $t2, 0x4($v0)
    /* 96DE0 800A65E0 08004B8C */  lw         $t3, 0x8($v0)
    /* 96DE4 800A65E4 5800A9AF */  sw         $t1, 0x58($sp)
    /* 96DE8 800A65E8 5C00AAAF */  sw         $t2, 0x5C($sp)
    /* 96DEC 800A65EC 6000ABAF */  sw         $t3, 0x60($sp)
    /* 96DF0 800A65F0 4800A48F */  lw         $a0, 0x48($sp)
    /* 96DF4 800A65F4 6800A28F */  lw         $v0, 0x68($sp)
    /* 96DF8 800A65F8 5C00A38F */  lw         $v1, 0x5C($sp)
    /* 96DFC 800A65FC 4C00A58F */  lw         $a1, 0x4C($sp)
    /* 96E00 800A6600 21208200 */  addu       $a0, $a0, $v0
    /* 96E04 800A6604 5800A28F */  lw         $v0, 0x58($sp)
    /* 96E08 800A6608 21186500 */  addu       $v1, $v1, $a1
    /* 96E0C 800A660C 5C00A3AF */  sw         $v1, 0x5C($sp)
    /* 96E10 800A6610 5000A38F */  lw         $v1, 0x50($sp)
    /* 96E14 800A6614 21104400 */  addu       $v0, $v0, $a0
    /* 96E18 800A6618 7000A48F */  lw         $a0, 0x70($sp)
    /* 96E1C 800A661C 5800A2AF */  sw         $v0, 0x58($sp)
    /* 96E20 800A6620 6000A28F */  lw         $v0, 0x60($sp)
    /* 96E24 800A6624 21186400 */  addu       $v1, $v1, $a0
    /* 96E28 800A6628 21104300 */  addu       $v0, $v0, $v1
    /* 96E2C 800A662C 6000A2AF */  sw         $v0, 0x60($sp)
  .L800A6630:
    /* 96E30 800A6630 02000292 */  lbu        $v0, 0x2($s0)
    /* 96E34 800A6634 00000000 */  nop
    /* 96E38 800A6638 13005314 */  bne        $v0, $s3, .L800A6688
    /* 96E3C 800A663C 00000000 */   nop
    /* 96E40 800A6640 1400A58E */  lw         $a1, 0x14($s5)
    /* 96E44 800A6644 00000000 */  nop
    /* 96E48 800A6648 0200A490 */  lbu        $a0, 0x2($a1)
    /* 96E4C 800A664C 00000000 */  nop
    /* 96E50 800A6650 06009214 */  bne        $a0, $s2, .L800A666C
    /* 96E54 800A6654 00000000 */   nop
    /* 96E58 800A6658 0D000392 */  lbu        $v1, 0xD($s0)
    /* 96E5C 800A665C 2300A290 */  lbu        $v0, 0x23($a1)
    /* 96E60 800A6660 00000000 */  nop
    /* 96E64 800A6664 08006214 */  bne        $v1, $v0, .L800A6688
    /* 96E68 800A6668 00000000 */   nop
  .L800A666C:
    /* 96E6C 800A666C 09009114 */  bne        $a0, $s1, .L800A6694
    /* 96E70 800A6670 2120C003 */   addu      $a0, $fp, $zero
    /* 96E74 800A6674 0D000392 */  lbu        $v1, 0xD($s0)
    /* 96E78 800A6678 0D00A290 */  lbu        $v0, 0xD($a1)
    /* 96E7C 800A667C 00000000 */  nop
    /* 96E80 800A6680 04006210 */  beq        $v1, $v0, .L800A6694
    /* 96E84 800A6684 00000000 */   nop
  .L800A6688:
    /* 96E88 800A6688 00000286 */  lh         $v0, 0x0($s0)
    /* 96E8C 800A668C 8C990208 */  j          .L800A6630
    /* 96E90 800A6690 21800202 */   addu      $s0, $s0, $v0
  .L800A6694:
    /* 96E94 800A6694 2000A627 */  addiu      $a2, $sp, 0x20
    /* 96E98 800A6698 D800A58F */  lw         $a1, 0xD8($sp)
    /* 96E9C 800A669C 06000286 */  lh         $v0, 0x6($s0)
    /* 96EA0 800A66A0 1480033C */  lui        $v1, %hi(Track_gObjDefs)
    /* 96EA4 800A66A4 D4D4638C */  lw         $v1, %lo(Track_gObjDefs)($v1)
    /* 96EA8 800A66A8 DC00A98F */  lw         $t1, 0xDC($sp)
    /* 96EAC 800A66AC 80100200 */  sll        $v0, $v0, 2
    /* 96EB0 800A66B0 21104300 */  addu       $v0, $v0, $v1
    /* 96EB4 800A66B4 0000478C */  lw         $a3, 0x0($v0)
    /* 96EB8 800A66B8 5800A227 */  addiu      $v0, $sp, 0x58
    /* 96EBC 800A66BC 1000A2AF */  sw         $v0, 0x10($sp)
    /* 96EC0 800A66C0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 96EC4 800A66C4 1400A9AF */  sw         $t1, 0x14($sp)
    /* 96EC8 800A66C8 AF1F030C */  jal        DrawObjectTransform__FP13DRender_tViewP11Draw_DCacheP10matrixtdefP13Trk_ObjectDefP8coorddefis
    /* 96ECC 800A66CC 1800A2AF */   sw        $v0, 0x18($sp)
    /* 96ED0 800A66D0 00000286 */  lh         $v0, 0x0($s0)
    /* 96ED4 800A66D4 0100D626 */  addiu      $s6, $s6, 0x1
    /* 96ED8 800A66D8 21800202 */  addu       $s0, $s0, $v0
    /* 96EDC 800A66DC 2A10D702 */  slt        $v0, $s6, $s7
    /* 96EE0 800A66E0 AEFF4014 */  bnez       $v0, .L800A659C
    /* 96EE4 800A66E4 2128C002 */   addu      $a1, $s6, $zero
  .L800A66E8:
    /* 96EE8 800A66E8 04000224 */  addiu      $v0, $zero, 0x4
  .L800A66EC:
    /* 96EEC 800A66EC CC00BF8F */  lw         $ra, 0xCC($sp)
    /* 96EF0 800A66F0 C800BE8F */  lw         $fp, 0xC8($sp)
    /* 96EF4 800A66F4 C400B78F */  lw         $s7, 0xC4($sp)
    /* 96EF8 800A66F8 C000B68F */  lw         $s6, 0xC0($sp)
    /* 96EFC 800A66FC BC00B58F */  lw         $s5, 0xBC($sp)
    /* 96F00 800A6700 B800B48F */  lw         $s4, 0xB8($sp)
    /* 96F04 800A6704 B400B38F */  lw         $s3, 0xB4($sp)
    /* 96F08 800A6708 B000B28F */  lw         $s2, 0xB0($sp)
    /* 96F0C 800A670C AC00B18F */  lw         $s1, 0xAC($sp)
    /* 96F10 800A6710 A800B08F */  lw         $s0, 0xA8($sp)
    /* 96F14 800A6714 0800E003 */  jr         $ra
    /* 96F18 800A6718 D000BD27 */   addiu     $sp, $sp, 0xD0
endlabel Draw__15ObjectMultiAnimP13DRender_tViewP11Draw_DCachei
