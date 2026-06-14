.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __32tPMenuItemLeftRightSliderIndexedUiPicPc, 0x48

glabel __32tPMenuItemLeftRightSliderIndexedUiPicPc
    /* 9846C 800A7C6C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 98470 800A7C70 1000B0AF */  sw         $s0, 0x10($sp)
    /* 98474 800A7C74 21808000 */  addu       $s0, $a0, $zero
    /* 98478 800A7C78 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9847C 800A7C7C 3000B18F */  lw         $s1, 0x30($sp)
    /* 98480 800A7C80 1800BFAF */  sw         $ra, 0x18($sp)
    /* 98484 800A7C84 0A9E020C */  jal        __25tPMenuItemLeftRightSliderUiPic
    /* 98488 800A7C88 FF00E730 */   andi      $a3, $a3, 0xFF
    /* 9848C 800A7C8C 21100002 */  addu       $v0, $s0, $zero
    /* 98490 800A7C90 0580033C */  lui        $v1, %hi(_vt_32tPMenuItemLeftRightSliderIndexed)
    /* 98494 800A7C94 B4616324 */  addiu      $v1, $v1, %lo(_vt_32tPMenuItemLeftRightSliderIndexed)
    /* 98498 800A7C98 080043AC */  sw         $v1, 0x8($v0)
    /* 9849C 800A7C9C 140051AC */  sw         $s1, 0x14($v0)
    /* 984A0 800A7CA0 1800BF8F */  lw         $ra, 0x18($sp)
    /* 984A4 800A7CA4 1400B18F */  lw         $s1, 0x14($sp)
    /* 984A8 800A7CA8 1000B08F */  lw         $s0, 0x10($sp)
    /* 984AC 800A7CAC 0800E003 */  jr         $ra
    /* 984B0 800A7CB0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __32tPMenuItemLeftRightSliderIndexedUiPicPc
