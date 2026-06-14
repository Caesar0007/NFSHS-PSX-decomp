.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Night_InitWeatherTables__Fv, 0x84

glabel Night_InitWeatherTables__Fv
    /* CC250 800DBA50 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* CC254 800DBA54 1400B1AF */  sw         $s1, 0x14($sp)
    /* CC258 800DBA58 21880000 */  addu       $s1, $zero, $zero
    /* CC25C 800DBA5C 1800B2AF */  sw         $s2, 0x18($sp)
    /* CC260 800DBA60 1480123C */  lui        $s2, %hi(D_8013DA18)
    /* CC264 800DBA64 1000B0AF */  sw         $s0, 0x10($sp)
    /* CC268 800DBA68 1480103C */  lui        $s0, %hi(Night_gWeatherLightingTable)
    /* CC26C 800DBA6C F0D91026 */  addiu      $s0, $s0, %lo(Night_gWeatherLightingTable)
    /* CC270 800DBA70 1C00BFAF */  sw         $ra, 0x1C($sp)
  .L800DBA74:
    /* CC274 800DBA74 0000028E */  lw         $v0, 0x0($s0)
    /* CC278 800DBA78 00000000 */  nop
    /* CC27C 800DBA7C 05004014 */  bnez       $v0, .L800DBA94
    /* CC280 800DBA80 18DA4426 */   addiu     $a0, $s2, %lo(D_8013DA18)
    /* CC284 800DBA84 00010524 */  addiu      $a1, $zero, 0x100
    /* CC288 800DBA88 CF94030C */  jal        reservememadr
    /* CC28C 800DBA8C 21300000 */   addu      $a2, $zero, $zero
    /* CC290 800DBA90 000002AE */  sw         $v0, 0x0($s0)
  .L800DBA94:
    /* CC294 800DBA94 01003126 */  addiu      $s1, $s1, 0x1
    /* CC298 800DBA98 0200222A */  slti       $v0, $s1, 0x2
    /* CC29C 800DBA9C F5FF4014 */  bnez       $v0, .L800DBA74
    /* CC2A0 800DBAA0 04001026 */   addiu     $s0, $s0, 0x4
    /* CC2A4 800DBAA4 5700033C */  lui        $v1, (0x574054 >> 16)
    /* CC2A8 800DBAA8 54406334 */  ori        $v1, $v1, (0x574054 & 0xFFFF)
    /* CC2AC 800DBAAC 6C00023C */  lui        $v0, (0x6C4040 >> 16)
    /* CC2B0 800DBAB0 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* CC2B4 800DBAB4 1800B28F */  lw         $s2, 0x18($sp)
    /* CC2B8 800DBAB8 1400B18F */  lw         $s1, 0x14($sp)
    /* CC2BC 800DBABC 1000B08F */  lw         $s0, 0x10($sp)
    /* CC2C0 800DBAC0 40404234 */  ori        $v0, $v0, (0x6C4040 & 0xFFFF)
    /* CC2C4 800DBAC4 3C1583AF */  sw         $v1, %gp_rel(Night_gWeatherColor)($gp)
    /* CC2C8 800DBAC8 401582AF */  sw         $v0, %gp_rel(D_8013DA8C)($gp)
    /* CC2CC 800DBACC 0800E003 */  jr         $ra
    /* CC2D0 800DBAD0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Night_InitWeatherTables__Fv
