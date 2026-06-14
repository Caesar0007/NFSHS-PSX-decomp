.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8005B4CC, 0x34

glabel func_8005B4CC
    /* 4BCCC 8005B4CC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4BCD0 8005B4D0 0580023C */  lui        $v0, %hi(D_80054E3C)
    /* 4BCD4 8005B4D4 3C4E4224 */  addiu      $v0, $v0, %lo(D_80054E3C)
    /* 4BCD8 8005B4D8 0100A530 */  andi       $a1, $a1, 0x1
    /* 4BCDC 8005B4DC 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4BCE0 8005B4E0 0300A010 */  beqz       $a1, .L8005B4F0
    /* 4BCE4 8005B4E4 040082AC */   sw        $v0, 0x4($a0)
    /* 4BCE8 8005B4E8 6B8F020C */  jal        __builtin_delete
    /* 4BCEC 8005B4EC 00000000 */   nop
  .L8005B4F0:
    /* 4BCF0 8005B4F0 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4BCF4 8005B4F4 00000000 */  nop
    /* 4BCF8 8005B4F8 0800E003 */  jr         $ra
    /* 4BCFC 8005B4FC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_8005B4CC
