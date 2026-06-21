.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__11tDialogBase7tPlayerR13tInputKeyTypeR12tMenuCommand, 0x44

glabel ProcessInput__11tDialogBase7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* 92C8 80018AC8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 92CC 80018ACC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 92D0 80018AD0 2188C000 */  addu       $s1, $a2, $zero
    /* 92D4 80018AD4 1800BFAF */  sw         $ra, 0x18($sp)
    /* 92D8 80018AD8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 92DC 80018ADC 0000228E */  lw         $v0, 0x0($s1)
    /* 92E0 80018AE0 01001024 */  addiu      $s0, $zero, 0x1
    /* 92E4 80018AE4 04005010 */  beq        $v0, $s0, .L80018AF8
    /* 92E8 80018AE8 00000000 */   nop
    /* 92EC 80018AEC 4162000C */  jal        Hide__11tDialogBase
    /* 92F0 80018AF0 00000000 */   nop
    /* 92F4 80018AF4 000030AE */  sw         $s0, 0x0($s1)
  .L80018AF8:
    /* 92F8 80018AF8 1800BF8F */  lw         $ra, 0x18($sp)
    /* 92FC 80018AFC 1400B18F */  lw         $s1, 0x14($sp)
    /* 9300 80018B00 1000B08F */  lw         $s0, 0x10($sp)
    /* 9304 80018B04 0800E003 */  jr         $ra
    /* 9308 80018B08 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel ProcessInput__11tDialogBase7tPlayerR13tInputKeyTypeR12tMenuCommand
