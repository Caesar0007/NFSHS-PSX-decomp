.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__17tScreenTrophyRoomRsT1PPcT3, 0xC0

glabel GetShapeInfo__17tScreenTrophyRoomRsT1PPcT3
    /* 30DD8 800405D8 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 30DDC 800405DC 1C00B1AF */  sw         $s1, 0x1C($sp)
    /* 30DE0 800405E0 2188E000 */  addu       $s1, $a3, $zero
    /* 30DE4 800405E4 2000B2AF */  sw         $s2, 0x20($sp)
    /* 30DE8 800405E8 3800B28F */  lw         $s2, 0x38($sp)
    /* 30DEC 800405EC 26000224 */  addiu      $v0, $zero, 0x26
    /* 30DF0 800405F0 2400BFAF */  sw         $ra, 0x24($sp)
    /* 30DF4 800405F4 1800B0AF */  sw         $s0, 0x18($sp)
    /* 30DF8 800405F8 0000A2A4 */  sh         $v0, 0x0($a1)
    /* 30DFC 800405FC 20000224 */  addiu      $v0, $zero, 0x20
    /* 30E00 80040600 0000C2A4 */  sh         $v0, 0x0($a2)
    /* 30E04 80040604 1180023C */  lui        $v0, %hi(D_80114722)
    /* 30E08 80040608 0580103C */  lui        $s0, %hi(gSwapFileName)
    /* 30E0C 8004060C 64201026 */  addiu      $s0, $s0, %lo(gSwapFileName)
    /* 30E10 80040610 22474390 */  lbu        $v1, %lo(D_80114722)($v0)
    /* 30E14 80040614 21380002 */  addu       $a3, $s0, $zero
    /* 30E18 80040618 40100300 */  sll        $v0, $v1, 1
    /* 30E1C 8004061C 21288200 */  addu       $a1, $a0, $v0
    /* 30E20 80040620 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 30E24 80040624 D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 30E28 80040628 21104300 */  addu       $v0, $v0, $v1
    /* 30E2C 8004062C 80100200 */  sll        $v0, $v0, 2
    /* 30E30 80040630 1800868C */  lw         $a2, 0x18($a0)
    /* 30E34 80040634 D400A590 */  lbu        $a1, 0xD4($a1)
    /* 30E38 80040638 2110C200 */  addu       $v0, $a2, $v0
    /* 30E3C 8004063C 02004390 */  lbu        $v1, 0x2($v0)
    /* 30E40 80040640 FFFF0224 */  addiu      $v0, $zero, -0x1
    /* 30E44 80040644 1000A2AF */  sw         $v0, 0x10($sp)
    /* 30E48 80040648 21186500 */  addu       $v1, $v1, $a1
    /* 30E4C 8004064C 80280300 */  sll        $a1, $v1, 2
    /* 30E50 80040650 2128A300 */  addu       $a1, $a1, $v1
    /* 30E54 80040654 80280500 */  sll        $a1, $a1, 2
    /* 30E58 80040658 2128A300 */  addu       $a1, $a1, $v1
    /* 30E5C 8004065C 80280500 */  sll        $a1, $a1, 2
    /* 30E60 80040660 2400A524 */  addiu      $a1, $a1, 0x24
    /* 30E64 80040664 2128C500 */  addu       $a1, $a2, $a1
    /* 30E68 80040668 D9CE000C */  jal        GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci
    /* 30E6C 8004066C 21300000 */   addu      $a2, $zero, $zero
    /* 30E70 80040670 0180023C */  lui        $v0, %hi(D_80011E0C)
    /* 30E74 80040674 0C1E4224 */  addiu      $v0, $v0, %lo(D_80011E0C)
    /* 30E78 80040678 000022AE */  sw         $v0, 0x0($s1)
    /* 30E7C 8004067C 000050AE */  sw         $s0, 0x0($s2)
    /* 30E80 80040680 2400BF8F */  lw         $ra, 0x24($sp)
    /* 30E84 80040684 2000B28F */  lw         $s2, 0x20($sp)
    /* 30E88 80040688 1C00B18F */  lw         $s1, 0x1C($sp)
    /* 30E8C 8004068C 1800B08F */  lw         $s0, 0x18($sp)
    /* 30E90 80040690 0800E003 */  jr         $ra
    /* 30E94 80040694 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel GetShapeInfo__17tScreenTrophyRoomRsT1PPcT3
