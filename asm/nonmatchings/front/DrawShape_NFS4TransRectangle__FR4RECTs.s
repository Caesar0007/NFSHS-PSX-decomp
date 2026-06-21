.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawShape_NFS4TransRectangle__FR4RECTs, 0x128

glabel DrawShape_NFS4TransRectangle__FR4RECTs
    /* 3CCDC 8004C4DC D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 3CCE0 8004C4E0 1800B0AF */  sw         $s0, 0x18($sp)
    /* 3CCE4 8004C4E4 21808000 */  addu       $s0, $a0, $zero
    /* 3CCE8 8004C4E8 2000B2AF */  sw         $s2, 0x20($sp)
    /* 3CCEC 8004C4EC 2190A000 */  addu       $s2, $a1, $zero
    /* 3CCF0 8004C4F0 21200000 */  addu       $a0, $zero, $zero
    /* 3CCF4 8004C4F4 04000724 */  addiu      $a3, $zero, 0x4
    /* 3CCF8 8004C4F8 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 3CCFC 8004C4FC 408C1200 */  sll        $s1, $s2, 17
    /* 3CD00 8004C500 2800BFAF */  sw         $ra, 0x28($sp)
    /* 3CD04 8004C504 2400B3AF */  sw         $s3, 0x24($sp)
    /* 3CD08 8004C508 00000586 */  lh         $a1, 0x0($s0)
    /* 3CD0C 8004C50C 02000686 */  lh         $a2, 0x2($s0)
    /* 3CD10 8004C510 06000286 */  lh         $v0, 0x6($s0)
    /* 3CD14 8004C514 038C1100 */  sra        $s1, $s1, 16
    /* 3CD18 8004C518 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3CD1C 8004C51C B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 3CD20 8004C520 1000A2AF */   sw        $v0, 0x10($sp)
    /* 3CD24 8004C524 21200000 */  addu       $a0, $zero, $zero
    /* 3CD28 8004C528 00000586 */  lh         $a1, 0x0($s0)
    /* 3CD2C 8004C52C 04000286 */  lh         $v0, 0x4($s0)
    /* 3CD30 8004C530 02000686 */  lh         $a2, 0x2($s0)
    /* 3CD34 8004C534 06000386 */  lh         $v1, 0x6($s0)
    /* 3CD38 8004C538 04000724 */  addiu      $a3, $zero, 0x4
    /* 3CD3C 8004C53C 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3CD40 8004C540 2128A200 */  addu       $a1, $a1, $v0
    /* 3CD44 8004C544 FCFFA524 */  addiu      $a1, $a1, -0x4
    /* 3CD48 8004C548 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 3CD4C 8004C54C 1000A3AF */   sw        $v1, 0x10($sp)
    /* 3CD50 8004C550 21200000 */  addu       $a0, $zero, $zero
    /* 3CD54 8004C554 00000586 */  lh         $a1, 0x0($s0)
    /* 3CD58 8004C558 02000686 */  lh         $a2, 0x2($s0)
    /* 3CD5C 8004C55C 04000786 */  lh         $a3, 0x4($s0)
    /* 3CD60 8004C560 02001324 */  addiu      $s3, $zero, 0x2
    /* 3CD64 8004C564 1000B3AF */  sw         $s3, 0x10($sp)
    /* 3CD68 8004C568 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3CD6C 8004C56C 0400A524 */  addiu      $a1, $a1, 0x4
    /* 3CD70 8004C570 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 3CD74 8004C574 F8FFE724 */   addiu     $a3, $a3, -0x8
    /* 3CD78 8004C578 00000586 */  lh         $a1, 0x0($s0)
    /* 3CD7C 8004C57C 02000686 */  lh         $a2, 0x2($s0)
    /* 3CD80 8004C580 06000286 */  lh         $v0, 0x6($s0)
    /* 3CD84 8004C584 04000786 */  lh         $a3, 0x4($s0)
    /* 3CD88 8004C588 21200000 */  addu       $a0, $zero, $zero
    /* 3CD8C 8004C58C 1000B3AF */  sw         $s3, 0x10($sp)
    /* 3CD90 8004C590 1400B1AF */  sw         $s1, 0x14($sp)
    /* 3CD94 8004C594 0400A524 */  addiu      $a1, $a1, 0x4
    /* 3CD98 8004C598 2130C200 */  addu       $a2, $a2, $v0
    /* 3CD9C 8004C59C FEFFC624 */  addiu      $a2, $a2, -0x2
    /* 3CDA0 8004C5A0 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 3CDA4 8004C5A4 F8FFE724 */   addiu     $a3, $a3, -0x8
    /* 3CDA8 8004C5A8 21200000 */  addu       $a0, $zero, $zero
    /* 3CDAC 8004C5AC 00941200 */  sll        $s2, $s2, 16
    /* 3CDB0 8004C5B0 00000586 */  lh         $a1, 0x0($s0)
    /* 3CDB4 8004C5B4 02000686 */  lh         $a2, 0x2($s0)
    /* 3CDB8 8004C5B8 04000786 */  lh         $a3, 0x4($s0)
    /* 3CDBC 8004C5BC 06000286 */  lh         $v0, 0x6($s0)
    /* 3CDC0 8004C5C0 03941200 */  sra        $s2, $s2, 16
    /* 3CDC4 8004C5C4 1400B2AF */  sw         $s2, 0x14($sp)
    /* 3CDC8 8004C5C8 0400A524 */  addiu      $a1, $a1, 0x4
    /* 3CDCC 8004C5CC 2130D300 */  addu       $a2, $a2, $s3
    /* 3CDD0 8004C5D0 F8FFE724 */  addiu      $a3, $a3, -0x8
    /* 3CDD4 8004C5D4 FCFF4224 */  addiu      $v0, $v0, -0x4
    /* 3CDD8 8004C5D8 B43B010C */  jal        PSXDrawTransSquare__Fiiiiis
    /* 3CDDC 8004C5DC 1000A2AF */   sw        $v0, 0x10($sp)
    /* 3CDE0 8004C5E0 B635010C */  jal        FeDraw_SetABRMode__Fi
    /* 3CDE4 8004C5E4 21200000 */   addu      $a0, $zero, $zero
    /* 3CDE8 8004C5E8 2800BF8F */  lw         $ra, 0x28($sp)
    /* 3CDEC 8004C5EC 2400B38F */  lw         $s3, 0x24($sp)
    /* 3CDF0 8004C5F0 2000B28F */  lw         $s2, 0x20($sp)
    /* 3CDF4 8004C5F4 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 3CDF8 8004C5F8 1800B08F */  lw         $s0, 0x18($sp)
    /* 3CDFC 8004C5FC 0800E003 */  jr         $ra
    /* 3CE00 8004C600 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel DrawShape_NFS4TransRectangle__FR4RECTs
    /* 3CE04 8004C604 00000000 */  nop
