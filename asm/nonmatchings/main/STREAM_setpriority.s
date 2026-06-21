.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching STREAM_setpriority, 0x50

glabel STREAM_setpriority
    /* ED9F8 800FD1F8 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* ED9FC 800FD1FC 1800B0AF */  sw         $s0, 0x18($sp)
    /* EDA00 800FD200 2180A000 */  addu       $s0, $a1, $zero
    /* EDA04 800FD204 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* EDA08 800FD208 2188C000 */  addu       $s1, $a2, $zero
    /* EDA0C 800FD20C 1000A527 */  addiu      $a1, $sp, 0x10
    /* EDA10 800FD210 2000BFAF */  sw         $ra, 0x20($sp)
    /* EDA14 800FD214 BEF0030C */  jal        validatehandle
    /* EDA18 800FD218 1400A627 */   addiu     $a2, $sp, 0x14
    /* EDA1C 800FD21C 05004014 */  bnez       $v0, .L800FD234
    /* EDA20 800FD220 00000000 */   nop
    /* EDA24 800FD224 1000A28F */  lw         $v0, 0x10($sp)
    /* EDA28 800FD228 00000000 */  nop
    /* EDA2C 800FD22C 2C0050AC */  sw         $s0, 0x2C($v0)
    /* EDA30 800FD230 300051AC */  sw         $s1, 0x30($v0)
  .L800FD234:
    /* EDA34 800FD234 2000BF8F */  lw         $ra, 0x20($sp)
    /* EDA38 800FD238 1C00B18F */  lw         $s1, 0x1C($sp)
    /* EDA3C 800FD23C 1800B08F */  lw         $s0, 0x18($sp)
    /* EDA40 800FD240 0800E003 */  jr         $ra
    /* EDA44 800FD244 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel STREAM_setpriority
