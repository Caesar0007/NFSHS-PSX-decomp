.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDdmcomplete, 0x70

glabel iSNDdmcomplete
    /* FB66C 8010AE6C E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* FB670 8010AE70 1000B0AF */  sw         $s0, 0x10($sp)
    /* FB674 8010AE74 1400BFAF */  sw         $ra, 0x14($sp)
    /* FB678 8010AE78 082B040C */  jal        iSNDdmservice
    /* FB67C 8010AE7C 21808000 */   addu      $s0, $a0, $zero
    /* FB680 8010AE80 1480023C */  lui        $v0, %hi(sndpd)
    /* FB684 8010AE84 18794324 */  addiu      $v1, $v0, %lo(sndpd)
    /* FB688 8010AE88 0C006290 */  lbu        $v0, 0xC($v1)
    /* FB68C 8010AE8C 00000000 */  nop
    /* FB690 8010AE90 00160200 */  sll        $v0, $v0, 24
    /* FB694 8010AE94 0500401C */  bgtz       $v0, .L8010AEAC
    /* FB698 8010AE98 21200000 */   addu      $a0, $zero, $zero
    /* FB69C 8010AE9C B32B0408 */  j          .L8010AECC
    /* FB6A0 8010AEA0 01000224 */   addiu     $v0, $zero, 0x1
  .L8010AEA4:
    /* FB6A4 8010AEA4 B32B0408 */  j          .L8010AECC
    /* FB6A8 8010AEA8 21100000 */   addu      $v0, $zero, $zero
  .L8010AEAC:
    /* FB6AC 8010AEAC 1000628C */  lw         $v0, 0x10($v1)
    /* FB6B0 8010AEB0 00000000 */  nop
    /* FB6B4 8010AEB4 FBFF5010 */  beq        $v0, $s0, .L8010AEA4
    /* FB6B8 8010AEB8 01008424 */   addiu     $a0, $a0, 0x1
    /* FB6BC 8010AEBC 0A008228 */  slti       $v0, $a0, 0xA
    /* FB6C0 8010AEC0 FAFF4014 */  bnez       $v0, .L8010AEAC
    /* FB6C4 8010AEC4 14006324 */   addiu     $v1, $v1, 0x14
    /* FB6C8 8010AEC8 01000224 */  addiu      $v0, $zero, 0x1
  .L8010AECC:
    /* FB6CC 8010AECC 1400BF8F */  lw         $ra, 0x14($sp)
    /* FB6D0 8010AED0 1000B08F */  lw         $s0, 0x10($sp)
    /* FB6D4 8010AED4 0800E003 */  jr         $ra
    /* FB6D8 8010AED8 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel iSNDdmcomplete
