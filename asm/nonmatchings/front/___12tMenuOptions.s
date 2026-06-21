.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching ___12tMenuOptions, 0x28

glabel ___12tMenuOptions
    /* C2C4 8001BAC4 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* C2C8 8001BAC8 0180023C */  lui        $v0, %hi(_vt_12tMenuOptions)
    /* C2CC 8001BACC 20064224 */  addiu      $v0, $v0, %lo(_vt_12tMenuOptions)
    /* C2D0 8001BAD0 1000BFAF */  sw         $ra, 0x10($sp)
    /* C2D4 8001BAD4 566C000C */  jal        ___9tMenuNFS4
    /* C2D8 8001BAD8 680082AC */   sw        $v0, 0x68($a0)
    /* C2DC 8001BADC 1000BF8F */  lw         $ra, 0x10($sp)
    /* C2E0 8001BAE0 00000000 */  nop
    /* C2E4 8001BAE4 0800E003 */  jr         $ra
    /* C2E8 8001BAE8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel ___12tMenuOptions
