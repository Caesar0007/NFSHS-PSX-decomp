.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDabs, 0x18

glabel iSNDabs
    /* FB6DC 8010AEDC 21108000 */  addu       $v0, $a0, $zero
    /* FB6E0 8010AEE0 02004104 */  bgez       $v0, .L8010AEEC
    /* FB6E4 8010AEE4 00000000 */   nop
    /* FB6E8 8010AEE8 23100200 */  negu       $v0, $v0
  .L8010AEEC:
    /* FB6EC 8010AEEC 0800E003 */  jr         $ra
    /* FB6F0 8010AEF0 00000000 */   nop
endlabel iSNDabs
