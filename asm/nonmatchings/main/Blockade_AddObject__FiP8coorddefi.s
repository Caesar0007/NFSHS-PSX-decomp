.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Blockade_AddObject__FiP8coorddefi, 0x17C

glabel Blockade_AddObject__FiP8coorddefi
    /* 4CC68 8005C468 F0FEBD27 */  addiu      $sp, $sp, -0x110
    /* 4CC6C 8005C46C F800B0AF */  sw         $s0, 0xF8($sp)
    /* 4CC70 8005C470 21808000 */  addu       $s0, $a0, $zero
    /* 4CC74 8005C474 0001B2AF */  sw         $s2, 0x100($sp)
    /* 4CC78 8005C478 2190A000 */  addu       $s2, $a1, $zero
    /* 4CC7C 8005C47C FC00B1AF */  sw         $s1, 0xFC($sp)
    /* 4CC80 8005C480 2188C000 */  addu       $s1, $a2, $zero
    /* 4CC84 8005C484 21202002 */  addu       $a0, $s1, $zero
    /* 4CC88 8005C488 01000224 */  addiu      $v0, $zero, 0x1
    /* 4CC8C 8005C48C 0801BFAF */  sw         $ra, 0x108($sp)
    /* 4CC90 8005C490 0401B3AF */  sw         $s3, 0x104($sp)
    /* 4CC94 8005C494 1000A0AF */  sw         $zero, 0x10($sp)
    /* 4CC98 8005C498 5696020C */  jal        Object_GetObjDefID__Fi
    /* 4CC9C 8005C49C 5400A2AF */   sw        $v0, 0x54($sp)
    /* 4CCA0 8005C4A0 0200033C */  lui        $v1, (0x23916 >> 16)
    /* 4CCA4 8005C4A4 16396334 */  ori        $v1, $v1, (0x23916 & 0xFFFF)
    /* 4CCA8 8005C4A8 21200002 */  addu       $a0, $s0, $zero
    /* 4CCAC 8005C4AC 7000B027 */  addiu      $s0, $sp, 0x70
    /* 4CCB0 8005C4B0 21280002 */  addu       $a1, $s0, $zero
    /* 4CCB4 8005C4B4 5C00A2AF */  sw         $v0, 0x5C($sp)
    /* 4CCB8 8005C4B8 6000A3AF */  sw         $v1, 0x60($sp)
    /* 4CCBC 8005C4BC 0000478E */  lw         $a3, 0x0($s2)
    /* 4CCC0 8005C4C0 0400488E */  lw         $t0, 0x4($s2)
    /* 4CCC4 8005C4C4 0800498E */  lw         $t1, 0x8($s2)
    /* 4CCC8 8005C4C8 2000A7AF */  sw         $a3, 0x20($sp)
    /* 4CCCC 8005C4CC 2400A8AF */  sw         $t0, 0x24($sp)
    /* 4CCD0 8005C4D0 2800A9AF */  sw         $t1, 0x28($sp)
    /* 4CCD4 8005C4D4 59FB010C */  jal        BWorldSm_SetSlice__FiP12BWorldSm_Pos
    /* 4CCD8 8005C4D8 5800B1AF */   sw        $s1, 0x58($sp)
    /* 4CCDC 8005C4DC 21204002 */  addu       $a0, $s2, $zero
    /* 4CCE0 8005C4E0 21280002 */  addu       $a1, $s0, $zero
    /* 4CCE4 8005C4E4 B1FE010C */  jal        BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi
    /* 4CCE8 8005C4E8 01000624 */   addiu     $a2, $zero, 0x1
    /* 4CCEC 8005C4EC 4801020C */  jal        BWorldSm_UNormal__FP12BWorldSm_Pos
    /* 4CCF0 8005C4F0 21200002 */   addu      $a0, $s0, $zero
    /* 4CCF4 8005C4F4 0000478C */  lw         $a3, 0x0($v0)
    /* 4CCF8 8005C4F8 0400488C */  lw         $t0, 0x4($v0)
    /* 4CCFC 8005C4FC 0800498C */  lw         $t1, 0x8($v0)
    /* 4CD00 8005C500 3C00A7AF */  sw         $a3, 0x3C($sp)
    /* 4CD04 8005C504 4000A8AF */  sw         $t0, 0x40($sp)
    /* 4CD08 8005C508 4400A9AF */  sw         $t1, 0x44($sp)
    /* 4CD0C 8005C50C 5201020C */  jal        BWorldSm_UForward__FP12BWorldSm_Pos
    /* 4CD10 8005C510 21200002 */   addu      $a0, $s0, $zero
    /* 4CD14 8005C514 3C00B227 */  addiu      $s2, $sp, 0x3C
    /* 4CD18 8005C518 4800B127 */  addiu      $s1, $sp, 0x48
    /* 4CD1C 8005C51C 0000478C */  lw         $a3, 0x0($v0)
    /* 4CD20 8005C520 0400488C */  lw         $t0, 0x4($v0)
    /* 4CD24 8005C524 0800498C */  lw         $t1, 0x8($v0)
    /* 4CD28 8005C528 4800A7AF */  sw         $a3, 0x48($sp)
    /* 4CD2C 8005C52C 4C00A8AF */  sw         $t0, 0x4C($sp)
    /* 4CD30 8005C530 5000A9AF */  sw         $t1, 0x50($sp)
    /* 4CD34 8005C534 0400448E */  lw         $a0, 0x4($s2)
    /* 4CD38 8005C538 0800258E */  lw         $a1, 0x8($s1)
    /* 4CD3C 8005C53C CA90030C */  jal        fixedmult
    /* 4CD40 8005C540 00000000 */   nop
    /* 4CD44 8005C544 0800448E */  lw         $a0, 0x8($s2)
    /* 4CD48 8005C548 0400258E */  lw         $a1, 0x4($s1)
    /* 4CD4C 8005C54C CA90030C */  jal        fixedmult
    /* 4CD50 8005C550 21804000 */   addu      $s0, $v0, $zero
    /* 4CD54 8005C554 23800202 */  subu       $s0, $s0, $v0
    /* 4CD58 8005C558 3000B0AF */  sw         $s0, 0x30($sp)
    /* 4CD5C 8005C55C 0800448E */  lw         $a0, 0x8($s2)
    /* 4CD60 8005C560 4800A58F */  lw         $a1, 0x48($sp)
    /* 4CD64 8005C564 CA90030C */  jal        fixedmult
    /* 4CD68 8005C568 00000000 */   nop
    /* 4CD6C 8005C56C 3C00A48F */  lw         $a0, 0x3C($sp)
    /* 4CD70 8005C570 0800258E */  lw         $a1, 0x8($s1)
    /* 4CD74 8005C574 CA90030C */  jal        fixedmult
    /* 4CD78 8005C578 21804000 */   addu      $s0, $v0, $zero
    /* 4CD7C 8005C57C 3000B327 */  addiu      $s3, $sp, 0x30
    /* 4CD80 8005C580 23800202 */  subu       $s0, $s0, $v0
    /* 4CD84 8005C584 040070AE */  sw         $s0, 0x4($s3)
    /* 4CD88 8005C588 3C00A48F */  lw         $a0, 0x3C($sp)
    /* 4CD8C 8005C58C 0400258E */  lw         $a1, 0x4($s1)
    /* 4CD90 8005C590 CA90030C */  jal        fixedmult
    /* 4CD94 8005C594 00000000 */   nop
    /* 4CD98 8005C598 0400448E */  lw         $a0, 0x4($s2)
    /* 4CD9C 8005C59C 4800A58F */  lw         $a1, 0x48($sp)
    /* 4CDA0 8005C5A0 CA90030C */  jal        fixedmult
    /* 4CDA4 8005C5A4 21804000 */   addu      $s0, $v0, $zero
    /* 4CDA8 8005C5A8 21206002 */  addu       $a0, $s3, $zero
    /* 4CDAC 8005C5AC 21288000 */  addu       $a1, $a0, $zero
    /* 4CDB0 8005C5B0 23800202 */  subu       $s0, $s0, $v0
    /* 4CDB4 8005C5B4 D690030C */  jal        transpose
    /* 4CDB8 8005C5B8 080090AC */   sw        $s0, 0x8($a0)
    /* 4CDBC 8005C5BC 1000A427 */  addiu      $a0, $sp, 0x10
    /* 4CDC0 8005C5C0 8196020C */  jal        Object_AddCustomObject__FP9SceneElemi
    /* 4CDC4 8005C5C4 01000524 */   addiu     $a1, $zero, 0x1
    /* 4CDC8 8005C5C8 0801BF8F */  lw         $ra, 0x108($sp)
    /* 4CDCC 8005C5CC 0401B38F */  lw         $s3, 0x104($sp)
    /* 4CDD0 8005C5D0 0001B28F */  lw         $s2, 0x100($sp)
    /* 4CDD4 8005C5D4 FC00B18F */  lw         $s1, 0xFC($sp)
    /* 4CDD8 8005C5D8 F800B08F */  lw         $s0, 0xF8($sp)
    /* 4CDDC 8005C5DC 0800E003 */  jr         $ra
    /* 4CDE0 8005C5E0 1001BD27 */   addiu     $sp, $sp, 0x110
endlabel Blockade_AddObject__FiP8coorddefi
