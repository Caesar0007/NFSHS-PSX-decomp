.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOff__12tOptionsMenu, 0x98

glabel TransitionOff__12tOptionsMenu
    /* CDD8 8001C5D8 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* CDDC 8001C5DC 1400B1AF */  sw         $s1, 0x14($sp)
    /* CDE0 8001C5E0 21888000 */  addu       $s1, $a0, $zero
    /* CDE4 8001C5E4 1000B0AF */  sw         $s0, 0x10($sp)
    /* CDE8 8001C5E8 21800000 */  addu       $s0, $zero, $zero
    /* CDEC 8001C5EC 1800BFAF */  sw         $ra, 0x18($sp)
    /* CDF0 8001C5F0 1000238E */  lw         $v1, 0x10($s1)
    /* CDF4 8001C5F4 28000224 */  addiu      $v0, $zero, 0x28
    /* CDF8 8001C5F8 700022A2 */  sb         $v0, 0x70($s1)
    /* CDFC 8001C5FC 15006010 */  beqz       $v1, .L8001C654
    /* CE00 8001C600 740020AE */   sw        $zero, 0x74($s1)
  .L8001C604:
    /* CE04 8001C604 00141000 */  sll        $v0, $s0, 16
    /* CE08 8001C608 83130200 */  sra        $v0, $v0, 14
    /* CE0C 8001C60C 21102202 */  addu       $v0, $s1, $v0
    /* CE10 8001C610 1000438C */  lw         $v1, 0x10($v0)
    /* CE14 8001C614 00000000 */  nop
    /* CE18 8001C618 1800628C */  lw         $v0, 0x18($v1)
    /* CE1C 8001C61C 00000000 */  nop
    /* CE20 8001C620 38004484 */  lh         $a0, 0x38($v0)
    /* CE24 8001C624 3C00428C */  lw         $v0, 0x3C($v0)
    /* CE28 8001C628 00000000 */  nop
    /* CE2C 8001C62C 09F84000 */  jalr       $v0
    /* CE30 8001C630 21206400 */   addu      $a0, $v1, $a0
    /* CE34 8001C634 01000326 */  addiu      $v1, $s0, 0x1
    /* CE38 8001C638 00140300 */  sll        $v0, $v1, 16
    /* CE3C 8001C63C 83130200 */  sra        $v0, $v0, 14
    /* CE40 8001C640 21102202 */  addu       $v0, $s1, $v0
    /* CE44 8001C644 1000428C */  lw         $v0, 0x10($v0)
    /* CE48 8001C648 00000000 */  nop
    /* CE4C 8001C64C EDFF4014 */  bnez       $v0, .L8001C604
    /* CE50 8001C650 21806000 */   addu      $s0, $v1, $zero
  .L8001C654:
    /* CE54 8001C654 01000224 */  addiu      $v0, $zero, 0x1
    /* CE58 8001C658 6C0022AE */  sw         $v0, 0x6C($s1)
    /* CE5C 8001C65C 1800BF8F */  lw         $ra, 0x18($sp)
    /* CE60 8001C660 1400B18F */  lw         $s1, 0x14($sp)
    /* CE64 8001C664 1000B08F */  lw         $s0, 0x10($sp)
    /* CE68 8001C668 0800E003 */  jr         $ra
    /* CE6C 8001C66C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel TransitionOff__12tOptionsMenu
