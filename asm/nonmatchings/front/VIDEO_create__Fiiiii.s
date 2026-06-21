.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching VIDEO_create__Fiiiii, 0x178

glabel VIDEO_create__Fiiiii
    /* 414C8 80050CC8 70FFBD27 */  addiu      $sp, $sp, -0x90
    /* 414CC 80050CCC 7400B1AF */  sw         $s1, 0x74($sp)
    /* 414D0 80050CD0 A000B18F */  lw         $s1, 0xA0($sp)
    /* 414D4 80050CD4 7C00B3AF */  sw         $s3, 0x7C($sp)
    /* 414D8 80050CD8 21988000 */  addu       $s3, $a0, $zero
    /* 414DC 80050CDC 8000B4AF */  sw         $s4, 0x80($sp)
    /* 414E0 80050CE0 21A0A000 */  addu       $s4, $a1, $zero
    /* 414E4 80050CE4 8400B5AF */  sw         $s5, 0x84($sp)
    /* 414E8 80050CE8 21A8C000 */  addu       $s5, $a2, $zero
    /* 414EC 80050CEC 7800B2AF */  sw         $s2, 0x78($sp)
    /* 414F0 80050CF0 2190E000 */  addu       $s2, $a3, $zero
    /* 414F4 80050CF4 8800BFAF */  sw         $ra, 0x88($sp)
    /* 414F8 80050CF8 2871030C */  jal        Platform_ResetDCTBuffer__Fv
    /* 414FC 80050CFC 7000B0AF */   sw        $s0, 0x70($sp)
    /* 41500 80050D00 3000B027 */  addiu      $s0, $sp, 0x30
    /* 41504 80050D04 21200002 */  addu       $a0, $s0, $zero
    /* 41508 80050D08 1180023C */  lui        $v0, %hi(D_801164E8)
    /* 4150C 80050D0C 0180053C */  lui        $a1, %hi(D_800128C8)
    /* 41510 80050D10 E864468C */  lw         $a2, %lo(D_801164E8)($v0)
    /* 41514 80050D14 2F91030C */  jal        sprintf
    /* 41518 80050D18 C828A524 */   addiu     $a1, $a1, %lo(D_800128C8)
    /* 4151C 80050D1C 21200002 */  addu       $a0, $s0, $zero
    /* 41520 80050D20 1280053C */  lui        $a1, %hi(CF_DVLC)
    /* 41524 80050D24 0FC5030C */  jal        asyncloadfileat
    /* 41528 80050D28 3840A524 */   addiu     $a1, $a1, %lo(CF_DVLC)
    /* 4152C 80050D2C 21804000 */  addu       $s0, $v0, $zero
  .L80050D30:
    /* 41530 80050D30 B6C5030C */  jal        getasyncreadstatus
    /* 41534 80050D34 21200002 */   addu      $a0, $s0, $zero
    /* 41538 80050D38 05004014 */  bnez       $v0, .L80050D50
    /* 4153C 80050D3C 0180043C */   lui       $a0, %hi(D_800128D4)
    /* 41540 80050D40 019B030C */  jal        systemtask
    /* 41544 80050D44 21200000 */   addu      $a0, $zero, $zero
    /* 41548 80050D48 4C430108 */  j          .L80050D30
    /* 4154C 80050D4C 00000000 */   nop
  .L80050D50:
    /* 41550 80050D50 D4288424 */  addiu      $a0, $a0, %lo(D_800128D4)
    /* 41554 80050D54 40000524 */  addiu      $a1, $zero, 0x40
    /* 41558 80050D58 CF94030C */  jal        reservememadr
    /* 4155C 80050D5C 21302002 */   addu      $a2, $s1, $zero
    /* 41560 80050D60 21804000 */  addu       $s0, $v0, $zero
    /* 41564 80050D64 21200002 */  addu       $a0, $s0, $zero
    /* 41568 80050D68 E8C5030C */  jal        blockclear
    /* 4156C 80050D6C 40000524 */   addiu     $a1, $zero, 0x40
    /* 41570 80050D70 4457023C */  lui        $v0, (0x57444956 >> 16)
    /* 41574 80050D74 56494234 */  ori        $v0, $v0, (0x57444956 & 0xFFFF)
    /* 41578 80050D78 0180043C */  lui        $a0, %hi(D_800128E0)
    /* 4157C 80050D7C E0288424 */  addiu      $a0, $a0, %lo(D_800128E0)
    /* 41580 80050D80 21284002 */  addu       $a1, $s2, $zero
    /* 41584 80050D84 21302002 */  addu       $a2, $s1, $zero
    /* 41588 80050D88 000002AE */  sw         $v0, 0x0($s0)
    /* 4158C 80050D8C 040013AE */  sw         $s3, 0x4($s0)
    /* 41590 80050D90 CF94030C */  jal        reservememadr
    /* 41594 80050D94 080014AE */   sw        $s4, 0x8($s0)
    /* 41598 80050D98 02000424 */  addiu      $a0, $zero, 0x2
    /* 4159C 80050D9C 21288000 */  addu       $a1, $a0, $zero
    /* 415A0 80050DA0 0C0002AE */  sw         $v0, 0xC($s0)
    /* 415A4 80050DA4 1000B2AF */  sw         $s2, 0x10($sp)
    /* 415A8 80050DA8 0C00078E */  lw         $a3, 0xC($s0)
    /* 415AC 80050DAC 85F3030C */  jal        STREAM_create
    /* 415B0 80050DB0 21308000 */   addu      $a2, $a0, $zero
    /* 415B4 80050DB4 01000524 */  addiu      $a1, $zero, 0x1
    /* 415B8 80050DB8 FFFF0634 */  ori        $a2, $zero, 0xFFFF
    /* 415BC 80050DBC 180002AE */  sw         $v0, 0x18($s0)
    /* 415C0 80050DC0 02000224 */  addiu      $v0, $zero, 0x2
    /* 415C4 80050DC4 1000A2AF */  sw         $v0, 0x10($sp)
    /* 415C8 80050DC8 1800048E */  lw         $a0, 0x18($s0)
    /* 415CC 80050DCC 15F4030C */  jal        STREAM_setfilter
    /* 415D0 80050DD0 53430724 */   addiu     $a3, $zero, 0x4353
    /* 415D4 80050DD4 21206002 */  addu       $a0, $s3, $zero
    /* 415D8 80050DD8 21288002 */  addu       $a1, $s4, $zero
    /* 415DC 80050DDC 1480023C */  lui        $v0, %hi(screenbpp)
    /* 415E0 80050DE0 90DC468C */  lw         $a2, %lo(screenbpp)($v0)
    /* 415E4 80050DE4 3042010C */  jal        initmdec
    /* 415E8 80050DE8 21382002 */   addu      $a3, $s1, $zero
    /* 415EC 80050DEC 1480033C */  lui        $v1, %hi(timerhz)
    /* 415F0 80050DF0 C4DC648C */  lw         $a0, %lo(timerhz)($v1)
    /* 415F4 80050DF4 0A00053C */  lui        $a1, (0xA0000 >> 16)
    /* 415F8 80050DF8 100002AE */  sw         $v0, 0x10($s0)
    /* 415FC 80050DFC CA90030C */  jal        fixedmult
    /* 41600 80050E00 00240400 */   sll       $a0, $a0, 16
    /* 41604 80050E04 21204000 */  addu       $a0, $v0, $zero
    /* 41608 80050E08 0191030C */  jal        rdiv
    /* 4160C 80050E0C 2128A002 */   addu      $a1, $s5, $zero
    /* 41610 80050E10 300002AE */  sw         $v0, 0x30($s0)
    /* 41614 80050E14 21100002 */  addu       $v0, $s0, $zero
    /* 41618 80050E18 1C0040AC */  sw         $zero, 0x1C($v0)
    /* 4161C 80050E1C 8800BF8F */  lw         $ra, 0x88($sp)
    /* 41620 80050E20 8400B58F */  lw         $s5, 0x84($sp)
    /* 41624 80050E24 8000B48F */  lw         $s4, 0x80($sp)
    /* 41628 80050E28 7C00B38F */  lw         $s3, 0x7C($sp)
    /* 4162C 80050E2C 7800B28F */  lw         $s2, 0x78($sp)
    /* 41630 80050E30 7400B18F */  lw         $s1, 0x74($sp)
    /* 41634 80050E34 7000B08F */  lw         $s0, 0x70($sp)
    /* 41638 80050E38 0800E003 */  jr         $ra
    /* 4163C 80050E3C 9000BD27 */   addiu     $sp, $sp, 0x90
endlabel VIDEO_create__Fiiiii
