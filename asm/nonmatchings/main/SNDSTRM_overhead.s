.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSTRM_overhead, 0x44

glabel SNDSTRM_overhead
    /* DA894 800EA094 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DA898 800EA098 1400B1AF */  sw         $s1, 0x14($sp)
    /* DA89C 800EA09C 21888000 */  addu       $s1, $a0, $zero
    /* DA8A0 800EA0A0 1800BFAF */  sw         $ra, 0x18($sp)
    /* DA8A4 800EA0A4 15A8030C */  jal        SNDSTRM_overheadtap
    /* DA8A8 800EA0A8 1000B0AF */   sw        $s0, 0x10($sp)
    /* DA8AC 800EA0AC 21804000 */  addu       $s0, $v0, $zero
    /* DA8B0 800EA0B0 01002426 */  addiu      $a0, $s1, 0x1
    /* DA8B4 800EA0B4 01000524 */  addiu      $a1, $zero, 0x1
    /* DA8B8 800EA0B8 78F3030C */  jal        STREAM_overhead
    /* DA8BC 800EA0BC 2130A000 */   addu      $a2, $a1, $zero
    /* DA8C0 800EA0C0 21100202 */  addu       $v0, $s0, $v0
    /* DA8C4 800EA0C4 1800BF8F */  lw         $ra, 0x18($sp)
    /* DA8C8 800EA0C8 1400B18F */  lw         $s1, 0x14($sp)
    /* DA8CC 800EA0CC 1000B08F */  lw         $s0, 0x10($sp)
    /* DA8D0 800EA0D0 0800E003 */  jr         $ra
    /* DA8D4 800EA0D4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SNDSTRM_overhead
