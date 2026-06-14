.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_HandleSignalling__FP8Car_tObj, 0x74

glabel AIPhysic_HandleSignalling__FP8Car_tObj
    /* 5A27C 80069A7C 6002828C */  lw         $v0, 0x260($a0)
    /* 5A280 80069A80 00000000 */  nop
    /* 5A284 80069A84 10004230 */  andi       $v0, $v0, 0x10
    /* 5A288 80069A88 17004010 */  beqz       $v0, .L80069AE8
    /* 5A28C 80069A8C FCFF023C */   lui       $v0, (0xFFFC0000 >> 16)
    /* 5A290 80069A90 7405858C */  lw         $a1, 0x574($a0)
    /* 5A294 80069A94 5805838C */  lw         $v1, 0x558($a0)
    /* 5A298 80069A98 2110A200 */  addu       $v0, $a1, $v0
    /* 5A29C 80069A9C 2A106200 */  slt        $v0, $v1, $v0
    /* 5A2A0 80069AA0 06004010 */  beqz       $v0, .L80069ABC
    /* 5A2A4 80069AA4 0400023C */   lui       $v0, (0x40000 >> 16)
    /* 5A2A8 80069AA8 B8088294 */  lhu        $v0, 0x8B8($a0)
    /* 5A2AC 80069AAC BA0880A4 */  sh         $zero, 0x8BA($a0)
    /* 5A2B0 80069AB0 80004234 */  ori        $v0, $v0, 0x80
    /* 5A2B4 80069AB4 0800E003 */  jr         $ra
    /* 5A2B8 80069AB8 B80882A4 */   sh        $v0, 0x8B8($a0)
  .L80069ABC:
    /* 5A2BC 80069ABC 2110A200 */  addu       $v0, $a1, $v0
    /* 5A2C0 80069AC0 2A104300 */  slt        $v0, $v0, $v1
    /* 5A2C4 80069AC4 06004010 */  beqz       $v0, .L80069AE0
    /* 5A2C8 80069AC8 00000000 */   nop
    /* 5A2CC 80069ACC BA088294 */  lhu        $v0, 0x8BA($a0)
    /* 5A2D0 80069AD0 B80880A4 */  sh         $zero, 0x8B8($a0)
    /* 5A2D4 80069AD4 80004234 */  ori        $v0, $v0, 0x80
    /* 5A2D8 80069AD8 0800E003 */  jr         $ra
    /* 5A2DC 80069ADC BA0882A4 */   sh        $v0, 0x8BA($a0)
  .L80069AE0:
    /* 5A2E0 80069AE0 B80880A4 */  sh         $zero, 0x8B8($a0)
    /* 5A2E4 80069AE4 BA0880A4 */  sh         $zero, 0x8BA($a0)
  .L80069AE8:
    /* 5A2E8 80069AE8 0800E003 */  jr         $ra
    /* 5A2EC 80069AEC 00000000 */   nop
endlabel AIPhysic_HandleSignalling__FP8Car_tObj
