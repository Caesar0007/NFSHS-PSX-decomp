.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching __14ObjectSignAnimP8coorddefiP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectT1P22ObjectFinishedSignAnim, 0x2D4

glabel __14ObjectSignAnimP8coorddefiP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectT1P22ObjectFinishedSignAnim
    /* 96F64 800A6764 28FFBD27 */  addiu      $sp, $sp, -0xD8
    /* 96F68 800A6768 C400B5AF */  sw         $s5, 0xC4($sp)
    /* 96F6C 800A676C 21A88000 */  addu       $s5, $a0, $zero
    /* 96F70 800A6770 0580023C */  lui        $v0, %hi(_vt_14ObjectSignAnim)
    /* 96F74 800A6774 88604224 */  addiu      $v0, $v0, %lo(_vt_14ObjectSignAnim)
    /* 96F78 800A6778 D000BFAF */  sw         $ra, 0xD0($sp)
    /* 96F7C 800A677C CC00B7AF */  sw         $s7, 0xCC($sp)
    /* 96F80 800A6780 C800B6AF */  sw         $s6, 0xC8($sp)
    /* 96F84 800A6784 C000B4AF */  sw         $s4, 0xC0($sp)
    /* 96F88 800A6788 BC00B3AF */  sw         $s3, 0xBC($sp)
    /* 96F8C 800A678C B800B2AF */  sw         $s2, 0xB8($sp)
    /* 96F90 800A6790 B400B1AF */  sw         $s1, 0xB4($sp)
    /* 96F94 800A6794 B000B0AF */  sw         $s0, 0xB0($sp)
    /* 96F98 800A6798 0000A2AE */  sw         $v0, 0x0($s5)
    /* 96F9C 800A679C 0000B08C */  lw         $s0, 0x0($a1)
    /* 96FA0 800A67A0 0800A28C */  lw         $v0, 0x8($a1)
    /* 96FA4 800A67A4 00320600 */  sll        $a2, $a2, 8
    /* 96FA8 800A67A8 0000A88C */  lw         $t0, 0x0($a1)
    /* 96FAC 800A67AC 0400A98C */  lw         $t1, 0x4($a1)
    /* 96FB0 800A67B0 0800AA8C */  lw         $t2, 0x8($a1)
    /* 96FB4 800A67B4 0400A8AE */  sw         $t0, 0x4($s5)
    /* 96FB8 800A67B8 0800A9AE */  sw         $t1, 0x8($s5)
    /* 96FBC 800A67BC 0C00AAAE */  sw         $t2, 0xC($s5)
    /* 96FC0 800A67C0 2400A6AE */  sw         $a2, 0x24($s5)
    /* 96FC4 800A67C4 1C00A7AE */  sw         $a3, 0x1C($s5)
    /* 96FC8 800A67C8 E800B78F */  lw         $s7, 0xE8($sp)
    /* 96FCC 800A67CC EC00B68F */  lw         $s6, 0xEC($sp)
    /* 96FD0 800A67D0 F000A38F */  lw         $v1, 0xF0($sp)
    /* 96FD4 800A67D4 0400C426 */  addiu      $a0, $s6, 0x4
    /* 96FD8 800A67D8 02000106 */  bgez       $s0, .L800A67E4
    /* 96FDC 800A67DC 00000000 */   nop
    /* 96FE0 800A67E0 23801000 */  negu       $s0, $s0
  .L800A67E4:
    /* 96FE4 800A67E4 02004104 */  bgez       $v0, .L800A67F0
    /* 96FE8 800A67E8 00000000 */   nop
    /* 96FEC 800A67EC 23100200 */  negu       $v0, $v0
  .L800A67F0:
    /* 96FF0 800A67F0 21800202 */  addu       $s0, $s0, $v0
    /* 96FF4 800A67F4 1400B7AE */  sw         $s7, 0x14($s5)
    /* 96FF8 800A67F8 1800B6AE */  sw         $s6, 0x18($s5)
    /* 96FFC 800A67FC 1000A3AE */  sw         $v1, 0x10($s5)
    /* 97000 800A6800 F800B48F */  lw         $s4, 0xF8($sp)
    /* 97004 800A6804 B992020C */  jal        CalcObjYawAngle__FP8CCOORD16
    /* 97008 800A6808 03841000 */   sra       $s0, $s0, 16
    /* 9700C 800A680C 00120200 */  sll        $v0, $v0, 8
    /* 97010 800A6810 0A00102A */  slti       $s0, $s0, 0xA
    /* 97014 800A6814 09000012 */  beqz       $s0, .L800A683C
    /* 97018 800A6818 2000A2AE */   sw        $v0, 0x20($s5)
    /* 9701C 800A681C 578F020C */  jal        __builtin_new
    /* 97020 800A6820 14000424 */   addiu     $a0, $zero, 0x14
    /* 97024 800A6824 1C00A38E */  lw         $v1, 0x1C($s5)
    /* 97028 800A6828 00000000 */  nop
    /* 9702C 800A682C 0C00658C */  lw         $a1, 0xC($v1)
    /* 97030 800A6830 0400668C */  lw         $a2, 0x4($v1)
    /* 97034 800A6834 169A0208 */  j          .L800A6858
    /* 97038 800A6838 21204000 */   addu      $a0, $v0, $zero
  .L800A683C:
    /* 9703C 800A683C 578F020C */  jal        __builtin_new
    /* 97040 800A6840 14000424 */   addiu     $a0, $zero, 0x14
    /* 97044 800A6844 1C00A38E */  lw         $v1, 0x1C($s5)
    /* 97048 800A6848 21204000 */  addu       $a0, $v0, $zero
    /* 9704C 800A684C 0C00658C */  lw         $a1, 0xC($v1)
    /* 97050 800A6850 0400668C */  lw         $a2, 0x4($v1)
    /* 97054 800A6854 0100A524 */  addiu      $a1, $a1, 0x1
  .L800A6858:
    /* 97058 800A6858 F3D0010C */  jal        __10AnimScriptii
    /* 9705C 800A685C 1C009226 */   addiu     $s2, $s4, 0x1C
    /* 97060 800A6860 2800A2AE */  sw         $v0, 0x28($s5)
    /* 97064 800A6864 2800A48E */  lw         $a0, 0x28($s5)
    /* 97068 800A6868 4DD1010C */  jal        SetAnimAttrib__10AnimScripti
    /* 9706C 800A686C 02000524 */   addiu     $a1, $zero, 0x2
    /* 97070 800A6870 0100053C */  lui        $a1, (0x10000 >> 16)
    /* 97074 800A6874 2C00B4AE */  sw         $s4, 0x2C($s5)
    /* 97078 800A6878 F400A28F */  lw         $v0, 0xF4($sp)
    /* 9707C 800A687C 10009126 */  addiu      $s1, $s4, 0x10
    /* 97080 800A6880 0000488C */  lw         $t0, 0x0($v0)
    /* 97084 800A6884 0400498C */  lw         $t1, 0x4($v0)
    /* 97088 800A6888 08004A8C */  lw         $t2, 0x8($v0)
    /* 9708C 800A688C 100088AE */  sw         $t0, 0x10($s4)
    /* 97090 800A6890 140089AE */  sw         $t1, 0x14($s4)
    /* 97094 800A6894 18008AAE */  sw         $t2, 0x18($s4)
    /* 97098 800A6898 2110A000 */  addu       $v0, $a1, $zero
    /* 9709C 800A689C 1C0080AE */  sw         $zero, 0x1C($s4)
    /* 970A0 800A68A0 040040AE */  sw         $zero, 0x4($s2)
    /* 970A4 800A68A4 080042AE */  sw         $v0, 0x8($s2)
    /* 970A8 800A68A8 0400248E */  lw         $a0, 0x4($s1)
    /* 970AC 800A68AC CA90030C */  jal        fixedmult
    /* 970B0 800A68B0 04009326 */   addiu     $s3, $s4, 0x4
    /* 970B4 800A68B4 0800248E */  lw         $a0, 0x8($s1)
    /* 970B8 800A68B8 0400458E */  lw         $a1, 0x4($s2)
    /* 970BC 800A68BC CA90030C */  jal        fixedmult
    /* 970C0 800A68C0 21804000 */   addu      $s0, $v0, $zero
    /* 970C4 800A68C4 23800202 */  subu       $s0, $s0, $v0
    /* 970C8 800A68C8 040090AE */  sw         $s0, 0x4($s4)
    /* 970CC 800A68CC 0800248E */  lw         $a0, 0x8($s1)
    /* 970D0 800A68D0 1C00858E */  lw         $a1, 0x1C($s4)
    /* 970D4 800A68D4 CA90030C */  jal        fixedmult
    /* 970D8 800A68D8 00000000 */   nop
    /* 970DC 800A68DC 1000848E */  lw         $a0, 0x10($s4)
    /* 970E0 800A68E0 0800458E */  lw         $a1, 0x8($s2)
    /* 970E4 800A68E4 CA90030C */  jal        fixedmult
    /* 970E8 800A68E8 21804000 */   addu      $s0, $v0, $zero
    /* 970EC 800A68EC 23800202 */  subu       $s0, $s0, $v0
    /* 970F0 800A68F0 040070AE */  sw         $s0, 0x4($s3)
    /* 970F4 800A68F4 1000848E */  lw         $a0, 0x10($s4)
    /* 970F8 800A68F8 0400458E */  lw         $a1, 0x4($s2)
    /* 970FC 800A68FC CA90030C */  jal        fixedmult
    /* 97100 800A6900 00000000 */   nop
    /* 97104 800A6904 0400248E */  lw         $a0, 0x4($s1)
    /* 97108 800A6908 1C00858E */  lw         $a1, 0x1C($s4)
    /* 9710C 800A690C CA90030C */  jal        fixedmult
    /* 97110 800A6910 21804000 */   addu      $s0, $v0, $zero
    /* 97114 800A6914 0400648E */  lw         $a0, 0x4($s3)
    /* 97118 800A6918 23800202 */  subu       $s0, $s0, $v0
    /* 9711C 800A691C 080070AE */  sw         $s0, 0x8($s3)
    /* 97120 800A6920 0800258E */  lw         $a1, 0x8($s1)
    /* 97124 800A6924 CA90030C */  jal        fixedmult
    /* 97128 800A6928 00000000 */   nop
    /* 9712C 800A692C 0800648E */  lw         $a0, 0x8($s3)
    /* 97130 800A6930 0400258E */  lw         $a1, 0x4($s1)
    /* 97134 800A6934 CA90030C */  jal        fixedmult
    /* 97138 800A6938 21804000 */   addu      $s0, $v0, $zero
    /* 9713C 800A693C 23800202 */  subu       $s0, $s0, $v0
    /* 97140 800A6940 1C0090AE */  sw         $s0, 0x1C($s4)
    /* 97144 800A6944 0800648E */  lw         $a0, 0x8($s3)
    /* 97148 800A6948 1000858E */  lw         $a1, 0x10($s4)
    /* 9714C 800A694C CA90030C */  jal        fixedmult
    /* 97150 800A6950 00000000 */   nop
    /* 97154 800A6954 0400848E */  lw         $a0, 0x4($s4)
    /* 97158 800A6958 0800258E */  lw         $a1, 0x8($s1)
    /* 9715C 800A695C CA90030C */  jal        fixedmult
    /* 97160 800A6960 21804000 */   addu      $s0, $v0, $zero
    /* 97164 800A6964 23800202 */  subu       $s0, $s0, $v0
    /* 97168 800A6968 040050AE */  sw         $s0, 0x4($s2)
    /* 9716C 800A696C 0400848E */  lw         $a0, 0x4($s4)
    /* 97170 800A6970 0400258E */  lw         $a1, 0x4($s1)
    /* 97174 800A6974 CA90030C */  jal        fixedmult
    /* 97178 800A6978 00000000 */   nop
    /* 9717C 800A697C 0400648E */  lw         $a0, 0x4($s3)
    /* 97180 800A6980 1000858E */  lw         $a1, 0x10($s4)
    /* 97184 800A6984 CA90030C */  jal        fixedmult
    /* 97188 800A6988 21804000 */   addu      $s0, $v0, $zero
    /* 9718C 800A698C 21206002 */  addu       $a0, $s3, $zero
    /* 97190 800A6990 23800202 */  subu       $s0, $s0, $v0
    /* 97194 800A6994 B9C0030C */  jal        reorthogonalize
    /* 97198 800A6998 080050AE */   sw        $s0, 0x8($s2)
    /* 9719C 800A699C 8800B127 */  addiu      $s1, $sp, 0x88
    /* 971A0 800A69A0 21202002 */  addu       $a0, $s1, $zero
    /* 971A4 800A69A4 EBAA030C */  jal        fixedxformx
    /* 971A8 800A69A8 00400524 */   addiu     $a1, $zero, 0x4000
    /* 971AC 800A69AC 3800B027 */  addiu      $s0, $sp, 0x38
    /* 971B0 800A69B0 2000A58E */  lw         $a1, 0x20($s5)
    /* 971B4 800A69B4 21200002 */  addu       $a0, $s0, $zero
    /* 971B8 800A69B8 04AB030C */  jal        fixedxformy
    /* 971BC 800A69BC 23280500 */   negu      $a1, $a1
    /* 971C0 800A69C0 2400A58E */  lw         $a1, 0x24($s5)
    /* 971C4 800A69C4 04AB030C */  jal        fixedxformy
    /* 971C8 800A69C8 1000A427 */   addiu     $a0, $sp, 0x10
    /* 971CC 800A69CC 21200002 */  addu       $a0, $s0, $zero
    /* 971D0 800A69D0 21282002 */  addu       $a1, $s1, $zero
    /* 971D4 800A69D4 6000B027 */  addiu      $s0, $sp, 0x60
    /* 971D8 800A69D8 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 971DC 800A69DC 21300002 */   addu      $a2, $s0, $zero
    /* 971E0 800A69E0 21200002 */  addu       $a0, $s0, $zero
    /* 971E4 800A69E4 1000A527 */  addiu      $a1, $sp, 0x10
    /* 971E8 800A69E8 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 971EC 800A69EC 21300002 */   addu      $a2, $s0, $zero
    /* 971F0 800A69F0 21200002 */  addu       $a0, $s0, $zero
    /* 971F4 800A69F4 21286002 */  addu       $a1, $s3, $zero
    /* 971F8 800A69F8 6377020C */  jal        Math_fasttransmult__FP10matrixtdefN20
    /* 971FC 800A69FC 2130A000 */   addu      $a2, $a1, $zero
    /* 97200 800A6A00 2110A002 */  addu       $v0, $s5, $zero
    /* 97204 800A6A04 280096AE */  sw         $s6, 0x28($s4)
    /* 97208 800A6A08 2C0097AE */  sw         $s7, 0x2C($s4)
    /* 9720C 800A6A0C D000BF8F */  lw         $ra, 0xD0($sp)
    /* 97210 800A6A10 CC00B78F */  lw         $s7, 0xCC($sp)
    /* 97214 800A6A14 C800B68F */  lw         $s6, 0xC8($sp)
    /* 97218 800A6A18 C400B58F */  lw         $s5, 0xC4($sp)
    /* 9721C 800A6A1C C000B48F */  lw         $s4, 0xC0($sp)
    /* 97220 800A6A20 BC00B38F */  lw         $s3, 0xBC($sp)
    /* 97224 800A6A24 B800B28F */  lw         $s2, 0xB8($sp)
    /* 97228 800A6A28 B400B18F */  lw         $s1, 0xB4($sp)
    /* 9722C 800A6A2C B000B08F */  lw         $s0, 0xB0($sp)
    /* 97230 800A6A30 0800E003 */  jr         $ra
    /* 97234 800A6A34 D800BD27 */   addiu     $sp, $sp, 0xD8
endlabel __14ObjectSignAnimP8coorddefiP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectT1P22ObjectFinishedSignAnim
