.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDatolrv, 0x58

glabel iSNDatolrv
    /* FB8A8 8010B0A8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* FB8AC 8010B0AC 1000B0AF */  sw         $s0, 0x10($sp)
    /* FB8B0 8010B0B0 2180C000 */  addu       $s0, $a2, $zero
    /* FB8B4 8010B0B4 1400B1AF */  sw         $s1, 0x14($sp)
    /* FB8B8 8010B0B8 1800BFAF */  sw         $ra, 0x18($sp)
    /* FB8BC 8010B0BC 2532040C */  jal        iSNDlibatodlrv
    /* FB8C0 8010B0C0 2188E000 */   addu      $s1, $a3, $zero
    /* FB8C4 8010B0C4 0000028E */  lw         $v0, 0x0($s0)
    /* FB8C8 8010B0C8 00000000 */  nop
    /* FB8CC 8010B0CC 02004104 */  bgez       $v0, .L8010B0D8
    /* FB8D0 8010B0D0 23100200 */   negu      $v0, $v0
    /* FB8D4 8010B0D4 000002AE */  sw         $v0, 0x0($s0)
  .L8010B0D8:
    /* FB8D8 8010B0D8 0000228E */  lw         $v0, 0x0($s1)
    /* FB8DC 8010B0DC 00000000 */  nop
    /* FB8E0 8010B0E0 02004104 */  bgez       $v0, .L8010B0EC
    /* FB8E4 8010B0E4 23100200 */   negu      $v0, $v0
    /* FB8E8 8010B0E8 000022AE */  sw         $v0, 0x0($s1)
  .L8010B0EC:
    /* FB8EC 8010B0EC 1800BF8F */  lw         $ra, 0x18($sp)
    /* FB8F0 8010B0F0 1400B18F */  lw         $s1, 0x14($sp)
    /* FB8F4 8010B0F4 1000B08F */  lw         $s0, 0x10($sp)
    /* FB8F8 8010B0F8 0800E003 */  jr         $ra
    /* FB8FC 8010B0FC 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel iSNDatolrv
