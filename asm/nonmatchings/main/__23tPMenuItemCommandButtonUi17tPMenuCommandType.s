.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __23tPMenuItemCommandButtonUi17tPMenuCommandType, 0x44

glabel __23tPMenuItemCommandButtonUi17tPMenuCommandType
    /* 986B0 800A7EB0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 986B4 800A7EB4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 986B8 800A7EB8 21808000 */  addu       $s0, $a0, $zero
    /* 986BC 800A7EBC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 986C0 800A7EC0 1800BFAF */  sw         $ra, 0x18($sp)
    /* 986C4 800A7EC4 359D020C */  jal        __21tPMenuItemInteractiveUi
    /* 986C8 800A7EC8 2188C000 */   addu      $s1, $a2, $zero
    /* 986CC 800A7ECC 21100002 */  addu       $v0, $s0, $zero
    /* 986D0 800A7ED0 0580033C */  lui        $v1, %hi(_vt_23tPMenuItemCommandButton)
    /* 986D4 800A7ED4 44616324 */  addiu      $v1, $v1, %lo(_vt_23tPMenuItemCommandButton)
    /* 986D8 800A7ED8 080043AC */  sw         $v1, 0x8($v0)
    /* 986DC 800A7EDC 0C0051AC */  sw         $s1, 0xC($v0)
    /* 986E0 800A7EE0 1800BF8F */  lw         $ra, 0x18($sp)
    /* 986E4 800A7EE4 1400B18F */  lw         $s1, 0x14($sp)
    /* 986E8 800A7EE8 1000B08F */  lw         $s0, 0x10($sp)
    /* 986EC 800A7EEC 0800E003 */  jr         $ra
    /* 986F0 800A7EF0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __23tPMenuItemCommandButtonUi17tPMenuCommandType
