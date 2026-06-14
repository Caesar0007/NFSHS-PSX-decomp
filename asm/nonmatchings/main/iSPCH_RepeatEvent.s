.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSPCH_RepeatEvent, 0x44

glabel iSPCH_RepeatEvent
    /* F16E0 80100EE0 21308000 */  addu       $a2, $a0, $zero
    /* F16E4 80100EE4 01000524 */  addiu      $a1, $zero, 0x1
    /* F16E8 80100EE8 1580023C */  lui        $v0, %hi(gVoxInGame)
    /* F16EC 80100EEC 0000C494 */  lhu        $a0, 0x0($a2)
    /* F16F0 80100EF0 5880438C */  lw         $v1, %lo(gVoxInGame)($v0)
    /* F16F4 80100EF4 00000000 */  nop
    /* F16F8 80100EF8 08008314 */  bne        $a0, $v1, .L80100F1C
    /* F16FC 80100EFC 58804224 */   addiu     $v0, $v0, %lo(gVoxInGame)
    /* F1700 80100F00 0800C480 */  lb         $a0, 0x8($a2)
    /* F1704 80100F04 00000000 */  nop
    /* F1708 80100F08 04008018 */  blez       $a0, .L80100F1C
    /* F170C 80100F0C 00000000 */   nop
    /* F1710 80100F10 0400428C */  lw         $v0, 0x4($v0)
    /* F1714 80100F14 00000000 */  nop
    /* F1718 80100F18 2A284400 */  slt        $a1, $v0, $a0
  .L80100F1C:
    /* F171C 80100F1C 0800E003 */  jr         $ra
    /* F1720 80100F20 2110A000 */   addu      $v0, $a1, $zero
endlabel iSPCH_RepeatEvent
