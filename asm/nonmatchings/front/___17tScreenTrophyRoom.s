.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___17tScreenTrophyRoom, 0x28

glabel ___17tScreenTrophyRoom
    /* 30DB0 800405B0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 30DB4 800405B4 0180023C */  lui        $v0, %hi(_vt_17tScreenTrophyRoom)
    /* 30DB8 800405B8 281E4224 */  addiu      $v0, $v0, %lo(_vt_17tScreenTrophyRoom)
    /* 30DBC 800405BC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 30DC0 800405C0 1E98000C */  jal        ___7tScreen
    /* 30DC4 800405C4 600082AC */   sw        $v0, 0x60($a0)
    /* 30DC8 800405C8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 30DCC 800405CC 00000000 */  nop
    /* 30DD0 800405D0 0800E003 */  jr         $ra
    /* 30DD4 800405D4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___17tScreenTrophyRoom
