.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_CalculateRampedDesiredLatPos__FP8Car_tObj9eRampType, 0x108

glabel AIPhysic_CalculateRampedDesiredLatPos__FP8Car_tObj9eRampType
    /* 5CF68 8006C768 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 5CF6C 8006C76C 1000B0AF */  sw         $s0, 0x10($sp)
    /* 5CF70 8006C770 21808000 */  addu       $s0, $a0, $zero
    /* 5CF74 8006C774 01000224 */  addiu      $v0, $zero, 0x1
    /* 5CF78 8006C778 0400A214 */  bne        $a1, $v0, .L8006C78C
    /* 5CF7C 8006C77C 1400BFAF */   sw        $ra, 0x14($sp)
    /* 5CF80 8006C780 5805028E */  lw         $v0, 0x558($s0)
    /* 5CF84 8006C784 18B20108 */  j          .L8006C860
    /* 5CF88 8006C788 180702AE */   sw        $v0, 0x718($s0)
  .L8006C78C:
    /* 5CF8C 8006C78C 96CD010C */  jal        AIWorld_CalculateDeltaRoadYaw__FP8Car_tObj
    /* 5CF90 8006C790 21200002 */   addu      $a0, $s0, $zero
    /* 5CF94 8006C794 5000838F */  lw         $v1, %gp_rel(AIPhysic_elapsedTime)($gp)
    /* 5CF98 8006C798 7405058E */  lw         $a1, 0x574($s0)
    /* 5CF9C 8006C79C 40100300 */  sll        $v0, $v1, 1
    /* 5CFA0 8006C7A0 21104300 */  addu       $v0, $v0, $v1
    /* 5CFA4 8006C7A4 00190200 */  sll        $v1, $v0, 4
    /* 5CFA8 8006C7A8 21104300 */  addu       $v0, $v0, $v1
    /* 5CFAC 8006C7AC 00220200 */  sll        $a0, $v0, 8
    /* 5CFB0 8006C7B0 5805038E */  lw         $v1, 0x558($s0)
    /* 5CFB4 8006C7B4 00000000 */  nop
    /* 5CFB8 8006C7B8 2A186500 */  slt        $v1, $v1, $a1
    /* 5CFBC 8006C7BC 09006010 */  beqz       $v1, .L8006C7E4
    /* 5CFC0 8006C7C0 21304400 */   addu      $a2, $v0, $a0
    /* 5CFC4 8006C7C4 1807028E */  lw         $v0, 0x718($s0)
    /* 5CFC8 8006C7C8 FFFF033C */  lui        $v1, (0xFFFF0000 >> 16)
    /* 5CFCC 8006C7CC 21104300 */  addu       $v0, $v0, $v1
    /* 5CFD0 8006C7D0 2A10A200 */  slt        $v0, $a1, $v0
    /* 5CFD4 8006C7D4 04004010 */  beqz       $v0, .L8006C7E8
    /* 5CFD8 8006C7D8 0100033C */   lui       $v1, (0x10000 >> 16)
    /* 5CFDC 8006C7DC 06B20108 */  j          .L8006C818
    /* 5CFE0 8006C7E0 180705AE */   sw        $a1, 0x718($s0)
  .L8006C7E4:
    /* 5CFE4 8006C7E4 0100033C */  lui        $v1, (0x10000 >> 16)
  .L8006C7E8:
    /* 5CFE8 8006C7E8 1807028E */  lw         $v0, 0x718($s0)
    /* 5CFEC 8006C7EC 7405048E */  lw         $a0, 0x574($s0)
    /* 5CFF0 8006C7F0 21104300 */  addu       $v0, $v0, $v1
    /* 5CFF4 8006C7F4 2A104400 */  slt        $v0, $v0, $a0
    /* 5CFF8 8006C7F8 07004010 */  beqz       $v0, .L8006C818
    /* 5CFFC 8006C7FC 00000000 */   nop
    /* 5D000 8006C800 5805028E */  lw         $v0, 0x558($s0)
    /* 5D004 8006C804 00000000 */  nop
    /* 5D008 8006C808 2A108200 */  slt        $v0, $a0, $v0
    /* 5D00C 8006C80C 02004010 */  beqz       $v0, .L8006C818
    /* 5D010 8006C810 00000000 */   nop
    /* 5D014 8006C814 180704AE */  sw         $a0, 0x718($s0)
  .L8006C818:
    /* 5D018 8006C818 1807038E */  lw         $v1, 0x718($s0)
    /* 5D01C 8006C81C 5805048E */  lw         $a0, 0x558($s0)
    /* 5D020 8006C820 00000000 */  nop
    /* 5D024 8006C824 2A106400 */  slt        $v0, $v1, $a0
    /* 5D028 8006C828 04004010 */  beqz       $v0, .L8006C83C
    /* 5D02C 8006C82C 21106600 */   addu      $v0, $v1, $a2
    /* 5D030 8006C830 180702AE */  sw         $v0, 0x718($s0)
    /* 5D034 8006C834 15B20108 */  j          .L8006C854
    /* 5D038 8006C838 2A108200 */   slt       $v0, $a0, $v0
  .L8006C83C:
    /* 5D03C 8006C83C 2A108300 */  slt        $v0, $a0, $v1
    /* 5D040 8006C840 07004010 */  beqz       $v0, .L8006C860
    /* 5D044 8006C844 23106600 */   subu      $v0, $v1, $a2
    /* 5D048 8006C848 5805048E */  lw         $a0, 0x558($s0)
    /* 5D04C 8006C84C 180702AE */  sw         $v0, 0x718($s0)
    /* 5D050 8006C850 2A104400 */  slt        $v0, $v0, $a0
  .L8006C854:
    /* 5D054 8006C854 02004010 */  beqz       $v0, .L8006C860
    /* 5D058 8006C858 00000000 */   nop
    /* 5D05C 8006C85C 180704AE */  sw         $a0, 0x718($s0)
  .L8006C860:
    /* 5D060 8006C860 1400BF8F */  lw         $ra, 0x14($sp)
    /* 5D064 8006C864 1000B08F */  lw         $s0, 0x10($sp)
    /* 5D068 8006C868 0800E003 */  jr         $ra
    /* 5D06C 8006C86C 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIPhysic_CalculateRampedDesiredLatPos__FP8Car_tObj9eRampType
