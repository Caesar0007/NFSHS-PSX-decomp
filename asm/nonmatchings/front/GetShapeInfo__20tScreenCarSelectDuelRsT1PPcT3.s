.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__20tScreenCarSelectDuelRsT1PPcT3, 0xBC

glabel GetShapeInfo__20tScreenCarSelectDuelRsT1PPcT3
    /* 2DDE0 8003D5E0 10FFBD27 */  addiu      $sp, $sp, -0xF0
    /* 2DDE4 8003D5E4 E000B0AF */  sw         $s0, 0xE0($sp)
    /* 2DDE8 8003D5E8 21808000 */  addu       $s0, $a0, $zero
    /* 2DDEC 8003D5EC 34000224 */  addiu      $v0, $zero, 0x34
    /* 2DDF0 8003D5F0 E800BFAF */  sw         $ra, 0xE8($sp)
    /* 2DDF4 8003D5F4 E400B1AF */  sw         $s1, 0xE4($sp)
    /* 2DDF8 8003D5F8 0000A2A4 */  sh         $v0, 0x0($a1)
    /* 2DDFC 8003D5FC 05000224 */  addiu      $v0, $zero, 0x5
    /* 2DE00 8003D600 1000A527 */  addiu      $a1, $sp, 0x10
    /* 2DE04 8003D604 0000C2A4 */  sh         $v0, 0x0($a2)
    /* 2DE08 8003D608 6000028E */  lw         $v0, 0x60($s0)
    /* 2DE0C 8003D60C 2188E000 */  addu       $s1, $a3, $zero
    /* 2DE10 8003D610 68004484 */  lh         $a0, 0x68($v0)
    /* 2DE14 8003D614 6C00428C */  lw         $v0, 0x6C($v0)
    /* 2DE18 8003D618 00000000 */  nop
    /* 2DE1C 8003D61C 09F84000 */  jalr       $v0
    /* 2DE20 8003D620 21200402 */   addu      $a0, $s0, $a0
    /* 2DE24 8003D624 01004238 */  xori       $v0, $v0, 0x1
    /* 2DE28 8003D628 05004010 */  beqz       $v0, .L8003D640
    /* 2DE2C 8003D62C 1180043C */   lui       $a0, %hi(carManager)
    /* 2DE30 8003D630 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 2DE34 8003D634 21280000 */  addu       $a1, $zero, $zero
    /* 2DE38 8003D638 A45B000C */  jal        GetStockCar__11tCarManagersR8tCarInfo
    /* 2DE3C 8003D63C 1000A627 */   addiu     $a2, $sp, 0x10
  .L8003D640:
    /* 2DE40 8003D640 D800A293 */  lbu        $v0, 0xD8($sp)
    /* 2DE44 8003D644 00000000 */  nop
    /* 2DE48 8003D648 1E0102A6 */  sh         $v0, 0x11E($s0)
    /* 2DE4C 8003D64C 1000A293 */  lbu        $v0, 0x10($sp)
    /* 2DE50 8003D650 00000000 */  nop
    /* 2DE54 8003D654 00160200 */  sll        $v0, $v0, 24
    /* 2DE58 8003D658 03160200 */  sra        $v0, $v0, 24
    /* 2DE5C 8003D65C 200102A6 */  sh         $v0, 0x120($s0)
    /* 2DE60 8003D660 D700A393 */  lbu        $v1, 0xD7($sp)
    /* 2DE64 8003D664 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 2DE68 8003D668 A00302A6 */  sh         $v0, 0x3A0($s0)
    /* 2DE6C 8003D66C 0180023C */  lui        $v0, %hi(D_80011B28)
    /* 2DE70 8003D670 281B4224 */  addiu      $v0, $v0, %lo(D_80011B28)
    /* 2DE74 8003D674 220103A6 */  sh         $v1, 0x122($s0)
    /* 2DE78 8003D678 000022AE */  sw         $v0, 0x0($s1)
    /* 2DE7C 8003D67C 0001A28F */  lw         $v0, 0x100($sp)
    /* 2DE80 8003D680 00000000 */  nop
    /* 2DE84 8003D684 000040AC */  sw         $zero, 0x0($v0)
    /* 2DE88 8003D688 E800BF8F */  lw         $ra, 0xE8($sp)
    /* 2DE8C 8003D68C E400B18F */  lw         $s1, 0xE4($sp)
    /* 2DE90 8003D690 E000B08F */  lw         $s0, 0xE0($sp)
    /* 2DE94 8003D694 0800E003 */  jr         $ra
    /* 2DE98 8003D698 F000BD27 */   addiu     $sp, $sp, 0xF0
endlabel GetShapeInfo__20tScreenCarSelectDuelRsT1PPcT3
