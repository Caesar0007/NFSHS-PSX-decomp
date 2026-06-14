.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SPCH_ClearEventQueue, 0x48

glabel SPCH_ClearEventQueue
    /* D7CE0 800E74E0 21200000 */  addu       $a0, $zero, $zero
    /* D7CE4 800E74E4 1580053C */  lui        $a1, %hi(gVoxEvents)
    /* D7CE8 800E74E8 6080A324 */  addiu      $v1, $a1, %lo(gVoxEvents)
  .L800E74EC:
    /* D7CEC 800E74EC 08006294 */  lhu        $v0, 0x8($v1)
    /* D7CF0 800E74F0 00000000 */  nop
    /* D7CF4 800E74F4 06004010 */  beqz       $v0, .L800E7510
    /* D7CF8 800E74F8 00000000 */   nop
    /* D7CFC 800E74FC 080060A4 */  sh         $zero, 0x8($v1)
    /* D7D00 800E7500 6080A28C */  lw         $v0, %lo(gVoxEvents)($a1)
    /* D7D04 800E7504 00000000 */  nop
    /* D7D08 800E7508 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* D7D0C 800E750C 6080A2AC */  sw         $v0, %lo(gVoxEvents)($a1)
  .L800E7510:
    /* D7D10 800E7510 01008424 */  addiu      $a0, $a0, 0x1
    /* D7D14 800E7514 10008228 */  slti       $v0, $a0, 0x10
    /* D7D18 800E7518 F4FF4014 */  bnez       $v0, .L800E74EC
    /* D7D1C 800E751C 3C006324 */   addiu     $v1, $v1, 0x3C
    /* D7D20 800E7520 0800E003 */  jr         $ra
    /* D7D24 800E7524 00000000 */   nop
endlabel SPCH_ClearEventQueue
