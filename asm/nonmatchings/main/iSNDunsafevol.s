.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDunsafevol, 0xC4

glabel iSNDunsafevol
    /* D71D0 800E69D0 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* D71D4 800E69D4 1800B0AF */  sw         $s0, 0x18($sp)
    /* D71D8 800E69D8 2180A000 */  addu       $s0, $a1, $zero
    /* D71DC 800E69DC 2800BFAF */  sw         $ra, 0x28($sp)
    /* D71E0 800E69E0 2400B3AF */  sw         $s3, 0x24($sp)
    /* D71E4 800E69E4 2000B2AF */  sw         $s2, 0x20($sp)
    /* D71E8 800E69E8 71FB030C */  jal        iSNDgetchan
    /* D71EC 800E69EC 1C00B1AF */   sw        $s1, 0x1C($sp)
    /* D71F0 800E69F0 21904000 */  addu       $s2, $v0, $zero
    /* D71F4 800E69F4 1F004006 */  bltz       $s2, .L800E6A74
    /* D71F8 800E69F8 FFFF0224 */   addiu     $v0, $zero, -0x1
    /* D71FC 800E69FC 1000A2AF */  sw         $v0, 0x10($sp)
    /* D7200 800E6A00 1480023C */  lui        $v0, %hi(sndgs)
    /* D7204 800E6A04 60785324 */  addiu      $s3, $v0, %lo(sndgs)
    /* D7208 800E6A08 008C1000 */  sll        $s1, $s0, 16
    /* D720C 800E6A0C 21204002 */  addu       $a0, $s2, $zero
  .L800E6A10:
    /* D7210 800E6A10 D3FB030C */  jal        iSNDpatchkey
    /* D7214 800E6A14 1000A527 */   addiu     $a1, $sp, 0x10
    /* D7218 800E6A18 17004010 */  beqz       $v0, .L800E6A78
    /* D721C 800E6A1C 21104002 */   addu      $v0, $s2, $zero
    /* D7220 800E6A20 1000A48F */  lw         $a0, 0x10($sp)
    /* D7224 800E6A24 9400638E */  lw         $v1, 0x94($s3)
    /* D7228 800E6A28 40100400 */  sll        $v0, $a0, 1
    /* D722C 800E6A2C 21104400 */  addu       $v0, $v0, $a0
    /* D7230 800E6A30 C0100200 */  sll        $v0, $v0, 3
    /* D7234 800E6A34 21104400 */  addu       $v0, $v0, $a0
    /* D7238 800E6A38 80100200 */  sll        $v0, $v0, 2
    /* D723C 800E6A3C 21806200 */  addu       $s0, $v1, $v0
    /* D7240 800E6A40 1C00028E */  lw         $v0, 0x1C($s0)
    /* D7244 800E6A44 00000000 */  nop
    /* D7248 800E6A48 0B005110 */  beq        $v0, $s1, .L800E6A78
    /* D724C 800E6A4C 21100000 */   addu      $v0, $zero, $zero
    /* D7250 800E6A50 1C0011AE */  sw         $s1, 0x1C($s0)
    /* D7254 800E6A54 14FC030C */  jal        iSNDcalcvol
    /* D7258 800E6A58 140000AE */   sw        $zero, 0x14($s0)
    /* D725C 800E6A5C 1000A48F */  lw         $a0, 0x10($sp)
    /* D7260 800E6A60 2D000582 */  lb         $a1, 0x2D($s0)
    /* D7264 800E6A64 3E00040C */  jal        iSNDvol
    /* D7268 800E6A68 00000000 */   nop
    /* D726C 800E6A6C 849A0308 */  j          .L800E6A10
    /* D7270 800E6A70 21204002 */   addu      $a0, $s2, $zero
  .L800E6A74:
    /* D7274 800E6A74 21104002 */  addu       $v0, $s2, $zero
  .L800E6A78:
    /* D7278 800E6A78 2800BF8F */  lw         $ra, 0x28($sp)
    /* D727C 800E6A7C 2400B38F */  lw         $s3, 0x24($sp)
    /* D7280 800E6A80 2000B28F */  lw         $s2, 0x20($sp)
    /* D7284 800E6A84 1C00B18F */  lw         $s1, 0x1C($sp)
    /* D7288 800E6A88 1800B08F */  lw         $s0, 0x18($sp)
    /* D728C 800E6A8C 0800E003 */  jr         $ra
    /* D7290 800E6A90 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel iSNDunsafevol
