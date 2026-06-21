.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching Initialize__18tTournamentManager, 0xD4

glabel Initialize__18tTournamentManager
    /* 22A28 80032228 21280000 */  addu       $a1, $zero, $zero
    /* 22A2C 8003222C 204E0224 */  addiu      $v0, $zero, 0x4E20
    /* 22A30 80032230 140082AC */  sw         $v0, 0x14($a0)
    /* 22A34 80032234 0C0080AC */  sw         $zero, 0xC($a0)
    /* 22A38 80032238 000080A0 */  sb         $zero, 0x0($a0)
    /* 22A3C 8003223C 180080AC */  sw         $zero, 0x18($a0)
    /* 22A40 80032240 340080A4 */  sh         $zero, 0x34($a0)
    /* 22A44 80032244 B60080A4 */  sh         $zero, 0xB6($a0)
    /* 22A48 80032248 00140500 */  sll        $v0, $a1, 16
  .L8003224C:
    /* 22A4C 8003224C 03140200 */  sra        $v0, $v0, 16
    /* 22A50 80032250 21108200 */  addu       $v0, $a0, $v0
    /* 22A54 80032254 370240A0 */  sb         $zero, 0x237($v0)
    /* 22A58 80032258 0100A224 */  addiu      $v0, $a1, 0x1
    /* 22A5C 8003225C 21284000 */  addu       $a1, $v0, $zero
    /* 22A60 80032260 00140200 */  sll        $v0, $v0, 16
    /* 22A64 80032264 03140200 */  sra        $v0, $v0, 16
    /* 22A68 80032268 06004228 */  slti       $v0, $v0, 0x6
    /* 22A6C 8003226C F7FF4014 */  bnez       $v0, .L8003224C
    /* 22A70 80032270 00140500 */   sll       $v0, $a1, 16
    /* 22A74 80032274 21280000 */  addu       $a1, $zero, $zero
    /* 22A78 80032278 07000324 */  addiu      $v1, $zero, 0x7
    /* 22A7C 8003227C 00140500 */  sll        $v0, $a1, 16
  .L80032280:
    /* 22A80 80032280 03140200 */  sra        $v0, $v0, 16
    /* 22A84 80032284 21108200 */  addu       $v0, $a0, $v0
    /* 22A88 80032288 F00143A0 */  sb         $v1, 0x1F0($v0)
    /* 22A8C 8003228C 0100A224 */  addiu      $v0, $a1, 0x1
    /* 22A90 80032290 21284000 */  addu       $a1, $v0, $zero
    /* 22A94 80032294 00140200 */  sll        $v0, $v0, 16
    /* 22A98 80032298 03140200 */  sra        $v0, $v0, 16
    /* 22A9C 8003229C 40004228 */  slti       $v0, $v0, 0x40
    /* 22AA0 800322A0 F7FF4014 */  bnez       $v0, .L80032280
    /* 22AA4 800322A4 00140500 */   sll       $v0, $a1, 16
    /* 22AA8 800322A8 21280000 */  addu       $a1, $zero, $zero
    /* 22AAC 800322AC 06000624 */  addiu      $a2, $zero, 0x6
  .L800322B0:
    /* 22AB0 800322B0 001C0500 */  sll        $v1, $a1, 16
    /* 22AB4 800322B4 0100A224 */  addiu      $v0, $a1, 0x1
    /* 22AB8 800322B8 21284000 */  addu       $a1, $v0, $zero
    /* 22ABC 800322BC C31B0300 */  sra        $v1, $v1, 15
    /* 22AC0 800322C0 21188300 */  addu       $v1, $a0, $v1
    /* 22AC4 800322C4 00140200 */  sll        $v0, $v0, 16
    /* 22AC8 800322C8 03140200 */  sra        $v0, $v0, 16
    /* 22ACC 800322CC 03004228 */  slti       $v0, $v0, 0x3
    /* 22AD0 800322D0 240066A4 */  sh         $a2, 0x24($v1)
    /* 22AD4 800322D4 F6FF4014 */  bnez       $v0, .L800322B0
    /* 22AD8 800322D8 2C0060A4 */   sh        $zero, 0x2C($v1)
    /* 22ADC 800322DC 1180023C */  lui        $v0, %hi(carManager)
    /* 22AE0 800322E0 1180033C */  lui        $v1, %hi(frontEnd)
    /* 22AE4 800322E4 7442428C */  lw         $v0, %lo(carManager)($v0)
    /* 22AE8 800322E8 00466324 */  addiu      $v1, $v1, %lo(frontEnd)
    /* 22AEC 800322EC FFFF4224 */  addiu      $v0, $v0, -0x1
    /* 22AF0 800322F0 230162A0 */  sb         $v0, 0x123($v1)
    /* 22AF4 800322F4 0800E003 */  jr         $ra
    /* 22AF8 800322F8 240162A0 */   sb        $v0, 0x124($v1)
endlabel Initialize__18tTournamentManager
