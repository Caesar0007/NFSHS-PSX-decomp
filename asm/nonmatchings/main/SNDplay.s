.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDplay, 0x38

glabel SNDplay
    /* D8230 800E7A30 1480023C */  lui        $v0, %hi(D_8014789C)
    /* D8234 800E7A34 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* D8238 800E7A38 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D823C 800E7A3C 05004010 */  beqz       $v0, .L800E7A54
    /* D8240 800E7A40 1000BFAF */   sw        $ra, 0x10($sp)
    /* D8244 800E7A44 9A9E030C */  jal        cSNDplay
    /* D8248 800E7A48 21280000 */   addu      $a1, $zero, $zero
    /* D824C 800E7A4C 969E0308 */  j          .L800E7A58
    /* D8250 800E7A50 00000000 */   nop
  .L800E7A54:
    /* D8254 800E7A54 F6FF0224 */  addiu      $v0, $zero, -0xA
  .L800E7A58:
    /* D8258 800E7A58 1000BF8F */  lw         $ra, 0x10($sp)
    /* D825C 800E7A5C 00000000 */  nop
    /* D8260 800E7A60 0800E003 */  jr         $ra
    /* D8264 800E7A64 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SNDplay
