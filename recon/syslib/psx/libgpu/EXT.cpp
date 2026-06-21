/* syslib/psx/libgpu/EXT.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libgpu.lib(EXT.OBJ): the DRAWENV / DISPENV default initialisers.  [libgpu.h] */

typedef unsigned char u_char;

extern "C" int GetVideoMode(void);   /* libetc VMODE.obj */

/* @0x800F222C : fill a DRAWENV with a sensible default (clip rect x,y,w,h; dither on; draw-to-
 *   display chosen by mode-dependent height threshold; default tpage = 10; no background fill). */
struct DRAWENV {                      /* PsyQ DRAWENV (relevant fields) */
    short clipx, clipy, clipw, cliph; /* +0x00 clip RECT */
    short ofsx, ofsy;                 /* +0x08 ofs[0],ofs[1] */
    short twx, twy, tww, twh;         /* +0x0C tw RECT */
    short tpage;                      /* +0x14 */
    u_char dtd;                       /* +0x16 */
    u_char dfe;                       /* +0x17 */
    u_char isbg;                      /* +0x18 */
    u_char bg0, bg1, bg2;             /* +0x19 r0,g0,b0 */
};

extern "C" void *SetDefDrawEnv(void *env, int x, int y, int w, int h)
{
    DRAWENV *e = (DRAWENV *)env;
    int vm = GetVideoMode();
    e->clipx = (short)x;
    e->clipy = (short)y;
    e->clipw = (short)w;
    e->twx = 0;
    e->twy = 0;
    e->tww = 0;
    e->twh = 0;
    e->bg0 = 0;
    e->bg1 = 0;
    e->bg2 = 0;
    e->dtd = 1;
    e->cliph = (short)h;
    e->dfe = (u_char)(vm != 0 ? (h < 0x121) : (h < 0x101));
    ((DRAWENV *)env)->ofsx = (short)x;
    ((DRAWENV *)env)->ofsy = (short)y;
    ((DRAWENV *)env)->tpage = 10;
    ((DRAWENV *)env)->isbg = 0;
    return env;
}

/* @0x800F22E0 : fill a DISPENV with a default display area (x,y,w,h) and zeroed screen offset. */
extern "C" void *SetDefDispEnv(void *env, int x, int y, int w, int h)
{
    short *es = (short *)env;
    u_char *eb = (u_char *)env;
    es[0] = (short)x;                 /* disp.x (+0)  */
    es[1] = (short)y;                 /* disp.y (+2)  */
    es[2] = (short)w;                 /* disp.w (+4)  */
    es[4] = 0;                        /* (+8)   */
    es[5] = 0;                        /* (+0xA) */
    es[6] = 0;                        /* (+0xC) */
    es[7] = 0;                        /* (+0xE) */
    eb[0x11] = 0;                     /* isinter */
    eb[0x10] = 0;
    eb[0x13] = 0;                     /* isrgb24 */
    eb[0x12] = 0;
    es[3] = (short)h;                 /* disp.h (+6) */
    return env;
}
