.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padGetActSize, 0x38

glabel _padGetActSize
    /* F5FCC 801057CC E3008290 */  lbu        $v0, 0xE3($a0)
    /* F5FD0 801057D0 E9008590 */  lbu        $a1, 0xE9($a0)
    /* F5FD4 801057D4 EC00848C */  lw         $a0, 0xEC($a0)
    /* F5FD8 801057D8 01004224 */  addiu      $v0, $v0, 0x1
    /* F5FDC 801057DC 43100200 */  sra        $v0, $v0, 1
    /* F5FE0 801057E0 80100200 */  sll        $v0, $v0, 2
    /* F5FE4 801057E4 80180500 */  sll        $v1, $a1, 2
    /* F5FE8 801057E8 21186500 */  addu       $v1, $v1, $a1
    /* F5FEC 801057EC 03006324 */  addiu      $v1, $v1, 0x3
    /* F5FF0 801057F0 FC0F6330 */  andi       $v1, $v1, 0xFFC
    /* F5FF4 801057F4 04006324 */  addiu      $v1, $v1, 0x4
    /* F5FF8 801057F8 21104300 */  addu       $v0, $v0, $v1
    /* F5FFC 801057FC 0800E003 */  jr         $ra
    /* F6000 80105800 21104400 */   addu      $v0, $v0, $a0
endlabel _padGetActSize
