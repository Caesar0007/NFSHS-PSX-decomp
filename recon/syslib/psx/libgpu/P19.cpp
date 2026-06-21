/* syslib/psx/libgpu/P19.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgpu.lib(P19.OBJ): SetPolyGT4 @0x800F3490.  Initialises a primitive tag: length byte
 *   (offset 3) = 0xC words, GPU code byte (offset 7) = 0x3C.  [libgpu.h] */
extern "C" void SetPolyGT4(void *p)   /* @0x800F3490 */
{
    ((char *)p)[3] = 0xC;
    ((char *)p)[7] = (char)0x3C;
}
