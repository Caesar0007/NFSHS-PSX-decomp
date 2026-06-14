.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___10tPMenuItem, 0x34

glabel ___10tPMenuItem
    /* 97C04 800A7404 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 97C08 800A7408 0580023C */  lui        $v0, %hi(_vt_10tPMenuItem)
    /* 97C0C 800A740C CC624224 */  addiu      $v0, $v0, %lo(_vt_10tPMenuItem)
    /* 97C10 800A7410 0100A530 */  andi       $a1, $a1, 0x1
    /* 97C14 800A7414 1000BFAF */  sw         $ra, 0x10($sp)
    /* 97C18 800A7418 0300A010 */  beqz       $a1, .L800A7428
    /* 97C1C 800A741C 080082AC */   sw        $v0, 0x8($a0)
    /* 97C20 800A7420 6B8F020C */  jal        __builtin_delete
    /* 97C24 800A7424 00000000 */   nop
  .L800A7428:
    /* 97C28 800A7428 1000BF8F */  lw         $ra, 0x10($sp)
    /* 97C2C 800A742C 00000000 */  nop
    /* 97C30 800A7430 0800E003 */  jr         $ra
    /* 97C34 800A7434 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___10tPMenuItem
