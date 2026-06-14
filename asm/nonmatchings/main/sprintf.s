.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching sprintf, 0x884

glabel sprintf
    /* D4CBC 800E44BC 0400A5AF */  sw         $a1, 0x4($sp)
    /* D4CC0 800E44C0 0800A6AF */  sw         $a2, 0x8($sp)
    /* D4CC4 800E44C4 0C00A7AF */  sw         $a3, 0xC($sp)
    /* D4CC8 800E44C8 B0FDBD27 */  addiu      $sp, $sp, -0x250
    /* D4CCC 800E44CC 3802B4AF */  sw         $s4, 0x238($sp)
    /* D4CD0 800E44D0 21A08000 */  addu       $s4, $a0, $zero
    /* D4CD4 800E44D4 5802A227 */  addiu      $v0, $sp, 0x258
    /* D4CD8 800E44D8 4802BFAF */  sw         $ra, 0x248($sp)
    /* D4CDC 800E44DC 4402B7AF */  sw         $s7, 0x244($sp)
    /* D4CE0 800E44E0 4002B6AF */  sw         $s6, 0x240($sp)
    /* D4CE4 800E44E4 3C02B5AF */  sw         $s5, 0x23C($sp)
    /* D4CE8 800E44E8 3402B3AF */  sw         $s3, 0x234($sp)
    /* D4CEC 800E44EC 3002B2AF */  sw         $s2, 0x230($sp)
    /* D4CF0 800E44F0 2C02B1AF */  sw         $s1, 0x22C($sp)
    /* D4CF4 800E44F4 2802B0AF */  sw         $s0, 0x228($sp)
    /* D4CF8 800E44F8 5402A5AF */  sw         $a1, 0x254($sp)
    /* D4CFC 800E44FC 2002A2AF */  sw         $v0, 0x220($sp)
    /* D4D00 800E4500 0000A580 */  lb         $a1, 0x0($a1)
    /* D4D04 800E4504 00000000 */  nop
    /* D4D08 800E4508 FF01A010 */  beqz       $a1, .L800E4D08
    /* D4D0C 800E450C 21900000 */   addu      $s2, $zero, $zero
    /* D4D10 800E4510 2D001724 */  addiu      $s7, $zero, 0x2D
    /* D4D14 800E4514 2B001624 */  addiu      $s6, $zero, 0x2B
    /* D4D18 800E4518 20001524 */  addiu      $s5, $zero, 0x20
    /* D4D1C 800E451C 30001324 */  addiu      $s3, $zero, 0x30
    /* D4D20 800E4520 25000224 */  addiu      $v0, $zero, 0x25
  .L800E4524:
    /* D4D24 800E4524 CA01A214 */  bne        $a1, $v0, .L800E4C50
    /* D4D28 800E4528 21109202 */   addu      $v0, $s4, $s2
    /* D4D2C 800E452C 1280053C */  lui        $a1, %hi(D_8012348C)
    /* D4D30 800E4530 8C34A524 */  addiu      $a1, $a1, %lo(D_8012348C)
    /* D4D34 800E4534 0000A28C */  lw         $v0, 0x0($a1)
    /* D4D38 800E4538 0400A38C */  lw         $v1, 0x4($a1)
    /* D4D3C 800E453C 0800A48C */  lw         $a0, 0x8($a1)
    /* D4D40 800E4540 1002A2AF */  sw         $v0, 0x210($sp)
    /* D4D44 800E4544 1402A3AF */  sw         $v1, 0x214($sp)
    /* D4D48 800E4548 1802A4AF */  sw         $a0, 0x218($sp)
    /* D4D4C 800E454C 23000324 */  addiu      $v1, $zero, 0x23
  .L800E4550:
    /* D4D50 800E4550 5402A68F */  lw         $a2, 0x254($sp)
    /* D4D54 800E4554 00000000 */  nop
    /* D4D58 800E4558 0100C224 */  addiu      $v0, $a2, 0x1
    /* D4D5C 800E455C 5402A2AF */  sw         $v0, 0x254($sp)
    /* D4D60 800E4560 0100C580 */  lb         $a1, 0x1($a2)
    /* D4D64 800E4564 00000000 */  nop
    /* D4D68 800E4568 0600B714 */  bne        $a1, $s7, .L800E4584
    /* D4D6C 800E456C 00000000 */   nop
    /* D4D70 800E4570 1002A28F */  lw         $v0, 0x210($sp)
    /* D4D74 800E4574 00000000 */  nop
    /* D4D78 800E4578 01004234 */  ori        $v0, $v0, 0x1
    /* D4D7C 800E457C 54910308 */  j          .L800E4550
    /* D4D80 800E4580 1002A2AF */   sw        $v0, 0x210($sp)
  .L800E4584:
    /* D4D84 800E4584 0600B614 */  bne        $a1, $s6, .L800E45A0
    /* D4D88 800E4588 00000000 */   nop
    /* D4D8C 800E458C 1002A28F */  lw         $v0, 0x210($sp)
    /* D4D90 800E4590 00000000 */  nop
    /* D4D94 800E4594 02004234 */  ori        $v0, $v0, 0x2
    /* D4D98 800E4598 54910308 */  j          .L800E4550
    /* D4D9C 800E459C 1002A2AF */   sw        $v0, 0x210($sp)
  .L800E45A0:
    /* D4DA0 800E45A0 0300B514 */  bne        $a1, $s5, .L800E45B0
    /* D4DA4 800E45A4 00000000 */   nop
    /* D4DA8 800E45A8 54910308 */  j          .L800E4550
    /* D4DAC 800E45AC 1102A5A3 */   sb        $a1, 0x211($sp)
  .L800E45B0:
    /* D4DB0 800E45B0 0600A314 */  bne        $a1, $v1, .L800E45CC
    /* D4DB4 800E45B4 00000000 */   nop
    /* D4DB8 800E45B8 1002A28F */  lw         $v0, 0x210($sp)
    /* D4DBC 800E45BC 00000000 */  nop
    /* D4DC0 800E45C0 04004234 */  ori        $v0, $v0, 0x4
    /* D4DC4 800E45C4 54910308 */  j          .L800E4550
    /* D4DC8 800E45C8 1002A2AF */   sw        $v0, 0x210($sp)
  .L800E45CC:
    /* D4DCC 800E45CC 0600B314 */  bne        $a1, $s3, .L800E45E8
    /* D4DD0 800E45D0 2A000224 */   addiu     $v0, $zero, 0x2A
    /* D4DD4 800E45D4 1002A28F */  lw         $v0, 0x210($sp)
    /* D4DD8 800E45D8 00000000 */  nop
    /* D4DDC 800E45DC 08004234 */  ori        $v0, $v0, 0x8
    /* D4DE0 800E45E0 54910308 */  j          .L800E4550
    /* D4DE4 800E45E4 1002A2AF */   sw        $v0, 0x210($sp)
  .L800E45E8:
    /* D4DE8 800E45E8 2100A214 */  bne        $a1, $v0, .L800E4670
    /* D4DEC 800E45EC D0FFA224 */   addiu     $v0, $a1, -0x30
    /* D4DF0 800E45F0 2002A28F */  lw         $v0, 0x220($sp)
    /* D4DF4 800E45F4 00000000 */  nop
    /* D4DF8 800E45F8 0000448C */  lw         $a0, 0x0($v0)
    /* D4DFC 800E45FC 04004224 */  addiu      $v0, $v0, 0x4
    /* D4E00 800E4600 2002A2AF */  sw         $v0, 0x220($sp)
    /* D4E04 800E4604 06008104 */  bgez       $a0, .L800E4620
    /* D4E08 800E4608 1402A4AF */   sw        $a0, 0x214($sp)
    /* D4E0C 800E460C 1002A38F */  lw         $v1, 0x210($sp)
    /* D4E10 800E4610 23100400 */  negu       $v0, $a0
    /* D4E14 800E4614 1402A2AF */  sw         $v0, 0x214($sp)
    /* D4E18 800E4618 01006334 */  ori        $v1, $v1, 0x1
    /* D4E1C 800E461C 1002A3AF */  sw         $v1, 0x210($sp)
  .L800E4620:
    /* D4E20 800E4620 0200C224 */  addiu      $v0, $a2, 0x2
    /* D4E24 800E4624 5402A2AF */  sw         $v0, 0x254($sp)
    /* D4E28 800E4628 0200C580 */  lb         $a1, 0x2($a2)
    /* D4E2C 800E462C 9F910308 */  j          .L800E467C
    /* D4E30 800E4630 2E000224 */   addiu     $v0, $zero, 0x2E
  .L800E4634:
    /* D4E34 800E4634 1402A38F */  lw         $v1, 0x214($sp)
    /* D4E38 800E4638 00000000 */  nop
    /* D4E3C 800E463C 80100300 */  sll        $v0, $v1, 2
    /* D4E40 800E4640 21104300 */  addu       $v0, $v0, $v1
    /* D4E44 800E4644 40100200 */  sll        $v0, $v0, 1
    /* D4E48 800E4648 D0FF4224 */  addiu      $v0, $v0, -0x30
    /* D4E4C 800E464C 21104500 */  addu       $v0, $v0, $a1
    /* D4E50 800E4650 1402A2AF */  sw         $v0, 0x214($sp)
    /* D4E54 800E4654 5402A38F */  lw         $v1, 0x254($sp)
    /* D4E58 800E4658 00000000 */  nop
    /* D4E5C 800E465C 01006224 */  addiu      $v0, $v1, 0x1
    /* D4E60 800E4660 5402A2AF */  sw         $v0, 0x254($sp)
    /* D4E64 800E4664 01006580 */  lb         $a1, 0x1($v1)
    /* D4E68 800E4668 00000000 */  nop
    /* D4E6C 800E466C D0FFA224 */  addiu      $v0, $a1, -0x30
  .L800E4670:
    /* D4E70 800E4670 0A00422C */  sltiu      $v0, $v0, 0xA
    /* D4E74 800E4674 EFFF4014 */  bnez       $v0, .L800E4634
    /* D4E78 800E4678 2E000224 */   addiu     $v0, $zero, 0x2E
  .L800E467C:
    /* D4E7C 800E467C 2E00A214 */  bne        $a1, $v0, .L800E4738
    /* D4E80 800E4680 00000000 */   nop
    /* D4E84 800E4684 5402A48F */  lw         $a0, 0x254($sp)
    /* D4E88 800E4688 00000000 */  nop
    /* D4E8C 800E468C 01008224 */  addiu      $v0, $a0, 0x1
    /* D4E90 800E4690 5402A2AF */  sw         $v0, 0x254($sp)
    /* D4E94 800E4694 01008580 */  lb         $a1, 0x1($a0)
    /* D4E98 800E4698 2A000224 */  addiu      $v0, $zero, 0x2A
    /* D4E9C 800E469C 1B00A214 */  bne        $a1, $v0, .L800E470C
    /* D4EA0 800E46A0 D0FFA224 */   addiu     $v0, $a1, -0x30
    /* D4EA4 800E46A4 2002A28F */  lw         $v0, 0x220($sp)
    /* D4EA8 800E46A8 00000000 */  nop
    /* D4EAC 800E46AC 0000438C */  lw         $v1, 0x0($v0)
    /* D4EB0 800E46B0 04004224 */  addiu      $v0, $v0, 0x4
    /* D4EB4 800E46B4 2002A2AF */  sw         $v0, 0x220($sp)
    /* D4EB8 800E46B8 02008224 */  addiu      $v0, $a0, 0x2
    /* D4EBC 800E46BC 1802A3AF */  sw         $v1, 0x218($sp)
    /* D4EC0 800E46C0 5402A2AF */  sw         $v0, 0x254($sp)
    /* D4EC4 800E46C4 02008580 */  lb         $a1, 0x2($a0)
    /* D4EC8 800E46C8 C6910308 */  j          .L800E4718
    /* D4ECC 800E46CC 00000000 */   nop
  .L800E46D0:
    /* D4ED0 800E46D0 1802A38F */  lw         $v1, 0x218($sp)
    /* D4ED4 800E46D4 00000000 */  nop
    /* D4ED8 800E46D8 80100300 */  sll        $v0, $v1, 2
    /* D4EDC 800E46DC 21104300 */  addu       $v0, $v0, $v1
    /* D4EE0 800E46E0 40100200 */  sll        $v0, $v0, 1
    /* D4EE4 800E46E4 D0FF4224 */  addiu      $v0, $v0, -0x30
    /* D4EE8 800E46E8 21104500 */  addu       $v0, $v0, $a1
    /* D4EEC 800E46EC 1802A2AF */  sw         $v0, 0x218($sp)
    /* D4EF0 800E46F0 5402A38F */  lw         $v1, 0x254($sp)
    /* D4EF4 800E46F4 00000000 */  nop
    /* D4EF8 800E46F8 01006224 */  addiu      $v0, $v1, 0x1
    /* D4EFC 800E46FC 5402A2AF */  sw         $v0, 0x254($sp)
    /* D4F00 800E4700 01006580 */  lb         $a1, 0x1($v1)
    /* D4F04 800E4704 00000000 */  nop
    /* D4F08 800E4708 D0FFA224 */  addiu      $v0, $a1, -0x30
  .L800E470C:
    /* D4F0C 800E470C 0A00422C */  sltiu      $v0, $v0, 0xA
    /* D4F10 800E4710 EFFF4014 */  bnez       $v0, .L800E46D0
    /* D4F14 800E4714 00000000 */   nop
  .L800E4718:
    /* D4F18 800E4718 1802A28F */  lw         $v0, 0x218($sp)
    /* D4F1C 800E471C 00000000 */  nop
    /* D4F20 800E4720 05004004 */  bltz       $v0, .L800E4738
    /* D4F24 800E4724 00000000 */   nop
    /* D4F28 800E4728 1002A28F */  lw         $v0, 0x210($sp)
    /* D4F2C 800E472C 00000000 */  nop
    /* D4F30 800E4730 10004234 */  ori        $v0, $v0, 0x10
    /* D4F34 800E4734 1002A2AF */  sw         $v0, 0x210($sp)
  .L800E4738:
    /* D4F38 800E4738 1002A38F */  lw         $v1, 0x210($sp)
    /* D4F3C 800E473C 00000000 */  nop
    /* D4F40 800E4740 01006230 */  andi       $v0, $v1, 0x1
    /* D4F44 800E4744 04004010 */  beqz       $v0, .L800E4758
    /* D4F48 800E4748 1002B127 */   addiu     $s1, $sp, 0x210
    /* D4F4C 800E474C F7FF0224 */  addiu      $v0, $zero, -0x9
    /* D4F50 800E4750 24106200 */  and        $v0, $v1, $v0
    /* D4F54 800E4754 1002A2AF */  sw         $v0, 0x210($sp)
  .L800E4758:
    /* D4F58 800E4758 B4FFA324 */  addiu      $v1, $a1, -0x4C
  .L800E475C:
    /* D4F5C 800E475C 2D00622C */  sltiu      $v0, $v1, 0x2D
    /* D4F60 800E4760 38014010 */  beqz       $v0, .L800E4C44
    /* D4F64 800E4764 80100300 */   sll       $v0, $v1, 2
    /* D4F68 800E4768 0580013C */  lui        $at, %hi(jtbl_80056B60)
    /* D4F6C 800E476C 21082200 */  addu       $at, $at, $v0
    /* D4F70 800E4770 606B228C */  lw         $v0, %lo(jtbl_80056B60)($at)
    /* D4F74 800E4774 00000000 */  nop
    /* D4F78 800E4778 08004000 */  jr         $v0
    /* D4F7C 800E477C 00000000 */   nop
  jlabel .L800E4780
    /* D4F80 800E4780 1002A28F */  lw         $v0, 0x210($sp)
    /* D4F84 800E4784 E9910308 */  j          .L800E47A4
    /* D4F88 800E4788 20004234 */   ori       $v0, $v0, 0x20
  jlabel .L800E478C
    /* D4F8C 800E478C 1002A28F */  lw         $v0, 0x210($sp)
    /* D4F90 800E4790 E9910308 */  j          .L800E47A4
    /* D4F94 800E4794 40004234 */   ori       $v0, $v0, 0x40
  jlabel .L800E4798
    /* D4F98 800E4798 1002A28F */  lw         $v0, 0x210($sp)
    /* D4F9C 800E479C 00000000 */  nop
    /* D4FA0 800E47A0 80004234 */  ori        $v0, $v0, 0x80
  .L800E47A4:
    /* D4FA4 800E47A4 1002A2AF */  sw         $v0, 0x210($sp)
    /* D4FA8 800E47A8 5402A38F */  lw         $v1, 0x254($sp)
    /* D4FAC 800E47AC 00000000 */  nop
    /* D4FB0 800E47B0 01006224 */  addiu      $v0, $v1, 0x1
    /* D4FB4 800E47B4 5402A2AF */  sw         $v0, 0x254($sp)
    /* D4FB8 800E47B8 01006580 */  lb         $a1, 0x1($v1)
    /* D4FBC 800E47BC D7910308 */  j          .L800E475C
    /* D4FC0 800E47C0 B4FFA324 */   addiu     $v1, $a1, -0x4C
  jlabel .L800E47C4
    /* D4FC4 800E47C4 2002A28F */  lw         $v0, 0x220($sp)
    /* D4FC8 800E47C8 00000000 */  nop
    /* D4FCC 800E47CC 0000448C */  lw         $a0, 0x0($v0)
    /* D4FD0 800E47D0 04004224 */  addiu      $v0, $v0, 0x4
    /* D4FD4 800E47D4 2002A2AF */  sw         $v0, 0x220($sp)
    /* D4FD8 800E47D8 1002A38F */  lw         $v1, 0x210($sp)
    /* D4FDC 800E47DC 00000000 */  nop
    /* D4FE0 800E47E0 42110300 */  srl        $v0, $v1, 5
    /* D4FE4 800E47E4 01004230 */  andi       $v0, $v0, 0x1
    /* D4FE8 800E47E8 02004010 */  beqz       $v0, .L800E47F4
    /* D4FEC 800E47EC 00140400 */   sll       $v0, $a0, 16
    /* D4FF0 800E47F0 03240200 */  sra        $a0, $v0, 16
  .L800E47F4:
    /* D4FF4 800E47F4 04008104 */  bgez       $a0, .L800E4808
    /* D4FF8 800E47F8 42100300 */   srl       $v0, $v1, 1
    /* D4FFC 800E47FC 23200400 */  negu       $a0, $a0
    /* D5000 800E4800 14920308 */  j          .L800E4850
    /* D5004 800E4804 1102B7A3 */   sb        $s7, 0x211($sp)
  .L800E4808:
    /* D5008 800E4808 01004230 */  andi       $v0, $v0, 0x1
    /* D500C 800E480C 10004010 */  beqz       $v0, .L800E4850
    /* D5010 800E4810 00000000 */   nop
    /* D5014 800E4814 14920308 */  j          .L800E4850
    /* D5018 800E4818 1102B6A3 */   sb        $s6, 0x211($sp)
  jlabel .L800E481C
    /* D501C 800E481C 2002A28F */  lw         $v0, 0x220($sp)
    /* D5020 800E4820 00000000 */  nop
    /* D5024 800E4824 0000448C */  lw         $a0, 0x0($v0)
    /* D5028 800E4828 04004224 */  addiu      $v0, $v0, 0x4
    /* D502C 800E482C 2002A2AF */  sw         $v0, 0x220($sp)
    /* D5030 800E4830 1002A28F */  lw         $v0, 0x210($sp)
    /* D5034 800E4834 00000000 */  nop
    /* D5038 800E4838 42110200 */  srl        $v0, $v0, 5
    /* D503C 800E483C 01004230 */  andi       $v0, $v0, 0x1
    /* D5040 800E4840 02004010 */  beqz       $v0, .L800E484C
    /* D5044 800E4844 00000000 */   nop
    /* D5048 800E4848 FFFF8430 */  andi       $a0, $a0, 0xFFFF
  .L800E484C:
    /* D504C 800E484C 1102A0A3 */  sb         $zero, 0x211($sp)
  .L800E4850:
    /* D5050 800E4850 1002A38F */  lw         $v1, 0x210($sp)
    /* D5054 800E4854 00000000 */  nop
    /* D5058 800E4858 02110300 */  srl        $v0, $v1, 4
    /* D505C 800E485C 01004230 */  andi       $v0, $v0, 0x1
    /* D5060 800E4860 10004014 */  bnez       $v0, .L800E48A4
    /* D5064 800E4864 C2100300 */   srl       $v0, $v1, 3
    /* D5068 800E4868 01004230 */  andi       $v0, $v0, 0x1
    /* D506C 800E486C 08004010 */  beqz       $v0, .L800E4890
    /* D5070 800E4870 00000000 */   nop
    /* D5074 800E4874 1402A38F */  lw         $v1, 0x214($sp)
    /* D5078 800E4878 1102A283 */  lb         $v0, 0x211($sp)
    /* D507C 800E487C 00000000 */  nop
    /* D5080 800E4880 03004010 */  beqz       $v0, .L800E4890
    /* D5084 800E4884 1802A3AF */   sw        $v1, 0x218($sp)
    /* D5088 800E4888 FFFF6224 */  addiu      $v0, $v1, -0x1
    /* D508C 800E488C 1802A2AF */  sw         $v0, 0x218($sp)
  .L800E4890:
    /* D5090 800E4890 1802A28F */  lw         $v0, 0x218($sp)
    /* D5094 800E4894 00000000 */  nop
    /* D5098 800E4898 0200401C */  bgtz       $v0, .L800E48A4
    /* D509C 800E489C 01000224 */   addiu     $v0, $zero, 0x1
    /* D50A0 800E48A0 1802A2AF */  sw         $v0, 0x218($sp)
  .L800E48A4:
    /* D50A4 800E48A4 10008010 */  beqz       $a0, .L800E48E8
    /* D50A8 800E48A8 21800000 */   addu      $s0, $zero, $zero
    /* D50AC 800E48AC CCCC053C */  lui        $a1, (0xCCCCCCCD >> 16)
    /* D50B0 800E48B0 CDCCA534 */  ori        $a1, $a1, (0xCCCCCCCD & 0xFFFF)
  .L800E48B4:
    /* D50B4 800E48B4 19008500 */  multu      $a0, $a1
    /* D50B8 800E48B8 FFFF3126 */  addiu      $s1, $s1, -0x1
    /* D50BC 800E48BC 01001026 */  addiu      $s0, $s0, 0x1
    /* D50C0 800E48C0 10400000 */  mfhi       $t0
    /* D50C4 800E48C4 C2180800 */  srl        $v1, $t0, 3
    /* D50C8 800E48C8 80100300 */  sll        $v0, $v1, 2
    /* D50CC 800E48CC 21104300 */  addu       $v0, $v0, $v1
    /* D50D0 800E48D0 40100200 */  sll        $v0, $v0, 1
    /* D50D4 800E48D4 23108200 */  subu       $v0, $a0, $v0
    /* D50D8 800E48D8 30004224 */  addiu      $v0, $v0, 0x30
    /* D50DC 800E48DC 21206000 */  addu       $a0, $v1, $zero
    /* D50E0 800E48E0 F4FF8014 */  bnez       $a0, .L800E48B4
    /* D50E4 800E48E4 000022A2 */   sb        $v0, 0x0($s1)
  .L800E48E8:
    /* D50E8 800E48E8 1802A28F */  lw         $v0, 0x218($sp)
    /* D50EC 800E48EC 00000000 */  nop
    /* D50F0 800E48F0 2A100202 */  slt        $v0, $s0, $v0
    /* D50F4 800E48F4 09004010 */  beqz       $v0, .L800E491C
    /* D50F8 800E48F8 00000000 */   nop
    /* D50FC 800E48FC FFFF3126 */  addiu      $s1, $s1, -0x1
  .L800E4900:
    /* D5100 800E4900 000033A2 */  sb         $s3, 0x0($s1)
    /* D5104 800E4904 1802A28F */  lw         $v0, 0x218($sp)
    /* D5108 800E4908 01001026 */  addiu      $s0, $s0, 0x1
    /* D510C 800E490C 2A100202 */  slt        $v0, $s0, $v0
    /* D5110 800E4910 FBFF4014 */  bnez       $v0, .L800E4900
    /* D5114 800E4914 FFFF3126 */   addiu     $s1, $s1, -0x1
    /* D5118 800E4918 01003126 */  addiu      $s1, $s1, 0x1
  .L800E491C:
    /* D511C 800E491C 1102A283 */  lb         $v0, 0x211($sp)
    /* D5120 800E4920 1102A393 */  lbu        $v1, 0x211($sp)
    /* D5124 800E4924 CD004010 */  beqz       $v0, .L800E4C5C
    /* D5128 800E4928 00000000 */   nop
    /* D512C 800E492C FFFF3126 */  addiu      $s1, $s1, -0x1
    /* D5130 800E4930 000023A2 */  sb         $v1, 0x0($s1)
    /* D5134 800E4934 17930308 */  j          .L800E4C5C
    /* D5138 800E4938 01001026 */   addiu     $s0, $s0, 0x1
  jlabel .L800E493C
    /* D513C 800E493C 2002A28F */  lw         $v0, 0x220($sp)
    /* D5140 800E4940 00000000 */  nop
    /* D5144 800E4944 0000448C */  lw         $a0, 0x0($v0)
    /* D5148 800E4948 04004224 */  addiu      $v0, $v0, 0x4
    /* D514C 800E494C 2002A2AF */  sw         $v0, 0x220($sp)
    /* D5150 800E4950 1002A38F */  lw         $v1, 0x210($sp)
    /* D5154 800E4954 00000000 */  nop
    /* D5158 800E4958 42110300 */  srl        $v0, $v1, 5
    /* D515C 800E495C 01004230 */  andi       $v0, $v0, 0x1
    /* D5160 800E4960 02004010 */  beqz       $v0, .L800E496C
    /* D5164 800E4964 02110300 */   srl       $v0, $v1, 4
    /* D5168 800E4968 FFFF8430 */  andi       $a0, $a0, 0xFFFF
  .L800E496C:
    /* D516C 800E496C 01004230 */  andi       $v0, $v0, 0x1
    /* D5170 800E4970 0C004014 */  bnez       $v0, .L800E49A4
    /* D5174 800E4974 C2100300 */   srl       $v0, $v1, 3
    /* D5178 800E4978 01004230 */  andi       $v0, $v0, 0x1
    /* D517C 800E497C 04004010 */  beqz       $v0, .L800E4990
    /* D5180 800E4980 00000000 */   nop
    /* D5184 800E4984 1402A28F */  lw         $v0, 0x214($sp)
    /* D5188 800E4988 00000000 */  nop
    /* D518C 800E498C 1802A2AF */  sw         $v0, 0x218($sp)
  .L800E4990:
    /* D5190 800E4990 1802A28F */  lw         $v0, 0x218($sp)
    /* D5194 800E4994 00000000 */  nop
    /* D5198 800E4998 0200401C */  bgtz       $v0, .L800E49A4
    /* D519C 800E499C 01000224 */   addiu     $v0, $zero, 0x1
    /* D51A0 800E49A0 1802A2AF */  sw         $v0, 0x218($sp)
  .L800E49A4:
    /* D51A4 800E49A4 08008010 */  beqz       $a0, .L800E49C8
    /* D51A8 800E49A8 21800000 */   addu      $s0, $zero, $zero
  .L800E49AC:
    /* D51AC 800E49AC FFFF3126 */  addiu      $s1, $s1, -0x1
    /* D51B0 800E49B0 07008230 */  andi       $v0, $a0, 0x7
    /* D51B4 800E49B4 30004224 */  addiu      $v0, $v0, 0x30
    /* D51B8 800E49B8 000022A2 */  sb         $v0, 0x0($s1)
    /* D51BC 800E49BC C2200400 */  srl        $a0, $a0, 3
    /* D51C0 800E49C0 FAFF8014 */  bnez       $a0, .L800E49AC
    /* D51C4 800E49C4 01001026 */   addiu     $s0, $s0, 0x1
  .L800E49C8:
    /* D51C8 800E49C8 1002A28F */  lw         $v0, 0x210($sp)
    /* D51CC 800E49CC 00000000 */  nop
    /* D51D0 800E49D0 82100200 */  srl        $v0, $v0, 2
    /* D51D4 800E49D4 01004230 */  andi       $v0, $v0, 0x1
    /* D51D8 800E49D8 0A004010 */  beqz       $v0, .L800E4A04
    /* D51DC 800E49DC 00000000 */   nop
    /* D51E0 800E49E0 08000012 */  beqz       $s0, .L800E4A04
    /* D51E4 800E49E4 00000000 */   nop
    /* D51E8 800E49E8 00002282 */  lb         $v0, 0x0($s1)
    /* D51EC 800E49EC 00000000 */  nop
    /* D51F0 800E49F0 04005310 */  beq        $v0, $s3, .L800E4A04
    /* D51F4 800E49F4 00000000 */   nop
    /* D51F8 800E49F8 FFFF3126 */  addiu      $s1, $s1, -0x1
    /* D51FC 800E49FC 000033A2 */  sb         $s3, 0x0($s1)
    /* D5200 800E4A00 01001026 */  addiu      $s0, $s0, 0x1
  .L800E4A04:
    /* D5204 800E4A04 1802A28F */  lw         $v0, 0x218($sp)
    /* D5208 800E4A08 00000000 */  nop
    /* D520C 800E4A0C 2A100202 */  slt        $v0, $s0, $v0
    /* D5210 800E4A10 92004010 */  beqz       $v0, .L800E4C5C
    /* D5214 800E4A14 00000000 */   nop
    /* D5218 800E4A18 FFFF3126 */  addiu      $s1, $s1, -0x1
  .L800E4A1C:
    /* D521C 800E4A1C 000033A2 */  sb         $s3, 0x0($s1)
    /* D5220 800E4A20 1802A28F */  lw         $v0, 0x218($sp)
    /* D5224 800E4A24 01001026 */  addiu      $s0, $s0, 0x1
    /* D5228 800E4A28 2A100202 */  slt        $v0, $s0, $v0
    /* D522C 800E4A2C FBFF4014 */  bnez       $v0, .L800E4A1C
    /* D5230 800E4A30 FFFF3126 */   addiu     $s1, $s1, -0x1
    /* D5234 800E4A34 17930308 */  j          .L800E4C5C
    /* D5238 800E4A38 01003126 */   addiu     $s1, $s1, 0x1
  jlabel .L800E4A3C
    /* D523C 800E4A3C 1002A38F */  lw         $v1, 0x210($sp)
    /* D5240 800E4A40 08000224 */  addiu      $v0, $zero, 0x8
    /* D5244 800E4A44 1802A2AF */  sw         $v0, 0x218($sp)
    /* D5248 800E4A48 50006334 */  ori        $v1, $v1, 0x50
    /* D524C 800E4A4C 1002A3AF */  sw         $v1, 0x210($sp)
  jlabel .L800E4A50
    /* D5250 800E4A50 0580073C */  lui        $a3, %hi(D_80056B38)
    /* D5254 800E4A54 99920308 */  j          .L800E4A64
    /* D5258 800E4A58 386BE724 */   addiu     $a3, $a3, %lo(D_80056B38)
  jlabel .L800E4A5C
    /* D525C 800E4A5C 0580073C */  lui        $a3, %hi(D_80056B4C)
    /* D5260 800E4A60 4C6BE724 */  addiu      $a3, $a3, %lo(D_80056B4C)
  .L800E4A64:
    /* D5264 800E4A64 2002A28F */  lw         $v0, 0x220($sp)
    /* D5268 800E4A68 00000000 */  nop
    /* D526C 800E4A6C 0000448C */  lw         $a0, 0x0($v0)
    /* D5270 800E4A70 04004224 */  addiu      $v0, $v0, 0x4
    /* D5274 800E4A74 2002A2AF */  sw         $v0, 0x220($sp)
    /* D5278 800E4A78 1002A38F */  lw         $v1, 0x210($sp)
    /* D527C 800E4A7C 00000000 */  nop
    /* D5280 800E4A80 42110300 */  srl        $v0, $v1, 5
    /* D5284 800E4A84 01004230 */  andi       $v0, $v0, 0x1
    /* D5288 800E4A88 02004010 */  beqz       $v0, .L800E4A94
    /* D528C 800E4A8C 02110300 */   srl       $v0, $v1, 4
    /* D5290 800E4A90 FFFF8430 */  andi       $a0, $a0, 0xFFFF
  .L800E4A94:
    /* D5294 800E4A94 01004230 */  andi       $v0, $v0, 0x1
    /* D5298 800E4A98 0F004014 */  bnez       $v0, .L800E4AD8
    /* D529C 800E4A9C C2100300 */   srl       $v0, $v1, 3
    /* D52A0 800E4AA0 01004230 */  andi       $v0, $v0, 0x1
    /* D52A4 800E4AA4 07004010 */  beqz       $v0, .L800E4AC4
    /* D52A8 800E4AA8 82100300 */   srl       $v0, $v1, 2
    /* D52AC 800E4AAC 1402A68F */  lw         $a2, 0x214($sp)
    /* D52B0 800E4AB0 01004230 */  andi       $v0, $v0, 0x1
    /* D52B4 800E4AB4 03004010 */  beqz       $v0, .L800E4AC4
    /* D52B8 800E4AB8 1802A6AF */   sw        $a2, 0x218($sp)
    /* D52BC 800E4ABC FEFFC224 */  addiu      $v0, $a2, -0x2
    /* D52C0 800E4AC0 1802A2AF */  sw         $v0, 0x218($sp)
  .L800E4AC4:
    /* D52C4 800E4AC4 1802A28F */  lw         $v0, 0x218($sp)
    /* D52C8 800E4AC8 00000000 */  nop
    /* D52CC 800E4ACC 0200401C */  bgtz       $v0, .L800E4AD8
    /* D52D0 800E4AD0 01000224 */   addiu     $v0, $zero, 0x1
    /* D52D4 800E4AD4 1802A2AF */  sw         $v0, 0x218($sp)
  .L800E4AD8:
    /* D52D8 800E4AD8 09008010 */  beqz       $a0, .L800E4B00
    /* D52DC 800E4ADC 21800000 */   addu      $s0, $zero, $zero
  .L800E4AE0:
    /* D52E0 800E4AE0 FFFF3126 */  addiu      $s1, $s1, -0x1
    /* D52E4 800E4AE4 0F008230 */  andi       $v0, $a0, 0xF
    /* D52E8 800E4AE8 02210400 */  srl        $a0, $a0, 4
    /* D52EC 800E4AEC 2110E200 */  addu       $v0, $a3, $v0
    /* D52F0 800E4AF0 00004290 */  lbu        $v0, 0x0($v0)
    /* D52F4 800E4AF4 01001026 */  addiu      $s0, $s0, 0x1
    /* D52F8 800E4AF8 F9FF8014 */  bnez       $a0, .L800E4AE0
    /* D52FC 800E4AFC 000022A2 */   sb        $v0, 0x0($s1)
  .L800E4B00:
    /* D5300 800E4B00 1802A28F */  lw         $v0, 0x218($sp)
    /* D5304 800E4B04 00000000 */  nop
    /* D5308 800E4B08 2A100202 */  slt        $v0, $s0, $v0
    /* D530C 800E4B0C 09004010 */  beqz       $v0, .L800E4B34
    /* D5310 800E4B10 00000000 */   nop
    /* D5314 800E4B14 FFFF3126 */  addiu      $s1, $s1, -0x1
  .L800E4B18:
    /* D5318 800E4B18 000033A2 */  sb         $s3, 0x0($s1)
    /* D531C 800E4B1C 1802A28F */  lw         $v0, 0x218($sp)
    /* D5320 800E4B20 01001026 */  addiu      $s0, $s0, 0x1
    /* D5324 800E4B24 2A100202 */  slt        $v0, $s0, $v0
    /* D5328 800E4B28 FBFF4014 */  bnez       $v0, .L800E4B18
    /* D532C 800E4B2C FFFF3126 */   addiu     $s1, $s1, -0x1
    /* D5330 800E4B30 01003126 */  addiu      $s1, $s1, 0x1
  .L800E4B34:
    /* D5334 800E4B34 1002A28F */  lw         $v0, 0x210($sp)
    /* D5338 800E4B38 00000000 */  nop
    /* D533C 800E4B3C 82100200 */  srl        $v0, $v0, 2
    /* D5340 800E4B40 01004230 */  andi       $v0, $v0, 0x1
    /* D5344 800E4B44 45004010 */  beqz       $v0, .L800E4C5C
    /* D5348 800E4B48 00000000 */   nop
    /* D534C 800E4B4C FFFF3126 */  addiu      $s1, $s1, -0x1
    /* D5350 800E4B50 000025A2 */  sb         $a1, 0x0($s1)
    /* D5354 800E4B54 FFFF3126 */  addiu      $s1, $s1, -0x1
    /* D5358 800E4B58 02001026 */  addiu      $s0, $s0, 0x2
    /* D535C 800E4B5C 17930308 */  j          .L800E4C5C
    /* D5360 800E4B60 000033A2 */   sb        $s3, 0x0($s1)
  jlabel .L800E4B64
    /* D5364 800E4B64 FFFF3126 */  addiu      $s1, $s1, -0x1
    /* D5368 800E4B68 2002A28F */  lw         $v0, 0x220($sp)
    /* D536C 800E4B6C 01001024 */  addiu      $s0, $zero, 0x1
    /* D5370 800E4B70 00004390 */  lbu        $v1, 0x0($v0)
    /* D5374 800E4B74 04004224 */  addiu      $v0, $v0, 0x4
    /* D5378 800E4B78 000023A2 */  sb         $v1, 0x0($s1)
    /* D537C 800E4B7C 17930308 */  j          .L800E4C5C
    /* D5380 800E4B80 2002A2AF */   sw        $v0, 0x220($sp)
  jlabel .L800E4B84
    /* D5384 800E4B84 2002A28F */  lw         $v0, 0x220($sp)
    /* D5388 800E4B88 1002A38F */  lw         $v1, 0x210($sp)
    /* D538C 800E4B8C 0000518C */  lw         $s1, 0x0($v0)
    /* D5390 800E4B90 04004224 */  addiu      $v0, $v0, 0x4
    /* D5394 800E4B94 2002A2AF */  sw         $v0, 0x220($sp)
    /* D5398 800E4B98 82100300 */  srl        $v0, $v1, 2
    /* D539C 800E4B9C 01004230 */  andi       $v0, $v0, 0x1
    /* D53A0 800E4BA0 0C004010 */  beqz       $v0, .L800E4BD4
    /* D53A4 800E4BA4 02110300 */   srl       $v0, $v1, 4
    /* D53A8 800E4BA8 00003092 */  lbu        $s0, 0x0($s1)
    /* D53AC 800E4BAC 01004230 */  andi       $v0, $v0, 0x1
    /* D53B0 800E4BB0 2A004010 */  beqz       $v0, .L800E4C5C
    /* D53B4 800E4BB4 01003126 */   addiu     $s1, $s1, 0x1
    /* D53B8 800E4BB8 1802A38F */  lw         $v1, 0x218($sp)
    /* D53BC 800E4BBC 00000000 */  nop
    /* D53C0 800E4BC0 2A107000 */  slt        $v0, $v1, $s0
    /* D53C4 800E4BC4 25004010 */  beqz       $v0, .L800E4C5C
    /* D53C8 800E4BC8 00000000 */   nop
    /* D53CC 800E4BCC 17930308 */  j          .L800E4C5C
    /* D53D0 800E4BD0 21806000 */   addu      $s0, $v1, $zero
  .L800E4BD4:
    /* D53D4 800E4BD4 01004230 */  andi       $v0, $v0, 0x1
    /* D53D8 800E4BD8 05004014 */  bnez       $v0, .L800E4BF0
    /* D53DC 800E4BDC 21202002 */   addu      $a0, $s1, $zero
    /* D53E0 800E4BE0 DDA7030C */  jal        strlen
    /* D53E4 800E4BE4 21202002 */   addu      $a0, $s1, $zero
    /* D53E8 800E4BE8 17930308 */  j          .L800E4C5C
    /* D53EC 800E4BEC 21804000 */   addu      $s0, $v0, $zero
  .L800E4BF0:
    /* D53F0 800E4BF0 1802A68F */  lw         $a2, 0x218($sp)
    /* D53F4 800E4BF4 E2F8030C */  jal        memchr
    /* D53F8 800E4BF8 21280000 */   addu      $a1, $zero, $zero
    /* D53FC 800E4BFC 17004014 */  bnez       $v0, .L800E4C5C
    /* D5400 800E4C00 23805100 */   subu      $s0, $v0, $s1
    /* D5404 800E4C04 1802B08F */  lw         $s0, 0x218($sp)
    /* D5408 800E4C08 17930308 */  j          .L800E4C5C
    /* D540C 800E4C0C 00000000 */   nop
  jlabel .L800E4C10
    /* D5410 800E4C10 2002A28F */  lw         $v0, 0x220($sp)
    /* D5414 800E4C14 1002A38F */  lw         $v1, 0x210($sp)
    /* D5418 800E4C18 0000518C */  lw         $s1, 0x0($v0)
    /* D541C 800E4C1C 04004224 */  addiu      $v0, $v0, 0x4
    /* D5420 800E4C20 2002A2AF */  sw         $v0, 0x220($sp)
    /* D5424 800E4C24 42110300 */  srl        $v0, $v1, 5
    /* D5428 800E4C28 01004230 */  andi       $v0, $v0, 0x1
    /* D542C 800E4C2C 03004010 */  beqz       $v0, .L800E4C3C
    /* D5430 800E4C30 00000000 */   nop
    /* D5434 800E4C34 3A930308 */  j          .L800E4CE8
    /* D5438 800E4C38 000032A6 */   sh        $s2, 0x0($s1)
  .L800E4C3C:
    /* D543C 800E4C3C 3A930308 */  j          .L800E4CE8
    /* D5440 800E4C40 000032AE */   sw        $s2, 0x0($s1)
  jlabel .L800E4C44
    /* D5444 800E4C44 25000224 */  addiu      $v0, $zero, 0x25
    /* D5448 800E4C48 2F00A214 */  bne        $a1, $v0, .L800E4D08
    /* D544C 800E4C4C 21109202 */   addu      $v0, $s4, $s2
  .L800E4C50:
    /* D5450 800E4C50 000045A0 */  sb         $a1, 0x0($v0)
    /* D5454 800E4C54 3A930308 */  j          .L800E4CE8
    /* D5458 800E4C58 01005226 */   addiu     $s2, $s2, 0x1
  .L800E4C5C:
    /* D545C 800E4C5C 1402A28F */  lw         $v0, 0x214($sp)
    /* D5460 800E4C60 00000000 */  nop
    /* D5464 800E4C64 2A100202 */  slt        $v0, $s0, $v0
    /* D5468 800E4C68 10004010 */  beqz       $v0, .L800E4CAC
    /* D546C 800E4C6C 21209202 */   addu      $a0, $s4, $s2
    /* D5470 800E4C70 1002A28F */  lw         $v0, 0x210($sp)
    /* D5474 800E4C74 00000000 */  nop
    /* D5478 800E4C78 01004230 */  andi       $v0, $v0, 0x1
    /* D547C 800E4C7C 0C004014 */  bnez       $v0, .L800E4CB0
    /* D5480 800E4C80 21282002 */   addu      $a1, $s1, $zero
  .L800E4C84:
    /* D5484 800E4C84 21109202 */  addu       $v0, $s4, $s2
    /* D5488 800E4C88 000055A0 */  sb         $s5, 0x0($v0)
    /* D548C 800E4C8C 1402A28F */  lw         $v0, 0x214($sp)
    /* D5490 800E4C90 00000000 */  nop
    /* D5494 800E4C94 FFFF4224 */  addiu      $v0, $v0, -0x1
    /* D5498 800E4C98 1402A2AF */  sw         $v0, 0x214($sp)
    /* D549C 800E4C9C 2A100202 */  slt        $v0, $s0, $v0
    /* D54A0 800E4CA0 F8FF4014 */  bnez       $v0, .L800E4C84
    /* D54A4 800E4CA4 01005226 */   addiu     $s2, $s2, 0x1
    /* D54A8 800E4CA8 21209202 */  addu       $a0, $s4, $s2
  .L800E4CAC:
    /* D54AC 800E4CAC 21282002 */  addu       $a1, $s1, $zero
  .L800E4CB0:
    /* D54B0 800E4CB0 E6F8030C */  jal        memmove
    /* D54B4 800E4CB4 21300002 */   addu      $a2, $s0, $zero
    /* D54B8 800E4CB8 1402A28F */  lw         $v0, 0x214($sp)
    /* D54BC 800E4CBC 00000000 */  nop
    /* D54C0 800E4CC0 2A100202 */  slt        $v0, $s0, $v0
    /* D54C4 800E4CC4 08004010 */  beqz       $v0, .L800E4CE8
    /* D54C8 800E4CC8 21905002 */   addu      $s2, $s2, $s0
  .L800E4CCC:
    /* D54CC 800E4CCC 21109202 */  addu       $v0, $s4, $s2
    /* D54D0 800E4CD0 000055A0 */  sb         $s5, 0x0($v0)
    /* D54D4 800E4CD4 1402A28F */  lw         $v0, 0x214($sp)
    /* D54D8 800E4CD8 01001026 */  addiu      $s0, $s0, 0x1
    /* D54DC 800E4CDC 2A100202 */  slt        $v0, $s0, $v0
    /* D54E0 800E4CE0 FAFF4014 */  bnez       $v0, .L800E4CCC
    /* D54E4 800E4CE4 01005226 */   addiu     $s2, $s2, 0x1
  .L800E4CE8:
    /* D54E8 800E4CE8 5402A38F */  lw         $v1, 0x254($sp)
    /* D54EC 800E4CEC 00000000 */  nop
    /* D54F0 800E4CF0 01006224 */  addiu      $v0, $v1, 0x1
    /* D54F4 800E4CF4 5402A2AF */  sw         $v0, 0x254($sp)
    /* D54F8 800E4CF8 01006580 */  lb         $a1, 0x1($v1)
    /* D54FC 800E4CFC 00000000 */  nop
    /* D5500 800E4D00 08FEA014 */  bnez       $a1, .L800E4524
    /* D5504 800E4D04 25000224 */   addiu     $v0, $zero, 0x25
  .L800E4D08:
    /* D5508 800E4D08 21109202 */  addu       $v0, $s4, $s2
    /* D550C 800E4D0C 000040A0 */  sb         $zero, 0x0($v0)
    /* D5510 800E4D10 21104002 */  addu       $v0, $s2, $zero
    /* D5514 800E4D14 4802BF8F */  lw         $ra, 0x248($sp)
    /* D5518 800E4D18 4402B78F */  lw         $s7, 0x244($sp)
    /* D551C 800E4D1C 4002B68F */  lw         $s6, 0x240($sp)
    /* D5520 800E4D20 3C02B58F */  lw         $s5, 0x23C($sp)
    /* D5524 800E4D24 3802B48F */  lw         $s4, 0x238($sp)
    /* D5528 800E4D28 3402B38F */  lw         $s3, 0x234($sp)
    /* D552C 800E4D2C 3002B28F */  lw         $s2, 0x230($sp)
    /* D5530 800E4D30 2C02B18F */  lw         $s1, 0x22C($sp)
    /* D5534 800E4D34 2802B08F */  lw         $s0, 0x228($sp)
    /* D5538 800E4D38 0800E003 */  jr         $ra
    /* D553C 800E4D3C 5002BD27 */   addiu     $sp, $sp, 0x250
endlabel sprintf
    /* D5540 800E4D40 00000000 */  nop
    /* D5544 800E4D44 00000000 */  nop
    /* D5548 800E4D48 00000000 */  nop
