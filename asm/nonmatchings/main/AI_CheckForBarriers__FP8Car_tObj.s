.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_CheckForBarriers__FP8Car_tObj, 0x3C0

glabel AI_CheckForBarriers__FP8Car_tObj
    /* 48AD4 800582D4 A0FFBD27 */  addiu      $sp, $sp, -0x60
    /* 48AD8 800582D8 5400B7AF */  sw         $s7, 0x54($sp)
    /* 48ADC 800582DC 21B88000 */  addu       $s7, $a0, $zero
    /* 48AE0 800582E0 0580023C */  lui        $v0, %hi(D_80054DA4)
    /* 48AE4 800582E4 5C00BFAF */  sw         $ra, 0x5C($sp)
    /* 48AE8 800582E8 5800BEAF */  sw         $fp, 0x58($sp)
    /* 48AEC 800582EC 5000B6AF */  sw         $s6, 0x50($sp)
    /* 48AF0 800582F0 4C00B5AF */  sw         $s5, 0x4C($sp)
    /* 48AF4 800582F4 4800B4AF */  sw         $s4, 0x48($sp)
    /* 48AF8 800582F8 4400B3AF */  sw         $s3, 0x44($sp)
    /* 48AFC 800582FC 4000B2AF */  sw         $s2, 0x40($sp)
    /* 48B00 80058300 3C00B1AF */  sw         $s1, 0x3C($sp)
    /* 48B04 80058304 3800B0AF */  sw         $s0, 0x38($sp)
    /* 48B08 80058308 A44D4924 */  addiu      $t1, $v0, %lo(D_80054DA4)
    /* 48B0C 8005830C 0000268D */  lw         $a2, 0x0($t1)
    /* 48B10 80058310 0400278D */  lw         $a3, 0x4($t1)
    /* 48B14 80058314 0800288D */  lw         $t0, 0x8($t1)
    /* 48B18 80058318 2000A6AF */  sw         $a2, 0x20($sp)
    /* 48B1C 8005831C 2400A7AF */  sw         $a3, 0x24($sp)
    /* 48B20 80058320 2800A8AF */  sw         $t0, 0x28($sp)
    /* 48B24 80058324 C406E48E */  lw         $a0, 0x6C4($s7)
    /* 48B28 80058328 FFCC010C */  jal        AIWorld_GetProfileMask__Fi
    /* 48B2C 8005832C FFFF8424 */   addiu     $a0, $a0, -0x1
    /* 48B30 80058330 1000A2AF */  sw         $v0, 0x10($sp)
    /* 48B34 80058334 C406E48E */  lw         $a0, 0x6C4($s7)
    /* 48B38 80058338 FFCC010C */  jal        AIWorld_GetProfileMask__Fi
    /* 48B3C 8005833C 00000000 */   nop
    /* 48B40 80058340 1400A2AF */  sw         $v0, 0x14($sp)
    /* 48B44 80058344 C406E48E */  lw         $a0, 0x6C4($s7)
    /* 48B48 80058348 FFCC010C */  jal        AIWorld_GetProfileMask__Fi
    /* 48B4C 8005834C 01008424 */   addiu     $a0, $a0, 0x1
    /* 48B50 80058350 1800A2AF */  sw         $v0, 0x18($sp)
    /* 48B54 80058354 5405E68E */  lw         $a2, 0x554($s7)
    /* 48B58 80058358 6405E38E */  lw         $v1, 0x564($s7)
    /* 48B5C 8005835C 0800F386 */  lh         $s3, 0x8($s7)
    /* 48B60 80058360 03006104 */  bgez       $v1, .L80058370
    /* 48B64 80058364 3000A6AF */   sw        $a2, 0x30($sp)
    /* 48B68 80058368 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 48B6C 8005836C 21186200 */  addu       $v1, $v1, $v0
  .L80058370:
    /* 48B70 80058370 03140300 */  sra        $v0, $v1, 16
    /* 48B74 80058374 02004104 */  bgez       $v0, .L80058380
    /* 48B78 80058378 00000000 */   nop
    /* 48B7C 8005837C 23100200 */  negu       $v0, $v0
  .L80058380:
    /* 48B80 80058380 AA2A033C */  lui        $v1, (0x2AAAAAAB >> 16)
    /* 48B84 80058384 ABAA6334 */  ori        $v1, $v1, (0x2AAAAAAB & 0xFFFF)
    /* 48B88 80058388 80140200 */  sll        $v0, $v0, 18
    /* 48B8C 8005838C 18004300 */  mult       $v0, $v1
    /* 48B90 80058390 C3170200 */  sra        $v0, $v0, 31
    /* 48B94 80058394 3000A68F */  lw         $a2, 0x30($sp)
    /* 48B98 80058398 10180000 */  mfhi       $v1
    /* 48B9C 8005839C 031C0300 */  sra        $v1, $v1, 16
    /* 48BA0 800583A0 23A06200 */  subu       $s4, $v1, $v0
    /* 48BA4 800583A4 18008602 */  mult       $s4, $a2
    /* 48BA8 800583A8 12100000 */  mflo       $v0
    /* 48BAC 800583AC 09004004 */  bltz       $v0, .L800583D4
    /* 48BB0 800583B0 21886202 */   addu      $s1, $s3, $v0
    /* 48BB4 800583B4 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 48BB8 800583B8 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 48BBC 800583BC 00000000 */  nop
    /* 48BC0 800583C0 2A102302 */  slt        $v0, $s1, $v1
    /* 48BC4 800583C4 0B004014 */  bnez       $v0, .L800583F4
    /* 48BC8 800583C8 01008226 */   addiu     $v0, $s4, 0x1
    /* 48BCC 800583CC FD600108 */  j          .L800583F4
    /* 48BD0 800583D0 23882302 */   subu      $s1, $s1, $v1
  .L800583D4:
    /* 48BD4 800583D4 05002106 */  bgez       $s1, .L800583EC
    /* 48BD8 800583D8 00000000 */   nop
    /* 48BDC 800583DC 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 48BE0 800583E0 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 48BE4 800583E4 00000000 */  nop
    /* 48BE8 800583E8 21882202 */  addu       $s1, $s1, $v0
  .L800583EC:
    /* 48BEC 800583EC 3000A68F */  lw         $a2, 0x30($sp)
    /* 48BF0 800583F0 01008226 */  addiu      $v0, $s4, 0x1
  .L800583F4:
    /* 48BF4 800583F4 18004600 */  mult       $v0, $a2
    /* 48BF8 800583F8 12100000 */  mflo       $v0
    /* 48BFC 800583FC 09004004 */  bltz       $v0, .L80058424
    /* 48C00 80058400 21806202 */   addu      $s0, $s3, $v0
    /* 48C04 80058404 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 48C08 80058408 C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 48C0C 8005840C 00000000 */  nop
    /* 48C10 80058410 2A100302 */  slt        $v0, $s0, $v1
    /* 48C14 80058414 0A004014 */  bnez       $v0, .L80058440
    /* 48C18 80058418 40111300 */   sll       $v0, $s3, 5
    /* 48C1C 8005841C 10610108 */  j          .L80058440
    /* 48C20 80058420 23800302 */   subu      $s0, $s0, $v1
  .L80058424:
    /* 48C24 80058424 06000106 */  bgez       $s0, .L80058440
    /* 48C28 80058428 40111300 */   sll       $v0, $s3, 5
    /* 48C2C 8005842C 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 48C30 80058430 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 48C34 80058434 00000000 */  nop
    /* 48C38 80058438 21800202 */  addu       $s0, $s0, $v0
    /* 48C3C 8005843C 40111300 */  sll        $v0, $s3, 5
  .L80058440:
    /* 48C40 80058440 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 48C44 80058444 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 48C48 80058448 1000A58F */  lw         $a1, 0x10($sp)
    /* 48C4C 8005844C 21104300 */  addu       $v0, $v0, $v1
    /* 48C50 80058450 16005284 */  lh         $s2, 0x16($v0)
    /* 48C54 80058454 0FCD010C */  jal        AIWorld_IsDriveableLane_UsingMask__Fii
    /* 48C58 80058458 21206002 */   addu      $a0, $s3, $zero
    /* 48C5C 8005845C 05004014 */  bnez       $v0, .L80058474
    /* 48C60 80058460 1180023C */   lui       $v0, %hi(CarLogic_gObs)
    /* 48C64 80058464 E4CC438C */  lw         $v1, %lo(CarLogic_gObs)($v0)
    /* 48C68 80058468 F6FF043C */  lui        $a0, (0xFFF60000 >> 16)
    /* 48C6C 8005846C 21186400 */  addu       $v1, $v1, $a0
    /* 48C70 80058470 E4CC43AC */  sw         $v1, %lo(CarLogic_gObs)($v0)
  .L80058474:
    /* 48C74 80058474 1400A58F */  lw         $a1, 0x14($sp)
    /* 48C78 80058478 0FCD010C */  jal        AIWorld_IsDriveableLane_UsingMask__Fii
    /* 48C7C 8005847C 21206002 */   addu      $a0, $s3, $zero
    /* 48C80 80058480 06004014 */  bnez       $v0, .L8005849C
    /* 48C84 80058484 1180023C */   lui       $v0, %hi(CarLogic_gObs)
    /* 48C88 80058488 E4CC4224 */  addiu      $v0, $v0, %lo(CarLogic_gObs)
    /* 48C8C 8005848C 0400438C */  lw         $v1, 0x4($v0)
    /* 48C90 80058490 F6FF043C */  lui        $a0, (0xFFF60000 >> 16)
    /* 48C94 80058494 21186400 */  addu       $v1, $v1, $a0
    /* 48C98 80058498 040043AC */  sw         $v1, 0x4($v0)
  .L8005849C:
    /* 48C9C 8005849C 1800A58F */  lw         $a1, 0x18($sp)
    /* 48CA0 800584A0 0FCD010C */  jal        AIWorld_IsDriveableLane_UsingMask__Fii
    /* 48CA4 800584A4 21206002 */   addu      $a0, $s3, $zero
    /* 48CA8 800584A8 06004014 */  bnez       $v0, .L800584C4
    /* 48CAC 800584AC 1180023C */   lui       $v0, %hi(CarLogic_gObs)
    /* 48CB0 800584B0 E4CC4224 */  addiu      $v0, $v0, %lo(CarLogic_gObs)
    /* 48CB4 800584B4 0800438C */  lw         $v1, 0x8($v0)
    /* 48CB8 800584B8 F6FF043C */  lui        $a0, (0xFFF60000 >> 16)
    /* 48CBC 800584BC 21186400 */  addu       $v1, $v1, $a0
    /* 48CC0 800584C0 080043AC */  sw         $v1, 0x8($v0)
  .L800584C4:
    /* 48CC4 800584C4 1480033C */  lui        $v1, %hi(BWorldSm_slices)
    /* 48CC8 800584C8 C0C7638C */  lw         $v1, %lo(BWorldSm_slices)($v1)
    /* 48CCC 800584CC 40111100 */  sll        $v0, $s1, 5
    /* 48CD0 800584D0 21104300 */  addu       $v0, $v0, $v1
    /* 48CD4 800584D4 16004284 */  lh         $v0, 0x16($v0)
    /* 48CD8 800584D8 00000000 */  nop
    /* 48CDC 800584DC 07004216 */  bne        $s2, $v0, .L800584FC
    /* 48CE0 800584E0 49000224 */   addiu     $v0, $zero, 0x49
    /* 48CE4 800584E4 40111000 */  sll        $v0, $s0, 5
    /* 48CE8 800584E8 21104300 */  addu       $v0, $v0, $v1
    /* 48CEC 800584EC 16004284 */  lh         $v0, 0x16($v0)
    /* 48CF0 800584F0 00000000 */  nop
    /* 48CF4 800584F4 02004212 */  beq        $s2, $v0, .L80058500
    /* 48CF8 800584F8 49000224 */   addiu     $v0, $zero, 0x49
  .L800584FC:
    /* 48CFC 800584FC C006E2AE */  sw         $v0, 0x6C0($s7)
  .L80058500:
    /* 48D00 80058500 C006E48E */  lw         $a0, 0x6C0($s7)
    /* 48D04 80058504 00000000 */  nop
    /* 48D08 80058508 56008018 */  blez       $a0, .L80058664
    /* 48D0C 8005850C 80101400 */   sll       $v0, $s4, 2
    /* 48D10 80058510 21105400 */  addu       $v0, $v0, $s4
    /* 48D14 80058514 C0100200 */  sll        $v0, $v0, 3
    /* 48D18 80058518 21105400 */  addu       $v0, $v0, $s4
    /* 48D1C 8005851C 00110200 */  sll        $v0, $v0, 4
    /* 48D20 80058520 23105400 */  subu       $v0, $v0, $s4
    /* 48D24 80058524 80100200 */  sll        $v0, $v0, 2
    /* 48D28 80058528 21185400 */  addu       $v1, $v0, $s4
    /* 48D2C 8005852C 04006104 */  bgez       $v1, .L80058540
    /* 48D30 80058530 03AC0300 */   sra       $s5, $v1, 16
    /* 48D34 80058534 FFFF0234 */  ori        $v0, $zero, 0xFFFF
    /* 48D38 80058538 21186200 */  addu       $v1, $v1, $v0
    /* 48D3C 8005853C 03AC0300 */  sra        $s5, $v1, 16
  .L80058540:
    /* 48D40 80058540 0200A016 */  bnez       $s5, .L8005854C
    /* 48D44 80058544 21880000 */   addu      $s1, $zero, $zero
    /* 48D48 80058548 01001524 */  addiu      $s5, $zero, 0x1
  .L8005854C:
    /* 48D4C 8005854C D8FF163C */  lui        $s6, (0xFFD80000 >> 16)
    /* 48D50 80058550 11801E3C */  lui        $fp, %hi(CarLogic_gObs)
    /* 48D54 80058554 0800828F */  lw         $v0, %gp_rel(AI_elapsedTime)($gp)
    /* 48D58 80058558 E4CCD227 */  addiu      $s2, $fp, %lo(CarLogic_gObs)
    /* 48D5C 8005855C 23108200 */  subu       $v0, $a0, $v0
    /* 48D60 80058560 C006E2AE */  sw         $v0, 0x6C0($s7)
  .L80058564:
    /* 48D64 80058564 2A103402 */  slt        $v0, $s1, $s4
    /* 48D68 80058568 3E004010 */  beqz       $v0, .L80058664
    /* 48D6C 8005856C 00000000 */   nop
    /* 48D70 80058570 3000A68F */  lw         $a2, 0x30($sp)
    /* 48D74 80058574 00000000 */  nop
    /* 48D78 80058578 18002602 */  mult       $s1, $a2
    /* 48D7C 8005857C 12100000 */  mflo       $v0
    /* 48D80 80058580 09004004 */  bltz       $v0, .L800585A8
    /* 48D84 80058584 21806202 */   addu      $s0, $s3, $v0
    /* 48D88 80058588 1480033C */  lui        $v1, %hi(gNumSlices)
    /* 48D8C 8005858C C8C7638C */  lw         $v1, %lo(gNumSlices)($v1)
    /* 48D90 80058590 00000000 */  nop
    /* 48D94 80058594 2A100302 */  slt        $v0, $s0, $v1
    /* 48D98 80058598 09004014 */  bnez       $v0, .L800585C0
    /* 48D9C 8005859C 00000000 */   nop
    /* 48DA0 800585A0 70610108 */  j          .L800585C0
    /* 48DA4 800585A4 23800302 */   subu      $s0, $s0, $v1
  .L800585A8:
    /* 48DA8 800585A8 05000106 */  bgez       $s0, .L800585C0
    /* 48DAC 800585AC 00000000 */   nop
    /* 48DB0 800585B0 1480023C */  lui        $v0, %hi(gNumSlices)
    /* 48DB4 800585B4 C8C7428C */  lw         $v0, %lo(gNumSlices)($v0)
    /* 48DB8 800585B8 00000000 */  nop
    /* 48DBC 800585BC 21800202 */  addu       $s0, $s0, $v0
  .L800585C0:
    /* 48DC0 800585C0 2000A28F */  lw         $v0, 0x20($sp)
    /* 48DC4 800585C4 00000000 */  nop
    /* 48DC8 800585C8 0A004010 */  beqz       $v0, .L800585F4
    /* 48DCC 800585CC 00000000 */   nop
    /* 48DD0 800585D0 1000A58F */  lw         $a1, 0x10($sp)
    /* 48DD4 800585D4 0FCD010C */  jal        AIWorld_IsDriveableLane_UsingMask__Fii
    /* 48DD8 800585D8 21200002 */   addu      $a0, $s0, $zero
    /* 48DDC 800585DC 05004014 */  bnez       $v0, .L800585F4
    /* 48DE0 800585E0 00000000 */   nop
    /* 48DE4 800585E4 E4CCC28F */  lw         $v0, %lo(CarLogic_gObs)($fp)
    /* 48DE8 800585E8 2000A0AF */  sw         $zero, 0x20($sp)
    /* 48DEC 800585EC 21105600 */  addu       $v0, $v0, $s6
    /* 48DF0 800585F0 E4CCC2AF */  sw         $v0, %lo(CarLogic_gObs)($fp)
  .L800585F4:
    /* 48DF4 800585F4 2400A28F */  lw         $v0, 0x24($sp)
    /* 48DF8 800585F8 00000000 */  nop
    /* 48DFC 800585FC 0A004010 */  beqz       $v0, .L80058628
    /* 48E00 80058600 00000000 */   nop
    /* 48E04 80058604 1400A58F */  lw         $a1, 0x14($sp)
    /* 48E08 80058608 0FCD010C */  jal        AIWorld_IsDriveableLane_UsingMask__Fii
    /* 48E0C 8005860C 21200002 */   addu      $a0, $s0, $zero
    /* 48E10 80058610 05004014 */  bnez       $v0, .L80058628
    /* 48E14 80058614 00000000 */   nop
    /* 48E18 80058618 0400428E */  lw         $v0, 0x4($s2)
    /* 48E1C 8005861C 2400A0AF */  sw         $zero, 0x24($sp)
    /* 48E20 80058620 21105600 */  addu       $v0, $v0, $s6
    /* 48E24 80058624 040042AE */  sw         $v0, 0x4($s2)
  .L80058628:
    /* 48E28 80058628 2800A28F */  lw         $v0, 0x28($sp)
    /* 48E2C 8005862C 00000000 */  nop
    /* 48E30 80058630 0A004010 */  beqz       $v0, .L8005865C
    /* 48E34 80058634 00000000 */   nop
    /* 48E38 80058638 1800A58F */  lw         $a1, 0x18($sp)
    /* 48E3C 8005863C 0FCD010C */  jal        AIWorld_IsDriveableLane_UsingMask__Fii
    /* 48E40 80058640 21200002 */   addu      $a0, $s0, $zero
    /* 48E44 80058644 05004014 */  bnez       $v0, .L8005865C
    /* 48E48 80058648 00000000 */   nop
    /* 48E4C 8005864C 0800428E */  lw         $v0, 0x8($s2)
    /* 48E50 80058650 2800A0AF */  sw         $zero, 0x28($sp)
    /* 48E54 80058654 21105600 */  addu       $v0, $v0, $s6
    /* 48E58 80058658 080042AE */  sw         $v0, 0x8($s2)
  .L8005865C:
    /* 48E5C 8005865C 59610108 */  j          .L80058564
    /* 48E60 80058660 21883502 */   addu      $s1, $s1, $s5
  .L80058664:
    /* 48E64 80058664 5C00BF8F */  lw         $ra, 0x5C($sp)
    /* 48E68 80058668 5800BE8F */  lw         $fp, 0x58($sp)
    /* 48E6C 8005866C 5400B78F */  lw         $s7, 0x54($sp)
    /* 48E70 80058670 5000B68F */  lw         $s6, 0x50($sp)
    /* 48E74 80058674 4C00B58F */  lw         $s5, 0x4C($sp)
    /* 48E78 80058678 4800B48F */  lw         $s4, 0x48($sp)
    /* 48E7C 8005867C 4400B38F */  lw         $s3, 0x44($sp)
    /* 48E80 80058680 4000B28F */  lw         $s2, 0x40($sp)
    /* 48E84 80058684 3C00B18F */  lw         $s1, 0x3C($sp)
    /* 48E88 80058688 3800B08F */  lw         $s0, 0x38($sp)
    /* 48E8C 8005868C 0800E003 */  jr         $ra
    /* 48E90 80058690 6000BD27 */   addiu     $sp, $sp, 0x60
endlabel AI_CheckForBarriers__FP8Car_tObj
