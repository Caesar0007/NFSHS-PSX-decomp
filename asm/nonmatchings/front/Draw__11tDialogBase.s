.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Draw__11tDialogBase, 0x110

glabel Draw__11tDialogBase
    /* 91B8 800189B8 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 91BC 800189BC 1800B0AF */  sw         $s0, 0x18($sp)
    /* 91C0 800189C0 21808000 */  addu       $s0, $a0, $zero
    /* 91C4 800189C4 21200000 */  addu       $a0, $zero, $zero
    /* 91C8 800189C8 04000724 */  addiu      $a3, $zero, 0x4
    /* 91CC 800189CC 2400BFAF */  sw         $ra, 0x24($sp)
    /* 91D0 800189D0 2000B2AF */  sw         $s2, 0x20($sp)
    /* 91D4 800189D4 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 91D8 800189D8 66000586 */  lh         $a1, 0x66($s0)
    /* 91DC 800189DC 68000686 */  lh         $a2, 0x68($s0)
    /* 91E0 800189E0 6C000286 */  lh         $v0, 0x6C($s0)
    /* 91E4 800189E4 2190E000 */  addu       $s2, $a3, $zero
    /* 91E8 800189E8 1400B2AF */  sw         $s2, 0x14($sp)
    /* 91EC 800189EC B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 91F0 800189F0 1000A2AF */   sw        $v0, 0x10($sp)
    /* 91F4 800189F4 21200000 */  addu       $a0, $zero, $zero
    /* 91F8 800189F8 66000586 */  lh         $a1, 0x66($s0)
    /* 91FC 800189FC 6A000286 */  lh         $v0, 0x6A($s0)
    /* 9200 80018A00 68000686 */  lh         $a2, 0x68($s0)
    /* 9204 80018A04 6C000386 */  lh         $v1, 0x6C($s0)
    /* 9208 80018A08 04000724 */  addiu      $a3, $zero, 0x4
    /* 920C 80018A0C 1400B2AF */  sw         $s2, 0x14($sp)
    /* 9210 80018A10 2128A200 */  addu       $a1, $a1, $v0
    /* 9214 80018A14 FCFFA524 */  addiu      $a1, $a1, -0x4
    /* 9218 80018A18 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 921C 80018A1C 1000A3AF */   sw        $v1, 0x10($sp)
    /* 9220 80018A20 21200000 */  addu       $a0, $zero, $zero
    /* 9224 80018A24 66000586 */  lh         $a1, 0x66($s0)
    /* 9228 80018A28 68000686 */  lh         $a2, 0x68($s0)
    /* 922C 80018A2C 6A000786 */  lh         $a3, 0x6A($s0)
    /* 9230 80018A30 02001124 */  addiu      $s1, $zero, 0x2
    /* 9234 80018A34 1000B1AF */  sw         $s1, 0x10($sp)
    /* 9238 80018A38 1400B2AF */  sw         $s2, 0x14($sp)
    /* 923C 80018A3C 0400A524 */  addiu      $a1, $a1, 0x4
    /* 9240 80018A40 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 9244 80018A44 F8FFE724 */   addiu     $a3, $a3, -0x8
    /* 9248 80018A48 66000586 */  lh         $a1, 0x66($s0)
    /* 924C 80018A4C 68000686 */  lh         $a2, 0x68($s0)
    /* 9250 80018A50 6C000286 */  lh         $v0, 0x6C($s0)
    /* 9254 80018A54 6A000786 */  lh         $a3, 0x6A($s0)
    /* 9258 80018A58 21200000 */  addu       $a0, $zero, $zero
    /* 925C 80018A5C 1000B1AF */  sw         $s1, 0x10($sp)
    /* 9260 80018A60 1400B2AF */  sw         $s2, 0x14($sp)
    /* 9264 80018A64 0400A524 */  addiu      $a1, $a1, 0x4
    /* 9268 80018A68 2130C200 */  addu       $a2, $a2, $v0
    /* 926C 80018A6C FEFFC624 */  addiu      $a2, $a2, -0x2
    /* 9270 80018A70 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 9274 80018A74 F8FFE724 */   addiu     $a3, $a3, -0x8
    /* 9278 80018A78 66000586 */  lh         $a1, 0x66($s0)
    /* 927C 80018A7C 68000686 */  lh         $a2, 0x68($s0)
    /* 9280 80018A80 6A000786 */  lh         $a3, 0x6A($s0)
    /* 9284 80018A84 6C000286 */  lh         $v0, 0x6C($s0)
    /* 9288 80018A88 21200000 */  addu       $a0, $zero, $zero
    /* 928C 80018A8C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9290 80018A90 0400A524 */  addiu      $a1, $a1, 0x4
    /* 9294 80018A94 2130D100 */  addu       $a2, $a2, $s1
    /* 9298 80018A98 F8FFE724 */  addiu      $a3, $a3, -0x8
    /* 929C 80018A9C FCFF4224 */  addiu      $v0, $v0, -0x4
    /* 92A0 80018AA0 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 92A4 80018AA4 1000A2AF */   sw        $v0, 0x10($sp)
    /* 92A8 80018AA8 B635010C */  jal        FeDraw_SetABRMode__Fi
    /* 92AC 80018AAC 21200000 */   addu      $a0, $zero, $zero
    /* 92B0 80018AB0 2400BF8F */  lw         $ra, 0x24($sp)
    /* 92B4 80018AB4 2000B28F */  lw         $s2, 0x20($sp)
    /* 92B8 80018AB8 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 92BC 80018ABC 1800B08F */  lw         $s0, 0x18($sp)
    /* 92C0 80018AC0 0800E003 */  jr         $ra
    /* 92C4 80018AC4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Draw__11tDialogBase
