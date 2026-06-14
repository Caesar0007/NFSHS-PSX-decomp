.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIInit_LoadPhysicsConfig__FP10Udff_tInfo, 0x120

glabel AIInit_LoadPhysicsConfig__FP10Udff_tInfo
    /* 57854 80067054 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 57858 80067058 1400B1AF */  sw         $s1, 0x14($sp)
    /* 5785C 8006705C 21888000 */  addu       $s1, $a0, $zero
    /* 57860 80067060 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 57864 80067064 1800B2AF */  sw         $s2, 0x18($sp)
    /* 57868 80067068 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5786C 8006706C 1000B0AF */   sw        $s0, 0x10($sp)
    /* 57870 80067070 21202002 */  addu       $a0, $s1, $zero
    /* 57874 80067074 1180103C */  lui        $s0, %hi(AIPhysicConfig)
    /* 57878 80067078 74DC02AE */  sw         $v0, %lo(AIPhysicConfig)($s0)
    /* 5787C 8006707C C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 57880 80067080 74DC1026 */   addiu     $s0, $s0, %lo(AIPhysicConfig)
    /* 57884 80067084 21202002 */  addu       $a0, $s1, $zero
    /* 57888 80067088 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5788C 8006708C 040002AE */   sw        $v0, 0x4($s0)
    /* 57890 80067090 21202002 */  addu       $a0, $s1, $zero
    /* 57894 80067094 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 57898 80067098 080002AE */   sw        $v0, 0x8($s0)
    /* 5789C 8006709C 21202002 */  addu       $a0, $s1, $zero
    /* 578A0 800670A0 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 578A4 800670A4 0C0002AE */   sw        $v0, 0xC($s0)
    /* 578A8 800670A8 21900000 */  addu       $s2, $zero, $zero
    /* 578AC 800670AC 100002AE */  sw         $v0, 0x10($s0)
  .L800670B0:
    /* 578B0 800670B0 04004016 */  bnez       $s2, .L800670C4
    /* 578B4 800670B4 1180023C */   lui       $v0, %hi(D_8010DCB4)
    /* 578B8 800670B8 1180023C */  lui        $v0, %hi(D_8010DC88)
    /* 578BC 800670BC 329C0108 */  j          .L800670C8
    /* 578C0 800670C0 88DC5024 */   addiu     $s0, $v0, %lo(D_8010DC88)
  .L800670C4:
    /* 578C4 800670C4 B4DC5024 */  addiu      $s0, $v0, %lo(D_8010DCB4)
  .L800670C8:
    /* 578C8 800670C8 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 578CC 800670CC 21202002 */   addu      $a0, $s1, $zero
    /* 578D0 800670D0 21202002 */  addu       $a0, $s1, $zero
    /* 578D4 800670D4 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 578D8 800670D8 000002AE */   sw        $v0, 0x0($s0)
    /* 578DC 800670DC 21202002 */  addu       $a0, $s1, $zero
    /* 578E0 800670E0 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 578E4 800670E4 040002AE */   sw        $v0, 0x4($s0)
    /* 578E8 800670E8 21202002 */  addu       $a0, $s1, $zero
    /* 578EC 800670EC C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 578F0 800670F0 080002AE */   sw        $v0, 0x8($s0)
    /* 578F4 800670F4 21202002 */  addu       $a0, $s1, $zero
    /* 578F8 800670F8 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 578FC 800670FC 0C0002AE */   sw        $v0, 0xC($s0)
    /* 57900 80067100 21202002 */  addu       $a0, $s1, $zero
    /* 57904 80067104 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 57908 80067108 100002AE */   sw        $v0, 0x10($s0)
    /* 5790C 8006710C 21202002 */  addu       $a0, $s1, $zero
    /* 57910 80067110 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 57914 80067114 140002AE */   sw        $v0, 0x14($s0)
    /* 57918 80067118 21202002 */  addu       $a0, $s1, $zero
    /* 5791C 8006711C C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 57920 80067120 180002AE */   sw        $v0, 0x18($s0)
    /* 57924 80067124 21202002 */  addu       $a0, $s1, $zero
    /* 57928 80067128 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 5792C 8006712C 1C0002AE */   sw        $v0, 0x1C($s0)
    /* 57930 80067130 21202002 */  addu       $a0, $s1, $zero
    /* 57934 80067134 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 57938 80067138 200002AE */   sw        $v0, 0x20($s0)
    /* 5793C 8006713C 21202002 */  addu       $a0, $s1, $zero
    /* 57940 80067140 C9EE020C */  jal        Udff_GetInt__FP10Udff_tInfo
    /* 57944 80067144 240002AE */   sw        $v0, 0x24($s0)
    /* 57948 80067148 01005226 */  addiu      $s2, $s2, 0x1
    /* 5794C 8006714C 280002AE */  sw         $v0, 0x28($s0)
    /* 57950 80067150 0200422A */  slti       $v0, $s2, 0x2
    /* 57954 80067154 D6FF4014 */  bnez       $v0, .L800670B0
    /* 57958 80067158 00000000 */   nop
    /* 5795C 8006715C 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 57960 80067160 1800B28F */  lw         $s2, 0x18($sp)
    /* 57964 80067164 1400B18F */  lw         $s1, 0x14($sp)
    /* 57968 80067168 1000B08F */  lw         $s0, 0x10($sp)
    /* 5796C 8006716C 0800E003 */  jr         $ra
    /* 57970 80067170 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AIInit_LoadPhysicsConfig__FP10Udff_tInfo
