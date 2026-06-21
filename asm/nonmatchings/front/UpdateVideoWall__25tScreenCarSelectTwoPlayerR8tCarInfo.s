.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateVideoWall__25tScreenCarSelectTwoPlayerR8tCarInfo, 0xD4

glabel UpdateVideoWall__25tScreenCarSelectTwoPlayerR8tCarInfo
    /* 2EBC8 8003E3C8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 2EBCC 8003E3CC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 2EBD0 8003E3D0 21888000 */  addu       $s1, $a0, $zero
    /* 2EBD4 8003E3D4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2EBD8 8003E3D8 2180A000 */  addu       $s0, $a1, $zero
    /* 2EBDC 8003E3DC 1800BFAF */  sw         $ra, 0x18($sp)
    /* 2EBE0 8003E3E0 C8000392 */  lbu        $v1, 0xC8($s0)
    /* 2EBE4 8003E3E4 1E012286 */  lh         $v0, 0x11E($s1)
    /* 2EBE8 8003E3E8 00000000 */  nop
    /* 2EBEC 8003E3EC 0F006214 */  bne        $v1, $v0, .L8003E42C
    /* 2EBF0 8003E3F0 00000000 */   nop
    /* 2EBF4 8003E3F4 00000382 */  lb         $v1, 0x0($s0)
    /* 2EBF8 8003E3F8 20012286 */  lh         $v0, 0x120($s1)
    /* 2EBFC 8003E3FC 00000000 */  nop
    /* 2EC00 8003E400 0A006214 */  bne        $v1, $v0, .L8003E42C
    /* 2EC04 8003E404 07000224 */   addiu     $v0, $zero, 0x7
    /* 2EC08 8003E408 02000392 */  lbu        $v1, 0x2($s0)
    /* 2EC0C 8003E40C 00000000 */  nop
    /* 2EC10 8003E410 1D006214 */  bne        $v1, $v0, .L8003E488
    /* 2EC14 8003E414 00000000 */   nop
    /* 2EC18 8003E418 22012386 */  lh         $v1, 0x122($s1)
    /* 2EC1C 8003E41C C7000292 */  lbu        $v0, 0xC7($s0)
    /* 2EC20 8003E420 00000000 */  nop
    /* 2EC24 8003E424 18006210 */  beq        $v1, $v0, .L8003E488
    /* 2EC28 8003E428 00000000 */   nop
  .L8003E42C:
    /* 2EC2C 8003E42C 00000282 */  lb         $v0, 0x0($s0)
    /* 2EC30 8003E430 00000000 */  nop
    /* 2EC34 8003E434 03004004 */  bltz       $v0, .L8003E444
    /* 2EC38 8003E438 21202002 */   addu      $a0, $s1, $zero
    /* 2EC3C 8003E43C 6E97000C */  jal        AsyncLoadSwapShapeFile__7tScreenPc
    /* 2EC40 8003E440 10000526 */   addiu     $a1, $s0, 0x10
  .L8003E444:
    /* 2EC44 8003E444 C8000292 */  lbu        $v0, 0xC8($s0)
    /* 2EC48 8003E448 00000000 */  nop
    /* 2EC4C 8003E44C 1E0122A6 */  sh         $v0, 0x11E($s1)
    /* 2EC50 8003E450 00000292 */  lbu        $v0, 0x0($s0)
    /* 2EC54 8003E454 00000000 */  nop
    /* 2EC58 8003E458 00160200 */  sll        $v0, $v0, 24
    /* 2EC5C 8003E45C 03160200 */  sra        $v0, $v0, 24
    /* 2EC60 8003E460 200122A6 */  sh         $v0, 0x120($s1)
    /* 2EC64 8003E464 C7000292 */  lbu        $v0, 0xC7($s0)
    /* 2EC68 8003E468 04032426 */  addiu      $a0, $s1, 0x304
    /* 2EC6C 8003E46C 840320AE */  sw         $zero, 0x384($s1)
    /* 2EC70 8003E470 96DB000C */  jal        TurnOff__10tVideoWall
    /* 2EC74 8003E474 220122A6 */   sh        $v0, 0x122($s1)
    /* 2EC78 8003E478 21202002 */  addu       $a0, $s1, $zero
    /* 2EC7C 8003E47C 21280000 */  addu       $a1, $zero, $zero
    /* 2EC80 8003E480 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2EC84 8003E484 2130A000 */   addu      $a2, $a1, $zero
  .L8003E488:
    /* 2EC88 8003E488 1800BF8F */  lw         $ra, 0x18($sp)
    /* 2EC8C 8003E48C 1400B18F */  lw         $s1, 0x14($sp)
    /* 2EC90 8003E490 1000B08F */  lw         $s0, 0x10($sp)
    /* 2EC94 8003E494 0800E003 */  jr         $ra
    /* 2EC98 8003E498 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel UpdateVideoWall__25tScreenCarSelectTwoPlayerR8tCarInfo
