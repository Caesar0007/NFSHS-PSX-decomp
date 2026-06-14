.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Physics_DoBarrierCheck__FP8Car_tObj, 0x598

glabel Physics_DoBarrierCheck__FP8Car_tObj
    /* 99CB8 800A94B8 88FFBD27 */  addiu      $sp, $sp, -0x78
    /* 99CBC 800A94BC 5C00B1AF */  sw         $s1, 0x5C($sp)
    /* 99CC0 800A94C0 21888000 */  addu       $s1, $a0, $zero
    /* 99CC4 800A94C4 6800B4AF */  sw         $s4, 0x68($sp)
    /* 99CC8 800A94C8 21A00000 */  addu       $s4, $zero, $zero
    /* 99CCC 800A94CC 7000BFAF */  sw         $ra, 0x70($sp)
    /* 99CD0 800A94D0 6C00B5AF */  sw         $s5, 0x6C($sp)
    /* 99CD4 800A94D4 6400B3AF */  sw         $s3, 0x64($sp)
    /* 99CD8 800A94D8 6000B2AF */  sw         $s2, 0x60($sp)
    /* 99CDC 800A94DC 5800B0AF */  sw         $s0, 0x58($sp)
    /* 99CE0 800A94E0 08003586 */  lh         $s5, 0x8($s1)
    /* 99CE4 800A94E4 1480023C */  lui        $v0, %hi(BWorldSm_slices)
    /* 99CE8 800A94E8 C0C7428C */  lw         $v0, %lo(BWorldSm_slices)($v0)
    /* 99CEC 800A94EC 40191500 */  sll        $v1, $s5, 5
    /* 99CF0 800A94F0 21186200 */  addu       $v1, $v1, $v0
    /* 99CF4 800A94F4 12006280 */  lb         $v0, 0x12($v1)
    /* 99CF8 800A94F8 14006480 */  lb         $a0, 0x14($v1)
    /* 99CFC 800A94FC 402A0200 */  sll        $a1, $v0, 9
    /* 99D00 800A9500 13006280 */  lb         $v0, 0x13($v1)
    /* 99D04 800A9504 21988002 */  addu       $s3, $s4, $zero
    /* 99D08 800A9508 2800A5AF */  sw         $a1, 0x28($sp)
    /* 99D0C 800A950C 2800A68F */  lw         $a2, 0x28($sp)
    /* 99D10 800A9510 40220400 */  sll        $a0, $a0, 9
    /* 99D14 800A9514 3000A4AF */  sw         $a0, 0x30($sp)
    /* 99D18 800A9518 40120200 */  sll        $v0, $v0, 9
    /* 99D1C 800A951C 2C00A2AF */  sw         $v0, 0x2C($sp)
    /* 99D20 800A9520 0000648C */  lw         $a0, 0x0($v1)
    /* 99D24 800A9524 AC00228E */  lw         $v0, 0xAC($s1)
    /* 99D28 800A9528 A000258E */  lw         $a1, 0xA0($s1)
    /* 99D2C 800A952C 43110200 */  sra        $v0, $v0, 5
    /* 99D30 800A9530 2110A200 */  addu       $v0, $a1, $v0
    /* 99D34 800A9534 23384400 */  subu       $a3, $v0, $a0
    /* 99D38 800A9538 1800A7AF */  sw         $a3, 0x18($sp)
    /* 99D3C 800A953C 0400648C */  lw         $a0, 0x4($v1)
    /* 99D40 800A9540 B000228E */  lw         $v0, 0xB0($s1)
    /* 99D44 800A9544 A400258E */  lw         $a1, 0xA4($s1)
    /* 99D48 800A9548 43110200 */  sra        $v0, $v0, 5
    /* 99D4C 800A954C 2110A200 */  addu       $v0, $a1, $v0
    /* 99D50 800A9550 23404400 */  subu       $t0, $v0, $a0
    /* 99D54 800A9554 1C00A8AF */  sw         $t0, 0x1C($sp)
    /* 99D58 800A9558 0800648C */  lw         $a0, 0x8($v1)
    /* 99D5C 800A955C B400228E */  lw         $v0, 0xB4($s1)
    /* 99D60 800A9560 A800258E */  lw         $a1, 0xA8($s1)
    /* 99D64 800A9564 43110200 */  sra        $v0, $v0, 5
    /* 99D68 800A9568 2110A200 */  addu       $v0, $a1, $v0
    /* 99D6C 800A956C 23184400 */  subu       $v1, $v0, $a0
    /* 99D70 800A9570 0200C104 */  bgez       $a2, .L800A957C
    /* 99D74 800A9574 2000A3AF */   sw        $v1, 0x20($sp)
    /* 99D78 800A9578 FF00C624 */  addiu      $a2, $a2, 0xFF
  .L800A957C:
    /* 99D7C 800A957C 2110E000 */  addu       $v0, $a3, $zero
    /* 99D80 800A9580 02004104 */  bgez       $v0, .L800A958C
    /* 99D84 800A9584 03320600 */   sra       $a2, $a2, 8
    /* 99D88 800A9588 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A958C:
    /* 99D8C 800A958C 03120200 */  sra        $v0, $v0, 8
    /* 99D90 800A9590 1800C200 */  mult       $a2, $v0
    /* 99D94 800A9594 2C00A58F */  lw         $a1, 0x2C($sp)
    /* 99D98 800A9598 12480000 */  mflo       $t1
    /* 99D9C 800A959C 0200A104 */  bgez       $a1, .L800A95A8
    /* 99DA0 800A95A0 21100001 */   addu      $v0, $t0, $zero
    /* 99DA4 800A95A4 FF00A524 */  addiu      $a1, $a1, 0xFF
  .L800A95A8:
    /* 99DA8 800A95A8 02004104 */  bgez       $v0, .L800A95B4
    /* 99DAC 800A95AC 03320500 */   sra       $a2, $a1, 8
    /* 99DB0 800A95B0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A95B4:
    /* 99DB4 800A95B4 03120200 */  sra        $v0, $v0, 8
    /* 99DB8 800A95B8 1800C200 */  mult       $a2, $v0
    /* 99DBC 800A95BC 3000A58F */  lw         $a1, 0x30($sp)
    /* 99DC0 800A95C0 12300000 */  mflo       $a2
    /* 99DC4 800A95C4 0200A104 */  bgez       $a1, .L800A95D0
    /* 99DC8 800A95C8 21106000 */   addu      $v0, $v1, $zero
    /* 99DCC 800A95CC FF00A524 */  addiu      $a1, $a1, 0xFF
  .L800A95D0:
    /* 99DD0 800A95D0 02004104 */  bgez       $v0, .L800A95DC
    /* 99DD4 800A95D4 031A0500 */   sra       $v1, $a1, 8
    /* 99DD8 800A95D8 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A95DC:
    /* 99DDC 800A95DC 03120200 */  sra        $v0, $v0, 8
    /* 99DE0 800A95E0 18006200 */  mult       $v1, $v0
    /* 99DE4 800A95E4 21102601 */  addu       $v0, $t1, $a2
    /* 99DE8 800A95E8 0C01248E */  lw         $a0, 0x10C($s1)
    /* 99DEC 800A95EC 0801238E */  lw         $v1, 0x108($s1)
    /* 99DF0 800A95F0 1001278E */  lw         $a3, 0x110($s1)
    /* 99DF4 800A95F4 21286000 */  addu       $a1, $v1, $zero
    /* 99DF8 800A95F8 12500000 */  mflo       $t2
    /* 99DFC 800A95FC 21904A00 */  addu       $s2, $v0, $t2
    /* 99E00 800A9600 02006104 */  bgez       $v1, .L800A960C
    /* 99E04 800A9604 C40032AE */   sw        $s2, 0xC4($s1)
    /* 99E08 800A9608 FF006524 */  addiu      $a1, $v1, 0xFF
  .L800A960C:
    /* 99E0C 800A960C 2800A28F */  lw         $v0, 0x28($sp)
    /* 99E10 800A9610 00000000 */  nop
    /* 99E14 800A9614 02004104 */  bgez       $v0, .L800A9620
    /* 99E18 800A9618 032A0500 */   sra       $a1, $a1, 8
    /* 99E1C 800A961C FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A9620:
    /* 99E20 800A9620 03120200 */  sra        $v0, $v0, 8
    /* 99E24 800A9624 1800A200 */  mult       $a1, $v0
    /* 99E28 800A9628 12480000 */  mflo       $t1
    /* 99E2C 800A962C 02008104 */  bgez       $a0, .L800A9638
    /* 99E30 800A9630 21188000 */   addu      $v1, $a0, $zero
    /* 99E34 800A9634 FF008324 */  addiu      $v1, $a0, 0xFF
  .L800A9638:
    /* 99E38 800A9638 2C00A28F */  lw         $v0, 0x2C($sp)
    /* 99E3C 800A963C 00000000 */  nop
    /* 99E40 800A9640 02004104 */  bgez       $v0, .L800A964C
    /* 99E44 800A9644 03220300 */   sra       $a0, $v1, 8
    /* 99E48 800A9648 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A964C:
    /* 99E4C 800A964C 03120200 */  sra        $v0, $v0, 8
    /* 99E50 800A9650 18008200 */  mult       $a0, $v0
    /* 99E54 800A9654 12300000 */  mflo       $a2
    /* 99E58 800A9658 0200E104 */  bgez       $a3, .L800A9664
    /* 99E5C 800A965C 2118E000 */   addu      $v1, $a3, $zero
    /* 99E60 800A9660 FF00E324 */  addiu      $v1, $a3, 0xFF
  .L800A9664:
    /* 99E64 800A9664 3000A28F */  lw         $v0, 0x30($sp)
    /* 99E68 800A9668 00000000 */  nop
    /* 99E6C 800A966C 02004104 */  bgez       $v0, .L800A9678
    /* 99E70 800A9670 031A0300 */   sra       $v1, $v1, 8
    /* 99E74 800A9674 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A9678:
    /* 99E78 800A9678 03120200 */  sra        $v0, $v0, 8
    /* 99E7C 800A967C 18006200 */  mult       $v1, $v0
    /* 99E80 800A9680 3C01248E */  lw         $a0, 0x13C($s1)
    /* 99E84 800A9684 21102601 */  addu       $v0, $t1, $a2
    /* 99E88 800A9688 12580000 */  mflo       $t3
    /* 99E8C 800A968C 21804B00 */  addu       $s0, $v0, $t3
    /* 99E90 800A9690 CA90030C */  jal        fixedmult
    /* 99E94 800A9694 21280002 */   addu      $a1, $s0, $zero
    /* 99E98 800A9698 06004018 */  blez       $v0, .L800A96B4
    /* 99E9C 800A969C 00000000 */   nop
    /* 99EA0 800A96A0 3C01248E */  lw         $a0, 0x13C($s1)
    /* 99EA4 800A96A4 CA90030C */  jal        fixedmult
    /* 99EA8 800A96A8 21280002 */   addu      $a1, $s0, $zero
    /* 99EAC 800A96AC B1A50208 */  j          .L800A96C4
    /* 99EB0 800A96B0 21404000 */   addu      $t0, $v0, $zero
  .L800A96B4:
    /* 99EB4 800A96B4 3C01248E */  lw         $a0, 0x13C($s1)
    /* 99EB8 800A96B8 CA90030C */  jal        fixedmult
    /* 99EBC 800A96BC 21280002 */   addu      $a1, $s0, $zero
    /* 99EC0 800A96C0 23400200 */  negu       $t0, $v0
  .L800A96C4:
    /* 99EC4 800A96C4 F400248E */  lw         $a0, 0xF4($s1)
    /* 99EC8 800A96C8 F000238E */  lw         $v1, 0xF0($s1)
    /* 99ECC 800A96CC F800278E */  lw         $a3, 0xF8($s1)
    /* 99ED0 800A96D0 02006104 */  bgez       $v1, .L800A96DC
    /* 99ED4 800A96D4 00000000 */   nop
    /* 99ED8 800A96D8 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800A96DC:
    /* 99EDC 800A96DC 2800A28F */  lw         $v0, 0x28($sp)
    /* 99EE0 800A96E0 00000000 */  nop
    /* 99EE4 800A96E4 02004104 */  bgez       $v0, .L800A96F0
    /* 99EE8 800A96E8 032A0300 */   sra       $a1, $v1, 8
    /* 99EEC 800A96EC FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A96F0:
    /* 99EF0 800A96F0 03120200 */  sra        $v0, $v0, 8
    /* 99EF4 800A96F4 1800A200 */  mult       $a1, $v0
    /* 99EF8 800A96F8 21188000 */  addu       $v1, $a0, $zero
    /* 99EFC 800A96FC 12480000 */  mflo       $t1
    /* 99F00 800A9700 02006104 */  bgez       $v1, .L800A970C
    /* 99F04 800A9704 00000000 */   nop
    /* 99F08 800A9708 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800A970C:
    /* 99F0C 800A970C 2C00A28F */  lw         $v0, 0x2C($sp)
    /* 99F10 800A9710 00000000 */  nop
    /* 99F14 800A9714 02004104 */  bgez       $v0, .L800A9720
    /* 99F18 800A9718 03220300 */   sra       $a0, $v1, 8
    /* 99F1C 800A971C FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A9720:
    /* 99F20 800A9720 03120200 */  sra        $v0, $v0, 8
    /* 99F24 800A9724 18008200 */  mult       $a0, $v0
    /* 99F28 800A9728 2118E000 */  addu       $v1, $a3, $zero
    /* 99F2C 800A972C 12300000 */  mflo       $a2
    /* 99F30 800A9730 02006104 */  bgez       $v1, .L800A973C
    /* 99F34 800A9734 00000000 */   nop
    /* 99F38 800A9738 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800A973C:
    /* 99F3C 800A973C 3000A28F */  lw         $v0, 0x30($sp)
    /* 99F40 800A9740 00000000 */  nop
    /* 99F44 800A9744 02004104 */  bgez       $v0, .L800A9750
    /* 99F48 800A9748 032A0300 */   sra       $a1, $v1, 8
    /* 99F4C 800A974C FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A9750:
    /* 99F50 800A9750 03120200 */  sra        $v0, $v0, 8
    /* 99F54 800A9754 1800A200 */  mult       $a1, $v0
    /* 99F58 800A9758 3401238E */  lw         $v1, 0x134($s1)
    /* 99F5C 800A975C 12580000 */  mflo       $t3
    /* 99F60 800A9760 02006104 */  bgez       $v1, .L800A976C
    /* 99F64 800A9764 21102601 */   addu      $v0, $t1, $a2
    /* 99F68 800A9768 FF006324 */  addiu      $v1, $v1, 0xFF
  .L800A976C:
    /* 99F6C 800A976C 21104B00 */  addu       $v0, $v0, $t3
    /* 99F70 800A9770 02004104 */  bgez       $v0, .L800A977C
    /* 99F74 800A9774 03220300 */   sra       $a0, $v1, 8
    /* 99F78 800A9778 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A977C:
    /* 99F7C 800A977C 03120200 */  sra        $v0, $v0, 8
    /* 99F80 800A9780 18008200 */  mult       $a0, $v0
    /* 99F84 800A9784 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 99F88 800A9788 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 99F8C 800A978C 40111500 */  sll        $v0, $s5, 5
    /* 99F90 800A9790 21284300 */  addu       $a1, $v0, $v1
    /* 99F94 800A9794 1800A384 */  lh         $v1, 0x18($a1)
    /* 99F98 800A9798 8407228E */  lw         $v0, 0x784($s1)
    /* 99F9C 800A979C 001A0300 */  sll        $v1, $v1, 8
    /* 99FA0 800A97A0 12500000 */  mflo       $t2
    /* 99FA4 800A97A4 02004105 */  bgez       $t2, .L800A97B0
    /* 99FA8 800A97A8 21204001 */   addu      $a0, $t2, $zero
    /* 99FAC 800A97AC 23200400 */  negu       $a0, $a0
  .L800A97B0:
    /* 99FB0 800A97B0 21400401 */  addu       $t0, $t0, $a0
    /* 99FB4 800A97B4 23180301 */  subu       $v1, $t0, $v1
    /* 99FB8 800A97B8 23106200 */  subu       $v0, $v1, $v0
    /* 99FBC 800A97BC 2A104202 */  slt        $v0, $s2, $v0
    /* 99FC0 800A97C0 04004010 */  beqz       $v0, .L800A97D4
    /* 99FC4 800A97C4 01000224 */   addiu     $v0, $zero, 0x1
    /* 99FC8 800A97C8 FFFF1324 */  addiu      $s3, $zero, -0x1
    /* 99FCC 800A97CC 23A07200 */  subu       $s4, $v1, $s2
    /* 99FD0 800A97D0 B00D82AF */  sw         $v0, %gp_rel(D_8013D2FC)($gp)
  .L800A97D4:
    /* 99FD4 800A97D4 1A00A384 */  lh         $v1, 0x1A($a1)
    /* 99FD8 800A97D8 8407228E */  lw         $v0, 0x784($s1)
    /* 99FDC 800A97DC 001A0300 */  sll        $v1, $v1, 8
    /* 99FE0 800A97E0 23186800 */  subu       $v1, $v1, $t0
    /* 99FE4 800A97E4 21106200 */  addu       $v0, $v1, $v0
    /* 99FE8 800A97E8 2A105200 */  slt        $v0, $v0, $s2
    /* 99FEC 800A97EC 04004010 */  beqz       $v0, .L800A9800
    /* 99FF0 800A97F0 00000000 */   nop
    /* 99FF4 800A97F4 01001324 */  addiu      $s3, $zero, 0x1
    /* 99FF8 800A97F8 23A04302 */  subu       $s4, $s2, $v1
    /* 99FFC 800A97FC B00D93AF */  sw         $s3, %gp_rel(D_8013D2FC)($gp)
  .L800A9800:
    /* 9A000 800A9800 8A006012 */  beqz       $s3, .L800A9A2C
    /* 9A004 800A9804 21100000 */   addu      $v0, $zero, $zero
    /* 9A008 800A9808 562C030C */  jal        Force_IsForceOn__FP8Car_tObj
    /* 9A00C 800A980C 21202002 */   addu      $a0, $s1, $zero
    /* 9A010 800A9810 03004010 */  beqz       $v0, .L800A9820
    /* 9A014 800A9814 00000000 */   nop
    /* 9A018 800A9818 812C030C */  jal        Force_HitWall__Fi
    /* 9A01C 800A981C 1E00043C */   lui       $a0, (0x1E0000 >> 16)
  .L800A9820:
    /* 9A020 800A9820 3401228E */  lw         $v0, 0x134($s1)
    /* 9A024 800A9824 00000000 */  nop
    /* 9A028 800A9828 02004104 */  bgez       $v0, .L800A9834
    /* 9A02C 800A982C 00000000 */   nop
    /* 9A030 800A9830 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A9834:
    /* 9A034 800A9834 2800A38F */  lw         $v1, 0x28($sp)
    /* 9A038 800A9838 03120200 */  sra        $v0, $v0, 8
    /* 9A03C 800A983C 18004300 */  mult       $v0, $v1
    /* 9A040 800A9840 12100000 */  mflo       $v0
    /* 9A044 800A9844 03004104 */  bgez       $v0, .L800A9854
    /* 9A048 800A9848 03220200 */   sra       $a0, $v0, 8
    /* 9A04C 800A984C FF004224 */  addiu      $v0, $v0, 0xFF
    /* 9A050 800A9850 03220200 */  sra        $a0, $v0, 8
  .L800A9854:
    /* 9A054 800A9854 4800A4AF */  sw         $a0, 0x48($sp)
    /* 9A058 800A9858 3401228E */  lw         $v0, 0x134($s1)
    /* 9A05C 800A985C 00000000 */  nop
    /* 9A060 800A9860 02004104 */  bgez       $v0, .L800A986C
    /* 9A064 800A9864 00000000 */   nop
    /* 9A068 800A9868 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A986C:
    /* 9A06C 800A986C 2C00A38F */  lw         $v1, 0x2C($sp)
    /* 9A070 800A9870 03120200 */  sra        $v0, $v0, 8
    /* 9A074 800A9874 18004300 */  mult       $v0, $v1
    /* 9A078 800A9878 12100000 */  mflo       $v0
    /* 9A07C 800A987C 02004104 */  bgez       $v0, .L800A9888
    /* 9A080 800A9880 00000000 */   nop
    /* 9A084 800A9884 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A9888:
    /* 9A088 800A9888 03120200 */  sra        $v0, $v0, 8
    /* 9A08C 800A988C 4C00A2AF */  sw         $v0, 0x4C($sp)
    /* 9A090 800A9890 3401228E */  lw         $v0, 0x134($s1)
    /* 9A094 800A9894 00000000 */  nop
    /* 9A098 800A9898 02004104 */  bgez       $v0, .L800A98A4
    /* 9A09C 800A989C 00000000 */   nop
    /* 9A0A0 800A98A0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A98A4:
    /* 9A0A4 800A98A4 3000A38F */  lw         $v1, 0x30($sp)
    /* 9A0A8 800A98A8 03120200 */  sra        $v0, $v0, 8
    /* 9A0AC 800A98AC 18004300 */  mult       $v0, $v1
    /* 9A0B0 800A98B0 12100000 */  mflo       $v0
    /* 9A0B4 800A98B4 02004104 */  bgez       $v0, .L800A98C0
    /* 9A0B8 800A98B8 00000000 */   nop
    /* 9A0BC 800A98BC FF004224 */  addiu      $v0, $v0, 0xFF
  .L800A98C0:
    /* 9A0C0 800A98C0 03120200 */  sra        $v0, $v0, 8
    /* 9A0C4 800A98C4 0E00601A */  blez       $s3, .L800A9900
    /* 9A0C8 800A98C8 5000A2AF */   sw        $v0, 0x50($sp)
    /* 9A0CC 800A98CC A000228E */  lw         $v0, 0xA0($s1)
    /* 9A0D0 800A98D0 00000000 */  nop
    /* 9A0D4 800A98D4 21104400 */  addu       $v0, $v0, $a0
    /* 9A0D8 800A98D8 A00122AE */  sw         $v0, 0x1A0($s1)
    /* 9A0DC 800A98DC A400228E */  lw         $v0, 0xA4($s1)
    /* 9A0E0 800A98E0 4C00A38F */  lw         $v1, 0x4C($sp)
    /* 9A0E4 800A98E4 00000000 */  nop
    /* 9A0E8 800A98E8 21104300 */  addu       $v0, $v0, $v1
    /* 9A0EC 800A98EC A40122AE */  sw         $v0, 0x1A4($s1)
    /* 9A0F0 800A98F0 A800228E */  lw         $v0, 0xA8($s1)
    /* 9A0F4 800A98F4 5000A38F */  lw         $v1, 0x50($sp)
    /* 9A0F8 800A98F8 4DA60208 */  j          .L800A9934
    /* 9A0FC 800A98FC 21104300 */   addu      $v0, $v0, $v1
  .L800A9900:
    /* 9A100 800A9900 A000228E */  lw         $v0, 0xA0($s1)
    /* 9A104 800A9904 00000000 */  nop
    /* 9A108 800A9908 23104400 */  subu       $v0, $v0, $a0
    /* 9A10C 800A990C A00122AE */  sw         $v0, 0x1A0($s1)
    /* 9A110 800A9910 A400228E */  lw         $v0, 0xA4($s1)
    /* 9A114 800A9914 4C00A38F */  lw         $v1, 0x4C($sp)
    /* 9A118 800A9918 00000000 */  nop
    /* 9A11C 800A991C 23104300 */  subu       $v0, $v0, $v1
    /* 9A120 800A9920 A40122AE */  sw         $v0, 0x1A4($s1)
    /* 9A124 800A9924 A800228E */  lw         $v0, 0xA8($s1)
    /* 9A128 800A9928 5000A38F */  lw         $v1, 0x50($sp)
    /* 9A12C 800A992C 00000000 */  nop
    /* 9A130 800A9930 23104300 */  subu       $v0, $v0, $v1
  .L800A9934:
    /* 9A134 800A9934 A80122AE */  sw         $v0, 0x1A8($s1)
    /* 9A138 800A9938 8801238E */  lw         $v1, 0x188($s1)
    /* 9A13C 800A993C 99990234 */  ori        $v0, $zero, 0x9999
    /* 9A140 800A9940 2A104300 */  slt        $v0, $v0, $v1
    /* 9A144 800A9944 0A004014 */  bnez       $v0, .L800A9970
    /* 9A148 800A9948 65E60234 */   ori       $v0, $zero, 0xE665
    /* 9A14C 800A994C 2C01238E */  lw         $v1, 0x12C($s1)
    /* 9A150 800A9950 00000000 */  nop
    /* 9A154 800A9954 2A104300 */  slt        $v0, $v0, $v1
    /* 9A158 800A9958 05004010 */  beqz       $v0, .L800A9970
    /* 9A15C 800A995C 00000000 */   nop
    /* 9A160 800A9960 7C012296 */  lhu        $v0, 0x17C($s1)
    /* 9A164 800A9964 00000000 */  nop
    /* 9A168 800A9968 20004010 */  beqz       $v0, .L800A99EC
    /* 9A16C 800A996C 40281400 */   sll       $a1, $s4, 1
  .L800A9970:
    /* 9A170 800A9970 08006106 */  bgez       $s3, .L800A9994
    /* 9A174 800A9974 00000000 */   nop
    /* 9A178 800A9978 2800A28F */  lw         $v0, 0x28($sp)
    /* 9A17C 800A997C 2C00A38F */  lw         $v1, 0x2C($sp)
    /* 9A180 800A9980 3000A48F */  lw         $a0, 0x30($sp)
    /* 9A184 800A9984 3800A2AF */  sw         $v0, 0x38($sp)
    /* 9A188 800A9988 3C00A3AF */  sw         $v1, 0x3C($sp)
    /* 9A18C 800A998C 6EA60208 */  j          .L800A99B8
    /* 9A190 800A9990 4000A4AF */   sw        $a0, 0x40($sp)
  .L800A9994:
    /* 9A194 800A9994 2800A28F */  lw         $v0, 0x28($sp)
    /* 9A198 800A9998 3000A38F */  lw         $v1, 0x30($sp)
    /* 9A19C 800A999C 23100200 */  negu       $v0, $v0
    /* 9A1A0 800A99A0 3800A2AF */  sw         $v0, 0x38($sp)
    /* 9A1A4 800A99A4 2C00A28F */  lw         $v0, 0x2C($sp)
    /* 9A1A8 800A99A8 23180300 */  negu       $v1, $v1
    /* 9A1AC 800A99AC 4000A3AF */  sw         $v1, 0x40($sp)
    /* 9A1B0 800A99B0 23100200 */  negu       $v0, $v0
    /* 9A1B4 800A99B4 3C00A2AF */  sw         $v0, 0x3C($sp)
  .L800A99B8:
    /* 9A1B8 800A99B8 21202002 */  addu       $a0, $s1, $zero
    /* 9A1BC 800A99BC 3800A527 */  addiu      $a1, $sp, 0x38
    /* 9A1C0 800A99C0 6A36020C */  jal        Collide_TestWithPlane__FP13BO_tNewtonObjP8coorddefT1
    /* 9A1C4 800A99C4 A0002626 */   addiu     $a2, $s1, 0xA0
    /* 9A1C8 800A99C8 9001228E */  lw         $v0, 0x190($s1)
    /* 9A1CC 800A99CC 00000000 */  nop
    /* 9A1D0 800A99D0 15004010 */  beqz       $v0, .L800A9A28
    /* 9A1D4 800A99D4 0400033C */   lui       $v1, (0x40000 >> 16)
    /* 9A1D8 800A99D8 B00D828F */  lw         $v0, %gp_rel(D_8013D2FC)($gp)
    /* 9A1DC 800A99DC 940120AE */  sw         $zero, 0x194($s1)
    /* 9A1E0 800A99E0 25104300 */  or         $v0, $v0, $v1
    /* 9A1E4 800A99E4 8AA60208 */  j          .L800A9A28
    /* 9A1E8 800A99E8 980122AE */   sw        $v0, 0x198($s1)
  .L800A99EC:
    /* 9A1EC 800A99EC 0200A104 */  bgez       $a1, .L800A99F8
    /* 9A1F0 800A99F0 00000000 */   nop
    /* 9A1F4 800A99F4 23280500 */  negu       $a1, $a1
  .L800A99F8:
    /* 9A1F8 800A99F8 18006502 */  mult       $s3, $a1
    /* 9A1FC 800A99FC 21202002 */  addu       $a0, $s1, $zero
    /* 9A200 800A9A00 12280000 */  mflo       $a1
    /* 9A204 800A9A04 9FA3020C */  jal        Physics_AttenuateVelocity__FP8Car_tObjiP10matrixtdef
    /* 9A208 800A9A08 44012626 */   addiu     $a2, $s1, 0x144
    /* 9A20C 800A9A0C 4000A38F */  lw         $v1, 0x40($sp)
    /* 9A210 800A9A10 21202002 */  addu       $a0, $s1, $zero
    /* 9A214 800A9A14 1000A3AF */  sw         $v1, 0x10($sp)
    /* 9A218 800A9A18 3800A68F */  lw         $a2, 0x38($sp)
    /* 9A21C 800A9A1C 3C00A78F */  lw         $a3, 0x3C($sp)
    /* 9A220 800A9A20 C8A4020C */  jal        Physics_CorrectPostCollisionYaw__FP8Car_tObjiG8coorddef
    /* 9A224 800A9A24 21284000 */   addu      $a1, $v0, $zero
  .L800A9A28:
    /* 9A228 800A9A28 21106002 */  addu       $v0, $s3, $zero
  .L800A9A2C:
    /* 9A22C 800A9A2C 7000BF8F */  lw         $ra, 0x70($sp)
    /* 9A230 800A9A30 6C00B58F */  lw         $s5, 0x6C($sp)
    /* 9A234 800A9A34 6800B48F */  lw         $s4, 0x68($sp)
    /* 9A238 800A9A38 6400B38F */  lw         $s3, 0x64($sp)
    /* 9A23C 800A9A3C 6000B28F */  lw         $s2, 0x60($sp)
    /* 9A240 800A9A40 5C00B18F */  lw         $s1, 0x5C($sp)
    /* 9A244 800A9A44 5800B08F */  lw         $s0, 0x58($sp)
    /* 9A248 800A9A48 0800E003 */  jr         $ra
    /* 9A24C 800A9A4C 7800BD27 */   addiu     $sp, $sp, 0x78
endlabel Physics_DoBarrierCheck__FP8Car_tObj
