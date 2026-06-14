.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Fog_AddKey__Fii, 0xB4

glabel Fog_AddKey__Fii
    /* D14CC 800E0CCC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D14D0 800E0CD0 1800B2AF */  sw         $s2, 0x18($sp)
    /* D14D4 800E0CD4 21908000 */  addu       $s2, $a0, $zero
    /* D14D8 800E0CD8 1000B0AF */  sw         $s0, 0x10($sp)
    /* D14DC 800E0CDC 2180A000 */  addu       $s0, $a1, $zero
    /* D14E0 800E0CE0 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* D14E4 800E0CE4 2083030C */  jal        Fog_AllocKey__Fv
    /* D14E8 800E0CE8 1400B1AF */   sw        $s1, 0x14($sp)
    /* D14EC 800E0CEC 3C16838F */  lw         $v1, %gp_rel(Fog_gHeadKey)($gp)
    /* D14F0 800E0CF0 21884000 */  addu       $s1, $v0, $zero
    /* D14F4 800E0CF4 080020AE */  sw         $zero, 0x8($s1)
    /* D14F8 800E0CF8 040020AE */  sw         $zero, 0x4($s1)
    /* D14FC 800E0CFC 020032A6 */  sh         $s2, 0x2($s1)
    /* D1500 800E0D00 05006014 */  bnez       $v1, .L800E0D18
    /* D1504 800E0D04 000030A6 */   sh        $s0, 0x0($s1)
    /* D1508 800E0D08 3C1691AF */  sw         $s1, %gp_rel(Fog_gHeadKey)($gp)
    /* D150C 800E0D0C 040031AE */  sw         $s1, 0x4($s1)
    /* D1510 800E0D10 56830308 */  j          .L800E0D58
    /* D1514 800E0D14 080031AE */   sw        $s1, 0x8($s1)
  .L800E0D18:
    /* D1518 800E0D18 0400628C */  lw         $v0, 0x4($v1)
    /* D151C 800E0D1C 00000000 */  nop
    /* D1520 800E0D20 04006210 */  beq        $v1, $v0, .L800E0D34
    /* D1524 800E0D24 21204002 */   addu      $a0, $s2, $zero
    /* D1528 800E0D28 FB82030C */  jal        Fog_FindKey__FiP6FogKey
    /* D152C 800E0D2C 21280000 */   addu      $a1, $zero, $zero
    /* D1530 800E0D30 21184000 */  addu       $v1, $v0, $zero
  .L800E0D34:
    /* D1534 800E0D34 02006284 */  lh         $v0, 0x2($v1)
    /* D1538 800E0D38 00000000 */  nop
    /* D153C 800E0D3C 0A005210 */  beq        $v0, $s2, .L800E0D68
    /* D1540 800E0D40 00000000 */   nop
    /* D1544 800E0D44 0400628C */  lw         $v0, 0x4($v1)
    /* D1548 800E0D48 040071AC */  sw         $s1, 0x4($v1)
    /* D154C 800E0D4C 080023AE */  sw         $v1, 0x8($s1)
    /* D1550 800E0D50 040022AE */  sw         $v0, 0x4($s1)
    /* D1554 800E0D54 080051AC */  sw         $s1, 0x8($v0)
  .L800E0D58:
    /* D1558 800E0D58 3016828F */  lw         $v0, %gp_rel(Fog_gNumKeys)($gp)
    /* D155C 800E0D5C 00000000 */  nop
    /* D1560 800E0D60 01004224 */  addiu      $v0, $v0, 0x1
    /* D1564 800E0D64 301682AF */  sw         $v0, %gp_rel(Fog_gNumKeys)($gp)
  .L800E0D68:
    /* D1568 800E0D68 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* D156C 800E0D6C 1800B28F */  lw         $s2, 0x18($sp)
    /* D1570 800E0D70 1400B18F */  lw         $s1, 0x14($sp)
    /* D1574 800E0D74 1000B08F */  lw         $s0, 0x10($sp)
    /* D1578 800E0D78 0800E003 */  jr         $ra
    /* D157C 800E0D7C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Fog_AddKey__Fii
