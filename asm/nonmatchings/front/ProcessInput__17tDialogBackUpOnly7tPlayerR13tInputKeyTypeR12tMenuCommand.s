.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__17tDialogBackUpOnly7tPlayerR13tInputKeyTypeR12tMenuCommand, 0x58

glabel ProcessInput__17tDialogBackUpOnly7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* 9F90 80019790 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 9F94 80019794 1000BFAF */  sw         $ra, 0x10($sp)
    /* 9F98 80019798 64008384 */  lh         $v1, 0x64($a0)
    /* 9F9C 8001979C FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 9FA0 800197A0 03006210 */  beq        $v1, $v0, .L800197B0
    /* 9FA4 800197A4 00000000 */   nop
    /* 9FA8 800197A8 0B00A314 */  bne        $a1, $v1, .L800197D8
    /* 9FAC 800197AC 00000000 */   nop
  .L800197B0:
    /* 9FB0 800197B0 0000C38C */  lw         $v1, 0x0($a2)
    /* 9FB4 800197B4 10000224 */  addiu      $v0, $zero, 0x10
    /* 9FB8 800197B8 05006210 */  beq        $v1, $v0, .L800197D0
    /* 9FBC 800197BC 04000224 */   addiu     $v0, $zero, 0x4
    /* 9FC0 800197C0 05006210 */  beq        $v1, $v0, .L800197D8
    /* 9FC4 800197C4 01000224 */   addiu     $v0, $zero, 0x1
    /* 9FC8 800197C8 F6650008 */  j          .L800197D8
    /* 9FCC 800197CC 0000C2AC */   sw        $v0, 0x0($a2)
  .L800197D0:
    /* 9FD0 800197D0 4162000C */  jal        Hide__11tDialogBase
    /* 9FD4 800197D4 00000000 */   nop
  .L800197D8:
    /* 9FD8 800197D8 1000BF8F */  lw         $ra, 0x10($sp)
    /* 9FDC 800197DC 00000000 */  nop
    /* 9FE0 800197E0 0800E003 */  jr         $ra
    /* 9FE4 800197E4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ProcessInput__17tDialogBackUpOnly7tPlayerR13tInputKeyTypeR12tMenuCommand
