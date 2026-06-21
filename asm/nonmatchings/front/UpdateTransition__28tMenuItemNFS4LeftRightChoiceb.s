.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateTransition__28tMenuItemNFS4LeftRightChoiceb, 0x5C

glabel UpdateTransition__28tMenuItemNFS4LeftRightChoiceb
    /* B384 8001AB84 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* B388 8001AB88 1000BFAF */  sw         $ra, 0x10($sp)
    /* B38C 8001AB8C 22008294 */  lhu        $v0, 0x22($a0)
    /* B390 8001AB90 24008394 */  lhu        $v1, 0x24($a0)
    /* B394 8001AB94 00000000 */  nop
    /* B398 8001AB98 21104300 */  addu       $v0, $v0, $v1
    /* B39C 8001AB9C 220082A4 */  sh         $v0, 0x22($a0)
    /* B3A0 8001ABA0 00140200 */  sll        $v0, $v0, 16
    /* B3A4 8001ABA4 03140200 */  sra        $v0, $v0, 16
    /* B3A8 8001ABA8 03004104 */  bgez       $v0, .L8001ABB8
    /* B3AC 8001ABAC 81004228 */   slti      $v0, $v0, 0x81
    /* B3B0 8001ABB0 F16A0008 */  j          .L8001ABC4
    /* B3B4 8001ABB4 220080A4 */   sh        $zero, 0x22($a0)
  .L8001ABB8:
    /* B3B8 8001ABB8 03004014 */  bnez       $v0, .L8001ABC8
    /* B3BC 8001ABBC 80000224 */   addiu     $v0, $zero, 0x80
    /* B3C0 8001ABC0 220082A4 */  sh         $v0, 0x22($a0)
  .L8001ABC4:
    /* B3C4 8001ABC4 240080A4 */  sh         $zero, 0x24($a0)
  .L8001ABC8:
    /* B3C8 8001ABC8 EA91000C */  jal        UpdateTransition__9tMenuItemb
    /* B3CC 8001ABCC 00000000 */   nop
    /* B3D0 8001ABD0 1000BF8F */  lw         $ra, 0x10($sp)
    /* B3D4 8001ABD4 00000000 */  nop
    /* B3D8 8001ABD8 0800E003 */  jr         $ra
    /* B3DC 8001ABDC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel UpdateTransition__28tMenuItemNFS4LeftRightChoiceb
