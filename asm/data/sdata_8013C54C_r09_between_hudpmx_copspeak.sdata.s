.include "macro.inc"
/* P882: unchanged residual 0x8013CD84..0x8013D07C from r09.
 * Both lanes retain these original bytes and labels. */

.section .sdata, "wa"

nonmatching _6Speech_fgSpeech

dlabel _6Speech_fgSpeech
    /* 12D584 8013CD84 00000000 */ .word 0x00000000
enddlabel _6Speech_fgSpeech

nonmatching _6Speech_fgUndefined

dlabel _6Speech_fgUndefined
    /* 12D588 8013CD88 00000000 */ .word 0x00000000
enddlabel _6Speech_fgUndefined

.align 2
nonmatching D_8013CD8C

dlabel D_8013CD8C
    /* 12D58C 8013CD8C */ .asciz "BMWZ"
    /* 424D575A00000000 */
.align 2
enddlabel D_8013CD8C

.align 2
nonmatching D_8013CD94

dlabel D_8013CD94
    /* 12D594 8013CD94 */ .asciz "bmwz3."
    /* 626D777A332E0000 */
.align 2
enddlabel D_8013CD94

.align 2
nonmatching D_8013CD9C

dlabel D_8013CD9C
    /* 12D59C 8013CD9C */ .asciz "bmw."
    /* 626D772E00000000 */
.align 2
enddlabel D_8013CD9C

.align 2
nonmatching D_8013CDA4

dlabel D_8013CDA4
    /* 12D5A4 8013CDA4 */ .asciz "z3."
    /* 7A332E00 */
.align 2
enddlabel D_8013CDA4

.align 2
nonmatching D_8013CDA8

dlabel D_8013CDA8
    /* 12D5A8 8013CDA8 */ .asciz "HSVT"
    /* 4853565400000000 */
.align 2
enddlabel D_8013CDA8

.align 2
nonmatching D_8013CDB0

dlabel D_8013CDB0
    /* 12D5B0 8013CDB0 */ .asciz "sedan."
    /* 736564616E2E0000 */
.align 2
enddlabel D_8013CDB0

.align 2
nonmatching D_8013CDB8

dlabel D_8013CDB8
    /* 12D5B8 8013CDB8 */ .asciz "FORD"
    /* 464F524400000000 */
.align 2
enddlabel D_8013CDB8

.align 2
nonmatching D_8013CDC0

dlabel D_8013CDC0
    /* 12D5C0 8013CDC0 */ .asciz "CMRO"
    /* 434D524F00000000 */
.align 2
enddlabel D_8013CDC0

.align 2
nonmatching D_8013CDC8

dlabel D_8013CDC8
    /* 12D5C8 8013CDC8 */ .asciz "chvcam."
    /* 63687663616D2E00 */
.align 2
enddlabel D_8013CDC8

.align 2
nonmatching D_8013CDD0

dlabel D_8013CDD0
    /* 12D5D0 8013CDD0 */ .asciz "chevro."
    /* 63686576726F2E00 */
.align 2
enddlabel D_8013CDD0

.align 2
nonmatching D_8013CDD8

dlabel D_8013CDD8
    /* 12D5D8 8013CDD8 */ .asciz "cam."
    /* 63616D2E00000000 */
.align 2
enddlabel D_8013CDD8

.align 2
nonmatching D_8013CDE0

dlabel D_8013CDE0
    /* 12D5E0 8013CDE0 */ .asciz "TRAM"
    /* 5452414D00000000 */
.align 2
enddlabel D_8013CDE0

.align 2
nonmatching D_8013CDE8

dlabel D_8013CDE8
    /* 12D5E8 8013CDE8 */ .asciz "pont."
    /* 706F6E742E000000 */
.align 2
enddlabel D_8013CDE8

.align 2
nonmatching D_8013CDF0

dlabel D_8013CDF0
    /* 12D5F0 8013CDF0 */ .asciz "ADB7"
    /* 4144423700000000 */
.align 2
enddlabel D_8013CDF0

.align 2
nonmatching D_8013CDF8

dlabel D_8013CDF8
    /* 12D5F8 8013CDF8 */ .asciz "aston."
    /* 6173746F6E2E0000 */
.align 2
enddlabel D_8013CDF8

.align 2
nonmatching D_8013CE00

dlabel D_8013CE00
    /* 12D600 8013CE00 */ .asciz "JXKR"
    /* 4A584B5200000000 */
.align 2
enddlabel D_8013CE00

.align 2
nonmatching D_8013CE08

dlabel D_8013CE08
    /* 12D608 8013CE08 */ .asciz "jag."
    /* 6A61672E00000000 */
.align 2
enddlabel D_8013CE08

.align 2
nonmatching D_8013CE10

dlabel D_8013CE10
    /* 12D610 8013CE10 */ .asciz "BMWM"
    /* 424D574D00000000 */
.align 2
enddlabel D_8013CE10

.align 2
nonmatching D_8013CE18

dlabel D_8013CE18
    /* 12D618 8013CE18 */ .asciz "bmwm5."
    /* 626D776D352E0000 */
.align 2
enddlabel D_8013CE18

.align 2
nonmatching D_8013CE20

dlabel D_8013CE20
    /* 12D620 8013CE20 */ .asciz "m5."
    /* 6D352E00 */
.align 2
enddlabel D_8013CE20

.align 2
nonmatching D_8013CE24

dlabel D_8013CE24
    /* 12D624 8013CE24 */ .asciz "CORV"
    /* 434F525600000000 */
.align 2
enddlabel D_8013CE24

.align 2
nonmatching D_8013CE2C

dlabel D_8013CE2C
    /* 12D62C 8013CE2C */ .asciz "chvcor."
    /* 636876636F722E00 */
.align 2
enddlabel D_8013CE2C

.align 2
nonmatching D_8013CE34

dlabel D_8013CE34
    /* 12D634 8013CE34 */ .asciz "corv."
    /* 636F72762E000000 */
.align 2
enddlabel D_8013CE34

.align 2
nonmatching D_8013CE3C

dlabel D_8013CE3C
    /* 12D63C 8013CE3C */ .asciz "P993"
    /* 5039393300000000 */
.align 2
enddlabel D_8013CE3C

.align 2
nonmatching D_8013CE44

dlabel D_8013CE44
    /* 12D644 8013CE44 */ .asciz "por911."
    /* 706F723931312E00 */
.align 2
enddlabel D_8013CE44

.align 2
nonmatching D_8013CE4C

dlabel D_8013CE4C
    /* 12D64C 8013CE4C */ .asciz "porsc."
    /* 706F7273632E0000 */
.align 2
enddlabel D_8013CE4C

.align 2
nonmatching D_8013CE54

dlabel D_8013CE54
    /* 12D654 8013CE54 */ .asciz "DIAB"
    /* 4449414200000000 */
.align 2
enddlabel D_8013CE54

.align 2
nonmatching D_8013CE5C

dlabel D_8013CE5C
    /* 12D65C 8013CE5C */ .asciz "lamdia."
    /* 6C616D6469612E00 */
.align 2
enddlabel D_8013CE5C

.align 2
nonmatching D_8013CE64

dlabel D_8013CE64
    /* 12D664 8013CE64 */ .asciz "lamb."
    /* 6C616D622E000000 */
.align 2
enddlabel D_8013CE64

.align 2
nonmatching D_8013CE6C

dlabel D_8013CE6C
    /* 12D66C 8013CE6C */ .asciz "dia."
    /* 6469612E00000000 */
.align 2
enddlabel D_8013CE6C

.align 2
nonmatching D_8013CE74

dlabel D_8013CE74
    /* 12D674 8013CE74 */ .asciz "MCF1"
    /* 4D43463100000000 */
.align 2
enddlabel D_8013CE74

.align 2
nonmatching D_8013CE7C

dlabel D_8013CE7C
    /* 12D67C 8013CE7C */ .asciz "mclar."
    /* 6D636C61722E0000 */
.align 2
enddlabel D_8013CE7C

.align 2
nonmatching D_8013CE84

dlabel D_8013CE84
    /* 12D684 8013CE84 */ .asciz "X993"
    /* 5839393300000000 */
.align 2
enddlabel D_8013CE84

.align 2
nonmatching D_8013CE8C

dlabel D_8013CE8C
    /* 12D68C 8013CE8C */ .asciz "XCF1"
    /* 5843463100000000 */
.align 2
enddlabel D_8013CE8C

.align 2
nonmatching D_8013CE94

dlabel D_8013CE94
    /* 12D694 8013CE94 */ .asciz "sport."
    /* 73706F72742E0000 */
.align 2
enddlabel D_8013CE94

.align 2
nonmatching D_8013CE9C

dlabel D_8013CE9C
    /* 12D69C 8013CE9C */ .asciz "cab."
    /* 6361622E00000000 */
.align 2
enddlabel D_8013CE9C

.align 2
nonmatching D_8013CEA4

dlabel D_8013CEA4
    /* 12D6A4 8013CEA4 */ .asciz "baov."
    /* 62616F762E000000 */
.align 2
enddlabel D_8013CEA4

.align 2
nonmatching D_8013CEAC

dlabel D_8013CEAC
    /* 12D6AC 8013CEAC */ .asciz "tun."
    /* 74756E2E00000000 */
.align 2
enddlabel D_8013CEAC

.align 2
nonmatching D_8013CEB4

dlabel D_8013CEB4
    /* 12D6B4 8013CEB4 */ .asciz "scrv."
    /* 736372762E000000 */
.align 2
enddlabel D_8013CEB4

.align 2
nonmatching D_8013CEBC

dlabel D_8013CEBC
    /* 12D6BC 8013CEBC */ .asciz "twr."
    /* 7477722E00000000 */
.align 2
enddlabel D_8013CEBC

.align 2
nonmatching D_8013CEC4

dlabel D_8013CEC4
    /* 12D6C4 8013CEC4 */ .asciz "brg."
    /* 6272672E00000000 */
.align 2
enddlabel D_8013CEC4

.align 2
nonmatching D_8013CECC

dlabel D_8013CECC
    /* 12D6CC 8013CECC */ .asciz "frm."
    /* 66726D2E00000000 */
.align 2
enddlabel D_8013CECC

.align 2
nonmatching D_8013CED4

dlabel D_8013CED4
    /* 12D6D4 8013CED4 */ .asciz "pike."
    /* 70696B652E000000 */
.align 2
enddlabel D_8013CED4

.align 2
nonmatching D_8013CEDC

dlabel D_8013CEDC
    /* 12D6DC 8013CEDC */ .asciz "ltun."
    /* 6C74756E2E000000 */
.align 2
enddlabel D_8013CEDC

.align 2
nonmatching D_8013CEE4

dlabel D_8013CEE4
    /* 12D6E4 8013CEE4 */ .asciz "icec."
    /* 696365632E000000 */
.align 2
enddlabel D_8013CEE4

.align 2
nonmatching D_8013CEEC

dlabel D_8013CEEC
    /* 12D6EC 8013CEEC */ .asciz "mar."
    /* 6D61722E00000000 */
.align 2
enddlabel D_8013CEEC

.align 2
nonmatching D_8013CEF4

dlabel D_8013CEF4
    /* 12D6F4 8013CEF4 */ .asciz "bay."
    /* 6261792E00000000 */
.align 2
enddlabel D_8013CEF4

.align 2
nonmatching D_8013CEFC

dlabel D_8013CEFC
    /* 12D6FC 8013CEFC */ .asciz "rarc."
    /* 726172632E000000 */
.align 2
enddlabel D_8013CEFC

.align 2
nonmatching D_8013CF04

dlabel D_8013CF04
    /* 12D704 8013CF04 */ .asciz "lth."
    /* 6C74682E00000000 */
.align 2
enddlabel D_8013CF04

.align 2
nonmatching D_8013CF0C

dlabel D_8013CF0C
    /* 12D70C 8013CF0C */ .asciz "ruin."
    /* 7275696E2E000000 */
.align 2
enddlabel D_8013CF0C

.align 2
nonmatching D_8013CF14

dlabel D_8013CF14
    /* 12D714 8013CF14 */ .asciz "spfl."
    /* 7370666C2E000000 */
.align 2
enddlabel D_8013CF14

.align 2
nonmatching D_8013CF1C

dlabel D_8013CF1C
    /* 12D71C 8013CF1C */ .asciz "tbrg."
    /* 746272672E000000 */
.align 2
enddlabel D_8013CF1C

.align 2
nonmatching D_8013CF24

dlabel D_8013CF24
    /* 12D724 8013CF24 */ .asciz "bgdr."
    /* 626764722E000000 */
.align 2
enddlabel D_8013CF24

.align 2
nonmatching D_8013CF2C

dlabel D_8013CF2C
    /* 12D72C 8013CF2C */ .asciz "over."
    /* 6F7665722E000000 */
.align 2
enddlabel D_8013CF2C

.align 2
nonmatching D_8013CF34

dlabel D_8013CF34
    /* 12D734 8013CF34 */ .asciz "fld."
    /* 666C642E00000000 */
.align 2
enddlabel D_8013CF34

.align 2
nonmatching D_8013CF3C

dlabel D_8013CF3C
    /* 12D73C 8013CF3C */ .asciz "stun."
    /* 7374756E2E000000 */
.align 2
enddlabel D_8013CF3C

.align 2
nonmatching D_8013CF44

dlabel D_8013CF44
    /* 12D744 8013CF44 */ .asciz "htou."
    /* 68746F752E000000 */
.align 2
enddlabel D_8013CF44

.align 2
nonmatching D_8013CF4C

dlabel D_8013CF4C
    /* 12D74C 8013CF4C */ .asciz "ogt."
    /* 6F67742E00000000 */
.align 2
enddlabel D_8013CF4C

.align 2
nonmatching D_8013CF54

dlabel D_8013CF54
    /* 12D754 8013CF54 */ .asciz "trnx."
    /* 74726E782E000000 */
.align 2
enddlabel D_8013CF54

.align 2
nonmatching D_8013CF5C

dlabel D_8013CF5C
    /* 12D75C 8013CF5C */ .asciz "lsp."
    /* 6C73702E00000000 */
.align 2
enddlabel D_8013CF5C

.align 2
nonmatching D_8013CF64

dlabel D_8013CF64
    /* 12D764 8013CF64 */ .asciz "hsv."
    /* 6873762E00000000 */
.align 2
enddlabel D_8013CF64

.align 2
nonmatching D_8013CF6C

dlabel D_8013CF6C
    /* 12D76C 8013CF6C */ .asciz "pent."
    /* 70656E742E000000 */
.align 2
enddlabel D_8013CF6C

.align 2
nonmatching D_8013CF74

dlabel D_8013CF74
    /* 12D774 8013CF74 */ .asciz "wfrm."
    /* 7766726D2E000000 */
.align 2
enddlabel D_8013CF74

.align 2
nonmatching D_8013CF7C

dlabel D_8013CF7C
    /* 12D77C 8013CF7C */ .asciz "owel."
    /* 6F77656C2E000000 */
.align 2
enddlabel D_8013CF7C

.align 2
nonmatching D_8013CF84

dlabel D_8013CF84
    /* 12D784 8013CF84 */ .asciz "toll."
    /* 746F6C6C2E000000 */
.align 2
enddlabel D_8013CF84

.align 2
nonmatching D_8013CF8C

dlabel D_8013CF8C
    /* 12D78C 8013CF8C */ .asciz "obwm."
    /* 6F62776D2E000000 */
.align 2
enddlabel D_8013CF8C

.align 2
nonmatching D_8013CF94

dlabel D_8013CF94
    /* 12D794 8013CF94 */ .asciz "vill."
    /* 76696C6C2E000000 */
.align 2
enddlabel D_8013CF94

.align 2
nonmatching D_8013CF9C

dlabel D_8013CF9C
    /* 12D79C 8013CF9C */ .asciz "omus."
    /* 6F6D75732E000000 */
.align 2
enddlabel D_8013CF9C

.align 2
nonmatching D_8013CFA4

dlabel D_8013CFA4
    /* 12D7A4 8013CFA4 */ .asciz "kngm."
    /* 6B6E676D2E000000 */
.align 2
enddlabel D_8013CFA4

.align 2
nonmatching D_8013CFAC

dlabel D_8013CFAC
    /* 12D7AC 8013CFAC */ .asciz "hpin."
    /* 6870696E2E000000 */
.align 2
enddlabel D_8013CFAC

.align 2
nonmatching D_8013CFB4

dlabel D_8013CFB4
    /* 12D7B4 8013CFB4 */ .asciz "arch."
    /* 617263682E000000 */
.align 2
enddlabel D_8013CFB4

.align 2
nonmatching D_8013CFBC

dlabel D_8013CFBC
    /* 12D7BC 8013CFBC */ .asciz "medi."
    /* 6D6564692E000000 */
.align 2
enddlabel D_8013CFBC

.align 2
nonmatching D_8013CFC4

dlabel D_8013CFC4
    /* 12D7C4 8013CFC4 */ .asciz "farm."
    /* 6661726D2E000000 */
.align 2
enddlabel D_8013CFC4

.align 2
nonmatching D_8013CFCC

dlabel D_8013CFCC
    /* 12D7CC 8013CFCC */ .asciz "all."
    /* 616C6C2E00000000 */
.align 2
enddlabel D_8013CFCC

.align 2
nonmatching D_8013CFD4

dlabel D_8013CFD4
    /* 12D7D4 8013CFD4 */ .asciz "dis."
    /* 6469732E00000000 */
.align 2
enddlabel D_8013CFD4

.align 2
nonmatching D_8013CFDC

dlabel D_8013CFDC
    /* 12D7DC 8013CFDC */ .asciz "cen."
    /* 63656E2E00000000 */
.align 2
enddlabel D_8013CFDC

.align 2
nonmatching D_8013CFE4

dlabel D_8013CFE4
    /* 12D7E4 8013CFE4 */ .asciz "cont."
    /* 636F6E742E000000 */
.align 2
enddlabel D_8013CFE4

.align 2
nonmatching D_8013CFEC

dlabel D_8013CFEC
    /* 12D7EC 8013CFEC */ .asciz "hq."
    /* 68712E00 */
.align 2
enddlabel D_8013CFEC

.align 2
nonmatching D_8013CFF0

dlabel D_8013CFF0
    /* 12D7F0 8013CFF0 */ .asciz "cou."
    /* 636F752E00000000 */
.align 2
enddlabel D_8013CFF0

.align 2
nonmatching D_8013CFF8

dlabel D_8013CFF8
    /* 12D7F8 8013CFF8 */ .asciz "20."
    /* 32302E00 */
.align 2
enddlabel D_8013CFF8

.align 2
nonmatching D_8013CFFC

dlabel D_8013CFFC
    /* 12D7FC 8013CFFC */ .asciz "25."
    /* 32352E00 */
.align 2
enddlabel D_8013CFFC

.align 2
nonmatching D_8013D000

dlabel D_8013D000
    /* 12D800 8013D000 */ .asciz "31."
    /* 33312E00 */
.align 2
enddlabel D_8013D000

.align 2
nonmatching D_8013D004

dlabel D_8013D004
    /* 12D804 8013D004 */ .asciz "37."
    /* 33372E00 */
.align 2
enddlabel D_8013D004

.align 2
nonmatching D_8013D008

dlabel D_8013D008
    /* 12D808 8013D008 */ .asciz "38."
    /* 33382E00 */
.align 2
enddlabel D_8013D008

.align 2
nonmatching D_8013D00C

dlabel D_8013D00C
    /* 12D80C 8013D00C */ .asciz "43."
    /* 34332E00 */
.align 2
enddlabel D_8013D00C

.align 2
nonmatching D_8013D010

dlabel D_8013D010
    /* 12D810 8013D010 */ .asciz "45."
    /* 34352E00 */
.align 2
enddlabel D_8013D010

.align 2
nonmatching D_8013D014

dlabel D_8013D014
    /* 12D814 8013D014 */ .asciz "46."
    /* 34362E00 */
.align 2
enddlabel D_8013D014

.align 2
nonmatching D_8013D018

dlabel D_8013D018
    /* 12D818 8013D018 */ .asciz "52."
    /* 35322E00 */
.align 2
enddlabel D_8013D018

.align 2
nonmatching D_8013D01C

dlabel D_8013D01C
    /* 12D81C 8013D01C */ .asciz "217."
    /* 3231372E00000000 */
.align 2
enddlabel D_8013D01C

.align 2
nonmatching D_8013D024

dlabel D_8013D024
    /* 12D824 8013D024 */ .asciz "223."
    /* 3232332E00000000 */
.align 2
enddlabel D_8013D024

.align 2
nonmatching D_8013D02C

dlabel D_8013D02C
    /* 12D82C 8013D02C */ .asciz "316."
    /* 3331362E00000000 */
.align 2
enddlabel D_8013D02C

.align 2
nonmatching D_8013D034

dlabel D_8013D034
    /* 12D834 8013D034 */ .asciz "332."
    /* 3333322E00000000 */
.align 2
enddlabel D_8013D034

.align 2
nonmatching D_8013D03C

dlabel D_8013D03C
    /* 12D83C 8013D03C */ .asciz "355."
    /* 3335352E00000000 */
.align 2
enddlabel D_8013D03C

.align 2
nonmatching D_8013D044

dlabel D_8013D044
    /* 12D844 8013D044 */ .asciz "371."
    /* 3337312E00000000 */
.align 2
enddlabel D_8013D044

.align 2
nonmatching D_8013D04C

dlabel D_8013D04C
    /* 12D84C 8013D04C */ .asciz "j:id\\"
    /* 6A3A69645C000000 */
.align 2
enddlabel D_8013D04C

.align 2
nonmatching D_8013D054

dlabel D_8013D054
    /* 12D854 8013D054 */ .asciz "j:cars\\"
    /* 6A3A636172735C00 */
.align 2
enddlabel D_8013D054

.align 2
nonmatching D_8013D05C

dlabel D_8013D05C
    /* 12D85C 8013D05C */ .asciz "j:cid\\"
    /* 6A3A6369645C0000 */
.align 2
enddlabel D_8013D05C

.align 2
nonmatching D_8013D064

dlabel D_8013D064
    /* 12D864 8013D064 */ .asciz "j:clip."
    /* 6A3A636C69702E00 */
.align 2
enddlabel D_8013D064

.align 2
nonmatching D_8013D06C

dlabel D_8013D06C
    /* 12D86C 8013D06C */ .asciz "fre"
    /* 66726500 */
.align 2
enddlabel D_8013D06C

.align 2
nonmatching D_8013D070

dlabel D_8013D070
    /* 12D870 8013D070 */ .asciz "ger"
    /* 67657200 */
.align 2
enddlabel D_8013D070

.align 2
nonmatching D_8013D074

dlabel D_8013D074
    /* 12D874 8013D074 */ .asciz "brt"
    /* 62727400 */
.align 2
enddlabel D_8013D074

.align 2
nonmatching D_8013D078

dlabel D_8013D078
    /* 12D878 8013D078 */ .asciz "eng"
    /* 656E6700 */
.align 2
enddlabel D_8013D078
