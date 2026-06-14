.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Camera_GetMode__Fi, 0xA0

glabel Camera_GetMode__Fi
    /* 75D68 80085568 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
    /* 75D6C 8008556C 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* 75D70 80085570 80180400 */  sll        $v1, $a0, 2
    /* 75D74 80085574 21186200 */  addu       $v1, $v1, $v0
    /* 75D78 80085578 0000638C */  lw         $v1, 0x0($v1)
    /* 75D7C 8008557C 00000000 */  nop
    /* 75D80 80085580 6002628C */  lw         $v0, 0x260($v1)
    /* 75D84 80085584 00000000 */  nop
    /* 75D88 80085588 01004230 */  andi       $v0, $v0, 0x1
    /* 75D8C 8008558C 07004010 */  beqz       $v0, .L800855AC
    /* 75D90 80085590 02000224 */   addiu     $v0, $zero, 0x2
    /* 75D94 80085594 9003638C */  lw         $v1, 0x390($v1)
    /* 75D98 80085598 00000000 */  nop
    /* 75D9C 8008559C 04006214 */  bne        $v1, $v0, .L800855B0
    /* 75DA0 800855A0 1180023C */   lui       $v0, %hi(Cars_gHumanRaceCarList)
  .L800855A4:
    /* 75DA4 800855A4 0800E003 */  jr         $ra
    /* 75DA8 800855A8 14000224 */   addiu     $v0, $zero, 0x14
  .L800855AC:
    /* 75DAC 800855AC 1180023C */  lui        $v0, %hi(Cars_gHumanRaceCarList)
  .L800855B0:
    /* 75DB0 800855B0 48FA4224 */  addiu      $v0, $v0, %lo(Cars_gHumanRaceCarList)
    /* 75DB4 800855B4 80180400 */  sll        $v1, $a0, 2
    /* 75DB8 800855B8 21186200 */  addu       $v1, $v1, $v0
    /* 75DBC 800855BC 0000638C */  lw         $v1, 0x0($v1)
    /* 75DC0 800855C0 00000000 */  nop
    /* 75DC4 800855C4 7802628C */  lw         $v0, 0x278($v1)
    /* 75DC8 800855C8 00000000 */  nop
    /* 75DCC 800855CC 05004010 */  beqz       $v0, .L800855E4
    /* 75DD0 800855D0 03000224 */   addiu     $v0, $zero, 0x3
    /* 75DD4 800855D4 9003638C */  lw         $v1, 0x390($v1)
    /* 75DD8 800855D8 00000000 */  nop
    /* 75DDC 800855DC F1FF6214 */  bne        $v1, $v0, .L800855A4
    /* 75DE0 800855E0 00000000 */   nop
  .L800855E4:
    /* 75DE4 800855E4 1180033C */  lui        $v1, %hi(Camera_gInfo)
    /* 75DE8 800855E8 ACF26324 */  addiu      $v1, $v1, %lo(Camera_gInfo)
    /* 75DEC 800855EC 00110400 */  sll        $v0, $a0, 4
    /* 75DF0 800855F0 21104400 */  addu       $v0, $v0, $a0
    /* 75DF4 800855F4 00110200 */  sll        $v0, $v0, 4
    /* 75DF8 800855F8 21104300 */  addu       $v0, $v0, $v1
    /* 75DFC 800855FC 70004284 */  lh         $v0, 0x70($v0)
    /* 75E00 80085600 0800E003 */  jr         $ra
    /* 75E04 80085604 00000000 */   nop
endlabel Camera_GetMode__Fi
