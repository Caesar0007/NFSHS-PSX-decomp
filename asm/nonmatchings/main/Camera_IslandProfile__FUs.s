.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Camera_IslandProfile__FUs, 0x58

glabel Camera_IslandProfile__FUs
    /* 7343C 80082C3C 21188000 */  addu       $v1, $a0, $zero
    /* 73440 80082C40 FFFF8224 */  addiu      $v0, $a0, -0x1
    /* 73444 80082C44 24108200 */  and        $v0, $a0, $v0
    /* 73448 80082C48 21284000 */  addu       $a1, $v0, $zero
    /* 7344C 80082C4C 23208200 */  subu       $a0, $a0, $v0
    /* 73450 80082C50 FFFF6230 */  andi       $v0, $v1, 0xFFFF
    /* 73454 80082C54 0D004010 */  beqz       $v0, .L80082C8C
    /* 73458 80082C58 00000000 */   nop
  .L80082C5C:
    /* 7345C 80082C5C FFFFA330 */  andi       $v1, $a1, 0xFFFF
    /* 73460 80082C60 23104300 */  subu       $v0, $v0, $v1
    /* 73464 80082C64 FFFF8330 */  andi       $v1, $a0, 0xFFFF
    /* 73468 80082C68 03004310 */  beq        $v0, $v1, .L80082C78
    /* 7346C 80082C6C 2118A000 */   addu      $v1, $a1, $zero
    /* 73470 80082C70 0800E003 */  jr         $ra
    /* 73474 80082C74 01000224 */   addiu     $v0, $zero, 0x1
  .L80082C78:
    /* 73478 80082C78 FFFF6224 */  addiu      $v0, $v1, -0x1
    /* 7347C 80082C7C 24286200 */  and        $a1, $v1, $v0
    /* 73480 80082C80 FFFF6230 */  andi       $v0, $v1, 0xFFFF
    /* 73484 80082C84 F5FF4014 */  bnez       $v0, .L80082C5C
    /* 73488 80082C88 40200400 */   sll       $a0, $a0, 1
  .L80082C8C:
    /* 7348C 80082C8C 0800E003 */  jr         $ra
    /* 73490 80082C90 21100000 */   addu      $v0, $zero, $zero
endlabel Camera_IslandProfile__FUs
