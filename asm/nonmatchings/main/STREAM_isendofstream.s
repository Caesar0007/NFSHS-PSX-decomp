.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching STREAM_isendofstream, 0x5C

glabel STREAM_isendofstream
    /* EE43C 800FDC3C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* EE440 800FDC40 1800BFAF */  sw         $ra, 0x18($sp)
    /* EE444 800FDC44 1000A527 */  addiu      $a1, $sp, 0x10
    /* EE448 800FDC48 BEF0030C */  jal        validatehandle
    /* EE44C 800FDC4C 1400A627 */   addiu     $a2, $sp, 0x14
    /* EE450 800FDC50 0D004014 */  bnez       $v0, .L800FDC88
    /* EE454 800FDC54 21100000 */   addu      $v0, $zero, $zero
    /* EE458 800FDC58 1000A28F */  lw         $v0, 0x10($sp)
    /* EE45C 800FDC5C 00000000 */  nop
    /* EE460 800FDC60 2800428C */  lw         $v0, 0x28($v0)
    /* EE464 800FDC64 00000000 */  nop
    /* EE468 800FDC68 06004014 */  bnez       $v0, .L800FDC84
    /* EE46C 800FDC6C 21180000 */   addu      $v1, $zero, $zero
    /* EE470 800FDC70 1400A28F */  lw         $v0, 0x14($sp)
    /* EE474 800FDC74 00000000 */  nop
    /* EE478 800FDC78 0800428C */  lw         $v0, 0x8($v0)
    /* EE47C 800FDC7C 00000000 */  nop
    /* EE480 800FDC80 0100432C */  sltiu      $v1, $v0, 0x1
  .L800FDC84:
    /* EE484 800FDC84 21106000 */  addu       $v0, $v1, $zero
  .L800FDC88:
    /* EE488 800FDC88 1800BF8F */  lw         $ra, 0x18($sp)
    /* EE48C 800FDC8C 00000000 */  nop
    /* EE490 800FDC90 0800E003 */  jr         $ra
    /* EE494 800FDC94 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel STREAM_isendofstream
