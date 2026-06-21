.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DebounceKeys__5tMenu, 0x4C

glabel DebounceKeys__5tMenu
    /* 1625C 80025A5C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 16260 80025A60 1000BFAF */  sw         $ra, 0x10($sp)
    /* 16264 80025A64 0800828C */  lw         $v0, 0x8($a0)
    /* 16268 80025A68 00000000 */  nop
    /* 1626C 80025A6C 80100200 */  sll        $v0, $v0, 2
    /* 16270 80025A70 21208200 */  addu       $a0, $a0, $v0
    /* 16274 80025A74 1000838C */  lw         $v1, 0x10($a0)
    /* 16278 80025A78 00000000 */  nop
    /* 1627C 80025A7C 1800628C */  lw         $v0, 0x18($v1)
    /* 16280 80025A80 00000000 */  nop
    /* 16284 80025A84 10004484 */  lh         $a0, 0x10($v0)
    /* 16288 80025A88 1400428C */  lw         $v0, 0x14($v0)
    /* 1628C 80025A8C 00000000 */  nop
    /* 16290 80025A90 09F84000 */  jalr       $v0
    /* 16294 80025A94 21206400 */   addu      $a0, $v1, $a0
    /* 16298 80025A98 1000BF8F */  lw         $ra, 0x10($sp)
    /* 1629C 80025A9C 00000000 */  nop
    /* 162A0 80025AA0 0800E003 */  jr         $ra
    /* 162A4 80025AA4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DebounceKeys__5tMenu
