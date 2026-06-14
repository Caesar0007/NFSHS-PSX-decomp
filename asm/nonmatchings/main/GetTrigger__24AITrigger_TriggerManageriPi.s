.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetTrigger__24AITrigger_TriggerManageriPi, 0x68

glabel GetTrigger__24AITrigger_TriggerManageriPi
    /* 634D8 80072CD8 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 634DC 80072CDC 80180500 */  sll        $v1, $a1, 2
    /* 634E0 80072CE0 21188300 */  addu       $v1, $a0, $v1
    /* 634E4 80072CE4 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 634E8 80072CE8 9801638C */  lw         $v1, 0x198($v1)
    /* 634EC 80072CEC 00000000 */  nop
    /* 634F0 80072CF0 23104300 */  subu       $v0, $v0, $v1
    /* 634F4 80072CF4 010A4228 */  slti       $v0, $v0, 0xA01
    /* 634F8 80072CF8 03004014 */  bnez       $v0, .L80072D08
    /* 634FC 80072CFC 01000224 */   addiu     $v0, $zero, 0x1
    /* 63500 80072D00 43CB0108 */  j          .L80072D0C
    /* 63504 80072D04 0000C0AC */   sw        $zero, 0x0($a2)
  .L80072D08:
    /* 63508 80072D08 0000C2AC */  sw         $v0, 0x0($a2)
  .L80072D0C:
    /* 6350C 80072D0C 80180500 */  sll        $v1, $a1, 2
    /* 63510 80072D10 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* 63514 80072D14 B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 63518 80072D18 21308300 */  addu       $a2, $a0, $v1
    /* 6351C 80072D1C 9801C2AC */  sw         $v0, 0x198($a2)
    /* 63520 80072D20 0000828C */  lw         $v0, 0x0($a0)
    /* 63524 80072D24 00000000 */  nop
    /* 63528 80072D28 2A10A200 */  slt        $v0, $a1, $v0
    /* 6352C 80072D2C 02004010 */  beqz       $v0, .L80072D38
    /* 63530 80072D30 21180000 */   addu      $v1, $zero, $zero
    /* 63534 80072D34 0800C38C */  lw         $v1, 0x8($a2)
  .L80072D38:
    /* 63538 80072D38 0800E003 */  jr         $ra
    /* 6353C 80072D3C 21106000 */   addu      $v0, $v1, $zero
endlabel GetTrigger__24AITrigger_TriggerManageriPi
