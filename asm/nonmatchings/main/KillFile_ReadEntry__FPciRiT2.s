.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching KillFile_ReadEntry__FPciRiT2, 0x20

glabel KillFile_ReadEntry__FPciRiT2
    /* AB594 800BAD94 C0280500 */  sll        $a1, $a1, 3
    /* AB598 800BAD98 21208500 */  addu       $a0, $a0, $a1
    /* AB59C 800BAD9C 0400828C */  lw         $v0, 0x4($a0)
    /* AB5A0 800BADA0 00000000 */  nop
    /* AB5A4 800BADA4 0000C2AC */  sw         $v0, 0x0($a2)
    /* AB5A8 800BADA8 0800828C */  lw         $v0, 0x8($a0)
    /* AB5AC 800BADAC 0800E003 */  jr         $ra
    /* AB5B0 800BADB0 0000E2AC */   sw        $v0, 0x0($a3)
endlabel KillFile_ReadEntry__FPciRiT2
