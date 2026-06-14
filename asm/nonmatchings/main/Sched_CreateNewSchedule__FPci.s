.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Sched_CreateNewSchedule__FPci, 0x70

glabel Sched_CreateNewSchedule__FPci
    /* A6AF0 800B62F0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A6AF4 800B62F4 1000B0AF */  sw         $s0, 0x10($sp)
    /* A6AF8 800B62F8 2180A000 */  addu       $s0, $a1, $zero
    /* A6AFC 800B62FC 00291000 */  sll        $a1, $s0, 4
    /* A6B00 800B6300 1800A524 */  addiu      $a1, $a1, 0x18
    /* A6B04 800B6304 1400BFAF */  sw         $ra, 0x14($sp)
    /* A6B08 800B6308 CF94030C */  jal        reservememadr
    /* A6B0C 800B630C 21300000 */   addu      $a2, $zero, $zero
    /* A6B10 800B6310 21284000 */  addu       $a1, $v0, $zero
    /* A6B14 800B6314 0000B0AC */  sw         $s0, 0x0($a1)
    /* A6B18 800B6318 21100002 */  addu       $v0, $s0, $zero
    /* A6B1C 800B631C 21200000 */  addu       $a0, $zero, $zero
    /* A6B20 800B6320 0A004018 */  blez       $v0, .L800B634C
    /* A6B24 800B6324 0400A0AC */   sw        $zero, 0x4($a1)
    /* A6B28 800B6328 FE7F0624 */  addiu      $a2, $zero, 0x7FFE
    /* A6B2C 800B632C 2118A000 */  addu       $v1, $a1, $zero
  .L800B6330:
    /* A6B30 800B6330 080066AC */  sw         $a2, 0x8($v1)
    /* A6B34 800B6334 0C0060AC */  sw         $zero, 0xC($v1)
    /* A6B38 800B6338 0000A28C */  lw         $v0, 0x0($a1)
    /* A6B3C 800B633C 01008424 */  addiu      $a0, $a0, 0x1
    /* A6B40 800B6340 2A108200 */  slt        $v0, $a0, $v0
    /* A6B44 800B6344 FAFF4014 */  bnez       $v0, .L800B6330
    /* A6B48 800B6348 10006324 */   addiu     $v1, $v1, 0x10
  .L800B634C:
    /* A6B4C 800B634C 1400BF8F */  lw         $ra, 0x14($sp)
    /* A6B50 800B6350 1000B08F */  lw         $s0, 0x10($sp)
    /* A6B54 800B6354 2110A000 */  addu       $v0, $a1, $zero
    /* A6B58 800B6358 0800E003 */  jr         $ra
    /* A6B5C 800B635C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Sched_CreateNewSchedule__FPci
