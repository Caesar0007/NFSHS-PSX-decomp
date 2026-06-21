.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __14tScreenMemcard, 0x44

glabel __14tScreenMemcard
    /* 38374 80047B74 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 38378 80047B78 1000B0AF */  sw         $s0, 0x10($sp)
    /* 3837C 80047B7C 1400BFAF */  sw         $ra, 0x14($sp)
    /* 38380 80047B80 0898000C */  jal        __7tScreen
    /* 38384 80047B84 21808000 */   addu      $s0, $a0, $zero
    /* 38388 80047B88 21100002 */  addu       $v0, $s0, $zero
    /* 3838C 80047B8C 0180033C */  lui        $v1, %hi(_vt_14tScreenMemcard)
    /* 38390 80047B90 28226324 */  addiu      $v1, $v1, %lo(_vt_14tScreenMemcard)
    /* 38394 80047B94 600043AC */  sw         $v1, 0x60($v0)
    /* 38398 80047B98 FFFF0324 */  addiu      $v1, $zero, -0x1
    /* 3839C 80047B9C 840543AC */  sw         $v1, 0x584($v0)
    /* 383A0 80047BA0 01000324 */  addiu      $v1, $zero, 0x1
    /* 383A4 80047BA4 680043AC */  sw         $v1, 0x68($v0)
    /* 383A8 80047BA8 1400BF8F */  lw         $ra, 0x14($sp)
    /* 383AC 80047BAC 1000B08F */  lw         $s0, 0x10($sp)
    /* 383B0 80047BB0 0800E003 */  jr         $ra
    /* 383B4 80047BB4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __14tScreenMemcard
