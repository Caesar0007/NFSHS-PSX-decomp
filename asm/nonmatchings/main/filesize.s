.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching filesize, 0x44

glabel filesize
    /* D5E6C 800E566C 1480023C */  lui        $v0, %hi(abortflag)
    /* D5E70 800E5670 D4DC428C */  lw         $v0, %lo(abortflag)($v0)
    /* D5E74 800E5674 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D5E78 800E5678 2000BFAF */  sw         $ra, 0x20($sp)
    /* D5E7C 800E567C 1000A4AF */  sw         $a0, 0x10($sp)
    /* D5E80 800E5680 45D8030C */  jal        setclipwindow
    /* D5E84 800E5684 1C00A2AF */   sw        $v0, 0x1C($sp)
    /* D5E88 800E5688 0E80043C */  lui        $a0, %hi(filesizeatomic)
    /* D5E8C 800E568C 08568424 */  addiu      $a0, $a0, %lo(filesizeatomic)
    /* D5E90 800E5690 21284000 */  addu       $a1, $v0, $zero
    /* D5E94 800E5694 64000624 */  addiu      $a2, $zero, 0x64
    /* D5E98 800E5698 D0B2030C */  jal        FILE_atomic
    /* D5E9C 800E569C 1000A727 */   addiu     $a3, $sp, 0x10
    /* D5EA0 800E56A0 2000BF8F */  lw         $ra, 0x20($sp)
    /* D5EA4 800E56A4 00000000 */  nop
    /* D5EA8 800E56A8 0800E003 */  jr         $ra
    /* D5EAC 800E56AC 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel filesize
