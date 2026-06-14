.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDstreamreleasecallback, 0x44

glabel iSNDstreamreleasecallback
    /* D9590 800E8D90 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D9594 800E8D94 1000BFAF */  sw         $ra, 0x10($sp)
    /* D9598 800E8D98 FCFF858C */  lw         $a1, -0x4($a0)
    /* D959C 800E8D9C 1480033C */  lui        $v1, %hi(sndss)
    /* D95A0 800E8DA0 0000A290 */  lbu        $v0, 0x0($a1)
    /* D95A4 800E8DA4 80EA6324 */  addiu      $v1, $v1, %lo(sndss)
    /* D95A8 800E8DA8 80100200 */  sll        $v0, $v0, 2
    /* D95AC 800E8DAC 21104300 */  addu       $v0, $v0, $v1
    /* D95B0 800E8DB0 0000428C */  lw         $v0, 0x0($v0)
    /* D95B4 800E8DB4 00000000 */  nop
    /* D95B8 800E8DB8 0400448C */  lw         $a0, 0x4($v0)
    /* D95BC 800E8DBC B4F6030C */  jal        STREAM_release
    /* D95C0 800E8DC0 00000000 */   nop
    /* D95C4 800E8DC4 1000BF8F */  lw         $ra, 0x10($sp)
    /* D95C8 800E8DC8 00000000 */  nop
    /* D95CC 800E8DCC 0800E003 */  jr         $ra
    /* D95D0 800E8DD0 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDstreamreleasecallback
