.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching stricmp, 0x74

glabel stricmp
    /* EED20 800FE520 00008690 */  lbu        $a2, 0x0($a0)
    /* EED24 800FE524 00000000 */  nop
    /* EED28 800FE528 BFFFC224 */  addiu      $v0, $a2, -0x41
    /* EED2C 800FE52C 1A00422C */  sltiu      $v0, $v0, 0x1A
    /* EED30 800FE530 02004010 */  beqz       $v0, .L800FE53C
    /* EED34 800FE534 00000000 */   nop
    /* EED38 800FE538 2000C624 */  addiu      $a2, $a2, 0x20
  .L800FE53C:
    /* EED3C 800FE53C 0000A290 */  lbu        $v0, 0x0($a1)
    /* EED40 800FE540 00000000 */  nop
    /* EED44 800FE544 BFFF4224 */  addiu      $v0, $v0, -0x41
    /* EED48 800FE548 1A00422C */  sltiu      $v0, $v0, 0x1A
    /* EED4C 800FE54C 04004010 */  beqz       $v0, .L800FE560
    /* EED50 800FE550 E0FFC224 */   addiu     $v0, $a2, -0x20
    /* EED54 800FE554 0000A390 */  lbu        $v1, 0x0($a1)
    /* EED58 800FE558 5BF90308 */  j          .L800FE56C
    /* EED5C 800FE55C 23184300 */   subu      $v1, $v0, $v1
  .L800FE560:
    /* EED60 800FE560 0000A290 */  lbu        $v0, 0x0($a1)
    /* EED64 800FE564 00000000 */  nop
    /* EED68 800FE568 2318C200 */  subu       $v1, $a2, $v0
  .L800FE56C:
    /* EED6C 800FE56C 07006014 */  bnez       $v1, .L800FE58C
    /* EED70 800FE570 00000000 */   nop
    /* EED74 800FE574 00008290 */  lbu        $v0, 0x0($a0)
    /* EED78 800FE578 00000000 */  nop
    /* EED7C 800FE57C 03004010 */  beqz       $v0, .L800FE58C
    /* EED80 800FE580 01008424 */   addiu     $a0, $a0, 0x1
    /* EED84 800FE584 48F90308 */  j          stricmp
    /* EED88 800FE588 0100A524 */   addiu     $a1, $a1, 0x1
  .L800FE58C:
    /* EED8C 800FE58C 0800E003 */  jr         $ra
    /* EED90 800FE590 21106000 */   addu      $v0, $v1, $zero
endlabel stricmp
