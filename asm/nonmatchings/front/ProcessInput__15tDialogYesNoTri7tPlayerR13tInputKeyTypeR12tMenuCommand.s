.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__15tDialogYesNoTri7tPlayerR13tInputKeyTypeR12tMenuCommand, 0x40

glabel ProcessInput__15tDialogYesNoTri7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* A67C 80019E7C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A680 80019E80 1000BFAF */  sw         $ra, 0x10($sp)
    /* A684 80019E84 0000C38C */  lw         $v1, 0x0($a2)
    /* A688 80019E88 10000224 */  addiu      $v0, $zero, 0x10
    /* A68C 80019E8C 05006214 */  bne        $v1, $v0, .L80019EA4
    /* A690 80019E90 01000224 */   addiu     $v0, $zero, 0x1
    /* A694 80019E94 980082AC */  sw         $v0, 0x98($a0)
    /* A698 80019E98 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* A69C 80019E9C AB670008 */  j          .L80019EAC
    /* A6A0 80019EA0 8A0082A4 */   sh        $v0, 0x8A($a0)
  .L80019EA4:
    /* A6A4 80019EA4 3367000C */  jal        ProcessInput__12tDialogYesNo7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* A6A8 80019EA8 00000000 */   nop
  .L80019EAC:
    /* A6AC 80019EAC 1000BF8F */  lw         $ra, 0x10($sp)
    /* A6B0 80019EB0 00000000 */  nop
    /* A6B4 80019EB4 0800E003 */  jr         $ra
    /* A6B8 80019EB8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ProcessInput__15tDialogYesNoTri7tPlayerR13tInputKeyTypeR12tMenuCommand
