/* syslib/psx/libgpu/P11.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgpu.lib(P11.OBJ): SetShadeTex @0x800F611C.  Sets/clears the texture-without-shading
 *   bit (0x01) in a primitive's code byte at offset 7. */
extern void SetShadeTex(void *p, int tge)   /* @0x800F611C */
{
    unsigned char *b = (unsigned char *)p;
    unsigned char v;
    if (tge) v = (unsigned char)(b[7] | 0x01);
    else     v = (unsigned char)(b[7] & 0xfe);
    b[7] = v;
}
