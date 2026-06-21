.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionOn__12tOptionsMenu, 0x9C

glabel TransitionOn__12tOptionsMenu
    /* CE70 8001C670 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* CE74 8001C674 1400B1AF */  sw         $s1, 0x14($sp)
    /* CE78 8001C678 21888000 */  addu       $s1, $a0, $zero
    /* CE7C 8001C67C 1000B0AF */  sw         $s0, 0x10($sp)
    /* CE80 8001C680 21800000 */  addu       $s0, $zero, $zero
    /* CE84 8001C684 1800BFAF */  sw         $ra, 0x18($sp)
    /* CE88 8001C688 1000238E */  lw         $v1, 0x10($s1)
    /* CE8C 8001C68C D8FF0224 */  addiu      $v0, $zero, -0x28
    /* CE90 8001C690 700022A2 */  sb         $v0, 0x70($s1)
    /* CE94 8001C694 01000224 */  addiu      $v0, $zero, 0x1
    /* CE98 8001C698 6C0022AE */  sw         $v0, 0x6C($s1)
    /* CE9C 8001C69C 28020224 */  addiu      $v0, $zero, 0x228
    /* CEA0 8001C6A0 15006010 */  beqz       $v1, .L8001C6F8
    /* CEA4 8001C6A4 740022AE */   sw        $v0, 0x74($s1)
  .L8001C6A8:
    /* CEA8 8001C6A8 00141000 */  sll        $v0, $s0, 16
    /* CEAC 8001C6AC 83130200 */  sra        $v0, $v0, 14
    /* CEB0 8001C6B0 21102202 */  addu       $v0, $s1, $v0
    /* CEB4 8001C6B4 1000438C */  lw         $v1, 0x10($v0)
    /* CEB8 8001C6B8 00000000 */  nop
    /* CEBC 8001C6BC 1800628C */  lw         $v0, 0x18($v1)
    /* CEC0 8001C6C0 00000000 */  nop
    /* CEC4 8001C6C4 40004484 */  lh         $a0, 0x40($v0)
    /* CEC8 8001C6C8 4400428C */  lw         $v0, 0x44($v0)
    /* CECC 8001C6CC 00000000 */  nop
    /* CED0 8001C6D0 09F84000 */  jalr       $v0
    /* CED4 8001C6D4 21206400 */   addu      $a0, $v1, $a0
    /* CED8 8001C6D8 01000326 */  addiu      $v1, $s0, 0x1
    /* CEDC 8001C6DC 00140300 */  sll        $v0, $v1, 16
    /* CEE0 8001C6E0 83130200 */  sra        $v0, $v0, 14
    /* CEE4 8001C6E4 21102202 */  addu       $v0, $s1, $v0
    /* CEE8 8001C6E8 1000428C */  lw         $v0, 0x10($v0)
    /* CEEC 8001C6EC 00000000 */  nop
    /* CEF0 8001C6F0 EDFF4014 */  bnez       $v0, .L8001C6A8
    /* CEF4 8001C6F4 21806000 */   addu      $s0, $v1, $zero
  .L8001C6F8:
    /* CEF8 8001C6F8 1800BF8F */  lw         $ra, 0x18($sp)
    /* CEFC 8001C6FC 1400B18F */  lw         $s1, 0x14($sp)
    /* CF00 8001C700 1000B08F */  lw         $s0, 0x10($sp)
    /* CF04 8001C704 0800E003 */  jr         $ra
    /* CF08 8001C708 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel TransitionOn__12tOptionsMenu
