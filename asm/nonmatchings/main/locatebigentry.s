.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching locatebigentry, 0x24

glabel locatebigentry
    /* D69B8 800E61B8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D69BC 800E61BC 3000A28F */  lw         $v0, 0x30($sp)
    /* D69C0 800E61C0 1800BFAF */  sw         $ra, 0x18($sp)
    /* D69C4 800E61C4 FF97030C */  jal        locatebigentryz
    /* D69C8 800E61C8 1000A2AF */   sw        $v0, 0x10($sp)
    /* D69CC 800E61CC 1800BF8F */  lw         $ra, 0x18($sp)
    /* D69D0 800E61D0 00000000 */  nop
    /* D69D4 800E61D4 0800E003 */  jr         $ra
    /* D69D8 800E61D8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel locatebigentry
