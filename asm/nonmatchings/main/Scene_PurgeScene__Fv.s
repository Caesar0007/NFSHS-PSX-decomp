.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Scene_PurgeScene__Fv, 0x34

glabel Scene_PurgeScene__Fv
    /* A67B0 800B5FB0 BC0E848F */  lw         $a0, %gp_rel(gGameSceneList)($gp)
    /* A67B4 800B5FB4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* A67B8 800B5FB8 04008010 */  beqz       $a0, .L800B5FCC
    /* A67BC 800B5FBC 1000BFAF */   sw        $ra, 0x10($sp)
    /* A67C0 800B5FC0 5095030C */  jal        purgememadr
    /* A67C4 800B5FC4 00000000 */   nop
    /* A67C8 800B5FC8 BC0E80AF */  sw         $zero, %gp_rel(gGameSceneList)($gp)
  .L800B5FCC:
    /* A67CC 800B5FCC 9B95020C */  jal        Object_ClearCustomObjects__Fv
    /* A67D0 800B5FD0 00000000 */   nop
    /* A67D4 800B5FD4 1000BF8F */  lw         $ra, 0x10($sp)
    /* A67D8 800B5FD8 00000000 */  nop
    /* A67DC 800B5FDC 0800E003 */  jr         $ra
    /* A67E0 800B5FE0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel Scene_PurgeScene__Fv
