.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DebounceKeys__20tMenuItemSlidingMenu, 0x48

glabel DebounceKeys__20tMenuItemSlidingMenu
    /* DB98 8001D398 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DB9C 8001D39C 1000BFAF */  sw         $ra, 0x10($sp)
    /* DBA0 8001D3A0 1C00838C */  lw         $v1, 0x1C($a0)
    /* DBA4 8001D3A4 00000000 */  nop
    /* DBA8 8001D3A8 09006010 */  beqz       $v1, .L8001D3D0
    /* DBAC 8001D3AC 00060224 */   addiu     $v0, $zero, 0x600
    /* DBB0 8001D3B0 6800628C */  lw         $v0, 0x68($v1)
    /* DBB4 8001D3B4 00000000 */  nop
    /* DBB8 8001D3B8 20004484 */  lh         $a0, 0x20($v0)
    /* DBBC 8001D3BC 2400428C */  lw         $v0, 0x24($v0)
    /* DBC0 8001D3C0 00000000 */  nop
    /* DBC4 8001D3C4 09F84000 */  jalr       $v0
    /* DBC8 8001D3C8 21206400 */   addu      $a0, $v1, $a0
    /* DBCC 8001D3CC 00064234 */  ori        $v0, $v0, 0x600
  .L8001D3D0:
    /* DBD0 8001D3D0 1000BF8F */  lw         $ra, 0x10($sp)
    /* DBD4 8001D3D4 00000000 */  nop
    /* DBD8 8001D3D8 0800E003 */  jr         $ra
    /* DBDC 8001D3DC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel DebounceKeys__20tMenuItemSlidingMenu
