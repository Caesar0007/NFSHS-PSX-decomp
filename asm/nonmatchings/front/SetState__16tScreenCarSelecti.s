.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching SetState__16tScreenCarSelecti, 0x284

glabel SetState__16tScreenCarSelecti
    /* 2BD9C 8003B59C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 2BDA0 8003B5A0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 2BDA4 8003B5A4 21808000 */  addu       $s0, $a0, $zero
    /* 2BDA8 8003B5A8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 2BDAC 8003B5AC 2188A000 */  addu       $s1, $a1, $zero
    /* 2BDB0 8003B5B0 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 2BDB4 8003B5B4 1800B2AF */  sw         $s2, 0x18($sp)
    /* 2BDB8 8003B5B8 1C010286 */  lh         $v0, 0x11C($s0)
    /* 2BDBC 8003B5BC 1C011296 */  lhu        $s2, 0x11C($s0)
    /* 2BDC0 8003B5C0 38002212 */  beq        $s1, $v0, .L8003B6A4
    /* 2BDC4 8003B5C4 FEFF4226 */   addiu     $v0, $s2, -0x2
    /* 2BDC8 8003B5C8 FFFF4230 */  andi       $v0, $v0, 0xFFFF
    /* 2BDCC 8003B5CC 0200422C */  sltiu      $v0, $v0, 0x2
    /* 2BDD0 8003B5D0 0A004010 */  beqz       $v0, .L8003B5FC
    /* 2BDD4 8003B5D4 1C0111A6 */   sh        $s1, 0x11C($s0)
    /* 2BDD8 8003B5D8 96DB000C */  jal        TurnOff__10tVideoWall
    /* 2BDDC 8003B5DC 04030426 */   addiu     $a0, $s0, 0x304
    /* 2BDE0 8003B5E0 21200002 */  addu       $a0, $s0, $zero
    /* 2BDE4 8003B5E4 21280000 */  addu       $a1, $zero, $zero
    /* 2BDE8 8003B5E8 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2BDEC 8003B5EC 2130A000 */   addu      $a2, $a1, $zero
    /* 2BDF0 8003B5F0 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 2BDF4 8003B5F4 1E0102A6 */  sh         $v0, 0x11E($s0)
    /* 2BDF8 8003B5F8 200102A6 */  sh         $v0, 0x120($s0)
  .L8003B5FC:
    /* 2BDFC 8003B5FC 21300000 */  addu       $a2, $zero, $zero
    /* 2BE00 8003B600 0580023C */  lui        $v0, %hi(D_80051FA4)
    /* 2BE04 8003B604 A41F4824 */  addiu      $t0, $v0, %lo(D_80051FA4)
    /* 2BE08 8003B608 80381100 */  sll        $a3, $s1, 2
    /* 2BE0C 8003B60C FFFF0924 */  addiu      $t1, $zero, -0x1
    /* 2BE10 8003B610 00140600 */  sll        $v0, $a2, 16
  .L8003B614:
    /* 2BE14 8003B614 031C0200 */  sra        $v1, $v0, 16
    /* 2BE18 8003B618 80100300 */  sll        $v0, $v1, 2
    /* 2BE1C 8003B61C 21280202 */  addu       $a1, $s0, $v0
    /* 2BE20 8003B620 0C01A48C */  lw         $a0, 0x10C($a1)
    /* 2BE24 8003B624 00000000 */  nop
    /* 2BE28 8003B628 09008010 */  beqz       $a0, .L8003B650
    /* 2BE2C 8003B62C 21106700 */   addu      $v0, $v1, $a3
    /* 2BE30 8003B630 21104800 */  addu       $v0, $v0, $t0
    /* 2BE34 8003B634 16008384 */  lh         $v1, 0x16($a0)
    /* 2BE38 8003B638 00004280 */  lb         $v0, 0x0($v0)
    /* 2BE3C 8003B63C 00000000 */  nop
    /* 2BE40 8003B640 12006210 */  beq        $v1, $v0, .L8003B68C
    /* 2BE44 8003B644 0100C224 */   addiu     $v0, $a2, 0x1
    /* 2BE48 8003B648 A3ED0008 */  j          .L8003B68C
    /* 2BE4C 8003B64C 140089A4 */   sh        $t1, 0x14($a0)
  .L8003B650:
    /* 2BE50 8003B650 21104800 */  addu       $v0, $v0, $t0
    /* 2BE54 8003B654 00004380 */  lb         $v1, 0x0($v0)
    /* 2BE58 8003B658 00000000 */  nop
    /* 2BE5C 8003B65C 0A006004 */  bltz       $v1, .L8003B688
    /* 2BE60 8003B660 40100300 */   sll       $v0, $v1, 1
    /* 2BE64 8003B664 21104300 */  addu       $v0, $v0, $v1
    /* 2BE68 8003B668 C0100200 */  sll        $v0, $v0, 3
    /* 2BE6C 8003B66C 64004224 */  addiu      $v0, $v0, 0x64
    /* 2BE70 8003B670 21100202 */  addu       $v0, $s0, $v0
    /* 2BE74 8003B674 0C01A2AC */  sw         $v0, 0x10C($a1)
    /* 2BE78 8003B678 100040A4 */  sh         $zero, 0x10($v0)
    /* 2BE7C 8003B67C 0C01A38C */  lw         $v1, 0x10C($a1)
    /* 2BE80 8003B680 01000224 */  addiu      $v0, $zero, 0x1
    /* 2BE84 8003B684 140062A4 */  sh         $v0, 0x14($v1)
  .L8003B688:
    /* 2BE88 8003B688 0100C224 */  addiu      $v0, $a2, 0x1
  .L8003B68C:
    /* 2BE8C 8003B68C 21304000 */  addu       $a2, $v0, $zero
    /* 2BE90 8003B690 00140200 */  sll        $v0, $v0, 16
    /* 2BE94 8003B694 03140200 */  sra        $v0, $v0, 16
    /* 2BE98 8003B698 04004228 */  slti       $v0, $v0, 0x4
    /* 2BE9C 8003B69C DDFF4014 */  bnez       $v0, .L8003B614
    /* 2BEA0 8003B6A0 00140600 */   sll       $v0, $a2, 16
  .L8003B6A4:
    /* 2BEA4 8003B6A4 02000224 */  addiu      $v0, $zero, 0x2
    /* 2BEA8 8003B6A8 0B002212 */  beq        $s1, $v0, .L8003B6D8
    /* 2BEAC 8003B6AC 0300222A */   slti      $v0, $s1, 0x3
    /* 2BEB0 8003B6B0 05004010 */  beqz       $v0, .L8003B6C8
    /* 2BEB4 8003B6B4 0700222A */   slti      $v0, $s1, 0x7
    /* 2BEB8 8003B6B8 08002012 */  beqz       $s1, .L8003B6DC
    /* 2BEBC 8003B6BC FBFF2226 */   addiu     $v0, $s1, -0x5
    /* 2BEC0 8003B6C0 02EE0008 */  j          .L8003B808
    /* 2BEC4 8003B6C4 00000000 */   nop
  .L8003B6C8:
    /* 2BEC8 8003B6C8 4F004010 */  beqz       $v0, .L8003B808
    /* 2BECC 8003B6CC 0500222A */   slti      $v0, $s1, 0x5
    /* 2BED0 8003B6D0 4D004014 */  bnez       $v0, .L8003B808
    /* 2BED4 8003B6D4 00000000 */   nop
  .L8003B6D8:
    /* 2BED8 8003B6D8 FBFF2226 */  addiu      $v0, $s1, -0x5
  .L8003B6DC:
    /* 2BEDC 8003B6DC 0200422C */  sltiu      $v0, $v0, 0x2
    /* 2BEE0 8003B6E0 0580033C */  lui        $v1, %hi(gStopCommentaryNow)
    /* 2BEE4 8003B6E4 880302AE */  sw         $v0, 0x388($s0)
    /* 2BEE8 8003B6E8 1480023C */  lui        $v0, %hi(ticks)
    /* 2BEEC 8003B6EC ACDC448C */  lw         $a0, %lo(ticks)($v0)
    /* 2BEF0 8003B6F0 ACDC458C */  lw         $a1, %lo(ticks)($v0)
    /* 2BEF4 8003B6F4 8803068E */  lw         $a2, 0x388($s0)
    /* 2BEF8 8003B6F8 01000224 */  addiu      $v0, $zero, 0x1
    /* 2BEFC 8003B6FC C81462AC */  sw         $v0, %lo(gStopCommentaryNow)($v1)
    /* 2BF00 8003B700 940300AE */  sw         $zero, 0x394($s0)
    /* 2BF04 8003B704 900304AE */  sw         $a0, 0x390($s0)
    /* 2BF08 8003B708 2600C010 */  beqz       $a2, .L8003B7A4
    /* 2BF0C 8003B70C 8C0305AE */   sw        $a1, 0x38C($s0)
    /* 2BF10 8003B710 81EB010C */  jal        AudioMus_StopSong__Fi
    /* 2BF14 8003B714 E8030424 */   addiu     $a0, $zero, 0x3E8
    /* 2BF18 8003B718 21300000 */  addu       $a2, $zero, $zero
    /* 2BF1C 8003B71C 0580023C */  lui        $v0, %hi(D_80051E78)
    /* 2BF20 8003B720 781E4224 */  addiu      $v0, $v0, %lo(D_80051E78)
    /* 2BF24 8003B724 9C03038E */  lw         $v1, 0x39C($s0)
    /* 2BF28 8003B728 21384000 */  addu       $a3, $v0, $zero
    /* 2BF2C 8003B72C 980300AE */  sw         $zero, 0x398($s0)
    /* 2BF30 8003B730 FF036330 */  andi       $v1, $v1, 0x3FF
    /* 2BF34 8003B734 2400E3AC */  sw         $v1, 0x24($a3)
  .L8003B738:
    /* 2BF38 8003B738 00240600 */  sll        $a0, $a2, 16
    /* 2BF3C 8003B73C 83230400 */  sra        $a0, $a0, 14
    /* 2BF40 8003B740 21208700 */  addu       $a0, $a0, $a3
    /* 2BF44 8003B744 0100C324 */  addiu      $v1, $a2, 0x1
    /* 2BF48 8003B748 21306000 */  addu       $a2, $v1, $zero
    /* 2BF4C 8003B74C 001C0300 */  sll        $v1, $v1, 16
    /* 2BF50 8003B750 031C0300 */  sra        $v1, $v1, 16
    /* 2BF54 8003B754 2800858C */  lw         $a1, 0x28($a0)
    /* 2BF58 8003B758 1400828C */  lw         $v0, 0x14($a0)
    /* 2BF5C 8003B75C 05006328 */  slti       $v1, $v1, 0x5
    /* 2BF60 8003B760 2328A200 */  subu       $a1, $a1, $v0
    /* 2BF64 8003B764 23104500 */  subu       $v0, $v0, $a1
    /* 2BF68 8003B768 F3FF6014 */  bnez       $v1, .L8003B738
    /* 2BF6C 8003B76C 000082AC */   sw        $v0, 0x0($a0)
    /* 2BF70 8003B770 21200002 */  addu       $a0, $s0, $zero
    /* 2BF74 8003B774 02000524 */  addiu      $a1, $zero, 0x2
    /* 2BF78 8003B778 21300000 */  addu       $a2, $zero, $zero
    /* 2BF7C 8003B77C 0580073C */  lui        $a3, %hi(D_80052C18)
    /* 2BF80 8003B780 182CE324 */  addiu      $v1, $a3, %lo(D_80052C18)
    /* 2BF84 8003B784 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 2BF88 8003B788 0C0062AC */  sw         $v0, 0xC($v1)
    /* 2BF8C 8003B78C 080062AC */  sw         $v0, 0x8($v1)
    /* 2BF90 8003B790 040062AC */  sw         $v0, 0x4($v1)
    /* 2BF94 8003B794 019A000C */  jal        TransitionOff__7tScreen22tScreen_TransitionTypeP5tMenu
    /* 2BF98 8003B798 182CE2AC */   sw        $v0, %lo(D_80052C18)($a3)
    /* 2BF9C 8003B79C 02EE0008 */  j          .L8003B808
    /* 2BFA0 8003B7A0 00000000 */   nop
  .L8003B7A4:
    /* 2BFA4 8003B7A4 21300000 */  addu       $a2, $zero, $zero
  .L8003B7A8:
    /* 2BFA8 8003B7A8 00140600 */  sll        $v0, $a2, 16
    /* 2BFAC 8003B7AC 0100C424 */  addiu      $a0, $a2, 0x1
    /* 2BFB0 8003B7B0 21308000 */  addu       $a2, $a0, $zero
    /* 2BFB4 8003B7B4 03140200 */  sra        $v0, $v0, 16
    /* 2BFB8 8003B7B8 40180200 */  sll        $v1, $v0, 1
    /* 2BFBC 8003B7BC 21186200 */  addu       $v1, $v1, $v0
    /* 2BFC0 8003B7C0 00190300 */  sll        $v1, $v1, 4
    /* 2BFC4 8003B7C4 21180302 */  addu       $v1, $s0, $v1
    /* 2BFC8 8003B7C8 00240400 */  sll        $a0, $a0, 16
    /* 2BFCC 8003B7CC 03240400 */  sra        $a0, $a0, 16
    /* 2BFD0 8003B7D0 0A008428 */  slti       $a0, $a0, 0xA
    /* 2BFD4 8003B7D4 240160AC */  sw         $zero, 0x124($v1)
    /* 2BFD8 8003B7D8 F3FF8014 */  bnez       $a0, .L8003B7A8
    /* 2BFDC 8003B7DC 280160A4 */   sh        $zero, 0x128($v1)
    /* 2BFE0 8003B7E0 00141200 */  sll        $v0, $s2, 16
    /* 2BFE4 8003B7E4 03140200 */  sra        $v0, $v0, 16
    /* 2BFE8 8003B7E8 01000324 */  addiu      $v1, $zero, 0x1
    /* 2BFEC 8003B7EC 04004310 */  beq        $v0, $v1, .L8003B800
    /* 2BFF0 8003B7F0 21200002 */   addu      $a0, $s0, $zero
    /* 2BFF4 8003B7F4 02000524 */  addiu      $a1, $zero, 0x2
    /* 2BFF8 8003B7F8 099A000C */  jal        TransitionOn__7tScreen22tScreen_TransitionTypeP5tMenu
    /* 2BFFC 8003B7FC 21300000 */   addu      $a2, $zero, $zero
  .L8003B800:
    /* 2C000 8003B800 BEDB000C */  jal        TurnOn__10tVideoWall
    /* 2C004 8003B804 04030426 */   addiu     $a0, $s0, 0x304
  .L8003B808:
    /* 2C008 8003B808 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 2C00C 8003B80C 1800B28F */  lw         $s2, 0x18($sp)
    /* 2C010 8003B810 1400B18F */  lw         $s1, 0x14($sp)
    /* 2C014 8003B814 1000B08F */  lw         $s0, 0x10($sp)
    /* 2C018 8003B818 0800E003 */  jr         $ra
    /* 2C01C 8003B81C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel SetState__16tScreenCarSelecti
