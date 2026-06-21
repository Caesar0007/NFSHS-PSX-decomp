.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TransitionIsFinished__12tOptionsMenu, 0x148

glabel TransitionIsFinished__12tOptionsMenu
    /* CF0C 8001C70C E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* CF10 8001C710 1400B1AF */  sw         $s1, 0x14($sp)
    /* CF14 8001C714 21888000 */  addu       $s1, $a0, $zero
    /* CF18 8001C718 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* CF1C 8001C71C 1800B2AF */  sw         $s2, 0x18($sp)
    /* CF20 8001C720 1000B0AF */  sw         $s0, 0x10($sp)
    /* CF24 8001C724 7400228E */  lw         $v0, 0x74($s1)
    /* CF28 8001C728 00000000 */  nop
    /* CF2C 8001C72C 28024228 */  slti       $v0, $v0, 0x228
    /* CF30 8001C730 05004014 */  bnez       $v0, .L8001C748
    /* CF34 8001C734 00000000 */   nop
    /* CF38 8001C738 70002282 */  lb         $v0, 0x70($s1)
    /* CF3C 8001C73C 00000000 */  nop
    /* CF40 8001C740 0900401C */  bgtz       $v0, .L8001C768
    /* CF44 8001C744 00000000 */   nop
  .L8001C748:
    /* CF48 8001C748 7400228E */  lw         $v0, 0x74($s1)
    /* CF4C 8001C74C 00000000 */  nop
    /* CF50 8001C750 0700401C */  bgtz       $v0, .L8001C770
    /* CF54 8001C754 01000224 */   addiu     $v0, $zero, 0x1
    /* CF58 8001C758 70002282 */  lb         $v0, 0x70($s1)
    /* CF5C 8001C75C 00000000 */  nop
    /* CF60 8001C760 03004104 */  bgez       $v0, .L8001C770
    /* CF64 8001C764 01000224 */   addiu     $v0, $zero, 0x1
  .L8001C768:
    /* CF68 8001C768 DD710008 */  j          .L8001C774
    /* CF6C 8001C76C 6C0020AE */   sw        $zero, 0x6C($s1)
  .L8001C770:
    /* CF70 8001C770 6C0022AE */  sw         $v0, 0x6C($s1)
  .L8001C774:
    /* CF74 8001C774 6C00228E */  lw         $v0, 0x6C($s1)
    /* CF78 8001C778 00000000 */  nop
    /* CF7C 8001C77C 1E004014 */  bnez       $v0, .L8001C7F8
    /* CF80 8001C780 0580023C */   lui       $v0, %hi(FEApp)
    /* CF84 8001C784 1000228E */  lw         $v0, 0x10($s1)
    /* CF88 8001C788 00000000 */  nop
    /* CF8C 8001C78C 19004010 */  beqz       $v0, .L8001C7F4
    /* CF90 8001C790 21800000 */   addu      $s0, $zero, $zero
    /* CF94 8001C794 01001224 */  addiu      $s2, $zero, 0x1
  .L8001C798:
    /* CF98 8001C798 00141000 */  sll        $v0, $s0, 16
    /* CF9C 8001C79C 83130200 */  sra        $v0, $v0, 14
    /* CFA0 8001C7A0 21102202 */  addu       $v0, $s1, $v0
    /* CFA4 8001C7A4 1000438C */  lw         $v1, 0x10($v0)
    /* CFA8 8001C7A8 00000000 */  nop
    /* CFAC 8001C7AC 1800628C */  lw         $v0, 0x18($v1)
    /* CFB0 8001C7B0 00000000 */  nop
    /* CFB4 8001C7B4 48004484 */  lh         $a0, 0x48($v0)
    /* CFB8 8001C7B8 4C00428C */  lw         $v0, 0x4C($v0)
    /* CFBC 8001C7BC 00000000 */  nop
    /* CFC0 8001C7C0 09F84000 */  jalr       $v0
    /* CFC4 8001C7C4 21206400 */   addu      $a0, $v1, $a0
    /* CFC8 8001C7C8 01004238 */  xori       $v0, $v0, 0x1
    /* CFCC 8001C7CC 02004010 */  beqz       $v0, .L8001C7D8
    /* CFD0 8001C7D0 01000226 */   addiu     $v0, $s0, 0x1
    /* CFD4 8001C7D4 6C0032AE */  sw         $s2, 0x6C($s1)
  .L8001C7D8:
    /* CFD8 8001C7D8 001C0200 */  sll        $v1, $v0, 16
    /* CFDC 8001C7DC 831B0300 */  sra        $v1, $v1, 14
    /* CFE0 8001C7E0 21182302 */  addu       $v1, $s1, $v1
    /* CFE4 8001C7E4 1000638C */  lw         $v1, 0x10($v1)
    /* CFE8 8001C7E8 00000000 */  nop
    /* CFEC 8001C7EC EAFF6014 */  bnez       $v1, .L8001C798
    /* CFF0 8001C7F0 21804000 */   addu      $s0, $v0, $zero
  .L8001C7F4:
    /* CFF4 8001C7F4 0580023C */  lui        $v0, %hi(FEApp)
  .L8001C7F8:
    /* CFF8 8001C7F8 C014428C */  lw         $v0, %lo(FEApp)($v0)
    /* CFFC 8001C7FC 00000000 */  nop
    /* D000 8001C800 0C00438C */  lw         $v1, 0xC($v0)
    /* D004 8001C804 00000000 */  nop
    /* D008 8001C808 6000628C */  lw         $v0, 0x60($v1)
    /* D00C 8001C80C 00000000 */  nop
    /* D010 8001C810 40004484 */  lh         $a0, 0x40($v0)
    /* D014 8001C814 4400428C */  lw         $v0, 0x44($v0)
    /* D018 8001C818 00000000 */  nop
    /* D01C 8001C81C 09F84000 */  jalr       $v0
    /* D020 8001C820 21206400 */   addu      $a0, $v1, $a0
    /* D024 8001C824 01004238 */  xori       $v0, $v0, 0x1
    /* D028 8001C828 02004010 */  beqz       $v0, .L8001C834
    /* D02C 8001C82C 01000224 */   addiu     $v0, $zero, 0x1
    /* D030 8001C830 6C0022AE */  sw         $v0, 0x6C($s1)
  .L8001C834:
    /* D034 8001C834 6C00228E */  lw         $v0, 0x6C($s1)
    /* D038 8001C838 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* D03C 8001C83C 1800B28F */  lw         $s2, 0x18($sp)
    /* D040 8001C840 1400B18F */  lw         $s1, 0x14($sp)
    /* D044 8001C844 1000B08F */  lw         $s0, 0x10($sp)
    /* D048 8001C848 01004238 */  xori       $v0, $v0, 0x1
    /* D04C 8001C84C 0800E003 */  jr         $ra
    /* D050 8001C850 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel TransitionIsFinished__12tOptionsMenu
