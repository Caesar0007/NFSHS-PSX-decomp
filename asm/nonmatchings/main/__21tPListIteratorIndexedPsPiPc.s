.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __21tPListIteratorIndexedPsPiPc, 0x44

glabel __21tPListIteratorIndexedPsPiPc
    /* 979B0 800A71B0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 979B4 800A71B4 1000B0AF */  sw         $s0, 0x10($sp)
    /* 979B8 800A71B8 21808000 */  addu       $s0, $a0, $zero
    /* 979BC 800A71BC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 979C0 800A71C0 1800BFAF */  sw         $ra, 0x18($sp)
    /* 979C4 800A71C4 FC9B020C */  jal        __14tPListIteratorPsPi
    /* 979C8 800A71C8 2188E000 */   addu      $s1, $a3, $zero
    /* 979CC 800A71CC 21100002 */  addu       $v0, $s0, $zero
    /* 979D0 800A71D0 0580033C */  lui        $v1, %hi(_vt_21tPListIteratorIndexed)
    /* 979D4 800A71D4 04636324 */  addiu      $v1, $v1, %lo(_vt_21tPListIteratorIndexed)
    /* 979D8 800A71D8 080043AC */  sw         $v1, 0x8($v0)
    /* 979DC 800A71DC 0C0051AC */  sw         $s1, 0xC($v0)
    /* 979E0 800A71E0 1800BF8F */  lw         $ra, 0x18($sp)
    /* 979E4 800A71E4 1400B18F */  lw         $s1, 0x14($sp)
    /* 979E8 800A71E8 1000B08F */  lw         $s0, 0x10($sp)
    /* 979EC 800A71EC 0800E003 */  jr         $ra
    /* 979F0 800A71F0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __21tPListIteratorIndexedPsPiPc
