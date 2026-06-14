.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___14AIState_Normal, 0x34

glabel ___14AIState_Normal
    /* 62FFC 800727FC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 63000 80072800 0580023C */  lui        $v0, %hi(D_80055640)
    /* 63004 80072804 40564224 */  addiu      $v0, $v0, %lo(D_80055640)
    /* 63008 80072808 0100A530 */  andi       $a1, $a1, 0x1
    /* 6300C 8007280C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 63010 80072810 0300A010 */  beqz       $a1, .L80072820
    /* 63014 80072814 040082AC */   sw        $v0, 0x4($a0)
    /* 63018 80072818 6B8F020C */  jal        __builtin_delete
    /* 6301C 8007281C 00000000 */   nop
  .L80072820:
    /* 63020 80072820 1000BF8F */  lw         $ra, 0x10($sp)
    /* 63024 80072824 00000000 */  nop
    /* 63028 80072828 0800E003 */  jr         $ra
    /* 6302C 8007282C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___14AIState_Normal
