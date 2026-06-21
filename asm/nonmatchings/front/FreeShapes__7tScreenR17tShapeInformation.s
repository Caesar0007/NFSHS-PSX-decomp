.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching FreeShapes__7tScreenR17tShapeInformation, 0x160

glabel FreeShapes__7tScreenR17tShapeInformation
    /* 16C94 80026494 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 16C98 80026498 1000B0AF */  sw         $s0, 0x10($sp)
    /* 16C9C 8002649C 2180A000 */  addu       $s0, $a1, $zero
    /* 16CA0 800264A0 1C00BFAF */  sw         $ra, 0x1C($sp)
    /* 16CA4 800264A4 1800B2AF */  sw         $s2, 0x18($sp)
    /* 16CA8 800264A8 D598000C */  jal        CancelAsyncLoad__7tScreenR17tShapeInformation
    /* 16CAC 800264AC 1400B1AF */   sw        $s1, 0x14($sp)
    /* 16CB0 800264B0 0C00028E */  lw         $v0, 0xC($s0)
    /* 16CB4 800264B4 00000000 */  nop
    /* 16CB8 800264B8 1E004010 */  beqz       $v0, .L80026534
    /* 16CBC 800264BC 00000000 */   nop
    /* 16CC0 800264C0 FFFF1224 */  addiu      $s2, $zero, -0x1
    /* 16CC4 800264C4 FEFF1124 */  addiu      $s1, $zero, -0x2
  .L800264C8:
    /* 16CC8 800264C8 0C00048E */  lw         $a0, 0xC($s0)
    /* 16CCC 800264CC B6C5030C */  jal        getasyncreadstatus
    /* 16CD0 800264D0 00000000 */   nop
    /* 16CD4 800264D4 0300401C */  bgtz       $v0, .L800264E4
    /* 16CD8 800264D8 00000000 */   nop
    /* 16CDC 800264DC 0C005214 */  bne        $v0, $s2, .L80026510
    /* 16CE0 800264E0 00000000 */   nop
  .L800264E4:
    /* 16CE4 800264E4 0800028E */  lw         $v0, 0x8($s0)
    /* 16CE8 800264E8 00000000 */  nop
    /* 16CEC 800264EC 06004014 */  bnez       $v0, .L80026508
    /* 16CF0 800264F0 00000000 */   nop
    /* 16CF4 800264F4 0C00048E */  lw         $a0, 0xC($s0)
    /* 16CF8 800264F8 90C5030C */  jal        getasyncreadadr
    /* 16CFC 800264FC 00000000 */   nop
    /* 16D00 80026500 46990008 */  j          .L80026518
    /* 16D04 80026504 040002AE */   sw        $v0, 0x4($s0)
  .L80026508:
    /* 16D08 80026508 46990008 */  j          .L80026518
    /* 16D0C 8002650C 040000AE */   sw        $zero, 0x4($s0)
  .L80026510:
    /* 16D10 80026510 02005114 */  bne        $v0, $s1, .L8002651C
    /* 16D14 80026514 00000000 */   nop
  .L80026518:
    /* 16D18 80026518 0C0000AE */  sw         $zero, 0xC($s0)
  .L8002651C:
    /* 16D1C 8002651C 5256000C */  jal        FeAudio_systemtask__Fi
    /* 16D20 80026520 21200000 */   addu      $a0, $zero, $zero
    /* 16D24 80026524 0C00028E */  lw         $v0, 0xC($s0)
    /* 16D28 80026528 00000000 */  nop
    /* 16D2C 8002652C E6FF4014 */  bnez       $v0, .L800264C8
    /* 16D30 80026530 00000000 */   nop
  .L80026534:
    /* 16D34 80026534 0400048E */  lw         $a0, 0x4($s0)
    /* 16D38 80026538 00000000 */  nop
    /* 16D3C 8002653C 08008010 */  beqz       $a0, .L80026560
    /* 16D40 80026540 00000000 */   nop
    /* 16D44 80026544 0800028E */  lw         $v0, 0x8($s0)
    /* 16D48 80026548 00000000 */  nop
    /* 16D4C 8002654C 03004014 */  bnez       $v0, .L8002655C
    /* 16D50 80026550 00000000 */   nop
    /* 16D54 80026554 5095030C */  jal        purgememadr
    /* 16D58 80026558 00000000 */   nop
  .L8002655C:
    /* 16D5C 8002655C 040000AE */  sw         $zero, 0x4($s0)
  .L80026560:
    /* 16D60 80026560 0000028E */  lw         $v0, 0x0($s0)
    /* 16D64 80026564 00000000 */  nop
    /* 16D68 80026568 1C004010 */  beqz       $v0, .L800265DC
    /* 16D6C 8002656C 00000000 */   nop
    /* 16D70 80026570 10000296 */  lhu        $v0, 0x10($s0)
    /* 16D74 80026574 00000000 */  nop
    /* 16D78 80026578 14004010 */  beqz       $v0, .L800265CC
    /* 16D7C 8002657C 21880000 */   addu      $s1, $zero, $zero
    /* 16D80 80026580 00141100 */  sll        $v0, $s1, 16
  .L80026584:
    /* 16D84 80026584 0000038E */  lw         $v1, 0x0($s0)
    /* 16D88 80026588 C3120200 */  sra        $v0, $v0, 11
    /* 16D8C 8002658C 21184300 */  addu       $v1, $v0, $v1
    /* 16D90 80026590 0400628C */  lw         $v0, 0x4($v1)
    /* 16D94 80026594 00000000 */  nop
    /* 16D98 80026598 05004010 */  beqz       $v0, .L800265B0
    /* 16D9C 8002659C 01002226 */   addiu     $v0, $s1, 0x1
    /* 16DA0 800265A0 04006484 */  lh         $a0, 0x4($v1)
    /* 16DA4 800265A4 697E030C */  jal        Texture_MenuReleaseClutId__Fs
    /* 16DA8 800265A8 00000000 */   nop
    /* 16DAC 800265AC 01002226 */  addiu      $v0, $s1, 0x1
  .L800265B0:
    /* 16DB0 800265B0 21884000 */  addu       $s1, $v0, $zero
    /* 16DB4 800265B4 00140200 */  sll        $v0, $v0, 16
    /* 16DB8 800265B8 10000396 */  lhu        $v1, 0x10($s0)
    /* 16DBC 800265BC 03140200 */  sra        $v0, $v0, 16
    /* 16DC0 800265C0 2A104300 */  slt        $v0, $v0, $v1
    /* 16DC4 800265C4 EFFF4014 */  bnez       $v0, .L80026584
    /* 16DC8 800265C8 00141100 */   sll       $v0, $s1, 16
  .L800265CC:
    /* 16DCC 800265CC 0000048E */  lw         $a0, 0x0($s0)
    /* 16DD0 800265D0 5095030C */  jal        purgememadr
    /* 16DD4 800265D4 00000000 */   nop
    /* 16DD8 800265D8 000000AE */  sw         $zero, 0x0($s0)
  .L800265DC:
    /* 16DDC 800265DC 1C00BF8F */  lw         $ra, 0x1C($sp)
    /* 16DE0 800265E0 1800B28F */  lw         $s2, 0x18($sp)
    /* 16DE4 800265E4 1400B18F */  lw         $s1, 0x14($sp)
    /* 16DE8 800265E8 1000B08F */  lw         $s0, 0x10($sp)
    /* 16DEC 800265EC 0800E003 */  jr         $ra
    /* 16DF0 800265F0 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel FreeShapes__7tScreenR17tShapeInformation
