.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching vramimage, 0x48

glabel vramimage
    /* E7160 800F6960 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* E7164 800F6964 1000B0AF */  sw         $s0, 0x10($sp)
    /* E7168 800F6968 21808000 */  addu       $s0, $a0, $zero
    /* E716C 800F696C 1400B1AF */  sw         $s1, 0x14($sp)
    /* E7170 800F6970 1800BFAF */  sw         $ra, 0x18($sp)
    /* E7174 800F6974 4DDA030C */  jal        checkrect
    /* E7178 800F6978 2188A000 */   addu      $s1, $a1, $zero
    /* E717C 800F697C 21200002 */  addu       $a0, $s0, $zero
    /* E7180 800F6980 A4B6030C */  jal        LoadImage
    /* E7184 800F6984 21282002 */   addu      $a1, $s1, $zero
    /* E7188 800F6988 1800BF8F */  lw         $ra, 0x18($sp)
    /* E718C 800F698C 1400B18F */  lw         $s1, 0x14($sp)
    /* E7190 800F6990 1000B08F */  lw         $s0, 0x10($sp)
    /* E7194 800F6994 01000224 */  addiu      $v0, $zero, 0x1
    /* E7198 800F6998 1480013C */  lui        $at, %hi(drawpending)
    /* E719C 800F699C 10DD22AC */  sw         $v0, %lo(drawpending)($at)
    /* E71A0 800F69A0 0800E003 */  jr         $ra
    /* E71A4 800F69A4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel vramimage
