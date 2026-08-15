/* syslib/psx/libgpu/P00.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgpu.lib(P00.OBJ): GetTPage @0x800F1BFC.  Packs a texture-page id from
 *   (texture-mode, semi-transparency-mode, framebuffer x/y).  [libgpu.h] */
extern unsigned short GetTPage(int tp, int abr, int x, int y)   /* @0x800F1BFC */
{
    return (unsigned short)(((tp & 0x3) << 7) | ((abr & 0x3) << 5)
                          | ((y & 0x100) >> 4) | ((x & 0x3ff) >> 6)
                          | ((y & 0x200) << 2));
}
