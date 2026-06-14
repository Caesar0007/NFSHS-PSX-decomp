.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _SN_write, 0x18

glabel _SN_write
    /* FCF20 8010C720 8D410000 */  break      0, 262
    /* FCF24 8010C724 02004010 */  beqz       $v0, .L8010C730
    /* FCF28 8010C728 21106000 */   addu      $v0, $v1, $zero
    /* FCF2C 8010C72C FFFF0224 */  addiu      $v0, $zero, -0x1
  .L8010C730:
    /* FCF30 8010C730 0800E003 */  jr         $ra
    /* FCF34 8010C734 00000000 */   nop
endlabel _SN_write
