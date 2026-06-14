.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Fog_InitFogTriggers__Fv, 0xE4

glabel Fog_InitFogTriggers__Fv
    /* D182C 800E102C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D1830 800E1030 01000424 */  addiu      $a0, $zero, 0x1
    /* D1834 800E1034 1F000324 */  addiu      $v1, $zero, 0x1F
    /* D1838 800E1038 1280023C */  lui        $v0, %hi(openkeys)
    /* D183C 800E103C FC314224 */  addiu      $v0, $v0, %lo(openkeys)
    /* D1840 800E1040 7C004224 */  addiu      $v0, $v0, 0x7C
    /* D1844 800E1044 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* D1848 800E1048 1800B2AF */  sw         $s2, 0x18($sp)
    /* D184C 800E104C 1400B1AF */  sw         $s1, 0x14($sp)
    /* D1850 800E1050 1000B0AF */  sw         $s0, 0x10($sp)
    /* D1854 800E1054 301680AF */  sw         $zero, %gp_rel(Fog_gNumKeys)($gp)
    /* D1858 800E1058 3C1680AF */  sw         $zero, %gp_rel(Fog_gHeadKey)($gp)
  .L800E105C:
    /* D185C 800E105C 000044AC */  sw         $a0, 0x0($v0)
    /* D1860 800E1060 FFFF6324 */  addiu      $v1, $v1, -0x1
    /* D1864 800E1064 FDFF6104 */  bgez       $v1, .L800E105C
    /* D1868 800E1068 FCFF4224 */   addiu     $v0, $v0, -0x4
    /* D186C 800E106C C583030C */  jal        Fog_ReadFogKeys__Fv
    /* D1870 800E1070 00000000 */   nop
    /* D1874 800E1074 06004014 */  bnez       $v0, .L800E1090
    /* D1878 800E1078 1180023C */   lui       $v0, %hi(D_801131F8)
    /* D187C 800E107C 1280023C */  lui        $v0, %hi(D_80123294)
    /* D1880 800E1080 9432458C */  lw         $a1, %lo(D_80123294)($v0)
    /* D1884 800E1084 3383030C */  jal        Fog_AddKey__Fii
    /* D1888 800E1088 21200000 */   addu      $a0, $zero, $zero
    /* D188C 800E108C 1180023C */  lui        $v0, %hi(D_801131F8)
  .L800E1090:
    /* D1890 800E1090 3C16838F */  lw         $v1, %gp_rel(Fog_gHeadKey)($gp)
    /* D1894 800E1094 F831428C */  lw         $v0, %lo(D_801131F8)($v0)
    /* D1898 800E1098 01001224 */  addiu      $s2, $zero, 0x1
    /* D189C 800E109C 341683AF */  sw         $v1, %gp_rel(Fog_gCurrentKey)($gp)
    /* D18A0 800E10A0 381683AF */  sw         $v1, %gp_rel(D_8013DB84)($gp)
    /* D18A4 800E10A4 02005214 */  bne        $v0, $s2, .L800E10B0
    /* D18A8 800E10A8 1480043C */   lui       $a0, %hi(D_8013DB6C)
    /* D18AC 800E10AC 02001224 */  addiu      $s2, $zero, 0x2
  .L800E10B0:
    /* D18B0 800E10B0 6CDB8424 */  addiu      $a0, $a0, %lo(D_8013DB6C)
    /* D18B4 800E10B4 40291200 */  sll        $a1, $s2, 5
    /* D18B8 800E10B8 2128B200 */  addu       $a1, $a1, $s2
    /* D18BC 800E10BC 80280500 */  sll        $a1, $a1, 2
    /* D18C0 800E10C0 CF94030C */  jal        reservememadr
    /* D18C4 800E10C4 21300000 */   addu      $a2, $zero, $zero
    /* D18C8 800E10C8 401682AF */  sw         $v0, %gp_rel(fogslicePos)($gp)
    /* D18CC 800E10CC 0A004012 */  beqz       $s2, .L800E10F8
    /* D18D0 800E10D0 21800000 */   addu      $s0, $zero, $zero
    /* D18D4 800E10D4 21880002 */  addu       $s1, $s0, $zero
  .L800E10D8:
    /* D18D8 800E10D8 21200000 */  addu       $a0, $zero, $zero
    /* D18DC 800E10DC 4016858F */  lw         $a1, %gp_rel(fogslicePos)($gp)
    /* D18E0 800E10E0 01001026 */  addiu      $s0, $s0, 0x1
    /* D18E4 800E10E4 59FB010C */  jal        BWorldSm_SetSlice__FiP12BWorldSm_Pos
    /* D18E8 800E10E8 2128B100 */   addu      $a1, $a1, $s1
    /* D18EC 800E10EC 2A101202 */  slt        $v0, $s0, $s2
    /* D18F0 800E10F0 F9FF4014 */  bnez       $v0, .L800E10D8
    /* D18F4 800E10F4 84003126 */   addiu     $s1, $s1, 0x84
  .L800E10F8:
    /* D18F8 800E10F8 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* D18FC 800E10FC 1800B28F */  lw         $s2, 0x18($sp)
    /* D1900 800E1100 1400B18F */  lw         $s1, 0x14($sp)
    /* D1904 800E1104 1000B08F */  lw         $s0, 0x10($sp)
    /* D1908 800E1108 0800E003 */  jr         $ra
    /* D190C 800E110C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Fog_InitFogTriggers__Fv
