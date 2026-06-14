.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __10AIDelayCarP8Car_tObjT1i, 0x34

glabel __10AIDelayCarP8Car_tObjT1i
    /* 4B228 8005AA28 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4B22C 8005AA2C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4B230 8005AA30 21808000 */  addu       $s0, $a0, $zero
    /* 4B234 8005AA34 1400BFAF */  sw         $ra, 0x14($sp)
    /* 4B238 8005AA38 040005AE */  sw         $a1, 0x4($s0)
    /* 4B23C 8005AA3C 2128C000 */  addu       $a1, $a2, $zero
    /* 4B240 8005AA40 976A010C */  jal        SetNewTargetCar__10AIDelayCarP8Car_tObj
    /* 4B244 8005AA44 000007AE */   sw        $a3, 0x0($s0)
    /* 4B248 8005AA48 21100002 */  addu       $v0, $s0, $zero
    /* 4B24C 8005AA4C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 4B250 8005AA50 1000B08F */  lw         $s0, 0x10($sp)
    /* 4B254 8005AA54 0800E003 */  jr         $ra
    /* 4B258 8005AA58 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __10AIDelayCarP8Car_tObjT1i
