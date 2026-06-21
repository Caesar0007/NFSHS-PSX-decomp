.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __14tInsideBoxMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme, 0x74

glabel __14tInsideBoxMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
    /* D590 8001CD90 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D594 8001CD94 2000B0AF */  sw         $s0, 0x20($sp)
    /* D598 8001CD98 21808000 */  addu       $s0, $a0, $zero
    /* D59C 8001CD9C 3800A88F */  lw         $t0, 0x38($sp)
    /* D5A0 8001CDA0 3C00A98F */  lw         $t1, 0x3C($sp)
    /* D5A4 8001CDA4 4000A28F */  lw         $v0, 0x40($sp)
    /* D5A8 8001CDA8 4400A38F */  lw         $v1, 0x44($sp)
    /* D5AC 8001CDAC 2400BFAF */  sw         $ra, 0x24($sp)
    /* D5B0 8001CDB0 00140200 */  sll        $v0, $v0, 16
    /* D5B4 8001CDB4 03140200 */  sra        $v0, $v0, 16
    /* D5B8 8001CDB8 1000A8AF */  sw         $t0, 0x10($sp)
    /* D5BC 8001CDBC 1400A9AF */  sw         $t1, 0x14($sp)
    /* D5C0 8001CDC0 1B95000C */  jal        __5tMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vs
    /* D5C4 8001CDC4 1800A2AF */   sw        $v0, 0x18($sp)
    /* D5C8 8001CDC8 21200002 */  addu       $a0, $s0, $zero
    /* D5CC 8001CDCC 4800A627 */  addiu      $a2, $sp, 0x48
    /* D5D0 8001CDD0 0180023C */  lui        $v0, %hi(_vt_14tInsideBoxMenu)
    /* D5D4 8001CDD4 4400A58F */  lw         $a1, 0x44($sp)
    /* D5D8 8001CDD8 A80E4224 */  addiu      $v0, $v0, %lo(_vt_14tInsideBoxMenu)
    /* D5DC 8001CDDC 0D95000C */  jal        tMenuConstructor__5tMenuP9tMenuItemPv
    /* D5E0 8001CDE0 680002AE */   sw        $v0, 0x68($s0)
    /* D5E4 8001CDE4 21100002 */  addu       $v0, $s0, $zero
    /* D5E8 8001CDE8 6C0040A4 */  sh         $zero, 0x6C($v0)
    /* D5EC 8001CDEC 6E0040A4 */  sh         $zero, 0x6E($v0)
    /* D5F0 8001CDF0 700040A4 */  sh         $zero, 0x70($v0)
    /* D5F4 8001CDF4 2400BF8F */  lw         $ra, 0x24($sp)
    /* D5F8 8001CDF8 2000B08F */  lw         $s0, 0x20($sp)
    /* D5FC 8001CDFC 0800E003 */  jr         $ra
    /* D600 8001CE00 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel __14tInsideBoxMenuUiP7tScreenP5tMenuT3PFR12tMenuCommand_vsP9tMenuIteme
