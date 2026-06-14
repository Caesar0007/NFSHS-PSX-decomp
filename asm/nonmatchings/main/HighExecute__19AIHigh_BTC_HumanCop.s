.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching HighExecute__19AIHigh_BTC_HumanCop, 0x1D8

glabel HighExecute__19AIHigh_BTC_HumanCop
    /* 4E8AC 8005E0AC D0FFBD27 */  addiu      $sp, $sp, -0x30
    /* 4E8B0 8005E0B0 2000B0AF */  sw         $s0, 0x20($sp)
    /* 4E8B4 8005E0B4 21808000 */  addu       $s0, $a0, $zero
    /* 4E8B8 8005E0B8 2800BFAF */  sw         $ra, 0x28($sp)
    /* 4E8BC 8005E0BC 2400B1AF */  sw         $s1, 0x24($sp)
    /* 4E8C0 8005E0C0 1C00028E */  lw         $v0, 0x1C($s0)
    /* 4E8C4 8005E0C4 00000000 */  nop
    /* 4E8C8 8005E0C8 07004014 */  bnez       $v0, .L8005E0E8
    /* 4E8CC 8005E0CC 01000224 */   addiu     $v0, $zero, 0x1
    /* 4E8D0 8005E0D0 6000038E */  lw         $v1, 0x60($s0)
    /* 4E8D4 8005E0D4 00000000 */  nop
    /* 4E8D8 8005E0D8 03006214 */  bne        $v1, $v0, .L8005E0E8
    /* 4E8DC 8005E0DC 00000000 */   nop
    /* 4E8E0 8005E0E0 E877010C */  jal        ClearTrafficToPurgatory__19AIHigh_BTC_HumanCop
    /* 4E8E4 8005E0E4 00000000 */   nop
  .L8005E0E8:
    /* 4E8E8 8005E0E8 5800048E */  lw         $a0, 0x58($s0)
    /* 4E8EC 8005E0EC 00000000 */  nop
    /* 4E8F0 8005E0F0 0A008010 */  beqz       $a0, .L8005E11C
    /* 4E8F4 8005E0F4 01000224 */   addiu     $v0, $zero, 0x1
    /* 4E8F8 8005E0F8 6000038E */  lw         $v1, 0x60($s0)
    /* 4E8FC 8005E0FC 00000000 */  nop
    /* 4E900 8005E100 06006210 */  beq        $v1, $v0, .L8005E11C
    /* 4E904 8005E104 00000000 */   nop
    /* 4E908 8005E108 0000828C */  lw         $v0, 0x0($a0)
    /* 4E90C 8005E10C 0000038E */  lw         $v1, 0x0($s0)
    /* 4E910 8005E110 5405428C */  lw         $v0, 0x554($v0)
    /* 4E914 8005E114 00000000 */  nop
    /* 4E918 8005E118 500562AC */  sw         $v0, 0x550($v1)
  .L8005E11C:
    /* 4E91C 8005E11C 1378010C */  jal        SetDesiredSpeed__19AIHigh_BTC_HumanCop
    /* 4E920 8005E120 21200002 */   addu      $a0, $s0, $zero
    /* 4E924 8005E124 5975010C */  jal        CheckConditionWithCop0__19AIHigh_BTC_HumanCop
    /* 4E928 8005E128 21200002 */   addu      $a0, $s0, $zero
    /* 4E92C 8005E12C B576010C */  jal        UpdateFreezeModeAndPullOverMode__19AIHigh_BTC_HumanCop
    /* 4E930 8005E130 21200002 */   addu      $a0, $s0, $zero
    /* 4E934 8005E134 7076010C */  jal        UpdateAndCheckTimeLeft__19AIHigh_BTC_HumanCop
    /* 4E938 8005E138 21200002 */   addu      $a0, $s0, $zero
    /* 4E93C 8005E13C 2E73010C */  jal        CheckForNewTarget__14AIHigh_BTC_Cop
    /* 4E940 8005E140 21200002 */   addu      $a0, $s0, $zero
    /* 4E944 8005E144 5800028E */  lw         $v0, 0x58($s0)
    /* 4E948 8005E148 00000000 */  nop
    /* 4E94C 8005E14C 03004010 */  beqz       $v0, .L8005E15C
    /* 4E950 8005E150 21200002 */   addu      $a0, $s0, $zero
    /* 4E954 8005E154 0773010C */  jal        GetCheckChasePosition__14AIHigh_BTC_CopP8coorddef
    /* 4E958 8005E158 1000A527 */   addiu     $a1, $sp, 0x10
  .L8005E15C:
    /* 4E95C 8005E15C 1480033C */  lui        $v1, %hi(AIHigh_CopGameType)
    /* 4E960 8005E160 5CC5638C */  lw         $v1, %lo(AIHigh_CopGameType)($v1)
    /* 4E964 8005E164 02000224 */  addiu      $v0, $zero, 0x2
    /* 4E968 8005E168 3E006214 */  bne        $v1, $v0, .L8005E264
    /* 4E96C 8005E16C 1280023C */   lui       $v0, %hi(simGlobal)
    /* 4E970 8005E170 ACE05124 */  addiu      $s1, $v0, %lo(simGlobal)
    /* 4E974 8005E174 0400228E */  lw         $v0, 0x4($s1)
    /* 4E978 8005E178 1400838F */  lw         $v1, %gp_rel(_19AIHigh_BTC_HumanCop_lastInputRequestTick_)($gp)
    /* 4E97C 8005E17C 00000000 */  nop
    /* 4E980 8005E180 23104300 */  subu       $v0, $v0, $v1
    /* 4E984 8005E184 81024228 */  slti       $v0, $v0, 0x281
    /* 4E988 8005E188 2D004014 */  bnez       $v0, .L8005E240
    /* 4E98C 8005E18C 00000000 */   nop
    /* 4E990 8005E190 0000028E */  lw         $v0, 0x0($s0)
    /* 4E994 8005E194 00000000 */  nop
    /* 4E998 8005E198 4B044390 */  lbu        $v1, 0x44B($v0)
    /* 4E99C 8005E19C 04000224 */  addiu      $v0, $zero, 0x4
    /* 4E9A0 8005E1A0 09006214 */  bne        $v1, $v0, .L8005E1C8
    /* 4E9A4 8005E1A4 00000000 */   nop
    /* 4E9A8 8005E1A8 FE76010C */  jal        RequestWingman__19AIHigh_BTC_HumanCop
    /* 4E9AC 8005E1AC 21200002 */   addu      $a0, $s0, $zero
    /* 4E9B0 8005E1B0 0000028E */  lw         $v0, 0x0($s0)
    /* 4E9B4 8005E1B4 00000000 */  nop
    /* 4E9B8 8005E1B8 4B0440A0 */  sb         $zero, 0x44B($v0)
    /* 4E9BC 8005E1BC 0400228E */  lw         $v0, 0x4($s1)
    /* 4E9C0 8005E1C0 00000000 */  nop
    /* 4E9C4 8005E1C4 140082AF */  sw         $v0, %gp_rel(_19AIHigh_BTC_HumanCop_lastInputRequestTick_)($gp)
  .L8005E1C8:
    /* 4E9C8 8005E1C8 0000028E */  lw         $v0, 0x0($s0)
    /* 4E9CC 8005E1CC 00000000 */  nop
    /* 4E9D0 8005E1D0 4B044390 */  lbu        $v1, 0x44B($v0)
    /* 4E9D4 8005E1D4 05000224 */  addiu      $v0, $zero, 0x5
    /* 4E9D8 8005E1D8 09006214 */  bne        $v1, $v0, .L8005E200
    /* 4E9DC 8005E1DC 21200002 */   addu      $a0, $s0, $zero
    /* 4E9E0 8005E1E0 4577010C */  jal        RequestBlockader__19AIHigh_BTC_HumanCopi
    /* 4E9E4 8005E1E4 21280000 */   addu      $a1, $zero, $zero
    /* 4E9E8 8005E1E8 0000028E */  lw         $v0, 0x0($s0)
    /* 4E9EC 8005E1EC 00000000 */  nop
    /* 4E9F0 8005E1F0 4B0440A0 */  sb         $zero, 0x44B($v0)
    /* 4E9F4 8005E1F4 0400228E */  lw         $v0, 0x4($s1)
    /* 4E9F8 8005E1F8 00000000 */  nop
    /* 4E9FC 8005E1FC 140082AF */  sw         $v0, %gp_rel(_19AIHigh_BTC_HumanCop_lastInputRequestTick_)($gp)
  .L8005E200:
    /* 4EA00 8005E200 0000028E */  lw         $v0, 0x0($s0)
    /* 4EA04 8005E204 00000000 */  nop
    /* 4EA08 8005E208 4B044390 */  lbu        $v1, 0x44B($v0)
    /* 4EA0C 8005E20C 06000224 */  addiu      $v0, $zero, 0x6
    /* 4EA10 8005E210 14006214 */  bne        $v1, $v0, .L8005E264
    /* 4EA14 8005E214 21200002 */   addu      $a0, $s0, $zero
    /* 4EA18 8005E218 4577010C */  jal        RequestBlockader__19AIHigh_BTC_HumanCopi
    /* 4EA1C 8005E21C 01000524 */   addiu     $a1, $zero, 0x1
    /* 4EA20 8005E220 0000028E */  lw         $v0, 0x0($s0)
    /* 4EA24 8005E224 00000000 */  nop
    /* 4EA28 8005E228 4B0440A0 */  sb         $zero, 0x44B($v0)
    /* 4EA2C 8005E22C 0400228E */  lw         $v0, 0x4($s1)
    /* 4EA30 8005E230 00000000 */  nop
    /* 4EA34 8005E234 140082AF */  sw         $v0, %gp_rel(_19AIHigh_BTC_HumanCop_lastInputRequestTick_)($gp)
    /* 4EA38 8005E238 99780108 */  j          .L8005E264
    /* 4EA3C 8005E23C 00000000 */   nop
  .L8005E240:
    /* 4EA40 8005E240 0000038E */  lw         $v1, 0x0($s0)
    /* 4EA44 8005E244 00000000 */  nop
    /* 4EA48 8005E248 4B046290 */  lbu        $v0, 0x44B($v1)
    /* 4EA4C 8005E24C 00000000 */  nop
    /* 4EA50 8005E250 FCFF4224 */  addiu      $v0, $v0, -0x4
    /* 4EA54 8005E254 0300422C */  sltiu      $v0, $v0, 0x3
    /* 4EA58 8005E258 02004010 */  beqz       $v0, .L8005E264
    /* 4EA5C 8005E25C 00000000 */   nop
    /* 4EA60 8005E260 4B0460A0 */  sb         $zero, 0x44B($v1)
  .L8005E264:
    /* 4EA64 8005E264 0400048E */  lw         $a0, 0x4($s0)
    /* 4EA68 8005E268 7BBE010C */  jal        StateExecute__12AIState_Base
    /* 4EA6C 8005E26C 00000000 */   nop
    /* 4EA70 8005E270 2800BF8F */  lw         $ra, 0x28($sp)
    /* 4EA74 8005E274 2400B18F */  lw         $s1, 0x24($sp)
    /* 4EA78 8005E278 2000B08F */  lw         $s0, 0x20($sp)
    /* 4EA7C 8005E27C 0800E003 */  jr         $ra
    /* 4EA80 8005E280 3000BD27 */   addiu     $sp, $sp, 0x30
endlabel HighExecute__19AIHigh_BTC_HumanCop
