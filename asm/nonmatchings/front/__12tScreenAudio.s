.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __12tScreenAudio, 0x40

glabel __12tScreenAudio
    /* 36964 80046164 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 36968 80046168 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3696C 8004616C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 36970 80046170 0898000C */  jal        __7tScreen
    /* 36974 80046174 21808000 */   addu      $s0, $a0, $zero
    /* 36978 80046178 21100002 */  addu       $v0, $s0, $zero
    /* 3697C 8004617C 0180033C */  lui        $v1, %hi(_vt_12tScreenAudio)
    /* 36980 80046180 58216324 */  addiu      $v1, $v1, %lo(_vt_12tScreenAudio)
    /* 36984 80046184 600043AC */  sw         $v1, 0x60($v0)
    /* 36988 80046188 740040A4 */  sh         $zero, 0x74($v0)
    /* 3698C 8004618C 720040A0 */  sb         $zero, 0x72($v0)
    /* 36990 80046190 780040AC */  sw         $zero, 0x78($v0)
    /* 36994 80046194 1400BF8F */  lw         $ra, 0x14($sp)
    /* 36998 80046198 1000B08F */  lw         $s0, 0x10($sp)
    /* 3699C 8004619C 0800E003 */  jr         $ra
    /* 369A0 800461A0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __12tScreenAudio
