.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDPKTPLAY_unsafeframesoutstanding, 0x28

glabel SNDPKTPLAY_unsafeframesoutstanding
    /* F36C4 80102EC4 1580023C */  lui        $v0, %hi(sndpps)
    /* F36C8 80102EC8 74854224 */  addiu      $v0, $v0, %lo(sndpps)
    /* F36CC 80102ECC 80200400 */  sll        $a0, $a0, 2
    /* F36D0 80102ED0 21208200 */  addu       $a0, $a0, $v0
    /* F36D4 80102ED4 0000828C */  lw         $v0, 0x0($a0)
    /* F36D8 80102ED8 00000000 */  nop
    /* F36DC 80102EDC 1000438C */  lw         $v1, 0x10($v0)
    /* F36E0 80102EE0 1400428C */  lw         $v0, 0x14($v0)
    /* F36E4 80102EE4 0800E003 */  jr         $ra
    /* F36E8 80102EE8 21106200 */   addu      $v0, $v1, $v0
endlabel SNDPKTPLAY_unsafeframesoutstanding
