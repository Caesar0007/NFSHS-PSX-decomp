.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDPKTPLAY_overhead, 0x2C

glabel SNDPKTPLAY_overhead
    /* F30D0 801028D0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* F30D4 801028D4 1400BFAF */  sw         $ra, 0x14($sp)
    /* F30D8 801028D8 2F0A040C */  jal        iSNDpacketplayoverhead
    /* F30DC 801028DC 1000B0AF */   sw        $s0, 0x10($sp)
    /* F30E0 801028E0 6E10040C */  jal        iSNDplatformpacketoverhead
    /* F30E4 801028E4 21804000 */   addu      $s0, $v0, $zero
    /* F30E8 801028E8 21100202 */  addu       $v0, $s0, $v0
    /* F30EC 801028EC 1400BF8F */  lw         $ra, 0x14($sp)
    /* F30F0 801028F0 1000B08F */  lw         $s0, 0x10($sp)
    /* F30F4 801028F4 0800E003 */  jr         $ra
    /* F30F8 801028F8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SNDPKTPLAY_overhead
