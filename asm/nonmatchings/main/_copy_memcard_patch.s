.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _copy_memcard_patch, 0x34

glabel _copy_memcard_patch
    /* FD36C 8010CB6C 80DF0234 */  ori        $v0, $zero, 0xDF80
    /* FD370 8010CB70 11800A3C */  lui        $t2, %hi(InitCARD2 + 0x10)
    /* FD374 8010CB74 D0C94A25 */  addiu      $t2, $t2, %lo(InitCARD2 + 0x10)
    /* FD378 8010CB78 1180093C */  lui        $t1, %hi(func_8010CA40)
    /* FD37C 8010CB7C 40CA2925 */  addiu      $t1, $t1, %lo(func_8010CA40)
  .L8010CB80:
    /* FD380 8010CB80 0000438D */  lw         $v1, 0x0($t2)
    /* FD384 8010CB84 00000000 */  nop
    /* FD388 8010CB88 000043AC */  sw         $v1, 0x0($v0)
    /* FD38C 8010CB8C 04004A25 */  addiu      $t2, $t2, 0x4
    /* FD390 8010CB90 FBFF4915 */  bne        $t2, $t1, .L8010CB80
    /* FD394 8010CB94 04004224 */   addiu     $v0, $v0, 0x4
    /* FD398 8010CB98 0800E003 */  jr         $ra
    /* FD39C 8010CB9C 00000000 */   nop
endlabel _copy_memcard_patch
