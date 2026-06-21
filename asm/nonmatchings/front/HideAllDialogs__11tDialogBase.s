.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching HideAllDialogs__11tDialogBase, 0x40

glabel HideAllDialogs__11tDialogBase
    /* 8FF0 800187F0 21180000 */  addu       $v1, $zero, $zero
    /* 8FF4 800187F4 0580023C */  lui        $v0, %hi(_front_data_orgend)
    /* 8FF8 800187F8 382B4424 */  addiu      $a0, $v0, %lo(_front_data_orgend)
    /* 8FFC 800187FC 00140300 */  sll        $v0, $v1, 16
  .L80018800:
    /* 9000 80018800 83130200 */  sra        $v0, $v0, 14
    /* 9004 80018804 21104400 */  addu       $v0, $v0, $a0
    /* 9008 80018808 000040AC */  sw         $zero, 0x0($v0)
    /* 900C 8001880C 01006224 */  addiu      $v0, $v1, 0x1
    /* 9010 80018810 21184000 */  addu       $v1, $v0, $zero
    /* 9014 80018814 00140200 */  sll        $v0, $v0, 16
    /* 9018 80018818 03140200 */  sra        $v0, $v0, 16
    /* 901C 8001881C 08004228 */  slti       $v0, $v0, 0x8
    /* 9020 80018820 F7FF4014 */  bnez       $v0, .L80018800
    /* 9024 80018824 00140300 */   sll       $v0, $v1, 16
    /* 9028 80018828 0800E003 */  jr         $ra
    /* 902C 8001882C 00000000 */   nop
endlabel HideAllDialogs__11tDialogBase
