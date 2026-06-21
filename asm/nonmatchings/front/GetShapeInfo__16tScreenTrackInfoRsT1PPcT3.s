.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching GetShapeInfo__16tScreenTrackInfoRsT1PPcT3, 0xA0

glabel GetShapeInfo__16tScreenTrackInfoRsT1PPcT3
    /* 329F8 800421F8 D8FFBD27 */  addiu      $sp, $sp, -0x28
    /* 329FC 800421FC 1400B1AF */  sw         $s1, 0x14($sp)
    /* 32A00 80042200 21888000 */  addu       $s1, $a0, $zero
    /* 32A04 80042204 1180043C */  lui        $a0, %hi(tournamentManager)
    /* 32A08 80042208 D84A8424 */  addiu      $a0, $a0, %lo(tournamentManager)
    /* 32A0C 8004220C 1C00B3AF */  sw         $s3, 0x1C($sp)
    /* 32A10 80042210 3800B38F */  lw         $s3, 0x38($sp)
    /* 32A14 80042214 2B000224 */  addiu      $v0, $zero, 0x2B
    /* 32A18 80042218 2000BFAF */  sw         $ra, 0x20($sp)
    /* 32A1C 8004221C 1800B2AF */  sw         $s2, 0x18($sp)
    /* 32A20 80042220 1000B0AF */  sw         $s0, 0x10($sp)
    /* 32A24 80042224 0000A2A4 */  sh         $v0, 0x0($a1)
    /* 32A28 80042228 64002526 */  addiu      $a1, $s1, 0x64
    /* 32A2C 8004222C 0A000224 */  addiu      $v0, $zero, 0xA
    /* 32A30 80042230 2190E000 */  addu       $s2, $a3, $zero
    /* 32A34 80042234 A3C9000C */  jal        GetTrackToRace__18tTournamentManagerR10tTrackInfo
    /* 32A38 80042238 0000C2A4 */   sh        $v0, 0x0($a2)
    /* 32A3C 8004223C 0580103C */  lui        $s0, %hi(D_80052CB8)
    /* 32A40 80042240 B82C1026 */  addiu      $s0, $s0, %lo(D_80052CB8)
    /* 32A44 80042244 21200002 */  addu       $a0, $s0, $zero
    /* 32A48 80042248 0180053C */  lui        $a1, %hi(D_80011F60)
    /* 32A4C 8004224C 601FA524 */  addiu      $a1, $a1, %lo(D_80011F60)
    /* 32A50 80042250 0180023C */  lui        $v0, %hi(D_80011F58)
    /* 32A54 80042254 581F4224 */  addiu      $v0, $v0, %lo(D_80011F58)
    /* 32A58 80042258 000042AE */  sw         $v0, 0x0($s2)
    /* 32A5C 8004225C 67002292 */  lbu        $v0, 0x67($s1)
    /* 32A60 80042260 68002792 */  lbu        $a3, 0x68($s1)
    /* 32A64 80042264 64002682 */  lb         $a2, 0x64($s1)
    /* 32A68 80042268 40100200 */  sll        $v0, $v0, 1
    /* 32A6C 8004226C 6100E724 */  addiu      $a3, $a3, 0x61
    /* 32A70 80042270 2F91030C */  jal        sprintf
    /* 32A74 80042274 21384700 */   addu      $a3, $v0, $a3
    /* 32A78 80042278 000070AE */  sw         $s0, 0x0($s3)
    /* 32A7C 8004227C 2000BF8F */  lw         $ra, 0x20($sp)
    /* 32A80 80042280 1C00B38F */  lw         $s3, 0x1C($sp)
    /* 32A84 80042284 1800B28F */  lw         $s2, 0x18($sp)
    /* 32A88 80042288 1400B18F */  lw         $s1, 0x14($sp)
    /* 32A8C 8004228C 1000B08F */  lw         $s0, 0x10($sp)
    /* 32A90 80042290 0800E003 */  jr         $ra
    /* 32A94 80042294 2800BD27 */   addiu     $sp, $sp, 0x28
endlabel GetShapeInfo__16tScreenTrackInfoRsT1PPcT3
