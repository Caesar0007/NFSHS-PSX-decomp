/* syslib/psx/libgpu/P10.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgpu.lib(P10.OBJ): SetSemiTrans @0x800F30FC.  Sets/clears the semi-transparency
 *   bit (0x02) in a primitive's code byte at offset 7. */
extern "C" void SetSemiTrans(void *p, int abe)   /* @0x800F30FC */
{
    if (abe) ((char *)p)[7] |= 0x02;
    else     ((char *)p)[7] &= (char)0xfd;
}
