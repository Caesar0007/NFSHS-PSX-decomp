.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _cd_event_init, 0x3C

glabel _cd_event_init
    /* F991C 8010911C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F9920 80109120 1000BFAF */  sw         $ra, 0x10($sp)
    /* F9924 80109124 5020040C */  jal        CD_init_80108140
    /* F9928 80109128 00000000 */   nop
    /* F992C 8010912C 05004014 */  bnez       $v0, .L80109144
    /* F9930 80109130 00000000 */   nop
    /* F9934 80109134 0120040C */  jal        CD_initvol
    /* F9938 80109138 00000000 */   nop
    /* F993C 8010913C 52240408 */  j          .L80109148
    /* F9940 80109140 0100422C */   sltiu     $v0, $v0, 0x1
  .L80109144:
    /* F9944 80109144 21100000 */  addu       $v0, $zero, $zero
  .L80109148:
    /* F9948 80109148 1000BF8F */  lw         $ra, 0x10($sp)
    /* F994C 8010914C 1800BD27 */  addiu      $sp, $sp, 0x18
    /* F9950 80109150 0800E003 */  jr         $ra
    /* F9954 80109154 00000000 */   nop
endlabel _cd_event_init
