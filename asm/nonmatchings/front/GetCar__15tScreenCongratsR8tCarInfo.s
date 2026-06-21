.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetCar__15tScreenCongratsR8tCarInfo, 0x58

glabel GetCar__15tScreenCongratsR8tCarInfo
    /* 388E4 800480E4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 388E8 800480E8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 388EC 800480EC 2180A000 */  addu       $s0, $a1, $zero
    /* 388F0 800480F0 1180043C */  lui        $a0, %hi(carManager)
    /* 388F4 800480F4 1180023C */  lui        $v0, %hi(D_80114723)
    /* 388F8 800480F8 74428424 */  addiu      $a0, $a0, %lo(carManager)
    /* 388FC 800480FC 21300002 */  addu       $a2, $s0, $zero
    /* 38900 80048100 23474590 */  lbu        $a1, %lo(D_80114723)($v0)
    /* 38904 80048104 1400BFAF */  sw         $ra, 0x14($sp)
    /* 38908 80048108 D35B000C */  jal        GetGarageCar__11tCarManagersR8tCarInfos
    /* 3890C 8004810C 21380000 */   addu      $a3, $zero, $zero
    /* 38910 80048110 C5000292 */  lbu        $v0, 0xC5($s0)
    /* 38914 80048114 00000000 */  nop
    /* 38918 80048118 21100202 */  addu       $v0, $s0, $v0
    /* 3891C 8004811C AF004290 */  lbu        $v0, 0xAF($v0)
    /* 38920 80048120 00000000 */  nop
    /* 38924 80048124 C50002A2 */  sb         $v0, 0xC5($s0)
    /* 38928 80048128 1400BF8F */  lw         $ra, 0x14($sp)
    /* 3892C 8004812C 1000B08F */  lw         $s0, 0x10($sp)
    /* 38930 80048130 01000224 */  addiu      $v0, $zero, 0x1
    /* 38934 80048134 0800E003 */  jr         $ra
    /* 38938 80048138 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel GetCar__15tScreenCongratsR8tCarInfo
