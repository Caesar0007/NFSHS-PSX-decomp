.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Audio_FECleanUp__Fv, 0x48

glabel Audio_FECleanUp__Fv
    /* AC51C 800BBD1C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* AC520 800BBD20 FFFF0424 */  addiu      $a0, $zero, -0x1
    /* AC524 800BBD24 1400BFAF */  sw         $ra, 0x14($sp)
    /* AC528 800BBD28 9D99030C */  jal        SNDbankremove
    /* AC52C 800BBD2C 1000B0AF */   sw        $s0, 0x10($sp)
    /* AC530 800BBD30 1180023C */  lui        $v0, %hi(gSndBnk)
    /* AC534 800BBD34 A8E85024 */  addiu      $s0, $v0, %lo(gSndBnk)
    /* AC538 800BBD38 0800048E */  lw         $a0, 0x8($s0)
    /* AC53C 800BBD3C 00000000 */  nop
    /* AC540 800BBD40 04008010 */  beqz       $a0, .L800BBD54
    /* AC544 800BBD44 00000000 */   nop
    /* AC548 800BBD48 5095030C */  jal        purgememadr
    /* AC54C 800BBD4C 00000000 */   nop
    /* AC550 800BBD50 080000AE */  sw         $zero, 0x8($s0)
  .L800BBD54:
    /* AC554 800BBD54 1400BF8F */  lw         $ra, 0x14($sp)
    /* AC558 800BBD58 1000B08F */  lw         $s0, 0x10($sp)
    /* AC55C 800BBD5C 0800E003 */  jr         $ra
    /* AC560 800BBD60 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Audio_FECleanUp__Fv
