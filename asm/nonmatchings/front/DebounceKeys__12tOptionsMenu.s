.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DebounceKeys__12tOptionsMenu, 0x6C

glabel DebounceKeys__12tOptionsMenu
    /* CD6C 8001C56C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* CD70 8001C570 1000BFAF */  sw         $ra, 0x10($sp)
    /* CD74 8001C574 0800828C */  lw         $v0, 0x8($a0)
    /* CD78 8001C578 00000000 */  nop
    /* CD7C 8001C57C 80100200 */  sll        $v0, $v0, 2
    /* CD80 8001C580 21208200 */  addu       $a0, $a0, $v0
    /* CD84 8001C584 1000838C */  lw         $v1, 0x10($a0)
    /* CD88 8001C588 00000000 */  nop
    /* CD8C 8001C58C 0E006010 */  beqz       $v1, .L8001C5C8
    /* CD90 8001C590 21100000 */   addu      $v0, $zero, $zero
    /* CD94 8001C594 0000628C */  lw         $v0, 0x0($v1)
    /* CD98 8001C598 00000000 */  nop
    /* CD9C 8001C59C 01004230 */  andi       $v0, $v0, 0x1
    /* CDA0 8001C5A0 01004238 */  xori       $v0, $v0, 0x1
    /* CDA4 8001C5A4 08004010 */  beqz       $v0, .L8001C5C8
    /* CDA8 8001C5A8 21100000 */   addu      $v0, $zero, $zero
    /* CDAC 8001C5AC 1800628C */  lw         $v0, 0x18($v1)
    /* CDB0 8001C5B0 00000000 */  nop
    /* CDB4 8001C5B4 10004484 */  lh         $a0, 0x10($v0)
    /* CDB8 8001C5B8 1400428C */  lw         $v0, 0x14($v0)
    /* CDBC 8001C5BC 00000000 */  nop
    /* CDC0 8001C5C0 09F84000 */  jalr       $v0
    /* CDC4 8001C5C4 21206400 */   addu      $a0, $v1, $a0
  .L8001C5C8:
    /* CDC8 8001C5C8 1000BF8F */  lw         $ra, 0x10($sp)
    /* CDCC 8001C5CC 00000000 */  nop
    /* CDD0 8001C5D0 0800E003 */  jr         $ra
    /* CDD4 8001C5D4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DebounceKeys__12tOptionsMenu
