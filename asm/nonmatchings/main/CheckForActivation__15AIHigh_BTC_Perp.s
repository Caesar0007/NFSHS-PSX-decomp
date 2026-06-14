.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CheckForActivation__15AIHigh_BTC_Perp, 0x108

glabel CheckForActivation__15AIHigh_BTC_Perp
    /* 50774 8005FF74 21588000 */  addu       $t3, $a0, $zero
    /* 50778 8005FF78 21380000 */  addu       $a3, $zero, $zero
    /* 5077C 8005FF7C 1480083C */  lui        $t0, %hi(Cars_gNumCars)
    /* 50780 8005FF80 F4C7088D */  lw         $t0, %lo(Cars_gNumCars)($t0)
    /* 50784 8005FF84 1180023C */  lui        $v0, %hi(highLevelAIObjs)
    /* 50788 8005FF88 38CD4A24 */  addiu      $t2, $v0, %lo(highLevelAIObjs)
    /* 5078C 8005FF8C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 50790 8005FF90 EC314924 */  addiu      $t1, $v0, %lo(GameSetup_gData)
    /* 50794 8005FF94 1180023C */  lui        $v0, %hi(Cars_gList)
    /* 50798 8005FF98 DCF94624 */  addiu      $a2, $v0, %lo(Cars_gList)
  .L8005FF9C:
    /* 5079C 8005FF9C 2A10E800 */  slt        $v0, $a3, $t0
    /* 507A0 8005FFA0 34004010 */  beqz       $v0, .L80060074
    /* 507A4 8005FFA4 00000000 */   nop
    /* 507A8 8005FFA8 0000C38C */  lw         $v1, 0x0($a2)
    /* 507AC 8005FFAC 00000000 */  nop
    /* 507B0 8005FFB0 6002628C */  lw         $v0, 0x260($v1)
    /* 507B4 8005FFB4 00000000 */  nop
    /* 507B8 8005FFB8 00024230 */  andi       $v0, $v0, 0x200
    /* 507BC 8005FFBC 2A004010 */  beqz       $v0, .L80060068
    /* 507C0 8005FFC0 00000000 */   nop
    /* 507C4 8005FFC4 91006290 */  lbu        $v0, 0x91($v1)
    /* 507C8 8005FFC8 00000000 */  nop
    /* 507CC 8005FFCC 26004010 */  beqz       $v0, .L80060068
    /* 507D0 8005FFD0 00000000 */   nop
    /* 507D4 8005FFD4 5402628C */  lw         $v0, 0x254($v1)
    /* 507D8 8005FFD8 00000000 */  nop
    /* 507DC 8005FFDC 80100200 */  sll        $v0, $v0, 2
    /* 507E0 8005FFE0 21104A00 */  addu       $v0, $v0, $t2
    /* 507E4 8005FFE4 0000458C */  lw         $a1, 0x0($v0)
    /* 507E8 8005FFE8 00000000 */  nop
    /* 507EC 8005FFEC 1C00A28C */  lw         $v0, 0x1C($a1)
    /* 507F0 8005FFF0 00000000 */  nop
    /* 507F4 8005FFF4 02004014 */  bnez       $v0, .L80060000
    /* 507F8 8005FFF8 21180000 */   addu      $v1, $zero, $zero
    /* 507FC 8005FFFC 7C00A38C */  lw         $v1, 0x7C($a1)
  .L80060000:
    /* 50800 80060000 00000000 */  nop
    /* 50804 80060004 18006010 */  beqz       $v1, .L80060068
    /* 50808 80060008 00000000 */   nop
    /* 5080C 8006000C 0000648D */  lw         $a0, 0x0($t3)
    /* 50810 80060010 00000000 */  nop
    /* 50814 80060014 6002828C */  lw         $v0, 0x260($a0)
    /* 50818 80060018 00000000 */  nop
    /* 5081C 8006001C 04004230 */  andi       $v0, $v0, 0x4
    /* 50820 80060020 03004010 */  beqz       $v0, .L80060030
    /* 50824 80060024 00000000 */   nop
  .L80060028:
    /* 50828 80060028 0800E003 */  jr         $ra
    /* 5082C 8006002C 2110A000 */   addu      $v0, $a1, $zero
  .L80060030:
    /* 50830 80060030 6400A38C */  lw         $v1, 0x64($a1)
    /* 50834 80060034 00000000 */  nop
    /* 50838 80060038 40100300 */  sll        $v0, $v1, 1
    /* 5083C 8006003C 21104300 */  addu       $v0, $v0, $v1
    /* 50840 80060040 80100200 */  sll        $v0, $v0, 2
    /* 50844 80060044 21104300 */  addu       $v0, $v0, $v1
    /* 50848 80060048 80100200 */  sll        $v0, $v0, 2
    /* 5084C 8006004C 21104900 */  addu       $v0, $v0, $t1
    /* 50850 80060050 8802838C */  lw         $v1, 0x288($a0)
    /* 50854 80060054 BC01448C */  lw         $a0, 0x1BC($v0)
    /* 50858 80060058 0000628C */  lw         $v0, 0x0($v1)
    /* 5085C 8006005C 00000000 */  nop
    /* 50860 80060060 F1FF8210 */  beq        $a0, $v0, .L80060028
    /* 50864 80060064 00000000 */   nop
  .L80060068:
    /* 50868 80060068 0400C624 */  addiu      $a2, $a2, 0x4
    /* 5086C 8006006C E77F0108 */  j          .L8005FF9C
    /* 50870 80060070 0100E724 */   addiu     $a3, $a3, 0x1
  .L80060074:
    /* 50874 80060074 0800E003 */  jr         $ra
    /* 50878 80060078 21100000 */   addu      $v0, $zero, $zero
endlabel CheckForActivation__15AIHigh_BTC_Perp
