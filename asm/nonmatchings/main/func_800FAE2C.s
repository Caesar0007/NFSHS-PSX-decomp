.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching func_800FAE2C, 0x234

glabel func_800FAE2C
    /* EB62C 800FAE2C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* EB630 800FAE30 1000B0AF */  sw         $s0, 0x10($sp)
    /* EB634 800FAE34 21808000 */  addu       $s0, $a0, $zero
    /* EB638 800FAE38 1800BFAF */  sw         $ra, 0x18($sp)
    /* EB63C 800FAE3C 1400B1AF */  sw         $s1, 0x14($sp)
    /* EB640 800FAE40 0000038E */  lw         $v1, 0x0($s0)
    /* EB644 800FAE44 00000000 */  nop
    /* EB648 800FAE48 2000622C */  sltiu      $v0, $v1, 0x20
    /* EB64C 800FAE4C 7E004010 */  beqz       $v0, .L800FB048
    /* EB650 800FAE50 80100300 */   sll       $v0, $v1, 2
    /* EB654 800FAE54 0580013C */  lui        $at, %hi(jtbl_80057398)
    /* EB658 800FAE58 21082200 */  addu       $at, $at, $v0
    /* EB65C 800FAE5C 9873228C */  lw         $v0, %lo(jtbl_80057398)($at)
    /* EB660 800FAE60 00000000 */  nop
    /* EB664 800FAE64 08004000 */  jr         $v0
    /* EB668 800FAE68 00000000 */   nop
  jlabel .L800FAE6C
    /* EB66C 800FAE6C 1080043C */  lui        $a0, %hi(func_800FABF0)
    /* EB670 800FAE70 F0AB8424 */  addiu      $a0, $a0, %lo(func_800FABF0)
    /* EB674 800FAE74 1480013C */  lui        $at, %hi(D_80147510)
    /* EB678 800FAE78 107520AC */  sw         $zero, %lo(D_80147510)($at)
    /* EB67C 800FAE7C 1480013C */  lui        $at, %hi(D_8014750C)
    /* EB680 800FAE80 0C7520AC */  sw         $zero, %lo(D_8014750C)($at)
    /* EB684 800FAE84 1480013C */  lui        $at, %hi(D_80147508)
    /* EB688 800FAE88 0427040C */  jal        UserFuncOpen
    /* EB68C 800FAE8C 087520AC */   sw        $zero, %lo(D_80147508)($at)
    /* EB690 800FAE90 0A000224 */  addiu      $v0, $zero, 0xA
    /* EB694 800FAE94 12EC0308 */  j          .L800FB048
    /* EB698 800FAE98 000002AE */   sw        $v0, 0x0($s0)
  jlabel .L800FAE9C
    /* EB69C 800FAE9C 1480113C */  lui        $s1, %hi(D_8014751C)
    /* EB6A0 800FAEA0 1C753126 */  addiu      $s1, $s1, %lo(D_8014751C)
    /* EB6A4 800FAEA4 0000238E */  lw         $v1, 0x0($s1)
    /* EB6A8 800FAEA8 00000000 */  nop
    /* EB6AC 800FAEAC 52006010 */  beqz       $v1, .L800FAFF8
    /* EB6B0 800FAEB0 03000224 */   addiu     $v0, $zero, 0x3
    /* EB6B4 800FAEB4 65006214 */  bne        $v1, $v0, .L800FB04C
    /* EB6B8 800FAEB8 01000224 */   addiu     $v0, $zero, 0x1
    /* EB6BC 800FAEBC 0800248E */  lw         $a0, 0x8($s1)
    /* EB6C0 800FAEC0 1480023C */  lui        $v0, %hi(D_80147514)
    /* EB6C4 800FAEC4 1475428C */  lw         $v0, %lo(D_80147514)($v0)
    /* EB6C8 800FAEC8 01000324 */  addiu      $v1, $zero, 0x1
    /* EB6CC 800FAECC 1480013C */  lui        $at, %hi(D_80147510)
    /* EB6D0 800FAED0 107523AC */  sw         $v1, %lo(D_80147510)($at)
    /* EB6D4 800FAED4 04188300 */  sllv       $v1, $v1, $a0
    /* EB6D8 800FAED8 25104300 */  or         $v0, $v0, $v1
    /* EB6DC 800FAEDC 1480013C */  lui        $at, %hi(D_80147514)
    /* EB6E0 800FAEE0 3426040C */  jal        _clr_card_event
    /* EB6E4 800FAEE4 147522AC */   sw        $v0, %lo(D_80147514)($at)
    /* EB6E8 800FAEE8 0800248E */  lw         $a0, 0x8($s1)
    /* EB6EC 800FAEEC 4827040C */  jal        _card_clear
    /* EB6F0 800FAEF0 00000000 */   nop
    /* EB6F4 800FAEF4 15000224 */  addiu      $v0, $zero, 0x15
    /* EB6F8 800FAEF8 12EC0308 */  j          .L800FB048
    /* EB6FC 800FAEFC 000002AE */   sw        $v0, 0x0($s0)
  jlabel .L800FAF00
    /* EB700 800FAF00 F126040C */  jal        _chk_card_event_x
    /* EB704 800FAF04 00000000 */   nop
    /* EB708 800FAF08 50004010 */  beqz       $v0, .L800FB04C
    /* EB70C 800FAF0C 21100000 */   addu      $v0, $zero, $zero
    /* EB710 800FAF10 AC26040C */  jal        _get_card_event_x
    /* EB714 800FAF14 00000000 */   nop
    /* EB718 800FAF18 1E000224 */  addiu      $v0, $zero, 0x1E
    /* EB71C 800FAF1C 000002AE */  sw         $v0, 0x0($s0)
  jlabel .L800FAF20
    /* EB720 800FAF20 3426040C */  jal        _clr_card_event
    /* EB724 800FAF24 00000000 */   nop
    /* EB728 800FAF28 1480043C */  lui        $a0, %hi(D_80147524)
    /* EB72C 800FAF2C 2475848C */  lw         $a0, %lo(D_80147524)($a0)
    /* EB730 800FAF30 5827040C */  jal        _card_load
    /* EB734 800FAF34 00000000 */   nop
    /* EB738 800FAF38 0000028E */  lw         $v0, 0x0($s0)
    /* EB73C 800FAF3C 00000000 */  nop
    /* EB740 800FAF40 01004224 */  addiu      $v0, $v0, 0x1
    /* EB744 800FAF44 12EC0308 */  j          .L800FB048
    /* EB748 800FAF48 000002AE */   sw        $v0, 0x0($s0)
  jlabel .L800FAF4C
    /* EB74C 800FAF4C E226040C */  jal        _chk_card_event
    /* EB750 800FAF50 00000000 */   nop
    /* EB754 800FAF54 3D004010 */  beqz       $v0, .L800FB04C
    /* EB758 800FAF58 21100000 */   addu      $v0, $zero, $zero
    /* EB75C 800FAF5C 7626040C */  jal        _get_card_event
    /* EB760 800FAF60 00000000 */   nop
    /* EB764 800FAF64 21184000 */  addu       $v1, $v0, $zero
    /* EB768 800FAF68 1480013C */  lui        $at, %hi(D_8014750C)
    /* EB76C 800FAF6C 0C7522AC */  sw         $v0, %lo(D_8014750C)($at)
    /* EB770 800FAF70 03006228 */  slti       $v0, $v1, 0x3
    /* EB774 800FAF74 07004010 */  beqz       $v0, .L800FAF94
    /* EB778 800FAF78 00000000 */   nop
    /* EB77C 800FAF7C 1500601C */  bgtz       $v1, .L800FAFD4
    /* EB780 800FAF80 00000000 */   nop
    /* EB784 800FAF84 08006010 */  beqz       $v1, .L800FAFA8
    /* EB788 800FAF88 00000000 */   nop
    /* EB78C 800FAF8C 01EC0308 */  j          .L800FB004
    /* EB790 800FAF90 00000000 */   nop
  .L800FAF94:
    /* EB794 800FAF94 04000224 */  addiu      $v0, $zero, 0x4
    /* EB798 800FAF98 0E006210 */  beq        $v1, $v0, .L800FAFD4
    /* EB79C 800FAF9C 00000000 */   nop
    /* EB7A0 800FAFA0 01EC0308 */  j          .L800FB004
    /* EB7A4 800FAFA4 00000000 */   nop
  .L800FAFA8:
    /* EB7A8 800FAFA8 1480023C */  lui        $v0, %hi(D_80147510)
    /* EB7AC 800FAFAC 1075428C */  lw         $v0, %lo(D_80147510)($v0)
    /* EB7B0 800FAFB0 00000000 */  nop
    /* EB7B4 800FAFB4 02004010 */  beqz       $v0, .L800FAFC0
    /* EB7B8 800FAFB8 21180000 */   addu      $v1, $zero, $zero
    /* EB7BC 800FAFBC 03000324 */  addiu      $v1, $zero, 0x3
  .L800FAFC0:
    /* EB7C0 800FAFC0 1480023C */  lui        $v0, %hi(D_80147518)
    /* EB7C4 800FAFC4 18754224 */  addiu      $v0, $v0, %lo(D_80147518)
    /* EB7C8 800FAFC8 040043AC */  sw         $v1, 0x4($v0)
    /* EB7CC 800FAFCC 13EC0308 */  j          .L800FB04C
    /* EB7D0 800FAFD0 01000224 */   addiu     $v0, $zero, 0x1
  .L800FAFD4:
    /* EB7D4 800FAFD4 1480023C */  lui        $v0, %hi(D_80147508)
    /* EB7D8 800FAFD8 0875428C */  lw         $v0, %lo(D_80147508)($v0)
    /* EB7DC 800FAFDC 00000000 */  nop
    /* EB7E0 800FAFE0 01004224 */  addiu      $v0, $v0, 0x1
    /* EB7E4 800FAFE4 1480013C */  lui        $at, %hi(D_80147508)
    /* EB7E8 800FAFE8 087522AC */  sw         $v0, %lo(D_80147508)($at)
    /* EB7EC 800FAFEC 05004228 */  slti       $v0, $v0, 0x5
    /* EB7F0 800FAFF0 04004010 */  beqz       $v0, .L800FB004
    /* EB7F4 800FAFF4 00000000 */   nop
  .L800FAFF8:
    /* EB7F8 800FAFF8 1E000224 */  addiu      $v0, $zero, 0x1E
    /* EB7FC 800FAFFC 12EC0308 */  j          .L800FB048
    /* EB800 800FB000 000002AE */   sw        $v0, 0x0($s0)
  .L800FB004:
    /* EB804 800FB004 1480043C */  lui        $a0, %hi(D_8014750C)
    /* EB808 800FB008 0C75848C */  lw         $a0, %lo(D_8014750C)($a0)
    /* EB80C 800FB00C 04000224 */  addiu      $v0, $zero, 0x4
    /* EB810 800FB010 06008214 */  bne        $a0, $v0, .L800FB02C
    /* EB814 800FB014 00000000 */   nop
    /* EB818 800FB018 1480023C */  lui        $v0, %hi(D_80147518)
    /* EB81C 800FB01C 18754224 */  addiu      $v0, $v0, %lo(D_80147518)
    /* EB820 800FB020 040044AC */  sw         $a0, 0x4($v0)
    /* EB824 800FB024 13EC0308 */  j          .L800FB04C
    /* EB828 800FB028 01000224 */   addiu     $v0, $zero, 0x1
  .L800FB02C:
    /* EB82C 800FB02C 47F0030C */  jal        func_800FC11C
    /* EB830 800FB030 00000000 */   nop
    /* EB834 800FB034 1480033C */  lui        $v1, %hi(D_80147518)
    /* EB838 800FB038 18756324 */  addiu      $v1, $v1, %lo(D_80147518)
    /* EB83C 800FB03C 040062AC */  sw         $v0, 0x4($v1)
    /* EB840 800FB040 13EC0308 */  j          .L800FB04C
    /* EB844 800FB044 01000224 */   addiu     $v0, $zero, 0x1
  jlabel .L800FB048
    /* EB848 800FB048 21100000 */  addu       $v0, $zero, $zero
  .L800FB04C:
    /* EB84C 800FB04C 1800BF8F */  lw         $ra, 0x18($sp)
    /* EB850 800FB050 1400B18F */  lw         $s1, 0x14($sp)
    /* EB854 800FB054 1000B08F */  lw         $s0, 0x10($sp)
    /* EB858 800FB058 0800E003 */  jr         $ra
    /* EB85C 800FB05C 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel func_800FAE2C
