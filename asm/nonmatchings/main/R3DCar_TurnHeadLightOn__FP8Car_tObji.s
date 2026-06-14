.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching R3DCar_TurnHeadLightOn__FP8Car_tObji, 0x60

glabel R3DCar_TurnHeadLightOn__FP8Car_tObji
    /* A02F4 800AFAF4 B4088294 */  lhu        $v0, 0x8B4($a0)
    /* A02F8 800AFAF8 00000000 */  nop
    /* A02FC 800AFAFC 11004234 */  ori        $v0, $v0, 0x11
    /* A0300 800AFB00 0500A010 */  beqz       $a1, .L800AFB18
    /* A0304 800AFB04 B40882A4 */   sh        $v0, 0x8B4($a0)
    /* A0308 800AFB08 B6088294 */  lhu        $v0, 0x8B6($a0)
    /* A030C 800AFB0C 00000000 */  nop
    /* A0310 800AFB10 02004234 */  ori        $v0, $v0, 0x2
    /* A0314 800AFB14 B60882A4 */  sh         $v0, 0x8B6($a0)
  .L800AFB18:
    /* A0318 800AFB18 B4088394 */  lhu        $v1, 0x8B4($a0)
    /* A031C 800AFB1C 00000000 */  nop
    /* A0320 800AFB20 08006230 */  andi       $v0, $v1, 0x8
    /* A0324 800AFB24 06004014 */  bnez       $v0, .L800AFB40
    /* A0328 800AFB28 80006230 */   andi      $v0, $v1, 0x80
    /* A032C 800AFB2C 02006234 */  ori        $v0, $v1, 0x2
    /* A0330 800AFB30 B40882A4 */  sh         $v0, 0x8B4($a0)
    /* A0334 800AFB34 B4088394 */  lhu        $v1, 0x8B4($a0)
    /* A0338 800AFB38 00000000 */  nop
    /* A033C 800AFB3C 80006230 */  andi       $v0, $v1, 0x80
  .L800AFB40:
    /* A0340 800AFB40 02004014 */  bnez       $v0, .L800AFB4C
    /* A0344 800AFB44 20006234 */   ori       $v0, $v1, 0x20
    /* A0348 800AFB48 B40882A4 */  sh         $v0, 0x8B4($a0)
  .L800AFB4C:
    /* A034C 800AFB4C 0800E003 */  jr         $ra
    /* A0350 800AFB50 00000000 */   nop
endlabel R3DCar_TurnHeadLightOn__FP8Car_tObji
