.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDstreamparsenumchunks, 0x68

glabel iSNDstreamparsenumchunks
    /* D9844 800E9044 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* D9848 800E9048 1000B0AF */  sw         $s0, 0x10($sp)
    /* D984C 800E904C 21808000 */  addu       $s0, $a0, $zero
    /* D9850 800E9050 1400B1AF */  sw         $s1, 0x14($sp)
    /* D9854 800E9054 1800BFAF */  sw         $ra, 0x18($sp)
    /* D9858 800E9058 0400048E */  lw         $a0, 0x4($s0)
    /* D985C 800E905C B4F6030C */  jal        STREAM_release
    /* D9860 800E9060 2188A000 */   addu      $s1, $a1, $zero
    /* D9864 800E9064 17000392 */  lbu        $v1, 0x17($s0)
    /* D9868 800E9068 0C00248E */  lw         $a0, 0xC($s1)
    /* D986C 800E906C 001E0300 */  sll        $v1, $v1, 24
    /* D9870 800E9070 031E0300 */  sra        $v1, $v1, 24
    /* D9874 800E9074 40100300 */  sll        $v0, $v1, 1
    /* D9878 800E9078 21104300 */  addu       $v0, $v0, $v1
    /* D987C 800E907C 80100200 */  sll        $v0, $v0, 2
    /* D9880 800E9080 23104300 */  subu       $v0, $v0, $v1
    /* D9884 800E9084 0000038E */  lw         $v1, 0x0($s0)
    /* D9888 800E9088 80100200 */  sll        $v0, $v0, 2
    /* D988C 800E908C 21104300 */  addu       $v0, $v0, $v1
    /* D9890 800E9090 240044AC */  sw         $a0, 0x24($v0)
    /* D9894 800E9094 1800BF8F */  lw         $ra, 0x18($sp)
    /* D9898 800E9098 1400B18F */  lw         $s1, 0x14($sp)
    /* D989C 800E909C 1000B08F */  lw         $s0, 0x10($sp)
    /* D98A0 800E90A0 01000224 */  addiu      $v0, $zero, 0x1
    /* D98A4 800E90A4 0800E003 */  jr         $ra
    /* D98A8 800E90A8 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iSNDstreamparsenumchunks
