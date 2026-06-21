.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOff__9tMenuNFS4, 0x88

glabel TransitionOff__9tMenuNFS4
    /* BA50 8001B250 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* BA54 8001B254 1400B1AF */  sw         $s1, 0x14($sp)
    /* BA58 8001B258 21888000 */  addu       $s1, $a0, $zero
    /* BA5C 8001B25C 1800BFAF */  sw         $ra, 0x18($sp)
    /* BA60 8001B260 1000B0AF */  sw         $s0, 0x10($sp)
    /* BA64 8001B264 1000228E */  lw         $v0, 0x10($s1)
    /* BA68 8001B268 00000000 */  nop
    /* BA6C 8001B26C 15004010 */  beqz       $v0, .L8001B2C4
    /* BA70 8001B270 21800000 */   addu      $s0, $zero, $zero
  .L8001B274:
    /* BA74 8001B274 00141000 */  sll        $v0, $s0, 16
    /* BA78 8001B278 83130200 */  sra        $v0, $v0, 14
    /* BA7C 8001B27C 21102202 */  addu       $v0, $s1, $v0
    /* BA80 8001B280 1000438C */  lw         $v1, 0x10($v0)
    /* BA84 8001B284 00000000 */  nop
    /* BA88 8001B288 1800628C */  lw         $v0, 0x18($v1)
    /* BA8C 8001B28C 00000000 */  nop
    /* BA90 8001B290 38004484 */  lh         $a0, 0x38($v0)
    /* BA94 8001B294 3C00428C */  lw         $v0, 0x3C($v0)
    /* BA98 8001B298 00000000 */  nop
    /* BA9C 8001B29C 09F84000 */  jalr       $v0
    /* BAA0 8001B2A0 21206400 */   addu      $a0, $v1, $a0
    /* BAA4 8001B2A4 01000326 */  addiu      $v1, $s0, 0x1
    /* BAA8 8001B2A8 00140300 */  sll        $v0, $v1, 16
    /* BAAC 8001B2AC 83130200 */  sra        $v0, $v0, 14
    /* BAB0 8001B2B0 21102202 */  addu       $v0, $s1, $v0
    /* BAB4 8001B2B4 1000428C */  lw         $v0, 0x10($v0)
    /* BAB8 8001B2B8 00000000 */  nop
    /* BABC 8001B2BC EDFF4014 */  bnez       $v0, .L8001B274
    /* BAC0 8001B2C0 21806000 */   addu      $s0, $v1, $zero
  .L8001B2C4:
    /* BAC4 8001B2C4 1800BF8F */  lw         $ra, 0x18($sp)
    /* BAC8 8001B2C8 1400B18F */  lw         $s1, 0x14($sp)
    /* BACC 8001B2CC 1000B08F */  lw         $s0, 0x10($sp)
    /* BAD0 8001B2D0 0800E003 */  jr         $ra
    /* BAD4 8001B2D4 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel TransitionOff__9tMenuNFS4
