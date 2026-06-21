.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FeDraw_SetABRMode__Fi, 0x9C

glabel FeDraw_SetABRMode__Fi
    /* 3DED8 8004D6D8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 3DEDC 8004D6DC 21288000 */  addu       $a1, $a0, $zero
    /* 3DEE0 8004D6E0 801F0B3C */  lui        $t3, (0x1F800004 >> 16)
    /* 3DEE4 8004D6E4 04006B35 */  ori        $t3, $t3, (0x1F800004 & 0xFFFF)
    /* 3DEE8 8004D6E8 FF00093C */  lui        $t1, (0xFFFFFF >> 16)
    /* 3DEEC 8004D6EC FFFF2935 */  ori        $t1, $t1, (0xFFFFFF & 0xFFFF)
    /* 3DEF0 8004D6F0 02000424 */  addiu      $a0, $zero, 0x2
    /* 3DEF4 8004D6F4 21300000 */  addu       $a2, $zero, $zero
    /* 3DEF8 8004D6F8 00010724 */  addiu      $a3, $zero, 0x100
    /* 3DEFC 8004D6FC 00FF0A3C */  lui        $t2, (0xFF000000 >> 16)
    /* 3DF00 8004D700 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 3DF04 8004D704 1800B0AF */  sw         $s0, 0x18($sp)
    /* 3DF08 8004D708 0000708D */  lw         $s0, 0x0($t3)
    /* 3DF0C 8004D70C 801F083C */  lui        $t0, (0x1F800000 >> 16)
    /* 3DF10 8004D710 0000088D */  lw         $t0, (0x1F800000 & 0xFFFF)($t0)
    /* 3DF14 8004D714 0000038E */  lw         $v1, 0x0($s0)
    /* 3DF18 8004D718 0000028D */  lw         $v0, 0x0($t0)
    /* 3DF1C 8004D71C 24186A00 */  and        $v1, $v1, $t2
    /* 3DF20 8004D720 24104900 */  and        $v0, $v0, $t1
    /* 3DF24 8004D724 25186200 */  or         $v1, $v1, $v0
    /* 3DF28 8004D728 000003AE */  sw         $v1, 0x0($s0)
    /* 3DF2C 8004D72C 0C000326 */  addiu      $v1, $s0, 0xC
    /* 3DF30 8004D730 0000028D */  lw         $v0, 0x0($t0)
    /* 3DF34 8004D734 24480902 */  and        $t1, $s0, $t1
    /* 3DF38 8004D738 000063AD */  sw         $v1, 0x0($t3)
    /* 3DF3C 8004D73C 24104A00 */  and        $v0, $v0, $t2
    /* 3DF40 8004D740 25104900 */  or         $v0, $v0, $t1
    /* 3DF44 8004D744 FFC6030C */  jal        GetTPage
    /* 3DF48 8004D748 000002AD */   sw        $v0, 0x0($t0)
    /* 3DF4C 8004D74C 21200002 */  addu       $a0, $s0, $zero
    /* 3DF50 8004D750 21280000 */  addu       $a1, $zero, $zero
    /* 3DF54 8004D754 2130A000 */  addu       $a2, $a1, $zero
    /* 3DF58 8004D758 FFFF4730 */  andi       $a3, $v0, 0xFFFF
    /* 3DF5C 8004D75C EFB8030C */  jal        SetDrawMode
    /* 3DF60 8004D760 1000A0AF */   sw        $zero, 0x10($sp)
    /* 3DF64 8004D764 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 3DF68 8004D768 1800B08F */  lw         $s0, 0x18($sp)
    /* 3DF6C 8004D76C 0800E003 */  jr         $ra
    /* 3DF70 8004D770 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FeDraw_SetABRMode__Fi
    /* 3DF74 8004D774 00000000 */  nop
