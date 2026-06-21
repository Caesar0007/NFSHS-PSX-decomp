.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AnimKeyPoints__23tScreenControllerConfigbT1, 0x64

glabel AnimKeyPoints__23tScreenControllerConfigbT1
    /* 33B9C 8004339C 74018390 */  lbu        $v1, 0x174($a0)
    /* 33BA0 800433A0 02000224 */  addiu      $v0, $zero, 0x2
    /* 33BA4 800433A4 0B006214 */  bne        $v1, $v0, .L800433D4
    /* 33BA8 800433A8 00000000 */   nop
    /* 33BAC 800433AC 0500A010 */  beqz       $a1, .L800433C4
    /* 33BB0 800433B0 00000000 */   nop
    /* 33BB4 800433B4 1000C010 */  beqz       $a2, .L800433F8
    /* 33BB8 800433B8 14000224 */   addiu     $v0, $zero, 0x14
  .L800433BC:
    /* 33BBC 800433BC 0800E003 */  jr         $ra
    /* 33BC0 800433C0 21100000 */   addu      $v0, $zero, $zero
  .L800433C4:
    /* 33BC4 800433C4 0C00C010 */  beqz       $a2, .L800433F8
    /* 33BC8 800433C8 14000224 */   addiu     $v0, $zero, 0x14
    /* 33BCC 800433CC 0800E003 */  jr         $ra
    /* 33BD0 800433D0 28000224 */   addiu     $v0, $zero, 0x28
  .L800433D4:
    /* 33BD4 800433D4 2410C500 */  and        $v0, $a2, $a1
    /* 33BD8 800433D8 F8FF4014 */  bnez       $v0, .L800433BC
    /* 33BDC 800433DC 00000000 */   nop
    /* 33BE0 800433E0 0300C014 */  bnez       $a2, .L800433F0
    /* 33BE4 800433E4 00000000 */   nop
    /* 33BE8 800433E8 0300A010 */  beqz       $a1, .L800433F8
    /* 33BEC 800433EC 21100000 */   addu      $v0, $zero, $zero
  .L800433F0:
    /* 33BF0 800433F0 0800E003 */  jr         $ra
    /* 33BF4 800433F4 18000224 */   addiu     $v0, $zero, 0x18
  .L800433F8:
    /* 33BF8 800433F8 0800E003 */  jr         $ra
    /* 33BFC 800433FC 00000000 */   nop
endlabel AnimKeyPoints__23tScreenControllerConfigbT1
