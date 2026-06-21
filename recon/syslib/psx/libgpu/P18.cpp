/* syslib/psx/libgpu/P18.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgpu.lib(P18.OBJ): SetPolyG4 @0x800F3630.  Initialises a primitive tag: length byte
 *   (offset 3) = 8 words, GPU code byte (offset 7) = 0x38.  [libgpu.h] */
extern "C" void SetPolyG4(void *p)   /* @0x800F3630 */
{
    ((char *)p)[3] = 8;
    ((char *)p)[7] = (char)0x38;
}
