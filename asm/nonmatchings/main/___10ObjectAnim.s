.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___10ObjectAnim, 0x34

glabel ___10ObjectAnim
    /* 975E0 800A6DE0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 975E4 800A6DE4 0580023C */  lui        $v0, %hi(D_800560E8)
    /* 975E8 800A6DE8 E8604224 */  addiu      $v0, $v0, %lo(D_800560E8)
    /* 975EC 800A6DEC 0100A530 */  andi       $a1, $a1, 0x1
    /* 975F0 800A6DF0 1000BFAF */  sw         $ra, 0x10($sp)
    /* 975F4 800A6DF4 0300A010 */  beqz       $a1, .L800A6E04
    /* 975F8 800A6DF8 000082AC */   sw        $v0, 0x0($a0)
    /* 975FC 800A6DFC 6B8F020C */  jal        __builtin_delete
    /* 97600 800A6E00 00000000 */   nop
  .L800A6E04:
    /* 97604 800A6E04 1000BF8F */  lw         $ra, 0x10($sp)
    /* 97608 800A6E08 00000000 */  nop
    /* 9760C 800A6E0C 0800E003 */  jr         $ra
    /* 97610 800A6E10 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___10ObjectAnim
