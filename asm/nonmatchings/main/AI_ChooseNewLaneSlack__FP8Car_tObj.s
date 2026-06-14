.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching AI_ChooseNewLaneSlack__FP8Car_tObj, 0x4C

glabel AI_ChooseNewLaneSlack__FP8Car_tObj
    /* 4B1DC 8005A9DC 1480053C */  lui        $a1, %hi(fastRandom)
    /* 4B1E0 8005A9E0 FCD0A58C */  lw         $a1, %lo(fastRandom)($a1)
    /* 4B1E4 8005A9E4 1480023C */  lui        $v0, %hi(randSeed)
    /* 4B1E8 8005A9E8 04D1428C */  lw         $v0, %lo(randSeed)($v0)
    /* 4B1EC 8005A9EC 00000000 */  nop
    /* 4B1F0 8005A9F0 1800A200 */  mult       $a1, $v0
    /* 4B1F4 8005A9F4 F004838C */  lw         $v1, 0x4F0($a0)
    /* 4B1F8 8005A9F8 12280000 */  mflo       $a1
    /* 4B1FC 8005A9FC 82110500 */  srl        $v0, $a1, 6
    /* 4B200 8005AA00 0C004230 */  andi       $v0, $v0, 0xC
    /* 4B204 8005AA04 21186200 */  addu       $v1, $v1, $v0
    /* 4B208 8005AA08 0C00628C */  lw         $v0, 0xC($v1)
    /* 4B20C 8005AA0C 1480013C */  lui        $at, %hi(randtemp)
    /* 4B210 8005AA10 00D125AC */  sw         $a1, %lo(randtemp)($at)
    /* 4B214 8005AA14 FFFFA530 */  andi       $a1, $a1, 0xFFFF
    /* 4B218 8005AA18 1480013C */  lui        $at, %hi(fastRandom)
    /* 4B21C 8005AA1C FCD025AC */  sw         $a1, %lo(fastRandom)($at)
    /* 4B220 8005AA20 0800E003 */  jr         $ra
    /* 4B224 8005AA24 6C0582AC */   sw        $v0, 0x56C($a0)
endlabel AI_ChooseNewLaneSlack__FP8Car_tObj
