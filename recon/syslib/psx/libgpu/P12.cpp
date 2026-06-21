/* syslib/psx/libgpu/P12.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgpu.lib(P12.OBJ): SetPolyF3 @0x800F35F0.  Initialises a primitive tag: length byte
 *   (offset 3) = 4 words, GPU code byte (offset 7) = 0x20.  [libgpu.h] */
extern "C" void SetPolyF3(void *p)   /* @0x800F35F0 */
{
    ((char *)p)[3] = 4;
    ((char *)p)[7] = (char)0x20;
}
