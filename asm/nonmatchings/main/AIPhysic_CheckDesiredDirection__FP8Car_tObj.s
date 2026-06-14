.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AIPhysic_CheckDesiredDirection__FP8Car_tObj, 0x48

glabel AIPhysic_CheckDesiredDirection__FP8Car_tObj
    /* 5A234 80069A34 0800053C */  lui        $a1, (0x8E38E >> 16)
    /* 5A238 80069A38 6002828C */  lw         $v0, 0x260($a0)
    /* 5A23C 80069A3C 00000000 */  nop
    /* 5A240 80069A40 20004230 */  andi       $v0, $v0, 0x20
    /* 5A244 80069A44 03004010 */  beqz       $v0, .L80069A54
    /* 5A248 80069A48 8EE3A534 */   ori       $a1, $a1, (0x8E38E & 0xFFFF)
    /* 5A24C 80069A4C 1180023C */  lui        $v0, %hi(GameSetup_gData)
    /* 5A250 80069A50 EC31438C */  lw         $v1, %lo(GameSetup_gData)($v0)
  .L80069A54:
    /* 5A254 80069A54 6805828C */  lw         $v0, 0x568($a0)
    /* 5A258 80069A58 00000000 */  nop
    /* 5A25C 80069A5C 2A104500 */  slt        $v0, $v0, $a1
    /* 5A260 80069A60 04004010 */  beqz       $v0, .L80069A74
    /* 5A264 80069A64 00000000 */   nop
    /* 5A268 80069A68 5005828C */  lw         $v0, 0x550($a0)
    /* 5A26C 80069A6C 00000000 */  nop
    /* 5A270 80069A70 540582AC */  sw         $v0, 0x554($a0)
  .L80069A74:
    /* 5A274 80069A74 0800E003 */  jr         $ra
    /* 5A278 80069A78 00000000 */   nop
endlabel AIPhysic_CheckDesiredDirection__FP8Car_tObj
