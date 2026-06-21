.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOn__12tMenuOptions, 0x98

glabel TransitionOn__12tMenuOptions
    /* C600 8001BE00 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* C604 8001BE04 1400B1AF */  sw         $s1, 0x14($sp)
    /* C608 8001BE08 21888000 */  addu       $s1, $a0, $zero
    /* C60C 8001BE0C 1000B0AF */  sw         $s0, 0x10($sp)
    /* C610 8001BE10 21802002 */  addu       $s0, $s1, $zero
    /* C614 8001BE14 1800BFAF */  sw         $ra, 0x18($sp)
  .L8001BE18:
    /* C618 8001BE18 1000038E */  lw         $v1, 0x10($s0)
    /* C61C 8001BE1C 00000000 */  nop
    /* C620 8001BE20 10006010 */  beqz       $v1, .L8001BE64
    /* C624 8001BE24 0F000424 */   addiu     $a0, $zero, 0xF
    /* C628 8001BE28 0000628C */  lw         $v0, 0x0($v1)
    /* C62C 8001BE2C 00000000 */  nop
    /* C630 8001BE30 01004238 */  xori       $v0, $v0, 0x1
    /* C634 8001BE34 01004230 */  andi       $v0, $v0, 0x1
    /* C638 8001BE38 08004010 */  beqz       $v0, .L8001BE5C
    /* C63C 8001BE3C 00000000 */   nop
    /* C640 8001BE40 1800628C */  lw         $v0, 0x18($v1)
    /* C644 8001BE44 00000000 */  nop
    /* C648 8001BE48 40004484 */  lh         $a0, 0x40($v0)
    /* C64C 8001BE4C 4400428C */  lw         $v0, 0x44($v0)
    /* C650 8001BE50 00000000 */  nop
    /* C654 8001BE54 09F84000 */  jalr       $v0
    /* C658 8001BE58 21206400 */   addu      $a0, $v1, $a0
  .L8001BE5C:
    /* C65C 8001BE5C 866F0008 */  j          .L8001BE18
    /* C660 8001BE60 04001026 */   addiu     $s0, $s0, 0x4
  .L8001BE64:
    /* C664 8001BE64 01000224 */  addiu      $v0, $zero, 0x1
    /* C668 8001BE68 760022A2 */  sb         $v0, 0x76($s1)
    /* C66C 8001BE6C 1480023C */  lui        $v0, %hi(ticks)
    /* C670 8001BE70 ACDC438C */  lw         $v1, %lo(ticks)($v0)
    /* C674 8001BE74 01000224 */  addiu      $v0, $zero, 0x1
    /* C678 8001BE78 700022AE */  sw         $v0, 0x70($s1)
    /* C67C 8001BE7C 81E5010C */  jal        AudioCmn_PlayFESFX__Fi
    /* C680 8001BE80 7C0023AE */   sw        $v1, 0x7C($s1)
    /* C684 8001BE84 1800BF8F */  lw         $ra, 0x18($sp)
    /* C688 8001BE88 1400B18F */  lw         $s1, 0x14($sp)
    /* C68C 8001BE8C 1000B08F */  lw         $s0, 0x10($sp)
    /* C690 8001BE90 0800E003 */  jr         $ra
    /* C694 8001BE94 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel TransitionOn__12tMenuOptions
