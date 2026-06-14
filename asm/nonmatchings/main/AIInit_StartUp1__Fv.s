.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIInit_StartUp1__Fv, 0x74

glabel AIInit_StartUp1__Fv
    /* 573B0 80066BB0 E0FFBD27 */  addiu      $sp, $sp, -0x20
    /* 573B4 80066BB4 1800BFAF */  sw         $ra, 0x18($sp)
    /* 573B8 80066BB8 1400B1AF */  sw         $s1, 0x14($sp)
    /* 573BC 80066BBC C39B010C */  jal        AI_TrafficStartUp__Fv
    /* 573C0 80066BC0 1000B0AF */   sw        $s0, 0x10($sp)
    /* 573C4 80066BC4 1180023C */  lui        $v0, %hi(inverseLaneWidthTable)
    /* 573C8 80066BC8 01001024 */  addiu      $s0, $zero, 0x1
    /* 573CC 80066BCC 0CE040AC */  sw         $zero, %lo(inverseLaneWidthTable)($v0)
    /* 573D0 80066BD0 0CE04224 */  addiu      $v0, $v0, %lo(inverseLaneWidthTable)
    /* 573D4 80066BD4 04005124 */  addiu      $s1, $v0, 0x4
  .L80066BD8:
    /* 573D8 80066BD8 0100043C */  lui        $a0, (0x10000 >> 16)
    /* 573DC 80066BDC 0191030C */  jal        rdiv
    /* 573E0 80066BE0 802B1000 */   sll       $a1, $s0, 14
    /* 573E4 80066BE4 000022AE */  sw         $v0, 0x0($s1)
    /* 573E8 80066BE8 01001026 */  addiu      $s0, $s0, 0x1
    /* 573EC 80066BEC 5000022A */  slti       $v0, $s0, 0x50
    /* 573F0 80066BF0 F9FF4014 */  bnez       $v0, .L80066BD8
    /* 573F4 80066BF4 04003126 */   addiu     $s1, $s1, 0x4
    /* 573F8 80066BF8 D0CB010C */  jal        AITune_StartUp1__Fv
    /* 573FC 80066BFC 00000000 */   nop
    /* 57400 80066C00 CFB3010C */  jal        StartUp1__14AIDataRecord_t
    /* 57404 80066C04 00000000 */   nop
    /* 57408 80066C08 5F5E010C */  jal        AI_StartUp__Fv
    /* 5740C 80066C0C 00000000 */   nop
    /* 57410 80066C10 1800BF8F */  lw         $ra, 0x18($sp)
    /* 57414 80066C14 1400B18F */  lw         $s1, 0x14($sp)
    /* 57418 80066C18 1000B08F */  lw         $s0, 0x10($sp)
    /* 5741C 80066C1C 0800E003 */  jr         $ra
    /* 57420 80066C20 2000BD27 */   addiu     $sp, $sp, 0x20
endlabel AIInit_StartUp1__Fv
