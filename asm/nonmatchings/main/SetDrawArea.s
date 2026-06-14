.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetDrawArea, 0x80

glabel SetDrawArea
    /* DEB14 800EE314 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DEB18 800EE318 1400B1AF */  sw         $s1, 0x14($sp)
    /* DEB1C 800EE31C 21888000 */  addu       $s1, $a0, $zero
    /* DEB20 800EE320 1000B0AF */  sw         $s0, 0x10($sp)
    /* DEB24 800EE324 2180A000 */  addu       $s0, $a1, $zero
    /* DEB28 800EE328 02000224 */  addiu      $v0, $zero, 0x2
    /* DEB2C 800EE32C 1800BFAF */  sw         $ra, 0x18($sp)
    /* DEB30 800EE330 030022A2 */  sb         $v0, 0x3($s1)
    /* DEB34 800EE334 00000486 */  lh         $a0, 0x0($s0)
    /* DEB38 800EE338 02000586 */  lh         $a1, 0x2($s0)
    /* DEB3C 800EE33C 26BA030C */  jal        func_800EE898
    /* DEB40 800EE340 00000000 */   nop
    /* DEB44 800EE344 040022AE */  sw         $v0, 0x4($s1)
    /* DEB48 800EE348 00000496 */  lhu        $a0, 0x0($s0)
    /* DEB4C 800EE34C 04000296 */  lhu        $v0, 0x4($s0)
    /* DEB50 800EE350 02000596 */  lhu        $a1, 0x2($s0)
    /* DEB54 800EE354 21208200 */  addu       $a0, $a0, $v0
    /* DEB58 800EE358 FFFF8424 */  addiu      $a0, $a0, -0x1
    /* DEB5C 800EE35C 00240400 */  sll        $a0, $a0, 16
    /* DEB60 800EE360 06000296 */  lhu        $v0, 0x6($s0)
    /* DEB64 800EE364 03240400 */  sra        $a0, $a0, 16
    /* DEB68 800EE368 2128A200 */  addu       $a1, $a1, $v0
    /* DEB6C 800EE36C FFFFA524 */  addiu      $a1, $a1, -0x1
    /* DEB70 800EE370 002C0500 */  sll        $a1, $a1, 16
    /* DEB74 800EE374 4CBA030C */  jal        func_800EE930
    /* DEB78 800EE378 032C0500 */   sra       $a1, $a1, 16
    /* DEB7C 800EE37C 080022AE */  sw         $v0, 0x8($s1)
    /* DEB80 800EE380 1800BF8F */  lw         $ra, 0x18($sp)
    /* DEB84 800EE384 1400B18F */  lw         $s1, 0x14($sp)
    /* DEB88 800EE388 1000B08F */  lw         $s0, 0x10($sp)
    /* DEB8C 800EE38C 0800E003 */  jr         $ra
    /* DEB90 800EE390 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SetDrawArea
