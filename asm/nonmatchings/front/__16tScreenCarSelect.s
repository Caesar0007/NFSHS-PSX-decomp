.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __16tScreenCarSelect, 0x110

glabel __16tScreenCarSelect
    /* 2B380 8003AB80 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2B384 8003AB84 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2B388 8003AB88 1400BFAF */  sw         $ra, 0x14($sp)
    /* 2B38C 8003AB8C 0898000C */  jal        __7tScreen
    /* 2B390 8003AB90 21808000 */   addu      $s0, $a0, $zero
    /* 2B394 8003AB94 21200000 */  addu       $a0, $zero, $zero
    /* 2B398 8003AB98 0580023C */  lui        $v0, %hi(D_80051FC4)
    /* 2B39C 8003AB9C C41F4624 */  addiu      $a2, $v0, %lo(D_80051FC4)
    /* 2B3A0 8003ABA0 06000524 */  addiu      $a1, $zero, 0x6
    /* 2B3A4 8003ABA4 0180023C */  lui        $v0, %hi(_vt_16tScreenCarSelect)
    /* 2B3A8 8003ABA8 081D4224 */  addiu      $v0, $v0, %lo(_vt_16tScreenCarSelect)
    /* 2B3AC 8003ABAC 600002AE */  sw         $v0, 0x60($s0)
    /* 2B3B0 8003ABB0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 2B3B4 8003ABB4 1E0100A6 */  sh         $zero, 0x11E($s0)
    /* 2B3B8 8003ABB8 200102A6 */  sh         $v0, 0x120($s0)
    /* 2B3BC 8003ABBC 220100A6 */  sh         $zero, 0x122($s0)
  .L8003ABC0:
    /* 2B3C0 8003ABC0 00140400 */  sll        $v0, $a0, 16
    /* 2B3C4 8003ABC4 03140200 */  sra        $v0, $v0, 16
    /* 2B3C8 8003ABC8 40180200 */  sll        $v1, $v0, 1
    /* 2B3CC 8003ABCC 21186200 */  addu       $v1, $v1, $v0
    /* 2B3D0 8003ABD0 C0180300 */  sll        $v1, $v1, 3
    /* 2B3D4 8003ABD4 64006324 */  addiu      $v1, $v1, 0x64
    /* 2B3D8 8003ABD8 21180302 */  addu       $v1, $s0, $v1
    /* 2B3DC 8003ABDC 00110200 */  sll        $v0, $v0, 4
    /* 2B3E0 8003ABE0 21104600 */  addu       $v0, $v0, $a2
    /* 2B3E4 8003ABE4 03004788 */  lwl        $a3, 0x3($v0)
    /* 2B3E8 8003ABE8 00004798 */  lwr        $a3, 0x0($v0)
    /* 2B3EC 8003ABEC 07004888 */  lwl        $t0, 0x7($v0)
    /* 2B3F0 8003ABF0 04004898 */  lwr        $t0, 0x4($v0)
    /* 2B3F4 8003ABF4 030067A8 */  swl        $a3, 0x3($v1)
    /* 2B3F8 8003ABF8 000067B8 */  swr        $a3, 0x0($v1)
    /* 2B3FC 8003ABFC 070068A8 */  swl        $t0, 0x7($v1)
    /* 2B400 8003AC00 040068B8 */  swr        $t0, 0x4($v1)
    /* 2B404 8003AC04 0B004788 */  lwl        $a3, 0xB($v0)
    /* 2B408 8003AC08 08004798 */  lwr        $a3, 0x8($v0)
    /* 2B40C 8003AC0C 0F004888 */  lwl        $t0, 0xF($v0)
    /* 2B410 8003AC10 0C004898 */  lwr        $t0, 0xC($v0)
    /* 2B414 8003AC14 0B0067A8 */  swl        $a3, 0xB($v1)
    /* 2B418 8003AC18 080067B8 */  swr        $a3, 0x8($v1)
    /* 2B41C 8003AC1C 0F0068A8 */  swl        $t0, 0xF($v1)
    /* 2B420 8003AC20 0C0068B8 */  swr        $t0, 0xC($v1)
    /* 2B424 8003AC24 01008224 */  addiu      $v0, $a0, 0x1
    /* 2B428 8003AC28 160064A4 */  sh         $a0, 0x16($v1)
    /* 2B42C 8003AC2C 21204000 */  addu       $a0, $v0, $zero
    /* 2B430 8003AC30 00140200 */  sll        $v0, $v0, 16
    /* 2B434 8003AC34 03140200 */  sra        $v0, $v0, 16
    /* 2B438 8003AC38 07004228 */  slti       $v0, $v0, 0x7
    /* 2B43C 8003AC3C 140060A4 */  sh         $zero, 0x14($v1)
    /* 2B440 8003AC40 100060A4 */  sh         $zero, 0x10($v1)
    /* 2B444 8003AC44 DEFF4014 */  bnez       $v0, .L8003ABC0
    /* 2B448 8003AC48 120065A4 */   sh        $a1, 0x12($v1)
    /* 2B44C 8003AC4C 21200000 */  addu       $a0, $zero, $zero
    /* 2B450 8003AC50 00140400 */  sll        $v0, $a0, 16
  .L8003AC54:
    /* 2B454 8003AC54 83130200 */  sra        $v0, $v0, 14
    /* 2B458 8003AC58 21100202 */  addu       $v0, $s0, $v0
    /* 2B45C 8003AC5C 0C0140AC */  sw         $zero, 0x10C($v0)
    /* 2B460 8003AC60 01008224 */  addiu      $v0, $a0, 0x1
    /* 2B464 8003AC64 21204000 */  addu       $a0, $v0, $zero
    /* 2B468 8003AC68 00140200 */  sll        $v0, $v0, 16
    /* 2B46C 8003AC6C 03140200 */  sra        $v0, $v0, 16
    /* 2B470 8003AC70 04004228 */  slti       $v0, $v0, 0x4
    /* 2B474 8003AC74 F7FF4014 */  bnez       $v0, .L8003AC54
    /* 2B478 8003AC78 00140400 */   sll       $v0, $a0, 16
    /* 2B47C 8003AC7C 21100002 */  addu       $v0, $s0, $zero
    /* 2B480 8003AC80 1400BF8F */  lw         $ra, 0x14($sp)
    /* 2B484 8003AC84 1000B08F */  lw         $s0, 0x10($sp)
    /* 2B488 8003AC88 0800E003 */  jr         $ra
    /* 2B48C 8003AC8C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __16tScreenCarSelect
