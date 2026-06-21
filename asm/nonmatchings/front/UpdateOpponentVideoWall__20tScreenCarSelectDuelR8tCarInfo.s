.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching UpdateOpponentVideoWall__20tScreenCarSelectDuelR8tCarInfo, 0x84

glabel UpdateOpponentVideoWall__20tScreenCarSelectDuelR8tCarInfo
    /* 2DF6C 8003D76C C0FFBD27 */  addiu      $sp, $sp, -0x40
    /* 2DF70 8003D770 3000B0AF */  sw         $s0, 0x30($sp)
    /* 2DF74 8003D774 21808000 */  addu       $s0, $a0, $zero
    /* 2DF78 8003D778 3400B1AF */  sw         $s1, 0x34($sp)
    /* 2DF7C 8003D77C 2188A000 */  addu       $s1, $a1, $zero
    /* 2DF80 8003D780 3800BFAF */  sw         $ra, 0x38($sp)
    /* 2DF84 8003D784 C8002392 */  lbu        $v1, 0xC8($s1)
    /* 2DF88 8003D788 A0030286 */  lh         $v0, 0x3A0($s0)
    /* 2DF8C 8003D78C 00000000 */  nop
    /* 2DF90 8003D790 12006210 */  beq        $v1, $v0, .L8003D7DC
    /* 2DF94 8003D794 0180053C */   lui       $a1, %hi(D_80011B24)
    /* 2DF98 8003D798 1000A427 */  addiu      $a0, $sp, 0x10
    /* 2DF9C 8003D79C 241BA524 */  addiu      $a1, $a1, %lo(D_80011B24)
    /* 2DFA0 8003D7A0 2F91030C */  jal        sprintf
    /* 2DFA4 8003D7A4 10002626 */   addiu     $a2, $s1, 0x10
    /* 2DFA8 8003D7A8 21200002 */  addu       $a0, $s0, $zero
    /* 2DFAC 8003D7AC 1000A527 */  addiu      $a1, $sp, 0x10
    /* 2DFB0 8003D7B0 9098000C */  jal        AsyncLoadShapeFile__7tScreenPcR17tShapeInformation
    /* 2DFB4 8003D7B4 A8030626 */   addiu     $a2, $s0, 0x3A8
    /* 2DFB8 8003D7B8 21200002 */  addu       $a0, $s0, $zero
    /* 2DFBC 8003D7BC 21280000 */  addu       $a1, $zero, $zero
    /* 2DFC0 8003D7C0 A40300AE */  sw         $zero, 0x3A4($s0)
    /* 2DFC4 8003D7C4 C8002292 */  lbu        $v0, 0xC8($s1)
    /* 2DFC8 8003D7C8 01000624 */  addiu      $a2, $zero, 0x1
    /* 2DFCC 8003D7CC 29F1000C */  jal        SetBrightness__16tScreenCarSelectss
    /* 2DFD0 8003D7D0 A00302A6 */   sh        $v0, 0x3A0($s0)
    /* 2DFD4 8003D7D4 96DB000C */  jal        TurnOff__10tVideoWall
    /* 2DFD8 8003D7D8 3C030426 */   addiu     $a0, $s0, 0x33C
  .L8003D7DC:
    /* 2DFDC 8003D7DC 3800BF8F */  lw         $ra, 0x38($sp)
    /* 2DFE0 8003D7E0 3400B18F */  lw         $s1, 0x34($sp)
    /* 2DFE4 8003D7E4 3000B08F */  lw         $s0, 0x30($sp)
    /* 2DFE8 8003D7E8 0800E003 */  jr         $ra
    /* 2DFEC 8003D7EC 4000BD27 */   addiu     $sp, $sp, 0x40
endlabel UpdateOpponentVideoWall__20tScreenCarSelectDuelR8tCarInfo
