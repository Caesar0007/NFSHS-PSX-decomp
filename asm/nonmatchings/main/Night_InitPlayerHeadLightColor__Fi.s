.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_InitPlayerHeadLightColor__Fi, 0x5C

glabel Night_InitPlayerHeadLightColor__Fi
    /* CC0DC 800DB8DC 9814828F */  lw         $v0, %gp_rel(Night_gPlayerLightingTable)($gp)
    /* CC0E0 800DB8E0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CC0E4 800DB8E4 1000B0AF */  sw         $s0, 0x10($sp)
    /* CC0E8 800DB8E8 21808000 */  addu       $s0, $a0, $zero
    /* CC0EC 800DB8EC 07004014 */  bnez       $v0, .L800DB90C
    /* CC0F0 800DB8F0 1400BFAF */   sw        $ra, 0x14($sp)
    /* CC0F4 800DB8F4 1480043C */  lui        $a0, %hi(D_8013DA00)
    /* CC0F8 800DB8F8 00DA8424 */  addiu      $a0, $a0, %lo(D_8013DA00)
    /* CC0FC 800DB8FC 00100524 */  addiu      $a1, $zero, 0x1000
    /* CC100 800DB900 CF94030C */  jal        reservememadr
    /* CC104 800DB904 21300000 */   addu      $a2, $zero, $zero
    /* CC108 800DB908 981482AF */  sw         $v0, %gp_rel(Night_gPlayerLightingTable)($gp)
  .L800DB90C:
    /* CC10C 800DB90C 80181000 */  sll        $v1, $s0, 2
    /* CC110 800DB910 1480043C */  lui        $a0, %hi(Night_gPlayerHeadLightColor)
    /* CC114 800DB914 80DA8424 */  addiu      $a0, $a0, %lo(Night_gPlayerHeadLightColor)
    /* CC118 800DB918 1280023C */  lui        $v0, %hi(D_80123368)
    /* CC11C 800DB91C 6833428C */  lw         $v0, %lo(D_80123368)($v0)
    /* CC120 800DB920 21186400 */  addu       $v1, $v1, $a0
    /* CC124 800DB924 000062AC */  sw         $v0, 0x0($v1)
    /* CC128 800DB928 1400BF8F */  lw         $ra, 0x14($sp)
    /* CC12C 800DB92C 1000B08F */  lw         $s0, 0x10($sp)
    /* CC130 800DB930 0800E003 */  jr         $ra
    /* CC134 800DB934 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Night_InitPlayerHeadLightColor__Fi
