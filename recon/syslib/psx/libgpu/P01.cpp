/* syslib/psx/libgpu/P01.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgpu.lib(P01.OBJ): GetClut @0x800F4450.  Packs a CLUT id from framebuffer x/y. */
extern "C" unsigned short GetClut(int x, int y)   /* @0x800F4450 */
{
    return (unsigned short)((y << 6) | ((x >> 4) & 0x3f));
}
