.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetNumOwnedCars__11tCarManagers, 0x44

glabel GetNumOwnedCars__11tCarManagers
    /* 7B34 80017334 21300000 */  addu       $a2, $zero, $zero
    /* 7B38 80017338 21180000 */  addu       $v1, $zero, $zero
    /* 7B3C 8001733C 002C0500 */  sll        $a1, $a1, 16
    /* 7B40 80017340 432A0500 */  sra        $a1, $a1, 9
  .L80017344:
    /* 7B44 80017344 21108500 */  addu       $v0, $a0, $a1
    /* 7B48 80017348 08004280 */  lb         $v0, 0x8($v0)
    /* 7B4C 8001734C 00000000 */  nop
    /* 7B50 80017350 02004004 */  bltz       $v0, .L8001735C
    /* 7B54 80017354 00000000 */   nop
    /* 7B58 80017358 0100C624 */  addiu      $a2, $a2, 0x1
  .L8001735C:
    /* 7B5C 8001735C 01006324 */  addiu      $v1, $v1, 0x1
    /* 7B60 80017360 20006228 */  slti       $v0, $v1, 0x20
    /* 7B64 80017364 F7FF4014 */  bnez       $v0, .L80017344
    /* 7B68 80017368 0400A524 */   addiu     $a1, $a1, 0x4
    /* 7B6C 8001736C 00140600 */  sll        $v0, $a2, 16
    /* 7B70 80017370 0800E003 */  jr         $ra
    /* 7B74 80017374 03140200 */   sra       $v0, $v0, 16
endlabel GetNumOwnedCars__11tCarManagers
