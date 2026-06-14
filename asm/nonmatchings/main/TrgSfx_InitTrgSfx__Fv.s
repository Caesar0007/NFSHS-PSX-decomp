.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching TrgSfx_InitTrgSfx__Fv, 0xD8

glabel TrgSfx_InitTrgSfx__Fv
    /* AC100 800BB900 21500000 */  addu       $t2, $zero, $zero
    /* AC104 800BB904 1280023C */  lui        $v0, %hi(gTAddCarWheelSfx)
    /* AC108 800BB908 F0E15924 */  addiu      $t9, $v0, %lo(gTAddCarWheelSfx)
    /* AC10C 800BB90C 1280023C */  lui        $v0, %hi(gTAddCarExtraSfx)
    /* AC110 800BB910 70E25824 */  addiu      $t8, $v0, %lo(gTAddCarExtraSfx)
    /* AC114 800BB914 21684001 */  addu       $t5, $t2, $zero
    /* AC118 800BB918 1280023C */  lui        $v0, %hi(gTAddCarSfx)
    /* AC11C 800BB91C D0E14C24 */  addiu      $t4, $v0, %lo(gTAddCarSfx)
    /* AC120 800BB920 1280023C */  lui        $v0, %hi(D_8011E0B0)
    /* AC124 800BB924 1280033C */  lui        $v1, %hi(gTEnviroEffect)
    /* AC128 800BB928 B0E0498C */  lw         $t1, %lo(D_8011E0B0)($v0)
    /* AC12C 800BB92C B0E16B24 */  addiu      $t3, $v1, %lo(gTEnviroEffect)
    /* AC130 800BB930 A80F89AF */  sw         $t1, %gp_rel(gTAddCSmoke)($gp)
  .L800BB934:
    /* AC134 800BB934 21400000 */  addu       $t0, $zero, $zero
    /* AC138 800BB938 1280023C */  lui        $v0, %hi(gStatusSm)
    /* AC13C 800BB93C 70E64F24 */  addiu      $t7, $v0, %lo(gStatusSm)
    /* AC140 800BB940 1280023C */  lui        $v0, %hi(gPrevSkidSm)
    /* AC144 800BB944 F0E24E24 */  addiu      $t6, $v0, %lo(gPrevSkidSm)
    /* AC148 800BB948 2138A001 */  addu       $a3, $t5, $zero
    /* AC14C 800BB94C 00310A00 */  sll        $a2, $t2, 4
    /* AC150 800BB950 000069AD */  sw         $t1, 0x0($t3)
    /* AC154 800BB954 000089AD */  sw         $t1, 0x0($t4)
  .L800BB958:
    /* AC158 800BB958 2110EE00 */  addu       $v0, $a3, $t6
    /* AC15C 800BB95C 1C00E724 */  addiu      $a3, $a3, 0x1C
    /* AC160 800BB960 2118D900 */  addu       $v1, $a2, $t9
    /* AC164 800BB964 2120D800 */  addu       $a0, $a2, $t8
    /* AC168 800BB968 2128CF00 */  addu       $a1, $a2, $t7
    /* AC16C 800BB96C 01000825 */  addiu      $t0, $t0, 0x1
    /* AC170 800BB970 000069AC */  sw         $t1, 0x0($v1)
    /* AC174 800BB974 000089AC */  sw         $t1, 0x0($a0)
    /* AC178 800BB978 0000A0AC */  sw         $zero, 0x0($a1)
    /* AC17C 800BB97C 000040AC */  sw         $zero, 0x0($v0)
    /* AC180 800BB980 040040AC */  sw         $zero, 0x4($v0)
    /* AC184 800BB984 080040AC */  sw         $zero, 0x8($v0)
    /* AC188 800BB988 140040AC */  sw         $zero, 0x14($v0)
    /* AC18C 800BB98C 04000229 */  slti       $v0, $t0, 0x4
    /* AC190 800BB990 F1FF4014 */  bnez       $v0, .L800BB958
    /* AC194 800BB994 0400C624 */   addiu     $a2, $a2, 0x4
    /* AC198 800BB998 7000AD25 */  addiu      $t5, $t5, 0x70
    /* AC19C 800BB99C 04008C25 */  addiu      $t4, $t4, 0x4
    /* AC1A0 800BB9A0 01004A25 */  addiu      $t2, $t2, 0x1
    /* AC1A4 800BB9A4 08004229 */  slti       $v0, $t2, 0x8
    /* AC1A8 800BB9A8 E2FF4014 */  bnez       $v0, .L800BB934
    /* AC1AC 800BB9AC 04006B25 */   addiu     $t3, $t3, 0x4
    /* AC1B0 800BB9B0 08000224 */  addiu      $v0, $zero, 0x8
    /* AC1B4 800BB9B4 A40F82AF */  sw         $v0, %gp_rel(gTAddCarWheelDelay)($gp)
    /* AC1B8 800BB9B8 1180023C */  lui        $v0, %hi(D_801131F8)
    /* AC1BC 800BB9BC F831438C */  lw         $v1, %lo(D_801131F8)($v0)
    /* AC1C0 800BB9C0 01000224 */  addiu      $v0, $zero, 0x1
    /* AC1C4 800BB9C4 02006214 */  bne        $v1, $v0, .L800BB9D0
    /* AC1C8 800BB9C8 0C000224 */   addiu     $v0, $zero, 0xC
    /* AC1CC 800BB9CC A40F82AF */  sw         $v0, %gp_rel(gTAddCarWheelDelay)($gp)
  .L800BB9D0:
    /* AC1D0 800BB9D0 0800E003 */  jr         $ra
    /* AC1D4 800BB9D4 00000000 */   nop
endlabel TrgSfx_InitTrgSfx__Fv
