.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__29tMenuItemOnOffLeftRightChoiceiib, 0x178

glabel Draw__29tMenuItemOnOffLeftRightChoiceiib
    /* EB84 8001E384 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* EB88 8001E388 2800B2AF */  sw         $s2, 0x28($sp)
    /* EB8C 8001E38C 21908000 */  addu       $s2, $a0, $zero
    /* EB90 8001E390 2000B0AF */  sw         $s0, 0x20($sp)
    /* EB94 8001E394 2180A000 */  addu       $s0, $a1, $zero
    /* EB98 8001E398 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* EB9C 8001E39C 3000BFAF */  sw         $ra, 0x30($sp)
    /* EBA0 8001E3A0 2400B1AF */  sw         $s1, 0x24($sp)
    /* EBA4 8001E3A4 20004386 */  lh         $v1, 0x20($s2)
    /* EBA8 8001E3A8 80000224 */  addiu      $v0, $zero, 0x80
    /* EBAC 8001E3AC 4C006210 */  beq        $v1, $v0, .L8001E4E0
    /* EBB0 8001E3B0 2198C000 */   addu      $s3, $a2, $zero
    /* EBB4 8001E3B4 1C00438E */  lw         $v1, 0x1C($s2)
    /* EBB8 8001E3B8 00000000 */  nop
    /* EBBC 8001E3BC 0C00628C */  lw         $v0, 0xC($v1)
    /* EBC0 8001E3C0 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* EBC4 8001E3C4 10004484 */  lh         $a0, 0x10($v0)
    /* EBC8 8001E3C8 1400428C */  lw         $v0, 0x14($v0)
    /* EBCC 8001E3CC 00000000 */  nop
    /* EBD0 8001E3D0 09F84000 */  jalr       $v0
    /* EBD4 8001E3D4 21206400 */   addu      $a0, $v1, $a0
    /* EBD8 8001E3D8 FF004230 */  andi       $v0, $v0, 0xFF
    /* EBDC 8001E3DC 04004010 */  beqz       $v0, .L8001E3F0
    /* EBE0 8001E3E0 00000000 */   nop
    /* EBE4 8001E3E4 2C004296 */  lhu        $v0, 0x2C($s2)
    /* EBE8 8001E3E8 FF780008 */  j          .L8001E3FC
    /* EBEC 8001E3EC 20004224 */   addiu     $v0, $v0, 0x20
  .L8001E3F0:
    /* EBF0 8001E3F0 2C004296 */  lhu        $v0, 0x2C($s2)
    /* EBF4 8001E3F4 00000000 */  nop
    /* EBF8 8001E3F8 E0FF4224 */  addiu      $v0, $v0, -0x20
  .L8001E3FC:
    /* EBFC 8001E3FC 2C0042A6 */  sh         $v0, 0x2C($s2)
    /* EC00 8001E400 2C004286 */  lh         $v0, 0x2C($s2)
    /* EC04 8001E404 00000000 */  nop
    /* EC08 8001E408 81004228 */  slti       $v0, $v0, 0x81
    /* EC0C 8001E40C 02004014 */  bnez       $v0, .L8001E418
    /* EC10 8001E410 80000224 */   addiu     $v0, $zero, 0x80
    /* EC14 8001E414 2C0042A6 */  sh         $v0, 0x2C($s2)
  .L8001E418:
    /* EC18 8001E418 2C004286 */  lh         $v0, 0x2C($s2)
    /* EC1C 8001E41C 00000000 */  nop
    /* EC20 8001E420 02004104 */  bgez       $v0, .L8001E42C
    /* EC24 8001E424 00000000 */   nop
    /* EC28 8001E428 2C0040A6 */  sh         $zero, 0x2C($s2)
  .L8001E42C:
    /* EC2C 8001E42C 0400448E */  lw         $a0, 0x4($s2)
    /* EC30 8001E430 A4E4020C */  jal        TextSys_WordX__Fi
    /* EC34 8001E434 00000000 */   nop
    /* EC38 8001E438 0400448E */  lw         $a0, 0x4($s2)
    /* EC3C 8001E43C ACE4020C */  jal        TextSys_WordY__Fi
    /* EC40 8001E440 21885000 */   addu      $s1, $v0, $s0
    /* EC44 8001E444 06000424 */  addiu      $a0, $zero, 0x6
    /* EC48 8001E448 2C004586 */  lh         $a1, 0x2C($s2)
    /* EC4C 8001E44C 08004686 */  lh         $a2, 0x8($s2)
    /* EC50 8001E450 20004786 */  lh         $a3, 0x20($s2)
    /* EC54 8001E454 1800A327 */  addiu      $v1, $sp, 0x18
    /* EC58 8001E458 1000A3AF */  sw         $v1, 0x10($sp)
    /* EC5C 8001E45C 1C00A327 */  addiu      $v1, $sp, 0x1C
    /* EC60 8001E460 21805300 */  addu       $s0, $v0, $s3
    /* EC64 8001E464 752E010C */  jal        CalcOnOffFade__F13tMenuTextTypesssRiT4
    /* EC68 8001E468 1400A3AF */   sw        $v1, 0x14($sp)
    /* EC6C 8001E46C 21204002 */  addu       $a0, $s2, $zero
    /* EC70 8001E470 002C1100 */  sll        $a1, $s1, 16
    /* EC74 8001E474 032C0500 */  sra        $a1, $a1, 16
    /* EC78 8001E478 00841000 */  sll        $s0, $s0, 16
    /* EC7C 8001E47C 03841000 */  sra        $s0, $s0, 16
    /* EC80 8001E480 4F78000C */  jal        MyLeftRightDraw__22tMenuItemLeftRightFadeii
    /* EC84 8001E484 21300002 */   addu      $a2, $s0, $zero
    /* EC88 8001E488 94E4020C */  jal        TextSys_Word__Fi
    /* EC8C 8001E48C 66000424 */   addiu     $a0, $zero, 0x66
    /* EC90 8001E490 21204000 */  addu       $a0, $v0, $zero
    /* EC94 8001E494 37002526 */  addiu      $a1, $s1, 0x37
    /* EC98 8001E498 002C0500 */  sll        $a1, $a1, 16
    /* EC9C 8001E49C 032C0500 */  sra        $a1, $a1, 16
    /* ECA0 8001E4A0 1800A78F */  lw         $a3, 0x18($sp)
    /* ECA4 8001E4A4 21300002 */  addu       $a2, $s0, $zero
    /* ECA8 8001E4A8 1000A0AF */  sw         $zero, 0x10($sp)
    /* ECAC 8001E4AC 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* ECB0 8001E4B0 1400A0AF */   sw        $zero, 0x14($sp)
    /* ECB4 8001E4B4 94E4020C */  jal        TextSys_Word__Fi
    /* ECB8 8001E4B8 67000424 */   addiu     $a0, $zero, 0x67
    /* ECBC 8001E4BC 21204000 */  addu       $a0, $v0, $zero
    /* ECC0 8001E4C0 9E003126 */  addiu      $s1, $s1, 0x9E
    /* ECC4 8001E4C4 008C1100 */  sll        $s1, $s1, 16
    /* ECC8 8001E4C8 032C1100 */  sra        $a1, $s1, 16
    /* ECCC 8001E4CC 1C00A78F */  lw         $a3, 0x1C($sp)
    /* ECD0 8001E4D0 21300002 */  addu       $a2, $s0, $zero
    /* ECD4 8001E4D4 1000A0AF */  sw         $zero, 0x10($sp)
    /* ECD8 8001E4D8 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* ECDC 8001E4DC 1400A0AF */   sw        $zero, 0x14($sp)
  .L8001E4E0:
    /* ECE0 8001E4E0 3000BF8F */  lw         $ra, 0x30($sp)
    /* ECE4 8001E4E4 2C00B38F */  lw         $s3, 0x2C($sp)
    /* ECE8 8001E4E8 2800B28F */  lw         $s2, 0x28($sp)
    /* ECEC 8001E4EC 2400B18F */  lw         $s1, 0x24($sp)
    /* ECF0 8001E4F0 2000B08F */  lw         $s0, 0x20($sp)
    /* ECF4 8001E4F4 0800E003 */  jr         $ra
    /* ECF8 8001E4F8 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel Draw__29tMenuItemOnOffLeftRightChoiceiib
