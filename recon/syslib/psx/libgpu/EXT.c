/* syslib/psx/libgpu/EXT.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libgpu.lib(EXT.OBJ): the DRAWENV / DISPENV default initialisers.  [libgpu.h] */

typedef unsigned char u_char;
typedef unsigned short u_short;
typedef unsigned long u_long;

extern int GetVideoMode(void);   /* libetc VMODE.obj */

typedef struct {
    short x, y;
    short w, h;
} RECT;

typedef struct {
    u_long tag;
    u_long code[15];
} DR_ENV;

typedef struct {
    RECT clip;
    short ofs[2];
    RECT tw;
    u_short tpage;
    u_char dtd;
    u_char dfe;
    u_char isbg;
    u_char r0, g0, b0;
    DR_ENV dr_env;
} DRAWENV;

typedef struct {
    RECT disp;
    RECT screen;
    u_char isinter;
    u_char isrgb24;
    u_char pad0, pad1;
} DISPENV;

/* @0x800F222C : fill a DRAWENV with a sensible default (clip rect x,y,w,h; dither on; draw-to-
 *   display chosen by mode-dependent height threshold; default tpage = 10; no background fill). */
DRAWENV *SetDefDrawEnv(DRAWENV *env, int x, int y, int w, int h)
{
    int vm = GetVideoMode();
    env->clip.x = (short)x;
    env->clip.y = (short)y;
    env->clip.w = (short)w;
    env->tw.x = 0;
    env->tw.y = 0;
    env->tw.w = 0;
    env->tw.h = 0;
    env->r0 = 0;
    env->g0 = 0;
    env->b0 = 0;
    env->dtd = 1;
    env->clip.h = (short)h;
    env->dfe = (u_char)(vm != 0 ? (h < 0x121) : (h < 0x101));
    env->ofs[0] = (short)x;
    env->ofs[1] = (short)y;
    env->tpage = 10;
    env->isbg = 0;
    return env;
}

/* @0x800F22E0 : fill a DISPENV with a default display area (x,y,w,h) and zeroed screen offset. */
DISPENV *SetDefDispEnv(DISPENV *env, int x, int y, int w, int h)
{
    env->disp.x = (short)x;
    env->disp.y = (short)y;
    env->disp.w = (short)w;
    env->screen.x = 0;
    env->screen.y = 0;
    env->screen.w = 0;
    env->screen.h = 0;
    env->isrgb24 = 0;
    env->isinter = 0;
    env->pad1 = 0;
    env->pad0 = 0;
    env->disp.h = (short)h;
    return env;
}
