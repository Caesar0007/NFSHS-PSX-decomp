/* eaclib/psx/sndpsxz/sstopall.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sstopall.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E81A8.  SNDstopall -- stop every voice in the channel pool.  Ghidra nfs4-f.exe.c (sstopall).
 */

extern "C" int sndgs[];
extern "C" int SNDstop(unsigned int tag);   /* sstop */

extern "C" int SNDstopall(void);            /* @0x800E81A8 */

/* SNDstopall @0x800E81A8 : walk the channel pool (sndgs[0x25], count sndgs[4]._1_1_) and SNDstop each
 *   channel by its owning tag. */
extern "C" int SNDstopall(void)
{
    int i = 0, off;
    if (((unsigned char *)sndgs)[0x11] != 0) {
        off = 0;
        do {
            i++;
            SNDstop(*(unsigned int *)(off + sndgs[0x25]));
            off += 100;
        } while (i < (int)(unsigned)((unsigned char *)sndgs)[0x11]);
    }
    return 0;
}
