.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetNumPinkSlipsCars__11tCarManagers, 0x44

glabel GetNumPinkSlipsCars__11tCarManagers
    /* 7C20 80017420 21300000 */  addu       $a2, $zero, $zero
    /* 7C24 80017424 21180000 */  addu       $v1, $zero, $zero
    /* 7C28 80017428 002C0500 */  sll        $a1, $a1, 16
    /* 7C2C 8001742C 432A0500 */  sra        $a1, $a1, 9
  .L80017430:
    /* 7C30 80017430 21108500 */  addu       $v0, $a0, $a1
    /* 7C34 80017434 08014280 */  lb         $v0, 0x108($v0)
    /* 7C38 80017438 00000000 */  nop
    /* 7C3C 8001743C 02004004 */  bltz       $v0, .L80017448
    /* 7C40 80017440 00000000 */   nop
    /* 7C44 80017444 0100C624 */  addiu      $a2, $a2, 0x1
  .L80017448:
    /* 7C48 80017448 01006324 */  addiu      $v1, $v1, 0x1
    /* 7C4C 8001744C 20006228 */  slti       $v0, $v1, 0x20
    /* 7C50 80017450 F7FF4014 */  bnez       $v0, .L80017430
    /* 7C54 80017454 0400A524 */   addiu     $a1, $a1, 0x4
    /* 7C58 80017458 00140600 */  sll        $v0, $a2, 16
    /* 7C5C 8001745C 0800E003 */  jr         $ra
    /* 7C60 80017460 03140200 */   sra       $v0, $v0, 16
endlabel GetNumPinkSlipsCars__11tCarManagers
