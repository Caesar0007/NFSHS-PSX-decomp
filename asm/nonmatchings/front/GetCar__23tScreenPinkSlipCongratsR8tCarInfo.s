.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetCar__23tScreenPinkSlipCongratsR8tCarInfo, 0x78

glabel GetCar__23tScreenPinkSlipCongratsR8tCarInfo
    /* 39464 80048C64 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 39468 80048C68 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3946C 80048C6C 2180A000 */  addu       $s0, $a1, $zero
    /* 39470 80048C70 1180063C */  lui        $a2, %hi(carManager)
    /* 39474 80048C74 1180033C */  lui        $v1, %hi(frontEnd)
    /* 39478 80048C78 00466324 */  addiu      $v1, $v1, %lo(frontEnd)
    /* 3947C 80048C7C 01000724 */  addiu      $a3, $zero, 0x1
    /* 39480 80048C80 1400BFAF */  sw         $ra, 0x14($sp)
    /* 39484 80048C84 84018584 */  lh         $a1, 0x184($a0)
    /* 39488 80048C88 84018294 */  lhu        $v0, 0x184($a0)
    /* 3948C 80048C8C 7442C424 */  addiu      $a0, $a2, %lo(carManager)
    /* 39490 80048C90 21300002 */  addu       $a2, $s0, $zero
    /* 39494 80048C94 2328E500 */  subu       $a1, $a3, $a1
    /* 39498 80048C98 2128A300 */  addu       $a1, $a1, $v1
    /* 3949C 80048C9C 2338E200 */  subu       $a3, $a3, $v0
    /* 394A0 80048CA0 003C0700 */  sll        $a3, $a3, 16
    /* 394A4 80048CA4 2501A590 */  lbu        $a1, 0x125($a1)
    /* 394A8 80048CA8 165C000C */  jal        GetPinkSlipsCar__11tCarManagersR8tCarInfos
    /* 394AC 80048CAC 033C0700 */   sra       $a3, $a3, 16
    /* 394B0 80048CB0 C5000292 */  lbu        $v0, 0xC5($s0)
    /* 394B4 80048CB4 00000000 */  nop
    /* 394B8 80048CB8 21100202 */  addu       $v0, $s0, $v0
    /* 394BC 80048CBC AF004290 */  lbu        $v0, 0xAF($v0)
    /* 394C0 80048CC0 00000000 */  nop
    /* 394C4 80048CC4 C50002A2 */  sb         $v0, 0xC5($s0)
    /* 394C8 80048CC8 1400BF8F */  lw         $ra, 0x14($sp)
    /* 394CC 80048CCC 1000B08F */  lw         $s0, 0x10($sp)
    /* 394D0 80048CD0 01000224 */  addiu      $v0, $zero, 0x1
    /* 394D4 80048CD4 0800E003 */  jr         $ra
    /* 394D8 80048CD8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel GetCar__23tScreenPinkSlipCongratsR8tCarInfo
