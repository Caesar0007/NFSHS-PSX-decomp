.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Execute__17AIState_Purgatory, 0x68

glabel Execute__17AIState_Purgatory
    /* 61FD8 800717D8 0000828C */  lw         $v0, 0x0($a0)
    /* 61FDC 800717DC 00000000 */  nop
    /* 61FE0 800717E0 880740AC */  sw         $zero, 0x788($v0)
    /* 61FE4 800717E4 0000828C */  lw         $v0, 0x0($a0)
    /* 61FE8 800717E8 00000000 */  nop
    /* 61FEC 800717EC 9C0140AC */  sw         $zero, 0x19C($v0)
    /* 61FF0 800717F0 0000848C */  lw         $a0, 0x0($a0)
    /* 61FF4 800717F4 00000000 */  nop
    /* 61FF8 800717F8 6002828C */  lw         $v0, 0x260($a0)
    /* 61FFC 800717FC 00000000 */  nop
    /* 62000 80071800 20004230 */  andi       $v0, $v0, 0x20
    /* 62004 80071804 0C004014 */  bnez       $v0, .L80071838
    /* 62008 80071808 1280023C */   lui       $v0, %hi(D_8011E0B0)
    /* 6200C 8007180C B0E0428C */  lw         $v0, %lo(D_8011E0B0)($v0)
    /* 62010 80071810 00000000 */  nop
    /* 62014 80071814 C0034228 */  slti       $v0, $v0, 0x3C0
    /* 62018 80071818 07004014 */  bnez       $v0, .L80071838
    /* 6201C 8007181C 00000000 */   nop
    /* 62020 80071820 8C05828C */  lw         $v0, 0x58C($a0)
    /* 62024 80071824 1480033C */  lui        $v1, %hi(AI_elapsedTime)
    /* 62028 80071828 54C5638C */  lw         $v1, %lo(AI_elapsedTime)($v1)
    /* 6202C 8007182C 00000000 */  nop
    /* 62030 80071830 23104300 */  subu       $v0, $v0, $v1
    /* 62034 80071834 8C0582AC */  sw         $v0, 0x58C($a0)
  .L80071838:
    /* 62038 80071838 0800E003 */  jr         $ra
    /* 6203C 8007183C 00000000 */   nop
endlabel Execute__17AIState_Purgatory
