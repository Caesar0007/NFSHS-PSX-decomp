.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_TurnHeadLightOff__FP8Car_tObji, 0x54

glabel R3DCar_TurnHeadLightOff__FP8Car_tObji
    /* A0354 800AFB54 B6088294 */  lhu        $v0, 0x8B6($a0)
    /* A0358 800AFB58 00000000 */  nop
    /* A035C 800AFB5C FD004230 */  andi       $v0, $v0, 0xFD
    /* A0360 800AFB60 0F00A010 */  beqz       $a1, .L800AFBA0
    /* A0364 800AFB64 B60882A4 */   sh        $v0, 0x8B6($a0)
    /* A0368 800AFB68 B4088394 */  lhu        $v1, 0x8B4($a0)
    /* A036C 800AFB6C 00000000 */  nop
    /* A0370 800AFB70 EE006230 */  andi       $v0, $v1, 0xEE
    /* A0374 800AFB74 B40882A4 */  sh         $v0, 0x8B4($a0)
    /* A0378 800AFB78 08006230 */  andi       $v0, $v1, 0x8
    /* A037C 800AFB7C 02004014 */  bnez       $v0, .L800AFB88
    /* A0380 800AFB80 EC006230 */   andi      $v0, $v1, 0xEC
    /* A0384 800AFB84 B40882A4 */  sh         $v0, 0x8B4($a0)
  .L800AFB88:
    /* A0388 800AFB88 B4088394 */  lhu        $v1, 0x8B4($a0)
    /* A038C 800AFB8C 00000000 */  nop
    /* A0390 800AFB90 80006230 */  andi       $v0, $v1, 0x80
    /* A0394 800AFB94 02004014 */  bnez       $v0, .L800AFBA0
    /* A0398 800AFB98 DF006230 */   andi      $v0, $v1, 0xDF
    /* A039C 800AFB9C B40882A4 */  sh         $v0, 0x8B4($a0)
  .L800AFBA0:
    /* A03A0 800AFBA0 0800E003 */  jr         $ra
    /* A03A4 800AFBA4 00000000 */   nop
endlabel R3DCar_TurnHeadLightOff__FP8Car_tObji
