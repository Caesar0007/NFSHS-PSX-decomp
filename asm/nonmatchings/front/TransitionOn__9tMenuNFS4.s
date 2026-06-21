.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOn__9tMenuNFS4, 0x88

glabel TransitionOn__9tMenuNFS4
    /* BAD8 8001B2D8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* BADC 8001B2DC 1400B1AF */  sw         $s1, 0x14($sp)
    /* BAE0 8001B2E0 21888000 */  addu       $s1, $a0, $zero
    /* BAE4 8001B2E4 1800BFAF */  sw         $ra, 0x18($sp)
    /* BAE8 8001B2E8 1000B0AF */  sw         $s0, 0x10($sp)
    /* BAEC 8001B2EC 1000228E */  lw         $v0, 0x10($s1)
    /* BAF0 8001B2F0 00000000 */  nop
    /* BAF4 8001B2F4 15004010 */  beqz       $v0, .L8001B34C
    /* BAF8 8001B2F8 21800000 */   addu      $s0, $zero, $zero
  .L8001B2FC:
    /* BAFC 8001B2FC 00141000 */  sll        $v0, $s0, 16
    /* BB00 8001B300 83130200 */  sra        $v0, $v0, 14
    /* BB04 8001B304 21102202 */  addu       $v0, $s1, $v0
    /* BB08 8001B308 1000438C */  lw         $v1, 0x10($v0)
    /* BB0C 8001B30C 00000000 */  nop
    /* BB10 8001B310 1800628C */  lw         $v0, 0x18($v1)
    /* BB14 8001B314 00000000 */  nop
    /* BB18 8001B318 40004484 */  lh         $a0, 0x40($v0)
    /* BB1C 8001B31C 4400428C */  lw         $v0, 0x44($v0)
    /* BB20 8001B320 00000000 */  nop
    /* BB24 8001B324 09F84000 */  jalr       $v0
    /* BB28 8001B328 21206400 */   addu      $a0, $v1, $a0
    /* BB2C 8001B32C 01000326 */  addiu      $v1, $s0, 0x1
    /* BB30 8001B330 00140300 */  sll        $v0, $v1, 16
    /* BB34 8001B334 83130200 */  sra        $v0, $v0, 14
    /* BB38 8001B338 21102202 */  addu       $v0, $s1, $v0
    /* BB3C 8001B33C 1000428C */  lw         $v0, 0x10($v0)
    /* BB40 8001B340 00000000 */  nop
    /* BB44 8001B344 EDFF4014 */  bnez       $v0, .L8001B2FC
    /* BB48 8001B348 21806000 */   addu      $s0, $v1, $zero
  .L8001B34C:
    /* BB4C 8001B34C 1800BF8F */  lw         $ra, 0x18($sp)
    /* BB50 8001B350 1400B18F */  lw         $s1, 0x14($sp)
    /* BB54 8001B354 1000B08F */  lw         $s0, 0x10($sp)
    /* BB58 8001B358 0800E003 */  jr         $ra
    /* BB5C 8001B35C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel TransitionOn__9tMenuNFS4
