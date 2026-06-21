/* syslib/psx/libgpu/EXT.cpp -- RECONSTRUCTED from nfs4-f.exe (Ghidra + disasm-v3).
 *   obj libgpu.lib(EXT.OBJ): the DRAWENV / DISPENV default initialisers.  [libgpu.h] */

typedef unsigned char u_char;

extern "C" int GetVideoMode(void);   /* libetc VMODE.obj */

/* @0x800F222C : fill a DRAWENV with a sensible default (clip rect x,y,w,h; dither on; draw-to-
 *   display chosen by mode-dependent height threshold; default tpage = 10; no background fill). */
extern "C" void *SetDefDrawEnv(void *env, int x, int y, int w, int h)
{
    short *es = (short *)env;
    u_char *eb = (u_char *)env;
    int vm = GetVideoMode();
    es[0] = (short)x;                 /* clip.x  (+0)  */
    es[1] = (short)y;                 /* clip.y  (+2)  */
    es[2] = (short)w;                 /* clip.w  (+4)  */
    es[6] = 0;                        /* ofs[0]? (+0xC)*/
    es[7] = 0;                        /*         (+0xE)*/
    *(short *)(eb + 0x10) = 0;
    *(short *)(eb + 0x12) = 0;
    eb[0x19] = 0;                     /* bg r */
    eb[0x1a] = 0;                     /* bg g */
    eb[0x1b] = 0;                     /* bg b */
    eb[0x16] = 1;                     /* dtd (dither) */
    es[3] = (short)h;                 /* clip.h  (+6)  */
    eb[0x17] = (u_char)(vm == 0 ? (h < 0x101) : (h < 0x121));   /* dfe */
    es[4] = (short)x;                 /* draw offset x (+8)  */
    es[5] = (short)y;                 /*             y (+0xA)*/
    *(short *)(eb + 0x14) = 10;       /* default tpage */
    eb[0x18] = 0;                     /* isbg = 0 */
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
