.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BuildMapMarkers__Fi, 0x4D0

glabel Hud_BuildMapMarkers__Fi
    /* C62E8 800D5AE8 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* C62EC 800D5AEC 4000BEAF */  sw         $fp, 0x40($sp)
    /* C62F0 800D5AF0 18001E24 */  addiu      $fp, $zero, 0x18
    /* C62F4 800D5AF4 3400B5AF */  sw         $s5, 0x34($sp)
    /* C62F8 800D5AF8 21A80000 */  addu       $s5, $zero, $zero
    /* C62FC 800D5AFC 3800B6AF */  sw         $s6, 0x38($sp)
    /* C6300 800D5B00 FF00163C */  lui        $s6, (0xFFFFFF >> 16)
    /* C6304 800D5B04 1180023C */  lui        $v0, %hi(Cars_gCopCarList)
    /* C6308 800D5B08 3000B4AF */  sw         $s4, 0x30($sp)
    /* C630C 800D5B0C B4FA5424 */  addiu      $s4, $v0, %lo(Cars_gCopCarList)
    /* C6310 800D5B10 3414828F */  lw         $v0, %gp_rel(gMapOffY)($gp)
    /* C6314 800D5B14 3014888F */  lw         $t0, %gp_rel(gMapOffX)($gp)
    /* C6318 800D5B18 FFFFD636 */  ori        $s6, $s6, (0xFFFFFF & 0xFFFF)
    /* C631C 800D5B1C 4400BFAF */  sw         $ra, 0x44($sp)
    /* C6320 800D5B20 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* C6324 800D5B24 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* C6328 800D5B28 2800B2AF */  sw         $s2, 0x28($sp)
    /* C632C 800D5B2C 2400B1AF */  sw         $s1, 0x24($sp)
    /* C6330 800D5B30 2000B0AF */  sw         $s0, 0x20($sp)
    /* C6334 800D5B34 02004224 */  addiu      $v0, $v0, 0x2
    /* C6338 800D5B38 1800A8AF */  sw         $t0, 0x18($sp)
    /* C633C 800D5B3C 1C00A2AF */  sw         $v0, 0x1C($sp)
  .L800D5B40:
    /* C6340 800D5B40 1480023C */  lui        $v0, %hi(Cars_gNumCopCars)
    /* C6344 800D5B44 0CC8428C */  lw         $v0, %lo(Cars_gNumCopCars)($v0)
    /* C6348 800D5B48 00000000 */  nop
    /* C634C 800D5B4C 2A10A202 */  slt        $v0, $s5, $v0
    /* C6350 800D5B50 79004010 */  beqz       $v0, .L800D5D38
    /* C6354 800D5B54 FF00173C */   lui       $s7, (0xFFFFFF >> 16)
    /* C6358 800D5B58 0000838E */  lw         $v1, 0x0($s4)
    /* C635C 800D5B5C 00000000 */  nop
    /* C6360 800D5B60 91006290 */  lbu        $v0, 0x91($v1)
    /* C6364 800D5B64 00000000 */  nop
    /* C6368 800D5B68 70004010 */  beqz       $v0, .L800D5D2C
    /* C636C 800D5B6C 80B81500 */   sll       $s7, $s5, 2
    /* C6370 800D5B70 08006384 */  lh         $v1, 0x8($v1)
    /* C6374 800D5B74 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* C6378 800D5B78 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* C637C 800D5B7C 40190300 */  sll        $v1, $v1, 5
    /* C6380 800D5B80 21186200 */  addu       $v1, $v1, $v0
    /* C6384 800D5B84 0000648C */  lw         $a0, 0x0($v1)
    /* C6388 800D5B88 2814828F */  lw         $v0, %gp_rel(gMapScaleX)($gp)
    /* C638C 800D5B8C 00000000 */  nop
    /* C6390 800D5B90 1A008200 */  div        $zero, $a0, $v0
    /* C6394 800D5B94 02004014 */  bnez       $v0, .L800D5BA0
    /* C6398 800D5B98 00000000 */   nop
    /* C639C 800D5B9C 0D000700 */  break      7
  .L800D5BA0:
    /* C63A0 800D5BA0 FFFF0124 */  addiu      $at, $zero, -0x1
    /* C63A4 800D5BA4 04004114 */  bne        $v0, $at, .L800D5BB8
    /* C63A8 800D5BA8 0080013C */   lui       $at, (0x80000000 >> 16)
    /* C63AC 800D5BAC 02008114 */  bne        $a0, $at, .L800D5BB8
    /* C63B0 800D5BB0 00000000 */   nop
    /* C63B4 800D5BB4 0D000600 */  break      6
  .L800D5BB8:
    /* C63B8 800D5BB8 12900000 */  mflo       $s2
    /* C63BC 800D5BBC 0800638C */  lw         $v1, 0x8($v1)
    /* C63C0 800D5BC0 2C14828F */  lw         $v0, %gp_rel(gMapScaleY)($gp)
    /* C63C4 800D5BC4 00000000 */  nop
    /* C63C8 800D5BC8 1A006200 */  div        $zero, $v1, $v0
    /* C63CC 800D5BCC 02004014 */  bnez       $v0, .L800D5BD8
    /* C63D0 800D5BD0 00000000 */   nop
    /* C63D4 800D5BD4 0D000700 */  break      7
  .L800D5BD8:
    /* C63D8 800D5BD8 FFFF0124 */  addiu      $at, $zero, -0x1
    /* C63DC 800D5BDC 04004114 */  bne        $v0, $at, .L800D5BF0
    /* C63E0 800D5BE0 0080013C */   lui       $at, (0x80000000 >> 16)
    /* C63E4 800D5BE4 02006114 */  bne        $v1, $at, .L800D5BF0
    /* C63E8 800D5BE8 00000000 */   nop
    /* C63EC 800D5BEC 0D000600 */  break      6
  .L800D5BF0:
    /* C63F0 800D5BF0 12880000 */  mflo       $s1
    /* C63F4 800D5BF4 FC13848F */  lw         $a0, %gp_rel(mapMarkerMCos)($gp)
    /* C63F8 800D5BF8 CA90030C */  jal        fixedmult
    /* C63FC 800D5BFC 21284002 */   addu      $a1, $s2, $zero
    /* C6400 800D5C00 21804000 */  addu       $s0, $v0, $zero
    /* C6404 800D5C04 0014848F */  lw         $a0, %gp_rel(mapMarkerMSin)($gp)
    /* C6408 800D5C08 CA90030C */  jal        fixedmult
    /* C640C 800D5C0C 21282002 */   addu      $a1, $s1, $zero
    /* C6410 800D5C10 21284002 */  addu       $a1, $s2, $zero
    /* C6414 800D5C14 1800A88F */  lw         $t0, 0x18($sp)
    /* C6418 800D5C18 0014848F */  lw         $a0, %gp_rel(mapMarkerMSin)($gp)
    /* C641C 800D5C1C 21801001 */  addu       $s0, $t0, $s0
    /* C6420 800D5C20 CA90030C */  jal        fixedmult
    /* C6424 800D5C24 23980202 */   subu      $s3, $s0, $v0
    /* C6428 800D5C28 21282002 */  addu       $a1, $s1, $zero
    /* C642C 800D5C2C FC13848F */  lw         $a0, %gp_rel(mapMarkerMCos)($gp)
    /* C6430 800D5C30 CA90030C */  jal        fixedmult
    /* C6434 800D5C34 21804000 */   addu      $s0, $v0, $zero
    /* C6438 800D5C38 1180033C */  lui        $v1, %hi(D_80113218)
    /* C643C 800D5C3C 1C00A88F */  lw         $t0, 0x1C($sp)
    /* C6440 800D5C40 1832638C */  lw         $v1, %lo(D_80113218)($v1)
    /* C6444 800D5C44 21801001 */  addu       $s0, $t0, $s0
    /* C6448 800D5C48 02006010 */  beqz       $v1, .L800D5C54
    /* C644C 800D5C4C 21800202 */   addu      $s0, $s0, $v0
    /* C6450 800D5C50 23981300 */  negu       $s3, $s3
  .L800D5C54:
    /* C6454 800D5C54 801F053C */  lui        $a1, (0x1F800004 >> 16)
    /* C6458 800D5C58 0400A534 */  ori        $a1, $a1, (0x1F800004 & 0xFFFF)
    /* C645C 800D5C5C 00FF083C */  lui        $t0, (0xFF000000 >> 16)
    /* C6460 800D5C60 0000A68C */  lw         $a2, 0x0($a1)
    /* C6464 800D5C64 801F043C */  lui        $a0, (0x1F800000 >> 16)
    /* C6468 800D5C68 0000848C */  lw         $a0, (0x1F800000 & 0xFFFF)($a0)
    /* C646C 800D5C6C 0000C38C */  lw         $v1, 0x0($a2)
    /* C6470 800D5C70 0000828C */  lw         $v0, 0x0($a0)
    /* C6474 800D5C74 24186800 */  and        $v1, $v1, $t0
    /* C6478 800D5C78 24105600 */  and        $v0, $v0, $s6
    /* C647C 800D5C7C 25186200 */  or         $v1, $v1, $v0
    /* C6480 800D5C80 0000C3AC */  sw         $v1, 0x0($a2)
    /* C6484 800D5C84 0000828C */  lw         $v0, 0x0($a0)
    /* C6488 800D5C88 2418D600 */  and        $v1, $a2, $s6
    /* C648C 800D5C8C 24104800 */  and        $v0, $v0, $t0
    /* C6490 800D5C90 25104300 */  or         $v0, $v0, $v1
    /* C6494 800D5C94 000082AC */  sw         $v0, 0x0($a0)
    /* C6498 800D5C98 0000828E */  lw         $v0, 0x0($s4)
    /* C649C 800D5C9C 00000000 */  nop
    /* C64A0 800D5CA0 7005438C */  lw         $v1, 0x570($v0)
    /* C64A4 800D5CA4 1400C224 */  addiu      $v0, $a2, 0x14
    /* C64A8 800D5CA8 02006330 */  andi       $v1, $v1, 0x2
    /* C64AC 800D5CAC 0D006010 */  beqz       $v1, .L800D5CE4
    /* C64B0 800D5CB0 0000A2AC */   sw        $v0, 0x0($a1)
    /* C64B4 800D5CB4 1480023C */  lui        $v0, %hi(gFlip)
    /* C64B8 800D5CB8 B4D7428C */  lw         $v0, %lo(gFlip)($v0)
    /* C64BC 800D5CBC 00000000 */  nop
    /* C64C0 800D5CC0 0C004014 */  bnez       $v0, .L800D5CF4
    /* C64C4 800D5CC4 FF000224 */   addiu     $v0, $zero, 0xFF
    /* C64C8 800D5CC8 1280023C */  lui        $v0, %hi(D_8011E0D4)
    /* C64CC 800D5CCC D4E0428C */  lw         $v0, %lo(D_8011E0D4)($v0)
    /* C64D0 800D5CD0 00000000 */  nop
    /* C64D4 800D5CD4 07004014 */  bnez       $v0, .L800D5CF4
    /* C64D8 800D5CD8 FF000224 */   addiu     $v0, $zero, 0xFF
    /* C64DC 800D5CDC 3D570308 */  j          .L800D5CF4
    /* C64E0 800D5CE0 FF00023C */   lui       $v0, (0xFF0000 >> 16)
  .L800D5CE4:
    /* C64E4 800D5CE4 1280023C */  lui        $v0, %hi(Hud_gCopMarkerColor)
    /* C64E8 800D5CE8 900B4224 */  addiu      $v0, $v0, %lo(Hud_gCopMarkerColor)
    /* C64EC 800D5CEC 2110E202 */  addu       $v0, $s7, $v0
    /* C64F0 800D5CF0 0000428C */  lw         $v0, 0x0($v0)
  .L800D5CF4:
    /* C64F4 800D5CF4 00000000 */  nop
    /* C64F8 800D5CF8 C81882AF */  sw         $v0, %gp_rel(D_8013DE14)($gp)
    /* C64FC 800D5CFC 2120C000 */  addu       $a0, $a2, $zero
    /* C6500 800D5D00 7A000524 */  addiu      $a1, $zero, 0x7A
    /* C6504 800D5D04 16000824 */  addiu      $t0, $zero, 0x16
    /* C6508 800D5D08 21301301 */  addu       $a2, $t0, $s3
    /* C650C 800D5D0C FEFFC624 */  addiu      $a2, $a2, -0x2
    /* C6510 800D5D10 FFFFC630 */  andi       $a2, $a2, 0xFFFF
    /* C6514 800D5D14 2338D003 */  subu       $a3, $fp, $s0
    /* C6518 800D5D18 C818828F */  lw         $v0, %gp_rel(D_8013DE14)($gp)
    /* C651C 800D5D1C FFFFE730 */  andi       $a3, $a3, 0xFFFF
    /* C6520 800D5D20 1400A0AF */  sw         $zero, 0x14($sp)
    /* C6524 800D5D24 E647030C */  jal        Hud_BuildSprite__FP4SPRTiiiUli
    /* C6528 800D5D28 1000A2AF */   sw        $v0, 0x10($sp)
  .L800D5D2C:
    /* C652C 800D5D2C 04009426 */  addiu      $s4, $s4, 0x4
    /* C6530 800D5D30 D0560308 */  j          .L800D5B40
    /* C6534 800D5D34 0100B526 */   addiu     $s5, $s5, 0x1
  .L800D5D38:
    /* C6538 800D5D38 21A80000 */  addu       $s5, $zero, $zero
    /* C653C 800D5D3C FFFFF736 */  ori        $s7, $s7, (0xFFFFFF & 0xFFFF)
    /* C6540 800D5D40 1280023C */  lui        $v0, %hi(Hud_gMarkerColor)
    /* C6544 800D5D44 600B5424 */  addiu      $s4, $v0, %lo(Hud_gMarkerColor)
    /* C6548 800D5D48 1180023C */  lui        $v0, %hi(Cars_gRaceCarList)
    /* C654C 800D5D4C 00FA5624 */  addiu      $s6, $v0, %lo(Cars_gRaceCarList)
  .L800D5D50:
    /* C6550 800D5D50 1480023C */  lui        $v0, %hi(Cars_gNumRaceCars)
    /* C6554 800D5D54 F8C7428C */  lw         $v0, %lo(Cars_gNumRaceCars)($v0)
    /* C6558 800D5D58 00000000 */  nop
    /* C655C 800D5D5C 2A10A202 */  slt        $v0, $s5, $v0
    /* C6560 800D5D60 89004010 */  beqz       $v0, .L800D5F88
    /* C6564 800D5D64 00000000 */   nop
    /* C6568 800D5D68 0000C38E */  lw         $v1, 0x0($s6)
    /* C656C 800D5D6C 00000000 */  nop
    /* C6570 800D5D70 91006290 */  lbu        $v0, 0x91($v1)
    /* C6574 800D5D74 00000000 */  nop
    /* C6578 800D5D78 7F004010 */  beqz       $v0, .L800D5F78
    /* C657C 800D5D7C 00000000 */   nop
    /* C6580 800D5D80 08006384 */  lh         $v1, 0x8($v1)
    /* C6584 800D5D84 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* C6588 800D5D88 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* C658C 800D5D8C 40190300 */  sll        $v1, $v1, 5
    /* C6590 800D5D90 21186200 */  addu       $v1, $v1, $v0
    /* C6594 800D5D94 0000648C */  lw         $a0, 0x0($v1)
    /* C6598 800D5D98 2814828F */  lw         $v0, %gp_rel(gMapScaleX)($gp)
    /* C659C 800D5D9C 00000000 */  nop
    /* C65A0 800D5DA0 1A008200 */  div        $zero, $a0, $v0
    /* C65A4 800D5DA4 02004014 */  bnez       $v0, .L800D5DB0
    /* C65A8 800D5DA8 00000000 */   nop
    /* C65AC 800D5DAC 0D000700 */  break      7
  .L800D5DB0:
    /* C65B0 800D5DB0 FFFF0124 */  addiu      $at, $zero, -0x1
    /* C65B4 800D5DB4 04004114 */  bne        $v0, $at, .L800D5DC8
    /* C65B8 800D5DB8 0080013C */   lui       $at, (0x80000000 >> 16)
    /* C65BC 800D5DBC 02008114 */  bne        $a0, $at, .L800D5DC8
    /* C65C0 800D5DC0 00000000 */   nop
    /* C65C4 800D5DC4 0D000600 */  break      6
  .L800D5DC8:
    /* C65C8 800D5DC8 12900000 */  mflo       $s2
    /* C65CC 800D5DCC 0800638C */  lw         $v1, 0x8($v1)
    /* C65D0 800D5DD0 2C14828F */  lw         $v0, %gp_rel(gMapScaleY)($gp)
    /* C65D4 800D5DD4 00000000 */  nop
    /* C65D8 800D5DD8 1A006200 */  div        $zero, $v1, $v0
    /* C65DC 800D5DDC 02004014 */  bnez       $v0, .L800D5DE8
    /* C65E0 800D5DE0 00000000 */   nop
    /* C65E4 800D5DE4 0D000700 */  break      7
  .L800D5DE8:
    /* C65E8 800D5DE8 FFFF0124 */  addiu      $at, $zero, -0x1
    /* C65EC 800D5DEC 04004114 */  bne        $v0, $at, .L800D5E00
    /* C65F0 800D5DF0 0080013C */   lui       $at, (0x80000000 >> 16)
    /* C65F4 800D5DF4 02006114 */  bne        $v1, $at, .L800D5E00
    /* C65F8 800D5DF8 00000000 */   nop
    /* C65FC 800D5DFC 0D000600 */  break      6
  .L800D5E00:
    /* C6600 800D5E00 12880000 */  mflo       $s1
    /* C6604 800D5E04 FC13848F */  lw         $a0, %gp_rel(mapMarkerMCos)($gp)
    /* C6608 800D5E08 CA90030C */  jal        fixedmult
    /* C660C 800D5E0C 21284002 */   addu      $a1, $s2, $zero
    /* C6610 800D5E10 21804000 */  addu       $s0, $v0, $zero
    /* C6614 800D5E14 0014848F */  lw         $a0, %gp_rel(mapMarkerMSin)($gp)
    /* C6618 800D5E18 CA90030C */  jal        fixedmult
    /* C661C 800D5E1C 21282002 */   addu      $a1, $s1, $zero
    /* C6620 800D5E20 21284002 */  addu       $a1, $s2, $zero
    /* C6624 800D5E24 1800A88F */  lw         $t0, 0x18($sp)
    /* C6628 800D5E28 0014848F */  lw         $a0, %gp_rel(mapMarkerMSin)($gp)
    /* C662C 800D5E2C 21801001 */  addu       $s0, $t0, $s0
    /* C6630 800D5E30 CA90030C */  jal        fixedmult
    /* C6634 800D5E34 23980202 */   subu      $s3, $s0, $v0
    /* C6638 800D5E38 21282002 */  addu       $a1, $s1, $zero
    /* C663C 800D5E3C FC13848F */  lw         $a0, %gp_rel(mapMarkerMCos)($gp)
    /* C6640 800D5E40 CA90030C */  jal        fixedmult
    /* C6644 800D5E44 21804000 */   addu      $s0, $v0, $zero
    /* C6648 800D5E48 1180033C */  lui        $v1, %hi(D_80113218)
    /* C664C 800D5E4C 1C00A88F */  lw         $t0, 0x1C($sp)
    /* C6650 800D5E50 1832638C */  lw         $v1, %lo(D_80113218)($v1)
    /* C6654 800D5E54 21801001 */  addu       $s0, $t0, $s0
    /* C6658 800D5E58 02006010 */  beqz       $v1, .L800D5E64
    /* C665C 800D5E5C 21800202 */   addu      $s0, $s0, $v0
    /* C6660 800D5E60 23981300 */  negu       $s3, $s3
  .L800D5E64:
    /* C6664 800D5E64 801F063C */  lui        $a2, (0x1F800004 >> 16)
    /* C6668 800D5E68 0400C634 */  ori        $a2, $a2, (0x1F800004 & 0xFFFF)
    /* C666C 800D5E6C 00FF053C */  lui        $a1, (0xFF000000 >> 16)
    /* C6670 800D5E70 0000C78C */  lw         $a3, 0x0($a2)
    /* C6674 800D5E74 801F043C */  lui        $a0, (0x1F800000 >> 16)
    /* C6678 800D5E78 0000848C */  lw         $a0, (0x1F800000 & 0xFFFF)($a0)
    /* C667C 800D5E7C 0000E38C */  lw         $v1, 0x0($a3)
    /* C6680 800D5E80 0000828C */  lw         $v0, 0x0($a0)
    /* C6684 800D5E84 24186500 */  and        $v1, $v1, $a1
    /* C6688 800D5E88 24105700 */  and        $v0, $v0, $s7
    /* C668C 800D5E8C 25186200 */  or         $v1, $v1, $v0
    /* C6690 800D5E90 0000E3AC */  sw         $v1, 0x0($a3)
    /* C6694 800D5E94 0000828C */  lw         $v0, 0x0($a0)
    /* C6698 800D5E98 2418F700 */  and        $v1, $a3, $s7
    /* C669C 800D5E9C 24104500 */  and        $v0, $v0, $a1
    /* C66A0 800D5EA0 25104300 */  or         $v0, $v0, $v1
    /* C66A4 800D5EA4 000082AC */  sw         $v0, 0x0($a0)
    /* C66A8 800D5EA8 0000C48E */  lw         $a0, 0x0($s6)
    /* C66AC 800D5EAC 00000000 */  nop
    /* C66B0 800D5EB0 6002838C */  lw         $v1, 0x260($a0)
    /* C66B4 800D5EB4 1400E224 */  addiu      $v0, $a3, 0x14
    /* C66B8 800D5EB8 0000C2AC */  sw         $v0, 0x0($a2)
    /* C66BC 800D5EBC 00026230 */  andi       $v0, $v1, 0x200
    /* C66C0 800D5EC0 1D004010 */  beqz       $v0, .L800D5F38
    /* C66C4 800D5EC4 04006230 */   andi      $v0, $v1, 0x4
    /* C66C8 800D5EC8 7005828C */  lw         $v0, 0x570($a0)
    /* C66CC 800D5ECC 00000000 */  nop
    /* C66D0 800D5ED0 02004230 */  andi       $v0, $v0, 0x2
    /* C66D4 800D5ED4 0D004010 */  beqz       $v0, .L800D5F0C
    /* C66D8 800D5ED8 00000000 */   nop
    /* C66DC 800D5EDC 1480023C */  lui        $v0, %hi(gFlip)
    /* C66E0 800D5EE0 B4D7428C */  lw         $v0, %lo(gFlip)($v0)
    /* C66E4 800D5EE4 00000000 */  nop
    /* C66E8 800D5EE8 09004014 */  bnez       $v0, .L800D5F10
    /* C66EC 800D5EEC FF000224 */   addiu     $v0, $zero, 0xFF
    /* C66F0 800D5EF0 1280023C */  lui        $v0, %hi(D_8011E0D4)
    /* C66F4 800D5EF4 D4E0428C */  lw         $v0, %lo(D_8011E0D4)($v0)
    /* C66F8 800D5EF8 00000000 */  nop
    /* C66FC 800D5EFC 04004014 */  bnez       $v0, .L800D5F10
    /* C6700 800D5F00 FF000224 */   addiu     $v0, $zero, 0xFF
    /* C6704 800D5F04 C4570308 */  j          .L800D5F10
    /* C6708 800D5F08 FF00023C */   lui       $v0, (0xFF0000 >> 16)
  .L800D5F0C:
    /* C670C 800D5F0C 0000828E */  lw         $v0, 0x0($s4)
  .L800D5F10:
    /* C6710 800D5F10 00000000 */  nop
    /* C6714 800D5F14 C81882AF */  sw         $v0, %gp_rel(D_8013DE14)($gp)
    /* C6718 800D5F18 2120E000 */  addu       $a0, $a3, $zero
    /* C671C 800D5F1C 79000524 */  addiu      $a1, $zero, 0x79
    /* C6720 800D5F20 16006626 */  addiu      $a2, $s3, 0x16
    /* C6724 800D5F24 FDFFC624 */  addiu      $a2, $a2, -0x3
    /* C6728 800D5F28 FFFFC630 */  andi       $a2, $a2, 0xFFFF
    /* C672C 800D5F2C C818828F */  lw         $v0, %gp_rel(D_8013DE14)($gp)
    /* C6730 800D5F30 DA570308 */  j          .L800D5F68
    /* C6734 800D5F34 2338D003 */   subu      $a3, $fp, $s0
  .L800D5F38:
    /* C6738 800D5F38 05004010 */  beqz       $v0, .L800D5F50
    /* C673C 800D5F3C 2120E000 */   addu      $a0, $a3, $zero
    /* C6740 800D5F40 79000524 */  addiu      $a1, $zero, 0x79
    /* C6744 800D5F44 16006626 */  addiu      $a2, $s3, 0x16
    /* C6748 800D5F48 D7570308 */  j          .L800D5F5C
    /* C674C 800D5F4C FDFFC624 */   addiu     $a2, $a2, -0x3
  .L800D5F50:
    /* C6750 800D5F50 7A000524 */  addiu      $a1, $zero, 0x7A
    /* C6754 800D5F54 16006626 */  addiu      $a2, $s3, 0x16
    /* C6758 800D5F58 FEFFC624 */  addiu      $a2, $a2, -0x2
  .L800D5F5C:
    /* C675C 800D5F5C FFFFC630 */  andi       $a2, $a2, 0xFFFF
    /* C6760 800D5F60 2338D003 */  subu       $a3, $fp, $s0
    /* C6764 800D5F64 0000828E */  lw         $v0, 0x0($s4)
  .L800D5F68:
    /* C6768 800D5F68 FFFFE730 */  andi       $a3, $a3, 0xFFFF
    /* C676C 800D5F6C 1400A0AF */  sw         $zero, 0x14($sp)
    /* C6770 800D5F70 E647030C */  jal        Hud_BuildSprite__FP4SPRTiiiUli
    /* C6774 800D5F74 1000A2AF */   sw        $v0, 0x10($sp)
  .L800D5F78:
    /* C6778 800D5F78 04009426 */  addiu      $s4, $s4, 0x4
    /* C677C 800D5F7C 0400D626 */  addiu      $s6, $s6, 0x4
    /* C6780 800D5F80 54570308 */  j          .L800D5D50
    /* C6784 800D5F84 0100B526 */   addiu     $s5, $s5, 0x1
  .L800D5F88:
    /* C6788 800D5F88 4400BF8F */  lw         $ra, 0x44($sp)
    /* C678C 800D5F8C 4000BE8F */  lw         $fp, 0x40($sp)
    /* C6790 800D5F90 3C00B78F */  lw         $s7, 0x3C($sp)
    /* C6794 800D5F94 3800B68F */  lw         $s6, 0x38($sp)
    /* C6798 800D5F98 3400B58F */  lw         $s5, 0x34($sp)
    /* C679C 800D5F9C 3000B48F */  lw         $s4, 0x30($sp)
    /* C67A0 800D5FA0 2C00B38F */  lw         $s3, 0x2C($sp)
    /* C67A4 800D5FA4 2800B28F */  lw         $s2, 0x28($sp)
    /* C67A8 800D5FA8 2400B18F */  lw         $s1, 0x24($sp)
    /* C67AC 800D5FAC 2000B08F */  lw         $s0, 0x20($sp)
    /* C67B0 800D5FB0 0800E003 */  jr         $ra
    /* C67B4 800D5FB4 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Hud_BuildMapMarkers__Fi
