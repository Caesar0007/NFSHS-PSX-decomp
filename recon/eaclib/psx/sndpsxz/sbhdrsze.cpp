/* eaclib/psx/sndpsxz/sbhdrsze.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sbhdrsze.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7B64.  SNDbankheadersize -- the header byte-size of loaded bank `bankId`.  Ghidra.
 */

extern "C" int sndgs[];

extern "C" int SNDbankheadersize(int bankId);   /* @0x800E7B64 */

/* SNDbankheadersize @0x800E7B64 : bank @ sndgs[0x26]+bankId*0xc, +0 = data ptr, [data+8] = header size. */
extern "C" int SNDbankheadersize(int bankId)
{
    if ((signed char)sndgs[0xf] == 0)
        return -10;
    return *(int *)(*(int *)(bankId * 0xc + sndgs[0x26]) + 8);
}
