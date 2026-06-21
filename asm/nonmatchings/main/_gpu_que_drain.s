.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _gpu_que_drain, 0x260

glabel _gpu_que_drain
    /* DFE0C 800EF60C 1280023C */  lui        $v0, %hi(D_801237B0)
    /* DFE10 800EF610 B037428C */  lw         $v0, %lo(D_801237B0)($v0)
    /* DFE14 800EF614 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* DFE18 800EF618 1800BFAF */  sw         $ra, 0x18($sp)
    /* DFE1C 800EF61C 1400B1AF */  sw         $s1, 0x14($sp)
    /* DFE20 800EF620 1000B0AF */  sw         $s0, 0x10($sp)
    /* DFE24 800EF624 0000428C */  lw         $v0, 0x0($v0)
    /* DFE28 800EF628 0001103C */  lui        $s0, (0x1000000 >> 16)
    /* DFE2C 800EF62C 24105000 */  and        $v0, $v0, $s0
    /* DFE30 800EF630 89004014 */  bnez       $v0, .L800EF858
    /* DFE34 800EF634 01000224 */   addiu     $v0, $zero, 0x1
    /* DFE38 800EF638 54CA030C */  jal        SetIntrMask
    /* DFE3C 800EF63C 21200000 */   addu      $a0, $zero, $zero
    /* DFE40 800EF640 1280043C */  lui        $a0, %hi(_qin)
    /* DFE44 800EF644 C437848C */  lw         $a0, %lo(_qin)($a0)
    /* DFE48 800EF648 1280033C */  lui        $v1, %hi(_qout)
    /* DFE4C 800EF64C C837638C */  lw         $v1, %lo(_qout)($v1)
    /* DFE50 800EF650 1280013C */  lui        $at, %hi(D_801237D0)
    /* DFE54 800EF654 59008310 */  beq        $a0, $v1, .L800EF7BC
    /* DFE58 800EF658 D03722AC */   sw        $v0, %lo(D_801237D0)($at)
    /* DFE5C 800EF65C 1280023C */  lui        $v0, %hi(D_801237B0)
    /* DFE60 800EF660 B037428C */  lw         $v0, %lo(D_801237B0)($v0)
    /* DFE64 800EF664 00000000 */  nop
    /* DFE68 800EF668 0000428C */  lw         $v0, 0x0($v0)
    /* DFE6C 800EF66C 00000000 */  nop
    /* DFE70 800EF670 24105000 */  and        $v0, $v0, $s0
    /* DFE74 800EF674 51004014 */  bnez       $v0, .L800EF7BC
    /* DFE78 800EF678 00000000 */   nop
    /* DFE7C 800EF67C 0004113C */  lui        $s1, (0x4000000 >> 16)
    /* DFE80 800EF680 0001103C */  lui        $s0, (0x1000000 >> 16)
  .L800EF684:
    /* DFE84 800EF684 1280023C */  lui        $v0, %hi(_qout)
    /* DFE88 800EF688 C837428C */  lw         $v0, %lo(_qout)($v0)
    /* DFE8C 800EF68C 1280033C */  lui        $v1, %hi(_qin)
    /* DFE90 800EF690 C437638C */  lw         $v1, %lo(_qin)($v1)
    /* DFE94 800EF694 01004224 */  addiu      $v0, $v0, 0x1
    /* DFE98 800EF698 3F004230 */  andi       $v0, $v0, 0x3F
    /* DFE9C 800EF69C 08004314 */  bne        $v0, $v1, .L800EF6C0
    /* DFEA0 800EF6A0 00000000 */   nop
    /* DFEA4 800EF6A4 1280023C */  lui        $v0, %hi(D_801236A8)
    /* DFEA8 800EF6A8 A836428C */  lw         $v0, %lo(D_801236A8)($v0)
    /* DFEAC 800EF6AC 00000000 */  nop
    /* DFEB0 800EF6B0 03004014 */  bnez       $v0, .L800EF6C0
    /* DFEB4 800EF6B4 02000424 */   addiu     $a0, $zero, 0x2
    /* DFEB8 800EF6B8 2BCA030C */  jal        DMACallback
    /* DFEBC 800EF6BC 21280000 */   addu      $a1, $zero, $zero
  .L800EF6C0:
    /* DFEC0 800EF6C0 1280033C */  lui        $v1, %hi(D_801237A4)
    /* DFEC4 800EF6C4 A437638C */  lw         $v1, %lo(D_801237A4)($v1)
    /* DFEC8 800EF6C8 00000000 */  nop
    /* DFECC 800EF6CC 0000628C */  lw         $v0, 0x0($v1)
    /* DFED0 800EF6D0 00000000 */  nop
    /* DFED4 800EF6D4 24105100 */  and        $v0, $v0, $s1
    /* DFED8 800EF6D8 06004014 */  bnez       $v0, .L800EF6F4
    /* DFEDC 800EF6DC 0004043C */   lui       $a0, (0x4000000 >> 16)
  .L800EF6E0:
    /* DFEE0 800EF6E0 0000628C */  lw         $v0, 0x0($v1)
    /* DFEE4 800EF6E4 00000000 */  nop
    /* DFEE8 800EF6E8 24104400 */  and        $v0, $v0, $a0
    /* DFEEC 800EF6EC FCFF4010 */  beqz       $v0, .L800EF6E0
    /* DFEF0 800EF6F0 00000000 */   nop
  .L800EF6F4:
    /* DFEF4 800EF6F4 1280053C */  lui        $a1, %hi(_qout)
    /* DFEF8 800EF6F8 C837A58C */  lw         $a1, %lo(_qout)($a1)
    /* DFEFC 800EF6FC 1280033C */  lui        $v1, %hi(_qout)
    /* DFF00 800EF700 C837638C */  lw         $v1, %lo(_qout)($v1)
    /* DFF04 800EF704 00000000 */  nop
    /* DFF08 800EF708 40100300 */  sll        $v0, $v1, 1
    /* DFF0C 800EF70C 21104300 */  addu       $v0, $v0, $v1
    /* DFF10 800EF710 40110200 */  sll        $v0, $v0, 5
    /* DFF14 800EF714 40180500 */  sll        $v1, $a1, 1
    /* DFF18 800EF718 21186500 */  addu       $v1, $v1, $a1
    /* DFF1C 800EF71C 1480043C */  lui        $a0, %hi(D_8013EC04)
    /* DFF20 800EF720 21208200 */  addu       $a0, $a0, $v0
    /* DFF24 800EF724 04EC848C */  lw         $a0, %lo(D_8013EC04)($a0)
    /* DFF28 800EF728 1280053C */  lui        $a1, %hi(_qout)
    /* DFF2C 800EF72C C837A58C */  lw         $a1, %lo(_qout)($a1)
    /* DFF30 800EF730 40190300 */  sll        $v1, $v1, 5
    /* DFF34 800EF734 40100500 */  sll        $v0, $a1, 1
    /* DFF38 800EF738 21104500 */  addu       $v0, $v0, $a1
    /* DFF3C 800EF73C 40110200 */  sll        $v0, $v0, 5
    /* DFF40 800EF740 1480053C */  lui        $a1, %hi(D_8013EC08)
    /* DFF44 800EF744 2128A200 */  addu       $a1, $a1, $v0
    /* DFF48 800EF748 08ECA58C */  lw         $a1, %lo(D_8013EC08)($a1)
    /* DFF4C 800EF74C 1480023C */  lui        $v0, %hi(_que)
    /* DFF50 800EF750 21104300 */  addu       $v0, $v0, $v1
    /* DFF54 800EF754 00EC428C */  lw         $v0, %lo(_que)($v0)
    /* DFF58 800EF758 00000000 */  nop
    /* DFF5C 800EF75C 09F84000 */  jalr       $v0
    /* DFF60 800EF760 00000000 */   nop
    /* DFF64 800EF764 1280023C */  lui        $v0, %hi(_qout)
    /* DFF68 800EF768 C837428C */  lw         $v0, %lo(_qout)($v0)
    /* DFF6C 800EF76C 00000000 */  nop
    /* DFF70 800EF770 01004224 */  addiu      $v0, $v0, 0x1
    /* DFF74 800EF774 3F004230 */  andi       $v0, $v0, 0x3F
    /* DFF78 800EF778 1280013C */  lui        $at, %hi(_qout)
    /* DFF7C 800EF77C C83722AC */  sw         $v0, %lo(_qout)($at)
    /* DFF80 800EF780 1280033C */  lui        $v1, %hi(_qin)
    /* DFF84 800EF784 C437638C */  lw         $v1, %lo(_qin)($v1)
    /* DFF88 800EF788 1280023C */  lui        $v0, %hi(_qout)
    /* DFF8C 800EF78C C837428C */  lw         $v0, %lo(_qout)($v0)
    /* DFF90 800EF790 00000000 */  nop
    /* DFF94 800EF794 09006210 */  beq        $v1, $v0, .L800EF7BC
    /* DFF98 800EF798 00000000 */   nop
    /* DFF9C 800EF79C 1280023C */  lui        $v0, %hi(D_801237B0)
    /* DFFA0 800EF7A0 B037428C */  lw         $v0, %lo(D_801237B0)($v0)
    /* DFFA4 800EF7A4 00000000 */  nop
    /* DFFA8 800EF7A8 0000428C */  lw         $v0, 0x0($v0)
    /* DFFAC 800EF7AC 00000000 */  nop
    /* DFFB0 800EF7B0 24105000 */  and        $v0, $v0, $s0
    /* DFFB4 800EF7B4 B3FF4010 */  beqz       $v0, .L800EF684
    /* DFFB8 800EF7B8 00000000 */   nop
  .L800EF7BC:
    /* DFFBC 800EF7BC 1280043C */  lui        $a0, %hi(D_801237D0)
    /* DFFC0 800EF7C0 D037848C */  lw         $a0, %lo(D_801237D0)($a0)
    /* DFFC4 800EF7C4 54CA030C */  jal        SetIntrMask
    /* DFFC8 800EF7C8 00000000 */   nop
    /* DFFCC 800EF7CC 1280033C */  lui        $v1, %hi(_qin)
    /* DFFD0 800EF7D0 C437638C */  lw         $v1, %lo(_qin)($v1)
    /* DFFD4 800EF7D4 1280023C */  lui        $v0, %hi(_qout)
    /* DFFD8 800EF7D8 C837428C */  lw         $v0, %lo(_qout)($v0)
    /* DFFDC 800EF7DC 00000000 */  nop
    /* DFFE0 800EF7E0 16006214 */  bne        $v1, $v0, .L800EF83C
    /* DFFE4 800EF7E4 00000000 */   nop
    /* DFFE8 800EF7E8 1280023C */  lui        $v0, %hi(D_801237B0)
    /* DFFEC 800EF7EC B037428C */  lw         $v0, %lo(D_801237B0)($v0)
    /* DFFF0 800EF7F0 00000000 */  nop
    /* DFFF4 800EF7F4 0000428C */  lw         $v0, 0x0($v0)
    /* DFFF8 800EF7F8 0001033C */  lui        $v1, (0x1000000 >> 16)
    /* DFFFC 800EF7FC 24104300 */  and        $v0, $v0, $v1
    /* E0000 800EF800 0E004014 */  bnez       $v0, .L800EF83C
    /* E0004 800EF804 00000000 */   nop
    /* E0008 800EF808 1280033C */  lui        $v1, %hi(D_801236A4)
    /* E000C 800EF80C A4366324 */  addiu      $v1, $v1, %lo(D_801236A4)
    /* E0010 800EF810 0000628C */  lw         $v0, 0x0($v1)
    /* E0014 800EF814 00000000 */  nop
    /* E0018 800EF818 08004010 */  beqz       $v0, .L800EF83C
    /* E001C 800EF81C 00000000 */   nop
    /* E0020 800EF820 0400648C */  lw         $a0, 0x4($v1)
    /* E0024 800EF824 00000000 */  nop
    /* E0028 800EF828 04008010 */  beqz       $a0, .L800EF83C
    /* E002C 800EF82C F8FF6224 */   addiu     $v0, $v1, -0x8
    /* E0030 800EF830 080040AC */  sw         $zero, 0x8($v0)
    /* E0034 800EF834 09F88000 */  jalr       $a0
    /* E0038 800EF838 00000000 */   nop
  .L800EF83C:
    /* E003C 800EF83C 1280023C */  lui        $v0, %hi(_qin)
    /* E0040 800EF840 C437428C */  lw         $v0, %lo(_qin)($v0)
    /* E0044 800EF844 1280033C */  lui        $v1, %hi(_qout)
    /* E0048 800EF848 C837638C */  lw         $v1, %lo(_qout)($v1)
    /* E004C 800EF84C 00000000 */  nop
    /* E0050 800EF850 23104300 */  subu       $v0, $v0, $v1
    /* E0054 800EF854 3F004230 */  andi       $v0, $v0, 0x3F
  .L800EF858:
    /* E0058 800EF858 1800BF8F */  lw         $ra, 0x18($sp)
    /* E005C 800EF85C 1400B18F */  lw         $s1, 0x14($sp)
    /* E0060 800EF860 1000B08F */  lw         $s0, 0x10($sp)
    /* E0064 800EF864 0800E003 */  jr         $ra
    /* E0068 800EF868 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel _gpu_que_drain
