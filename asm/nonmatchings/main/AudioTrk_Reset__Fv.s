.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AudioTrk_Reset__Fv, 0xE0

glabel AudioTrk_Reset__Fv
    /* 6CE14 8007C614 0802828F */  lw         $v0, %gp_rel(AudioTrk_g)($gp)
    /* 6CE18 8007C618 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 6CE1C 8007C61C 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 6CE20 8007C620 1800B2AF */  sw         $s2, 0x18($sp)
    /* 6CE24 8007C624 1400B1AF */  sw         $s1, 0x14($sp)
    /* 6CE28 8007C628 18004010 */  beqz       $v0, .L8007C68C
    /* 6CE2C 8007C62C 1000B0AF */   sw        $s0, 0x10($sp)
    /* 6CE30 8007C630 21880000 */  addu       $s1, $zero, $zero
    /* 6CE34 8007C634 FFFF1224 */  addiu      $s2, $zero, -0x1
  .L8007C638:
    /* 6CE38 8007C638 0802828F */  lw         $v0, %gp_rel(AudioTrk_g)($gp)
    /* 6CE3C 8007C63C 00811100 */  sll        $s0, $s1, 4
    /* 6CE40 8007C640 21105000 */  addu       $v0, $v0, $s0
    /* 6CE44 8007C644 0400428C */  lw         $v0, 0x4($v0)
    /* 6CE48 8007C648 00000000 */  nop
    /* 6CE4C 8007C64C 07005210 */  beq        $v0, $s2, .L8007C66C
    /* 6CE50 8007C650 00000000 */   nop
    /* 6CE54 8007C654 34E0010C */  jal        freeVoiceChannel__Fi
    /* 6CE58 8007C658 37002426 */   addiu     $a0, $s1, 0x37
    /* 6CE5C 8007C65C 0802828F */  lw         $v0, %gp_rel(AudioTrk_g)($gp)
    /* 6CE60 8007C660 00000000 */  nop
    /* 6CE64 8007C664 21105000 */  addu       $v0, $v0, $s0
    /* 6CE68 8007C668 040052AC */  sw         $s2, 0x4($v0)
  .L8007C66C:
    /* 6CE6C 8007C66C 0802828F */  lw         $v0, %gp_rel(AudioTrk_g)($gp)
    /* 6CE70 8007C670 01003126 */  addiu      $s1, $s1, 0x1
    /* 6CE74 8007C674 21105000 */  addu       $v0, $v0, $s0
    /* 6CE78 8007C678 000040AC */  sw         $zero, 0x0($v0)
    /* 6CE7C 8007C67C 0C0052A4 */  sh         $s2, 0xC($v0)
    /* 6CE80 8007C680 1000222A */  slti       $v0, $s1, 0x10
    /* 6CE84 8007C684 ECFF4014 */  bnez       $v0, .L8007C638
    /* 6CE88 8007C688 00000000 */   nop
  .L8007C68C:
    /* 6CE8C 8007C68C 1480033C */  lui        $v1, %hi(gGameAudioList)
    /* 6CE90 8007C690 30C7638C */  lw         $v1, %lo(gGameAudioList)($v1)
    /* 6CE94 8007C694 00000000 */  nop
    /* 6CE98 8007C698 10006010 */  beqz       $v1, .L8007C6DC
    /* 6CE9C 8007C69C 00000000 */   nop
    /* 6CEA0 8007C6A0 0400628C */  lw         $v0, 0x4($v1)
    /* 6CEA4 8007C6A4 00000000 */  nop
    /* 6CEA8 8007C6A8 0C004018 */  blez       $v0, .L8007C6DC
    /* 6CEAC 8007C6AC 21200000 */   addu      $a0, $zero, $zero
    /* 6CEB0 8007C6B0 FFFF0524 */  addiu      $a1, $zero, -0x1
    /* 6CEB4 8007C6B4 25006324 */  addiu      $v1, $v1, 0x25
  .L8007C6B8:
    /* 6CEB8 8007C6B8 000065A0 */  sb         $a1, 0x0($v1)
    /* 6CEBC 8007C6BC 1480023C */  lui        $v0, %hi(gGameAudioList)
    /* 6CEC0 8007C6C0 30C7428C */  lw         $v0, %lo(gGameAudioList)($v0)
    /* 6CEC4 8007C6C4 F7FF60A4 */  sh         $zero, -0x9($v1)
    /* 6CEC8 8007C6C8 0400428C */  lw         $v0, 0x4($v0)
    /* 6CECC 8007C6CC 01008424 */  addiu      $a0, $a0, 0x1
    /* 6CED0 8007C6D0 2A108200 */  slt        $v0, $a0, $v0
    /* 6CED4 8007C6D4 F8FF4014 */  bnez       $v0, .L8007C6B8
    /* 6CED8 8007C6D8 18006324 */   addiu     $v1, $v1, 0x18
  .L8007C6DC:
    /* 6CEDC 8007C6DC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 6CEE0 8007C6E0 1800B28F */  lw         $s2, 0x18($sp)
    /* 6CEE4 8007C6E4 1400B18F */  lw         $s1, 0x14($sp)
    /* 6CEE8 8007C6E8 1000B08F */  lw         $s0, 0x10($sp)
    /* 6CEEC 8007C6EC 0800E003 */  jr         $ra
    /* 6CEF0 8007C6F0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AudioTrk_Reset__Fv
