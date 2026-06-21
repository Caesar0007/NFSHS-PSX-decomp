.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetCar__23tScreenBeTheCopCongratsR8tCarInfo, 0x60

glabel GetCar__23tScreenBeTheCopCongratsR8tCarInfo
    /* 39C7C 8004947C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 39C80 80049480 1400B1AF */  sw         $s1, 0x14($sp)
    /* 39C84 80049484 2188A000 */  addu       $s1, $a1, $zero
    /* 39C88 80049488 1000B0AF */  sw         $s0, 0x10($sp)
    /* 39C8C 8004948C 1180103C */  lui        $s0, %hi(frontEnd)
    /* 39C90 80049490 00461026 */  addiu      $s0, $s0, %lo(frontEnd)
    /* 39C94 80049494 1180043C */  lui        $a0, %hi(carManager)
    /* 39C98 80049498 1800BFAF */  sw         $ra, 0x18($sp)
    /* 39C9C 8004949C 2D010592 */  lbu        $a1, 0x12D($s0)
    /* 39CA0 800494A0 9358000C */  jal        GetCarFromID__11tCarManagers
    /* 39CA4 800494A4 74428424 */   addiu     $a0, $a0, %lo(carManager)
    /* 39CA8 800494A8 21204000 */  addu       $a0, $v0, $zero
    /* 39CAC 800494AC 21282002 */  addu       $a1, $s1, $zero
    /* 39CB0 800494B0 B798030C */  jal        blockmove
    /* 39CB4 800494B4 CC000624 */   addiu     $a2, $zero, 0xCC
    /* 39CB8 800494B8 2E010392 */  lbu        $v1, 0x12E($s0)
    /* 39CBC 800494BC 00000000 */  nop
    /* 39CC0 800494C0 C70023A2 */  sb         $v1, 0xC7($s1)
    /* 39CC4 800494C4 1800BF8F */  lw         $ra, 0x18($sp)
    /* 39CC8 800494C8 1400B18F */  lw         $s1, 0x14($sp)
    /* 39CCC 800494CC 1000B08F */  lw         $s0, 0x10($sp)
    /* 39CD0 800494D0 01000224 */  addiu      $v0, $zero, 0x1
    /* 39CD4 800494D4 0800E003 */  jr         $ra
    /* 39CD8 800494D8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel GetCar__23tScreenBeTheCopCongratsR8tCarInfo
