.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching StateExecute__12AIState_Base, 0x88

glabel StateExecute__12AIState_Base
    /* 601EC 8006F9EC E8FFBD27 */  addiu      $sp, $sp, -0x18
    /* 601F0 8006F9F0 1000B0AF */  sw         $s0, 0x10($sp)
    /* 601F4 8006F9F4 21808000 */  addu       $s0, $a0, $zero
    /* 601F8 8006F9F8 1400BFAF */  sw         $ra, 0x14($sp)
    /* 601FC 8006F9FC 0000048E */  lw         $a0, 0x0($s0)
    /* 60200 8006FA00 00000000 */  nop
    /* 60204 8006FA04 91008290 */  lbu        $v0, 0x91($a0)
    /* 60208 8006FA08 00000000 */  nop
    /* 6020C 8006FA0C 0E004010 */  beqz       $v0, .L8006FA48
    /* 60210 8006FA10 00000000 */   nop
    /* 60214 8006FA14 6002828C */  lw         $v0, 0x260($a0)
    /* 60218 8006FA18 00000000 */  nop
    /* 6021C 8006FA1C 04004230 */  andi       $v0, $v0, 0x4
    /* 60220 8006FA20 09004014 */  bnez       $v0, .L8006FA48
    /* 60224 8006FA24 00000000 */   nop
    /* 60228 8006FA28 7E018294 */  lhu        $v0, 0x17E($a0)
    /* 6022C 8006FA2C 00000000 */  nop
    /* 60230 8006FA30 05004014 */  bnez       $v0, .L8006FA48
    /* 60234 8006FA34 00000000 */   nop
    /* 60238 8006FA38 1480053C */  lui        $a1, %hi(AI_elapsedTime)
    /* 6023C 8006FA3C 54C5A58C */  lw         $a1, %lo(AI_elapsedTime)($a1)
    /* 60240 8006FA40 FCBD010C */  jal        AIScript_ProcessActionsAndReactions__FP10AIScript_ti
    /* 60244 8006FA44 F4048424 */   addiu     $a0, $a0, 0x4F4
  .L8006FA48:
    /* 60248 8006FA48 0400028E */  lw         $v0, 0x4($s0)
    /* 6024C 8006FA4C 00000000 */  nop
    /* 60250 8006FA50 08004484 */  lh         $a0, 0x8($v0)
    /* 60254 8006FA54 0C00428C */  lw         $v0, 0xC($v0)
    /* 60258 8006FA58 00000000 */  nop
    /* 6025C 8006FA5C 09F84000 */  jalr       $v0
    /* 60260 8006FA60 21200402 */   addu      $a0, $s0, $a0
    /* 60264 8006FA64 1400BF8F */  lw         $ra, 0x14($sp)
    /* 60268 8006FA68 1000B08F */  lw         $s0, 0x10($sp)
    /* 6026C 8006FA6C 0800E003 */  jr         $ra
    /* 60270 8006FA70 1800BD27 */   addiu     $sp, $sp, 0x18
endlabel StateExecute__12AIState_Base
