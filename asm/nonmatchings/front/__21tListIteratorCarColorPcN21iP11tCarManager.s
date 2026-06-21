.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __21tListIteratorCarColorPcN21iP11tCarManager, 0x80

glabel __21tListIteratorCarColorPcN21iP11tCarManager
    /* 8CA0 800184A0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 8CA4 800184A4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 8CA8 800184A8 21808000 */  addu       $s0, $a0, $zero
    /* 8CAC 800184AC 2110A000 */  addu       $v0, $a1, $zero
    /* 8CB0 800184B0 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 8CB4 800184B4 2198C000 */  addu       $s3, $a2, $zero
    /* 8CB8 800184B8 2000B4AF */  sw         $s4, 0x20($sp)
    /* 8CBC 800184BC 21A0E000 */  addu       $s4, $a3, $zero
    /* 8CC0 800184C0 1400B1AF */  sw         $s1, 0x14($sp)
    /* 8CC4 800184C4 3800B18F */  lw         $s1, 0x38($sp)
    /* 8CC8 800184C8 21280000 */  addu       $a1, $zero, $zero
    /* 8CCC 800184CC 1800B2AF */  sw         $s2, 0x18($sp)
    /* 8CD0 800184D0 3C00B28F */  lw         $s2, 0x3C($sp)
    /* 8CD4 800184D4 2400BFAF */  sw         $ra, 0x24($sp)
    /* 8CD8 800184D8 748F000C */  jal        __13tListIteratorPsPc
    /* 8CDC 800184DC 21304000 */   addu      $a2, $v0, $zero
    /* 8CE0 800184E0 21100002 */  addu       $v0, $s0, $zero
    /* 8CE4 800184E4 0180033C */  lui        $v1, %hi(_vt_21tListIteratorCarColor)
    /* 8CE8 800184E8 D8016324 */  addiu      $v1, $v1, %lo(_vt_21tListIteratorCarColor)
    /* 8CEC 800184EC 0C0043AC */  sw         $v1, 0xC($v0)
    /* 8CF0 800184F0 100053AC */  sw         $s3, 0x10($v0)
    /* 8CF4 800184F4 140054AC */  sw         $s4, 0x14($v0)
    /* 8CF8 800184F8 180051AC */  sw         $s1, 0x18($v0)
    /* 8CFC 800184FC 1C0052AC */  sw         $s2, 0x1C($v0)
    /* 8D00 80018500 2400BF8F */  lw         $ra, 0x24($sp)
    /* 8D04 80018504 2000B48F */  lw         $s4, 0x20($sp)
    /* 8D08 80018508 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 8D0C 8001850C 1800B28F */  lw         $s2, 0x18($sp)
    /* 8D10 80018510 1400B18F */  lw         $s1, 0x14($sp)
    /* 8D14 80018514 1000B08F */  lw         $s0, 0x10($sp)
    /* 8D18 80018518 0800E003 */  jr         $ra
    /* 8D1C 8001851C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel __21tListIteratorCarColorPcN21iP11tCarManager
