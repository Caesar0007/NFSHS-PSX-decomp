.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MenuExtended_SetOnePlayer__FR12tMenuCommand, 0x4C

glabel MenuExtended_SetOnePlayer__FR12tMenuCommand
    /* 1C8E0 8002C0E0 0580023C */  lui        $v0, %hi(FEApp)
    /* 1C8E4 8002C0E4 C014428C */  lw         $v0, %lo(FEApp)($v0)
    /* 1C8E8 8002C0E8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 1C8EC 8002C0EC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 1C8F0 8002C0F0 2D024390 */  lbu        $v1, 0x22D($v0)
    /* 1C8F4 8002C0F4 01000224 */  addiu      $v0, $zero, 0x1
    /* 1C8F8 8002C0F8 03006214 */  bne        $v1, $v0, .L8002C108
    /* 1C8FC 8002C0FC 1180023C */   lui       $v0, %hi(D_80114603)
    /* 1C900 8002C100 47B00008 */  j          .L8002C11C
    /* 1C904 8002C104 000080AC */   sw        $zero, 0x0($a0)
  .L8002C108:
    /* 1C908 8002C108 034640A0 */  sb         $zero, %lo(D_80114603)($v0)
    /* 1C90C 8002C10C 0580023C */  lui        $v0, %hi(screenMain)
    /* 1C910 8002C110 581E448C */  lw         $a0, %lo(screenMain)($v0)
    /* 1C914 8002C114 C8DB000C */  jal        SwapBackground__11tScreenMaini
    /* 1C918 8002C118 FFFF0524 */   addiu     $a1, $zero, -0x1
  .L8002C11C:
    /* 1C91C 8002C11C 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1C920 8002C120 00000000 */  nop
    /* 1C924 8002C124 0800E003 */  jr         $ra
    /* 1C928 8002C128 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel MenuExtended_SetOnePlayer__FR12tMenuCommand
