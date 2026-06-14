.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching delsystemtask, 0x5C

glabel delsystemtask
    /* D73A8 800E6BA8 21180000 */  addu       $v1, $zero, $zero
    /* D73AC 800E6BAC 1480023C */  lui        $v0, %hi(D_8013E980)
    /* D73B0 800E6BB0 80E94624 */  addiu      $a2, $v0, %lo(D_8013E980)
    /* D73B4 800E6BB4 2128C000 */  addu       $a1, $a2, $zero
  .L800E6BB8:
    /* D73B8 800E6BB8 0000A28C */  lw         $v0, 0x0($a1)
    /* D73BC 800E6BBC 00000000 */  nop
    /* D73C0 800E6BC0 06004410 */  beq        $v0, $a0, .L800E6BDC
    /* D73C4 800E6BC4 10006228 */   slti      $v0, $v1, 0x10
    /* D73C8 800E6BC8 01006324 */  addiu      $v1, $v1, 0x1
    /* D73CC 800E6BCC 10006228 */  slti       $v0, $v1, 0x10
    /* D73D0 800E6BD0 F9FF4014 */  bnez       $v0, .L800E6BB8
    /* D73D4 800E6BD4 1000A524 */   addiu     $a1, $a1, 0x10
    /* D73D8 800E6BD8 10006228 */  slti       $v0, $v1, 0x10
  .L800E6BDC:
    /* D73DC 800E6BDC 07004010 */  beqz       $v0, .L800E6BFC
    /* D73E0 800E6BE0 00110300 */   sll       $v0, $v1, 4
    /* D73E4 800E6BE4 21184600 */  addu       $v1, $v0, $a2
    /* D73E8 800E6BE8 0000628C */  lw         $v0, 0x0($v1)
    /* D73EC 800E6BEC 00000000 */  nop
    /* D73F0 800E6BF0 02004414 */  bne        $v0, $a0, .L800E6BFC
    /* D73F4 800E6BF4 00000000 */   nop
    /* D73F8 800E6BF8 000060AC */  sw         $zero, 0x0($v1)
  .L800E6BFC:
    /* D73FC 800E6BFC 0800E003 */  jr         $ra
    /* D7400 800E6C00 00000000 */   nop
endlabel delsystemtask
