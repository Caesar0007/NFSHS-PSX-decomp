.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDstreamparseend, 0x40

glabel iSNDstreamparseend
    /* D9A30 800E9230 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* D9A34 800E9234 1000B0AF */  sw         $s0, 0x10($sp)
    /* D9A38 800E9238 21808000 */  addu       $s0, $a0, $zero
    /* D9A3C 800E923C 1400BFAF */  sw         $ra, 0x14($sp)
    /* D9A40 800E9240 0400048E */  lw         $a0, 0x4($s0)
    /* D9A44 800E9244 B4F6030C */  jal        STREAM_release
    /* D9A48 800E9248 00000000 */   nop
    /* D9A4C 800E924C 17000292 */  lbu        $v0, 0x17($s0)
    /* D9A50 800E9250 00000000 */  nop
    /* D9A54 800E9254 01004224 */  addiu      $v0, $v0, 0x1
    /* D9A58 800E9258 170002A2 */  sb         $v0, 0x17($s0)
    /* D9A5C 800E925C 1400BF8F */  lw         $ra, 0x14($sp)
    /* D9A60 800E9260 1000B08F */  lw         $s0, 0x10($sp)
    /* D9A64 800E9264 01000224 */  addiu      $v0, $zero, 0x1
    /* D9A68 800E9268 0800E003 */  jr         $ra
    /* D9A6C 800E926C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDstreamparseend
