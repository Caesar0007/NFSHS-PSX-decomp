.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateVideoWall__20tScreenCarSelectDuelR8tCarInfo, 0xD0

glabel UpdateVideoWall__20tScreenCarSelectDuelR8tCarInfo
    /* 2DE9C 8003D69C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 2DEA0 8003D6A0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 2DEA4 8003D6A4 21888000 */  addu       $s1, $a0, $zero
    /* 2DEA8 8003D6A8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2DEAC 8003D6AC 2180A000 */  addu       $s0, $a1, $zero
    /* 2DEB0 8003D6B0 1800BFAF */  sw         $ra, 0x18($sp)
    /* 2DEB4 8003D6B4 C8000392 */  lbu        $v1, 0xC8($s0)
    /* 2DEB8 8003D6B8 1E012286 */  lh         $v0, 0x11E($s1)
    /* 2DEBC 8003D6BC 00000000 */  nop
    /* 2DEC0 8003D6C0 0F006214 */  bne        $v1, $v0, .L8003D700
    /* 2DEC4 8003D6C4 00000000 */   nop
    /* 2DEC8 8003D6C8 00000382 */  lb         $v1, 0x0($s0)
    /* 2DECC 8003D6CC 20012286 */  lh         $v0, 0x120($s1)
    /* 2DED0 8003D6D0 00000000 */  nop
    /* 2DED4 8003D6D4 0A006214 */  bne        $v1, $v0, .L8003D700
    /* 2DED8 8003D6D8 07000224 */   addiu     $v0, $zero, 0x7
    /* 2DEDC 8003D6DC 02000392 */  lbu        $v1, 0x2($s0)
    /* 2DEE0 8003D6E0 00000000 */  nop
    /* 2DEE4 8003D6E4 1C006214 */  bne        $v1, $v0, .L8003D758
    /* 2DEE8 8003D6E8 00000000 */   nop
    /* 2DEEC 8003D6EC 22012386 */  lh         $v1, 0x122($s1)
    /* 2DEF0 8003D6F0 C7000292 */  lbu        $v0, 0xC7($s0)
    /* 2DEF4 8003D6F4 00000000 */  nop
    /* 2DEF8 8003D6F8 17006210 */  beq        $v1, $v0, .L8003D758
    /* 2DEFC 8003D6FC 00000000 */   nop
  .L8003D700:
    /* 2DF00 8003D700 00000282 */  lb         $v0, 0x0($s0)
    /* 2DF04 8003D704 00000000 */  nop
    /* 2DF08 8003D708 04004004 */  bltz       $v0, .L8003D71C
    /* 2DF0C 8003D70C 00000000 */   nop
    /* 2DF10 8003D710 21202002 */  addu       $a0, $s1, $zero
    /* 2DF14 8003D714 6E97000C */  jal        AsyncLoadSwapShapeFile__7tScreenPc
    /* 2DF18 8003D718 10000526 */   addiu     $a1, $s0, 0x10
  .L8003D71C:
    /* 2DF1C 8003D71C C8000292 */  lbu        $v0, 0xC8($s0)
    /* 2DF20 8003D720 21202002 */  addu       $a0, $s1, $zero
    /* 2DF24 8003D724 1E0122A6 */  sh         $v0, 0x11E($s1)
    /* 2DF28 8003D728 00000292 */  lbu        $v0, 0x0($s0)
    /* 2DF2C 8003D72C 21280000 */  addu       $a1, $zero, $zero
    /* 2DF30 8003D730 00160200 */  sll        $v0, $v0, 24
    /* 2DF34 8003D734 03160200 */  sra        $v0, $v0, 24
    /* 2DF38 8003D738 200122A6 */  sh         $v0, 0x120($s1)
    /* 2DF3C 8003D73C C7000292 */  lbu        $v0, 0xC7($s0)
    /* 2DF40 8003D740 2130A000 */  addu       $a2, $a1, $zero
    /* 2DF44 8003D744 840320AE */  sw         $zero, 0x384($s1)
    /* 2DF48 8003D748 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2DF4C 8003D74C 220122A6 */   sh        $v0, 0x122($s1)
    /* 2DF50 8003D750 96DB000C */  jal        TurnOff__10tVideoWall
    /* 2DF54 8003D754 04032426 */   addiu     $a0, $s1, 0x304
  .L8003D758:
    /* 2DF58 8003D758 1800BF8F */  lw         $ra, 0x18($sp)
    /* 2DF5C 8003D75C 1400B18F */  lw         $s1, 0x14($sp)
    /* 2DF60 8003D760 1000B08F */  lw         $s0, 0x10($sp)
    /* 2DF64 8003D764 0800E003 */  jr         $ra
    /* 2DF68 8003D768 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel UpdateVideoWall__20tScreenCarSelectDuelR8tCarInfo
