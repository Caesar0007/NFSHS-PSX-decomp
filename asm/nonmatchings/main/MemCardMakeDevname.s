.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching MemCardMakeDevname, 0x5C

glabel MemCardMakeDevname
    /* EC9F4 800FC1F4 21308000 */  addu       $a2, $a0, $zero
    /* EC9F8 800FC1F8 2138A000 */  addu       $a3, $a1, $zero
    /* EC9FC 800FC1FC 0580053C */  lui        $a1, %hi(D_800574E0)
    /* ECA00 800FC200 E074A524 */  addiu      $a1, $a1, %lo(D_800574E0)
    /* ECA04 800FC204 0300A288 */  lwl        $v0, 0x3($a1)
    /* ECA08 800FC208 0000A298 */  lwr        $v0, 0x0($a1)
    /* ECA0C 800FC20C 0400A380 */  lb         $v1, 0x4($a1)
    /* ECA10 800FC210 0500A480 */  lb         $a0, 0x5($a1)
    /* ECA14 800FC214 0300E2A8 */  swl        $v0, 0x3($a3)
    /* ECA18 800FC218 0000E2B8 */  swr        $v0, 0x0($a3)
    /* ECA1C 800FC21C 0400E3A0 */  sb         $v1, 0x4($a3)
    /* ECA20 800FC220 0500E4A0 */  sb         $a0, 0x5($a3)
    /* ECA24 800FC224 0200C104 */  bgez       $a2, .L800FC230
    /* ECA28 800FC228 2110C000 */   addu      $v0, $a2, $zero
    /* ECA2C 800FC22C 0F00C224 */  addiu      $v0, $a2, 0xF
  .L800FC230:
    /* ECA30 800FC230 03110200 */  sra        $v0, $v0, 4
    /* ECA34 800FC234 30004324 */  addiu      $v1, $v0, 0x30
    /* ECA38 800FC238 00110200 */  sll        $v0, $v0, 4
    /* ECA3C 800FC23C 2310C200 */  subu       $v0, $a2, $v0
    /* ECA40 800FC240 30004224 */  addiu      $v0, $v0, 0x30
    /* ECA44 800FC244 0200E3A0 */  sb         $v1, 0x2($a3)
    /* ECA48 800FC248 0800E003 */  jr         $ra
    /* ECA4C 800FC24C 0300E2A0 */   sb        $v0, 0x3($a3)
endlabel MemCardMakeDevname
