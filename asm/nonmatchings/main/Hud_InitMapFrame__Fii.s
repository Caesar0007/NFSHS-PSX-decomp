.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_InitMapFrame__Fii, 0x3AC

glabel Hud_InitMapFrame__Fii
    /* C334C 800D2B4C A8FFBD27 */  addiu      $sp, $sp, -0x58
    /* C3350 800D2B50 3000B0AF */  sw         $s0, 0x30($sp)
    /* C3354 800D2B54 2180A000 */  addu       $s0, $a1, $zero
    /* C3358 800D2B58 5400BFAF */  sw         $ra, 0x54($sp)
    /* C335C 800D2B5C 5000BEAF */  sw         $fp, 0x50($sp)
    /* C3360 800D2B60 4C00B7AF */  sw         $s7, 0x4C($sp)
    /* C3364 800D2B64 4800B6AF */  sw         $s6, 0x48($sp)
    /* C3368 800D2B68 4400B5AF */  sw         $s5, 0x44($sp)
    /* C336C 800D2B6C 4000B4AF */  sw         $s4, 0x40($sp)
    /* C3370 800D2B70 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* C3374 800D2B74 3800B2AF */  sw         $s2, 0x38($sp)
    /* C3378 800D2B78 04008010 */  beqz       $a0, .L800D2B8C
    /* C337C 800D2B7C 3400B1AF */   sw        $s1, 0x34($sp)
    /* C3380 800D2B80 C018938F */  lw         $s3, %gp_rel(D_8013DE0C)($gp)
    /* C3384 800D2B84 E54A0308 */  j          .L800D2B94
    /* C3388 800D2B88 1480023C */   lui       $v0, %hi(D_8013E450)
  .L800D2B8C:
    /* C338C 800D2B8C BC18938F */  lw         $s3, %gp_rel(D_8013DE08)($gp)
    /* C3390 800D2B90 1480023C */  lui        $v0, %hi(D_8013E450)
  .L800D2B94:
    /* C3394 800D2B94 50E44224 */  addiu      $v0, $v0, %lo(D_8013E450)
    /* C3398 800D2B98 04008010 */  beqz       $a0, .L800D2BAC
    /* C339C 800D2B9C 2000A2AF */   sw        $v0, 0x20($sp)
    /* C33A0 800D2BA0 21404000 */  addu       $t0, $v0, $zero
    /* C33A4 800D2BA4 A8000825 */  addiu      $t0, $t0, 0xA8
    /* C33A8 800D2BA8 2000A8AF */  sw         $t0, 0x20($sp)
  .L800D2BAC:
    /* C33AC 800D2BAC 1480023C */  lui        $v0, %hi(D_8013E5A0)
    /* C33B0 800D2BB0 02008010 */  beqz       $a0, .L800D2BBC
    /* C33B4 800D2BB4 A0E55524 */   addiu     $s5, $v0, %lo(D_8013E5A0)
    /* C33B8 800D2BB8 C800B526 */  addiu      $s5, $s5, 0xC8
  .L800D2BBC:
    /* C33BC 800D2BBC 02008010 */  beqz       $a0, .L800D2BC8
    /* C33C0 800D2BC0 21900000 */   addu      $s2, $zero, $zero
    /* C33C4 800D2BC4 F3FF1224 */  addiu      $s2, $zero, -0xD
  .L800D2BC8:
    /* C33C8 800D2BC8 1180083C */  lui        $t0, %hi(HudPmx_gShapes)
    /* C33CC 800D2BCC 980C0825 */  addiu      $t0, $t0, %lo(HudPmx_gShapes)
    /* C33D0 800D2BD0 B818868F */  lw         $a2, %gp_rel(D_8013DE04)($gp)
    /* C33D4 800D2BD4 2A011685 */  lh         $s6, 0x12A($t0)
    /* C33D8 800D2BD8 28011785 */  lh         $s7, 0x128($t0)
    /* C33DC 800D2BDC A2010285 */  lh         $v0, 0x1A2($t0)
    /* C33E0 800D2BE0 F0010385 */  lh         $v1, 0x1F0($t0)
    /* C33E4 800D2BE4 2310C202 */  subu       $v0, $s6, $v0
    /* C33E8 800D2BE8 3800D484 */  lh         $s4, 0x38($a2)
    /* C33EC 800D2BEC 2318E302 */  subu       $v1, $s7, $v1
    /* C33F0 800D2BF0 2400A2AF */  sw         $v0, 0x24($sp)
    /* C33F4 800D2BF4 2C00A3AF */  sw         $v1, 0x2C($sp)
    /* C33F8 800D2BF8 F2011E85 */  lh         $fp, 0x1F2($t0)
    /* C33FC 800D2BFC A0010885 */  lh         $t0, 0x1A0($t0)
    /* C3400 800D2C00 00000000 */  nop
    /* C3404 800D2C04 2800A8AF */  sw         $t0, 0x28($sp)
    /* C3408 800D2C08 01000824 */  addiu      $t0, $zero, 0x1
    /* C340C 800D2C0C 02000816 */  bne        $s0, $t0, .L800D2C18
    /* C3410 800D2C10 FF00033C */   lui       $v1, (0xFF5721 >> 16)
    /* C3414 800D2C14 E2FF9426 */  addiu      $s4, $s4, -0x1E
  .L800D2C18:
    /* C3418 800D2C18 21576334 */  ori        $v1, $v1, (0xFF5721 & 0xFFFF)
    /* C341C 800D2C1C EC046426 */  addiu      $a0, $s3, 0x4EC
    /* C3420 800D2C20 0E000524 */  addiu      $a1, $zero, 0xE
    /* C3424 800D2C24 3A00C784 */  lh         $a3, 0x3A($a2)
    /* C3428 800D2C28 2014828F */  lw         $v0, %gp_rel(HudMapOffsetY)($gp)
    /* C342C 800D2C2C 21308002 */  addu       $a2, $s4, $zero
    /* C3430 800D2C30 C81883AF */  sw         $v1, %gp_rel(D_8013DE14)($gp)
    /* C3434 800D2C34 C41880A3 */  sb         $zero, %gp_rel(D_8013DE10)($gp)
    /* C3438 800D2C38 2138E200 */  addu       $a3, $a3, $v0
    /* C343C 800D2C3C 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C3440 800D2C40 2138F200 */   addu      $a3, $a3, $s2
    /* C3444 800D2C44 00056426 */  addiu      $a0, $s3, 0x500
    /* C3448 800D2C48 0F000524 */  addiu      $a1, $zero, 0xF
    /* C344C 800D2C4C B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C3450 800D2C50 2800A88F */  lw         $t0, 0x28($sp)
    /* C3454 800D2C54 38004684 */  lh         $a2, 0x38($v0)
    /* C3458 800D2C58 3A004784 */  lh         $a3, 0x3A($v0)
    /* C345C 800D2C5C 2014828F */  lw         $v0, %gp_rel(HudMapOffsetY)($gp)
    /* C3460 800D2C60 2130D700 */  addu       $a2, $a2, $s7
    /* C3464 800D2C64 2130C800 */  addu       $a2, $a2, $t0
    /* C3468 800D2C68 2138E200 */  addu       $a3, $a3, $v0
    /* C346C 800D2C6C 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C3470 800D2C70 2138F200 */   addu      $a3, $a3, $s2
    /* C3474 800D2C74 14056426 */  addiu      $a0, $s3, 0x514
    /* C3478 800D2C78 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C347C 800D2C7C 10000524 */  addiu      $a1, $zero, 0x10
    /* C3480 800D2C80 3A004784 */  lh         $a3, 0x3A($v0)
    /* C3484 800D2C84 2014828F */  lw         $v0, %gp_rel(HudMapOffsetY)($gp)
    /* C3488 800D2C88 21308002 */  addu       $a2, $s4, $zero
    /* C348C 800D2C8C 2138E200 */  addu       $a3, $a3, $v0
    /* C3490 800D2C90 2138F600 */  addu       $a3, $a3, $s6
    /* C3494 800D2C94 2138FE00 */  addu       $a3, $a3, $fp
    /* C3498 800D2C98 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C349C 800D2C9C 2138F200 */   addu      $a3, $a3, $s2
    /* C34A0 800D2CA0 28056426 */  addiu      $a0, $s3, 0x528
    /* C34A4 800D2CA4 11000524 */  addiu      $a1, $zero, 0x11
    /* C34A8 800D2CA8 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C34AC 800D2CAC 2800A88F */  lw         $t0, 0x28($sp)
    /* C34B0 800D2CB0 38004684 */  lh         $a2, 0x38($v0)
    /* C34B4 800D2CB4 3A004784 */  lh         $a3, 0x3A($v0)
    /* C34B8 800D2CB8 2014828F */  lw         $v0, %gp_rel(HudMapOffsetY)($gp)
    /* C34BC 800D2CBC 2130D700 */  addu       $a2, $a2, $s7
    /* C34C0 800D2CC0 2130C800 */  addu       $a2, $a2, $t0
    /* C34C4 800D2CC4 2138E200 */  addu       $a3, $a3, $v0
    /* C34C8 800D2CC8 2138F600 */  addu       $a3, $a3, $s6
    /* C34CC 800D2CCC 2138FE00 */  addu       $a3, $a3, $fp
    /* C34D0 800D2CD0 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C34D4 800D2CD4 2138F200 */   addu      $a3, $a3, $s2
    /* C34D8 800D2CD8 3C056426 */  addiu      $a0, $s3, 0x53C
    /* C34DC 800D2CDC 14001026 */  addiu      $s0, $s0, 0x14
    /* C34E0 800D2CE0 21280002 */  addu       $a1, $s0, $zero
    /* C34E4 800D2CE4 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C34E8 800D2CE8 21889702 */  addu       $s1, $s4, $s7
    /* C34EC 800D2CEC 3A004784 */  lh         $a3, 0x3A($v0)
    /* C34F0 800D2CF0 2014828F */  lw         $v0, %gp_rel(HudMapOffsetY)($gp)
    /* C34F4 800D2CF4 21302002 */  addu       $a2, $s1, $zero
    /* C34F8 800D2CF8 2138E200 */  addu       $a3, $a3, $v0
    /* C34FC 800D2CFC 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C3500 800D2D00 2138F200 */   addu      $a3, $a3, $s2
    /* C3504 800D2D04 50056426 */  addiu      $a0, $s3, 0x550
    /* C3508 800D2D08 21280002 */  addu       $a1, $s0, $zero
    /* C350C 800D2D0C B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C3510 800D2D10 21302002 */  addu       $a2, $s1, $zero
    /* C3514 800D2D14 3A004784 */  lh         $a3, 0x3A($v0)
    /* C3518 800D2D18 2014828F */  lw         $v0, %gp_rel(HudMapOffsetY)($gp)
    /* C351C 800D2D1C 2400A88F */  lw         $t0, 0x24($sp)
    /* C3520 800D2D20 2138E200 */  addu       $a3, $a3, $v0
    /* C3524 800D2D24 2138F600 */  addu       $a3, $a3, $s6
    /* C3528 800D2D28 2138FE00 */  addu       $a3, $a3, $fp
    /* C352C 800D2D2C 2138E800 */  addu       $a3, $a3, $t0
    /* C3530 800D2D30 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C3534 800D2D34 2138F200 */   addu      $a3, $a3, $s2
    /* C3538 800D2D38 64056426 */  addiu      $a0, $s3, 0x564
    /* C353C 800D2D3C B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C3540 800D2D40 18000524 */  addiu      $a1, $zero, 0x18
    /* C3544 800D2D44 3A004784 */  lh         $a3, 0x3A($v0)
    /* C3548 800D2D48 2014828F */  lw         $v0, %gp_rel(HudMapOffsetY)($gp)
    /* C354C 800D2D4C 21308002 */  addu       $a2, $s4, $zero
    /* C3550 800D2D50 2138E200 */  addu       $a3, $a3, $v0
    /* C3554 800D2D54 2138F600 */  addu       $a3, $a3, $s6
    /* C3558 800D2D58 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C355C 800D2D5C 2138F200 */   addu      $a3, $a3, $s2
    /* C3560 800D2D60 78056426 */  addiu      $a0, $s3, 0x578
    /* C3564 800D2D64 18000524 */  addiu      $a1, $zero, 0x18
    /* C3568 800D2D68 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C356C 800D2D6C 2800A88F */  lw         $t0, 0x28($sp)
    /* C3570 800D2D70 38004684 */  lh         $a2, 0x38($v0)
    /* C3574 800D2D74 3A004784 */  lh         $a3, 0x3A($v0)
    /* C3578 800D2D78 2014828F */  lw         $v0, %gp_rel(HudMapOffsetY)($gp)
    /* C357C 800D2D7C 2130D700 */  addu       $a2, $a2, $s7
    /* C3580 800D2D80 2130C800 */  addu       $a2, $a2, $t0
    /* C3584 800D2D84 2138E200 */  addu       $a3, $a3, $v0
    /* C3588 800D2D88 2138F600 */  addu       $a3, $a3, $s6
    /* C358C 800D2D8C 2C00A88F */  lw         $t0, 0x2C($sp)
    /* C3590 800D2D90 2138F200 */  addu       $a3, $a3, $s2
    /* C3594 800D2D94 1148030C */  jal        Hud_BuildSprite2__FP4SPRTiii
    /* C3598 800D2D98 2130C800 */   addu      $a2, $a2, $t0
    /* C359C 800D2D9C 01000524 */  addiu      $a1, $zero, 0x1
    /* C35A0 800D2DA0 21300000 */  addu       $a2, $zero, $zero
    /* C35A4 800D2DA4 2138C000 */  addu       $a3, $a2, $zero
    /* C35A8 800D2DA8 2000A88F */  lw         $t0, 0x20($sp)
    /* C35AC 800D2DAC 2D000224 */  addiu      $v0, $zero, 0x2D
    /* C35B0 800D2DB0 1000A2AF */  sw         $v0, 0x10($sp)
    /* C35B4 800D2DB4 30000224 */  addiu      $v0, $zero, 0x30
    /* C35B8 800D2DB8 1400A2AF */  sw         $v0, 0x14($sp)
    /* C35BC 800D2DBC 1800A0AF */  sw         $zero, 0x18($sp)
    /* C35C0 800D2DC0 8D49030C */  jal        Hud_BuildF4__FP7POLY_F4iiiiiUl
    /* C35C4 800D2DC4 60000425 */   addiu     $a0, $t0, 0x60
    /* C35C8 800D2DC8 1180023C */  lui        $v0, %hi(D_80113218)
    /* C35CC 800D2DCC 1832428C */  lw         $v0, %lo(D_80113218)($v0)
    /* C35D0 800D2DD0 00000000 */  nop
    /* C35D4 800D2DD4 0E004010 */  beqz       $v0, .L800D2E10
    /* C35D8 800D2DD8 8000023C */   lui       $v0, (0x808080 >> 16)
    /* C35DC 800D2DDC 80804234 */  ori        $v0, $v0, (0x808080 & 0xFFFF)
    /* C35E0 800D2DE0 2120A002 */  addu       $a0, $s5, $zero
    /* C35E4 800D2DE4 1180083C */  lui        $t0, %hi(HudPmx_gShapes)
    /* C35E8 800D2DE8 980C0825 */  addiu      $t0, $t0, %lo(HudPmx_gShapes)
    /* C35EC 800D2DEC 60090525 */  addiu      $a1, $t0, 0x960
    /* C35F0 800D2DF0 21300000 */  addu       $a2, $zero, $zero
    /* C35F4 800D2DF4 2138C000 */  addu       $a3, $a2, $zero
    /* C35F8 800D2DF8 01000824 */  addiu      $t0, $zero, 0x1
    /* C35FC 800D2DFC 1000A2AF */  sw         $v0, 0x10($sp)
    /* C3600 800D2E00 4A49030C */  jal        Hud_BuildMapMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli
    /* C3604 800D2E04 1400A8AF */   sw        $t0, 0x14($sp)
    /* C3608 800D2E08 904B0308 */  j          .L800D2E40
    /* C360C 800D2E0C 8000123C */   lui       $s2, (0x808080 >> 16)
  .L800D2E10:
    /* C3610 800D2E10 80804234 */  ori        $v0, $v0, (0x808080 & 0xFFFF)
    /* C3614 800D2E14 2120A002 */  addu       $a0, $s5, $zero
    /* C3618 800D2E18 1180083C */  lui        $t0, %hi(HudPmx_gShapes)
    /* C361C 800D2E1C 980C0825 */  addiu      $t0, $t0, %lo(HudPmx_gShapes)
    /* C3620 800D2E20 60090525 */  addiu      $a1, $t0, 0x960
    /* C3624 800D2E24 21300000 */  addu       $a2, $zero, $zero
    /* C3628 800D2E28 2138C000 */  addu       $a3, $a2, $zero
    /* C362C 800D2E2C 01000824 */  addiu      $t0, $zero, 0x1
    /* C3630 800D2E30 1000A2AF */  sw         $v0, 0x10($sp)
    /* C3634 800D2E34 CD48030C */  jal        Hud_BuildFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli
    /* C3638 800D2E38 1400A8AF */   sw        $t0, 0x14($sp)
    /* C363C 800D2E3C 8000123C */  lui        $s2, (0x808080 >> 16)
  .L800D2E40:
    /* C3640 800D2E40 80805236 */  ori        $s2, $s2, (0x808080 & 0xFFFF)
    /* C3644 800D2E44 2800A426 */  addiu      $a0, $s5, 0x28
    /* C3648 800D2E48 1180103C */  lui        $s0, %hi(D_80111558)
    /* C364C 800D2E4C 58151026 */  addiu      $s0, $s0, %lo(D_80111558)
    /* C3650 800D2E50 21280002 */  addu       $a1, $s0, $zero
    /* C3654 800D2E54 21300000 */  addu       $a2, $zero, $zero
    /* C3658 800D2E58 2138C000 */  addu       $a3, $a2, $zero
    /* C365C 800D2E5C 01001124 */  addiu      $s1, $zero, 0x1
    /* C3660 800D2E60 1000B2AF */  sw         $s2, 0x10($sp)
    /* C3664 800D2E64 CD48030C */  jal        Hud_BuildFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli
    /* C3668 800D2E68 1400B1AF */   sw        $s1, 0x14($sp)
    /* C366C 800D2E6C 5000A426 */  addiu      $a0, $s5, 0x50
    /* C3670 800D2E70 21280002 */  addu       $a1, $s0, $zero
    /* C3674 800D2E74 40F71326 */  addiu      $s3, $s0, -0x8C0
    /* C3678 800D2E78 D0086686 */  lh         $a2, 0x8D0($s3)
    /* C367C 800D2E7C 21380000 */  addu       $a3, $zero, $zero
    /* C3680 800D2E80 1000B2AF */  sw         $s2, 0x10($sp)
    /* C3684 800D2E84 0949030C */  jal        Hud_BuildMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli
    /* C3688 800D2E88 1400B1AF */   sw        $s1, 0x14($sp)
    /* C368C 800D2E8C 7800A426 */  addiu      $a0, $s5, 0x78
    /* C3690 800D2E90 14001026 */  addiu      $s0, $s0, 0x14
    /* C3694 800D2E94 21280002 */  addu       $a1, $s0, $zero
    /* C3698 800D2E98 21300000 */  addu       $a2, $zero, $zero
    /* C369C 800D2E9C 2138C000 */  addu       $a3, $a2, $zero
    /* C36A0 800D2EA0 1000B2AF */  sw         $s2, 0x10($sp)
    /* C36A4 800D2EA4 CD48030C */  jal        Hud_BuildFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli
    /* C36A8 800D2EA8 1400B1AF */   sw        $s1, 0x14($sp)
    /* C36AC 800D2EAC A000A426 */  addiu      $a0, $s5, 0xA0
    /* C36B0 800D2EB0 21280002 */  addu       $a1, $s0, $zero
    /* C36B4 800D2EB4 E4086686 */  lh         $a2, 0x8E4($s3)
    /* C36B8 800D2EB8 21380000 */  addu       $a3, $zero, $zero
    /* C36BC 800D2EBC 1000B2AF */  sw         $s2, 0x10($sp)
    /* C36C0 800D2EC0 0949030C */  jal        Hud_BuildMirrorFT4__FP8POLY_FT4P13HudPmx_tShapeiiUli
    /* C36C4 800D2EC4 1400B1AF */   sw        $s1, 0x14($sp)
    /* C36C8 800D2EC8 5400BF8F */  lw         $ra, 0x54($sp)
    /* C36CC 800D2ECC 5000BE8F */  lw         $fp, 0x50($sp)
    /* C36D0 800D2ED0 4C00B78F */  lw         $s7, 0x4C($sp)
    /* C36D4 800D2ED4 4800B68F */  lw         $s6, 0x48($sp)
    /* C36D8 800D2ED8 4400B58F */  lw         $s5, 0x44($sp)
    /* C36DC 800D2EDC 4000B48F */  lw         $s4, 0x40($sp)
    /* C36E0 800D2EE0 3C00B38F */  lw         $s3, 0x3C($sp)
    /* C36E4 800D2EE4 3800B28F */  lw         $s2, 0x38($sp)
    /* C36E8 800D2EE8 3400B18F */  lw         $s1, 0x34($sp)
    /* C36EC 800D2EEC 3000B08F */  lw         $s0, 0x30($sp)
    /* C36F0 800D2EF0 0800E003 */  jr         $ra
    /* C36F4 800D2EF4 5800BD27 */   addiu     $sp, $sp, 0x58
endlabel Hud_InitMapFrame__Fii
