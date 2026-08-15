/* syslib/psx/libgpu/P10.c -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgpu.lib(P10.OBJ): SetSemiTrans @0x800F30FC.  Sets/clears the semi-transparency
 *   bit (0x02) in a primitive's code byte at offset 7. */
extern void SetSemiTrans(void *p, int abe)   /* @0x800F30FC */
{
    unsigned char *b = (unsigned char *)p;
    unsigned char v;
    if (abe) v = (unsigned char)(b[7] | 0x02);
    else     v = (unsigned char)(b[7] & 0xfd);
    b[7] = v;
}
