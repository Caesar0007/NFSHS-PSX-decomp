.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_CalcAcceleration__FP8Car_tObji, 0x2E0

glabel AIPhysic_CalcAcceleration__FP8Car_tObji
    /* 59EB0 800696B0 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 59EB4 800696B4 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 59EB8 800696B8 21988000 */  addu       $s3, $a0, $zero
    /* 59EBC 800696BC 2000BFAF */  sw         $ra, 0x20($sp)
    /* 59EC0 800696C0 1800B2AF */  sw         $s2, 0x18($sp)
    /* 59EC4 800696C4 1400B1AF */  sw         $s1, 0x14($sp)
    /* 59EC8 800696C8 1000B0AF */  sw         $s0, 0x10($sp)
    /* 59ECC 800696CC 8005628E */  lw         $v0, 0x580($s3)
    /* 59ED0 800696D0 0200A104 */  bgez       $a1, .L800696DC
    /* 59ED4 800696D4 2190A000 */   addu      $s2, $a1, $zero
    /* 59ED8 800696D8 23901200 */  negu       $s2, $s2
  .L800696DC:
    /* 59EDC 800696DC A500401C */  bgtz       $v0, .L80069974
    /* 59EE0 800696E0 21100000 */   addu      $v0, $zero, $zero
    /* 59EE4 800696E4 8802628E */  lw         $v0, 0x288($s3)
    /* 59EE8 800696E8 00000000 */  nop
    /* 59EEC 800696EC 0000438C */  lw         $v1, 0x0($v0)
    /* 59EF0 800696F0 00000000 */  nop
    /* 59EF4 800696F4 16006228 */  slti       $v0, $v1, 0x16
    /* 59EF8 800696F8 17004010 */  beqz       $v0, .L80069758
    /* 59EFC 800696FC 1180023C */   lui       $v0, %hi(Cars_topSpeedCap)
    /* 59F00 80069700 28F84224 */  addiu      $v0, $v0, %lo(Cars_topSpeedCap)
    /* 59F04 80069704 80180300 */  sll        $v1, $v1, 2
    /* 59F08 80069708 21186200 */  addu       $v1, $v1, $v0
    /* 59F0C 8006970C 0000718C */  lw         $s1, 0x0($v1)
    /* 59F10 80069710 7C07658E */  lw         $a1, 0x77C($s3)
    /* 59F14 80069714 CA90030C */  jal        fixedmult
    /* 59F18 80069718 21202002 */   addu      $a0, $s1, $zero
    /* 59F1C 8006971C 21804000 */  addu       $s0, $v0, $zero
    /* 59F20 80069720 3007658E */  lw         $a1, 0x730($s3)
    /* 59F24 80069724 CA90030C */  jal        fixedmult
    /* 59F28 80069728 21200002 */   addu      $a0, $s0, $zero
    /* 59F2C 8006972C 2A105200 */  slt        $v0, $v0, $s2
    /* 59F30 80069730 90004014 */  bnez       $v0, .L80069974
    /* 59F34 80069734 21100000 */   addu      $v0, $zero, $zero
    /* 59F38 80069738 2A101202 */  slt        $v0, $s0, $s2
    /* 59F3C 8006973C 8D004014 */  bnez       $v0, .L80069974
    /* 59F40 80069740 21100000 */   addu      $v0, $zero, $zero
    /* 59F44 80069744 2A103202 */  slt        $v0, $s1, $s2
    /* 59F48 80069748 03004010 */  beqz       $v0, .L80069758
    /* 59F4C 8006974C FDFF023C */   lui       $v0, (0xFFFDC71D >> 16)
    /* 59F50 80069750 1DC74234 */  ori        $v0, $v0, (0xFFFDC71D & 0xFFFF)
    /* 59F54 80069754 21902202 */  addu       $s2, $s1, $v0
  .L80069758:
    /* 59F58 80069758 21284002 */  addu       $a1, $s2, $zero
    /* 59F5C 8006975C 0200A104 */  bgez       $a1, .L80069768
    /* 59F60 80069760 FFFF0234 */   ori       $v0, $zero, 0xFFFF
    /* 59F64 80069764 2128A200 */  addu       $a1, $a1, $v0
  .L80069768:
    /* 59F68 80069768 032C0500 */  sra        $a1, $a1, 16
    /* 59F6C 8006976C 7000A228 */  slti       $v0, $a1, 0x70
    /* 59F70 80069770 02004014 */  bnez       $v0, .L8006977C
    /* 59F74 80069774 00000000 */   nop
    /* 59F78 80069778 6F000524 */  addiu      $a1, $zero, 0x6F
  .L8006977C:
    /* 59F7C 8006977C 0200A104 */  bgez       $a1, .L80069788
    /* 59F80 80069780 00000000 */   nop
    /* 59F84 80069784 21280000 */  addu       $a1, $zero, $zero
  .L80069788:
    /* 59F88 80069788 B006648E */  lw         $a0, 0x6B0($s3)
    /* 59F8C 8006978C 7DB4010C */  jal        Get__23AIDataRecord_AccTable_ti
    /* 59F90 80069790 00000000 */   nop
    /* 59F94 80069794 21804000 */  addu       $s0, $v0, $zero
    /* 59F98 80069798 3C07648E */  lw         $a0, 0x73C($s3)
    /* 59F9C 8006979C 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 59FA0 800697A0 0B008210 */  beq        $a0, $v0, .L800697D0
    /* 59FA4 800697A4 00000000 */   nop
    /* 59FA8 800697A8 02000106 */  bgez       $s0, .L800697B4
    /* 59FAC 800697AC 21180002 */   addu      $v1, $s0, $zero
    /* 59FB0 800697B0 FF000326 */  addiu      $v1, $s0, 0xFF
  .L800697B4:
    /* 59FB4 800697B4 21108000 */  addu       $v0, $a0, $zero
    /* 59FB8 800697B8 02004104 */  bgez       $v0, .L800697C4
    /* 59FBC 800697BC 03220300 */   sra       $a0, $v1, 8
    /* 59FC0 800697C0 FF004224 */  addiu      $v0, $v0, 0xFF
  .L800697C4:
    /* 59FC4 800697C4 03120200 */  sra        $v0, $v0, 8
    /* 59FC8 800697C8 18008200 */  mult       $a0, $v0
    /* 59FCC 800697CC 12800000 */  mflo       $s0
  .L800697D0:
    /* 59FD0 800697D0 02000106 */  bgez       $s0, .L800697DC
    /* 59FD4 800697D4 21100002 */   addu      $v0, $s0, $zero
    /* 59FD8 800697D8 FF000226 */  addiu      $v0, $s0, 0xFF
  .L800697DC:
    /* 59FDC 800697DC 8007638E */  lw         $v1, 0x780($s3)
    /* 59FE0 800697E0 00000000 */  nop
    /* 59FE4 800697E4 02006104 */  bgez       $v1, .L800697F0
    /* 59FE8 800697E8 03220200 */   sra       $a0, $v0, 8
    /* 59FEC 800697EC FF006324 */  addiu      $v1, $v1, 0xFF
  .L800697F0:
    /* 59FF0 800697F0 031A0300 */  sra        $v1, $v1, 8
    /* 59FF4 800697F4 18008300 */  mult       $a0, $v1
    /* 59FF8 800697F8 1180023C */  lui        $v0, %hi(D_80113234)
    /* 59FFC 800697FC 3432428C */  lw         $v0, %lo(D_80113234)($v0)
    /* 5A000 80069800 12800000 */  mflo       $s0
    /* 5A004 80069804 0C004018 */  blez       $v0, .L80069838
    /* 5A008 80069808 00000000 */   nop
    /* 5A00C 8006980C 02000106 */  bgez       $s0, .L80069818
    /* 5A010 80069810 21180002 */   addu      $v1, $s0, $zero
    /* 5A014 80069814 FF000326 */  addiu      $v1, $s0, 0xFF
  .L80069818:
    /* 5A018 80069818 031A0300 */  sra        $v1, $v1, 8
    /* 5A01C 8006981C C0100300 */  sll        $v0, $v1, 3
    /* 5A020 80069820 23104300 */  subu       $v0, $v0, $v1
    /* 5A024 80069824 80100200 */  sll        $v0, $v0, 2
    /* 5A028 80069828 21104300 */  addu       $v0, $v0, $v1
    /* 5A02C 8006982C 80100200 */  sll        $v0, $v0, 2
    /* 5A030 80069830 23104300 */  subu       $v0, $v0, $v1
    /* 5A034 80069834 40800200 */  sll        $s0, $v0, 1
  .L80069838:
    /* 5A038 80069838 6002628E */  lw         $v0, 0x260($s3)
    /* 5A03C 8006983C 00000000 */  nop
    /* 5A040 80069840 20004230 */  andi       $v0, $v0, 0x20
    /* 5A044 80069844 0D004010 */  beqz       $v0, .L8006987C
    /* 5A048 80069848 1180023C */   lui       $v0, %hi(GameSetup_gData)
    /* 5A04C 8006984C 02000106 */  bgez       $s0, .L80069858
    /* 5A050 80069850 21180002 */   addu      $v1, $s0, $zero
    /* 5A054 80069854 FF000326 */  addiu      $v1, $s0, 0xFF
  .L80069858:
    /* 5A058 80069858 CC06628E */  lw         $v0, 0x6CC($s3)
    /* 5A05C 8006985C 00000000 */  nop
    /* 5A060 80069860 02004104 */  bgez       $v0, .L8006986C
    /* 5A064 80069864 03220300 */   sra       $a0, $v1, 8
    /* 5A068 80069868 FF004224 */  addiu      $v0, $v0, 0xFF
  .L8006986C:
    /* 5A06C 8006986C 03120200 */  sra        $v0, $v0, 8
    /* 5A070 80069870 18008200 */  mult       $a0, $v0
    /* 5A074 80069874 12800000 */  mflo       $s0
    /* 5A078 80069878 1180023C */  lui        $v0, %hi(GameSetup_gData)
  .L8006987C:
    /* 5A07C 8006987C EC314524 */  addiu      $a1, $v0, %lo(GameSetup_gData)
    /* 5A080 80069880 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
    /* 5A084 80069884 01000224 */  addiu      $v0, $zero, 0x1
    /* 5A088 80069888 03006210 */  beq        $v1, $v0, .L80069898
    /* 5A08C 8006988C 05000224 */   addiu     $v0, $zero, 0x5
    /* 5A090 80069890 2B006214 */  bne        $v1, $v0, .L80069940
    /* 5A094 80069894 21206002 */   addu      $a0, $s3, $zero
  .L80069898:
    /* 5A098 80069898 1180033C */  lui        $v1, %hi(Cars_gHumanRaceCarList)
    /* 5A09C 8006989C 48FA628C */  lw         $v0, %lo(Cars_gHumanRaceCarList)($v1)
    /* 5A0A0 800698A0 00000000 */  nop
    /* 5A0A4 800698A4 6002428C */  lw         $v0, 0x260($v0)
    /* 5A0A8 800698A8 00000000 */  nop
    /* 5A0AC 800698AC 00024230 */  andi       $v0, $v0, 0x200
    /* 5A0B0 800698B0 0D004014 */  bnez       $v0, .L800698E8
    /* 5A0B4 800698B4 48FA6424 */   addiu     $a0, $v1, %lo(Cars_gHumanRaceCarList)
    /* 5A0B8 800698B8 1480033C */  lui        $v1, %hi(Cars_gNumHumanRaceCars)
    /* 5A0BC 800698BC 00C8638C */  lw         $v1, %lo(Cars_gNumHumanRaceCars)($v1)
    /* 5A0C0 800698C0 02000224 */  addiu      $v0, $zero, 0x2
    /* 5A0C4 800698C4 1D006214 */  bne        $v1, $v0, .L8006993C
    /* 5A0C8 800698C8 00000000 */   nop
    /* 5A0CC 800698CC 0400828C */  lw         $v0, 0x4($a0)
    /* 5A0D0 800698D0 00000000 */  nop
    /* 5A0D4 800698D4 6002428C */  lw         $v0, 0x260($v0)
    /* 5A0D8 800698D8 00000000 */  nop
    /* 5A0DC 800698DC 00024230 */  andi       $v0, $v0, 0x200
    /* 5A0E0 800698E0 17004010 */  beqz       $v0, .L80069940
    /* 5A0E4 800698E4 21206002 */   addu      $a0, $s3, $zero
  .L800698E8:
    /* 5A0E8 800698E8 6002628E */  lw         $v0, 0x260($s3)
    /* 5A0EC 800698EC 00000000 */  nop
    /* 5A0F0 800698F0 08004230 */  andi       $v0, $v0, 0x8
    /* 5A0F4 800698F4 11004010 */  beqz       $v0, .L8006993C
    /* 5A0F8 800698F8 00000000 */   nop
    /* 5A0FC 800698FC 02000106 */  bgez       $s0, .L80069908
    /* 5A100 80069900 21200002 */   addu      $a0, $s0, $zero
    /* 5A104 80069904 FF000426 */  addiu      $a0, $s0, 0xFF
  .L80069908:
    /* 5A108 80069908 1180033C */  lui        $v1, %hi(AITune_BTCPerpAccMults)
    /* 5A10C 8006990C 0800A28C */  lw         $v0, 0x8($a1)
    /* 5A110 80069910 68DE6324 */  addiu      $v1, $v1, %lo(AITune_BTCPerpAccMults)
    /* 5A114 80069914 80100200 */  sll        $v0, $v0, 2
    /* 5A118 80069918 21104300 */  addu       $v0, $v0, $v1
    /* 5A11C 8006991C 0000428C */  lw         $v0, 0x0($v0)
    /* 5A120 80069920 00000000 */  nop
    /* 5A124 80069924 02004104 */  bgez       $v0, .L80069930
    /* 5A128 80069928 03220400 */   sra       $a0, $a0, 8
    /* 5A12C 8006992C FF004224 */  addiu      $v0, $v0, 0xFF
  .L80069930:
    /* 5A130 80069930 03120200 */  sra        $v0, $v0, 8
    /* 5A134 80069934 18008200 */  mult       $a0, $v0
    /* 5A138 80069938 12800000 */  mflo       $s0
  .L8006993C:
    /* 5A13C 8006993C 21206002 */  addu       $a0, $s3, $zero
  .L80069940:
    /* 5A140 80069940 64A6010C */  jal        AIPhysic_ModifyAccelerationAccordingToScript__FP8Car_tObji
    /* 5A144 80069944 21280002 */   addu      $a1, $s0, $zero
    /* 5A148 80069948 21804000 */  addu       $s0, $v0, $zero
    /* 5A14C 8006994C 27B6010C */  jal        AISpeeds_SuperDuperSpeedUpTheCarsAtTheStartBecauseWeCannotActuallyHandleRenderingTheseCars__FP8Car_tObj
    /* 5A150 80069950 21206002 */   addu      $a0, $s3, $zero
    /* 5A154 80069954 21284000 */  addu       $a1, $v0, $zero
    /* 5A158 80069958 0100023C */  lui        $v0, (0x10000 >> 16)
    /* 5A15C 8006995C 0500A210 */  beq        $a1, $v0, .L80069974
    /* 5A160 80069960 21100002 */   addu      $v0, $s0, $zero
    /* 5A164 80069964 CA90030C */  jal        fixedmult
    /* 5A168 80069968 21200002 */   addu      $a0, $s0, $zero
    /* 5A16C 8006996C 21804000 */  addu       $s0, $v0, $zero
    /* 5A170 80069970 21100002 */  addu       $v0, $s0, $zero
  .L80069974:
    /* 5A174 80069974 2000BF8F */  lw         $ra, 0x20($sp)
    /* 5A178 80069978 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 5A17C 8006997C 1800B28F */  lw         $s2, 0x18($sp)
    /* 5A180 80069980 1400B18F */  lw         $s1, 0x14($sp)
    /* 5A184 80069984 1000B08F */  lw         $s0, 0x10($sp)
    /* 5A188 80069988 0800E003 */  jr         $ra
    /* 5A18C 8006998C 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel AIPhysic_CalcAcceleration__FP8Car_tObji
