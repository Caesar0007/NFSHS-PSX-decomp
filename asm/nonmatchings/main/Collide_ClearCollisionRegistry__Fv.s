.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Collide_ClearCollisionRegistry__Fv, 0x200

glabel Collide_ClearCollisionRegistry__Fv
    /* 81CD4 800914D4 B0FFBD27 */  addiu      $sp, $sp, -0x50
    /* 81CD8 800914D8 3C00B3AF */  sw         $s3, 0x3C($sp)
    /* 81CDC 800914DC 21980000 */  addu       $s3, $zero, $zero
    /* 81CE0 800914E0 1180023C */  lui        $v0, %hi(D_80110184)
    /* 81CE4 800914E4 4800B6AF */  sw         $s6, 0x48($sp)
    /* 81CE8 800914E8 84015624 */  addiu      $s6, $v0, %lo(D_80110184)
    /* 81CEC 800914EC 4400B5AF */  sw         $s5, 0x44($sp)
    /* 81CF0 800914F0 68FFD526 */  addiu      $s5, $s6, -0x98
    /* 81CF4 800914F4 1180023C */  lui        $v0, %hi(Collide_gRegistry)
    /* 81CF8 800914F8 4000B4AF */  sw         $s4, 0x40($sp)
    /* 81CFC 800914FC 300C5424 */  addiu      $s4, $v0, %lo(Collide_gRegistry)
    /* 81D00 80091500 3800B2AF */  sw         $s2, 0x38($sp)
    /* 81D04 80091504 2190C002 */  addu       $s2, $s6, $zero
    /* 81D08 80091508 3400B1AF */  sw         $s1, 0x34($sp)
    /* 81D0C 8009150C 21886002 */  addu       $s1, $s3, $zero
    /* 81D10 80091510 4C00BFAF */  sw         $ra, 0x4C($sp)
    /* 81D14 80091514 3000B0AF */  sw         $s0, 0x30($sp)
    /* 81D18 80091518 E80280AF */  sw         $zero, %gp_rel(Collide_gNumRegistered)($gp)
  .L8009151C:
    /* 81D1C 8009151C 0198020C */  jal        Object_GetNumIMassObjects__Fv
    /* 81D20 80091520 00000000 */   nop
    /* 81D24 80091524 2A106202 */  slt        $v0, $s3, $v0
    /* 81D28 80091528 59004010 */  beqz       $v0, .L80091690
    /* 81D2C 8009152C 21206002 */   addu      $a0, $s3, $zero
    /* 81D30 80091530 21284002 */  addu       $a1, $s2, $zero
    /* 81D34 80091534 5000C626 */  addiu      $a2, $s6, 0x50
    /* 81D38 80091538 0C00C726 */  addiu      $a3, $s6, 0xC
    /* 81D3C 8009153C 21302602 */  addu       $a2, $s1, $a2
    /* 81D40 80091540 0F98020C */  jal        Object_GetIMassObjectMotion__FiP8coorddefP10matrixtdefT1
    /* 81D44 80091544 21382702 */   addu      $a3, $s1, $a3
    /* 81D48 80091548 21204002 */  addu       $a0, $s2, $zero
    /* 81D4C 8009154C 60FFC226 */  addiu      $v0, $s6, -0xA0
    /* 81D50 80091550 E802838F */  lw         $v1, %gp_rel(Collide_gNumRegistered)($gp)
    /* 81D54 80091554 21802202 */  addu       $s0, $s1, $v0
    /* 81D58 80091558 140100AE */  sw         $zero, 0x114($s0)
    /* 81D5C 8009155C 180100AE */  sw         $zero, 0x118($s0)
    /* 81D60 80091560 1C0100AE */  sw         $zero, 0x11C($s0)
    /* 81D64 80091564 000090AE */  sw         $s0, 0x0($s4)
    /* 81D68 80091568 01006324 */  addiu      $v1, $v1, 0x1
    /* 81D6C 8009156C E80283AF */  sw         $v1, %gp_rel(Collide_gNumRegistered)($gp)
    /* 81D70 80091570 85FA010C */  jal        BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos
    /* 81D74 80091574 2128A002 */   addu      $a1, $s5, $zero
    /* 81D78 80091578 08000386 */  lh         $v1, 0x8($s0)
    /* 81D7C 8009157C 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 81D80 80091580 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 81D84 80091584 A000058E */  lw         $a1, 0xA0($s0)
    /* 81D88 80091588 40190300 */  sll        $v1, $v1, 5
    /* 81D8C 8009158C 21186200 */  addu       $v1, $v1, $v0
    /* 81D90 80091590 0000628C */  lw         $v0, 0x0($v1)
    /* 81D94 80091594 00000000 */  nop
    /* 81D98 80091598 2328A200 */  subu       $a1, $a1, $v0
    /* 81D9C 8009159C 1000A5AF */  sw         $a1, 0x10($sp)
    /* 81DA0 800915A0 A400048E */  lw         $a0, 0xA4($s0)
    /* 81DA4 800915A4 0000628C */  lw         $v0, 0x0($v1)
    /* 81DA8 800915A8 00000000 */  nop
    /* 81DAC 800915AC 23408200 */  subu       $t0, $a0, $v0
    /* 81DB0 800915B0 1400A8AF */  sw         $t0, 0x14($sp)
    /* 81DB4 800915B4 A800048E */  lw         $a0, 0xA8($s0)
    /* 81DB8 800915B8 0000628C */  lw         $v0, 0x0($v1)
    /* 81DBC 800915BC 00000000 */  nop
    /* 81DC0 800915C0 23508200 */  subu       $t2, $a0, $v0
    /* 81DC4 800915C4 1800AAAF */  sw         $t2, 0x18($sp)
    /* 81DC8 800915C8 12006280 */  lb         $v0, 0x12($v1)
    /* 81DCC 800915CC 00000000 */  nop
    /* 81DD0 800915D0 40320200 */  sll        $a2, $v0, 9
    /* 81DD4 800915D4 2000A6AF */  sw         $a2, 0x20($sp)
    /* 81DD8 800915D8 13006280 */  lb         $v0, 0x13($v1)
    /* 81DDC 800915DC 00000000 */  nop
    /* 81DE0 800915E0 403A0200 */  sll        $a3, $v0, 9
    /* 81DE4 800915E4 2400A7AF */  sw         $a3, 0x24($sp)
    /* 81DE8 800915E8 14006280 */  lb         $v0, 0x14($v1)
    /* 81DEC 800915EC 00000000 */  nop
    /* 81DF0 800915F0 404A0200 */  sll        $t1, $v0, 9
    /* 81DF4 800915F4 0200A104 */  bgez       $a1, .L80091600
    /* 81DF8 800915F8 2800A9AF */   sw        $t1, 0x28($sp)
    /* 81DFC 800915FC FF00A524 */  addiu      $a1, $a1, 0xFF
  .L80091600:
    /* 81E00 80091600 2110C000 */  addu       $v0, $a2, $zero
    /* 81E04 80091604 02004104 */  bgez       $v0, .L80091610
    /* 81E08 80091608 032A0500 */   sra       $a1, $a1, 8
    /* 81E0C 8009160C FF004224 */  addiu      $v0, $v0, 0xFF
  .L80091610:
    /* 81E10 80091610 03120200 */  sra        $v0, $v0, 8
    /* 81E14 80091614 1800A200 */  mult       $a1, $v0
    /* 81E18 80091618 21200001 */  addu       $a0, $t0, $zero
    /* 81E1C 8009161C 12180000 */  mflo       $v1
    /* 81E20 80091620 02008104 */  bgez       $a0, .L8009162C
    /* 81E24 80091624 2110E000 */   addu      $v0, $a3, $zero
    /* 81E28 80091628 FF008424 */  addiu      $a0, $a0, 0xFF
  .L8009162C:
    /* 81E2C 8009162C 02004104 */  bgez       $v0, .L80091638
    /* 81E30 80091630 03220400 */   sra       $a0, $a0, 8
    /* 81E34 80091634 FF004224 */  addiu      $v0, $v0, 0xFF
  .L80091638:
    /* 81E38 80091638 03120200 */  sra        $v0, $v0, 8
    /* 81E3C 8009163C 18008200 */  mult       $a0, $v0
    /* 81E40 80091640 21204001 */  addu       $a0, $t2, $zero
    /* 81E44 80091644 12580000 */  mflo       $t3
    /* 81E48 80091648 02008104 */  bgez       $a0, .L80091654
    /* 81E4C 8009164C 21286B00 */   addu      $a1, $v1, $t3
    /* 81E50 80091650 FF008424 */  addiu      $a0, $a0, 0xFF
  .L80091654:
    /* 81E54 80091654 21102001 */  addu       $v0, $t1, $zero
    /* 81E58 80091658 02004104 */  bgez       $v0, .L80091664
    /* 81E5C 8009165C 03220400 */   sra       $a0, $a0, 8
    /* 81E60 80091660 FF004224 */  addiu      $v0, $v0, 0xFF
  .L80091664:
    /* 81E64 80091664 03120200 */  sra        $v0, $v0, 8
    /* 81E68 80091668 18008200 */  mult       $a0, $v0
    /* 81E6C 8009166C 4002B526 */  addiu      $s5, $s5, 0x240
    /* 81E70 80091670 04009426 */  addiu      $s4, $s4, 0x4
    /* 81E74 80091674 40025226 */  addiu      $s2, $s2, 0x240
    /* 81E78 80091678 40023126 */  addiu      $s1, $s1, 0x240
    /* 81E7C 8009167C 01007326 */  addiu      $s3, $s3, 0x1
    /* 81E80 80091680 12580000 */  mflo       $t3
    /* 81E84 80091684 2110AB00 */  addu       $v0, $a1, $t3
    /* 81E88 80091688 47450208 */  j          .L8009151C
    /* 81E8C 8009168C C40002AE */   sw        $v0, 0xC4($s0)
  .L80091690:
    /* 81E90 80091690 21180000 */  addu       $v1, $zero, $zero
    /* 81E94 80091694 1480043C */  lui        $a0, %hi(Cars_gNumCars)
    /* 81E98 80091698 F4C7848C */  lw         $a0, %lo(Cars_gNumCars)($a0)
  .L8009169C:
    /* 81E9C 8009169C 00000000 */  nop
    /* 81EA0 800916A0 2A106400 */  slt        $v0, $v1, $a0
    /* 81EA4 800916A4 FDFF4014 */  bnez       $v0, .L8009169C
    /* 81EA8 800916A8 01006324 */   addiu     $v1, $v1, 0x1
    /* 81EAC 800916AC 4C00BF8F */  lw         $ra, 0x4C($sp)
    /* 81EB0 800916B0 4800B68F */  lw         $s6, 0x48($sp)
    /* 81EB4 800916B4 4400B58F */  lw         $s5, 0x44($sp)
    /* 81EB8 800916B8 4000B48F */  lw         $s4, 0x40($sp)
    /* 81EBC 800916BC 3C00B38F */  lw         $s3, 0x3C($sp)
    /* 81EC0 800916C0 3800B28F */  lw         $s2, 0x38($sp)
    /* 81EC4 800916C4 3400B18F */  lw         $s1, 0x34($sp)
    /* 81EC8 800916C8 3000B08F */  lw         $s0, 0x30($sp)
    /* 81ECC 800916CC 0800E003 */  jr         $ra
    /* 81ED0 800916D0 5000BD27 */   addiu     $sp, $sp, 0x50
endlabel Collide_ClearCollisionRegistry__Fv
