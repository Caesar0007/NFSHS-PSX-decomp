.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Debounce__6tPMenu, 0x4C

glabel Debounce__6tPMenu
    /* 98948 800A8148 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 9894C 800A814C 1000BFAF */  sw         $ra, 0x10($sp)
    /* 98950 800A8150 0000828C */  lw         $v0, 0x0($a0)
    /* 98954 800A8154 00000000 */  nop
    /* 98958 800A8158 80100200 */  sll        $v0, $v0, 2
    /* 9895C 800A815C 21208200 */  addu       $a0, $a0, $v0
    /* 98960 800A8160 0800838C */  lw         $v1, 0x8($a0)
    /* 98964 800A8164 00000000 */  nop
    /* 98968 800A8168 0800628C */  lw         $v0, 0x8($v1)
    /* 9896C 800A816C 00000000 */  nop
    /* 98970 800A8170 18004484 */  lh         $a0, 0x18($v0)
    /* 98974 800A8174 1C00428C */  lw         $v0, 0x1C($v0)
    /* 98978 800A8178 00000000 */  nop
    /* 9897C 800A817C 09F84000 */  jalr       $v0
    /* 98980 800A8180 21206400 */   addu      $a0, $v1, $a0
    /* 98984 800A8184 1000BF8F */  lw         $ra, 0x10($sp)
    /* 98988 800A8188 00000000 */  nop
    /* 9898C 800A818C 0800E003 */  jr         $ra
    /* 98990 800A8190 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Debounce__6tPMenu
