.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__10tMenuBlank7tPlayerR13tInputKeyTypeR12tMenuCommand, 0x44

glabel ProcessInput__10tMenuBlank7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* C188 8001B988 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* C18C 8001B98C 1000BFAF */  sw         $ra, 0x10($sp)
    /* C190 8001B990 0000C38C */  lw         $v1, 0x0($a2)
    /* C194 8001B994 00020224 */  addiu      $v0, $zero, 0x200
    /* C198 8001B998 03006210 */  beq        $v1, $v0, .L8001B9A8
    /* C19C 8001B99C 00040224 */   addiu     $v0, $zero, 0x400
    /* C1A0 8001B9A0 04006214 */  bne        $v1, $v0, .L8001B9B4
    /* C1A4 8001B9A4 00000000 */   nop
  .L8001B9A8:
    /* C1A8 8001B9A8 01000224 */  addiu      $v0, $zero, 0x1
    /* C1AC 8001B9AC 6F6E0008 */  j          .L8001B9BC
    /* C1B0 8001B9B0 0000C2AC */   sw        $v0, 0x0($a2)
  .L8001B9B4:
    /* C1B4 8001B9B4 5E95000C */  jal        ProcessInput__5tMenu7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* C1B8 8001B9B8 100080AC */   sw        $zero, 0x10($a0)
  .L8001B9BC:
    /* C1BC 8001B9BC 1000BF8F */  lw         $ra, 0x10($sp)
    /* C1C0 8001B9C0 00000000 */  nop
    /* C1C4 8001B9C4 0800E003 */  jr         $ra
    /* C1C8 8001B9C8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ProcessInput__10tMenuBlank7tPlayerR13tInputKeyTypeR12tMenuCommand
