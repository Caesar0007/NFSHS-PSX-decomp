.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Increment__20tListIteratorIndexed7tPlayer, 0x68

glabel Increment__20tListIteratorIndexed7tPlayer
    /* 14840 80024040 1000828C */  lw         $v0, 0x10($a0)
    /* 14844 80024044 0400838C */  lw         $v1, 0x4($a0)
    /* 14848 80024048 00004290 */  lbu        $v0, 0x0($v0)
    /* 1484C 8002404C 00000000 */  nop
    /* 14850 80024050 21186200 */  addu       $v1, $v1, $v0
    /* 14854 80024054 00006290 */  lbu        $v0, 0x0($v1)
    /* 14858 80024058 00000000 */  nop
    /* 1485C 8002405C 01004224 */  addiu      $v0, $v0, 0x1
    /* 14860 80024060 000062A0 */  sb         $v0, 0x0($v1)
    /* 14864 80024064 1000828C */  lw         $v0, 0x10($a0)
    /* 14868 80024068 00000000 */  nop
    /* 1486C 8002406C 00004390 */  lbu        $v1, 0x0($v0)
    /* 14870 80024070 0400828C */  lw         $v0, 0x4($a0)
    /* 14874 80024074 00000000 */  nop
    /* 14878 80024078 21284300 */  addu       $a1, $v0, $v1
    /* 1487C 8002407C 0000A290 */  lbu        $v0, 0x0($a1)
    /* 14880 80024080 0000838C */  lw         $v1, 0x0($a0)
    /* 14884 80024084 40100200 */  sll        $v0, $v0, 1
    /* 14888 80024088 21104300 */  addu       $v0, $v0, $v1
    /* 1488C 8002408C 00004284 */  lh         $v0, 0x0($v0)
    /* 14890 80024090 00000000 */  nop
    /* 14894 80024094 02004014 */  bnez       $v0, .L800240A0
    /* 14898 80024098 00000000 */   nop
    /* 1489C 8002409C 0000A0A0 */  sb         $zero, 0x0($a1)
  .L800240A0:
    /* 148A0 800240A0 0800E003 */  jr         $ra
    /* 148A4 800240A4 00000000 */   nop
endlabel Increment__20tListIteratorIndexed7tPlayer
