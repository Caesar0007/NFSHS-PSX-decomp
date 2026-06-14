.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSTRM_setgreedystate, 0x5C

glabel SNDSTRM_setgreedystate
    /* DA58C 800E9D8C 1480023C */  lui        $v0, %hi(D_8014789C)
    /* DA590 800E9D90 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* DA594 800E9D94 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DA598 800E9D98 1000B0AF */  sw         $s0, 0x10($sp)
    /* DA59C 800E9D9C 2180A000 */  addu       $s0, $a1, $zero
    /* DA5A0 800E9DA0 03004014 */  bnez       $v0, .L800E9DB0
    /* DA5A4 800E9DA4 1400BFAF */   sw        $ra, 0x14($sp)
    /* DA5A8 800E9DA8 76A70308 */  j          .L800E9DD8
    /* DA5AC 800E9DAC F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E9DB0:
    /* DA5B0 800E9DB0 12A3030C */  jal        iSNDstreamgetstreamptr
    /* DA5B4 800E9DB4 00000000 */   nop
    /* DA5B8 800E9DB8 06004010 */  beqz       $v0, .L800E9DD4
    /* DA5BC 800E9DBC 00000000 */   nop
    /* DA5C0 800E9DC0 0400448C */  lw         $a0, 0x4($v0)
    /* DA5C4 800E9DC4 ADF4030C */  jal        STREAM_setgreedystate
    /* DA5C8 800E9DC8 21280002 */   addu      $a1, $s0, $zero
    /* DA5CC 800E9DCC 76A70308 */  j          .L800E9DD8
    /* DA5D0 800E9DD0 21100000 */   addu      $v0, $zero, $zero
  .L800E9DD4:
    /* DA5D4 800E9DD4 F8FF0224 */  addiu      $v0, $zero, -0x8
  .L800E9DD8:
    /* DA5D8 800E9DD8 1400BF8F */  lw         $ra, 0x14($sp)
    /* DA5DC 800E9DDC 1000B08F */  lw         $s0, 0x10($sp)
    /* DA5E0 800E9DE0 0800E003 */  jr         $ra
    /* DA5E4 800E9DE4 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SNDSTRM_setgreedystate
