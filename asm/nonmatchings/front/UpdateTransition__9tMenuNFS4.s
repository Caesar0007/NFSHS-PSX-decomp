.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateTransition__9tMenuNFS4, 0x94

glabel UpdateTransition__9tMenuNFS4
    /* BC00 8001B400 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* BC04 8001B404 1400B1AF */  sw         $s1, 0x14($sp)
    /* BC08 8001B408 21888000 */  addu       $s1, $a0, $zero
    /* BC0C 8001B40C 1800BFAF */  sw         $ra, 0x18($sp)
    /* BC10 8001B410 1000B0AF */  sw         $s0, 0x10($sp)
    /* BC14 8001B414 1000228E */  lw         $v0, 0x10($s1)
    /* BC18 8001B418 00000000 */  nop
    /* BC1C 8001B41C 18004010 */  beqz       $v0, .L8001B480
    /* BC20 8001B420 21800000 */   addu      $s0, $zero, $zero
  .L8001B424:
    /* BC24 8001B424 002C1000 */  sll        $a1, $s0, 16
    /* BC28 8001B428 032C0500 */  sra        $a1, $a1, 16
    /* BC2C 8001B42C 80100500 */  sll        $v0, $a1, 2
    /* BC30 8001B430 21102202 */  addu       $v0, $s1, $v0
    /* BC34 8001B434 1000438C */  lw         $v1, 0x10($v0)
    /* BC38 8001B438 0800228E */  lw         $v0, 0x8($s1)
    /* BC3C 8001B43C 00000000 */  nop
    /* BC40 8001B440 2628A200 */  xor        $a1, $a1, $v0
    /* BC44 8001B444 1800668C */  lw         $a2, 0x18($v1)
    /* BC48 8001B448 0100A52C */  sltiu      $a1, $a1, 0x1
    /* BC4C 8001B44C 5000C484 */  lh         $a0, 0x50($a2)
    /* BC50 8001B450 5400C28C */  lw         $v0, 0x54($a2)
    /* BC54 8001B454 00000000 */  nop
    /* BC58 8001B458 09F84000 */  jalr       $v0
    /* BC5C 8001B45C 21206400 */   addu      $a0, $v1, $a0
    /* BC60 8001B460 01000326 */  addiu      $v1, $s0, 0x1
    /* BC64 8001B464 00140300 */  sll        $v0, $v1, 16
    /* BC68 8001B468 83130200 */  sra        $v0, $v0, 14
    /* BC6C 8001B46C 21102202 */  addu       $v0, $s1, $v0
    /* BC70 8001B470 1000428C */  lw         $v0, 0x10($v0)
    /* BC74 8001B474 00000000 */  nop
    /* BC78 8001B478 EAFF4014 */  bnez       $v0, .L8001B424
    /* BC7C 8001B47C 21806000 */   addu      $s0, $v1, $zero
  .L8001B480:
    /* BC80 8001B480 1800BF8F */  lw         $ra, 0x18($sp)
    /* BC84 8001B484 1400B18F */  lw         $s1, 0x14($sp)
    /* BC88 8001B488 1000B08F */  lw         $s0, 0x10($sp)
    /* BC8C 8001B48C 0800E003 */  jr         $ra
    /* BC90 8001B490 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel UpdateTransition__9tMenuNFS4
