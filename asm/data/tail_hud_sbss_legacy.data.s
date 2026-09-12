.include "macro.inc"
/* P910 oracle-only zero-transport bytes for native HUD .sbss76.
 * Original tail_after_simqueue offsets0x2C..0x78, native8013DE00..DE4C.
 * No CPE load covers these bytes; source owner is genuine NOBITS.
 * Keep original raw labels for the oracle lane; recon owns one LOCAL block. */
.section .data, "wa"

nonmatching D_8013DE00

dlabel D_8013DE00
    /* 12E600 8013DE00 00000000 */ .word 0x00000000
enddlabel D_8013DE00

nonmatching g1Player

dlabel g1Player
    /* 12E604 8013DE04 00000000 */ .word 0x00000000
enddlabel g1Player

nonmatching gSprite0

dlabel gSprite0
    /* 12E608 8013DE08 00000000 */ .word 0x00000000
enddlabel gSprite0

nonmatching gSprite1

dlabel gSprite1
    /* 12E60C 8013DE0C 00000000 */ .word 0x00000000
enddlabel gSprite1

nonmatching D_8013DE10

dlabel D_8013DE10
    /* 12E610 8013DE10 */ .byte 0x00
    /* 12E611 8013DE11 */ .byte 0x00
    /* 12E612 8013DE12 */ .byte 0x00
    /* 12E613 8013DE13 */ .byte 0x00
enddlabel D_8013DE10

nonmatching currentSpriteColor

dlabel currentSpriteColor
    /* 12E614 8013DE14 00000000 */ .word 0x00000000
enddlabel currentSpriteColor

nonmatching HudSplitTimeDiff1

dlabel HudSplitTimeDiff1
    /* 12E618 8013DE18 00000000 */ .word 0x00000000
    /* 12E61C 8013DE1C 00000000 */ .word 0x00000000
enddlabel HudSplitTimeDiff1

nonmatching HudSplitTimeDiff2

dlabel HudSplitTimeDiff2
    /* 12E620 8013DE20 00000000 */ .word 0x00000000
    /* 12E624 8013DE24 00000000 */ .word 0x00000000
enddlabel HudSplitTimeDiff2

nonmatching D_8013DE28

dlabel D_8013DE28
    /* 12E628 8013DE28 00000000 */ .word 0x00000000
enddlabel D_8013DE28

nonmatching D_8013DE2C

dlabel D_8013DE2C
    /* 12E62C 8013DE2C 00000000 */ .word 0x00000000
enddlabel D_8013DE2C

nonmatching D_8013DE30

dlabel D_8013DE30
    /* 12E630 8013DE30 00000000 */ .word 0x00000000
    /* 12E634 8013DE34 00000000 */ .word 0x00000000
enddlabel D_8013DE30

nonmatching PerpOverlayOn

dlabel PerpOverlayOn
    /* 12E638 8013DE38 00000000 */ .word 0x00000000
enddlabel PerpOverlayOn

nonmatching D_8013DE3C

dlabel D_8013DE3C
    /* 12E63C 8013DE3C 00000000 */ .word 0x00000000
enddlabel D_8013DE3C

nonmatching PerpOverlayMessage

dlabel PerpOverlayMessage
    /* 12E640 8013DE40 00000000 */ .word 0x00000000
    /* 12E644 8013DE44 00000000 */ .word 0x00000000
enddlabel PerpOverlayMessage

nonmatching D_8013DE48

dlabel D_8013DE48
    /* 12E648 8013DE48 00000000 */ .word 0x00000000
enddlabel D_8013DE48
