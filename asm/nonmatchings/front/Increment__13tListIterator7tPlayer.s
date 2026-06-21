.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Increment__13tListIterator7tPlayer, 0x4C

glabel Increment__13tListIterator7tPlayer
    /* 1468C 80023E8C 0400838C */  lw         $v1, 0x4($a0)
    /* 14690 80023E90 00000000 */  nop
    /* 14694 80023E94 00006290 */  lbu        $v0, 0x0($v1)
    /* 14698 80023E98 00000000 */  nop
    /* 1469C 80023E9C 01004224 */  addiu      $v0, $v0, 0x1
    /* 146A0 80023EA0 000062A0 */  sb         $v0, 0x0($v1)
    /* 146A4 80023EA4 0400858C */  lw         $a1, 0x4($a0)
    /* 146A8 80023EA8 00000000 */  nop
    /* 146AC 80023EAC 0000A290 */  lbu        $v0, 0x0($a1)
    /* 146B0 80023EB0 0000838C */  lw         $v1, 0x0($a0)
    /* 146B4 80023EB4 40100200 */  sll        $v0, $v0, 1
    /* 146B8 80023EB8 21104300 */  addu       $v0, $v0, $v1
    /* 146BC 80023EBC 00004284 */  lh         $v0, 0x0($v0)
    /* 146C0 80023EC0 00000000 */  nop
    /* 146C4 80023EC4 02004014 */  bnez       $v0, .L80023ED0
    /* 146C8 80023EC8 00000000 */   nop
    /* 146CC 80023ECC 0000A0A0 */  sb         $zero, 0x0($a1)
  .L80023ED0:
    /* 146D0 80023ED0 0800E003 */  jr         $ra
    /* 146D4 80023ED4 00000000 */   nop
endlabel Increment__13tListIterator7tPlayer
