.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__23tPMenuItemCommandButtonR13tInputKeyTypeR13tPMenuCommand, 0x60

glabel ProcessInput__23tPMenuItemCommandButtonR13tInputKeyTypeR13tPMenuCommand
    /* 9871C 800A7F1C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 98720 800A7F20 1000B0AF */  sw         $s0, 0x10($sp)
    /* 98724 800A7F24 21808000 */  addu       $s0, $a0, $zero
    /* 98728 800A7F28 1400B1AF */  sw         $s1, 0x14($sp)
    /* 9872C 800A7F2C 2188A000 */  addu       $s1, $a1, $zero
    /* 98730 800A7F30 1800B2AF */  sw         $s2, 0x18($sp)
    /* 98734 800A7F34 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 98738 800A7F38 0000238E */  lw         $v1, 0x0($s1)
    /* 9873C 800A7F3C 02000224 */  addiu      $v0, $zero, 0x2
    /* 98740 800A7F40 08006214 */  bne        $v1, $v0, .L800A7F64
    /* 98744 800A7F44 2190C000 */   addu      $s2, $a2, $zero
    /* 98748 800A7F48 B9E5010C */  jal        AudioCmn_PlayPauseSound__Fi
    /* 9874C 800A7F4C 04000424 */   addiu     $a0, $zero, 0x4
    /* 98750 800A7F50 0C00028E */  lw         $v0, 0xC($s0)
    /* 98754 800A7F54 00000000 */  nop
    /* 98758 800A7F58 000042AE */  sw         $v0, 0x0($s2)
    /* 9875C 800A7F5C 01000224 */  addiu      $v0, $zero, 0x1
    /* 98760 800A7F60 000022AE */  sw         $v0, 0x0($s1)
  .L800A7F64:
    /* 98764 800A7F64 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 98768 800A7F68 1800B28F */  lw         $s2, 0x18($sp)
    /* 9876C 800A7F6C 1400B18F */  lw         $s1, 0x14($sp)
    /* 98770 800A7F70 1000B08F */  lw         $s0, 0x10($sp)
    /* 98774 800A7F74 0800E003 */  jr         $ra
    /* 98778 800A7F78 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ProcessInput__23tPMenuItemCommandButtonR13tInputKeyTypeR13tPMenuCommand
