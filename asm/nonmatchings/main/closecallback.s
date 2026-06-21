.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching closecallback, 0x58

glabel closecallback
    /* ED050 800FC850 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* ED054 800FC854 1000B0AF */  sw         $s0, 0x10($sp)
    /* ED058 800FC858 2180C000 */  addu       $s0, $a2, $zero
    /* ED05C 800FC85C 1400BFAF */  sw         $ra, 0x14($sp)
    /* ED060 800FC860 A400048E */  lw         $a0, 0xA4($s0)
    /* ED064 800FC864 ACB0030C */  jal        FILE_completeop
    /* ED068 800FC868 00000000 */   nop
    /* ED06C 800FC86C 5C000426 */  addiu      $a0, $s0, 0x5C
    /* ED070 800FC870 01000524 */  addiu      $a1, $zero, 0x1
    /* ED074 800FC874 3000068E */  lw         $a2, 0x30($s0)
    /* ED078 800FC878 DBB0030C */  jal        FILE_open
    /* ED07C 800FC87C 21380002 */   addu      $a3, $s0, $zero
    /* ED080 800FC880 05004010 */  beqz       $v0, .L800FC898
    /* ED084 800FC884 A40002AE */   sw        $v0, 0xA4($s0)
    /* ED088 800FC888 21204000 */  addu       $a0, $v0, $zero
    /* ED08C 800FC88C 1080053C */  lui        $a1, %hi(opencallback)
    /* ED090 800FC890 93AF030C */  jal        FILE_callbackop
    /* ED094 800FC894 10C8A524 */   addiu     $a1, $a1, %lo(opencallback)
  .L800FC898:
    /* ED098 800FC898 1400BF8F */  lw         $ra, 0x14($sp)
    /* ED09C 800FC89C 1000B08F */  lw         $s0, 0x10($sp)
    /* ED0A0 800FC8A0 0800E003 */  jr         $ra
    /* ED0A4 800FC8A4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel closecallback
