.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSTRM_vol, 0x60

glabel SNDSTRM_vol
    /* DA8D8 800EA0D8 1480023C */  lui        $v0, %hi(D_8014789C)
    /* DA8DC 800EA0DC 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* DA8E0 800EA0E0 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DA8E4 800EA0E4 1000B0AF */  sw         $s0, 0x10($sp)
    /* DA8E8 800EA0E8 2180A000 */  addu       $s0, $a1, $zero
    /* DA8EC 800EA0EC 03004014 */  bnez       $v0, .L800EA0FC
    /* DA8F0 800EA0F0 1400BFAF */   sw        $ra, 0x14($sp)
    /* DA8F4 800EA0F4 4AA80308 */  j          .L800EA128
    /* DA8F8 800EA0F8 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800EA0FC:
    /* DA8FC 800EA0FC 12A3030C */  jal        iSNDstreamgetstreamptr
    /* DA900 800EA100 00000000 */   nop
    /* DA904 800EA104 07004010 */  beqz       $v0, .L800EA124
    /* DA908 800EA108 00000000 */   nop
    /* DA90C 800EA10C 0800448C */  lw         $a0, 0x8($v0)
    /* DA910 800EA110 21280002 */  addu       $a1, $s0, $zero
    /* DA914 800EA114 A59A030C */  jal        SNDvol
    /* DA918 800EA118 540050A0 */   sb        $s0, 0x54($v0)
    /* DA91C 800EA11C 4AA80308 */  j          .L800EA128
    /* DA920 800EA120 21100000 */   addu      $v0, $zero, $zero
  .L800EA124:
    /* DA924 800EA124 F8FF0224 */  addiu      $v0, $zero, -0x8
  .L800EA128:
    /* DA928 800EA128 1400BF8F */  lw         $ra, 0x14($sp)
    /* DA92C 800EA12C 1000B08F */  lw         $s0, 0x10($sp)
    /* DA930 800EA130 0800E003 */  jr         $ra
    /* DA934 800EA134 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SNDSTRM_vol
