.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__15tScreenCongrats, 0xC4

glabel Initialize__15tScreenCongrats
    /* 3922C 80048A2C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 39230 80048A30 1000B0AF */  sw         $s0, 0x10($sp)
    /* 39234 80048A34 21808000 */  addu       $s0, $a0, $zero
    /* 39238 80048A38 1480023C */  lui        $v0, %hi(ticks)
    /* 3923C 80048A3C ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* 39240 80048A40 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 39244 80048A44 1400BFAF */  sw         $ra, 0x14($sp)
    /* 39248 80048A48 740100AE */  sw         $zero, 0x174($s0)
    /* 3924C 80048A4C 880002AE */  sw         $v0, 0x88($s0)
    /* 39250 80048A50 840002AE */  sw         $v0, 0x84($s0)
    /* 39254 80048A54 8C0000AE */  sw         $zero, 0x8C($s0)
    /* 39258 80048A58 F3AD000C */  jal        SetLicensePlate__Fv
    /* 3925C 80048A5C 640103AE */   sw        $v1, 0x164($s0)
    /* 39260 80048A60 6000028E */  lw         $v0, 0x60($s0)
    /* 39264 80048A64 00000000 */  nop
    /* 39268 80048A68 50004484 */  lh         $a0, 0x50($v0)
    /* 3926C 80048A6C 5400428C */  lw         $v0, 0x54($v0)
    /* 39270 80048A70 00000000 */  nop
    /* 39274 80048A74 09F84000 */  jalr       $v0
    /* 39278 80048A78 21200402 */   addu      $a0, $s0, $a0
    /* 3927C 80048A7C 6000028E */  lw         $v0, 0x60($s0)
    /* 39280 80048A80 94000526 */  addiu      $a1, $s0, 0x94
    /* 39284 80048A84 60004484 */  lh         $a0, 0x60($v0)
    /* 39288 80048A88 6400428C */  lw         $v0, 0x64($v0)
    /* 3928C 80048A8C 00000000 */  nop
    /* 39290 80048A90 09F84000 */  jalr       $v0
    /* 39294 80048A94 21200402 */   addu      $a0, $s0, $a0
    /* 39298 80048A98 8000038E */  lw         $v1, 0x80($s0)
    /* 3929C 80048A9C 00000000 */  nop
    /* 392A0 80048AA0 08006018 */  blez       $v1, .L80048AC4
    /* 392A4 80048AA4 600102AE */   sw        $v0, 0x160($s0)
    /* 392A8 80048AA8 21106000 */  addu       $v0, $v1, $zero
    /* 392AC 80048AAC 680100AE */  sw         $zero, 0x168($s0)
    /* 392B0 80048AB0 02004104 */  bgez       $v0, .L80048ABC
    /* 392B4 80048AB4 6C0100AE */   sw        $zero, 0x16C($s0)
    /* 392B8 80048AB8 3F004224 */  addiu      $v0, $v0, 0x3F
  .L80048ABC:
    /* 392BC 80048ABC B5220108 */  j          .L80048AD4
    /* 392C0 80048AC0 83110200 */   sra       $v0, $v0, 6
  .L80048AC4:
    /* 392C4 80048AC4 01000224 */  addiu      $v0, $zero, 0x1
    /* 392C8 80048AC8 680102AE */  sw         $v0, 0x168($s0)
    /* 392CC 80048ACC 6C0102AE */  sw         $v0, 0x16C($s0)
    /* 392D0 80048AD0 E8030224 */  addiu      $v0, $zero, 0x3E8
  .L80048AD4:
    /* 392D4 80048AD4 700102AE */  sw         $v0, 0x170($s0)
    /* 392D8 80048AD8 2B98000C */  jal        Initialize__7tScreen
    /* 392DC 80048ADC 21200002 */   addu      $a0, $s0, $zero
    /* 392E0 80048AE0 1400BF8F */  lw         $ra, 0x14($sp)
    /* 392E4 80048AE4 1000B08F */  lw         $s0, 0x10($sp)
    /* 392E8 80048AE8 0800E003 */  jr         $ra
    /* 392EC 80048AEC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Initialize__15tScreenCongrats
