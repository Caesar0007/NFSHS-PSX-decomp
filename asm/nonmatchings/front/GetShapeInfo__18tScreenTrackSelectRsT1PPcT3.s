.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__18tScreenTrackSelectRsT1PPcT3, 0xC0

glabel GetShapeInfo__18tScreenTrackSelectRsT1PPcT3
    /* 322AC 80041AAC A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* 322B0 80041AB0 5400B5AF */  sw         $s5, 0x54($sp)
    /* 322B4 80041AB4 21A88000 */  addu       $s5, $a0, $zero
    /* 322B8 80041AB8 4800B2AF */  sw         $s2, 0x48($sp)
    /* 322BC 80041ABC 2190A000 */  addu       $s2, $a1, $zero
    /* 322C0 80041AC0 4C00B3AF */  sw         $s3, 0x4C($sp)
    /* 322C4 80041AC4 2198C000 */  addu       $s3, $a2, $zero
    /* 322C8 80041AC8 5000B4AF */  sw         $s4, 0x50($sp)
    /* 322CC 80041ACC 21A0E000 */  addu       $s4, $a3, $zero
    /* 322D0 80041AD0 1180043C */  lui        $a0, %hi(trackManager)
    /* 322D4 80041AD4 1180023C */  lui        $v0, %hi(D_80114623)
    /* 322D8 80041AD8 23464590 */  lbu        $a1, %lo(D_80114623)($v0)
    /* 322DC 80041ADC 504A8424 */  addiu      $a0, $a0, %lo(trackManager)
    /* 322E0 80041AE0 4400B1AF */  sw         $s1, 0x44($sp)
    /* 322E4 80041AE4 7000B18F */  lw         $s1, 0x70($sp)
    /* 322E8 80041AE8 1000A627 */  addiu      $a2, $sp, 0x10
    /* 322EC 80041AEC 5800BFAF */  sw         $ra, 0x58($sp)
    /* 322F0 80041AF0 A986000C */  jal        GetTrack__13tTrackManagersR17tTrackInformation
    /* 322F4 80041AF4 4000B0AF */   sw        $s0, 0x40($sp)
    /* 322F8 80041AF8 0580103C */  lui        $s0, %hi(D_80052CA0)
    /* 322FC 80041AFC A02C1026 */  addiu      $s0, $s0, %lo(D_80052CA0)
    /* 32300 80041B00 21200002 */  addu       $a0, $s0, $zero
    /* 32304 80041B04 0180053C */  lui        $a1, %hi(D_80011F04)
    /* 32308 80041B08 041FA524 */  addiu      $a1, $a1, %lo(D_80011F04)
    /* 3230C 80041B0C 1800A627 */  addiu      $a2, $sp, 0x18
    /* 32310 80041B10 44000224 */  addiu      $v0, $zero, 0x44
    /* 32314 80041B14 000042A6 */  sh         $v0, 0x0($s2)
    /* 32318 80041B18 0A000224 */  addiu      $v0, $zero, 0xA
    /* 3231C 80041B1C 000062A6 */  sh         $v0, 0x0($s3)
    /* 32320 80041B20 0180023C */  lui        $v0, %hi(D_80011EFC)
    /* 32324 80041B24 FC1E4224 */  addiu      $v0, $v0, %lo(D_80011EFC)
    /* 32328 80041B28 2F91030C */  jal        sprintf
    /* 3232C 80041B2C 000082AE */   sw        $v0, 0x0($s4)
    /* 32330 80041B30 000030AE */  sw         $s0, 0x0($s1)
    /* 32334 80041B34 1000A293 */  lbu        $v0, 0x10($sp)
    /* 32338 80041B38 00000000 */  nop
    /* 3233C 80041B3C 00160200 */  sll        $v0, $v0, 24
    /* 32340 80041B40 03160200 */  sra        $v0, $v0, 24
    /* 32344 80041B44 6C00A2A6 */  sh         $v0, 0x6C($s5)
    /* 32348 80041B48 5800BF8F */  lw         $ra, 0x58($sp)
    /* 3234C 80041B4C 5400B58F */  lw         $s5, 0x54($sp)
    /* 32350 80041B50 5000B48F */  lw         $s4, 0x50($sp)
    /* 32354 80041B54 4C00B38F */  lw         $s3, 0x4C($sp)
    /* 32358 80041B58 4800B28F */  lw         $s2, 0x48($sp)
    /* 3235C 80041B5C 4400B18F */  lw         $s1, 0x44($sp)
    /* 32360 80041B60 4000B08F */  lw         $s0, 0x40($sp)
    /* 32364 80041B64 0800E003 */  jr         $ra
    /* 32368 80041B68 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel GetShapeInfo__18tScreenTrackSelectRsT1PPcT3
