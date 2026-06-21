.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8002C960, 0x40

glabel func_8002C960
    /* 1D160 8002C960 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1D164 8002C964 0580023C */  lui        $v0, %hi(menuDefs)
    /* 1D168 8002C968 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 1D16C 8002C96C 01000324 */  addiu      $v1, $zero, 0x1
    /* 1D170 8002C970 1000BFAF */  sw         $ra, 0x10($sp)
    /* 1D174 8002C974 000083AC */  sw         $v1, 0x0($a0)
    /* 1D178 8002C978 341F4224 */  addiu      $v0, $v0, 0x1F34
    /* 1D17C 8002C97C 040082AC */  sw         $v0, 0x4($a0)
    /* 1D180 8002C980 0580023C */  lui        $v0, %hi(screenCarSelect)
    /* 1D184 8002C984 3C20448C */  lw         $a0, %lo(screenCarSelect)($v0)
    /* 1D188 8002C988 67ED000C */  jal        SetState__16tScreenCarSelecti
    /* 1D18C 8002C98C 04000524 */   addiu     $a1, $zero, 0x4
    /* 1D190 8002C990 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1D194 8002C994 00000000 */  nop
    /* 1D198 8002C998 0800E003 */  jr         $ra
    /* 1D19C 8002C99C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_8002C960
