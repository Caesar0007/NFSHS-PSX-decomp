.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching DrawBackground__23tScreenControllerConfig, 0x224

glabel DrawBackground__23tScreenControllerConfig
    /* 35640 80044E40 0580023C */  lui        $v0, %hi(menuDefs)
    /* 35644 80044E44 581A428C */  lw         $v0, %lo(menuDefs)($v0)
    /* 35648 80044E48 D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 3564C 80044E4C 2000B0AF */  sw         $s0, 0x20($sp)
    /* 35650 80044E50 21808000 */  addu       $s0, $a0, $zero
    /* 35654 80044E54 2800BFAF */  sw         $ra, 0x28($sp)
    /* 35658 80044E58 2400B1AF */  sw         $s1, 0x24($sp)
    /* 3565C 80044E5C 6C2B4424 */  addiu      $a0, $v0, 0x2B6C
    /* 35660 80044E60 7400828C */  lw         $v0, 0x74($a0)
    /* 35664 80044E64 00000000 */  nop
    /* 35668 80044E68 43100200 */  sra        $v0, $v0, 1
    /* 3566C 80044E6C 21884000 */  addu       $s1, $v0, $zero
    /* 35670 80044E70 00140200 */  sll        $v0, $v0, 16
    /* 35674 80044E74 03140200 */  sra        $v0, $v0, 16
    /* 35678 80044E78 81004228 */  slti       $v0, $v0, 0x81
    /* 3567C 80044E7C 02004014 */  bnez       $v0, .L80044E88
    /* 35680 80044E80 00000000 */   nop
    /* 35684 80044E84 80001124 */  addiu      $s1, $zero, 0x80
  .L80044E88:
    /* 35688 80044E88 9C00028E */  lw         $v0, 0x9C($s0)
    /* 3568C 80044E8C 00000000 */  nop
    /* 35690 80044E90 07004014 */  bnez       $v0, .L80044EB0
    /* 35694 80044E94 00141100 */   sll       $v0, $s1, 16
    /* 35698 80044E98 C371000C */  jal        TransitionIsFinished__12tOptionsMenu
    /* 3569C 80044E9C 00000000 */   nop
    /* 356A0 80044EA0 02004010 */  beqz       $v0, .L80044EAC
    /* 356A4 80044EA4 01000224 */   addiu     $v0, $zero, 0x1
    /* 356A8 80044EA8 9C0002AE */  sw         $v0, 0x9C($s0)
  .L80044EAC:
    /* 356AC 80044EAC 00141100 */  sll        $v0, $s1, 16
  .L80044EB0:
    /* 356B0 80044EB0 03140200 */  sra        $v0, $v0, 16
    /* 356B4 80044EB4 81004228 */  slti       $v0, $v0, 0x81
    /* 356B8 80044EB8 1B004010 */  beqz       $v0, .L80044F28
    /* 356BC 80044EBC 0580023C */   lui       $v0, %hi(menuDefs)
    /* 356C0 80044EC0 A000028E */  lw         $v0, 0xA0($s0)
    /* 356C4 80044EC4 00000000 */  nop
    /* 356C8 80044EC8 17004014 */  bnez       $v0, .L80044F28
    /* 356CC 80044ECC 0580023C */   lui       $v0, %hi(menuDefs)
    /* 356D0 80044ED0 74010292 */  lbu        $v0, 0x174($s0)
    /* 356D4 80044ED4 00000000 */  nop
    /* 356D8 80044ED8 12004010 */  beqz       $v0, .L80044F24
    /* 356DC 80044EDC 01000524 */   addiu     $a1, $zero, 0x1
    /* 356E0 80044EE0 21200002 */  addu       $a0, $s0, $zero
    /* 356E4 80044EE4 2130A000 */  addu       $a2, $a1, $zero
    /* 356E8 80044EE8 2110A000 */  addu       $v0, $a1, $zero
    /* 356EC 80044EEC E70C010C */  jal        AnimKeyPoints__23tScreenControllerConfigbT1
    /* 356F0 80044EF0 8C0002A6 */   sh        $v0, 0x8C($s0)
    /* 356F4 80044EF4 21200002 */  addu       $a0, $s0, $zero
    /* 356F8 80044EF8 01000524 */  addiu      $a1, $zero, 0x1
    /* 356FC 80044EFC 21300000 */  addu       $a2, $zero, $zero
    /* 35700 80044F00 E70C010C */  jal        AnimKeyPoints__23tScreenControllerConfigbT1
    /* 35704 80044F04 8E0002A6 */   sh        $v0, 0x8E($s0)
    /* 35708 80044F08 8E000396 */  lhu        $v1, 0x8E($s0)
    /* 3570C 80044F0C 74010492 */  lbu        $a0, 0x174($s0)
    /* 35710 80044F10 900002A6 */  sh         $v0, 0x90($s0)
    /* 35714 80044F14 01000224 */  addiu      $v0, $zero, 0x1
    /* 35718 80044F18 A00002AE */  sw         $v0, 0xA0($s0)
    /* 3571C 80044F1C 920003A6 */  sh         $v1, 0x92($s0)
    /* 35720 80044F20 940004A6 */  sh         $a0, 0x94($s0)
  .L80044F24:
    /* 35724 80044F24 0580023C */  lui        $v0, %hi(menuDefs)
  .L80044F28:
    /* 35728 80044F28 581A448C */  lw         $a0, %lo(menuDefs)($v0)
    /* 3572C 80044F2C C371000C */  jal        TransitionIsFinished__12tOptionsMenu
    /* 35730 80044F30 6C2B8424 */   addiu     $a0, $a0, 0x2B6C
    /* 35734 80044F34 01004238 */  xori       $v0, $v0, 0x1
    /* 35738 80044F38 1F004010 */  beqz       $v0, .L80044FB8
    /* 3573C 80044F3C 00000000 */   nop
    /* 35740 80044F40 9C00028E */  lw         $v0, 0x9C($s0)
    /* 35744 80044F44 00000000 */  nop
    /* 35748 80044F48 1B004010 */  beqz       $v0, .L80044FB8
    /* 3574C 80044F4C 00000000 */   nop
    /* 35750 80044F50 A400028E */  lw         $v0, 0xA4($s0)
    /* 35754 80044F54 00000000 */  nop
    /* 35758 80044F58 20004014 */  bnez       $v0, .L80044FDC
    /* 3575C 80044F5C 00000000 */   nop
    /* 35760 80044F60 74010292 */  lbu        $v0, 0x174($s0)
    /* 35764 80044F64 00000000 */  nop
    /* 35768 80044F68 13004010 */  beqz       $v0, .L80044FB8
    /* 3576C 80044F6C 21200002 */   addu      $a0, $s0, $zero
    /* 35770 80044F70 21280000 */  addu       $a1, $zero, $zero
    /* 35774 80044F74 01000624 */  addiu      $a2, $zero, 0x1
    /* 35778 80044F78 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 3577C 80044F7C E70C010C */  jal        AnimKeyPoints__23tScreenControllerConfigbT1
    /* 35780 80044F80 8C0002A6 */   sh        $v0, 0x8C($s0)
    /* 35784 80044F84 21200002 */  addu       $a0, $s0, $zero
    /* 35788 80044F88 21280000 */  addu       $a1, $zero, $zero
    /* 3578C 80044F8C 2130A000 */  addu       $a2, $a1, $zero
    /* 35790 80044F90 E70C010C */  jal        AnimKeyPoints__23tScreenControllerConfigbT1
    /* 35794 80044F94 8E0002A6 */   sh        $v0, 0x8E($s0)
    /* 35798 80044F98 8E000396 */  lhu        $v1, 0x8E($s0)
    /* 3579C 80044F9C 74010492 */  lbu        $a0, 0x174($s0)
    /* 357A0 80044FA0 900002A6 */  sh         $v0, 0x90($s0)
    /* 357A4 80044FA4 01000224 */  addiu      $v0, $zero, 0x1
    /* 357A8 80044FA8 A40002AE */  sw         $v0, 0xA4($s0)
    /* 357AC 80044FAC 640102AE */  sw         $v0, 0x164($s0)
    /* 357B0 80044FB0 920003A6 */  sh         $v1, 0x92($s0)
    /* 357B4 80044FB4 940004A6 */  sh         $a0, 0x94($s0)
  .L80044FB8:
    /* 357B8 80044FB8 A400028E */  lw         $v0, 0xA4($s0)
    /* 357BC 80044FBC 00000000 */  nop
    /* 357C0 80044FC0 06004014 */  bnez       $v0, .L80044FDC
    /* 357C4 80044FC4 00000000 */   nop
    /* 357C8 80044FC8 21200002 */  addu       $a0, $s0, $zero
    /* 357CC 80044FCC DE0D010C */  jal        SetCurrentController__23tScreenControllerConfigb
    /* 357D0 80044FD0 21280000 */   addu      $a1, $zero, $zero
    /* 357D4 80044FD4 000D010C */  jal        CheckConfigs__23tScreenControllerConfig
    /* 357D8 80044FD8 21200002 */   addu      $a0, $s0, $zero
  .L80044FDC:
    /* 357DC 80044FDC 8C000286 */  lh         $v0, 0x8C($s0)
    /* 357E0 80044FE0 00000000 */  nop
    /* 357E4 80044FE4 05004014 */  bnez       $v0, .L80044FFC
    /* 357E8 80044FE8 00000000 */   nop
    /* 357EC 80044FEC A400028E */  lw         $v0, 0xA4($s0)
    /* 357F0 80044FF0 00000000 */  nop
    /* 357F4 80044FF4 07004014 */  bnez       $v0, .L80045014
    /* 357F8 80044FF8 00000000 */   nop
  .L80044FFC:
    /* 357FC 80044FFC A000028E */  lw         $v0, 0xA0($s0)
    /* 35800 80045000 00000000 */  nop
    /* 35804 80045004 03004010 */  beqz       $v0, .L80045014
    /* 35808 80045008 00000000 */   nop
    /* 3580C 8004500C 790F010C */  jal        DrawController__23tScreenControllerConfig
    /* 35810 80045010 21200002 */   addu      $a0, $s0, $zero
  .L80045014:
    /* 35814 80045014 21800000 */  addu       $s0, $zero, $zero
    /* 35818 80045018 00141100 */  sll        $v0, $s1, 16
    /* 3581C 8004501C 038C0200 */  sra        $s1, $v0, 16
    /* 35820 80045020 0A000426 */  addiu      $a0, $s0, 0xA
  .L80045024:
    /* 35824 80045024 21280000 */  addu       $a1, $zero, $zero
    /* 35828 80045028 2130A000 */  addu       $a2, $a1, $zero
    /* 3582C 8004502C 2138A000 */  addu       $a3, $a1, $zero
    /* 35830 80045030 1000B1AF */  sw         $s1, 0x10($sp)
    /* 35834 80045034 1400A0AF */  sw         $zero, 0x14($sp)
    /* 35838 80045038 A23A010C */  jal        ScaleShapeExtended__FiiiiiiP18tDrawShapeExtended
    /* 3583C 8004503C 1800A0AF */   sw        $zero, 0x18($sp)
    /* 35840 80045040 01001026 */  addiu      $s0, $s0, 0x1
    /* 35844 80045044 0C00022A */  slti       $v0, $s0, 0xC
    /* 35848 80045048 F6FF4014 */  bnez       $v0, .L80045024
    /* 3584C 8004504C 0A000426 */   addiu     $a0, $s0, 0xA
    /* 35850 80045050 2800BF8F */  lw         $ra, 0x28($sp)
    /* 35854 80045054 2400B18F */  lw         $s1, 0x24($sp)
    /* 35858 80045058 2000B08F */  lw         $s0, 0x20($sp)
    /* 3585C 8004505C 0800E003 */  jr         $ra
    /* 35860 80045060 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel DrawBackground__23tScreenControllerConfig
