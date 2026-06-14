.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Hud_BustedOverlayOn__FiPcbs, 0x1B8

glabel Hud_BustedOverlayOn__FiPcbs
    /* C9E2C 800D962C D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* C9E30 800D9630 2000B4AF */  sw         $s4, 0x20($sp)
    /* C9E34 800D9634 21A08000 */  addu       $s4, $a0, $zero
    /* C9E38 800D9638 1800B2AF */  sw         $s2, 0x18($sp)
    /* C9E3C 800D963C 2190C000 */  addu       $s2, $a2, $zero
    /* C9E40 800D9640 00140700 */  sll        $v0, $a3, 16
    /* C9E44 800D9644 031C0200 */  sra        $v1, $v0, 16
    /* C9E48 800D9648 80300300 */  sll        $a2, $v1, 2
    /* C9E4C 800D964C 1480023C */  lui        $v0, %hi(StatsTimer)
    /* C9E50 800D9650 98D94224 */  addiu      $v0, $v0, %lo(StatsTimer)
    /* C9E54 800D9654 2110C200 */  addu       $v0, $a2, $v0
    /* C9E58 800D9658 2800BFAF */  sw         $ra, 0x28($sp)
    /* C9E5C 800D965C 2400B5AF */  sw         $s5, 0x24($sp)
    /* C9E60 800D9660 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* C9E64 800D9664 1400B1AF */  sw         $s1, 0x14($sp)
    /* C9E68 800D9668 1000B0AF */  sw         $s0, 0x10($sp)
    /* C9E6C 800D966C 000040AC */  sw         $zero, 0x0($v0)
    /* C9E70 800D9670 1480023C */  lui        $v0, %hi(Replay_ReplayMode)
    /* C9E74 800D9674 F4D3428C */  lw         $v0, %lo(Replay_ReplayMode)($v0)
    /* C9E78 800D9678 00000000 */  nop
    /* C9E7C 800D967C 02004228 */  slti       $v0, $v0, 0x2
    /* C9E80 800D9680 4F004010 */  beqz       $v0, .L800D97C0
    /* C9E84 800D9684 21A8E000 */   addu      $s5, $a3, $zero
    /* C9E88 800D9688 2130C300 */  addu       $a2, $a2, $v1
    /* C9E8C 800D968C 40180300 */  sll        $v1, $v1, 1
    /* C9E90 800D9690 1480023C */  lui        $v0, %hi(Hud_NextPerp)
    /* C9E94 800D9694 94D94224 */  addiu      $v0, $v0, %lo(Hud_NextPerp)
    /* C9E98 800D9698 21806200 */  addu       $s0, $v1, $v0
    /* C9E9C 800D969C 40890600 */  sll        $s1, $a2, 5
    /* C9EA0 800D96A0 1280023C */  lui        $v0, %hi(BTCPerpInfo)
    /* C9EA4 800D96A4 C00B5324 */  addiu      $s3, $v0, %lo(BTCPerpInfo)
    /* C9EA8 800D96A8 00000486 */  lh         $a0, 0x0($s0)
    /* C9EAC 800D96AC E813828F */  lw         $v0, %gp_rel(BTC_Countdown)($gp)
    /* C9EB0 800D96B0 00210400 */  sll        $a0, $a0, 4
    /* C9EB4 800D96B4 21209300 */  addu       $a0, $a0, $s3
    /* C9EB8 800D96B8 EC1382AF */  sw         $v0, %gp_rel(FinalBTC_Countdown)($gp)
    /* C9EBC 800D96BC 2F91030C */  jal        sprintf
    /* C9EC0 800D96C0 21202402 */   addu      $a0, $s1, $a0
    /* C9EC4 800D96C4 12004012 */  beqz       $s2, .L800D9710
    /* C9EC8 800D96C8 01000324 */   addiu     $v1, $zero, 0x1
    /* C9ECC 800D96CC 00000286 */  lh         $v0, 0x0($s0)
    /* C9ED0 800D96D0 00000000 */  nop
    /* C9ED4 800D96D4 00110200 */  sll        $v0, $v0, 4
    /* C9ED8 800D96D8 21105100 */  addu       $v0, $v0, $s1
    /* C9EDC 800D96DC 21105300 */  addu       $v0, $v0, $s3
    /* C9EE0 800D96E0 0C0043AC */  sw         $v1, 0xC($v0)
    /* C9EE4 800D96E4 00000286 */  lh         $v0, 0x0($s0)
    /* C9EE8 800D96E8 00000000 */  nop
    /* C9EEC 800D96EC 00110200 */  sll        $v0, $v0, 4
    /* C9EF0 800D96F0 21105100 */  addu       $v0, $v0, $s1
    /* C9EF4 800D96F4 21105300 */  addu       $v0, $v0, $s3
    /* C9EF8 800D96F8 080054AC */  sw         $s4, 0x8($v0)
    /* C9EFC 800D96FC 00000296 */  lhu        $v0, 0x0($s0)
    /* C9F00 800D9700 00000000 */  nop
    /* C9F04 800D9704 21104300 */  addu       $v0, $v0, $v1
    /* C9F08 800D9708 ED650308 */  j          .L800D97B4
    /* C9F0C 800D970C 000002A6 */   sh        $v0, 0x0($s0)
  .L800D9710:
    /* C9F10 800D9710 21900000 */  addu       $s2, $zero, $zero
    /* C9F14 800D9714 21884002 */  addu       $s1, $s2, $zero
  .L800D9718:
    /* C9F18 800D9718 40181200 */  sll        $v1, $s2, 1
    /* C9F1C 800D971C 1480023C */  lui        $v0, %hi(Hud_NextPerp)
    /* C9F20 800D9720 94D94224 */  addiu      $v0, $v0, %lo(Hud_NextPerp)
    /* C9F24 800D9724 21806200 */  addu       $s0, $v1, $v0
    /* C9F28 800D9728 00000386 */  lh         $v1, 0x0($s0)
    /* C9F2C 800D972C 00000000 */  nop
    /* C9F30 800D9730 08006010 */  beqz       $v1, .L800D9754
    /* C9F34 800D9734 FFFF6224 */   addiu     $v0, $v1, -0x1
    /* C9F38 800D9738 00110200 */  sll        $v0, $v0, 4
    /* C9F3C 800D973C 21105100 */  addu       $v0, $v0, $s1
    /* C9F40 800D9740 21105300 */  addu       $v0, $v0, $s3
    /* C9F44 800D9744 0C00428C */  lw         $v0, 0xC($v0)
    /* C9F48 800D9748 00000000 */  nop
    /* C9F4C 800D974C 15004010 */  beqz       $v0, .L800D97A4
    /* C9F50 800D9750 00000000 */   nop
  .L800D9754:
    /* C9F54 800D9754 00110300 */  sll        $v0, $v1, 4
    /* C9F58 800D9758 21105100 */  addu       $v0, $v0, $s1
    /* C9F5C 800D975C 21105300 */  addu       $v0, $v0, $s3
    /* C9F60 800D9760 0C0040AC */  sw         $zero, 0xC($v0)
    /* C9F64 800D9764 00000286 */  lh         $v0, 0x0($s0)
    /* C9F68 800D9768 1480053C */  lui        $a1, %hi(D_8013E850)
    /* C9F6C 800D976C 00110200 */  sll        $v0, $v0, 4
    /* C9F70 800D9770 21105100 */  addu       $v0, $v0, $s1
    /* C9F74 800D9774 21105300 */  addu       $v0, $v0, $s3
    /* C9F78 800D9778 080040AC */  sw         $zero, 0x8($v0)
    /* C9F7C 800D977C 00000486 */  lh         $a0, 0x0($s0)
    /* C9F80 800D9780 50E8A524 */  addiu      $a1, $a1, %lo(D_8013E850)
    /* C9F84 800D9784 00210400 */  sll        $a0, $a0, 4
    /* C9F88 800D9788 21209300 */  addu       $a0, $a0, $s3
    /* C9F8C 800D978C 2F91030C */  jal        sprintf
    /* C9F90 800D9790 21202402 */   addu      $a0, $s1, $a0
    /* C9F94 800D9794 00000296 */  lhu        $v0, 0x0($s0)
    /* C9F98 800D9798 00000000 */  nop
    /* C9F9C 800D979C 01004224 */  addiu      $v0, $v0, 0x1
    /* C9FA0 800D97A0 000002A6 */  sh         $v0, 0x0($s0)
  .L800D97A4:
    /* C9FA4 800D97A4 01005226 */  addiu      $s2, $s2, 0x1
    /* C9FA8 800D97A8 0200422A */  slti       $v0, $s2, 0x2
    /* C9FAC 800D97AC DAFF4014 */  bnez       $v0, .L800D9718
    /* C9FB0 800D97B0 A0003126 */   addiu     $s1, $s1, 0xA0
  .L800D97B4:
    /* C9FB4 800D97B4 01000224 */  addiu      $v0, $zero, 0x1
    /* C9FB8 800D97B8 DC1382AF */  sw         $v0, %gp_rel(HudBustedOverlay)($gp)
    /* C9FBC 800D97BC F81395A7 */  sh         $s5, %gp_rel(HudBustedOverlayPlayer)($gp)
  .L800D97C0:
    /* C9FC0 800D97C0 2800BF8F */  lw         $ra, 0x28($sp)
    /* C9FC4 800D97C4 2400B58F */  lw         $s5, 0x24($sp)
    /* C9FC8 800D97C8 2000B48F */  lw         $s4, 0x20($sp)
    /* C9FCC 800D97CC 1C00B38F */  lw         $s3, 0x1C($sp)
    /* C9FD0 800D97D0 1800B28F */  lw         $s2, 0x18($sp)
    /* C9FD4 800D97D4 1400B18F */  lw         $s1, 0x14($sp)
    /* C9FD8 800D97D8 1000B08F */  lw         $s0, 0x10($sp)
    /* C9FDC 800D97DC 0800E003 */  jr         $ra
    /* C9FE0 800D97E0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel Hud_BustedOverlayOn__FiPcbs
