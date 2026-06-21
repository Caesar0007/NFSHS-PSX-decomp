.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__25tScreenPinkSlipsCarSelectRsT1PPcT3, 0x98

glabel GetShapeInfo__25tScreenPinkSlipsCarSelectRsT1PPcT3
    /* 2FE38 8003F638 10FFBD27 */  addiu      $sp, $sp, -0xF0
    /* 2FE3C 8003F63C 21188000 */  addu       $v1, $a0, $zero
    /* 2FE40 8003F640 1180043C */  lui        $a0, %hi(carManager)
    /* 2FE44 8003F644 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 2FE48 8003F648 E800B2AF */  sw         $s2, 0xE8($sp)
    /* 2FE4C 8003F64C 0001B28F */  lw         $s2, 0x100($sp)
    /* 2FE50 8003F650 34000224 */  addiu      $v0, $zero, 0x34
    /* 2FE54 8003F654 EC00BFAF */  sw         $ra, 0xEC($sp)
    /* 2FE58 8003F658 E400B1AF */  sw         $s1, 0xE4($sp)
    /* 2FE5C 8003F65C E000B0AF */  sw         $s0, 0xE0($sp)
    /* 2FE60 8003F660 0000A2A4 */  sh         $v0, 0x0($a1)
    /* 2FE64 8003F664 21280000 */  addu       $a1, $zero, $zero
    /* 2FE68 8003F668 05000224 */  addiu      $v0, $zero, 0x5
    /* 2FE6C 8003F66C 0000C2A4 */  sh         $v0, 0x0($a2)
    /* 2FE70 8003F670 1000A627 */  addiu      $a2, $sp, 0x10
    /* 2FE74 8003F674 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 2FE78 8003F678 2188E000 */  addu       $s1, $a3, $zero
    /* 2FE7C 8003F67C 1E0162A4 */  sh         $v0, 0x11E($v1)
    /* 2FE80 8003F680 200162A4 */  sh         $v0, 0x120($v1)
    /* 2FE84 8003F684 A45B000C */  jal        GetStockCar__11tCarManagersR8tCarInfo
    /* 2FE88 8003F688 220162A4 */   sh        $v0, 0x122($v1)
    /* 2FE8C 8003F68C 0580103C */  lui        $s0, %hi(D_80052C28)
    /* 2FE90 8003F690 282C1026 */  addiu      $s0, $s0, %lo(D_80052C28)
    /* 2FE94 8003F694 21200002 */  addu       $a0, $s0, $zero
    /* 2FE98 8003F698 0180053C */  lui        $a1, %hi(D_80011ADC)
    /* 2FE9C 8003F69C DC1AA524 */  addiu      $a1, $a1, %lo(D_80011ADC)
    /* 2FEA0 8003F6A0 2000A627 */  addiu      $a2, $sp, 0x20
    /* 2FEA4 8003F6A4 0180023C */  lui        $v0, %hi(D_80011B30)
    /* 2FEA8 8003F6A8 301B4224 */  addiu      $v0, $v0, %lo(D_80011B30)
    /* 2FEAC 8003F6AC 2F91030C */  jal        sprintf
    /* 2FEB0 8003F6B0 000022AE */   sw        $v0, 0x0($s1)
    /* 2FEB4 8003F6B4 000050AE */  sw         $s0, 0x0($s2)
    /* 2FEB8 8003F6B8 EC00BF8F */  lw         $ra, 0xEC($sp)
    /* 2FEBC 8003F6BC E800B28F */  lw         $s2, 0xE8($sp)
    /* 2FEC0 8003F6C0 E400B18F */  lw         $s1, 0xE4($sp)
    /* 2FEC4 8003F6C4 E000B08F */  lw         $s0, 0xE0($sp)
    /* 2FEC8 8003F6C8 0800E003 */  jr         $ra
    /* 2FECC 8003F6CC F000BD27 */   addiu     $sp, $sp, 0xF0
endlabel GetShapeInfo__25tScreenPinkSlipsCarSelectRsT1PPcT3
