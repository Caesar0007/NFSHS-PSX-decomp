.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ProcessInput__12tMenuOptions7tPlayerR13tInputKeyTypeR12tMenuCommand, 0x34

glabel ProcessInput__12tMenuOptions7tPlayerR13tInputKeyTypeR12tMenuCommand
    /* C6BC 8001BEBC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* C6C0 8001BEC0 1000BFAF */  sw         $ra, 0x10($sp)
    /* C6C4 8001BEC4 0000C38C */  lw         $v1, 0x0($a2)
    /* C6C8 8001BEC8 08000224 */  addiu      $v0, $zero, 0x8
    /* C6CC 8001BECC 02006214 */  bne        $v1, $v0, .L8001BED8
    /* C6D0 8001BED0 10000224 */   addiu     $v0, $zero, 0x10
    /* C6D4 8001BED4 0000C2AC */  sw         $v0, 0x0($a2)
  .L8001BED8:
    /* C6D8 8001BED8 8C6C000C */  jal        ProcessInput__9tMenuNFS47tPlayerR13tInputKeyTypeR12tMenuCommand
    /* C6DC 8001BEDC 00000000 */   nop
    /* C6E0 8001BEE0 1000BF8F */  lw         $ra, 0x10($sp)
    /* C6E4 8001BEE4 00000000 */  nop
    /* C6E8 8001BEE8 0800E003 */  jr         $ra
    /* C6EC 8001BEEC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ProcessInput__12tMenuOptions7tPlayerR13tInputKeyTypeR12tMenuCommand
