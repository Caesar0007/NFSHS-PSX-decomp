.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetPinkSlipsCar__11tCarManagersR8tCarInfos, 0xDC

glabel GetPinkSlipsCar__11tCarManagersR8tCarInfos
    /* 7858 80017058 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 785C 8001705C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 7860 80017060 21888000 */  addu       $s1, $a0, $zero
    /* 7864 80017064 2000B4AF */  sw         $s4, 0x20($sp)
    /* 7868 80017068 21A0A000 */  addu       $s4, $a1, $zero
    /* 786C 8001706C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 7870 80017070 1000B0AF */  sw         $s0, 0x10($sp)
    /* 7874 80017074 00841400 */  sll        $s0, $s4, 16
    /* 7878 80017078 03841000 */  sra        $s0, $s0, 16
    /* 787C 8001707C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 7880 80017080 009C0700 */  sll        $s3, $a3, 16
    /* 7884 80017084 2400BFAF */  sw         $ra, 0x24($sp)
    /* 7888 80017088 0000228E */  lw         $v0, 0x0($s1)
    /* 788C 8001708C 439A1300 */  sra        $s3, $s3, 9
    /* 7890 80017090 23100202 */  subu       $v0, $s0, $v0
    /* 7894 80017094 80100200 */  sll        $v0, $v0, 2
    /* 7898 80017098 21105300 */  addu       $v0, $v0, $s3
    /* 789C 8001709C 21102202 */  addu       $v0, $s1, $v0
    /* 78A0 800170A0 08014580 */  lb         $a1, 0x108($v0)
    /* 78A4 800170A4 9358000C */  jal        GetCarFromID__11tCarManagers
    /* 78A8 800170A8 2190C000 */   addu      $s2, $a2, $zero
    /* 78AC 800170AC 21204000 */  addu       $a0, $v0, $zero
    /* 78B0 800170B0 21284002 */  addu       $a1, $s2, $zero
    /* 78B4 800170B4 B798030C */  jal        blockmove
    /* 78B8 800170B8 CC000624 */   addiu     $a2, $zero, 0xCC
    /* 78BC 800170BC 01000224 */  addiu      $v0, $zero, 0x1
    /* 78C0 800170C0 070042A2 */  sb         $v0, 0x7($s2)
    /* 78C4 800170C4 C60042A2 */  sb         $v0, 0xC6($s2)
    /* 78C8 800170C8 0000228E */  lw         $v0, 0x0($s1)
    /* 78CC 800170CC 00000000 */  nop
    /* 78D0 800170D0 23100202 */  subu       $v0, $s0, $v0
    /* 78D4 800170D4 80100200 */  sll        $v0, $v0, 2
    /* 78D8 800170D8 21105300 */  addu       $v0, $v0, $s3
    /* 78DC 800170DC 21102202 */  addu       $v0, $s1, $v0
    /* 78E0 800170E0 09014290 */  lbu        $v0, 0x109($v0)
    /* 78E4 800170E4 00000000 */  nop
    /* 78E8 800170E8 C40042A2 */  sb         $v0, 0xC4($s2)
    /* 78EC 800170EC 0000228E */  lw         $v0, 0x0($s1)
    /* 78F0 800170F0 00000000 */  nop
    /* 78F4 800170F4 23800202 */  subu       $s0, $s0, $v0
    /* 78F8 800170F8 80801000 */  sll        $s0, $s0, 2
    /* 78FC 800170FC 21801302 */  addu       $s0, $s0, $s3
    /* 7900 80017100 21883002 */  addu       $s1, $s1, $s0
    /* 7904 80017104 0A012292 */  lbu        $v0, 0x10A($s1)
    /* 7908 80017108 C70040A2 */  sb         $zero, 0xC7($s2)
    /* 790C 8001710C C80054A2 */  sb         $s4, 0xC8($s2)
    /* 7910 80017110 C50042A2 */  sb         $v0, 0xC5($s2)
    /* 7914 80017114 2400BF8F */  lw         $ra, 0x24($sp)
    /* 7918 80017118 2000B48F */  lw         $s4, 0x20($sp)
    /* 791C 8001711C 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 7920 80017120 1800B28F */  lw         $s2, 0x18($sp)
    /* 7924 80017124 1400B18F */  lw         $s1, 0x14($sp)
    /* 7928 80017128 1000B08F */  lw         $s0, 0x10($sp)
    /* 792C 8001712C 0800E003 */  jr         $ra
    /* 7930 80017130 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel GetPinkSlipsCar__11tCarManagersR8tCarInfos
