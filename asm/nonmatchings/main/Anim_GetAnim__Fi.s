.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Anim_GetAnim__Fi, 0x1C

glabel Anim_GetAnim__Fi
    /* 645EC 80073DEC 1180023C */  lui        $v0, %hi(animSlots)
    /* 645F0 80073DF0 4CE14224 */  addiu      $v0, $v0, %lo(animSlots)
    /* 645F4 80073DF4 80200400 */  sll        $a0, $a0, 2
    /* 645F8 80073DF8 21208200 */  addu       $a0, $a0, $v0
    /* 645FC 80073DFC 0000828C */  lw         $v0, 0x0($a0)
    /* 64600 80073E00 0800E003 */  jr         $ra
    /* 64604 80073E04 00000000 */   nop
endlabel Anim_GetAnim__Fi
