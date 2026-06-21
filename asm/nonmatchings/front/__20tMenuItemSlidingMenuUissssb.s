.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __20tMenuItemSlidingMenuUissssb, 0xA8

glabel __20tMenuItemSlidingMenuUissssb
    /* D960 8001D160 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* D964 8001D164 1400B1AF */  sw         $s1, 0x14($sp)
    /* D968 8001D168 4000B18F */  lw         $s1, 0x40($sp)
    /* D96C 8001D16C 1800B2AF */  sw         $s2, 0x18($sp)
    /* D970 8001D170 4400B28F */  lw         $s2, 0x44($sp)
    /* D974 8001D174 1000B0AF */  sw         $s0, 0x10($sp)
    /* D978 8001D178 21808000 */  addu       $s0, $a0, $zero
    /* D97C 8001D17C 2000B4AF */  sw         $s4, 0x20($sp)
    /* D980 8001D180 21A0C000 */  addu       $s4, $a2, $zero
    /* D984 8001D184 2400B5AF */  sw         $s5, 0x24($sp)
    /* D988 8001D188 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D98C 8001D18C 4800B38F */  lw         $s3, 0x48($sp)
    /* D990 8001D190 2800BFAF */  sw         $ra, 0x28($sp)
    /* D994 8001D194 CD91000C */  jal        __9tMenuItemUi
    /* D998 8001D198 21A8E000 */   addu      $s5, $a3, $zero
    /* D99C 8001D19C 0000038E */  lw         $v1, 0x0($s0)
    /* D9A0 8001D1A0 21100002 */  addu       $v0, $s0, $zero
    /* D9A4 8001D1A4 1C0040AC */  sw         $zero, 0x1C($v0)
    /* D9A8 8001D1A8 200040AC */  sw         $zero, 0x20($v0)
    /* D9AC 8001D1AC 240054A4 */  sh         $s4, 0x24($v0)
    /* D9B0 8001D1B0 260055A4 */  sh         $s5, 0x26($v0)
    /* D9B4 8001D1B4 080040A4 */  sh         $zero, 0x8($v0)
    /* D9B8 8001D1B8 80006334 */  ori        $v1, $v1, 0x80
    /* D9BC 8001D1BC 000043AC */  sw         $v1, 0x0($v0)
    /* D9C0 8001D1C0 0180033C */  lui        $v1, %hi(_vt_20tMenuItemSlidingMenu)
    /* D9C4 8001D1C4 0000448C */  lw         $a0, 0x0($v0)
    /* D9C8 8001D1C8 480E6324 */  addiu      $v1, $v1, %lo(_vt_20tMenuItemSlidingMenu)
    /* D9CC 8001D1CC 180043AC */  sw         $v1, 0x18($v0)
    /* D9D0 8001D1D0 3C0051A4 */  sh         $s1, 0x3C($v0)
    /* D9D4 8001D1D4 3E0052A4 */  sh         $s2, 0x3E($v0)
    /* D9D8 8001D1D8 400053AC */  sw         $s3, 0x40($v0)
    /* D9DC 8001D1DC 80008434 */  ori        $a0, $a0, 0x80
    /* D9E0 8001D1E0 000044AC */  sw         $a0, 0x0($v0)
    /* D9E4 8001D1E4 2800BF8F */  lw         $ra, 0x28($sp)
    /* D9E8 8001D1E8 2400B58F */  lw         $s5, 0x24($sp)
    /* D9EC 8001D1EC 2000B48F */  lw         $s4, 0x20($sp)
    /* D9F0 8001D1F0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D9F4 8001D1F4 1800B28F */  lw         $s2, 0x18($sp)
    /* D9F8 8001D1F8 1400B18F */  lw         $s1, 0x14($sp)
    /* D9FC 8001D1FC 1000B08F */  lw         $s0, 0x10($sp)
    /* DA00 8001D200 0800E003 */  jr         $ra
    /* DA04 8001D204 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel __20tMenuItemSlidingMenuUissssb
