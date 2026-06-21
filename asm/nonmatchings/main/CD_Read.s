.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching CD_Read, 0x28C

glabel CD_Read
    /* EAE78 800FA678 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* EAE7C 800FA67C 2400B3AF */  sw         $s3, 0x24($sp)
    /* EAE80 800FA680 2198E000 */  addu       $s3, $a3, $zero
    /* EAE84 800FA684 1480073C */  lui        $a3, %hi(Cdinfo)
    /* EAE88 800FA688 C46CE324 */  addiu      $v1, $a3, %lo(Cdinfo)
    /* EAE8C 800FA68C 80200400 */  sll        $a0, $a0, 2
    /* EAE90 800FA690 2C00BFAF */  sw         $ra, 0x2C($sp)
    /* EAE94 800FA694 2800B4AF */  sw         $s4, 0x28($sp)
    /* EAE98 800FA698 2000B2AF */  sw         $s2, 0x20($sp)
    /* EAE9C 800FA69C 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* EAEA0 800FA6A0 1800B0AF */  sw         $s0, 0x18($sp)
    /* EAEA4 800FA6A4 3400628C */  lw         $v0, 0x34($v1)
    /* EAEA8 800FA6A8 FCFF8424 */  addiu      $a0, $a0, -0x4
    /* EAEAC 800FA6AC 21204400 */  addu       $a0, $v0, $a0
    /* EAEB0 800FA6B0 C46CE28C */  lw         $v0, %lo(Cdinfo)($a3)
    /* EAEB4 800FA6B4 00000000 */  nop
    /* EAEB8 800FA6B8 03004230 */  andi       $v0, $v0, 0x3
    /* EAEBC 800FA6BC 03004010 */  beqz       $v0, .L800FA6CC
    /* EAEC0 800FA6C0 20007024 */   addiu     $s0, $v1, 0x20
    /* EAEC4 800FA6C4 39EA0308 */  j          .L800FA8E4
    /* EAEC8 800FA6C8 21100000 */   addu      $v0, $zero, $zero
  .L800FA6CC:
    /* EAECC 800FA6CC 0000828C */  lw         $v0, 0x0($a0)
    /* EAED0 800FA6D0 00000000 */  nop
    /* EAED4 800FA6D4 1000428C */  lw         $v0, 0x10($v0)
    /* EAED8 800FA6D8 00000000 */  nop
    /* EAEDC 800FA6DC 23184600 */  subu       $v1, $v0, $a2
    /* EAEE0 800FA6E0 2A107300 */  slt        $v0, $v1, $s3
    /* EAEE4 800FA6E4 02004010 */  beqz       $v0, .L800FA6F0
    /* EAEE8 800FA6E8 00000000 */   nop
    /* EAEEC 800FA6EC 21986000 */  addu       $s3, $v1, $zero
  .L800FA6F0:
    /* EAEF0 800FA6F0 0200C104 */  bgez       $a2, .L800FA6FC
    /* EAEF4 800FA6F4 2110C000 */   addu      $v0, $a2, $zero
    /* EAEF8 800FA6F8 FF07C224 */  addiu      $v0, $a2, 0x7FF
  .L800FA6FC:
    /* EAEFC 800FA6FC C3120200 */  sra        $v0, $v0, 11
    /* EAF00 800FA700 C0120200 */  sll        $v0, $v0, 11
    /* EAF04 800FA704 2310C200 */  subu       $v0, $a2, $v0
    /* EAF08 800FA708 080002AE */  sw         $v0, 0x8($s0)
    /* EAF0C 800FA70C 04004014 */  bnez       $v0, .L800FA720
    /* EAF10 800FA710 0C0005AE */   sw        $a1, 0xC($s0)
    /* EAF14 800FA714 0008622A */  slti       $v0, $s3, 0x800
    /* EAF18 800FA718 05004010 */  beqz       $v0, .L800FA730
    /* EAF1C 800FA71C 00000000 */   nop
  .L800FA720:
    /* EAF20 800FA720 C46CE28C */  lw         $v0, %lo(Cdinfo)($a3)
    /* EAF24 800FA724 00000000 */  nop
    /* EAF28 800FA728 08004234 */  ori        $v0, $v0, 0x8
    /* EAF2C 800FA72C C46CE2AC */  sw         $v0, %lo(Cdinfo)($a3)
  .L800FA730:
    /* EAF30 800FA730 0800038E */  lw         $v1, 0x8($s0)
    /* EAF34 800FA734 00000000 */  nop
    /* EAF38 800FA738 21107300 */  addu       $v0, $v1, $s3
    /* EAF3C 800FA73C 01084228 */  slti       $v0, $v0, 0x801
    /* EAF40 800FA740 03004014 */  bnez       $v0, .L800FA750
    /* EAF44 800FA744 00080224 */   addiu     $v0, $zero, 0x800
    /* EAF48 800FA748 D5E90308 */  j          .L800FA754
    /* EAF4C 800FA74C 23104300 */   subu      $v0, $v0, $v1
  .L800FA750:
    /* EAF50 800FA750 21106002 */  addu       $v0, $s3, $zero
  .L800FA754:
    /* EAF54 800FA754 000002AE */  sw         $v0, 0x0($s0)
    /* EAF58 800FA758 23106202 */  subu       $v0, $s3, $v0
    /* EAF5C 800FA75C 1480123C */  lui        $s2, %hi(Cdinfo)
    /* EAF60 800FA760 040002AE */  sw         $v0, 0x4($s0)
    /* EAF64 800FA764 0000838C */  lw         $v1, 0x0($a0)
    /* EAF68 800FA768 0200C104 */  bgez       $a2, .L800FA774
    /* EAF6C 800FA76C C46C5126 */   addiu     $s1, $s2, %lo(Cdinfo)
    /* EAF70 800FA770 FF07C624 */  addiu      $a2, $a2, 0x7FF
  .L800FA774:
    /* EAF74 800FA774 1080023C */  lui        $v0, %hi(CD_timerfunc)
    /* EAF78 800FA778 449C5424 */  addiu      $s4, $v0, %lo(CD_timerfunc)
    /* EAF7C 800FA77C 21208002 */  addu       $a0, $s4, $zero
    /* EAF80 800FA780 0C00638C */  lw         $v1, 0xC($v1)
    /* EAF84 800FA784 C3120600 */  sra        $v0, $a2, 11
    /* EAF88 800FA788 1C0020AE */  sw         $zero, 0x1C($s1)
    /* EAF8C 800FA78C 21186200 */  addu       $v1, $v1, $v0
    /* EAF90 800FA790 140023AE */  sw         $v1, 0x14($s1)
    /* EAF94 800FA794 1480033C */  lui        $v1, %hi(timerhz)
    /* EAF98 800FA798 C46C428E */  lw         $v0, %lo(Cdinfo)($s2)
    /* EAF9C 800FA79C C4DC638C */  lw         $v1, %lo(timerhz)($v1)
    /* EAFA0 800FA7A0 02004234 */  ori        $v0, $v0, 0x2
    /* EAFA4 800FA7A4 C46C42AE */  sw         $v0, %lo(Cdinfo)($s2)
    /* EAFA8 800FA7A8 40100300 */  sll        $v0, $v1, 1
    /* EAFAC 800FA7AC 21104300 */  addu       $v0, $v0, $v1
    /* EAFB0 800FA7B0 40100200 */  sll        $v0, $v0, 1
    /* EAFB4 800FA7B4 FAAB030C */  jal        addtimer
    /* EAFB8 800FA7B8 180022AE */   sw        $v0, 0x18($s1)
    /* EAFBC 800FA7BC 0C00238E */  lw         $v1, 0xC($s1)
    /* EAFC0 800FA7C0 1400228E */  lw         $v0, 0x14($s1)
    /* EAFC4 800FA7C4 00000000 */  nop
    /* EAFC8 800FA7C8 46006214 */  bne        $v1, $v0, .L800FA8E4
    /* EAFCC 800FA7CC 21106002 */   addu      $v0, $s3, $zero
    /* EAFD0 800FA7D0 C46C428E */  lw         $v0, %lo(Cdinfo)($s2)
    /* EAFD4 800FA7D4 00000000 */  nop
    /* EAFD8 800FA7D8 10004230 */  andi       $v0, $v0, 0x10
    /* EAFDC 800FA7DC 40004010 */  beqz       $v0, .L800FA8E0
    /* EAFE0 800FA7E0 1480023C */   lui       $v0, %hi(g_currentthread)
    /* EAFE4 800FA7E4 5CDD438C */  lw         $v1, %lo(g_currentthread)($v0)
    /* EAFE8 800FA7E8 02000224 */  addiu      $v0, $zero, 0x2
    /* EAFEC 800FA7EC 3D006214 */  bne        $v1, $v0, .L800FA8E4
    /* EAFF0 800FA7F0 21106002 */   addu      $v0, $s3, $zero
    /* EAFF4 800FA7F4 3C002226 */  addiu      $v0, $s1, 0x3C
    /* EAFF8 800FA7F8 0800048E */  lw         $a0, 0x8($s0)
    /* EAFFC 800FA7FC 0C00058E */  lw         $a1, 0xC($s0)
    /* EB000 800FA800 0000068E */  lw         $a2, 0x0($s0)
    /* EB004 800FA804 B798030C */  jal        blockmove
    /* EB008 800FA808 21208200 */   addu      $a0, $a0, $v0
    /* EB00C 800FA80C 0400028E */  lw         $v0, 0x4($s0)
    /* EB010 800FA810 00000000 */  nop
    /* EB014 800FA814 1E004018 */  blez       $v0, .L800FA890
    /* EB018 800FA818 21208002 */   addu      $a0, $s4, $zero
    /* EB01C 800FA81C 0C00028E */  lw         $v0, 0xC($s0)
    /* EB020 800FA820 0000038E */  lw         $v1, 0x0($s0)
    /* EB024 800FA824 0400048E */  lw         $a0, 0x4($s0)
    /* EB028 800FA828 080000AE */  sw         $zero, 0x8($s0)
    /* EB02C 800FA82C 21104300 */  addu       $v0, $v0, $v1
    /* EB030 800FA830 0C0002AE */  sw         $v0, 0xC($s0)
    /* EB034 800FA834 00088228 */  slti       $v0, $a0, 0x800
    /* EB038 800FA838 05004010 */  beqz       $v0, .L800FA850
    /* EB03C 800FA83C 00000000 */   nop
    /* EB040 800FA840 C46C428E */  lw         $v0, %lo(Cdinfo)($s2)
    /* EB044 800FA844 000004AE */  sw         $a0, 0x0($s0)
    /* EB048 800FA848 19EA0308 */  j          .L800FA864
    /* EB04C 800FA84C 08004234 */   ori       $v0, $v0, 0x8
  .L800FA850:
    /* EB050 800FA850 00080224 */  addiu      $v0, $zero, 0x800
    /* EB054 800FA854 000002AE */  sw         $v0, 0x0($s0)
    /* EB058 800FA858 C46C428E */  lw         $v0, %lo(Cdinfo)($s2)
    /* EB05C 800FA85C F7FF0324 */  addiu      $v1, $zero, -0x9
    /* EB060 800FA860 24104300 */  and        $v0, $v0, $v1
  .L800FA864:
    /* EB064 800FA864 C46C42AE */  sw         $v0, %lo(Cdinfo)($s2)
    /* EB068 800FA868 1480043C */  lui        $a0, %hi(Cdinfo)
    /* EB06C 800FA86C C46C8424 */  addiu      $a0, $a0, %lo(Cdinfo)
    /* EB070 800FA870 0400028E */  lw         $v0, 0x4($s0)
    /* EB074 800FA874 0000058E */  lw         $a1, 0x0($s0)
    /* EB078 800FA878 1400838C */  lw         $v1, 0x14($a0)
    /* EB07C 800FA87C 23104500 */  subu       $v0, $v0, $a1
    /* EB080 800FA880 01006324 */  addiu      $v1, $v1, 0x1
    /* EB084 800FA884 040002AE */  sw         $v0, 0x4($s0)
    /* EB088 800FA888 38EA0308 */  j          .L800FA8E0
    /* EB08C 800FA88C 140083AC */   sw        $v1, 0x14($a0)
  .L800FA890:
    /* EB090 800FA890 180020AE */  sw         $zero, 0x18($s1)
    /* EB094 800FA894 C46C428E */  lw         $v0, %lo(Cdinfo)($s2)
    /* EB098 800FA898 FDFF0324 */  addiu      $v1, $zero, -0x3
    /* EB09C 800FA89C 24104300 */  and        $v0, $v0, $v1
    /* EB0A0 800FA8A0 C46C42AE */  sw         $v0, %lo(Cdinfo)($s2)
    /* EB0A4 800FA8A4 12AC030C */  jal        deltimer
    /* EB0A8 800FA8A8 00000000 */   nop
    /* EB0AC 800FA8AC 3000228E */  lw         $v0, 0x30($s1)
    /* EB0B0 800FA8B0 00000000 */  nop
    /* EB0B4 800FA8B4 0B004010 */  beqz       $v0, .L800FA8E4
    /* EB0B8 800FA8B8 21106002 */   addu      $v0, $s3, $zero
    /* EB0BC 800FA8BC 24AC030C */  jal        savegp
    /* EB0C0 800FA8C0 1000A427 */   addiu     $a0, $sp, 0x10
    /* EB0C4 800FA8C4 3000228E */  lw         $v0, 0x30($s1)
    /* EB0C8 800FA8C8 00000000 */  nop
    /* EB0CC 800FA8CC 09F84000 */  jalr       $v0
    /* EB0D0 800FA8D0 01000424 */   addiu     $a0, $zero, 0x1
    /* EB0D4 800FA8D4 1000A48F */  lw         $a0, 0x10($sp)
    /* EB0D8 800FA8D8 29AC030C */  jal        restoregp
    /* EB0DC 800FA8DC 00000000 */   nop
  .L800FA8E0:
    /* EB0E0 800FA8E0 21106002 */  addu       $v0, $s3, $zero
  .L800FA8E4:
    /* EB0E4 800FA8E4 2C00BF8F */  lw         $ra, 0x2C($sp)
    /* EB0E8 800FA8E8 2800B48F */  lw         $s4, 0x28($sp)
    /* EB0EC 800FA8EC 2400B38F */  lw         $s3, 0x24($sp)
    /* EB0F0 800FA8F0 2000B28F */  lw         $s2, 0x20($sp)
    /* EB0F4 800FA8F4 1C00B18F */  lw         $s1, 0x1C($sp)
    /* EB0F8 800FA8F8 1800B08F */  lw         $s0, 0x18($sp)
    /* EB0FC 800FA8FC 0800E003 */  jr         $ra
    /* EB100 800FA900 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel CD_Read
