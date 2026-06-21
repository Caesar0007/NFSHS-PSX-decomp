/* syslib/psx/libgpu/P11.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgpu.lib(P11.OBJ): SetShadeTex @0x800F611C.  Sets/clears the texture-without-shading
 *   bit (0x01) in a primitive's code byte at offset 7. */
extern "C" void SetShadeTex(void *p, int tge)   /* @0x800F611C */
{
    if (tge) ((char *)p)[7] |= 0x01;
    else     ((char *)p)[7] &= (char)0xfe;
}
