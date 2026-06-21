.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __25tListIteratorRangeIndexedccPcT3, 0x4C

glabel __25tListIteratorRangeIndexedccPcT3
    /* 14E24 80024624 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 14E28 80024628 1000B0AF */  sw         $s0, 0x10($sp)
    /* 14E2C 8002462C 21808000 */  addu       $s0, $a0, $zero
    /* 14E30 80024630 FF00A530 */  andi       $a1, $a1, 0xFF
    /* 14E34 80024634 1400B1AF */  sw         $s1, 0x14($sp)
    /* 14E38 80024638 3000B18F */  lw         $s1, 0x30($sp)
    /* 14E3C 8002463C 1800BFAF */  sw         $ra, 0x18($sp)
    /* 14E40 80024640 4D91000C */  jal        __18tListIteratorRangeccPc
    /* 14E44 80024644 FF00C630 */   andi      $a2, $a2, 0xFF
    /* 14E48 80024648 21100002 */  addu       $v0, $s0, $zero
    /* 14E4C 8002464C 0180033C */  lui        $v1, %hi(_vt_25tListIteratorRangeIndexed)
    /* 14E50 80024650 D8126324 */  addiu      $v1, $v1, %lo(_vt_25tListIteratorRangeIndexed)
    /* 14E54 80024654 0C0043AC */  sw         $v1, 0xC($v0)
    /* 14E58 80024658 100051AC */  sw         $s1, 0x10($v0)
    /* 14E5C 8002465C 1800BF8F */  lw         $ra, 0x18($sp)
    /* 14E60 80024660 1400B18F */  lw         $s1, 0x14($sp)
    /* 14E64 80024664 1000B08F */  lw         $s0, 0x10($sp)
    /* 14E68 80024668 0800E003 */  jr         $ra
    /* 14E6C 8002466C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __25tListIteratorRangeIndexedccPcT3
