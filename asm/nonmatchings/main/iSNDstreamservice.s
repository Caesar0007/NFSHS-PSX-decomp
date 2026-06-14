.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching iSNDstreamservice, 0x168

glabel iSNDstreamservice
    /* D9D90 800E9590 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* D9D94 800E9594 2400BFAF */  sw         $ra, 0x24($sp)
    /* D9D98 800E9598 2000B4AF */  sw         $s4, 0x20($sp)
    /* D9D9C 800E959C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* D9DA0 800E95A0 1800B2AF */  sw         $s2, 0x18($sp)
    /* D9DA4 800E95A4 1400B1AF */  sw         $s1, 0x14($sp)
    /* D9DA8 800E95A8 4DA9030C */  jal        iSNDenteraudio
    /* D9DAC 800E95AC 1000B0AF */   sw        $s0, 0x10($sp)
    /* D9DB0 800E95B0 21A00000 */  addu       $s4, $zero, $zero
    /* D9DB4 800E95B4 1480023C */  lui        $v0, %hi(sndss)
    /* D9DB8 800E95B8 80EA5324 */  addiu      $s3, $v0, %lo(sndss)
  .L800E95BC:
    /* D9DBC 800E95BC 0000708E */  lw         $s0, 0x0($s3)
    /* D9DC0 800E95C0 00000000 */  nop
    /* D9DC4 800E95C4 3F000012 */  beqz       $s0, .L800E96C4
    /* D9DC8 800E95C8 00000000 */   nop
    /* D9DCC 800E95CC 16000292 */  lbu        $v0, 0x16($s0)
    /* D9DD0 800E95D0 00000000 */  nop
    /* D9DD4 800E95D4 3B004010 */  beqz       $v0, .L800E96C4
    /* D9DD8 800E95D8 00000000 */   nop
    /* D9DDC 800E95DC 14000292 */  lbu        $v0, 0x14($s0)
    /* D9DE0 800E95E0 02000324 */  addiu      $v1, $zero, 0x2
    /* D9DE4 800E95E4 00160200 */  sll        $v0, $v0, 24
    /* D9DE8 800E95E8 03160200 */  sra        $v0, $v0, 24
    /* D9DEC 800E95EC 16004314 */  bne        $v0, $v1, .L800E9648
    /* D9DF0 800E95F0 00000000 */   nop
    /* D9DF4 800E95F4 0C00048E */  lw         $a0, 0xC($s0)
    /* D9DF8 800E95F8 BB0B040C */  jal        SNDPKTPLAY_framesoutstanding
    /* D9DFC 800E95FC 00000000 */   nop
    /* D9E00 800E9600 3000401C */  bgtz       $v0, .L800E96C4
    /* D9E04 800E9604 00000000 */   nop
    /* D9E08 800E9608 2300088A */  lwl        $t0, 0x23($s0)
    /* D9E0C 800E960C 2000089A */  lwr        $t0, 0x20($s0)
    /* D9E10 800E9610 00000000 */  nop
    /* D9E14 800E9614 1F0008AA */  swl        $t0, 0x1F($s0)
    /* D9E18 800E9618 1C0008BA */  swr        $t0, 0x1C($s0)
    /* D9E1C 800E961C 0C00048E */  lw         $a0, 0xC($s0)
    /* D9E20 800E9620 460C040C */  jal        SNDPKTPLAY_stop
    /* D9E24 800E9624 00000000 */   nop
    /* D9E28 800E9628 1C000526 */  addiu      $a1, $s0, 0x1C
    /* D9E2C 800E962C 24000626 */  addiu      $a2, $s0, 0x24
    /* D9E30 800E9630 0C00048E */  lw         $a0, 0xC($s0)
    /* D9E34 800E9634 840A040C */  jal        SNDPKTPLAY_start
    /* D9E38 800E9638 4C000726 */   addiu     $a3, $s0, 0x4C
    /* D9E3C 800E963C 080002AE */  sw         $v0, 0x8($s0)
    /* D9E40 800E9640 01000224 */  addiu      $v0, $zero, 0x1
    /* D9E44 800E9644 140002A2 */  sb         $v0, 0x14($s0)
  .L800E9648:
    /* D9E48 800E9648 C6A4030C */  jal        iSNDstreamisheld
    /* D9E4C 800E964C 21200002 */   addu      $a0, $s0, $zero
    /* D9E50 800E9650 1C004014 */  bnez       $v0, .L800E96C4
    /* D9E54 800E9654 00000000 */   nop
    /* D9E58 800E9658 14000292 */  lbu        $v0, 0x14($s0)
    /* D9E5C 800E965C 01000324 */  addiu      $v1, $zero, 0x1
    /* D9E60 800E9660 00160200 */  sll        $v0, $v0, 24
    /* D9E64 800E9664 03160200 */  sra        $v0, $v0, 24
    /* D9E68 800E9668 09004314 */  bne        $v0, $v1, .L800E9690
    /* D9E6C 800E966C 0A001124 */   addiu     $s1, $zero, 0xA
    /* D9E70 800E9670 0C00048E */  lw         $a0, 0xC($s0)
    /* D9E74 800E9674 9C0B040C */  jal        SNDPKTPLAY_submitspace
    /* D9E78 800E9678 00000000 */   nop
    /* D9E7C 800E967C 21884000 */  addu       $s1, $v0, $zero
    /* D9E80 800E9680 10002012 */  beqz       $s1, .L800E96C4
    /* D9E84 800E9684 00000000 */   nop
    /* D9E88 800E9688 A5A50308 */  j          .L800E9694
    /* D9E8C 800E968C 21900000 */   addu      $s2, $zero, $zero
  .L800E9690:
    /* D9E90 800E9690 21900000 */  addu       $s2, $zero, $zero
  .L800E9694:
    /* D9E94 800E9694 0400048E */  lw         $a0, 0x4($s0)
    /* D9E98 800E9698 6BF6030C */  jal        STREAM_get
    /* D9E9C 800E969C FFFF3126 */   addiu     $s1, $s1, -0x1
    /* D9EA0 800E96A0 04004010 */  beqz       $v0, .L800E96B4
    /* D9EA4 800E96A4 21200002 */   addu      $a0, $s0, $zero
    /* D9EA8 800E96A8 9CA4030C */  jal        iSNDstreamparsechunk
    /* D9EAC 800E96AC 21284000 */   addu      $a1, $v0, $zero
    /* D9EB0 800E96B0 21904000 */  addu       $s2, $v0, $zero
  .L800E96B4:
    /* D9EB4 800E96B4 03004012 */  beqz       $s2, .L800E96C4
    /* D9EB8 800E96B8 00000000 */   nop
    /* D9EBC 800E96BC F5FF201E */  bgtz       $s1, .L800E9694
    /* D9EC0 800E96C0 00000000 */   nop
  .L800E96C4:
    /* D9EC4 800E96C4 01009426 */  addiu      $s4, $s4, 0x1
    /* D9EC8 800E96C8 BCFF801A */  blez       $s4, .L800E95BC
    /* D9ECC 800E96CC 04007326 */   addiu     $s3, $s3, 0x4
    /* D9ED0 800E96D0 5BA9030C */  jal        iSNDleaveaudio
    /* D9ED4 800E96D4 00000000 */   nop
    /* D9ED8 800E96D8 2400BF8F */  lw         $ra, 0x24($sp)
    /* D9EDC 800E96DC 2000B48F */  lw         $s4, 0x20($sp)
    /* D9EE0 800E96E0 1C00B38F */  lw         $s3, 0x1C($sp)
    /* D9EE4 800E96E4 1800B28F */  lw         $s2, 0x18($sp)
    /* D9EE8 800E96E8 1400B18F */  lw         $s1, 0x14($sp)
    /* D9EEC 800E96EC 1000B08F */  lw         $s0, 0x10($sp)
    /* D9EF0 800E96F0 0800E003 */  jr         $ra
    /* D9EF4 800E96F4 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel iSNDstreamservice
