.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching STREAM_bufferusage, 0x38

glabel STREAM_bufferusage
    /* EE4E0 800FDCE0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* EE4E4 800FDCE4 1800BFAF */  sw         $ra, 0x18($sp)
    /* EE4E8 800FDCE8 1000A527 */  addiu      $a1, $sp, 0x10
    /* EE4EC 800FDCEC BEF0030C */  jal        validatehandle
    /* EE4F0 800FDCF0 1400A627 */   addiu     $a2, $sp, 0x14
    /* EE4F4 800FDCF4 04004014 */  bnez       $v0, .L800FDD08
    /* EE4F8 800FDCF8 21100000 */   addu      $v0, $zero, $zero
    /* EE4FC 800FDCFC 1000A28F */  lw         $v0, 0x10($sp)
    /* EE500 800FDD00 00000000 */  nop
    /* EE504 800FDD04 3C00428C */  lw         $v0, 0x3C($v0)
  .L800FDD08:
    /* EE508 800FDD08 1800BF8F */  lw         $ra, 0x18($sp)
    /* EE50C 800FDD0C 00000000 */  nop
    /* EE510 800FDD10 0800E003 */  jr         $ra
    /* EE514 800FDD14 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel STREAM_bufferusage
