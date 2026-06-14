.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AILife_PlaceCarAtLocation__FP8Car_tObjiiiii, 0x3C

glabel AILife_PlaceCarAtLocation__FP8Car_tObjiiiii
    /* 58450 80067C50 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 58454 80067C54 1000BFAF */  sw         $ra, 0x10($sp)
    /* 58458 80067C58 580586AC */  sw         $a2, 0x558($a0)
    /* 5845C 80067C5C 2800A28F */  lw         $v0, 0x28($sp)
    /* 58460 80067C60 540587AC */  sw         $a3, 0x554($a0)
    /* 58464 80067C64 500587AC */  sw         $a3, 0x550($a0)
    /* 58468 80067C68 080085A4 */  sh         $a1, 0x8($a0)
    /* 5846C 80067C6C 640582AC */  sw         $v0, 0x564($a0)
    /* 58470 80067C70 2C00A58F */  lw         $a1, 0x2C($sp)
    /* 58474 80067C74 389F010C */  jal        AILife_PlaceCarAtLocation__FP8Car_tObji
    /* 58478 80067C78 00000000 */   nop
    /* 5847C 80067C7C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 58480 80067C80 00000000 */  nop
    /* 58484 80067C84 0800E003 */  jr         $ra
    /* 58488 80067C88 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AILife_PlaceCarAtLocation__FP8Car_tObjiiiii
