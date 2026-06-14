.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __18AIHigh_BTC_WingmanP8Car_tObji, 0x4C

glabel __18AIHigh_BTC_WingmanP8Car_tObji
    /* 4EAF0 8005E2F0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4EAF4 8005E2F4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 4EAF8 8005E2F8 1400BFAF */  sw         $ra, 0x14($sp)
    /* 4EAFC 8005E2FC DB72010C */  jal        __14AIHigh_BTC_CopP8Car_tObji
    /* 4EB00 8005E300 21808000 */   addu      $s0, $a0, $zero
    /* 4EB04 8005E304 21100002 */  addu       $v0, $s0, $zero
    /* 4EB08 8005E308 0580033C */  lui        $v1, %hi(_vt_18AIHigh_BTC_Wingman)
    /* 4EB0C 8005E30C C44E6324 */  addiu      $v1, $v1, %lo(_vt_18AIHigh_BTC_Wingman)
    /* 4EB10 8005E310 140043AC */  sw         $v1, 0x14($v0)
    /* 4EB14 8005E314 700040AC */  sw         $zero, 0x70($v0)
    /* 4EB18 8005E318 740040AC */  sw         $zero, 0x74($v0)
    /* 4EB1C 8005E31C 780040AC */  sw         $zero, 0x78($v0)
    /* 4EB20 8005E320 640040AC */  sw         $zero, 0x64($v0)
    /* 4EB24 8005E324 680040AC */  sw         $zero, 0x68($v0)
    /* 4EB28 8005E328 6C0040AC */  sw         $zero, 0x6C($v0)
    /* 4EB2C 8005E32C 1400BF8F */  lw         $ra, 0x14($sp)
    /* 4EB30 8005E330 1000B08F */  lw         $s0, 0x10($sp)
    /* 4EB34 8005E334 0800E003 */  jr         $ra
    /* 4EB38 8005E338 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel __18AIHigh_BTC_WingmanP8Car_tObji
