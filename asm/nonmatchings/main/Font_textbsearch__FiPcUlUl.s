.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Font_textbsearch__FiPcUlUl, 0xA0

glabel Font_textbsearch__FiPcUlUl
    /* BBEA0 800CB6A0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* BBEA4 800CB6A4 2000B4AF */  sw         $s4, 0x20($sp)
    /* BBEA8 800CB6A8 21A08000 */  addu       $s4, $a0, $zero
    /* BBEAC 800CB6AC 1800B2AF */  sw         $s2, 0x18($sp)
    /* BBEB0 800CB6B0 2190A000 */  addu       $s2, $a1, $zero
    /* BBEB4 800CB6B4 1400B1AF */  sw         $s1, 0x14($sp)
    /* BBEB8 800CB6B8 2188C000 */  addu       $s1, $a2, $zero
    /* BBEBC 800CB6BC 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* BBEC0 800CB6C0 2198E000 */  addu       $s3, $a3, $zero
    /* BBEC4 800CB6C4 2400BFAF */  sw         $ra, 0x24($sp)
    /* BBEC8 800CB6C8 14002012 */  beqz       $s1, .L800CB71C
    /* BBECC 800CB6CC 1000B0AF */   sw        $s0, 0x10($sp)
    /* BBED0 800CB6D0 43101100 */  sra        $v0, $s1, 1
  .L800CB6D4:
    /* BBED4 800CB6D4 18005300 */  mult       $v0, $s3
    /* BBED8 800CB6D8 02000524 */  addiu      $a1, $zero, 0x2
    /* BBEDC 800CB6DC 12180000 */  mflo       $v1
    /* BBEE0 800CB6E0 21804302 */  addu       $s0, $s2, $v1
    /* BBEE4 800CB6E4 23CC030C */  jal        geti
    /* BBEE8 800CB6E8 21200002 */   addu      $a0, $s0, $zero
    /* BBEEC 800CB6EC 23108202 */  subu       $v0, $s4, $v0
    /* BBEF0 800CB6F0 03004014 */  bnez       $v0, .L800CB700
    /* BBEF4 800CB6F4 00000000 */   nop
    /* BBEF8 800CB6F8 C82D0308 */  j          .L800CB720
    /* BBEFC 800CB6FC 21100002 */   addu      $v0, $s0, $zero
  .L800CB700:
    /* BBF00 800CB700 03004018 */  blez       $v0, .L800CB710
    /* BBF04 800CB704 00000000 */   nop
    /* BBF08 800CB708 21901302 */  addu       $s2, $s0, $s3
    /* BBF0C 800CB70C FFFF3126 */  addiu      $s1, $s1, -0x1
  .L800CB710:
    /* BBF10 800CB710 43881100 */  sra        $s1, $s1, 1
    /* BBF14 800CB714 EFFF2016 */  bnez       $s1, .L800CB6D4
    /* BBF18 800CB718 43101100 */   sra       $v0, $s1, 1
  .L800CB71C:
    /* BBF1C 800CB71C 21100000 */  addu       $v0, $zero, $zero
  .L800CB720:
    /* BBF20 800CB720 2400BF8F */  lw         $ra, 0x24($sp)
    /* BBF24 800CB724 2000B48F */  lw         $s4, 0x20($sp)
    /* BBF28 800CB728 1C00B38F */  lw         $s3, 0x1C($sp)
    /* BBF2C 800CB72C 1800B28F */  lw         $s2, 0x18($sp)
    /* BBF30 800CB730 1400B18F */  lw         $s1, 0x14($sp)
    /* BBF34 800CB734 1000B08F */  lw         $s0, 0x10($sp)
    /* BBF38 800CB738 0800E003 */  jr         $ra
    /* BBF3C 800CB73C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel Font_textbsearch__FiPcUlUl
