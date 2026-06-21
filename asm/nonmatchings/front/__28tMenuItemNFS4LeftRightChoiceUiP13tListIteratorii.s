.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii, 0x64

glabel __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
    /* B03C 8001A83C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* B040 8001A840 1000B0AF */  sw         $s0, 0x10($sp)
    /* B044 8001A844 21808000 */  addu       $s0, $a0, $zero
    /* B048 8001A848 1400B1AF */  sw         $s1, 0x14($sp)
    /* B04C 8001A84C 1800B2AF */  sw         $s2, 0x18($sp)
    /* B050 8001A850 3000B28F */  lw         $s2, 0x30($sp)
    /* B054 8001A854 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* B058 8001A858 4192000C */  jal        __24tMenuItemLeftRightChoiceUiP13tListIterator
    /* B05C 8001A85C 2188E000 */   addu      $s1, $a3, $zero
    /* B060 8001A860 21100002 */  addu       $v0, $s0, $zero
    /* B064 8001A864 0180033C */  lui        $v1, %hi(_vt_28tMenuItemNFS4LeftRightChoice)
    /* B068 8001A868 B0086324 */  addiu      $v1, $v1, %lo(_vt_28tMenuItemNFS4LeftRightChoice)
    /* B06C 8001A86C 180043AC */  sw         $v1, 0x18($v0)
    /* B070 8001A870 0E000324 */  addiu      $v1, $zero, 0xE
    /* B074 8001A874 0C0051AC */  sw         $s1, 0xC($v0)
    /* B078 8001A878 200043A4 */  sh         $v1, 0x20($v0)
    /* B07C 8001A87C 220040A4 */  sh         $zero, 0x22($v0)
    /* B080 8001A880 240040A4 */  sh         $zero, 0x24($v0)
    /* B084 8001A884 100052AC */  sw         $s2, 0x10($v0)
    /* B088 8001A888 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* B08C 8001A88C 1800B28F */  lw         $s2, 0x18($sp)
    /* B090 8001A890 1400B18F */  lw         $s1, 0x14($sp)
    /* B094 8001A894 1000B08F */  lw         $s0, 0x10($sp)
    /* B098 8001A898 0800E003 */  jr         $ra
    /* B09C 8001A89C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel __28tMenuItemNFS4LeftRightChoiceUiP13tListIteratorii
