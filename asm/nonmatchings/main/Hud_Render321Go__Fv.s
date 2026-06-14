.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_Render321Go__Fv, 0x14C

glabel Hud_Render321Go__Fv
    /* C8664 800D7E64 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* C8668 800D7E68 1C14848F */  lw         $a0, %gp_rel(Hud_gStatsView)($gp)
    /* C866C 800D7E6C 1180023C */  lui        $v0, %hi(gCView)
    /* C8670 800D7E70 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* C8674 800D7E74 2800B4AF */  sw         $s4, 0x28($sp)
    /* C8678 800D7E78 2400B3AF */  sw         $s3, 0x24($sp)
    /* C867C 800D7E7C 2000B2AF */  sw         $s2, 0x20($sp)
    /* C8680 800D7E80 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* C8684 800D7E84 1800B0AF */  sw         $s0, 0x18($sp)
    /* C8688 800D7E88 18F8020C */  jal        Draw_StartRenderingView__Fi
    /* C868C 800D7E8C 7C6F44AC */   sw        $a0, %lo(gCView)($v0)
    /* C8690 800D7E90 B818828F */  lw         $v0, %gp_rel(D_8013DE04)($gp)
    /* C8694 800D7E94 D1138383 */  lb         $v1, %gp_rel(D_8013D91D)($gp)
    /* C8698 800D7E98 1480043C */  lui        $a0, %hi(countdown)
    /* C869C 800D7E9C 3CC68490 */  lbu        $a0, %lo(countdown)($a0)
    /* C86A0 800D7EA0 46005384 */  lh         $s3, 0x46($v0)
    /* C86A4 800D7EA4 05006410 */  beq        $v1, $a0, .L800D7EBC
    /* C86A8 800D7EA8 A0001424 */   addiu     $s4, $zero, 0xA0
    /* C86AC 800D7EAC 1480023C */  lui        $v0, %hi(ticks)
    /* C86B0 800D7EB0 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* C86B4 800D7EB4 D11384A3 */  sb         $a0, %gp_rel(D_8013D91D)($gp)
    /* C86B8 800D7EB8 B41882AF */  sw         $v0, %gp_rel(D_8013DE00)($gp)
  .L800D7EBC:
    /* C86BC 800D7EBC 1480023C */  lui        $v0, %hi(ticks)
    /* C86C0 800D7EC0 ACDC428C */  lw         $v0, %lo(ticks)($v0)
    /* C86C4 800D7EC4 B418838F */  lw         $v1, %gp_rel(D_8013DE00)($gp)
    /* C86C8 800D7EC8 00000000 */  nop
    /* C86CC 800D7ECC 23184300 */  subu       $v1, $v0, $v1
    /* C86D0 800D7ED0 04000224 */  addiu      $v0, $zero, 0x4
    /* C86D4 800D7ED4 08008214 */  bne        $a0, $v0, .L800D7EF8
    /* C86D8 800D7ED8 6400622C */   sltiu     $v0, $v1, 0x64
    /* C86DC 800D7EDC 0D004010 */  beqz       $v0, .L800D7F14
    /* C86E0 800D7EE0 80100300 */   sll       $v0, $v1, 2
    /* C86E4 800D7EE4 21104300 */  addu       $v0, $v0, $v1
    /* C86E8 800D7EE8 00110200 */  sll        $v0, $v0, 4
    /* C86EC 800D7EEC 401F0324 */  addiu      $v1, $zero, 0x1F40
    /* C86F0 800D7EF0 C65F0308 */  j          .L800D7F18
    /* C86F4 800D7EF4 23886200 */   subu      $s1, $v1, $v0
  .L800D7EF8:
    /* C86F8 800D7EF8 06004010 */  beqz       $v0, .L800D7F14
    /* C86FC 800D7EFC 00110300 */   sll       $v0, $v1, 4
    /* C8700 800D7F00 23104300 */  subu       $v0, $v0, $v1
    /* C8704 800D7F04 80100200 */  sll        $v0, $v0, 2
    /* C8708 800D7F08 70170324 */  addiu      $v1, $zero, 0x1770
    /* C870C 800D7F0C C65F0308 */  j          .L800D7F18
    /* C8710 800D7F10 23886200 */   subu      $s1, $v1, $v0
  .L800D7F14:
    /* C8714 800D7F14 21880000 */  addu       $s1, $zero, $zero
  .L800D7F18:
    /* C8718 800D7F18 1480033C */  lui        $v1, %hi(countdown)
    /* C871C 800D7F1C 3CC66390 */  lbu        $v1, %lo(countdown)($v1)
    /* C8720 800D7F20 04000224 */  addiu      $v0, $zero, 0x4
    /* C8724 800D7F24 17006210 */  beq        $v1, $v0, .L800D7F84
    /* C8728 800D7F28 23904300 */   subu      $s2, $v0, $v1
    /* C872C 800D7F2C A8FF8426 */  addiu      $a0, $s4, -0x58
    /* C8730 800D7F30 21286002 */  addu       $a1, $s3, $zero
    /* C8734 800D7F34 21304002 */  addu       $a2, $s2, $zero
    /* C8738 800D7F38 21382002 */  addu       $a3, $s1, $zero
    /* C873C 800D7F3C 01001024 */  addiu      $s0, $zero, 0x1
    /* C8740 800D7F40 1000B0AF */  sw         $s0, 0x10($sp)
    /* C8744 800D7F44 2A5F030C */  jal        Hud_Draw321Num__Fiiiiii
    /* C8748 800D7F48 1400A0AF */   sw        $zero, 0x14($sp)
    /* C874C 800D7F4C E7FF8426 */  addiu      $a0, $s4, -0x19
    /* C8750 800D7F50 21286002 */  addu       $a1, $s3, $zero
    /* C8754 800D7F54 21304002 */  addu       $a2, $s2, $zero
    /* C8758 800D7F58 21382002 */  addu       $a3, $s1, $zero
    /* C875C 800D7F5C 1000A0AF */  sw         $zero, 0x10($sp)
    /* C8760 800D7F60 2A5F030C */  jal        Hud_Draw321Num__Fiiiiii
    /* C8764 800D7F64 1400A0AF */   sw        $zero, 0x14($sp)
    /* C8768 800D7F68 26008426 */  addiu      $a0, $s4, 0x26
    /* C876C 800D7F6C 21286002 */  addu       $a1, $s3, $zero
    /* C8770 800D7F70 21304002 */  addu       $a2, $s2, $zero
    /* C8774 800D7F74 21382002 */  addu       $a3, $s1, $zero
    /* C8778 800D7F78 1000A0AF */  sw         $zero, 0x10($sp)
    /* C877C 800D7F7C 2A5F030C */  jal        Hud_Draw321Num__Fiiiiii
    /* C8780 800D7F80 1400B0AF */   sw        $s0, 0x14($sp)
  .L800D7F84:
    /* C8784 800D7F84 1C14848F */  lw         $a0, %gp_rel(Hud_gStatsView)($gp)
    /* C8788 800D7F88 46F8020C */  jal        Draw_StopRenderingView__Fi
    /* C878C 800D7F8C 00000000 */   nop
    /* C8790 800D7F90 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* C8794 800D7F94 2800B48F */  lw         $s4, 0x28($sp)
    /* C8798 800D7F98 2400B38F */  lw         $s3, 0x24($sp)
    /* C879C 800D7F9C 2000B28F */  lw         $s2, 0x20($sp)
    /* C87A0 800D7FA0 1C00B18F */  lw         $s1, 0x1C($sp)
    /* C87A4 800D7FA4 1800B08F */  lw         $s0, 0x18($sp)
    /* C87A8 800D7FA8 0800E003 */  jr         $ra
    /* C87AC 800D7FAC 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Hud_Render321Go__Fv
