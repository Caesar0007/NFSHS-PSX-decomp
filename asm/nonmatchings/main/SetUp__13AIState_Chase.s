.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetUp__13AIState_Chase, 0x15C

glabel SetUp__13AIState_Chase
    /* 60698 8006FE98 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 6069C 8006FE9C 2000B0AF */  sw         $s0, 0x20($sp)
    /* 606A0 8006FEA0 21808000 */  addu       $s0, $a0, $zero
    /* 606A4 8006FEA4 2400B1AF */  sw         $s1, 0x24($sp)
    /* 606A8 8006FEA8 08001126 */  addiu      $s1, $s0, 0x8
    /* 606AC 8006FEAC 2800BFAF */  sw         $ra, 0x28($sp)
    /* 606B0 8006FEB0 D16A010C */  jal        Update__10AIDelayCar
    /* 606B4 8006FEB4 21202002 */   addu      $a0, $s1, $zero
    /* 606B8 8006FEB8 0000028E */  lw         $v0, 0x0($s0)
    /* 606BC 8006FEBC 00000000 */  nop
    /* 606C0 8006FEC0 6405428C */  lw         $v0, 0x564($v0)
    /* 606C4 8006FEC4 00000000 */  nop
    /* 606C8 8006FEC8 02004004 */  bltz       $v0, .L8006FED4
    /* 606CC 8006FECC FFFF0324 */   addiu     $v1, $zero, -0x1
    /* 606D0 8006FED0 01000324 */  addiu      $v1, $zero, 0x1
  .L8006FED4:
    /* 606D4 8006FED4 640003AE */  sw         $v1, 0x64($s0)
    /* 606D8 8006FED8 3800228E */  lw         $v0, 0x38($s1)
    /* 606DC 8006FEDC 00000000 */  nop
    /* 606E0 8006FEE0 02004004 */  bltz       $v0, .L8006FEEC
    /* 606E4 8006FEE4 FFFF0324 */   addiu     $v1, $zero, -0x1
    /* 606E8 8006FEE8 01000324 */  addiu      $v1, $zero, 0x1
  .L8006FEEC:
    /* 606EC 8006FEEC 0000028E */  lw         $v0, 0x0($s0)
    /* 606F0 8006FEF0 600003AE */  sw         $v1, 0x60($s0)
    /* 606F4 8006FEF4 3000238E */  lw         $v1, 0x30($s1)
    /* 606F8 8006FEF8 7405428C */  lw         $v0, 0x574($v0)
    /* 606FC 8006FEFC 00000000 */  nop
    /* 60700 8006FF00 23104300 */  subu       $v0, $v0, $v1
    /* 60704 8006FF04 6C0002AE */  sw         $v0, 0x6C($s0)
    /* 60708 8006FF08 2800078E */  lw         $a3, 0x28($s0)
    /* 6070C 8006FF0C 2C00088E */  lw         $t0, 0x2C($s0)
    /* 60710 8006FF10 3000098E */  lw         $t1, 0x30($s0)
    /* 60714 8006FF14 1000A7AF */  sw         $a3, 0x10($sp)
    /* 60718 8006FF18 1400A8AF */  sw         $t0, 0x14($sp)
    /* 6071C 8006FF1C 1800A9AF */  sw         $t1, 0x18($sp)
    /* 60720 8006FF20 0000048E */  lw         $a0, 0x0($s0)
    /* 60724 8006FF24 1000258E */  lw         $a1, 0x10($s1)
    /* 60728 8006FF28 9FCC010C */  jal        AIWorld_SplineDistance__FP8Car_tObjiP8coorddef
    /* 6072C 8006FF2C 1000A627 */   addiu     $a2, $sp, 0x10
    /* 60730 8006FF30 0000038E */  lw         $v1, 0x0($s0)
    /* 60734 8006FF34 680002AE */  sw         $v0, 0x68($s0)
    /* 60738 8006FF38 100760AC */  sw         $zero, 0x710($v1)
    /* 6073C 8006FF3C 0C0760AC */  sw         $zero, 0x70C($v1)
    /* 60740 8006FF40 080760AC */  sw         $zero, 0x708($v1)
    /* 60744 8006FF44 0000028E */  lw         $v0, 0x0($s0)
    /* 60748 8006FF48 00000000 */  nop
    /* 6074C 8006FF4C 140740AC */  sw         $zero, 0x714($v0)
    /* 60750 8006FF50 7000028E */  lw         $v0, 0x70($s0)
    /* 60754 8006FF54 00000000 */  nop
    /* 60758 8006FF58 09004010 */  beqz       $v0, .L8006FF80
    /* 6075C 8006FF5C 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 60760 8006FF60 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 60764 8006FF64 7400038E */  lw         $v1, 0x74($s0)
    /* 60768 8006FF68 00000000 */  nop
    /* 6076C 8006FF6C 2A104300 */  slt        $v0, $v0, $v1
    /* 60770 8006FF70 03004014 */  bnez       $v0, .L8006FF80
    /* 60774 8006FF74 00000000 */   nop
    /* 60778 8006FF78 700000AE */  sw         $zero, 0x70($s0)
    /* 6077C 8006FF7C 740000AE */  sw         $zero, 0x74($s0)
  .L8006FF80:
    /* 60780 8006FF80 0000028E */  lw         $v0, 0x0($s0)
    /* 60784 8006FF84 00000000 */  nop
    /* 60788 8006FF88 3C07428C */  lw         $v0, 0x73C($v0)
    /* 6078C 8006FF8C 0100043C */  lui        $a0, (0x10000 >> 16)
    /* 60790 8006FF90 07004410 */  beq        $v0, $a0, .L8006FFB0
    /* 60794 8006FF94 00000000 */   nop
    /* 60798 8006FF98 7C00028E */  lw         $v0, 0x7C($s0)
    /* 6079C 8006FF9C 1480033C */  lui        $v1, %hi(AI_elapsedTime)
    /* 607A0 8006FFA0 54C5638C */  lw         $v1, %lo(AI_elapsedTime)($v1)
    /* 607A4 8006FFA4 00000000 */  nop
    /* 607A8 8006FFA8 23104300 */  subu       $v0, $v0, $v1
    /* 607AC 8006FFAC 7C0002AE */  sw         $v0, 0x7C($s0)
  .L8006FFB0:
    /* 607B0 8006FFB0 0000028E */  lw         $v0, 0x0($s0)
    /* 607B4 8006FFB4 00000000 */  nop
    /* 607B8 8006FFB8 3C0744AC */  sw         $a0, 0x73C($v0)
    /* 607BC 8006FFBC 0000028E */  lw         $v0, 0x0($s0)
    /* 607C0 8006FFC0 00000000 */  nop
    /* 607C4 8006FFC4 400744AC */  sw         $a0, 0x740($v0)
    /* 607C8 8006FFC8 0000028E */  lw         $v0, 0x0($s0)
    /* 607CC 8006FFCC 00000000 */  nop
    /* 607D0 8006FFD0 1C0740AC */  sw         $zero, 0x71C($v0)
    /* 607D4 8006FFD4 0000028E */  lw         $v0, 0x0($s0)
    /* 607D8 8006FFD8 00000000 */  nop
    /* 607DC 8006FFDC 200740AC */  sw         $zero, 0x720($v0)
    /* 607E0 8006FFE0 2800BF8F */  lw         $ra, 0x28($sp)
    /* 607E4 8006FFE4 2400B18F */  lw         $s1, 0x24($sp)
    /* 607E8 8006FFE8 2000B08F */  lw         $s0, 0x20($sp)
    /* 607EC 8006FFEC 0800E003 */  jr         $ra
    /* 607F0 8006FFF0 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel SetUp__13AIState_Chase
