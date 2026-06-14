.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching STREAM_overhead, 0x34

glabel STREAM_overhead
    /* ED5E0 800FCDE0 40100400 */  sll        $v0, $a0, 1
    /* ED5E4 800FCDE4 21104400 */  addu       $v0, $v0, $a0
    /* ED5E8 800FCDE8 C0100200 */  sll        $v0, $v0, 3
    /* ED5EC 800FCDEC 21104400 */  addu       $v0, $v0, $a0
    /* ED5F0 800FCDF0 80100200 */  sll        $v0, $v0, 2
    /* ED5F4 800FCDF4 40180500 */  sll        $v1, $a1, 1
    /* ED5F8 800FCDF8 21186500 */  addu       $v1, $v1, $a1
    /* ED5FC 800FCDFC 80180300 */  sll        $v1, $v1, 2
    /* ED600 800FCE00 AC006324 */  addiu      $v1, $v1, 0xAC
    /* ED604 800FCE04 21104300 */  addu       $v0, $v0, $v1
    /* ED608 800FCE08 00310600 */  sll        $a2, $a2, 4
    /* ED60C 800FCE0C 0800E003 */  jr         $ra
    /* ED610 800FCE10 21104600 */   addu      $v0, $v0, $a2
endlabel STREAM_overhead
