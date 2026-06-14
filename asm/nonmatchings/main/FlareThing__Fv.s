.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FlareThing__Fv, 0x10C

glabel FlareThing__Fv
    /* A3DE8 800B35E8 1180023C */  lui        $v0, %hi(D_801131F8)
    /* A3DEC 800B35EC F831428C */  lw         $v0, %lo(D_801131F8)($v0)
    /* A3DF0 800B35F0 C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* A3DF4 800B35F4 2800B4AF */  sw         $s4, 0x28($sp)
    /* A3DF8 800B35F8 01001424 */  addiu      $s4, $zero, 0x1
    /* A3DFC 800B35FC 3800BFAF */  sw         $ra, 0x38($sp)
    /* A3E00 800B3600 3400B7AF */  sw         $s7, 0x34($sp)
    /* A3E04 800B3604 3000B6AF */  sw         $s6, 0x30($sp)
    /* A3E08 800B3608 2C00B5AF */  sw         $s5, 0x2C($sp)
    /* A3E0C 800B360C 2400B3AF */  sw         $s3, 0x24($sp)
    /* A3E10 800B3610 2000B2AF */  sw         $s2, 0x20($sp)
    /* A3E14 800B3614 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* A3E18 800B3618 02005414 */  bne        $v0, $s4, .L800B3624
    /* A3E1C 800B361C 1800B0AF */   sw        $s0, 0x18($sp)
    /* A3E20 800B3620 02001424 */  addiu      $s4, $zero, 0x2
  .L800B3624:
    /* A3E24 800B3624 21880000 */  addu       $s1, $zero, $zero
    /* A3E28 800B3628 1280023C */  lui        $v0, %hi(gEnviro)
    /* A3E2C 800B362C 24F45724 */  addiu      $s7, $v0, %lo(gEnviro)
    /* A3E30 800B3630 05001624 */  addiu      $s6, $zero, 0x5
    /* A3E34 800B3634 1280023C */  lui        $v0, %hi(gFlare_LensFlare)
    /* A3E38 800B3638 78025524 */  addiu      $s5, $v0, %lo(gFlare_LensFlare)
    /* A3E3C 800B363C 1000B326 */  addiu      $s3, $s5, 0x10
    /* A3E40 800B3640 2180A002 */  addu       $s0, $s5, $zero
  .L800B3644:
    /* A3E44 800B3644 2A103402 */  slt        $v0, $s1, $s4
    /* A3E48 800B3648 1F004010 */  beqz       $v0, .L800B36C8
    /* A3E4C 800B364C 21903502 */   addu      $s2, $s1, $s5
    /* A3E50 800B3650 7C004292 */  lbu        $v0, 0x7C($s2)
    /* A3E54 800B3654 00000000 */  nop
    /* A3E58 800B3658 17004010 */  beqz       $v0, .L800B36B8
    /* A3E5C 800B365C 21286002 */   addu      $a1, $s3, $zero
    /* A3E60 800B3660 1480023C */  lui        $v0, %hi(gFlip)
    /* A3E64 800B3664 B4D7428C */  lw         $v0, %lo(gFlip)($v0)
    /* A3E68 800B3668 08000496 */  lhu        $a0, 0x8($s0)
    /* A3E6C 800B366C 40180200 */  sll        $v1, $v0, 1
    /* A3E70 800B3670 21186200 */  addu       $v1, $v1, $v0
    /* A3E74 800B3674 C0180300 */  sll        $v1, $v1, 3
    /* A3E78 800B3678 21187700 */  addu       $v1, $v1, $s7
    /* A3E7C 800B367C 00006294 */  lhu        $v0, 0x0($v1)
    /* A3E80 800B3680 00000000 */  nop
    /* A3E84 800B3684 21104400 */  addu       $v0, $v0, $a0
    /* A3E88 800B3688 FEFF4224 */  addiu      $v0, $v0, -0x2
    /* A3E8C 800B368C 1000A2A7 */  sh         $v0, 0x10($sp)
    /* A3E90 800B3690 02006294 */  lhu        $v0, 0x2($v1)
    /* A3E94 800B3694 0A000396 */  lhu        $v1, 0xA($s0)
    /* A3E98 800B3698 1000A427 */  addiu      $a0, $sp, 0x10
    /* A3E9C 800B369C 1400B6A7 */  sh         $s6, 0x14($sp)
    /* A3EA0 800B36A0 1600B6A7 */  sh         $s6, 0x16($sp)
    /* A3EA4 800B36A4 21104300 */  addu       $v0, $v0, $v1
    /* A3EA8 800B36A8 FEFF4224 */  addiu      $v0, $v0, -0x2
    /* A3EAC 800B36AC BCB6030C */  jal        StoreImage
    /* A3EB0 800B36B0 1200A2A7 */   sh        $v0, 0x12($sp)
    /* A3EB4 800B36B4 7C0040A2 */  sb         $zero, 0x7C($s2)
  .L800B36B8:
    /* A3EB8 800B36B8 32007326 */  addiu      $s3, $s3, 0x32
    /* A3EBC 800B36BC 04001026 */  addiu      $s0, $s0, 0x4
    /* A3EC0 800B36C0 91CD0208 */  j          .L800B3644
    /* A3EC4 800B36C4 01003126 */   addiu     $s1, $s1, 0x1
  .L800B36C8:
    /* A3EC8 800B36C8 3800BF8F */  lw         $ra, 0x38($sp)
    /* A3ECC 800B36CC 3400B78F */  lw         $s7, 0x34($sp)
    /* A3ED0 800B36D0 3000B68F */  lw         $s6, 0x30($sp)
    /* A3ED4 800B36D4 2C00B58F */  lw         $s5, 0x2C($sp)
    /* A3ED8 800B36D8 2800B48F */  lw         $s4, 0x28($sp)
    /* A3EDC 800B36DC 2400B38F */  lw         $s3, 0x24($sp)
    /* A3EE0 800B36E0 2000B28F */  lw         $s2, 0x20($sp)
    /* A3EE4 800B36E4 1C00B18F */  lw         $s1, 0x1C($sp)
    /* A3EE8 800B36E8 1800B08F */  lw         $s0, 0x18($sp)
    /* A3EEC 800B36EC 0800E003 */  jr         $ra
    /* A3EF0 800B36F0 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel FlareThing__Fv
