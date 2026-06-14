.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

nonmatching _padInitDirSeq, 0x34

glabel _padInitDirSeq
    /* FA8B0 8010A0B0 1180023C */  lui        $v0, %hi(func_8010A0E4)
    /* FA8B4 8010A0B4 E4A04224 */  addiu      $v0, $v0, %lo(func_8010A0E4)
    /* FA8B8 8010A0B8 1380013C */  lui        $at, %hi(_padFuncSendAuto)
    /* FA8BC 8010A0BC 907C22AC */  sw         $v0, %lo(_padFuncSendAuto)($at)
    /* FA8C0 8010A0C0 1180023C */  lui        $v0, %hi(func_8010A510)
    /* FA8C4 8010A0C4 10A54224 */  addiu      $v0, $v0, %lo(func_8010A510)
    /* FA8C8 8010A0C8 1380013C */  lui        $at, %hi(_padFuncChkEng)
    /* FA8CC 8010A0CC 947C22AC */  sw         $v0, %lo(_padFuncChkEng)($at)
    /* FA8D0 8010A0D0 1180023C */  lui        $v0, %hi(func_8010A1E4)
    /* FA8D4 8010A0D4 E4A14224 */  addiu      $v0, $v0, %lo(func_8010A1E4)
    /* FA8D8 8010A0D8 1380013C */  lui        $at, %hi(_padFuncRecvAuto)
    /* FA8DC 8010A0DC 0800E003 */  jr         $ra
    /* FA8E0 8010A0E0 987C22AC */   sw        $v0, %lo(_padFuncRecvAuto)($at)
endlabel _padInitDirSeq
