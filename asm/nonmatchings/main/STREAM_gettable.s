.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching STREAM_gettable, 0x38

glabel STREAM_gettable
    /* EE3CC 800FDBCC E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* EE3D0 800FDBD0 1800BFAF */  sw         $ra, 0x18($sp)
    /* EE3D4 800FDBD4 1000A527 */  addiu      $a1, $sp, 0x10
    /* EE3D8 800FDBD8 BEF0030C */  jal        validatehandle
    /* EE3DC 800FDBDC 1400A627 */   addiu     $a2, $sp, 0x14
    /* EE3E0 800FDBE0 04004014 */  bnez       $v0, .L800FDBF4
    /* EE3E4 800FDBE4 21100000 */   addu      $v0, $zero, $zero
    /* EE3E8 800FDBE8 1400A28F */  lw         $v0, 0x14($sp)
    /* EE3EC 800FDBEC 00000000 */  nop
    /* EE3F0 800FDBF0 0800428C */  lw         $v0, 0x8($v0)
  .L800FDBF4:
    /* EE3F4 800FDBF4 1800BF8F */  lw         $ra, 0x18($sp)
    /* EE3F8 800FDBF8 00000000 */  nop
    /* EE3FC 800FDBFC 0800E003 */  jr         $ra
    /* EE400 800FDC00 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel STREAM_gettable
