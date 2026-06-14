.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SNDSYS_restore, 0xE4

glabel SNDSYS_restore
    /* E284C 800F204C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* E2850 800F2050 1480023C */  lui        $v0, %hi(sndgs)
    /* E2854 800F2054 1000B0AF */  sw         $s0, 0x10($sp)
    /* E2858 800F2058 60785024 */  addiu      $s0, $v0, %lo(sndgs)
    /* E285C 800F205C 1400BFAF */  sw         $ra, 0x14($sp)
    /* E2860 800F2060 3C000282 */  lb         $v0, 0x3C($s0)
    /* E2864 800F2064 00000000 */  nop
    /* E2868 800F2068 2D004010 */  beqz       $v0, .L800F2120
    /* E286C 800F206C F6FF0224 */   addiu     $v0, $zero, -0xA
    /* E2870 800F2070 8C00028E */  lw         $v0, 0x8C($s0)
    /* E2874 800F2074 00000000 */  nop
    /* E2878 800F2078 03004010 */  beqz       $v0, .L800F2088
    /* E287C 800F207C 00000000 */   nop
    /* E2880 800F2080 09F84000 */  jalr       $v0
    /* E2884 800F2084 00000000 */   nop
  .L800F2088:
    /* E2888 800F2088 9000028E */  lw         $v0, 0x90($s0)
    /* E288C 800F208C 00000000 */  nop
    /* E2890 800F2090 03004010 */  beqz       $v0, .L800F20A0
    /* E2894 800F2094 00000000 */   nop
    /* E2898 800F2098 09F84000 */  jalr       $v0
    /* E289C 800F209C 00000000 */   nop
  .L800F20A0:
    /* E28A0 800F20A0 8400028E */  lw         $v0, 0x84($s0)
    /* E28A4 800F20A4 00000000 */  nop
    /* E28A8 800F20A8 03004010 */  beqz       $v0, .L800F20B8
    /* E28AC 800F20AC 00000000 */   nop
    /* E28B0 800F20B0 09F84000 */  jalr       $v0
    /* E28B4 800F20B4 00000000 */   nop
  .L800F20B8:
    /* E28B8 800F20B8 8800028E */  lw         $v0, 0x88($s0)
    /* E28BC 800F20BC 00000000 */  nop
    /* E28C0 800F20C0 03004010 */  beqz       $v0, .L800F20D0
    /* E28C4 800F20C4 00000000 */   nop
    /* E28C8 800F20C8 09F84000 */  jalr       $v0
    /* E28CC 800F20CC 00000000 */   nop
  .L800F20D0:
    /* E28D0 800F20D0 8000028E */  lw         $v0, 0x80($s0)
    /* E28D4 800F20D4 00000000 */  nop
    /* E28D8 800F20D8 03004010 */  beqz       $v0, .L800F20E8
    /* E28DC 800F20DC 00000000 */   nop
    /* E28E0 800F20E0 09F84000 */  jalr       $v0
    /* E28E4 800F20E4 00000000 */   nop
  .L800F20E8:
    /* E28E8 800F20E8 6AA0030C */  jal        SNDstopall
    /* E28EC 800F20EC 00000000 */   nop
    /* E28F0 800F20F0 7C00028E */  lw         $v0, 0x7C($s0)
    /* E28F4 800F20F4 00000000 */  nop
    /* E28F8 800F20F8 03004010 */  beqz       $v0, .L800F2108
    /* E28FC 800F20FC 00000000 */   nop
    /* E2900 800F2100 09F84000 */  jalr       $v0
    /* E2904 800F2104 FFFF0424 */   addiu     $a0, $zero, -0x1
  .L800F2108:
    /* E2908 800F2108 68FE030C */  jal        iSNDrestore
    /* E290C 800F210C 00000000 */   nop
    /* E2910 800F2110 7D00040C */  jal        SNDI_mutexfree
    /* E2914 800F2114 3C0000A2 */   sb        $zero, 0x3C($s0)
    /* E2918 800F2118 7D18040C */  jal        iSNDmemrestore
    /* E291C 800F211C 00000000 */   nop
  .L800F2120:
    /* E2920 800F2120 1400BF8F */  lw         $ra, 0x14($sp)
    /* E2924 800F2124 1000B08F */  lw         $s0, 0x10($sp)
    /* E2928 800F2128 0800E003 */  jr         $ra
    /* E292C 800F212C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel SNDSYS_restore
