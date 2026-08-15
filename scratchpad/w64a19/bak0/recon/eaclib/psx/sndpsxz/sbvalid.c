/* eaclib/psx/sndpsxz/sbvalid.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sbvalid.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800FE6BC.  iSNDvalidbank -- is `bank_id` a loaded, ready sound bank?  Ghidra nfs4-f.exe.c.
 *
 *   Bank table @ sndgs[0x26], 0xc-byte entries: +0x00 data ptr (0 == empty), +0x08 load state (0 == ready).
 */

extern int sndgs[];

extern int iSNDvalidbank(int bank_id);   /* @0x800FE6BC */

/* iSNDvalidbank @0x800FE6BC : 0 if the bank is loaded and ready, -8 if out of range / empty, -0x12 if it
 *   is still loading. */
extern int iSNDvalidbank(int bank_id)
{
    int *bank;
    if (bank_id < 0 || (int)(unsigned int)(unsigned short)sndgs[3] <= bank_id)
        return -8;
    bank = (int *)(bank_id * 0xc + sndgs[0x26]);
    if (bank[0] == 0)
        return -8;
    if ((signed char)bank[2] != 0)
        return -0x12;
    return 0;
}
