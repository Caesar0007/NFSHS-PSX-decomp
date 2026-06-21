/* eaclib/psx/sndpsxz/sdata.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sdata.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800FE594.  iSNDplatformfree -- release a bank's downloaded SPU data (thin wrapper over the SPU
 *   allocator's free).  Ghidra nfs4-f.exe.c (sdata).
 */

extern "C" void iSNDpsxfree(int ptr);   /* sdmemman */

extern "C" void iSNDplatformfree(int ptr);   /* @0x800FE594 */

/* iSNDplatformfree @0x800FE594 : free the SPU block at `ptr`. */
extern "C" void iSNDplatformfree(int ptr)
{
    iSNDpsxfree(ptr);
}
