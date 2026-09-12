.include "macro.inc"
/* P907: exact native GameSetup name-table oracle,80113044..801131EC.
 * Preserve every byte/label for src; recon uses the typed source owner. */
.section .data.r09_gmesetup_names_legacy, "wa"

nonmatching GameSetup_gCarNames

dlabel GameSetup_gCarNames
    /* 103844 80113044 4D534C4B */ .word 0x4B4C534D
    /* 103848 80113048 00424D57 */ .word 0x574D4200
    /* 10384C 8011304C 5A004853 */ .word 0x5348005A
    /* 103850 80113050 56540046 */ .word 0x46005456
    /* 103854 80113054 4F524400 */ .word 0x0044524F
    /* 103858 80113058 434D524F */ .word 0x4F524D43
    /* 10385C 8011305C 00545241 */ .word 0x41525400
    /* 103860 80113060 4D004144 */ .word 0x4441004D
    /* 103864 80113064 4237004A */ .word 0x4A003742
    /* 103868 80113068 584B5200 */ .word 0x00524B58
    /* 10386C 8011306C 424D574D */ .word 0x4D574D42
    /* 103870 80113070 00434F52 */ .word 0x524F4300
    /* 103874 80113074 56004635 */ .word 0x35460056
    /* 103878 80113078 35300050 */ .word 0x50003035
    /* 10387C 8011307C 39393300 */ .word 0x00333939
    /* 103880 80113080 46333735 */ .word 0x35373346
    /* 103884 80113084 00444941 */ .word 0x41494400
    /* 103888 80113088 42004D43 */ .word 0x434D0042
    /* 10388C 8011308C 4C4B004D */ .word 0x4D004B4C
    /* 103890 80113090 43463100 */ .word 0x00314643
    /* 103894 80113094 58393933 */ .word 0x33393958
    /* 103898 80113098 00583337 */ .word 0x37335800
    /* 10389C 8011309C 35005843 */ .word 0x43580035
    /* 1038A0 801130A0 46310042 */ .word 0x42003146
    /* 1038A4 801130A4 4E533100 */ .word 0x0031534E
    /* 1038A8 801130A8 424E5332 */ .word 0x32534E42
    /* 1038AC 801130AC 00424E53 */ .word 0x534E4200
    /* 1038B0 801130B0 32004343 */ .word 0x43430032
    /* 1038B4 801130B4 50520043 */ .word 0x43005250
    /* 1038B8 801130B8 48535600 */ .word 0x00565348
    /* 1038BC 801130BC 43424D57 */ .word 0x574D4243
    /* 1038C0 801130C0 0043434F */ .word 0x4F434300
    /* 1038C4 801130C4 56004343 */ .word 0x43430056
    /* 1038C8 801130C8 4D520043 */ .word 0x4300524D
    /* 1038CC 801130CC 44424C00 */ .word 0x004C4244
    /* 1038D0 801130D0 43484F50 */ .word 0x504F4843
    /* 1038D4 801130D4 00475541 */ .word 0x41554700
    /* 1038D8 801130D8 5400424D */ .word 0x4D420054
    /* 1038DC 801130DC 5735004D */ .word 0x4D003557
    /* 1038E0 801130E0 45524300 */ .word 0x00435245
    /* 1038E4 801130E4 574F4C57 */ .word 0x574C4F57
    /* 1038E8 801130E8 00534255 */ .word 0x55425300
    /* 1038EC 801130EC 53005341 */ .word 0x41530053
    /* 1038F0 801130F0 4E440052 */ .word 0x5200444E
    /* 1038F4 801130F4 49415400 */ .word 0x00544149
    /* 1038F8 801130F8 41524D59 */ .word 0x594D5241
    /* 1038FC 801130FC 00434F4D */ .word 0x4D4F4300
    /* 103900 80113100 4300544F */ .word 0x4F540043
    /* 103904 80113104 4E310054 */ .word 0x5400314E
    /* 103908 80113108 4F4E3200 */ .word 0x00324E4F
    /* 10390C 8011310C 56414E00 */ .word 0x004E4156
    /* 103910 80113110 00424545 */ .word 0x45454200
    /* 103914 80113114 5000504B */ .word 0x4B500050
    /* 103918 80113118 55500050 */ .word 0x50005055
    /* 10391C 8011311C 4B555000 */ .word 0x0050554B
    /* 103920 80113120 46353030 */ .word 0x30303546
    /* 103924 80113124 00435543 */ .word 0x43554300
    /* 103928 80113128 41005441 */ .word 0x41540041
    /* 10392C 8011312C 58490054 */ .word 0x54004958
    /* 103930 80113130 42555300 */ .word 0x00535542
    /* 103934 80113134 4C4F4754 */ .word 0x54474F4C
    /* 103938 80113138 00434255 */ .word 0x55424300
    /* 10393C 8011313C 53004241 */ .word 0x41420053
    /* 103940 80113140 44210000 */ .word 0x00002144
enddlabel GameSetup_gCarNames

.align 2
nonmatching GameSetup_gTrackNames

dlabel GameSetup_gTrackNames
    /* 103944 80113144 */ .asciz "ALP"
    /* 414C5000 */
.align 2
.align 2
    /* 103948 80113148 */ .asciz "HWY"
    /* 48575900 */
.align 2
.align 2
    /* 10394C 8011314C */ .asciz "CST"
    /* 43535400 */
.align 2
.align 2
    /* 103950 80113150 */ .asciz "FRN"
    /* 46524E00 */
.align 2
.align 2
    /* 103954 80113154 */ .asciz "PAR"
    /* 50415200 */
.align 2
.align 2
    /* 103958 80113158 */ .asciz "HIL"
    /* 48494C00 */
.align 2
.align 2
    /* 10395C 8011315C */ .asciz "GER"
    /* 47455200 */
.align 2
.align 2
    /* 103960 80113160 */ .asciz "ENG"
    /* 454E4700 */
.align 2
.align 2
    /* 103964 80113164 */ .asciz "GT1"
    /* 47543100 */
.align 2
.align 2
    /* 103968 80113168 */ .asciz "GT2"
    /* 47543200 */
.align 2
.align 2
    /* 10396C 8011316C */ .asciz "GT3"
    /* 47543300 */
.align 2
.align 2
    /* 103970 80113170 */ .asciz "BAD"
    /* 42414400 */
.align 2
enddlabel GameSetup_gTrackNames

.align 2
nonmatching GameSetup_gPersonalityNames

dlabel GameSetup_gPersonalityNames
    /* 103974 80113174 */ .asciz "Nemesis"
    /* 4E656D6573697300 */
.align 2
.align 2
    /* 10397C 8011317C */ .asciz "Bullit"
    /* 42756C6C69740000 */
.align 2
.align 2
    /* 103984 80113184 */ .asciz "Frost"
    /* 46726F7374000000 */
.align 2
.align 2
    /* 10398C 8011318C */ .asciz "Ranger"
    /* 52616E6765720000 */
.align 2
.align 2
    /* 103994 80113194 */ .asciz "Chump"
    /* 4368756D70000000 */
.align 2
.align 2
    /* 10399C 8011319C */ .asciz "Snake"
    /* 536E616B65000000 */
.align 2
.align 2
    /* 1039A4 801131A4 */ .asciz "Razor"
    /* 52617A6F72000000 */
.align 2
.align 2
    /* 1039AC 801131AC */ .asciz "Thunder"
    /* 5468756E64657200 */
.align 2
.align 2
    /* 1039B4 801131B4 */ .asciz "Roadhog"
    /* 526F6164686F6700 */
.align 2
.align 2
    /* 1039BC 801131BC */ .asciz "Clutch"
    /* 436C757463680000 */
.align 2
.align 2
    /* 1039C4 801131C4 */ .asciz "Scooter"
    /* 53636F6F74657200 */
.align 2
.align 2
    /* 1039CC 801131CC */ .asciz "WndrBoy"
    /* 576E6472426F7900 */
.align 2
.align 2
    /* 1039D4 801131D4 */ .asciz "Flash"
    /* 466C617368000000 */
.align 2
.align 2
    /* 1039DC 801131DC */ .asciz "KikBut"
    /* 4B696B4275740000 */
.align 2
.align 2
    /* 1039E4 801131E4 */ .asciz "Laser"
    /* 4C61736572000000 */
.align 2
enddlabel GameSetup_gPersonalityNames
