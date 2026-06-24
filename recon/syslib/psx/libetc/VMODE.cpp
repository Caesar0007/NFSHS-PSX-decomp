/* syslib/psx/libetc/VMODE.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3; IDA mis-decompiled BOTH fns via
 *   its "write to const memory" const-folding bug -> disasm is authoritative).
 *   obj VMODE.obj ; libetc.lib.  SetVideoMode @0x800F1770 (returns the PREVIOUS mode, stores new in the
 *   jr delay slot), GetVideoMode @0x800F1784 (returns current).  Backed by g_videomode @0x80134838.
 */
extern "C" int g_videomode = 0;   /* @0x80134838 : 0=NTSC, 1=PAL */

extern "C" int SetVideoMode(int mode)   /* @0x800F1770 */
{
    int old = g_videomode;
    g_videomode = mode;
    return old;
}

extern "C" int GetVideoMode(void)   /* @0x800F1784 */
{
    return g_videomode;
}
