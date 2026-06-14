.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_RenderPauseBox__Fiiii, 0x188

glabel Hud_RenderPauseBox__Fiiii
    /* C96D0 800D8ED0 B8FFBD27 */  addiu      $sp, $sp, -0x48
    /* C96D4 800D8ED4 3000B4AF */  sw         $s4, 0x30($sp)
    /* C96D8 800D8ED8 21A08000 */  addu       $s4, $a0, $zero
    /* C96DC 800D8EDC 3400B5AF */  sw         $s5, 0x34($sp)
    /* C96E0 800D8EE0 21A8A000 */  addu       $s5, $a1, $zero
    /* C96E4 800D8EE4 3800B6AF */  sw         $s6, 0x38($sp)
    /* C96E8 800D8EE8 21B0C000 */  addu       $s6, $a2, $zero
    /* C96EC 800D8EEC 3C00B7AF */  sw         $s7, 0x3C($sp)
    /* C96F0 800D8EF0 21B8E000 */  addu       $s7, $a3, $zero
    /* C96F4 800D8EF4 2800B2AF */  sw         $s2, 0x28($sp)
    /* C96F8 800D8EF8 1180123C */  lui        $s2, %hi(HudPmx_gShapes)
    /* C96FC 800D8EFC 980C5226 */  addiu      $s2, $s2, %lo(HudPmx_gShapes)
    /* C9700 800D8F00 18014426 */  addiu      $a0, $s2, 0x118
    /* C9704 800D8F04 4000BEAF */  sw         $fp, 0x40($sp)
    /* C9708 800D8F08 FEFF9E26 */  addiu      $fp, $s4, -0x2
    /* C970C 800D8F0C 2128C003 */  addu       $a1, $fp, $zero
    /* C9710 800D8F10 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* C9714 800D8F14 0A00B326 */  addiu      $s3, $s5, 0xA
    /* C9718 800D8F18 21306002 */  addu       $a2, $s3, $zero
    /* C971C 800D8F1C 4400BFAF */  sw         $ra, 0x44($sp)
    /* C9720 800D8F20 2400B1AF */  sw         $s1, 0x24($sp)
    /* C9724 800D8F24 2000B0AF */  sw         $s0, 0x20($sp)
    /* C9728 800D8F28 64015096 */  lhu        $s0, 0x164($s2)
    /* C972C 800D8F2C 66015196 */  lhu        $s1, 0x166($s2)
    /* C9730 800D8F30 3D4A030C */  jal        Hud_FBuildFT4__FP13HudPmx_tShapeiiUl
    /* C9734 800D8F34 21380000 */   addu      $a3, $zero, $zero
    /* C9738 800D8F38 2C014426 */  addiu      $a0, $s2, 0x12C
    /* C973C 800D8F3C 21306002 */  addu       $a2, $s3, $zero
    /* C9740 800D8F40 21380000 */  addu       $a3, $zero, $zero
    /* C9744 800D8F44 21989602 */  addu       $s3, $s4, $s6
    /* C9748 800D8F48 00841000 */  sll        $s0, $s0, 16
    /* C974C 800D8F4C 03841000 */  sra        $s0, $s0, 16
    /* C9750 800D8F50 23987002 */  subu       $s3, $s3, $s0
    /* C9754 800D8F54 3D4A030C */  jal        Hud_FBuildFT4__FP13HudPmx_tShapeiiUl
    /* C9758 800D8F58 21286002 */   addu      $a1, $s3, $zero
    /* C975C 800D8F5C 40014426 */  addiu      $a0, $s2, 0x140
    /* C9760 800D8F60 2128C003 */  addu       $a1, $fp, $zero
    /* C9764 800D8F64 2180B702 */  addu       $s0, $s5, $s7
    /* C9768 800D8F68 008C1100 */  sll        $s1, $s1, 16
    /* C976C 800D8F6C 038C1100 */  sra        $s1, $s1, 16
    /* C9770 800D8F70 23881102 */  subu       $s1, $s0, $s1
    /* C9774 800D8F74 21302002 */  addu       $a2, $s1, $zero
    /* C9778 800D8F78 3D4A030C */  jal        Hud_FBuildFT4__FP13HudPmx_tShapeiiUl
    /* C977C 800D8F7C 21380000 */   addu      $a3, $zero, $zero
    /* C9780 800D8F80 54014426 */  addiu      $a0, $s2, 0x154
    /* C9784 800D8F84 21286002 */  addu       $a1, $s3, $zero
    /* C9788 800D8F88 21302002 */  addu       $a2, $s1, $zero
    /* C978C 800D8F8C 3D4A030C */  jal        Hud_FBuildFT4__FP13HudPmx_tShapeiiUl
    /* C9790 800D8F90 21380000 */   addu      $a3, $zero, $zero
    /* C9794 800D8F94 21200000 */  addu       $a0, $zero, $zero
    /* C9798 800D8F98 21288002 */  addu       $a1, $s4, $zero
    /* C979C 800D8F9C FEFF0626 */  addiu      $a2, $s0, -0x2
    /* C97A0 800D8FA0 2138C002 */  addu       $a3, $s6, $zero
    /* C97A4 800D8FA4 02000224 */  addiu      $v0, $zero, 0x2
    /* C97A8 800D8FA8 1000A2AF */  sw         $v0, 0x10($sp)
    /* C97AC 800D8FAC 1400A0AF */  sw         $zero, 0x14($sp)
    /* C97B0 800D8FB0 1800A0AF */  sw         $zero, 0x18($sp)
    /* C97B4 800D8FB4 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C97B8 800D8FB8 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* C97BC 800D8FBC 21208002 */  addu       $a0, $s4, $zero
    /* C97C0 800D8FC0 2128A002 */  addu       $a1, $s5, $zero
    /* C97C4 800D8FC4 2130C002 */  addu       $a2, $s6, $zero
    /* C97C8 800D8FC8 AF5E030C */  jal        Hud_BlackThinBox__Fiiii
    /* C97CC 800D8FCC 2138E002 */   addu      $a3, $s7, $zero
    /* C97D0 800D8FD0 21200000 */  addu       $a0, $zero, $zero
    /* C97D4 800D8FD4 21288002 */  addu       $a1, $s4, $zero
    /* C97D8 800D8FD8 2130A002 */  addu       $a2, $s5, $zero
    /* C97DC 800D8FDC 2138C002 */  addu       $a3, $s6, $zero
    /* C97E0 800D8FE0 0C000224 */  addiu      $v0, $zero, 0xC
    /* C97E4 800D8FE4 1000A2AF */  sw         $v0, 0x10($sp)
    /* C97E8 800D8FE8 1400A0AF */  sw         $zero, 0x14($sp)
    /* C97EC 800D8FEC 1800A0AF */  sw         $zero, 0x18($sp)
    /* C97F0 800D8FF0 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C97F4 800D8FF4 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* C97F8 800D8FF8 4600023C */  lui        $v0, (0x461414 >> 16)
    /* C97FC 800D8FFC 14144234 */  ori        $v0, $v0, (0x461414 & 0xFFFF)
    /* C9800 800D9000 01000424 */  addiu      $a0, $zero, 0x1
    /* C9804 800D9004 21288002 */  addu       $a1, $s4, $zero
    /* C9808 800D9008 0C00A626 */  addiu      $a2, $s5, 0xC
    /* C980C 800D900C 2138C002 */  addu       $a3, $s6, $zero
    /* C9810 800D9010 F4FFF726 */  addiu      $s7, $s7, -0xC
    /* C9814 800D9014 1000B7AF */  sw         $s7, 0x10($sp)
    /* C9818 800D9018 1400A2AF */  sw         $v0, 0x14($sp)
    /* C981C 800D901C 1800A0AF */  sw         $zero, 0x18($sp)
    /* C9820 800D9020 614A030C */  jal        Hud_FBuildF4__FiiiiiUlcc
    /* C9824 800D9024 1C00A0AF */   sw        $zero, 0x1C($sp)
    /* C9828 800D9028 4400BF8F */  lw         $ra, 0x44($sp)
    /* C982C 800D902C 4000BE8F */  lw         $fp, 0x40($sp)
    /* C9830 800D9030 3C00B78F */  lw         $s7, 0x3C($sp)
    /* C9834 800D9034 3800B68F */  lw         $s6, 0x38($sp)
    /* C9838 800D9038 3400B58F */  lw         $s5, 0x34($sp)
    /* C983C 800D903C 3000B48F */  lw         $s4, 0x30($sp)
    /* C9840 800D9040 2C00B38F */  lw         $s3, 0x2C($sp)
    /* C9844 800D9044 2800B28F */  lw         $s2, 0x28($sp)
    /* C9848 800D9048 2400B18F */  lw         $s1, 0x24($sp)
    /* C984C 800D904C 2000B08F */  lw         $s0, 0x20($sp)
    /* C9850 800D9050 0800E003 */  jr         $ra
    /* C9854 800D9054 4800BD27 */   addiu     $sp, $sp, 0x48
endlabel Hud_RenderPauseBox__Fiiii
