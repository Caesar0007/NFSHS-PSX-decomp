.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Object_InitIMassObjectInfo__Fv, 0x10C

glabel Object_InitIMassObjectInfo__Fv
    /* 966D0 800A5ED0 1480053C */  lui        $a1, %hi(gPersistObjInst)
    /* 966D4 800A5ED4 C0D4A58C */  lw         $a1, %lo(gPersistObjInst)($a1)
    /* 966D8 800A5ED8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 966DC 800A5EDC 1800BFAF */  sw         $ra, 0x18($sp)
    /* 966E0 800A5EE0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 966E4 800A5EE4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 966E8 800A5EE8 900D80AF */  sw         $zero, %gp_rel(gNumIMassObjects)($gp)
    /* 966EC 800A5EEC 8C0D80AF */  sw         $zero, %gp_rel(Object_IMassObjInst)($gp)
    /* 966F0 800A5EF0 3500A010 */  beqz       $a1, .L800A5FC8
    /* 966F4 800A5EF4 00000000 */   nop
    /* 966F8 800A5EF8 1480023C */  lui        $v0, %hi(gPersistObjDef)
    /* 966FC 800A5EFC BCD4428C */  lw         $v0, %lo(gPersistObjDef)($v0)
    /* 96700 800A5F00 00000000 */  nop
    /* 96704 800A5F04 30004010 */  beqz       $v0, .L800A5FC8
    /* 96708 800A5F08 0580043C */   lui       $a0, %hi(D_80056078)
    /* 9670C 800A5F0C 78608424 */  addiu      $a0, $a0, %lo(D_80056078)
    /* 96710 800A5F10 0000A58C */  lw         $a1, 0x0($a1)
    /* 96714 800A5F14 21300000 */  addu       $a2, $zero, $zero
    /* 96718 800A5F18 CF94030C */  jal        reservememadr
    /* 9671C 800A5F1C 40290500 */   sll       $a1, $a1, 5
    /* 96720 800A5F20 8C0D82AF */  sw         $v0, %gp_rel(Object_IMassObjInst)($gp)
    /* 96724 800A5F24 28004010 */  beqz       $v0, .L800A5FC8
    /* 96728 800A5F28 21880000 */   addu      $s1, $zero, $zero
    /* 9672C 800A5F2C 1480023C */  lui        $v0, %hi(gPersistObjInst)
    /* 96730 800A5F30 C0D4428C */  lw         $v0, %lo(gPersistObjInst)($v0)
    /* 96734 800A5F34 00000000 */  nop
    /* 96738 800A5F38 0000438C */  lw         $v1, 0x0($v0)
    /* 9673C 800A5F3C 00000000 */  nop
    /* 96740 800A5F40 21006018 */  blez       $v1, .L800A5FC8
    /* 96744 800A5F44 04005024 */   addiu     $s0, $v0, 0x4
  .L800A5F48:
    /* 96748 800A5F48 02000392 */  lbu        $v1, 0x2($s0)
    /* 9674C 800A5F4C 07000224 */  addiu      $v0, $zero, 0x7
    /* 96750 800A5F50 14006214 */  bne        $v1, $v0, .L800A5FA4
    /* 96754 800A5F54 21280002 */   addu      $a1, $s0, $zero
    /* 96758 800A5F58 1480043C */  lui        $a0, %hi(Track_gObjDefs)
    /* 9675C 800A5F5C D4D4848C */  lw         $a0, %lo(Track_gObjDefs)($a0)
    /* 96760 800A5F60 900D828F */  lw         $v0, %gp_rel(gNumIMassObjects)($gp)
    /* 96764 800A5F64 8C0D838F */  lw         $v1, %gp_rel(Object_IMassObjInst)($gp)
    /* 96768 800A5F68 40110200 */  sll        $v0, $v0, 5
    /* 9676C 800A5F6C 21104300 */  addu       $v0, $v0, $v1
    /* 96770 800A5F70 04004624 */  addiu      $a2, $v0, 0x4
    /* 96774 800A5F74 5697020C */  jal        GetObjMaxDimensions__FPP13Trk_ObjectDefP14Trk_SimpleInstP8coorddef
    /* 96778 800A5F78 000050AC */   sw        $s0, 0x0($v0)
    /* 9677C 800A5F7C 900D848F */  lw         $a0, %gp_rel(gNumIMassObjects)($gp)
    /* 96780 800A5F80 8C0D838F */  lw         $v1, %gp_rel(Object_IMassObjInst)($gp)
    /* 96784 800A5F84 40110400 */  sll        $v0, $a0, 5
    /* 96788 800A5F88 21104300 */  addu       $v0, $v0, $v1
    /* 9678C 800A5F8C 01008424 */  addiu      $a0, $a0, 0x1
    /* 96790 800A5F90 100040AC */  sw         $zero, 0x10($v0)
    /* 96794 800A5F94 140040AC */  sw         $zero, 0x14($v0)
    /* 96798 800A5F98 180040AC */  sw         $zero, 0x18($v0)
    /* 9679C 800A5F9C 1C0040AC */  sw         $zero, 0x1C($v0)
    /* 967A0 800A5FA0 900D84AF */  sw         $a0, %gp_rel(gNumIMassObjects)($gp)
  .L800A5FA4:
    /* 967A4 800A5FA4 01003126 */  addiu      $s1, $s1, 0x1
    /* 967A8 800A5FA8 1480023C */  lui        $v0, %hi(gPersistObjInst)
    /* 967AC 800A5FAC C0D4428C */  lw         $v0, %lo(gPersistObjInst)($v0)
    /* 967B0 800A5FB0 00000386 */  lh         $v1, 0x0($s0)
    /* 967B4 800A5FB4 0000428C */  lw         $v0, 0x0($v0)
    /* 967B8 800A5FB8 00000000 */  nop
    /* 967BC 800A5FBC 2A102202 */  slt        $v0, $s1, $v0
    /* 967C0 800A5FC0 E1FF4014 */  bnez       $v0, .L800A5F48
    /* 967C4 800A5FC4 21800302 */   addu      $s0, $s0, $v1
  .L800A5FC8:
    /* 967C8 800A5FC8 1800BF8F */  lw         $ra, 0x18($sp)
    /* 967CC 800A5FCC 1400B18F */  lw         $s1, 0x14($sp)
    /* 967D0 800A5FD0 1000B08F */  lw         $s0, 0x10($sp)
    /* 967D4 800A5FD4 0800E003 */  jr         $ra
    /* 967D8 800A5FD8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Object_InitIMassObjectInfo__Fv
