.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDlibatodlrv, 0x94

glabel iSNDlibatodlrv
    /* FD094 8010C894 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* FD098 8010C898 1400B1AF */  sw         $s1, 0x14($sp)
    /* FD09C 8010C89C 2188A000 */  addu       $s1, $a1, $zero
    /* FD0A0 8010C8A0 1000B0AF */  sw         $s0, 0x10($sp)
    /* FD0A4 8010C8A4 2180C000 */  addu       $s0, $a2, $zero
    /* FD0A8 8010C8A8 1800B2AF */  sw         $s2, 0x18($sp)
    /* FD0AC 8010C8AC 2190E000 */  addu       $s2, $a3, $zero
    /* FD0B0 8010C8B0 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* FD0B4 8010C8B4 1033040C */  jal        iSNDsin
    /* FD0B8 8010C8B8 83210400 */   sra       $a0, $a0, 6
    /* FD0BC 8010C8BC 21184000 */  addu       $v1, $v0, $zero
    /* FD0C0 8010C8C0 0100043C */  lui        $a0, (0x10000 >> 16)
    /* FD0C4 8010C8C4 23108300 */  subu       $v0, $a0, $v1
    /* FD0C8 8010C8C8 18002202 */  mult       $s1, $v0
    /* FD0CC 8010C8CC 12400000 */  mflo       $t0
    /* FD0D0 8010C8D0 02140800 */  srl        $v0, $t0, 16
    /* FD0D4 8010C8D4 000002AE */  sw         $v0, 0x0($s0)
    /* FD0D8 8010C8D8 80004228 */  slti       $v0, $v0, 0x80
    /* FD0DC 8010C8DC 04004014 */  bnez       $v0, .L8010C8F0
    /* FD0E0 8010C8E0 21106400 */   addu      $v0, $v1, $a0
    /* FD0E4 8010C8E4 7F000224 */  addiu      $v0, $zero, 0x7F
    /* FD0E8 8010C8E8 000002AE */  sw         $v0, 0x0($s0)
    /* FD0EC 8010C8EC 21106400 */  addu       $v0, $v1, $a0
  .L8010C8F0:
    /* FD0F0 8010C8F0 18002202 */  mult       $s1, $v0
    /* FD0F4 8010C8F4 12400000 */  mflo       $t0
    /* FD0F8 8010C8F8 02140800 */  srl        $v0, $t0, 16
    /* FD0FC 8010C8FC 000042AE */  sw         $v0, 0x0($s2)
    /* FD100 8010C900 80004228 */  slti       $v0, $v0, 0x80
    /* FD104 8010C904 02004014 */  bnez       $v0, .L8010C910
    /* FD108 8010C908 7F000224 */   addiu     $v0, $zero, 0x7F
    /* FD10C 8010C90C 000042AE */  sw         $v0, 0x0($s2)
  .L8010C910:
    /* FD110 8010C910 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* FD114 8010C914 1800B28F */  lw         $s2, 0x18($sp)
    /* FD118 8010C918 1400B18F */  lw         $s1, 0x14($sp)
    /* FD11C 8010C91C 1000B08F */  lw         $s0, 0x10($sp)
    /* FD120 8010C920 0800E003 */  jr         $ra
    /* FD124 8010C924 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iSNDlibatodlrv
