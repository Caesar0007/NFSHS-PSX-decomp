/* syslib/psx/libgpu/P17.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgpu.lib(P17.OBJ): SetPolyFT4 @0x800F3650.  Initialises a primitive tag: length byte
 *   (offset 3) = 9 words, GPU code byte (offset 7) = 0x2C.  [libgpu.h] */
extern "C" void SetPolyFT4(void *p)   /* @0x800F3650 */
{
    ((char *)p)[3] = 9;
    ((char *)p)[7] = (char)0x2C;
}
