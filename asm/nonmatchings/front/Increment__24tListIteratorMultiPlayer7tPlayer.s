.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Increment__24tListIteratorMultiPlayer7tPlayer, 0x64

glabel Increment__24tListIteratorMultiPlayer7tPlayer
    /* 14C30 80024430 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 14C34 80024434 0200A214 */  bne        $a1, $v0, .L80024440
    /* 14C38 80024438 00000000 */   nop
    /* 14C3C 8002443C 21280000 */  addu       $a1, $zero, $zero
  .L80024440:
    /* 14C40 80024440 0400838C */  lw         $v1, 0x4($a0)
    /* 14C44 80024444 00000000 */  nop
    /* 14C48 80024448 21186500 */  addu       $v1, $v1, $a1
    /* 14C4C 8002444C 00006290 */  lbu        $v0, 0x0($v1)
    /* 14C50 80024450 00000000 */  nop
    /* 14C54 80024454 01004224 */  addiu      $v0, $v0, 0x1
    /* 14C58 80024458 000062A0 */  sb         $v0, 0x0($v1)
    /* 14C5C 8002445C 0400828C */  lw         $v0, 0x4($a0)
    /* 14C60 80024460 00000000 */  nop
    /* 14C64 80024464 21284500 */  addu       $a1, $v0, $a1
    /* 14C68 80024468 0000A290 */  lbu        $v0, 0x0($a1)
    /* 14C6C 8002446C 0000838C */  lw         $v1, 0x0($a0)
    /* 14C70 80024470 40100200 */  sll        $v0, $v0, 1
    /* 14C74 80024474 21104300 */  addu       $v0, $v0, $v1
    /* 14C78 80024478 00004284 */  lh         $v0, 0x0($v0)
    /* 14C7C 8002447C 00000000 */  nop
    /* 14C80 80024480 02004014 */  bnez       $v0, .L8002448C
    /* 14C84 80024484 00000000 */   nop
    /* 14C88 80024488 0000A0A0 */  sb         $zero, 0x0($a1)
  .L8002448C:
    /* 14C8C 8002448C 0800E003 */  jr         $ra
    /* 14C90 80024490 00000000 */   nop
endlabel Increment__24tListIteratorMultiPlayer7tPlayer
