.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FILE_overhead, 0x50

glabel FILE_overhead
    /* DC574 800EBD74 02008014 */  bnez       $a0, .L800EBD80
    /* DC578 800EBD78 00000000 */   nop
    /* DC57C 800EBD7C 18000424 */  addiu      $a0, $zero, 0x18
  .L800EBD80:
    /* DC580 800EBD80 0200A014 */  bnez       $a1, .L800EBD8C
    /* DC584 800EBD84 00000000 */   nop
    /* DC588 800EBD88 00080524 */  addiu      $a1, $zero, 0x800
  .L800EBD8C:
    /* DC58C 800EBD8C 0200C014 */  bnez       $a2, .L800EBD98
    /* DC590 800EBD90 00000000 */   nop
    /* DC594 800EBD94 0A000624 */  addiu      $a2, $zero, 0xA
  .L800EBD98:
    /* DC598 800EBD98 40100600 */  sll        $v0, $a2, 1
    /* DC59C 800EBD9C 21104600 */  addu       $v0, $v0, $a2
    /* DC5A0 800EBDA0 80180400 */  sll        $v1, $a0, 2
    /* DC5A4 800EBDA4 21186400 */  addu       $v1, $v1, $a0
    /* DC5A8 800EBDA8 21186200 */  addu       $v1, $v1, $v0
    /* DC5AC 800EBDAC 00190300 */  sll        $v1, $v1, 4
    /* DC5B0 800EBDB0 80100500 */  sll        $v0, $a1, 2
    /* DC5B4 800EBDB4 21104500 */  addu       $v0, $v0, $a1
    /* DC5B8 800EBDB8 80100200 */  sll        $v0, $v0, 2
    /* DC5BC 800EBDBC 0800E003 */  jr         $ra
    /* DC5C0 800EBDC0 21106200 */   addu      $v0, $v1, $v0
endlabel FILE_overhead
