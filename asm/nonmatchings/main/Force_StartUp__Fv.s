.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Force_StartUp__Fv, 0xCC

glabel Force_StartUp__Fv
    /* BB818 800CB018 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* BB81C 800CB01C 1280023C */  lui        $v0, %hi(Force_g)
    /* BB820 800CB020 60FD4424 */  addiu      $a0, $v0, %lo(Force_g)
    /* BB824 800CB024 10008324 */  addiu      $v1, $a0, 0x10
    /* BB828 800CB028 2B108300 */  sltu       $v0, $a0, $v1
    /* BB82C 800CB02C 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* BB830 800CB030 1800B2AF */  sw         $s2, 0x18($sp)
    /* BB834 800CB034 1400B1AF */  sw         $s1, 0x14($sp)
    /* BB838 800CB038 0D004010 */  beqz       $v0, .L800CB070
    /* BB83C 800CB03C 1000B0AF */   sw        $s0, 0x10($sp)
    /* BB840 800CB040 21286000 */  addu       $a1, $v1, $zero
    /* BB844 800CB044 07008324 */  addiu      $v1, $a0, 0x7
  .L800CB048:
    /* BB848 800CB048 000080A0 */  sb         $zero, 0x0($a0)
    /* BB84C 800CB04C FAFF60A0 */  sb         $zero, -0x6($v1)
    /* BB850 800CB050 FBFF60A0 */  sb         $zero, -0x5($v1)
    /* BB854 800CB054 FDFF60A0 */  sb         $zero, -0x3($v1)
    /* BB858 800CB058 FFFF60A0 */  sb         $zero, -0x1($v1)
    /* BB85C 800CB05C 000060A0 */  sb         $zero, 0x0($v1)
    /* BB860 800CB060 08008424 */  addiu      $a0, $a0, 0x8
    /* BB864 800CB064 2B108500 */  sltu       $v0, $a0, $a1
    /* BB868 800CB068 F7FF4014 */  bnez       $v0, .L800CB048
    /* BB86C 800CB06C 08006324 */   addiu     $v1, $v1, 0x8
  .L800CB070:
    /* BB870 800CB070 0D80043C */  lui        $a0, %hi(Force_Vbl__Fv)
    /* BB874 800CB074 37CA030C */  jal        VSyncCallback
    /* BB878 800CB078 98A98424 */   addiu     $a0, $a0, %lo(Force_Vbl__Fv)
    /* BB87C 800CB07C 0D80023C */  lui        $v0, %hi(Force_Update__FP8Car_tObj)
    /* BB880 800CB080 C0AB5224 */  addiu      $s2, $v0, %lo(Force_Update__FP8Car_tObj)
    /* BB884 800CB084 21284002 */  addu       $a1, $s2, $zero
    /* BB888 800CB088 32000724 */  addiu      $a3, $zero, 0x32
    /* BB88C 800CB08C 1280023C */  lui        $v0, %hi(simGlobal)
    /* BB890 800CB090 ACE05024 */  addiu      $s0, $v0, %lo(simGlobal)
    /* BB894 800CB094 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* BB898 800CB098 1000048E */  lw         $a0, 0x10($s0)
    /* BB89C 800CB09C 48FA468C */  lw         $a2, %lo(Cars_gHumanRaceCarList)($v0)
    /* BB8A0 800CB0A0 E0D8020C */  jal        Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
    /* BB8A4 800CB0A4 48FA5124 */   addiu     $s1, $v0, %lo(Cars_gHumanRaceCarList)
    /* BB8A8 800CB0A8 1180023C */  lui        $v0, %hi(D_801131F8)
    /* BB8AC 800CB0AC F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* BB8B0 800CB0B0 01000224 */  addiu      $v0, $zero, 0x1
    /* BB8B4 800CB0B4 05006214 */  bne        $v1, $v0, .L800CB0CC
    /* BB8B8 800CB0B8 21284002 */   addu      $a1, $s2, $zero
    /* BB8BC 800CB0BC 1000048E */  lw         $a0, 0x10($s0)
    /* BB8C0 800CB0C0 0400268E */  lw         $a2, 0x4($s1)
    /* BB8C4 800CB0C4 E0D8020C */  jal        Sched_AddFunction__FP15Sched_tSchedulePFPv_vPvi
    /* BB8C8 800CB0C8 32000724 */   addiu     $a3, $zero, 0x32
  .L800CB0CC:
    /* BB8CC 800CB0CC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* BB8D0 800CB0D0 1800B28F */  lw         $s2, 0x18($sp)
    /* BB8D4 800CB0D4 1400B18F */  lw         $s1, 0x14($sp)
    /* BB8D8 800CB0D8 1000B08F */  lw         $s0, 0x10($sp)
    /* BB8DC 800CB0DC 0800E003 */  jr         $ra
    /* BB8E0 800CB0E0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel Force_StartUp__Fv
