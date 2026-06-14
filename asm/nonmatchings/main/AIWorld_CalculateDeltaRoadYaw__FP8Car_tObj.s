.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIWorld_CalculateDeltaRoadYaw__FP8Car_tObj, 0x88

glabel AIWorld_CalculateDeltaRoadYaw__FP8Car_tObj
    /* 63E58 80073658 E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 63E5C 8007365C 21188000 */  addu       $v1, $a0, $zero
    /* 63E60 80073660 1400BFAF */  sw         $ra, 0x14($sp)
    /* 63E64 80073664 1000B0AF */  sw         $s0, 0x10($sp)
    /* 63E68 80073668 6002628C */  lw         $v0, 0x260($v1)
    /* 63E6C 8007366C 00000000 */  nop
    /* 63E70 80073670 08004230 */  andi       $v0, $v0, 0x8
    /* 63E74 80073674 15004010 */  beqz       $v0, .L800736CC
    /* 63E78 80073678 21200000 */   addu      $a0, $zero, $zero
    /* 63E7C 8007367C 08006684 */  lh         $a2, 0x8($v1)
    /* 63E80 80073680 1480053C */  lui        $a1, %hi(gNumSlices)
    /* 63E84 80073684 C8C7A58C */  lw         $a1, %lo(gNumSlices)($a1)
    /* 63E88 80073688 7801708C */  lw         $s0, 0x178($v1)
    /* 63E8C 8007368C 0100C424 */  addiu      $a0, $a2, 0x1
    /* 63E90 80073690 2A108500 */  slt        $v0, $a0, $a1
    /* 63E94 80073694 02004014 */  bnez       $v0, .L800736A0
    /* 63E98 80073698 FFFFA224 */   addiu     $v0, $a1, -0x1
    /* 63E9C 8007369C 2320C200 */  subu       $a0, $a2, $v0
  .L800736A0:
    /* 63EA0 800736A0 CC7D020C */  jal        Newton_CalculateSliceYaw__Fi
    /* 63EA4 800736A4 00000000 */   nop
    /* 63EA8 800736A8 23205000 */  subu       $a0, $v0, $s0
    /* 63EAC 800736AC 01028228 */  slti       $v0, $a0, 0x201
    /* 63EB0 800736B0 03004014 */  bnez       $v0, .L800736C0
    /* 63EB4 800736B4 00FE8228 */   slti      $v0, $a0, -0x200
    /* 63EB8 800736B8 00FC8424 */  addiu      $a0, $a0, -0x400
    /* 63EBC 800736BC 00FE8228 */  slti       $v0, $a0, -0x200
  .L800736C0:
    /* 63EC0 800736C0 02004010 */  beqz       $v0, .L800736CC
    /* 63EC4 800736C4 00000000 */   nop
    /* 63EC8 800736C8 00048424 */  addiu      $a0, $a0, 0x400
  .L800736CC:
    /* 63ECC 800736CC 1400BF8F */  lw         $ra, 0x14($sp)
    /* 63ED0 800736D0 1000B08F */  lw         $s0, 0x10($sp)
    /* 63ED4 800736D4 21108000 */  addu       $v0, $a0, $zero
    /* 63ED8 800736D8 0800E003 */  jr         $ra
    /* 63EDC 800736DC 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel AIWorld_CalculateDeltaRoadYaw__FP8Car_tObj
