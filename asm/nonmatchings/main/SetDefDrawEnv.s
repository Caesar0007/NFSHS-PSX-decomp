.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetDefDrawEnv, 0xB4

glabel SetDefDrawEnv
    /* E2A2C 800F222C D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* E2A30 800F2230 1800B2AF */  sw         $s2, 0x18($sp)
    /* E2A34 800F2234 3800B28F */  lw         $s2, 0x38($sp)
    /* E2A38 800F2238 1400B1AF */  sw         $s1, 0x14($sp)
    /* E2A3C 800F223C 21888000 */  addu       $s1, $a0, $zero
    /* E2A40 800F2240 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* E2A44 800F2244 2198A000 */  addu       $s3, $a1, $zero
    /* E2A48 800F2248 2000B4AF */  sw         $s4, 0x20($sp)
    /* E2A4C 800F224C 21A0C000 */  addu       $s4, $a2, $zero
    /* E2A50 800F2250 1000B0AF */  sw         $s0, 0x10($sp)
    /* E2A54 800F2254 2400BFAF */  sw         $ra, 0x24($sp)
    /* E2A58 800F2258 E1C5030C */  jal        GetVideoMode
    /* E2A5C 800F225C 2180E000 */   addu      $s0, $a3, $zero
    /* E2A60 800F2260 01000324 */  addiu      $v1, $zero, 0x1
    /* E2A64 800F2264 000033A6 */  sh         $s3, 0x0($s1)
    /* E2A68 800F2268 020034A6 */  sh         $s4, 0x2($s1)
    /* E2A6C 800F226C 040030A6 */  sh         $s0, 0x4($s1)
    /* E2A70 800F2270 0C0020A6 */  sh         $zero, 0xC($s1)
    /* E2A74 800F2274 0E0020A6 */  sh         $zero, 0xE($s1)
    /* E2A78 800F2278 100020A6 */  sh         $zero, 0x10($s1)
    /* E2A7C 800F227C 120020A6 */  sh         $zero, 0x12($s1)
    /* E2A80 800F2280 190020A2 */  sb         $zero, 0x19($s1)
    /* E2A84 800F2284 1A0020A2 */  sb         $zero, 0x1A($s1)
    /* E2A88 800F2288 1B0020A2 */  sb         $zero, 0x1B($s1)
    /* E2A8C 800F228C 160023A2 */  sb         $v1, 0x16($s1)
    /* E2A90 800F2290 03004010 */  beqz       $v0, .L800F22A0
    /* E2A94 800F2294 060032A6 */   sh        $s2, 0x6($s1)
    /* E2A98 800F2298 A9C80308 */  j          .L800F22A4
    /* E2A9C 800F229C 2101422A */   slti      $v0, $s2, 0x121
  .L800F22A0:
    /* E2AA0 800F22A0 0101422A */  slti       $v0, $s2, 0x101
  .L800F22A4:
    /* E2AA4 800F22A4 170022A2 */  sb         $v0, 0x17($s1)
    /* E2AA8 800F22A8 21102002 */  addu       $v0, $s1, $zero
    /* E2AAC 800F22AC 0A000324 */  addiu      $v1, $zero, 0xA
    /* E2AB0 800F22B0 080053A4 */  sh         $s3, 0x8($v0)
    /* E2AB4 800F22B4 0A0054A4 */  sh         $s4, 0xA($v0)
    /* E2AB8 800F22B8 140043A4 */  sh         $v1, 0x14($v0)
    /* E2ABC 800F22BC 180040A0 */  sb         $zero, 0x18($v0)
    /* E2AC0 800F22C0 2400BF8F */  lw         $ra, 0x24($sp)
    /* E2AC4 800F22C4 2000B48F */  lw         $s4, 0x20($sp)
    /* E2AC8 800F22C8 1C00B38F */  lw         $s3, 0x1C($sp)
    /* E2ACC 800F22CC 1800B28F */  lw         $s2, 0x18($sp)
    /* E2AD0 800F22D0 1400B18F */  lw         $s1, 0x14($sp)
    /* E2AD4 800F22D4 1000B08F */  lw         $s0, 0x10($sp)
    /* E2AD8 800F22D8 0800E003 */  jr         $ra
    /* E2ADC 800F22DC 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel SetDefDrawEnv
