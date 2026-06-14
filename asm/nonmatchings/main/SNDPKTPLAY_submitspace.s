.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDPKTPLAY_submitspace, 0x54

glabel SNDPKTPLAY_submitspace
    /* F3670 80102E70 1480023C */  lui        $v0, %hi(D_8014789C)
    /* F3674 80102E74 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* F3678 80102E78 00000000 */  nop
    /* F367C 80102E7C 0F004010 */  beqz       $v0, .L80102EBC
    /* F3680 80102E80 1580033C */   lui       $v1, %hi(sndpps)
    /* F3684 80102E84 74856324 */  addiu      $v1, $v1, %lo(sndpps)
    /* F3688 80102E88 80100400 */  sll        $v0, $a0, 2
    /* F368C 80102E8C 21104300 */  addu       $v0, $v0, $v1
    /* F3690 80102E90 0000438C */  lw         $v1, 0x0($v0)
    /* F3694 80102E94 00000000 */  nop
    /* F3698 80102E98 08006294 */  lhu        $v0, 0x8($v1)
    /* F369C 80102E9C 0E006394 */  lhu        $v1, 0xE($v1)
    /* F36A0 80102EA0 00140200 */  sll        $v0, $v0, 16
    /* F36A4 80102EA4 03140200 */  sra        $v0, $v0, 16
    /* F36A8 80102EA8 001C0300 */  sll        $v1, $v1, 16
    /* F36AC 80102EAC 031C0300 */  sra        $v1, $v1, 16
    /* F36B0 80102EB0 23104300 */  subu       $v0, $v0, $v1
    /* F36B4 80102EB4 0800E003 */  jr         $ra
    /* F36B8 80102EB8 FFFF4224 */   addiu     $v0, $v0, -0x1
  .L80102EBC:
    /* F36BC 80102EBC 0800E003 */  jr         $ra
    /* F36C0 80102EC0 F6FF0224 */   addiu     $v0, $zero, -0xA
endlabel SNDPKTPLAY_submitspace
