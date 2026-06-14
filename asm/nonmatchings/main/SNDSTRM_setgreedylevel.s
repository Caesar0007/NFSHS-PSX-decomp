.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSTRM_setgreedylevel, 0x5C

glabel SNDSTRM_setgreedylevel
    /* DA530 800E9D30 1480023C */  lui        $v0, %hi(D_8014789C)
    /* DA534 800E9D34 9C784280 */  lb         $v0, %lo(D_8014789C)($v0)
    /* DA538 800E9D38 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* DA53C 800E9D3C 1000B0AF */  sw         $s0, 0x10($sp)
    /* DA540 800E9D40 2180A000 */  addu       $s0, $a1, $zero
    /* DA544 800E9D44 03004014 */  bnez       $v0, .L800E9D54
    /* DA548 800E9D48 1400BFAF */   sw        $ra, 0x14($sp)
    /* DA54C 800E9D4C 5FA70308 */  j          .L800E9D7C
    /* DA550 800E9D50 F6FF0224 */   addiu     $v0, $zero, -0xA
  .L800E9D54:
    /* DA554 800E9D54 12A3030C */  jal        iSNDstreamgetstreamptr
    /* DA558 800E9D58 00000000 */   nop
    /* DA55C 800E9D5C 06004010 */  beqz       $v0, .L800E9D78
    /* DA560 800E9D60 00000000 */   nop
    /* DA564 800E9D64 0400448C */  lw         $a0, 0x4($v0)
    /* DA568 800E9D68 92F4030C */  jal        STREAM_setgreedylevel
    /* DA56C 800E9D6C 21280002 */   addu      $a1, $s0, $zero
    /* DA570 800E9D70 5FA70308 */  j          .L800E9D7C
    /* DA574 800E9D74 21100000 */   addu      $v0, $zero, $zero
  .L800E9D78:
    /* DA578 800E9D78 F8FF0224 */  addiu      $v0, $zero, -0x8
  .L800E9D7C:
    /* DA57C 800E9D7C 1400BF8F */  lw         $ra, 0x14($sp)
    /* DA580 800E9D80 1000B08F */  lw         $s0, 0x10($sp)
    /* DA584 800E9D84 0800E003 */  jr         $ra
    /* DA588 800E9D88 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SNDSTRM_setgreedylevel
