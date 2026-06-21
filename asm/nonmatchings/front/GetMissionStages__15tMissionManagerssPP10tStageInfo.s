.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetMissionStages__15tMissionManagerssPP10tStageInfo, 0x68

glabel GetMissionStages__15tMissionManagerssPP10tStageInfo
    /* 249F4 800341F4 002C0500 */  sll        $a1, $a1, 16
    /* 249F8 800341F8 832B0500 */  sra        $a1, $a1, 14
    /* 249FC 800341FC 0400888C */  lw         $t0, 0x4($a0)
    /* 24A00 80034200 00340600 */  sll        $a2, $a2, 16
    /* 24A04 80034204 21280501 */  addu       $a1, $t0, $a1
    /* 24A08 80034208 0200A290 */  lbu        $v0, 0x2($a1)
    /* 24A0C 8003420C 03340600 */  sra        $a2, $a2, 16
    /* 24A10 80034210 21104600 */  addu       $v0, $v0, $a2
    /* 24A14 80034214 80180200 */  sll        $v1, $v0, 2
    /* 24A18 80034218 21186200 */  addu       $v1, $v1, $v0
    /* 24A1C 8003421C 80180300 */  sll        $v1, $v1, 2
    /* 24A20 80034220 20006324 */  addiu      $v1, $v1, 0x20
    /* 24A24 80034224 21180301 */  addu       $v1, $t0, $v1
    /* 24A28 80034228 08006494 */  lhu        $a0, 0x8($v1)
    /* 24A2C 8003422C 00000000 */  nop
    /* 24A30 80034230 40100400 */  sll        $v0, $a0, 1
    /* 24A34 80034234 21104400 */  addu       $v0, $v0, $a0
    /* 24A38 80034238 80100200 */  sll        $v0, $v0, 2
    /* 24A3C 8003423C 23104400 */  subu       $v0, $v0, $a0
    /* 24A40 80034240 80100200 */  sll        $v0, $v0, 2
    /* 24A44 80034244 20054224 */  addiu      $v0, $v0, 0x520
    /* 24A48 80034248 21400201 */  addu       $t0, $t0, $v0
    /* 24A4C 8003424C 0000E8AC */  sw         $t0, 0x0($a3)
    /* 24A50 80034250 0A006290 */  lbu        $v0, 0xA($v1)
    /* 24A54 80034254 0800E003 */  jr         $ra
    /* 24A58 80034258 00000000 */   nop
endlabel GetMissionStages__15tMissionManagerssPP10tStageInfo
