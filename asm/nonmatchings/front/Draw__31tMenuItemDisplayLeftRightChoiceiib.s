.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__31tMenuItemDisplayLeftRightChoiceiib, 0xF0

glabel Draw__31tMenuItemDisplayLeftRightChoiceiib
    /* EA30 8001E230 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* EA34 8001E234 2400B3AF */  sw         $s3, 0x24($sp)
    /* EA38 8001E238 21988000 */  addu       $s3, $a0, $zero
    /* EA3C 8001E23C 1800B0AF */  sw         $s0, 0x18($sp)
    /* EA40 8001E240 2180A000 */  addu       $s0, $a1, $zero
    /* EA44 8001E244 2000B2AF */  sw         $s2, 0x20($sp)
    /* EA48 8001E248 2800BFAF */  sw         $ra, 0x28($sp)
    /* EA4C 8001E24C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* EA50 8001E250 20006386 */  lh         $v1, 0x20($s3)
    /* EA54 8001E254 80000224 */  addiu      $v0, $zero, 0x80
    /* EA58 8001E258 2A006210 */  beq        $v1, $v0, .L8001E304
    /* EA5C 8001E25C 2190C000 */   addu      $s2, $a2, $zero
    /* EA60 8001E260 0400648E */  lw         $a0, 0x4($s3)
    /* EA64 8001E264 A4E4020C */  jal        TextSys_WordX__Fi
    /* EA68 8001E268 00000000 */   nop
    /* EA6C 8001E26C 0400648E */  lw         $a0, 0x4($s3)
    /* EA70 8001E270 ACE4020C */  jal        TextSys_WordY__Fi
    /* EA74 8001E274 21885000 */   addu      $s1, $v0, $s0
    /* EA78 8001E278 06000424 */  addiu      $a0, $zero, 0x6
    /* EA7C 8001E27C 08006586 */  lh         $a1, 0x8($s3)
    /* EA80 8001E280 20006686 */  lh         $a2, 0x20($s3)
    /* EA84 8001E284 542E010C */  jal        CalcTextFadeSelToHi__F13tMenuTextTypess
    /* EA88 8001E288 21805200 */   addu      $s0, $v0, $s2
    /* EA8C 8001E28C 21206002 */  addu       $a0, $s3, $zero
    /* EA90 8001E290 002C1100 */  sll        $a1, $s1, 16
    /* EA94 8001E294 032C0500 */  sra        $a1, $a1, 16
    /* EA98 8001E298 00841000 */  sll        $s0, $s0, 16
    /* EA9C 8001E29C 03841000 */  sra        $s0, $s0, 16
    /* EAA0 8001E2A0 21300002 */  addu       $a2, $s0, $zero
    /* EAA4 8001E2A4 4F78000C */  jal        MyLeftRightDraw__22tMenuItemLeftRightFadeii
    /* EAA8 8001E2A8 21904000 */   addu      $s2, $v0, $zero
    /* EAAC 8001E2AC 1C00668E */  lw         $a2, 0x1C($s3)
    /* EAB0 8001E2B0 0580023C */  lui        $v0, %hi(gMenu_SubMenuPlayer)
    /* EAB4 8001E2B4 0C00C38C */  lw         $v1, 0xC($a2)
    /* EAB8 8001E2B8 C017458C */  lw         $a1, %lo(gMenu_SubMenuPlayer)($v0)
    /* EABC 8001E2BC 18006484 */  lh         $a0, 0x18($v1)
    /* EAC0 8001E2C0 1C00628C */  lw         $v0, 0x1C($v1)
    /* EAC4 8001E2C4 00000000 */  nop
    /* EAC8 8001E2C8 09F84000 */  jalr       $v0
    /* EACC 8001E2CC 2120C400 */   addu      $a0, $a2, $a0
    /* EAD0 8001E2D0 00140200 */  sll        $v0, $v0, 16
    /* EAD4 8001E2D4 94E4020C */  jal        TextSys_Word__Fi
    /* EAD8 8001E2D8 03240200 */   sra       $a0, $v0, 16
    /* EADC 8001E2DC 21204000 */  addu       $a0, $v0, $zero
    /* EAE0 8001E2E0 73003126 */  addiu      $s1, $s1, 0x73
    /* EAE4 8001E2E4 008C1100 */  sll        $s1, $s1, 16
    /* EAE8 8001E2E8 032C1100 */  sra        $a1, $s1, 16
    /* EAEC 8001E2EC 21300002 */  addu       $a2, $s0, $zero
    /* EAF0 8001E2F0 02000224 */  addiu      $v0, $zero, 0x2
    /* EAF4 8001E2F4 21384002 */  addu       $a3, $s2, $zero
    /* EAF8 8001E2F8 1000A0AF */  sw         $zero, 0x10($sp)
    /* EAFC 8001E2FC 5383000C */  jal        FETextRender_FullTextRGB__FPcssics
    /* EB00 8001E300 1400A2AF */   sw        $v0, 0x14($sp)
  .L8001E304:
    /* EB04 8001E304 2800BF8F */  lw         $ra, 0x28($sp)
    /* EB08 8001E308 2400B38F */  lw         $s3, 0x24($sp)
    /* EB0C 8001E30C 2000B28F */  lw         $s2, 0x20($sp)
    /* EB10 8001E310 1C00B18F */  lw         $s1, 0x1C($sp)
    /* EB14 8001E314 1800B08F */  lw         $s0, 0x18($sp)
    /* EB18 8001E318 0800E003 */  jr         $ra
    /* EB1C 8001E31C 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Draw__31tMenuItemDisplayLeftRightChoiceiib
