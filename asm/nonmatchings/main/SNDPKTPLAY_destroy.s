.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDPKTPLAY_destroy, 0x54

glabel SNDPKTPLAY_destroy
    /* F39F4 801031F4 1480023C */  lui        $v0, %hi(D_8014789C)
    /* F39F8 801031F8 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* F39FC 801031FC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F3A00 80103200 1000B0AF */  sw         $s0, 0x10($sp)
    /* F3A04 80103204 21808000 */  addu       $s0, $a0, $zero
    /* F3A08 80103208 0A004010 */  beqz       $v0, .L80103234
    /* F3A0C 8010320C 1400BFAF */   sw        $ra, 0x14($sp)
    /* F3A10 80103210 B010040C */  jal        iSNDplatformpacketplaydestroy
    /* F3A14 80103214 00000000 */   nop
    /* F3A18 80103218 1580033C */  lui        $v1, %hi(sndpps)
    /* F3A1C 8010321C 74856324 */  addiu      $v1, $v1, %lo(sndpps)
    /* F3A20 80103220 80101000 */  sll        $v0, $s0, 2
    /* F3A24 80103224 21104300 */  addu       $v0, $v0, $v1
    /* F3A28 80103228 000040AC */  sw         $zero, 0x0($v0)
    /* F3A2C 8010322C 8E0C0408 */  j          .L80103238
    /* F3A30 80103230 21100000 */   addu      $v0, $zero, $zero
  .L80103234:
    /* F3A34 80103234 F6FF0224 */  addiu      $v0, $zero, -0xA
  .L80103238:
    /* F3A38 80103238 1400BF8F */  lw         $ra, 0x14($sp)
    /* F3A3C 8010323C 1000B08F */  lw         $s0, 0x10($sp)
    /* F3A40 80103240 0800E003 */  jr         $ra
    /* F3A44 80103244 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SNDPKTPLAY_destroy
