.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__20tScreenCarSelectDuel, 0x30

glabel Initialize__20tScreenCarSelectDuel
    /* 2DB04 8003D304 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 2DB08 8003D308 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2DB0C 8003D30C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 2DB10 8003D310 62EF000C */  jal        Initialize__16tScreenCarSelect
    /* 2DB14 8003D314 21808000 */   addu      $s0, $a0, $zero
    /* 2DB18 8003D318 1C0100A6 */  sh         $zero, 0x11C($s0)
    /* 2DB1C 8003D31C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 2DB20 8003D320 1000B08F */  lw         $s0, 0x10($sp)
    /* 2DB24 8003D324 0580023C */  lui        $v0, %hi(gShowroomLights)
    /* 2DB28 8003D328 B41440AC */  sw         $zero, %lo(gShowroomLights)($v0)
    /* 2DB2C 8003D32C 0800E003 */  jr         $ra
    /* 2DB30 8003D330 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Initialize__20tScreenCarSelectDuel
