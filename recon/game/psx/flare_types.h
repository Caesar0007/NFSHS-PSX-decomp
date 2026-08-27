/* flare.obj's exact source-visible type surface reconstructed from SYM.
 * Its shared game graph is the already-exact color.obj surface; the records
 * below are precisely the named delta retained by the standalone flare owner. */
#ifndef NFS4_GAME_PSX_FLARE_TYPES_H
#define NFS4_GAME_PSX_FLARE_TYPES_H

#include "../common/color_types.h"

#define Render_gPacketPtr  (*(u_char **)0x1F800004)
#define Render_gPalettePtr (*(u_char **)0x1F800000)

struct TCB { long status, mode; u_long reg[40]; long system[6]; };
struct EXEC {
    u_long pc0, gp0, t_addr, t_size, d_addr, d_size, b_addr, b_size;
    u_long s_addr, s_size, sp, fp, gp, ret, base;
};
struct DIRENTRY {
    char name[20]; long attr, size; DIRENTRY *next; long head; char system[4];
};

struct POLY_F4 {
    u_long tag; u_char r0,g0,b0,code;
    short x0,y0,x1,y1,x2,y2,x3,y3;
};
struct POLY_FT4 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char u0,v0; u_short clut;
    short x1,y1; u_char u1,v1; u_short tpage; short x2,y2; u_char u2,v2;
    u_short pad1; short x3,y3; u_char u3,v3; u_short pad2;
};
struct POLY_G3 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char r1,g1,b1,pad1;
    short x1,y1; u_char r2,g2,b2,pad2; short x2,y2;
};
struct POLY_G4 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char r1,g1,b1,pad1;
    short x1,y1; u_char r2,g2,b2,pad2; short x2,y2; u_char r3,g3,b3,pad3;
    short x3,y3;
};
struct LINE_G2 {
    u_long tag; u_char r0,g0,b0,code; short x0,y0; u_char r1,g1,b1,p1;
    short x1,y1;
};

struct DRender_tView { int id, player; DRender_tCalcView cview; };
struct Draw_FlareCache { Draw_tCacheHeader head; };
struct Sched_tSchedule {
    int maxNumFunctions, numFunctions;
    Sched_tFunctionSchedule func[1];
};

typedef enum forceFocus_t {
    FOCUS_NORMAL = 0, FOCUS_AI = 1, FOCUS_COPANDAI = 2
} forceFocus_t;

struct FLARE_PIECE_DEF { int distance,size; CVECTOR color; char type; };
struct FLARE_DEF {
    DVECTOR pos[2], oldpos[2];
    u_short screenData[2][5][5];
    int size;
    FLARE_PIECE_DEF *piece;
    char isDrawn[2];
};
struct Flare_tInfo { u_long chalo,cbeam; int scale,flags; };

struct CHorizonSpec {
    int mirror,angle,yoffset,height;
    CVECTOR frontColor[2],backColor[2];
    char ringPMX[16];
};
struct CSkySpec {
    int type,flags; CVECTOR frontcolors[5],backcolors[5],clearcolor;
    int sunAngleInSky,sunHeightInSky,moonAngleInSky,moonHeightInSky;
    int numStars,starAngleLow,starAngleHigh,starBrightMin,starBrightMax;
    CVECTOR starBaseColor; int starRandomSeed; CVECTOR sunBeamColor,sunHaloColor;
    int yoffset; char cloudIndices[5][4]; int ringAngles[5];
};
struct CNightSpec { CVECTOR nightcolor; };
struct CWeatherSpec { int type,intensity_limit; };
struct CFogSpec { int contrast; CVECTOR color; int start,dist2base; };
struct CDepthCueSpec { CVECTOR color; int distance; };
struct CWorldColor {
    int contrast; CVECTOR contrast_color; short worldR,worldG,worldB,type;
};

#endif
