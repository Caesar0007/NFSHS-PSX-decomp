.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching tMenuConstructor__5tMenuP9tMenuItemPv, 0x38

glabel tMenuConstructor__5tMenuP9tMenuItemPv
    /* 15C34 80025434 21100000 */  addu       $v0, $zero, $zero
    /* 15C38 80025438 640080A4 */  sh         $zero, 0x64($a0)
    /* 15C3C 8002543C 100085AC */  sw         $a1, 0x10($a0)
  .L80025440:
    /* 15C40 80025440 0400C624 */  addiu      $a2, $a2, 0x4
    /* 15C44 80025444 01004524 */  addiu      $a1, $v0, 0x1
    /* 15C48 80025448 80100500 */  sll        $v0, $a1, 2
    /* 15C4C 8002544C FCFFC38C */  lw         $v1, -0x4($a2)
    /* 15C50 80025450 21108200 */  addu       $v0, $a0, $v0
    /* 15C54 80025454 03006010 */  beqz       $v1, .L80025464
    /* 15C58 80025458 100043AC */   sw        $v1, 0x10($v0)
    /* 15C5C 8002545C 10950008 */  j          .L80025440
    /* 15C60 80025460 2110A000 */   addu      $v0, $a1, $zero
  .L80025464:
    /* 15C64 80025464 0800E003 */  jr         $ra
    /* 15C68 80025468 00000000 */   nop
endlabel tMenuConstructor__5tMenuP9tMenuItemPv
