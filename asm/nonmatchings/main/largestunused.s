.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching largestunused, 0x50

glabel largestunused
    /* D5A84 800E5284 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D5A88 800E5288 1480033C */  lui        $v1, %hi(memclass)
    /* D5A8C 800E528C 00E96324 */  addiu      $v1, $v1, %lo(memclass)
    /* D5A90 800E5290 1480023C */  lui        $v0, %hi(mb_default)
    /* D5A94 800E5294 C8DC428C */  lw         $v0, %lo(mb_default)($v0)
    /* D5A98 800E5298 21280000 */  addu       $a1, $zero, $zero
    /* D5A9C 800E529C 1000BFAF */  sw         $ra, 0x10($sp)
    /* D5AA0 800E52A0 0F004230 */  andi       $v0, $v0, 0xF
    /* D5AA4 800E52A4 80100200 */  sll        $v0, $v0, 2
    /* D5AA8 800E52A8 21104300 */  addu       $v0, $v0, $v1
    /* D5AAC 800E52AC 0000448C */  lw         $a0, 0x0($v0)
    /* D5AB0 800E52B0 6C93030C */  jal        FREE_findlargest
    /* D5AB4 800E52B4 2130A000 */   addu      $a2, $a1, $zero
    /* D5AB8 800E52B8 02004010 */  beqz       $v0, .L800E52C4
    /* D5ABC 800E52BC 21180000 */   addu      $v1, $zero, $zero
    /* D5AC0 800E52C0 0400438C */  lw         $v1, 0x4($v0)
  .L800E52C4:
    /* D5AC4 800E52C4 1000BF8F */  lw         $ra, 0x10($sp)
    /* D5AC8 800E52C8 21106000 */  addu       $v0, $v1, $zero
    /* D5ACC 800E52CC 0800E003 */  jr         $ra
    /* D5AD0 800E52D0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel largestunused
