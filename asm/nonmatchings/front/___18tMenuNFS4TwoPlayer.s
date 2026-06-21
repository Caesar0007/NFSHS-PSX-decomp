.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___18tMenuNFS4TwoPlayer, 0x28

glabel ___18tMenuNFS4TwoPlayer
    /* BEA8 8001B6A8 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* BEAC 8001B6AC 0180023C */  lui        $v0, %hi(_vt_18tMenuNFS4TwoPlayer)
    /* BEB0 8001B6B0 40074224 */  addiu      $v0, $v0, %lo(_vt_18tMenuNFS4TwoPlayer)
    /* BEB4 8001B6B4 1000BFAF */  sw         $ra, 0x10($sp)
    /* BEB8 8001B6B8 566C000C */  jal        ___9tMenuNFS4
    /* BEBC 8001B6BC 680082AC */   sw        $v0, 0x68($a0)
    /* BEC0 8001B6C0 1000BF8F */  lw         $ra, 0x10($sp)
    /* BEC4 8001B6C4 00000000 */  nop
    /* BEC8 8001B6C8 0800E003 */  jr         $ra
    /* BECC 8001B6CC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___18tMenuNFS4TwoPlayer
