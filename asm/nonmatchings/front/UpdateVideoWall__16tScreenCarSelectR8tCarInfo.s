.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateVideoWall__16tScreenCarSelectR8tCarInfo, 0xD0

glabel UpdateVideoWall__16tScreenCarSelectR8tCarInfo
    /* 2C3A4 8003BBA4 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 2C3A8 8003BBA8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 2C3AC 8003BBAC 21888000 */  addu       $s1, $a0, $zero
    /* 2C3B0 8003BBB0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2C3B4 8003BBB4 2180A000 */  addu       $s0, $a1, $zero
    /* 2C3B8 8003BBB8 1800BFAF */  sw         $ra, 0x18($sp)
    /* 2C3BC 8003BBBC C8000392 */  lbu        $v1, 0xC8($s0)
    /* 2C3C0 8003BBC0 1E012286 */  lh         $v0, 0x11E($s1)
    /* 2C3C4 8003BBC4 00000000 */  nop
    /* 2C3C8 8003BBC8 0F006214 */  bne        $v1, $v0, .L8003BC08
    /* 2C3CC 8003BBCC 00000000 */   nop
    /* 2C3D0 8003BBD0 00000382 */  lb         $v1, 0x0($s0)
    /* 2C3D4 8003BBD4 20012286 */  lh         $v0, 0x120($s1)
    /* 2C3D8 8003BBD8 00000000 */  nop
    /* 2C3DC 8003BBDC 0A006214 */  bne        $v1, $v0, .L8003BC08
    /* 2C3E0 8003BBE0 07000224 */   addiu     $v0, $zero, 0x7
    /* 2C3E4 8003BBE4 02000392 */  lbu        $v1, 0x2($s0)
    /* 2C3E8 8003BBE8 00000000 */  nop
    /* 2C3EC 8003BBEC 1C006214 */  bne        $v1, $v0, .L8003BC60
    /* 2C3F0 8003BBF0 00000000 */   nop
    /* 2C3F4 8003BBF4 22012386 */  lh         $v1, 0x122($s1)
    /* 2C3F8 8003BBF8 C7000292 */  lbu        $v0, 0xC7($s0)
    /* 2C3FC 8003BBFC 00000000 */  nop
    /* 2C400 8003BC00 17006210 */  beq        $v1, $v0, .L8003BC60
    /* 2C404 8003BC04 00000000 */   nop
  .L8003BC08:
    /* 2C408 8003BC08 00000282 */  lb         $v0, 0x0($s0)
    /* 2C40C 8003BC0C 00000000 */  nop
    /* 2C410 8003BC10 04004004 */  bltz       $v0, .L8003BC24
    /* 2C414 8003BC14 00000000 */   nop
    /* 2C418 8003BC18 21202002 */  addu       $a0, $s1, $zero
    /* 2C41C 8003BC1C 6E97000C */  jal        AsyncLoadSwapShapeFile__7tScreenPc
    /* 2C420 8003BC20 08000526 */   addiu     $a1, $s0, 0x8
  .L8003BC24:
    /* 2C424 8003BC24 C8000292 */  lbu        $v0, 0xC8($s0)
    /* 2C428 8003BC28 21202002 */  addu       $a0, $s1, $zero
    /* 2C42C 8003BC2C 1E0122A6 */  sh         $v0, 0x11E($s1)
    /* 2C430 8003BC30 00000292 */  lbu        $v0, 0x0($s0)
    /* 2C434 8003BC34 21280000 */  addu       $a1, $zero, $zero
    /* 2C438 8003BC38 00160200 */  sll        $v0, $v0, 24
    /* 2C43C 8003BC3C 03160200 */  sra        $v0, $v0, 24
    /* 2C440 8003BC40 200122A6 */  sh         $v0, 0x120($s1)
    /* 2C444 8003BC44 C7000292 */  lbu        $v0, 0xC7($s0)
    /* 2C448 8003BC48 2130A000 */  addu       $a2, $a1, $zero
    /* 2C44C 8003BC4C 840320AE */  sw         $zero, 0x384($s1)
    /* 2C450 8003BC50 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2C454 8003BC54 220122A6 */   sh        $v0, 0x122($s1)
    /* 2C458 8003BC58 96DB000C */  jal        TurnOff__10tVideoWall
    /* 2C45C 8003BC5C 04032426 */   addiu     $a0, $s1, 0x304
  .L8003BC60:
    /* 2C460 8003BC60 1800BF8F */  lw         $ra, 0x18($sp)
    /* 2C464 8003BC64 1400B18F */  lw         $s1, 0x14($sp)
    /* 2C468 8003BC68 1000B08F */  lw         $s0, 0x10($sp)
    /* 2C46C 8003BC6C 0800E003 */  jr         $ra
    /* 2C470 8003BC70 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel UpdateVideoWall__16tScreenCarSelectR8tCarInfo
