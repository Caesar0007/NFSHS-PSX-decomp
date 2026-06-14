.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _SN_read, 0x18

glabel _SN_read
    /* FCF08 8010C708 4D410000 */  break      0, 261
    /* FCF0C 8010C70C 02004010 */  beqz       $v0, .L8010C718
    /* FCF10 8010C710 21106000 */   addu      $v0, $v1, $zero
    /* FCF14 8010C714 FFFF0224 */  addiu      $v0, $zero, -0x1
  .L8010C718:
    /* FCF18 8010C718 0800E003 */  jr         $ra
    /* FCF1C 8010C71C 00000000 */   nop
endlabel _SN_read
