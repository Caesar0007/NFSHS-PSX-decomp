.include "macro.inc"
/* P882: oracle-only NFS3 .sdata, 0x8013D270..0x8013D2C8.
 * Reconstruction selects the exact nfs3.cpp.o(.sdata) payload. */

.section .sdata, "wa"

nonmatching gMusicInSimIsOn

dlabel gMusicInSimIsOn
    /* 12DA70 8013D270 01000000 */ .word 0x00000001
enddlabel gMusicInSimIsOn

nonmatching gUseFrontend

dlabel gUseFrontend
    /* 12DA74 8013D274 01000000 */ .word 0x00000001
enddlabel gUseFrontend

nonmatching gFECheats

dlabel gFECheats
    /* 12DA78 8013D278 00000000 */ .word 0x00000000
enddlabel gFECheats

nonmatching gFEBonus

dlabel gFEBonus
    /* 12DA7C 8013D27C 00000000 */ .word 0x00000000
enddlabel gFEBonus

nonmatching gFEBigHandle

dlabel gFEBigHandle
    /* 12DA80 8013D280 00000000 */ .word 0x00000000
enddlabel gFEBigHandle

nonmatching MEMCARDFRONTENDISINITTED

dlabel MEMCARDFRONTENDISINITTED
    /* 12DA84 8013D284 00000000 */ .word 0x00000000
enddlabel MEMCARDFRONTENDISINITTED

nonmatching gCheckTotalTime

dlabel gCheckTotalTime
    /* 12DA88 8013D288 */ .byte 0x01
enddlabel gCheckTotalTime

nonmatching gCheckLapTime

dlabel gCheckLapTime
    /* 12DA89 8013D289 */ .byte 0x01
enddlabel gCheckLapTime

nonmatching gUpdateTournamentInfoFlag

dlabel gUpdateTournamentInfoFlag
    /* 12DA8A 8013D28A */ .byte 0x01
enddlabel gUpdateTournamentInfoFlag

nonmatching gUpdateKnockoutInfoFlag

dlabel gUpdateKnockoutInfoFlag
    /* 12DA8B 8013D28B */ .byte 0x01
enddlabel gUpdateKnockoutInfoFlag

nonmatching gKnockOutSpeechFlag

dlabel gKnockOutSpeechFlag
    /* 12DA8C 8013D28C */ .byte 0x01
enddlabel gKnockOutSpeechFlag

nonmatching gCalculateVictory

dlabel gCalculateVictory
    /* 12DA8D 8013D28D */ .byte 0x01
    /* 12DA8E 8013D28E */ .short 0x0000
enddlabel gCalculateVictory

nonmatching gPlayerEnteredNameAlready

dlabel gPlayerEnteredNameAlready
    /* 12DA90 8013D290 00000000 */ .word 0x00000000
enddlabel gPlayerEnteredNameAlready

.align 2
nonmatching D_8013D294

dlabel D_8013D294
    /* 12DA94 8013D294 */ .asciz "%s%s"
    /* 2573257300000000 */
.align 2
enddlabel D_8013D294

.align 2
nonmatching D_8013D29C

dlabel D_8013D29C
    /* 12DA9C 8013D29C */ .asciz "ymus"
    /* 796D757300000000 */
.align 2
enddlabel D_8013D29C

.align 2
nonmatching D_8013D2A4

dlabel D_8013D2A4
    /* 12DAA4 8013D2A4 */ .asciz "win*"
    /* 77696E2A00000000 */
.align 2
enddlabel D_8013D2A4

.align 2
nonmatching D_8013D2AC

dlabel D_8013D2AC
    /* 12DAAC 8013D2AC */ .asciz "lose*"
    /* 6C6F73652A000000 */
.align 2
enddlabel D_8013D2AC

nonmatching nfs_sysInfo

dlabel nfs_sysInfo
    /* 12DAB4 8013D2B4 00000000 */ .word 0x00000000
enddlabel nfs_sysInfo

nonmatching missionManager

dlabel missionManager
    /* 12DAB8 8013D2B8 00000000 */ .word 0x00000000
    /* 12DABC 8013D2BC 00000000 */ .word 0x00000000
enddlabel missionManager

nonmatching finishOrder

dlabel finishOrder
    /* 12DAC0 8013D2C0 00000000 */ .word 0x00000000
    /* 12DAC4 8013D2C4 00000000 */ .word 0x00000000
enddlabel finishOrder
