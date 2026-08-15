/* syslib/psx/libgpu/P16.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgpu.lib(P16.OBJ): SetPolyF4 @0x800F3610.  Initialises a primitive tag: length byte
 *   (offset 3) = 5 words, GPU code byte (offset 7) = 0x28.  [libgpu.h] */
extern void SetPolyF4(void *p)   /* @0x800F3610 */
{
    ((char *)p)[3] = 5;
    ((char *)p)[7] = (char)0x28;
}
