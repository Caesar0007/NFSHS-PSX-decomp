.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_8005F680, 0x34

glabel func_8005F680
    /* 4FE80 8005F680 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 4FE84 8005F684 0580023C */  lui        $v0, %hi(D_80054F44)
    /* 4FE88 8005F688 444F4224 */  addiu      $v0, $v0, %lo(D_80054F44)
    /* 4FE8C 8005F68C 0100A530 */  andi       $a1, $a1, 0x1
    /* 4FE90 8005F690 1000BFAF */  sw         $ra, 0x10($sp)
    /* 4FE94 8005F694 0300A010 */  beqz       $a1, .L8005F6A4
    /* 4FE98 8005F698 040082AC */   sw        $v0, 0x4($a0)
    /* 4FE9C 8005F69C 6B8F020C */  jal        __builtin_delete
    /* 4FEA0 8005F6A0 00000000 */   nop
  .L8005F6A4:
    /* 4FEA4 8005F6A4 1000BF8F */  lw         $ra, 0x10($sp)
    /* 4FEA8 8005F6A8 00000000 */  nop
    /* 4FEAC 8005F6AC 0800E003 */  jr         $ra
    /* 4FEB0 8005F6B0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel func_8005F680
