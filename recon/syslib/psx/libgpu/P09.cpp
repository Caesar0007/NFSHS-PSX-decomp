/* syslib/psx/libgpu/P09.cpp -- RECONSTRUCTED from nfs4-f.exe (disasm-v3).
 *   obj libgpu.lib(P09.OBJ): TermPrim @0x80107020.  Sets a primitive's link address to the
 *   list terminator (0xFFFFFF), keeping its length byte. */
extern "C" void TermPrim(void *p)   /* @0x80107020 */
{
    *(unsigned int *)p |= 0x00ffffffu;
}
