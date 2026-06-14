.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching unhuff, 0xC24

glabel unhuff
    /* E4D9C 800F459C 10FBBD27 */  addiu      $sp, $sp, -0x4F0
    /* E4DA0 800F45A0 2150C000 */  addu       $t2, $a2, $zero
    /* E4DA4 800F45A4 21488000 */  addu       $t1, $a0, $zero
    /* E4DA8 800F45A8 F404A5AF */  sw         $a1, 0x4F4($sp)
    /* E4DAC 800F45AC 2178A000 */  addu       $t7, $a1, $zero
    /* E4DB0 800F45B0 E004B6AF */  sw         $s6, 0x4E0($sp)
    /* E4DB4 800F45B4 21B00000 */  addu       $s6, $zero, $zero
    /* E4DB8 800F45B8 E804BEAF */  sw         $fp, 0x4E8($sp)
    /* E4DBC 800F45BC E404B7AF */  sw         $s7, 0x4E4($sp)
    /* E4DC0 800F45C0 DC04B5AF */  sw         $s5, 0x4DC($sp)
    /* E4DC4 800F45C4 D804B4AF */  sw         $s4, 0x4D8($sp)
    /* E4DC8 800F45C8 D404B3AF */  sw         $s3, 0x4D4($sp)
    /* E4DCC 800F45CC D004B2AF */  sw         $s2, 0x4D0($sp)
    /* E4DD0 800F45D0 CC04B1AF */  sw         $s1, 0x4CC($sp)
    /* E4DD4 800F45D4 EE022011 */  beqz       $t1, .L800F5190
    /* E4DD8 800F45D8 C804B0AF */   sw        $s0, 0x4C8($sp)
    /* E4DDC 800F45DC 00002891 */  lbu        $t0, 0x0($t1)
    /* E4DE0 800F45E0 01002391 */  lbu        $v1, 0x1($t1)
    /* E4DE4 800F45E4 02002925 */  addiu      $t1, $t1, 0x2
    /* E4DE8 800F45E8 00002491 */  lbu        $a0, 0x0($t1)
    /* E4DEC 800F45EC 01002591 */  lbu        $a1, 0x1($t1)
    /* E4DF0 800F45F0 02002925 */  addiu      $t1, $t1, 0x2
    /* E4DF4 800F45F4 2138C002 */  addu       $a3, $s6, $zero
    /* E4DF8 800F45F8 00120800 */  sll        $v0, $t0, 8
    /* E4DFC 800F45FC 25406200 */  or         $t0, $v1, $v0
    /* E4E00 800F4600 21B80001 */  addu       $s7, $t0, $zero
    /* E4E04 800F4604 00121700 */  sll        $v0, $s7, 8
    /* E4E08 800F4608 25408200 */  or         $t0, $a0, $v0
    /* E4E0C 800F460C 00120800 */  sll        $v0, $t0, 8
    /* E4E10 800F4610 2540A200 */  or         $t0, $a1, $v0
    /* E4E14 800F4614 0001E232 */  andi       $v0, $s7, 0x100
    /* E4E18 800F4618 11004010 */  beqz       $v0, .L800F4660
    /* E4E1C 800F461C 002C0800 */   sll       $a1, $t0, 16
    /* E4E20 800F4620 00002391 */  lbu        $v1, 0x0($t1)
    /* E4E24 800F4624 01002491 */  lbu        $a0, 0x1($t1)
    /* E4E28 800F4628 02002925 */  addiu      $t1, $t1, 0x2
    /* E4E2C 800F462C 00002591 */  lbu        $a1, 0x0($t1)
    /* E4E30 800F4630 01002691 */  lbu        $a2, 0x1($t1)
    /* E4E34 800F4634 02002925 */  addiu      $t1, $t1, 0x2
    /* E4E38 800F4638 08000724 */  addiu      $a3, $zero, 0x8
    /* E4E3C 800F463C 0410E800 */  sllv       $v0, $t0, $a3
    /* E4E40 800F4640 25406200 */  or         $t0, $v1, $v0
    /* E4E44 800F4644 0410E800 */  sllv       $v0, $t0, $a3
    /* E4E48 800F4648 25408200 */  or         $t0, $a0, $v0
    /* E4E4C 800F464C 0410E800 */  sllv       $v0, $t0, $a3
    /* E4E50 800F4650 2540A200 */  or         $t0, $a1, $v0
    /* E4E54 800F4654 0410E800 */  sllv       $v0, $t0, $a3
    /* E4E58 800F4658 2540C200 */  or         $t0, $a2, $v0
    /* E4E5C 800F465C 0428E800 */  sllv       $a1, $t0, $a3
  .L800F4660:
    /* E4E60 800F4660 FFFE0224 */  addiu      $v0, $zero, -0x101
    /* E4E64 800F4664 24B8E202 */  and        $s7, $s7, $v0
    /* E4E68 800F4668 02360500 */  srl        $a2, $a1, 24
    /* E4E6C 800F466C F8FFE724 */  addiu      $a3, $a3, -0x8
    /* E4E70 800F4670 0B00E104 */  bgez       $a3, .L800F46A0
    /* E4E74 800F4674 002A0500 */   sll       $a1, $a1, 8
    /* E4E78 800F4678 00002391 */  lbu        $v1, 0x0($t1)
    /* E4E7C 800F467C 01002591 */  lbu        $a1, 0x1($t1)
    /* E4E80 800F4680 02002925 */  addiu      $t1, $t1, 0x2
    /* E4E84 800F4684 23200700 */  negu       $a0, $a3
    /* E4E88 800F4688 1000E724 */  addiu      $a3, $a3, 0x10
    /* E4E8C 800F468C 00120800 */  sll        $v0, $t0, 8
    /* E4E90 800F4690 25406200 */  or         $t0, $v1, $v0
    /* E4E94 800F4694 00120800 */  sll        $v0, $t0, 8
    /* E4E98 800F4698 2540A200 */  or         $t0, $a1, $v0
    /* E4E9C 800F469C 04288800 */  sllv       $a1, $t0, $a0
  .L800F46A0:
    /* E4EA0 800F46A0 02B40500 */  srl        $s6, $a1, 16
    /* E4EA4 800F46A4 F0FFE724 */  addiu      $a3, $a3, -0x10
    /* E4EA8 800F46A8 0B00E104 */  bgez       $a3, .L800F46D8
    /* E4EAC 800F46AC 002C0500 */   sll       $a1, $a1, 16
    /* E4EB0 800F46B0 00002391 */  lbu        $v1, 0x0($t1)
    /* E4EB4 800F46B4 01002591 */  lbu        $a1, 0x1($t1)
    /* E4EB8 800F46B8 02002925 */  addiu      $t1, $t1, 0x2
    /* E4EBC 800F46BC 23200700 */  negu       $a0, $a3
    /* E4EC0 800F46C0 1000E724 */  addiu      $a3, $a3, 0x10
    /* E4EC4 800F46C4 00120800 */  sll        $v0, $t0, 8
    /* E4EC8 800F46C8 25406200 */  or         $t0, $v1, $v0
    /* E4ECC 800F46CC 00120800 */  sll        $v0, $t0, 8
    /* E4ED0 800F46D0 2540A200 */  or         $t0, $a1, $v0
    /* E4ED4 800F46D4 04288800 */  sllv       $a1, $t0, $a0
  .L800F46D8:
    /* E4ED8 800F46D8 00140600 */  sll        $v0, $a2, 16
    /* E4EDC 800F46DC 6E014011 */  beqz       $t2, .L800F4C98
    /* E4EE0 800F46E0 25B0C202 */   or        $s6, $s6, $v0
    /* E4EE4 800F46E4 02F60500 */  srl        $fp, $a1, 24
    /* E4EE8 800F46E8 F8FFE724 */  addiu      $a3, $a3, -0x8
    /* E4EEC 800F46EC 0B00E104 */  bgez       $a3, .L800F471C
    /* E4EF0 800F46F0 002A0500 */   sll       $a1, $a1, 8
    /* E4EF4 800F46F4 00002391 */  lbu        $v1, 0x0($t1)
    /* E4EF8 800F46F8 01002591 */  lbu        $a1, 0x1($t1)
    /* E4EFC 800F46FC 02002925 */  addiu      $t1, $t1, 0x2
    /* E4F00 800F4700 23200700 */  negu       $a0, $a3
    /* E4F04 800F4704 1000E724 */  addiu      $a3, $a3, 0x10
    /* E4F08 800F4708 00120800 */  sll        $v0, $t0, 8
    /* E4F0C 800F470C 25406200 */  or         $t0, $v1, $v0
    /* E4F10 800F4710 00120800 */  sll        $v0, $t0, 8
    /* E4F14 800F4714 2540A200 */  or         $t0, $a1, $v0
    /* E4F18 800F4718 04288800 */  sllv       $a1, $t0, $a0
  .L800F471C:
    /* E4F1C 800F471C 21880000 */  addu       $s1, $zero, $zero
    /* E4F20 800F4720 01000624 */  addiu      $a2, $zero, 0x1
    /* E4F24 800F4724 21682002 */  addu       $t5, $s1, $zero
    /* E4F28 800F4728 2190C000 */  addu       $s2, $a2, $zero
    /* E4F2C 800F472C 0400B027 */  addiu      $s0, $sp, 0x4
    /* E4F30 800F4730 04000E24 */  addiu      $t6, $zero, 0x4
  .L800F4734:
    /* E4F34 800F4734 40680D00 */  sll        $t5, $t5, 1
    /* E4F38 800F4738 2118AE03 */  addu       $v1, $sp, $t6
    /* E4F3C 800F473C 2310B101 */  subu       $v0, $t5, $s1
    /* E4F40 800F4740 1100A104 */  bgez       $a1, .L800F4788
    /* E4F44 800F4744 400062AC */   sw        $v0, 0x40($v1)
    /* E4F48 800F4748 425F0500 */  srl        $t3, $a1, 29
    /* E4F4C 800F474C FDFFE724 */  addiu      $a3, $a3, -0x3
    /* E4F50 800F4750 0B00E104 */  bgez       $a3, .L800F4780
    /* E4F54 800F4754 C0280500 */   sll       $a1, $a1, 3
    /* E4F58 800F4758 00002391 */  lbu        $v1, 0x0($t1)
    /* E4F5C 800F475C 01002591 */  lbu        $a1, 0x1($t1)
    /* E4F60 800F4760 02002925 */  addiu      $t1, $t1, 0x2
    /* E4F64 800F4764 23200700 */  negu       $a0, $a3
    /* E4F68 800F4768 1000E724 */  addiu      $a3, $a3, 0x10
    /* E4F6C 800F476C 00120800 */  sll        $v0, $t0, 8
    /* E4F70 800F4770 25406200 */  or         $t0, $v1, $v0
    /* E4F74 800F4774 00120800 */  sll        $v0, $t0, 8
    /* E4F78 800F4778 2540A200 */  or         $t0, $a1, $v0
    /* E4F7C 800F477C 04288800 */  sllv       $a1, $t0, $a0
  .L800F4780:
    /* E4F80 800F4780 44D20308 */  j          .L800F4910
    /* E4F84 800F4784 FCFF6B25 */   addiu     $t3, $t3, -0x4
  .L800F4788:
    /* E4F88 800F4788 02140500 */  srl        $v0, $a1, 16
    /* E4F8C 800F478C 13004010 */  beqz       $v0, .L800F47DC
    /* E4F90 800F4790 02000A24 */   addiu     $t2, $zero, 0x2
  .L800F4794:
    /* E4F94 800F4794 40280500 */  sll        $a1, $a1, 1
    /* E4F98 800F4798 FEFFA104 */  bgez       $a1, .L800F4794
    /* E4F9C 800F479C 01004A25 */   addiu     $t2, $t2, 0x1
    /* E4FA0 800F47A0 0100E224 */  addiu      $v0, $a3, 0x1
    /* E4FA4 800F47A4 23384A00 */  subu       $a3, $v0, $t2
    /* E4FA8 800F47A8 1E00E104 */  bgez       $a3, .L800F4824
    /* E4FAC 800F47AC 40280500 */   sll       $a1, $a1, 1
    /* E4FB0 800F47B0 00002391 */  lbu        $v1, 0x0($t1)
    /* E4FB4 800F47B4 01002591 */  lbu        $a1, 0x1($t1)
    /* E4FB8 800F47B8 02002925 */  addiu      $t1, $t1, 0x2
    /* E4FBC 800F47BC 23200700 */  negu       $a0, $a3
    /* E4FC0 800F47C0 1000E724 */  addiu      $a3, $a3, 0x10
    /* E4FC4 800F47C4 00120800 */  sll        $v0, $t0, 8
    /* E4FC8 800F47C8 25406200 */  or         $t0, $v1, $v0
    /* E4FCC 800F47CC 00120800 */  sll        $v0, $t0, 8
    /* E4FD0 800F47D0 2540A200 */  or         $t0, $a1, $v0
    /* E4FD4 800F47D4 09D20308 */  j          .L800F4824
    /* E4FD8 800F47D8 04288800 */   sllv      $a1, $t0, $a0
  .L800F47DC:
    /* E4FDC 800F47DC 01004A25 */  addiu      $t2, $t2, 0x1
  .L800F47E0:
    /* E4FE0 800F47E0 C25F0500 */  srl        $t3, $a1, 31
    /* E4FE4 800F47E4 FFFFE724 */  addiu      $a3, $a3, -0x1
    /* E4FE8 800F47E8 0B00E104 */  bgez       $a3, .L800F4818
    /* E4FEC 800F47EC 40280500 */   sll       $a1, $a1, 1
    /* E4FF0 800F47F0 00002391 */  lbu        $v1, 0x0($t1)
    /* E4FF4 800F47F4 01002591 */  lbu        $a1, 0x1($t1)
    /* E4FF8 800F47F8 02002925 */  addiu      $t1, $t1, 0x2
    /* E4FFC 800F47FC 23200700 */  negu       $a0, $a3
    /* E5000 800F4800 1000E724 */  addiu      $a3, $a3, 0x10
    /* E5004 800F4804 00120800 */  sll        $v0, $t0, 8
    /* E5008 800F4808 25406200 */  or         $t0, $v1, $v0
    /* E500C 800F480C 00120800 */  sll        $v0, $t0, 8
    /* E5010 800F4810 2540A200 */  or         $t0, $a1, $v0
    /* E5014 800F4814 04288800 */  sllv       $a1, $t0, $a0
  .L800F4818:
    /* E5018 800F4818 F1FF6011 */  beqz       $t3, .L800F47E0
    /* E501C 800F481C 01004A25 */   addiu     $t2, $t2, 0x1
    /* E5020 800F4820 FFFF4A25 */  addiu      $t2, $t2, -0x1
  .L800F4824:
    /* E5024 800F4824 11004229 */  slti       $v0, $t2, 0x11
    /* E5028 800F4828 27004014 */  bnez       $v0, .L800F48C8
    /* E502C 800F482C 20000224 */   addiu     $v0, $zero, 0x20
    /* E5030 800F4830 30000224 */  addiu      $v0, $zero, 0x30
    /* E5034 800F4834 23104A00 */  subu       $v0, $v0, $t2
    /* E5038 800F4838 06584500 */  srlv       $t3, $a1, $v0
    /* E503C 800F483C F0FF4225 */  addiu      $v0, $t2, -0x10
    /* E5040 800F4840 04284500 */  sllv       $a1, $a1, $v0
    /* E5044 800F4844 1000E224 */  addiu      $v0, $a3, 0x10
    /* E5048 800F4848 23384A00 */  subu       $a3, $v0, $t2
    /* E504C 800F484C 0C00E104 */  bgez       $a3, .L800F4880
    /* E5050 800F4850 02640500 */   srl       $t4, $a1, 16
    /* E5054 800F4854 00002391 */  lbu        $v1, 0x0($t1)
    /* E5058 800F4858 01002591 */  lbu        $a1, 0x1($t1)
    /* E505C 800F485C 02002925 */  addiu      $t1, $t1, 0x2
    /* E5060 800F4860 23200700 */  negu       $a0, $a3
    /* E5064 800F4864 1000E724 */  addiu      $a3, $a3, 0x10
    /* E5068 800F4868 00120800 */  sll        $v0, $t0, 8
    /* E506C 800F486C 25406200 */  or         $t0, $v1, $v0
    /* E5070 800F4870 00120800 */  sll        $v0, $t0, 8
    /* E5074 800F4874 2540A200 */  or         $t0, $a1, $v0
    /* E5078 800F4878 04288800 */  sllv       $a1, $t0, $a0
    /* E507C 800F487C 02640500 */  srl        $t4, $a1, 16
  .L800F4880:
    /* E5080 800F4880 F0FFE724 */  addiu      $a3, $a3, -0x10
    /* E5084 800F4884 0B00E104 */  bgez       $a3, .L800F48B4
    /* E5088 800F4888 002C0500 */   sll       $a1, $a1, 16
    /* E508C 800F488C 00002391 */  lbu        $v1, 0x0($t1)
    /* E5090 800F4890 01002591 */  lbu        $a1, 0x1($t1)
    /* E5094 800F4894 02002925 */  addiu      $t1, $t1, 0x2
    /* E5098 800F4898 23200700 */  negu       $a0, $a3
    /* E509C 800F489C 1000E724 */  addiu      $a3, $a3, 0x10
    /* E50A0 800F48A0 00120800 */  sll        $v0, $t0, 8
    /* E50A4 800F48A4 25406200 */  or         $t0, $v1, $v0
    /* E50A8 800F48A8 00120800 */  sll        $v0, $t0, 8
    /* E50AC 800F48AC 2540A200 */  or         $t0, $a1, $v0
    /* E50B0 800F48B0 04288800 */  sllv       $a1, $t0, $a0
  .L800F48B4:
    /* E50B4 800F48B4 00140B00 */  sll        $v0, $t3, 16
    /* E50B8 800F48B8 25108201 */  or         $v0, $t4, $v0
    /* E50BC 800F48BC 04185201 */  sllv       $v1, $s2, $t2
    /* E50C0 800F48C0 43D20308 */  j          .L800F490C
    /* E50C4 800F48C4 21104300 */   addu      $v0, $v0, $v1
  .L800F48C8:
    /* E50C8 800F48C8 23104A00 */  subu       $v0, $v0, $t2
    /* E50CC 800F48CC 06584500 */  srlv       $t3, $a1, $v0
    /* E50D0 800F48D0 2338EA00 */  subu       $a3, $a3, $t2
    /* E50D4 800F48D4 0B00E104 */  bgez       $a3, .L800F4904
    /* E50D8 800F48D8 04284501 */   sllv      $a1, $a1, $t2
    /* E50DC 800F48DC 00002391 */  lbu        $v1, 0x0($t1)
    /* E50E0 800F48E0 01002591 */  lbu        $a1, 0x1($t1)
    /* E50E4 800F48E4 02002925 */  addiu      $t1, $t1, 0x2
    /* E50E8 800F48E8 23200700 */  negu       $a0, $a3
    /* E50EC 800F48EC 1000E724 */  addiu      $a3, $a3, 0x10
    /* E50F0 800F48F0 00120800 */  sll        $v0, $t0, 8
    /* E50F4 800F48F4 25406200 */  or         $t0, $v1, $v0
    /* E50F8 800F48F8 00120800 */  sll        $v0, $t0, 8
    /* E50FC 800F48FC 2540A200 */  or         $t0, $a1, $v0
    /* E5100 800F4900 04288800 */  sllv       $a1, $t0, $a0
  .L800F4904:
    /* E5104 800F4904 04105201 */  sllv       $v0, $s2, $t2
    /* E5108 800F4908 21106201 */  addu       $v0, $t3, $v0
  .L800F490C:
    /* E510C 800F490C FCFF4B24 */  addiu      $t3, $v0, -0x4
  .L800F4910:
    /* E5110 800F4910 00000BAE */  sw         $t3, 0x0($s0)
    /* E5114 800F4914 21882B02 */  addu       $s1, $s1, $t3
    /* E5118 800F4918 2168AB01 */  addu       $t5, $t5, $t3
    /* E511C 800F491C 05006011 */  beqz       $t3, .L800F4934
    /* E5120 800F4920 21200000 */   addu      $a0, $zero, $zero
    /* E5124 800F4924 10000224 */  addiu      $v0, $zero, 0x10
    /* E5128 800F4928 23104600 */  subu       $v0, $v0, $a2
    /* E512C 800F492C 04104D00 */  sllv       $v0, $t5, $v0
    /* E5130 800F4930 FFFF4430 */  andi       $a0, $v0, 0xFFFF
  .L800F4934:
    /* E5134 800F4934 8000AA27 */  addiu      $t2, $sp, 0x80
    /* E5138 800F4938 21104E01 */  addu       $v0, $t2, $t6
    /* E513C 800F493C 000044AC */  sw         $a0, 0x0($v0)
    /* E5140 800F4940 04001026 */  addiu      $s0, $s0, 0x4
    /* E5144 800F4944 0400CE25 */  addiu      $t6, $t6, 0x4
    /* E5148 800F4948 7AFF6011 */  beqz       $t3, .L800F4734
    /* E514C 800F494C 0100C624 */   addiu     $a2, $a2, 0x1
    /* E5150 800F4950 78FF8014 */  bnez       $a0, .L800F4734
    /* E5154 800F4954 FFFFC224 */   addiu     $v0, $a2, -0x1
    /* E5158 800F4958 80180200 */  sll        $v1, $v0, 2
    /* E515C 800F495C 21184301 */  addu       $v1, $t2, $v1
    /* E5160 800F4960 FFFF0424 */  addiu      $a0, $zero, -0x1
    /* E5164 800F4964 000064AC */  sw         $a0, 0x0($v1)
    /* E5168 800F4968 21A84000 */  addu       $s5, $v0, $zero
    /* E516C 800F496C 10000624 */  addiu      $a2, $zero, 0x10
    /* E5170 800F4970 21200000 */  addu       $a0, $zero, $zero
    /* E5174 800F4974 C003A327 */  addiu      $v1, $sp, 0x3C0
    /* E5178 800F4978 CC03A227 */  addiu      $v0, $sp, 0x3CC
  .L800F497C:
    /* E517C 800F497C 000064AC */  sw         $a0, 0x0($v1)
    /* E5180 800F4980 F8FF44AC */  sw         $a0, -0x8($v0)
    /* E5184 800F4984 FCFF44AC */  sw         $a0, -0x4($v0)
    /* E5188 800F4988 000044AC */  sw         $a0, 0x0($v0)
    /* E518C 800F498C 10004224 */  addiu      $v0, $v0, 0x10
    /* E5190 800F4990 FFFFC624 */  addiu      $a2, $a2, -0x1
    /* E5194 800F4994 F9FFC014 */  bnez       $a2, .L800F497C
    /* E5198 800F4998 10006324 */   addiu     $v1, $v1, 0x10
    /* E519C 800F499C FF000D24 */  addiu      $t5, $zero, 0xFF
    /* E51A0 800F49A0 8800201A */  blez       $s1, .L800F4BC4
    /* E51A4 800F49A4 21600000 */   addu      $t4, $zero, $zero
    /* E51A8 800F49A8 01001024 */  addiu      $s0, $zero, 0x1
    /* E51AC 800F49AC C003AE27 */  addiu      $t6, $sp, 0x3C0
  .L800F49B0:
    /* E51B0 800F49B0 1100A104 */  bgez       $a1, .L800F49F8
    /* E51B4 800F49B4 02140500 */   srl       $v0, $a1, 16
    /* E51B8 800F49B8 42370500 */  srl        $a2, $a1, 29
    /* E51BC 800F49BC FDFFE724 */  addiu      $a3, $a3, -0x3
    /* E51C0 800F49C0 0B00E104 */  bgez       $a3, .L800F49F0
    /* E51C4 800F49C4 C0280500 */   sll       $a1, $a1, 3
    /* E51C8 800F49C8 00002391 */  lbu        $v1, 0x0($t1)
    /* E51CC 800F49CC 01002591 */  lbu        $a1, 0x1($t1)
    /* E51D0 800F49D0 02002925 */  addiu      $t1, $t1, 0x2
    /* E51D4 800F49D4 23200700 */  negu       $a0, $a3
    /* E51D8 800F49D8 1000E724 */  addiu      $a3, $a3, 0x10
    /* E51DC 800F49DC 00120800 */  sll        $v0, $t0, 8
    /* E51E0 800F49E0 25406200 */  or         $t0, $v1, $v0
    /* E51E4 800F49E4 00120800 */  sll        $v0, $t0, 8
    /* E51E8 800F49E8 2540A200 */  or         $t0, $a1, $v0
    /* E51EC 800F49EC 04288800 */  sllv       $a1, $t0, $a0
  .L800F49F0:
    /* E51F0 800F49F0 DFD20308 */  j          .L800F4B7C
    /* E51F4 800F49F4 FCFFC624 */   addiu     $a2, $a2, -0x4
  .L800F49F8:
    /* E51F8 800F49F8 13004010 */  beqz       $v0, .L800F4A48
    /* E51FC 800F49FC 02000A24 */   addiu     $t2, $zero, 0x2
  .L800F4A00:
    /* E5200 800F4A00 40280500 */  sll        $a1, $a1, 1
    /* E5204 800F4A04 FEFFA104 */  bgez       $a1, .L800F4A00
    /* E5208 800F4A08 01004A25 */   addiu     $t2, $t2, 0x1
    /* E520C 800F4A0C 0100E224 */  addiu      $v0, $a3, 0x1
    /* E5210 800F4A10 23384A00 */  subu       $a3, $v0, $t2
    /* E5214 800F4A14 1E00E104 */  bgez       $a3, .L800F4A90
    /* E5218 800F4A18 40280500 */   sll       $a1, $a1, 1
    /* E521C 800F4A1C 00002391 */  lbu        $v1, 0x0($t1)
    /* E5220 800F4A20 01002591 */  lbu        $a1, 0x1($t1)
    /* E5224 800F4A24 02002925 */  addiu      $t1, $t1, 0x2
    /* E5228 800F4A28 23200700 */  negu       $a0, $a3
    /* E522C 800F4A2C 1000E724 */  addiu      $a3, $a3, 0x10
    /* E5230 800F4A30 00120800 */  sll        $v0, $t0, 8
    /* E5234 800F4A34 25406200 */  or         $t0, $v1, $v0
    /* E5238 800F4A38 00120800 */  sll        $v0, $t0, 8
    /* E523C 800F4A3C 2540A200 */  or         $t0, $a1, $v0
    /* E5240 800F4A40 A4D20308 */  j          .L800F4A90
    /* E5244 800F4A44 04288800 */   sllv      $a1, $t0, $a0
  .L800F4A48:
    /* E5248 800F4A48 01004A25 */  addiu      $t2, $t2, 0x1
  .L800F4A4C:
    /* E524C 800F4A4C C2370500 */  srl        $a2, $a1, 31
    /* E5250 800F4A50 FFFFE724 */  addiu      $a3, $a3, -0x1
    /* E5254 800F4A54 0B00E104 */  bgez       $a3, .L800F4A84
    /* E5258 800F4A58 40280500 */   sll       $a1, $a1, 1
    /* E525C 800F4A5C 00002391 */  lbu        $v1, 0x0($t1)
    /* E5260 800F4A60 01002591 */  lbu        $a1, 0x1($t1)
    /* E5264 800F4A64 02002925 */  addiu      $t1, $t1, 0x2
    /* E5268 800F4A68 23200700 */  negu       $a0, $a3
    /* E526C 800F4A6C 1000E724 */  addiu      $a3, $a3, 0x10
    /* E5270 800F4A70 00120800 */  sll        $v0, $t0, 8
    /* E5274 800F4A74 25406200 */  or         $t0, $v1, $v0
    /* E5278 800F4A78 00120800 */  sll        $v0, $t0, 8
    /* E527C 800F4A7C 2540A200 */  or         $t0, $a1, $v0
    /* E5280 800F4A80 04288800 */  sllv       $a1, $t0, $a0
  .L800F4A84:
    /* E5284 800F4A84 F1FFC010 */  beqz       $a2, .L800F4A4C
    /* E5288 800F4A88 01004A25 */   addiu     $t2, $t2, 0x1
    /* E528C 800F4A8C FFFF4A25 */  addiu      $t2, $t2, -0x1
  .L800F4A90:
    /* E5290 800F4A90 11004229 */  slti       $v0, $t2, 0x11
    /* E5294 800F4A94 27004014 */  bnez       $v0, .L800F4B34
    /* E5298 800F4A98 20000224 */   addiu     $v0, $zero, 0x20
    /* E529C 800F4A9C 30000224 */  addiu      $v0, $zero, 0x30
    /* E52A0 800F4AA0 23104A00 */  subu       $v0, $v0, $t2
    /* E52A4 800F4AA4 06304500 */  srlv       $a2, $a1, $v0
    /* E52A8 800F4AA8 F0FF4225 */  addiu      $v0, $t2, -0x10
    /* E52AC 800F4AAC 04284500 */  sllv       $a1, $a1, $v0
    /* E52B0 800F4AB0 1000E224 */  addiu      $v0, $a3, 0x10
    /* E52B4 800F4AB4 23384A00 */  subu       $a3, $v0, $t2
    /* E52B8 800F4AB8 0C00E104 */  bgez       $a3, .L800F4AEC
    /* E52BC 800F4ABC 025C0500 */   srl       $t3, $a1, 16
    /* E52C0 800F4AC0 00002391 */  lbu        $v1, 0x0($t1)
    /* E52C4 800F4AC4 01002591 */  lbu        $a1, 0x1($t1)
    /* E52C8 800F4AC8 02002925 */  addiu      $t1, $t1, 0x2
    /* E52CC 800F4ACC 23200700 */  negu       $a0, $a3
    /* E52D0 800F4AD0 1000E724 */  addiu      $a3, $a3, 0x10
    /* E52D4 800F4AD4 00120800 */  sll        $v0, $t0, 8
    /* E52D8 800F4AD8 25406200 */  or         $t0, $v1, $v0
    /* E52DC 800F4ADC 00120800 */  sll        $v0, $t0, 8
    /* E52E0 800F4AE0 2540A200 */  or         $t0, $a1, $v0
    /* E52E4 800F4AE4 04288800 */  sllv       $a1, $t0, $a0
    /* E52E8 800F4AE8 025C0500 */  srl        $t3, $a1, 16
  .L800F4AEC:
    /* E52EC 800F4AEC F0FFE724 */  addiu      $a3, $a3, -0x10
    /* E52F0 800F4AF0 0B00E104 */  bgez       $a3, .L800F4B20
    /* E52F4 800F4AF4 002C0500 */   sll       $a1, $a1, 16
    /* E52F8 800F4AF8 00002391 */  lbu        $v1, 0x0($t1)
    /* E52FC 800F4AFC 01002591 */  lbu        $a1, 0x1($t1)
    /* E5300 800F4B00 02002925 */  addiu      $t1, $t1, 0x2
    /* E5304 800F4B04 23200700 */  negu       $a0, $a3
    /* E5308 800F4B08 1000E724 */  addiu      $a3, $a3, 0x10
    /* E530C 800F4B0C 00120800 */  sll        $v0, $t0, 8
    /* E5310 800F4B10 25406200 */  or         $t0, $v1, $v0
    /* E5314 800F4B14 00120800 */  sll        $v0, $t0, 8
    /* E5318 800F4B18 2540A200 */  or         $t0, $a1, $v0
    /* E531C 800F4B1C 04288800 */  sllv       $a1, $t0, $a0
  .L800F4B20:
    /* E5320 800F4B20 00140600 */  sll        $v0, $a2, 16
    /* E5324 800F4B24 25106201 */  or         $v0, $t3, $v0
    /* E5328 800F4B28 04185001 */  sllv       $v1, $s0, $t2
    /* E532C 800F4B2C DED20308 */  j          .L800F4B78
    /* E5330 800F4B30 21104300 */   addu      $v0, $v0, $v1
  .L800F4B34:
    /* E5334 800F4B34 23104A00 */  subu       $v0, $v0, $t2
    /* E5338 800F4B38 06304500 */  srlv       $a2, $a1, $v0
    /* E533C 800F4B3C 2338EA00 */  subu       $a3, $a3, $t2
    /* E5340 800F4B40 0B00E104 */  bgez       $a3, .L800F4B70
    /* E5344 800F4B44 04284501 */   sllv      $a1, $a1, $t2
    /* E5348 800F4B48 00002391 */  lbu        $v1, 0x0($t1)
    /* E534C 800F4B4C 01002591 */  lbu        $a1, 0x1($t1)
    /* E5350 800F4B50 02002925 */  addiu      $t1, $t1, 0x2
    /* E5354 800F4B54 23200700 */  negu       $a0, $a3
    /* E5358 800F4B58 1000E724 */  addiu      $a3, $a3, 0x10
    /* E535C 800F4B5C 00120800 */  sll        $v0, $t0, 8
    /* E5360 800F4B60 25406200 */  or         $t0, $v1, $v0
    /* E5364 800F4B64 00120800 */  sll        $v0, $t0, 8
    /* E5368 800F4B68 2540A200 */  or         $t0, $a1, $v0
    /* E536C 800F4B6C 04288800 */  sllv       $a1, $t0, $a0
  .L800F4B70:
    /* E5370 800F4B70 04105001 */  sllv       $v0, $s0, $t2
    /* E5374 800F4B74 2110C200 */  addu       $v0, $a2, $v0
  .L800F4B78:
    /* E5378 800F4B78 FCFF4624 */  addiu      $a2, $v0, -0x4
  .L800F4B7C:
    /* E537C 800F4B7C 0100C624 */  addiu      $a2, $a2, 0x1
  .L800F4B80:
    /* E5380 800F4B80 0100A425 */  addiu      $a0, $t5, 0x1
    /* E5384 800F4B84 21688000 */  addu       $t5, $a0, $zero
    /* E5388 800F4B88 FF00A231 */  andi       $v0, $t5, 0xFF
    /* E538C 800F4B8C 2118C201 */  addu       $v1, $t6, $v0
    /* E5390 800F4B90 00006280 */  lb         $v0, 0x0($v1)
    /* E5394 800F4B94 00000000 */  nop
    /* E5398 800F4B98 02004014 */  bnez       $v0, .L800F4BA4
    /* E539C 800F4B9C 00000000 */   nop
    /* E53A0 800F4BA0 FFFFC624 */  addiu      $a2, $a2, -0x1
  .L800F4BA4:
    /* E53A4 800F4BA4 F6FFC014 */  bnez       $a2, .L800F4B80
    /* E53A8 800F4BA8 2110AC03 */   addu      $v0, $sp, $t4
    /* E53AC 800F4BAC 01008C25 */  addiu      $t4, $t4, 0x1
    /* E53B0 800F4BB0 000070A0 */  sb         $s0, 0x0($v1)
    /* E53B4 800F4BB4 C00044A0 */  sb         $a0, 0xC0($v0)
    /* E53B8 800F4BB8 2A109101 */  slt        $v0, $t4, $s1
    /* E53BC 800F4BBC 7CFF4014 */  bnez       $v0, .L800F49B0
    /* E53C0 800F4BC0 00000000 */   nop
  .L800F4BC4:
    /* E53C4 800F4BC4 10000624 */  addiu      $a2, $zero, 0x10
    /* E53C8 800F4BC8 4040033C */  lui        $v1, (0x40404040 >> 16)
    /* E53CC 800F4BCC 40406334 */  ori        $v1, $v1, (0x40404040 & 0xFFFF)
    /* E53D0 800F4BD0 C002A427 */  addiu      $a0, $sp, 0x2C0
    /* E53D4 800F4BD4 CC02A227 */  addiu      $v0, $sp, 0x2CC
  .L800F4BD8:
    /* E53D8 800F4BD8 000083AC */  sw         $v1, 0x0($a0)
    /* E53DC 800F4BDC F8FF43AC */  sw         $v1, -0x8($v0)
    /* E53E0 800F4BE0 FCFF43AC */  sw         $v1, -0x4($v0)
    /* E53E4 800F4BE4 000043AC */  sw         $v1, 0x0($v0)
    /* E53E8 800F4BE8 10004224 */  addiu      $v0, $v0, 0x10
    /* E53EC 800F4BEC FFFFC624 */  addiu      $a2, $a2, -0x1
    /* E53F0 800F4BF0 F9FFC014 */  bnez       $a2, .L800F4BD8
    /* E53F4 800F4BF4 10008424 */   addiu     $a0, $a0, 0x10
    /* E53F8 800F4BF8 C000B827 */  addiu      $t8, $sp, 0xC0
    /* E53FC 800F4BFC C001AE27 */  addiu      $t6, $sp, 0x1C0
    /* E5400 800F4C00 C002AD27 */  addiu      $t5, $sp, 0x2C0
    /* E5404 800F4C04 3600A01A */  blez       $s5, .L800F4CE0
    /* E5408 800F4C08 01000B24 */   addiu     $t3, $zero, 0x1
    /* E540C 800F4C0C 08001424 */  addiu      $s4, $zero, 0x8
    /* E5410 800F4C10 21986001 */  addu       $s3, $t3, $zero
    /* E5414 800F4C14 FFFF1224 */  addiu      $s2, $zero, -0x1
    /* E5418 800F4C18 FF00D133 */  andi       $s1, $fp, 0xFF
    /* E541C 800F4C1C 0400B927 */  addiu      $t9, $sp, 0x4
  .L800F4C20:
    /* E5420 800F4C20 0000248F */  lw         $a0, 0x0($t9)
    /* E5424 800F4C24 09006229 */  slti       $v0, $t3, 0x9
    /* E5428 800F4C28 1B004010 */  beqz       $v0, .L800F4C98
    /* E542C 800F4C2C FFFF8424 */   addiu     $a0, $a0, -0x1
    /* E5430 800F4C30 23108B02 */  subu       $v0, $s4, $t3
    /* E5434 800F4C34 14009210 */  beq        $a0, $s2, .L800F4C88
    /* E5438 800F4C38 04605300 */   sllv      $t4, $s3, $v0
    /* E543C 800F4C3C FFFF1024 */  addiu      $s0, $zero, -0x1
  .L800F4C40:
    /* E5440 800F4C40 00000A93 */  lbu        $t2, 0x0($t8)
    /* E5444 800F4C44 01001827 */  addiu      $t8, $t8, 0x1
    /* E5448 800F4C48 03005115 */  bne        $t2, $s1, .L800F4C58
    /* E544C 800F4C4C 21306001 */   addu      $a2, $t3, $zero
    /* E5450 800F4C50 C004ABAF */  sw         $t3, 0x4C0($sp)
    /* E5454 800F4C54 60000624 */  addiu      $a2, $zero, 0x60
  .L800F4C58:
    /* E5458 800F4C58 08008019 */  blez       $t4, .L800F4C7C
    /* E545C 800F4C5C 21180000 */   addu      $v1, $zero, $zero
  .L800F4C60:
    /* E5460 800F4C60 0000CAA1 */  sb         $t2, 0x0($t6)
    /* E5464 800F4C64 0100CE25 */  addiu      $t6, $t6, 0x1
    /* E5468 800F4C68 0000A6A1 */  sb         $a2, 0x0($t5)
    /* E546C 800F4C6C 01006324 */  addiu      $v1, $v1, 0x1
    /* E5470 800F4C70 2A106C00 */  slt        $v0, $v1, $t4
    /* E5474 800F4C74 FAFF4014 */  bnez       $v0, .L800F4C60
    /* E5478 800F4C78 0100AD25 */   addiu     $t5, $t5, 0x1
  .L800F4C7C:
    /* E547C 800F4C7C FFFF8424 */  addiu      $a0, $a0, -0x1
    /* E5480 800F4C80 EFFF9014 */  bne        $a0, $s0, .L800F4C40
    /* E5484 800F4C84 00000000 */   nop
  .L800F4C88:
    /* E5488 800F4C88 01006B25 */  addiu      $t3, $t3, 0x1
    /* E548C 800F4C8C 2A10AB02 */  slt        $v0, $s5, $t3
    /* E5490 800F4C90 E3FF4010 */  beqz       $v0, .L800F4C20
    /* E5494 800F4C94 04003927 */   addiu     $t9, $t9, 0x4
  .L800F4C98:
    /* E5498 800F4C98 C001AE27 */  addiu      $t6, $sp, 0x1C0
    /* E549C 800F4C9C 38D30308 */  j          .L800F4CE0
    /* E54A0 800F4CA0 C002AD27 */   addiu     $t5, $sp, 0x2C0
  .L800F4CA4:
    /* E54A4 800F4CA4 2110C201 */  addu       $v0, $t6, $v0
    /* E54A8 800F4CA8 00004290 */  lbu        $v0, 0x0($v0)
    /* E54AC 800F4CAC 00000000 */  nop
    /* E54B0 800F4CB0 0000E2A1 */  sb         $v0, 0x0($t7)
    /* E54B4 800F4CB4 0100EF25 */  addiu      $t7, $t7, 0x1
    /* E54B8 800F4CB8 00002391 */  lbu        $v1, 0x0($t1)
    /* E54BC 800F4CBC 01002491 */  lbu        $a0, 0x1($t1)
    /* E54C0 800F4CC0 02002925 */  addiu      $t1, $t1, 0x2
    /* E54C4 800F4CC4 00120800 */  sll        $v0, $t0, 8
    /* E54C8 800F4CC8 25406200 */  or         $t0, $v1, $v0
    /* E54CC 800F4CCC 00120800 */  sll        $v0, $t0, 8
    /* E54D0 800F4CD0 25408200 */  or         $t0, $a0, $v0
    /* E54D4 800F4CD4 10000224 */  addiu      $v0, $zero, 0x10
    /* E54D8 800F4CD8 23104700 */  subu       $v0, $v0, $a3
    /* E54DC 800F4CDC 04284800 */  sllv       $a1, $t0, $v0
  .L800F4CE0:
    /* E54E0 800F4CE0 021E0500 */  srl        $v1, $a1, 24
    /* E54E4 800F4CE4 2110A301 */  addu       $v0, $t5, $v1
    /* E54E8 800F4CE8 00004690 */  lbu        $a2, 0x0($v0)
    /* E54EC 800F4CEC 5CD30308 */  j          .L800F4D70
    /* E54F0 800F4CF0 2338E600 */   subu      $a3, $a3, $a2
  .L800F4CF4:
    /* E54F4 800F4CF4 2110C301 */  addu       $v0, $t6, $v1
    /* E54F8 800F4CF8 0428C500 */  sllv       $a1, $a1, $a2
    /* E54FC 800F4CFC 00004290 */  lbu        $v0, 0x0($v0)
    /* E5500 800F4D00 021E0500 */  srl        $v1, $a1, 24
    /* E5504 800F4D04 0000E2A1 */  sb         $v0, 0x0($t7)
    /* E5508 800F4D08 2110A301 */  addu       $v0, $t5, $v1
    /* E550C 800F4D0C 00004690 */  lbu        $a2, 0x0($v0)
    /* E5510 800F4D10 00000000 */  nop
    /* E5514 800F4D14 2338E600 */  subu       $a3, $a3, $a2
    /* E5518 800F4D18 2100E004 */  bltz       $a3, .L800F4DA0
    /* E551C 800F4D1C 0100EF25 */   addiu     $t7, $t7, 0x1
    /* E5520 800F4D20 2110C301 */  addu       $v0, $t6, $v1
    /* E5524 800F4D24 0428C500 */  sllv       $a1, $a1, $a2
    /* E5528 800F4D28 00004290 */  lbu        $v0, 0x0($v0)
    /* E552C 800F4D2C 021E0500 */  srl        $v1, $a1, 24
    /* E5530 800F4D30 0000E2A1 */  sb         $v0, 0x0($t7)
    /* E5534 800F4D34 2110A301 */  addu       $v0, $t5, $v1
    /* E5538 800F4D38 00004690 */  lbu        $a2, 0x0($v0)
    /* E553C 800F4D3C 00000000 */  nop
    /* E5540 800F4D40 2338E600 */  subu       $a3, $a3, $a2
    /* E5544 800F4D44 1600E004 */  bltz       $a3, .L800F4DA0
    /* E5548 800F4D48 0100EF25 */   addiu     $t7, $t7, 0x1
    /* E554C 800F4D4C 2110C301 */  addu       $v0, $t6, $v1
    /* E5550 800F4D50 0428C500 */  sllv       $a1, $a1, $a2
    /* E5554 800F4D54 00004290 */  lbu        $v0, 0x0($v0)
    /* E5558 800F4D58 021E0500 */  srl        $v1, $a1, 24
    /* E555C 800F4D5C 0000E2A1 */  sb         $v0, 0x0($t7)
    /* E5560 800F4D60 2110A301 */  addu       $v0, $t5, $v1
    /* E5564 800F4D64 00004690 */  lbu        $a2, 0x0($v0)
    /* E5568 800F4D68 0100EF25 */  addiu      $t7, $t7, 0x1
    /* E556C 800F4D6C 2338E600 */  subu       $a3, $a3, $a2
  .L800F4D70:
    /* E5570 800F4D70 0B00E004 */  bltz       $a3, .L800F4DA0
    /* E5574 800F4D74 2110C301 */   addu      $v0, $t6, $v1
    /* E5578 800F4D78 0428C500 */  sllv       $a1, $a1, $a2
    /* E557C 800F4D7C 00004290 */  lbu        $v0, 0x0($v0)
    /* E5580 800F4D80 021E0500 */  srl        $v1, $a1, 24
    /* E5584 800F4D84 0000E2A1 */  sb         $v0, 0x0($t7)
    /* E5588 800F4D88 2110A301 */  addu       $v0, $t5, $v1
    /* E558C 800F4D8C 00004690 */  lbu        $a2, 0x0($v0)
    /* E5590 800F4D90 00000000 */  nop
    /* E5594 800F4D94 2338E600 */  subu       $a3, $a3, $a2
    /* E5598 800F4D98 D6FFE104 */  bgez       $a3, .L800F4CF4
    /* E559C 800F4D9C 0100EF25 */   addiu     $t7, $t7, 0x1
  .L800F4DA0:
    /* E55A0 800F4DA0 1000E724 */  addiu      $a3, $a3, 0x10
    /* E55A4 800F4DA4 BFFFE104 */  bgez       $a3, .L800F4CA4
    /* E55A8 800F4DA8 02160500 */   srl       $v0, $a1, 24
    /* E55AC 800F4DAC F0FFC224 */  addiu      $v0, $a2, -0x10
    /* E55B0 800F4DB0 2138E200 */  addu       $a3, $a3, $v0
    /* E55B4 800F4DB4 60000224 */  addiu      $v0, $zero, 0x60
    /* E55B8 800F4DB8 0B00C210 */  beq        $a2, $v0, .L800F4DE8
    /* E55BC 800F4DBC 02240500 */   srl       $a0, $a1, 16
    /* E55C0 800F4DC0 08000624 */  addiu      $a2, $zero, 0x8
    /* E55C4 800F4DC4 A000A327 */  addiu      $v1, $sp, 0xA0
  .L800F4DC8:
    /* E55C8 800F4DC8 04006324 */  addiu      $v1, $v1, 0x4
    /* E55CC 800F4DCC 0000628C */  lw         $v0, 0x0($v1)
    /* E55D0 800F4DD0 00000000 */  nop
    /* E55D4 800F4DD4 2B108200 */  sltu       $v0, $a0, $v0
    /* E55D8 800F4DD8 FBFF4010 */  beqz       $v0, .L800F4DC8
    /* E55DC 800F4DDC 0100C624 */   addiu     $a2, $a2, 0x1
    /* E55E0 800F4DE0 7CD30308 */  j          .L800F4DF0
    /* E55E4 800F4DE4 20000224 */   addiu     $v0, $zero, 0x20
  .L800F4DE8:
    /* E55E8 800F4DE8 C004A68F */  lw         $a2, 0x4C0($sp)
    /* E55EC 800F4DEC 20000224 */  addiu      $v0, $zero, 0x20
  .L800F4DF0:
    /* E55F0 800F4DF0 23104600 */  subu       $v0, $v0, $a2
    /* E55F4 800F4DF4 06204500 */  srlv       $a0, $a1, $v0
    /* E55F8 800F4DF8 80100600 */  sll        $v0, $a2, 2
    /* E55FC 800F4DFC 2110A203 */  addu       $v0, $sp, $v0
    /* E5600 800F4E00 4000428C */  lw         $v0, 0x40($v0)
    /* E5604 800F4E04 0428C500 */  sllv       $a1, $a1, $a2
    /* E5608 800F4E08 23108200 */  subu       $v0, $a0, $v0
    /* E560C 800F4E0C 2110A203 */  addu       $v0, $sp, $v0
    /* E5610 800F4E10 C0004A90 */  lbu        $t2, 0xC0($v0)
    /* E5614 800F4E14 00000000 */  nop
    /* E5618 800F4E18 05005E11 */  beq        $t2, $fp, .L800F4E30
    /* E561C 800F4E1C 2338E600 */   subu      $a3, $a3, $a2
    /* E5620 800F4E20 0500E004 */  bltz       $a3, .L800F4E38
    /* E5624 800F4E24 00000000 */   nop
    /* E5628 800F4E28 9BD30308 */  j          .L800F4E6C
    /* E562C 800F4E2C 0000EAA1 */   sb        $t2, 0x0($t7)
  .L800F4E30:
    /* E5630 800F4E30 0B00E104 */  bgez       $a3, .L800F4E60
    /* E5634 800F4E34 00000000 */   nop
  .L800F4E38:
    /* E5638 800F4E38 00002391 */  lbu        $v1, 0x0($t1)
    /* E563C 800F4E3C 01002591 */  lbu        $a1, 0x1($t1)
    /* E5640 800F4E40 02002925 */  addiu      $t1, $t1, 0x2
    /* E5644 800F4E44 23200700 */  negu       $a0, $a3
    /* E5648 800F4E48 1000E724 */  addiu      $a3, $a3, 0x10
    /* E564C 800F4E4C 00120800 */  sll        $v0, $t0, 8
    /* E5650 800F4E50 25406200 */  or         $t0, $v1, $v0
    /* E5654 800F4E54 00120800 */  sll        $v0, $t0, 8
    /* E5658 800F4E58 2540A200 */  or         $t0, $a1, $v0
    /* E565C 800F4E5C 04288800 */  sllv       $a1, $t0, $a0
  .L800F4E60:
    /* E5660 800F4E60 04005E11 */  beq        $t2, $fp, .L800F4E74
    /* E5664 800F4E64 00000000 */   nop
    /* E5668 800F4E68 0000EAA1 */  sb         $t2, 0x0($t7)
  .L800F4E6C:
    /* E566C 800F4E6C 38D30308 */  j          .L800F4CE0
    /* E5670 800F4E70 0100EF25 */   addiu     $t7, $t7, 0x1
  .L800F4E74:
    /* E5674 800F4E74 1100A104 */  bgez       $a1, .L800F4EBC
    /* E5678 800F4E78 2158E001 */   addu      $t3, $t7, $zero
    /* E567C 800F4E7C 42570500 */  srl        $t2, $a1, 29
    /* E5680 800F4E80 FDFFE724 */  addiu      $a3, $a3, -0x3
    /* E5684 800F4E84 0B00E104 */  bgez       $a3, .L800F4EB4
    /* E5688 800F4E88 C0280500 */   sll       $a1, $a1, 3
    /* E568C 800F4E8C 00002391 */  lbu        $v1, 0x0($t1)
    /* E5690 800F4E90 01002591 */  lbu        $a1, 0x1($t1)
    /* E5694 800F4E94 02002925 */  addiu      $t1, $t1, 0x2
    /* E5698 800F4E98 23200700 */  negu       $a0, $a3
    /* E569C 800F4E9C 1000E724 */  addiu      $a3, $a3, 0x10
    /* E56A0 800F4EA0 00120800 */  sll        $v0, $t0, 8
    /* E56A4 800F4EA4 25406200 */  or         $t0, $v1, $v0
    /* E56A8 800F4EA8 00120800 */  sll        $v0, $t0, 8
    /* E56AC 800F4EAC 2540A200 */  or         $t0, $a1, $v0
    /* E56B0 800F4EB0 04288800 */  sllv       $a1, $t0, $a0
  .L800F4EB4:
    /* E56B4 800F4EB4 14D40308 */  j          .L800F5050
    /* E56B8 800F4EB8 FCFF4A25 */   addiu     $t2, $t2, -0x4
  .L800F4EBC:
    /* E56BC 800F4EBC 02140500 */  srl        $v0, $a1, 16
    /* E56C0 800F4EC0 13004010 */  beqz       $v0, .L800F4F10
    /* E56C4 800F4EC4 02000624 */   addiu     $a2, $zero, 0x2
  .L800F4EC8:
    /* E56C8 800F4EC8 40280500 */  sll        $a1, $a1, 1
    /* E56CC 800F4ECC FEFFA104 */  bgez       $a1, .L800F4EC8
    /* E56D0 800F4ED0 0100C624 */   addiu     $a2, $a2, 0x1
    /* E56D4 800F4ED4 0100E224 */  addiu      $v0, $a3, 0x1
    /* E56D8 800F4ED8 23384600 */  subu       $a3, $v0, $a2
    /* E56DC 800F4EDC 1E00E104 */  bgez       $a3, .L800F4F58
    /* E56E0 800F4EE0 40280500 */   sll       $a1, $a1, 1
    /* E56E4 800F4EE4 00002391 */  lbu        $v1, 0x0($t1)
    /* E56E8 800F4EE8 01002591 */  lbu        $a1, 0x1($t1)
    /* E56EC 800F4EEC 02002925 */  addiu      $t1, $t1, 0x2
    /* E56F0 800F4EF0 23200700 */  negu       $a0, $a3
    /* E56F4 800F4EF4 1000E724 */  addiu      $a3, $a3, 0x10
    /* E56F8 800F4EF8 00120800 */  sll        $v0, $t0, 8
    /* E56FC 800F4EFC 25406200 */  or         $t0, $v1, $v0
    /* E5700 800F4F00 00120800 */  sll        $v0, $t0, 8
    /* E5704 800F4F04 2540A200 */  or         $t0, $a1, $v0
    /* E5708 800F4F08 D6D30308 */  j          .L800F4F58
    /* E570C 800F4F0C 04288800 */   sllv      $a1, $t0, $a0
  .L800F4F10:
    /* E5710 800F4F10 0100C624 */  addiu      $a2, $a2, 0x1
  .L800F4F14:
    /* E5714 800F4F14 C2570500 */  srl        $t2, $a1, 31
    /* E5718 800F4F18 FFFFE724 */  addiu      $a3, $a3, -0x1
    /* E571C 800F4F1C 0B00E104 */  bgez       $a3, .L800F4F4C
    /* E5720 800F4F20 40280500 */   sll       $a1, $a1, 1
    /* E5724 800F4F24 00002391 */  lbu        $v1, 0x0($t1)
    /* E5728 800F4F28 01002591 */  lbu        $a1, 0x1($t1)
    /* E572C 800F4F2C 02002925 */  addiu      $t1, $t1, 0x2
    /* E5730 800F4F30 23200700 */  negu       $a0, $a3
    /* E5734 800F4F34 1000E724 */  addiu      $a3, $a3, 0x10
    /* E5738 800F4F38 00120800 */  sll        $v0, $t0, 8
    /* E573C 800F4F3C 25406200 */  or         $t0, $v1, $v0
    /* E5740 800F4F40 00120800 */  sll        $v0, $t0, 8
    /* E5744 800F4F44 2540A200 */  or         $t0, $a1, $v0
    /* E5748 800F4F48 04288800 */  sllv       $a1, $t0, $a0
  .L800F4F4C:
    /* E574C 800F4F4C F1FF4011 */  beqz       $t2, .L800F4F14
    /* E5750 800F4F50 0100C624 */   addiu     $a2, $a2, 0x1
    /* E5754 800F4F54 FFFFC624 */  addiu      $a2, $a2, -0x1
  .L800F4F58:
    /* E5758 800F4F58 1100C228 */  slti       $v0, $a2, 0x11
    /* E575C 800F4F5C 29004014 */  bnez       $v0, .L800F5004
    /* E5760 800F4F60 20000224 */   addiu     $v0, $zero, 0x20
    /* E5764 800F4F64 30000224 */  addiu      $v0, $zero, 0x30
    /* E5768 800F4F68 23104600 */  subu       $v0, $v0, $a2
    /* E576C 800F4F6C 06504500 */  srlv       $t2, $a1, $v0
    /* E5770 800F4F70 F0FFC224 */  addiu      $v0, $a2, -0x10
    /* E5774 800F4F74 04284500 */  sllv       $a1, $a1, $v0
    /* E5778 800F4F78 1000E224 */  addiu      $v0, $a3, 0x10
    /* E577C 800F4F7C 23384600 */  subu       $a3, $v0, $a2
    /* E5780 800F4F80 0C00E104 */  bgez       $a3, .L800F4FB4
    /* E5784 800F4F84 02640500 */   srl       $t4, $a1, 16
    /* E5788 800F4F88 00002391 */  lbu        $v1, 0x0($t1)
    /* E578C 800F4F8C 01002591 */  lbu        $a1, 0x1($t1)
    /* E5790 800F4F90 02002925 */  addiu      $t1, $t1, 0x2
    /* E5794 800F4F94 23200700 */  negu       $a0, $a3
    /* E5798 800F4F98 1000E724 */  addiu      $a3, $a3, 0x10
    /* E579C 800F4F9C 00120800 */  sll        $v0, $t0, 8
    /* E57A0 800F4FA0 25406200 */  or         $t0, $v1, $v0
    /* E57A4 800F4FA4 00120800 */  sll        $v0, $t0, 8
    /* E57A8 800F4FA8 2540A200 */  or         $t0, $a1, $v0
    /* E57AC 800F4FAC 04288800 */  sllv       $a1, $t0, $a0
    /* E57B0 800F4FB0 02640500 */  srl        $t4, $a1, 16
  .L800F4FB4:
    /* E57B4 800F4FB4 F0FFE724 */  addiu      $a3, $a3, -0x10
    /* E57B8 800F4FB8 0B00E104 */  bgez       $a3, .L800F4FE8
    /* E57BC 800F4FBC 002C0500 */   sll       $a1, $a1, 16
    /* E57C0 800F4FC0 00002391 */  lbu        $v1, 0x0($t1)
    /* E57C4 800F4FC4 01002591 */  lbu        $a1, 0x1($t1)
    /* E57C8 800F4FC8 02002925 */  addiu      $t1, $t1, 0x2
    /* E57CC 800F4FCC 23200700 */  negu       $a0, $a3
    /* E57D0 800F4FD0 1000E724 */  addiu      $a3, $a3, 0x10
    /* E57D4 800F4FD4 00120800 */  sll        $v0, $t0, 8
    /* E57D8 800F4FD8 25406200 */  or         $t0, $v1, $v0
    /* E57DC 800F4FDC 00120800 */  sll        $v0, $t0, 8
    /* E57E0 800F4FE0 2540A200 */  or         $t0, $a1, $v0
    /* E57E4 800F4FE4 04288800 */  sllv       $a1, $t0, $a0
  .L800F4FE8:
    /* E57E8 800F4FE8 001C0A00 */  sll        $v1, $t2, 16
    /* E57EC 800F4FEC 25188301 */  or         $v1, $t4, $v1
    /* E57F0 800F4FF0 01000224 */  addiu      $v0, $zero, 0x1
    /* E57F4 800F4FF4 0410C200 */  sllv       $v0, $v0, $a2
    /* E57F8 800F4FF8 21186200 */  addu       $v1, $v1, $v0
    /* E57FC 800F4FFC 14D40308 */  j          .L800F5050
    /* E5800 800F5000 FCFF6A24 */   addiu     $t2, $v1, -0x4
  .L800F5004:
    /* E5804 800F5004 23104600 */  subu       $v0, $v0, $a2
    /* E5808 800F5008 06504500 */  srlv       $t2, $a1, $v0
    /* E580C 800F500C 2338E600 */  subu       $a3, $a3, $a2
    /* E5810 800F5010 0B00E104 */  bgez       $a3, .L800F5040
    /* E5814 800F5014 0428C500 */   sllv      $a1, $a1, $a2
    /* E5818 800F5018 00002391 */  lbu        $v1, 0x0($t1)
    /* E581C 800F501C 01002591 */  lbu        $a1, 0x1($t1)
    /* E5820 800F5020 02002925 */  addiu      $t1, $t1, 0x2
    /* E5824 800F5024 23200700 */  negu       $a0, $a3
    /* E5828 800F5028 1000E724 */  addiu      $a3, $a3, 0x10
    /* E582C 800F502C 00120800 */  sll        $v0, $t0, 8
    /* E5830 800F5030 25406200 */  or         $t0, $v1, $v0
    /* E5834 800F5034 00120800 */  sll        $v0, $t0, 8
    /* E5838 800F5038 2540A200 */  or         $t0, $a1, $v0
    /* E583C 800F503C 04288800 */  sllv       $a1, $t0, $a0
  .L800F5040:
    /* E5840 800F5040 01000224 */  addiu      $v0, $zero, 0x1
    /* E5844 800F5044 0410C200 */  sllv       $v0, $v0, $a2
    /* E5848 800F5048 21104201 */  addu       $v0, $t2, $v0
    /* E584C 800F504C FCFF4A24 */  addiu      $t2, $v0, -0x4
  .L800F5050:
    /* E5850 800F5050 0A004011 */  beqz       $t2, .L800F507C
    /* E5854 800F5054 21186A01 */   addu      $v1, $t3, $t2
    /* E5858 800F5058 FFFF6A91 */  lbu        $t2, -0x1($t3)
  .L800F505C:
    /* E585C 800F505C 00000000 */  nop
    /* E5860 800F5060 00006AA1 */  sb         $t2, 0x0($t3)
    /* E5864 800F5064 01006B25 */  addiu      $t3, $t3, 0x1
    /* E5868 800F5068 2B106301 */  sltu       $v0, $t3, $v1
    /* E586C 800F506C FBFF4014 */  bnez       $v0, .L800F505C
    /* E5870 800F5070 00000000 */   nop
    /* E5874 800F5074 38D30308 */  j          .L800F4CE0
    /* E5878 800F5078 21786001 */   addu      $t7, $t3, $zero
  .L800F507C:
    /* E587C 800F507C C2370500 */  srl        $a2, $a1, 31
    /* E5880 800F5080 FFFFE724 */  addiu      $a3, $a3, -0x1
    /* E5884 800F5084 0B00E104 */  bgez       $a3, .L800F50B4
    /* E5888 800F5088 40280500 */   sll       $a1, $a1, 1
    /* E588C 800F508C 00002391 */  lbu        $v1, 0x0($t1)
    /* E5890 800F5090 01002591 */  lbu        $a1, 0x1($t1)
    /* E5894 800F5094 02002925 */  addiu      $t1, $t1, 0x2
    /* E5898 800F5098 23200700 */  negu       $a0, $a3
    /* E589C 800F509C 1000E724 */  addiu      $a3, $a3, 0x10
    /* E58A0 800F50A0 00120800 */  sll        $v0, $t0, 8
    /* E58A4 800F50A4 25406200 */  or         $t0, $v1, $v0
    /* E58A8 800F50A8 00120800 */  sll        $v0, $t0, 8
    /* E58AC 800F50AC 2540A200 */  or         $t0, $a1, $v0
    /* E58B0 800F50B0 04288800 */  sllv       $a1, $t0, $a0
  .L800F50B4:
    /* E58B4 800F50B4 1100C014 */  bnez       $a2, .L800F50FC
    /* E58B8 800F50B8 02360500 */   srl       $a2, $a1, 24
    /* E58BC 800F50BC F8FFE724 */  addiu      $a3, $a3, -0x8
    /* E58C0 800F50C0 0B00E104 */  bgez       $a3, .L800F50F0
    /* E58C4 800F50C4 002A0500 */   sll       $a1, $a1, 8
    /* E58C8 800F50C8 00002391 */  lbu        $v1, 0x0($t1)
    /* E58CC 800F50CC 01002591 */  lbu        $a1, 0x1($t1)
    /* E58D0 800F50D0 02002925 */  addiu      $t1, $t1, 0x2
    /* E58D4 800F50D4 23200700 */  negu       $a0, $a3
    /* E58D8 800F50D8 1000E724 */  addiu      $a3, $a3, 0x10
    /* E58DC 800F50DC 00120800 */  sll        $v0, $t0, 8
    /* E58E0 800F50E0 25406200 */  or         $t0, $v1, $v0
    /* E58E4 800F50E4 00120800 */  sll        $v0, $t0, 8
    /* E58E8 800F50E8 2540A200 */  or         $t0, $a1, $v0
    /* E58EC 800F50EC 04288800 */  sllv       $a1, $t0, $a0
  .L800F50F0:
    /* E58F0 800F50F0 0000E6A1 */  sb         $a2, 0x0($t7)
    /* E58F4 800F50F4 38D30308 */  j          .L800F4CE0
    /* E58F8 800F50F8 0100EF25 */   addiu     $t7, $t7, 0x1
  .L800F50FC:
    /* E58FC 800F50FC FB320224 */  addiu      $v0, $zero, 0x32FB
    /* E5900 800F5100 1100E216 */  bne        $s7, $v0, .L800F5148
    /* E5904 800F5104 FB340224 */   addiu     $v0, $zero, 0x34FB
    /* E5908 800F5108 F404AF8F */  lw         $t7, 0x4F4($sp)
    /* E590C 800F510C 00000000 */  nop
    /* E5910 800F5110 2120F601 */  addu       $a0, $t7, $s6
    /* E5914 800F5114 2B10E401 */  sltu       $v0, $t7, $a0
    /* E5918 800F5118 1D004010 */  beqz       $v0, .L800F5190
    /* E591C 800F511C 21180000 */   addu      $v1, $zero, $zero
  .L800F5120:
    /* E5920 800F5120 0000E291 */  lbu        $v0, 0x0($t7)
    /* E5924 800F5124 00000000 */  nop
    /* E5928 800F5128 21186200 */  addu       $v1, $v1, $v0
    /* E592C 800F512C 0000E3A1 */  sb         $v1, 0x0($t7)
    /* E5930 800F5130 0100EF25 */  addiu      $t7, $t7, 0x1
    /* E5934 800F5134 2B10E401 */  sltu       $v0, $t7, $a0
    /* E5938 800F5138 F9FF4014 */  bnez       $v0, .L800F5120
    /* E593C 800F513C 2110C002 */   addu      $v0, $s6, $zero
    /* E5940 800F5140 65D40308 */  j          .L800F5194
    /* E5944 800F5144 00000000 */   nop
  .L800F5148:
    /* E5948 800F5148 1200E216 */  bne        $s7, $v0, .L800F5194
    /* E594C 800F514C 2110C002 */   addu      $v0, $s6, $zero
    /* E5950 800F5150 21180000 */  addu       $v1, $zero, $zero
    /* E5954 800F5154 F404AF8F */  lw         $t7, 0x4F4($sp)
    /* E5958 800F5158 00000000 */  nop
    /* E595C 800F515C 2128F601 */  addu       $a1, $t7, $s6
    /* E5960 800F5160 2B10E501 */  sltu       $v0, $t7, $a1
    /* E5964 800F5164 0A004010 */  beqz       $v0, .L800F5190
    /* E5968 800F5168 21206000 */   addu      $a0, $v1, $zero
  .L800F516C:
    /* E596C 800F516C 0000E291 */  lbu        $v0, 0x0($t7)
    /* E5970 800F5170 00000000 */  nop
    /* E5974 800F5174 21186200 */  addu       $v1, $v1, $v0
    /* E5978 800F5178 21208300 */  addu       $a0, $a0, $v1
    /* E597C 800F517C 0000E4A1 */  sb         $a0, 0x0($t7)
    /* E5980 800F5180 0100EF25 */  addiu      $t7, $t7, 0x1
    /* E5984 800F5184 2B10E501 */  sltu       $v0, $t7, $a1
    /* E5988 800F5188 F8FF4014 */  bnez       $v0, .L800F516C
    /* E598C 800F518C 00000000 */   nop
  .L800F5190:
    /* E5990 800F5190 2110C002 */  addu       $v0, $s6, $zero
  .L800F5194:
    /* E5994 800F5194 E804BE8F */  lw         $fp, 0x4E8($sp)
    /* E5998 800F5198 E404B78F */  lw         $s7, 0x4E4($sp)
    /* E599C 800F519C E004B68F */  lw         $s6, 0x4E0($sp)
    /* E59A0 800F51A0 DC04B58F */  lw         $s5, 0x4DC($sp)
    /* E59A4 800F51A4 D804B48F */  lw         $s4, 0x4D8($sp)
    /* E59A8 800F51A8 D404B38F */  lw         $s3, 0x4D4($sp)
    /* E59AC 800F51AC D004B28F */  lw         $s2, 0x4D0($sp)
    /* E59B0 800F51B0 CC04B18F */  lw         $s1, 0x4CC($sp)
    /* E59B4 800F51B4 C804B08F */  lw         $s0, 0x4C8($sp)
    /* E59B8 800F51B8 0800E003 */  jr         $ra
    /* E59BC 800F51BC F004BD27 */   addiu     $sp, $sp, 0x4F0
endlabel unhuff
