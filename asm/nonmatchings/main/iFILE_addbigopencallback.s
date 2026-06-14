.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iFILE_addbigopencallback, 0xB8

glabel iFILE_addbigopencallback
    /* DCFA0 800EC7A0 C8FFBD27 */  addiu      $sp, $sp, -0x38
    /* DCFA4 800EC7A4 2000B0AF */  sw         $s0, 0x20($sp)
    /* DCFA8 800EC7A8 2180A000 */  addu       $s0, $a1, $zero
    /* DCFAC 800EC7AC 2400B1AF */  sw         $s1, 0x24($sp)
    /* DCFB0 800EC7B0 1480053C */  lui        $a1, %hi(D_8013EAA0)
    /* DCFB4 800EC7B4 021E0400 */  srl        $v1, $a0, 24
    /* DCFB8 800EC7B8 40100300 */  sll        $v0, $v1, 1
    /* DCFBC 800EC7BC 21104300 */  addu       $v0, $v0, $v1
    /* DCFC0 800EC7C0 A0EAA38C */  lw         $v1, %lo(D_8013EAA0)($a1)
    /* DCFC4 800EC7C4 00110200 */  sll        $v0, $v0, 4
    /* DCFC8 800EC7C8 3000BFAF */  sw         $ra, 0x30($sp)
    /* DCFCC 800EC7CC 2C00B3AF */  sw         $s3, 0x2C($sp)
    /* DCFD0 800EC7D0 2800B2AF */  sw         $s2, 0x28($sp)
    /* DCFD4 800EC7D4 21104300 */  addu       $v0, $v0, $v1
    /* DCFD8 800EC7D8 1000538C */  lw         $s3, 0x10($v0)
    /* DCFDC 800EC7DC ACB0030C */  jal        FILE_completeop
    /* DCFE0 800EC7E0 2188C000 */   addu      $s1, $a2, $zero
    /* DCFE4 800EC7E4 21204000 */  addu       $a0, $v0, $zero
    /* DCFE8 800EC7E8 01000224 */  addiu      $v0, $zero, 0x1
    /* DCFEC 800EC7EC 09000212 */  beq        $s0, $v0, .L800EC814
    /* DCFF0 800EC7F0 21902002 */   addu      $s2, $s1, $zero
    /* DCFF4 800EC7F4 0800238E */  lw         $v1, 0x8($s1)
    /* DCFF8 800EC7F8 04000224 */  addiu      $v0, $zero, 0x4
    /* DCFFC 800EC7FC 0C0062AC */  sw         $v0, 0xC($v1)
    /* DD000 800EC800 0800248E */  lw         $a0, 0x8($s1)
    /* DD004 800EC804 E6B2030C */  jal        func_800ECB98
    /* DD008 800EC808 00000000 */   nop
    /* DD00C 800EC80C 0FB20308 */  j          .L800EC83C
    /* DD010 800EC810 00000000 */   nop
  .L800EC814:
    /* DD014 800EC814 21280000 */  addu       $a1, $zero, $zero
    /* DD018 800EC818 1000B3AF */  sw         $s3, 0x10($sp)
    /* DD01C 800EC81C 1400B2AF */  sw         $s2, 0x14($sp)
    /* DD020 800EC820 0000468E */  lw         $a2, 0x0($s2)
    /* DD024 800EC824 3BB1030C */  jal        FILE_read
    /* DD028 800EC828 00080724 */   addiu     $a3, $zero, 0x800
    /* DD02C 800EC82C 21204000 */  addu       $a0, $v0, $zero
    /* DD030 800EC830 0F80053C */  lui        $a1, %hi(iFILE_addbigreadcallback)
    /* DD034 800EC834 93AF030C */  jal        FILE_callbackop
    /* DD038 800EC838 60C6A524 */   addiu     $a1, $a1, %lo(iFILE_addbigreadcallback)
  .L800EC83C:
    /* DD03C 800EC83C 3000BF8F */  lw         $ra, 0x30($sp)
    /* DD040 800EC840 2C00B38F */  lw         $s3, 0x2C($sp)
    /* DD044 800EC844 2800B28F */  lw         $s2, 0x28($sp)
    /* DD048 800EC848 2400B18F */  lw         $s1, 0x24($sp)
    /* DD04C 800EC84C 2000B08F */  lw         $s0, 0x20($sp)
    /* DD050 800EC850 0800E003 */  jr         $ra
    /* DD054 800EC854 3800BD27 */   addiu     $sp, $sp, 0x38
endlabel iFILE_addbigopencallback
