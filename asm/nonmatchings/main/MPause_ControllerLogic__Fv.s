.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MPause_ControllerLogic__Fv, 0xE4

glabel MPause_ControllerLogic__Fv
    /* 8EEA0 8009E6A0 1480043C */  lui        $a0, %hi(Device_gPausePortIndex)
    /* 8EEA4 8009E6A4 94D78490 */  lbu        $a0, %lo(Device_gPausePortIndex)($a0)
    /* 8EEA8 8009E6A8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 8EEAC 8009E6AC 1400BFAF */  sw         $ra, 0x14($sp)
    /* 8EEB0 8009E6B0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 8EEB4 8009E6B4 2B200400 */  sltu       $a0, $zero, $a0
    /* 8EEB8 8009E6B8 A8BF030C */  jal        PadGetState
    /* 8EEBC 8009E6BC 00210400 */   sll       $a0, $a0, 4
    /* 8EEC0 8009E6C0 02000324 */  addiu      $v1, $zero, 0x2
    /* 8EEC4 8009E6C4 15004314 */  bne        $v0, $v1, .L8009E71C
    /* 8EEC8 8009E6C8 00000000 */   nop
    /* 8EECC 8009E6CC 1C0D908F */  lw         $s0, %gp_rel(gPauseMenuDefs)($gp)
    /* 8EED0 8009E6D0 AAA1020C */  jal        IsEnabled__10tPMenuItem
    /* 8EED4 8009E6D4 48020426 */   addiu     $a0, $s0, 0x248
    /* 8EED8 8009E6D8 06004010 */  beqz       $v0, .L8009E6F4
    /* 8EEDC 8009E6DC 01000324 */   addiu     $v1, $zero, 0x1
    /* 8EEE0 8009E6E0 4802028E */  lw         $v0, 0x248($s0)
    /* 8EEE4 8009E6E4 1480013C */  lui        $at, %hi(ChangedEnabling)
    /* 8EEE8 8009E6E8 ECD223AC */  sw         $v1, %lo(ChangedEnabling)($at)
    /* 8EEEC 8009E6EC 25104300 */  or         $v0, $v0, $v1
    /* 8EEF0 8009E6F0 480202AE */  sw         $v0, 0x248($s0)
  .L8009E6F4:
    /* 8EEF4 8009E6F4 1C0D908F */  lw         $s0, %gp_rel(gPauseMenuDefs)($gp)
    /* 8EEF8 8009E6F8 AAA1020C */  jal        IsEnabled__10tPMenuItem
    /* 8EEFC 8009E6FC 60020426 */   addiu     $a0, $s0, 0x260
    /* 8EF00 8009E700 1C004010 */  beqz       $v0, .L8009E774
    /* 8EF04 8009E704 01000324 */   addiu     $v1, $zero, 0x1
    /* 8EF08 8009E708 6002028E */  lw         $v0, 0x260($s0)
    /* 8EF0C 8009E70C 1480013C */  lui        $at, %hi(ChangedEnabling)
    /* 8EF10 8009E710 ECD223AC */  sw         $v1, %lo(ChangedEnabling)($at)
    /* 8EF14 8009E714 DC790208 */  j          .L8009E770
    /* 8EF18 8009E718 25104300 */   or        $v0, $v0, $v1
  .L8009E71C:
    /* 8EF1C 8009E71C 1C0D908F */  lw         $s0, %gp_rel(gPauseMenuDefs)($gp)
    /* 8EF20 8009E720 AFA1020C */  jal        IsDisabled__10tPMenuItem
    /* 8EF24 8009E724 48020426 */   addiu     $a0, $s0, 0x248
    /* 8EF28 8009E728 07004010 */  beqz       $v0, .L8009E748
    /* 8EF2C 8009E72C 01000224 */   addiu     $v0, $zero, 0x1
    /* 8EF30 8009E730 1480013C */  lui        $at, %hi(ChangedEnabling)
    /* 8EF34 8009E734 ECD222AC */  sw         $v0, %lo(ChangedEnabling)($at)
    /* 8EF38 8009E738 4802028E */  lw         $v0, 0x248($s0)
    /* 8EF3C 8009E73C FEFF0324 */  addiu      $v1, $zero, -0x2
    /* 8EF40 8009E740 24104300 */  and        $v0, $v0, $v1
    /* 8EF44 8009E744 480202AE */  sw         $v0, 0x248($s0)
  .L8009E748:
    /* 8EF48 8009E748 1C0D908F */  lw         $s0, %gp_rel(gPauseMenuDefs)($gp)
    /* 8EF4C 8009E74C AFA1020C */  jal        IsDisabled__10tPMenuItem
    /* 8EF50 8009E750 60020426 */   addiu     $a0, $s0, 0x260
    /* 8EF54 8009E754 07004010 */  beqz       $v0, .L8009E774
    /* 8EF58 8009E758 01000224 */   addiu     $v0, $zero, 0x1
    /* 8EF5C 8009E75C 1480013C */  lui        $at, %hi(ChangedEnabling)
    /* 8EF60 8009E760 ECD222AC */  sw         $v0, %lo(ChangedEnabling)($at)
    /* 8EF64 8009E764 6002028E */  lw         $v0, 0x260($s0)
    /* 8EF68 8009E768 FEFF0324 */  addiu      $v1, $zero, -0x2
    /* 8EF6C 8009E76C 24104300 */  and        $v0, $v0, $v1
  .L8009E770:
    /* 8EF70 8009E770 600202AE */  sw         $v0, 0x260($s0)
  .L8009E774:
    /* 8EF74 8009E774 1400BF8F */  lw         $ra, 0x14($sp)
    /* 8EF78 8009E778 1000B08F */  lw         $s0, 0x10($sp)
    /* 8EF7C 8009E77C 0800E003 */  jr         $ra
    /* 8EF80 8009E780 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MPause_ControllerLogic__Fv
