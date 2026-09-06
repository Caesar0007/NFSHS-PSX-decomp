.include "macro.inc"
/* P882: unchanged residual 0x8013D3C0..0x8013D3EC from r13.
 * R3DCar's preceding 0x9C-byte source-owned span is selected separately. */

.section .sdata, "wa"

nonmatching Render_gBlurEffectDepth1

dlabel Render_gBlurEffectDepth1
    /* 12DBC0 8013D3C0 00000000 */ .word 0x00000000
enddlabel Render_gBlurEffectDepth1

nonmatching Render_gBlurEffectDepth2

dlabel Render_gBlurEffectDepth2
    /* 12DBC4 8013D3C4 00000000 */ .word 0x00000000
enddlabel Render_gBlurEffectDepth2

nonmatching Render_gBlurEffectMode

dlabel Render_gBlurEffectMode
    /* 12DBC8 8013D3C8 00000000 */ .word 0x00000000
enddlabel Render_gBlurEffectMode

nonmatching Draw_gPlayer1View

dlabel Draw_gPlayer1View
    /* 12DBCC 8013D3CC 00000000 */ .word 0x00000000
enddlabel Draw_gPlayer1View

nonmatching Draw_gPlayer2View

dlabel Draw_gPlayer2View
    /* 12DBD0 8013D3D0 00000000 */ .word 0x00000000
enddlabel Draw_gPlayer2View

nonmatching gPauseMenuRect

dlabel gPauseMenuRect
    /* 12DBD4 8013D3D4 */ .short 0x0000
enddlabel gPauseMenuRect

nonmatching D_8013D3D6

dlabel D_8013D3D6
    /* 12DBD6 8013D3D6 */ .short 0x0000
enddlabel D_8013D3D6

nonmatching D_8013D3D8

dlabel D_8013D3D8
    /* 12DBD8 8013D3D8 */ .short 0x0000
enddlabel D_8013D3D8

nonmatching D_8013D3DA

dlabel D_8013D3DA
    /* 12DBDA 8013D3DA */ .short 0x0000
enddlabel D_8013D3DA

nonmatching gPauseRender

dlabel gPauseRender
    /* 12DBDC 8013D3DC 00000000 */ .word 0x00000000
enddlabel gPauseRender

nonmatching Draw_gRearView

dlabel Draw_gRearView
    /* 12DBE0 8013D3E0 00000000 */ .word 0x00000000
enddlabel Draw_gRearView

nonmatching Render_gDebugView

dlabel Render_gDebugView
    /* 12DBE4 8013D3E4 00000000 */ .word 0x00000000
enddlabel Render_gDebugView

nonmatching Render_gPauseMenuView

dlabel Render_gPauseMenuView
    /* 12DBE8 8013D3E8 00000000 */ .word 0x00000000
enddlabel Render_gPauseMenuView
