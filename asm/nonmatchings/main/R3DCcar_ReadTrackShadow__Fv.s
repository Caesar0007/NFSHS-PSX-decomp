.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCcar_ReadTrackShadow__Fv, 0xE8

glabel R3DCcar_ReadTrackShadow__Fv
    /* 9EE68 800AE668 D8FEBD27 */  addiu      $sp, $sp, -0x128
    /* 9EE6C 800AE66C 1000A427 */  addiu      $a0, $sp, 0x10
    /* 9EE70 800AE670 0580053C */  lui        $a1, %hi(D_8005640C)
    /* 9EE74 800AE674 1180023C */  lui        $v0, %hi(D_801164CC)
    /* 9EE78 800AE678 CC64468C */  lw         $a2, %lo(D_801164CC)($v0)
    /* 9EE7C 800AE67C 0C64A524 */  addiu      $a1, $a1, %lo(D_8005640C)
    /* 9EE80 800AE680 2401BFAF */  sw         $ra, 0x124($sp)
    /* 9EE84 800AE684 2001B2AF */  sw         $s2, 0x120($sp)
    /* 9EE88 800AE688 1C01B1AF */  sw         $s1, 0x11C($sp)
    /* 9EE8C 800AE68C 2F91030C */  jal        sprintf
    /* 9EE90 800AE690 1801B0AF */   sw        $s0, 0x118($sp)
    /* 9EE94 800AE694 1000A427 */  addiu      $a0, $sp, 0x10
    /* 9EE98 800AE698 FA95030C */  jal        loadfileadr
    /* 9EE9C 800AE69C 10000524 */   addiu     $a1, $zero, 0x10
    /* 9EEA0 800AE6A0 1180033C */  lui        $v1, %hi(GameSetup_gData)
    /* 9EEA4 800AE6A4 EC316324 */  addiu      $v1, $v1, %lo(GameSetup_gData)
    /* 9EEA8 800AE6A8 3C00648C */  lw         $a0, 0x3C($v1)
    /* 9EEAC 800AE6AC 21904000 */  addu       $s2, $v0, $zero
    /* 9EEB0 800AE6B0 1001B2AF */  sw         $s2, 0x110($sp)
    /* 9EEB4 800AE6B4 4800658C */  lw         $a1, 0x48($v1)
    /* 9EEB8 800AE6B8 5400628C */  lw         $v0, 0x54($v1)
    /* 9EEBC 800AE6BC 80200400 */  sll        $a0, $a0, 2
    /* 9EEC0 800AE6C0 21208500 */  addu       $a0, $a0, $a1
    /* 9EEC4 800AE6C4 40100200 */  sll        $v0, $v0, 1
    /* 9EEC8 800AE6C8 21888200 */  addu       $s1, $a0, $v0
    /* 9EECC 800AE6CC FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 9EED0 800AE6D0 17002212 */  beq        $s1, $v0, .L800AE730
    /* 9EED4 800AE6D4 1001B027 */   addiu     $s0, $sp, 0x110
  .L800AE6D8:
    /* 9EED8 800AE6D8 BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* 9EEDC 800AE6DC 21200002 */   addu      $a0, $s0, $zero
    /* 9EEE0 800AE6E0 500E82A3 */  sb         $v0, %gp_rel(R3DCar_shadowColour)($gp)
    /* 9EEE4 800AE6E4 BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* 9EEE8 800AE6E8 21200002 */   addu      $a0, $s0, $zero
    /* 9EEEC 800AE6EC 510E82A3 */  sb         $v0, %gp_rel(D_8013D39D)($gp)
    /* 9EEF0 800AE6F0 BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* 9EEF4 800AE6F4 21200002 */   addu      $a0, $s0, $zero
    /* 9EEF8 800AE6F8 520E82A3 */  sb         $v0, %gp_rel(D_8013D39E)($gp)
    /* 9EEFC 800AE6FC BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* 9EF00 800AE700 21200002 */   addu      $a0, $s0, $zero
    /* 9EF04 800AE704 540E82A3 */  sb         $v0, %gp_rel(R3DCar_eMapColour)($gp)
    /* 9EF08 800AE708 BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* 9EF0C 800AE70C 21200002 */   addu      $a0, $s0, $zero
    /* 9EF10 800AE710 550E82A3 */  sb         $v0, %gp_rel(D_8013D3A1)($gp)
    /* 9EF14 800AE714 BF47020C */  jal        Risk_ReadNextValue__FPPc
    /* 9EF18 800AE718 21200002 */   addu      $a0, $s0, $zero
    /* 9EF1C 800AE71C FFFF3126 */  addiu      $s1, $s1, -0x1
    /* 9EF20 800AE720 560E82A3 */  sb         $v0, %gp_rel(D_8013D3A2)($gp)
    /* 9EF24 800AE724 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 9EF28 800AE728 EBFF2216 */  bne        $s1, $v0, .L800AE6D8
    /* 9EF2C 800AE72C 00000000 */   nop
  .L800AE730:
    /* 9EF30 800AE730 5095030C */  jal        purgememadr
    /* 9EF34 800AE734 21204002 */   addu      $a0, $s2, $zero
    /* 9EF38 800AE738 2401BF8F */  lw         $ra, 0x124($sp)
    /* 9EF3C 800AE73C 2001B28F */  lw         $s2, 0x120($sp)
    /* 9EF40 800AE740 1C01B18F */  lw         $s1, 0x11C($sp)
    /* 9EF44 800AE744 1801B08F */  lw         $s0, 0x118($sp)
    /* 9EF48 800AE748 0800E003 */  jr         $ra
    /* 9EF4C 800AE74C 2801BD27 */   addiu     $sp, $sp, 0x128
endlabel R3DCcar_ReadTrackShadow__Fv
