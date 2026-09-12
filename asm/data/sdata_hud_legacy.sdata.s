.include "macro.inc"
/* P909 oracle-only HUD middle: original r20 offsets0x24..0x114.
 * Native8013D89C..8013D98C, exactly240 bytes; preserve all original labels.
 * Reconstruction lane uses the verified complete source-owned HUD section. */
.section .sdata, "wa"

.align 2
nonmatching HudminChar

dlabel HudminChar
    /* 12E09C 8013D89C */ .asciz "::'''."
    /* 3A3A2727272E0000 */
.align 2
enddlabel HudminChar

.align 2
nonmatching HudsecChar

dlabel HudsecChar
    /* 12E0A4 8013D8A4 */ .asciz ".:\"\"\","
    /* 2E3A2222222C0000 */
.align 2
enddlabel HudsecChar

nonmatching D_8013D8AC

dlabel D_8013D8AC
    /* 12E0AC 8013D8AC 00000000 */ .word 0x00000000
enddlabel D_8013D8AC

nonmatching Hud_gWingmanInterface

dlabel Hud_gWingmanInterface
    /* 12E0B0 8013D8B0 00000000 */ .word 0x00000000
enddlabel Hud_gWingmanInterface

nonmatching Hud_gWingmanFlashIcon

dlabel Hud_gWingmanFlashIcon
    /* 12E0B4 8013D8B4 00000000 */ .word 0x00000000
enddlabel Hud_gWingmanFlashIcon

nonmatching Hud_gWingmanFlashTicks

dlabel Hud_gWingmanFlashTicks
    /* 12E0B8 8013D8B8 00000000 */ .word 0x00000000
    /* 12E0BC 8013D8BC 00000000 */ .word 0x00000000
enddlabel Hud_gWingmanFlashTicks

nonmatching Hud_gDebugInfo

dlabel Hud_gDebugInfo
    /* 12E0C0 8013D8C0 01000000 */ .word 0x00000001
enddlabel Hud_gDebugInfo

.align 2
nonmatching D_8013D8C4

dlabel D_8013D8C4
    /* 12E0C4 8013D8C4 */ .asciz "SLC %d"
    /* 534C432025640000 */
.align 2
enddlabel D_8013D8C4

.align 2
nonmatching D_8013D8CC

dlabel D_8013D8CC
    /* 12E0CC 8013D8CC */ .asciz "HUD1"
    /* 4855443100000000 */
.align 2
enddlabel D_8013D8CC

.align 2
nonmatching D_8013D8D4

dlabel D_8013D8D4
    /* 12E0D4 8013D8D4 */ .asciz "HUD2"
    /* 4855443200000000 */
.align 2
enddlabel D_8013D8D4

.align 2
nonmatching D_8013D8DC

dlabel D_8013D8DC
    /* 12E0DC 8013D8DC */ .asciz "::'''."
    /* 3A3A2727272E0000 */
.align 2
enddlabel D_8013D8DC

.align 2
nonmatching D_8013D8E4

dlabel D_8013D8E4
    /* 12E0E4 8013D8E4 */ .asciz ".:\"\"\","
    /* 2E3A2222222C0000 */
.align 2
enddlabel D_8013D8E4

.align 2
nonmatching D_8013D8EC

dlabel D_8013D8EC
    /* 12E0EC 8013D8EC */ .asciz "0/0"
    /* 302F3000 */
.align 2
enddlabel D_8013D8EC

.align 2
nonmatching D_8013D8F0

dlabel D_8013D8F0
    /* 12E0F0 8013D8F0 */ .asciz "0M00S00"
    /* 304D303053303000 */
.align 2
enddlabel D_8013D8F0

.align 2
nonmatching D_8013D8F8

dlabel D_8013D8F8
    /* 12E0F8 8013D8F8 */ .asciz "0.000"
    /* 302E303030000000 */
.align 2
enddlabel D_8013D8F8

nonmatching D_8013D900

dlabel D_8013D900
    /* 12E100 8013D900 00000000 */ .word 0x00000000
enddlabel D_8013D900

.align 2
nonmatching D_8013D904

dlabel D_8013D904
    /* 12E104 8013D904 */ .asciz "%s"
    /* 25730000 */
.align 2
enddlabel D_8013D904

.align 2
nonmatching D_8013D908

dlabel D_8013D908
    /* 12E108 8013D908 */ .asciz "%02d"
    /* 2530326400000000 */
.align 2
enddlabel D_8013D908

.align 2
nonmatching D_8013D910

dlabel D_8013D910
    /* 12E110 8013D910 */ .asciz "- -"
    /* 2D202D00 */
.align 2
enddlabel D_8013D910

nonmatching D_8013D914

dlabel D_8013D914
    /* 12E114 8013D914 04000102 */ .word 0x02010004
    /* 12E118 8013D918 03000000 */ .word 0x00000003
enddlabel D_8013D914

nonmatching D_8013D91C

dlabel D_8013D91C
    /* 12E11C 8013D91C */ .byte 0x00
enddlabel D_8013D91C

nonmatching D_8013D91D

dlabel D_8013D91D
    /* 12E11D 8013D91D */ .byte 0xFF
    /* 12E11E 8013D91E */ .byte 0x00
    /* 12E11F 8013D91F */ .byte 0x00
enddlabel D_8013D91D

nonmatching D_8013D920

dlabel D_8013D920
    /* 12E120 8013D920 32000000 */ .word 0x00000032
enddlabel D_8013D920

nonmatching D_8013D924

dlabel D_8013D924
    /* 12E124 8013D924 00000000 */ .word 0x00000000
enddlabel D_8013D924

nonmatching HudBustedOverlay

dlabel HudBustedOverlay
    /* 12E128 8013D928 00000000 */ .word 0x00000000
enddlabel HudBustedOverlay

nonmatching Hud_gCdActive

dlabel Hud_gCdActive
    /* 12E12C 8013D92C 00000000 */ .word 0x00000000
enddlabel Hud_gCdActive

nonmatching Hud_ActivateCDPlayer

dlabel Hud_ActivateCDPlayer
    /* 12E130 8013D930 00000000 */ .word 0x00000000
enddlabel Hud_ActivateCDPlayer

nonmatching BTC_Countdown

dlabel BTC_Countdown
    /* 12E134 8013D934 00000000 */ .word 0x00000000
enddlabel BTC_Countdown

nonmatching FinalBTC_Countdown

dlabel FinalBTC_Countdown
    /* 12E138 8013D938 00000000 */ .word 0x00000000
enddlabel FinalBTC_Countdown

nonmatching Hud_BeTheCop

dlabel Hud_BeTheCop
    /* 12E13C 8013D93C 00000000 */ .word 0x00000000
enddlabel Hud_BeTheCop

nonmatching Hud_kTurnSongOffNext

dlabel Hud_kTurnSongOffNext
    /* 12E140 8013D940 00000000 */ .word 0x00000000
enddlabel Hud_kTurnSongOffNext

nonmatching HudBustedOverlayPlayer

dlabel HudBustedOverlayPlayer
    /* 12E144 8013D944 */ .short 0x0000
    /* 12E146 8013D946 */ .short 0x0000
enddlabel HudBustedOverlayPlayer

nonmatching mapMarkerMCos

dlabel mapMarkerMCos
    /* 12E148 8013D948 00000000 */ .word 0x00000000
enddlabel mapMarkerMCos

nonmatching mapMarkerMSin

dlabel mapMarkerMSin
    /* 12E14C 8013D94C 00000000 */ .word 0x00000000
enddlabel mapMarkerMSin

nonmatching Hud_gHudView

dlabel Hud_gHudView
    /* 12E150 8013D950 00000000 */ .word 0x00000000
enddlabel Hud_gHudView

nonmatching D_8013D954

dlabel D_8013D954
    /* 12E154 8013D954 00000000 */ .word 0x00000000
enddlabel D_8013D954

nonmatching Hud_gMapView

dlabel Hud_gMapView
    /* 12E158 8013D958 00000000 */ .word 0x00000000
enddlabel Hud_gMapView

nonmatching D_8013D95C

dlabel D_8013D95C
    /* 12E15C 8013D95C 00000000 */ .word 0x00000000
enddlabel D_8013D95C

nonmatching Hud_gTacView

dlabel Hud_gTacView
    /* 12E160 8013D960 00000000 */ .word 0x00000000
enddlabel Hud_gTacView

nonmatching D_8013D964

dlabel D_8013D964
    /* 12E164 8013D964 00000000 */ .word 0x00000000
enddlabel D_8013D964

nonmatching Hud_gStatsView

dlabel Hud_gStatsView
    /* 12E168 8013D968 00000000 */ .word 0x00000000
enddlabel Hud_gStatsView

nonmatching HudMapOffsetY

dlabel HudMapOffsetY
    /* 12E16C 8013D96C 00000000 */ .word 0x00000000
enddlabel HudMapOffsetY

nonmatching gMapRotate

dlabel gMapRotate
    /* 12E170 8013D970 00000000 */ .word 0x00000000
enddlabel gMapRotate

nonmatching gMapScaleX

dlabel gMapScaleX
    /* 12E174 8013D974 00000000 */ .word 0x00000000
enddlabel gMapScaleX

nonmatching gMapScaleY

dlabel gMapScaleY
    /* 12E178 8013D978 00000000 */ .word 0x00000000
enddlabel gMapScaleY

nonmatching gMapOffX

dlabel gMapOffX
    /* 12E17C 8013D97C 00000000 */ .word 0x00000000
enddlabel gMapOffX

nonmatching gMapOffY

dlabel gMapOffY
    /* 12E180 8013D980 00000000 */ .word 0x00000000
enddlabel gMapOffY

nonmatching Hud_gCdLastTick

dlabel Hud_gCdLastTick
    /* 12E184 8013D984 00000000 */ .word 0x00000000
enddlabel Hud_gCdLastTick

nonmatching Hud_gCdScrollTitle

dlabel Hud_gCdScrollTitle
    /* 12E188 8013D988 00000000 */ .word 0x00000000
enddlabel Hud_gCdScrollTitle
