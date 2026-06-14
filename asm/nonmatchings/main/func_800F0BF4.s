.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800F0BF4, 0x5C

glabel func_800F0BF4
    /* E13F4 800F0BF4 00018228 */  slti       $v0, $a0, 0x100
    /* E13F8 800F0BF8 06004014 */  bnez       $v0, .L800F0C14
    /* E13FC 800F0BFC FF008330 */   andi      $v1, $a0, 0xFF
    /* E1400 800F0C00 4819828F */  lw         $v0, %gp_rel(D_8013DE94)($gp)
    /* E1404 800F0C04 00000000 */  nop
    /* E1408 800F0C08 2A106200 */  slt        $v0, $v1, $v0
    /* E140C 800F0C0C 03004014 */  bnez       $v0, .L800F0C1C
    /* E1410 800F0C10 40100300 */   sll       $v0, $v1, 1
  .L800F0C14:
    /* E1414 800F0C14 0800E003 */  jr         $ra
    /* E1418 800F0C18 21100000 */   addu      $v0, $zero, $zero
  .L800F0C1C:
    /* E141C 800F0C1C 21104300 */  addu       $v0, $v0, $v1
    /* E1420 800F0C20 80100200 */  sll        $v0, $v0, 2
    /* E1424 800F0C24 23104300 */  subu       $v0, $v0, $v1
    /* E1428 800F0C28 4C19838F */  lw         $v1, %gp_rel(D_8013DE98)($gp)
    /* E142C 800F0C2C 80100200 */  sll        $v0, $v0, 2
    /* E1430 800F0C30 21286200 */  addu       $a1, $v1, $v0
    /* E1434 800F0C34 0000A38C */  lw         $v1, 0x0($a1)
    /* E1438 800F0C38 00000000 */  nop
    /* E143C 800F0C3C 02006414 */  bne        $v1, $a0, .L800F0C48
    /* E1440 800F0C40 21100000 */   addu      $v0, $zero, $zero
    /* E1444 800F0C44 2110A000 */  addu       $v0, $a1, $zero
  .L800F0C48:
    /* E1448 800F0C48 0800E003 */  jr         $ra
    /* E144C 800F0C4C 00000000 */   nop
endlabel func_800F0BF4
