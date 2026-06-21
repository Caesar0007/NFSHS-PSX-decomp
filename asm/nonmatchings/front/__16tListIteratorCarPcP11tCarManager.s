.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __16tListIteratorCarPcP11tCarManager, 0x5C

glabel __16tListIteratorCarPcP11tCarManager
    /* 80CC 800178CC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 80D0 800178D0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 80D4 800178D4 21808000 */  addu       $s0, $a0, $zero
    /* 80D8 800178D8 2110A000 */  addu       $v0, $a1, $zero
    /* 80DC 800178DC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 80E0 800178E0 2188C000 */  addu       $s1, $a2, $zero
    /* 80E4 800178E4 21280000 */  addu       $a1, $zero, $zero
    /* 80E8 800178E8 1800BFAF */  sw         $ra, 0x18($sp)
    /* 80EC 800178EC 748F000C */  jal        __13tListIteratorPsPc
    /* 80F0 800178F0 21304000 */   addu      $a2, $v0, $zero
    /* 80F4 800178F4 21100002 */  addu       $v0, $s0, $zero
    /* 80F8 800178F8 0180033C */  lui        $v1, %hi(_vt_16tListIteratorCar)
    /* 80FC 800178FC 08026324 */  addiu      $v1, $v1, %lo(_vt_16tListIteratorCar)
    /* 8100 80017900 0C0043AC */  sw         $v1, 0xC($v0)
    /* 8104 80017904 01000324 */  addiu      $v1, $zero, 0x1
    /* 8108 80017908 140051AC */  sw         $s1, 0x14($v0)
    /* 810C 8001790C 100043AC */  sw         $v1, 0x10($v0)
    /* 8110 80017910 180040AC */  sw         $zero, 0x18($v0)
    /* 8114 80017914 1800BF8F */  lw         $ra, 0x18($sp)
    /* 8118 80017918 1400B18F */  lw         $s1, 0x14($sp)
    /* 811C 8001791C 1000B08F */  lw         $s0, 0x10($sp)
    /* 8120 80017920 0800E003 */  jr         $ra
    /* 8124 80017924 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __16tListIteratorCarPcP11tCarManager
