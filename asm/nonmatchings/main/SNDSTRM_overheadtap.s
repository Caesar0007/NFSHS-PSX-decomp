.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSTRM_overheadtap, 0x40

glabel SNDSTRM_overheadtap
    /* DA854 800EA054 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DA858 800EA058 1000B0AF */  sw         $s0, 0x10($sp)
    /* DA85C 800EA05C 40800400 */  sll        $s0, $a0, 1
    /* DA860 800EA060 21800402 */  addu       $s0, $s0, $a0
    /* DA864 800EA064 80801000 */  sll        $s0, $s0, 2
    /* DA868 800EA068 23800402 */  subu       $s0, $s0, $a0
    /* DA86C 800EA06C 80801000 */  sll        $s0, $s0, 2
    /* DA870 800EA070 60001026 */  addiu      $s0, $s0, 0x60
    /* DA874 800EA074 1400BFAF */  sw         $ra, 0x14($sp)
    /* DA878 800EA078 340A040C */  jal        SNDPKTPLAY_overhead
    /* DA87C 800EA07C 2120A000 */   addu      $a0, $a1, $zero
    /* DA880 800EA080 21100202 */  addu       $v0, $s0, $v0
    /* DA884 800EA084 1400BF8F */  lw         $ra, 0x14($sp)
    /* DA888 800EA088 1000B08F */  lw         $s0, 0x10($sp)
    /* DA88C 800EA08C 0800E003 */  jr         $ra
    /* DA890 800EA090 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SNDSTRM_overheadtap
