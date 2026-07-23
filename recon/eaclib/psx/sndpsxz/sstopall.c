/* eaclib/psx/sndpsxz/sstopall.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sstopall.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E81A8.  SNDstopall -- stop every voice in the channel pool.  Ghidra nfs4-f.exe.c (sstopall).
 */

extern int sndgs[];
extern int SNDstop(unsigned int tag);   /* sstop */

extern void SNDstopall(void);           /* @0x800E81A8 */

/* SNDstopall @0x800E81A8 : walk the channel pool (sndgs[0x25], count sndgs[4]._1_1_) and SNDstop each
 *   channel by its owning tag. */
extern void SNDstopall(void)
{
    int i, off;
    int *base = sndgs;
    if (((unsigned char *)base)[0x11] != 0) {
        int *gs;
        i = 0;
        off = i;
        gs = base;
        off = i;
        do {
            i++;
            SNDstop(*(unsigned int *)(off + gs[0x25]));
            off += 100;
        } while (i < (int)(unsigned)((unsigned char *)gs)[0x11]);
    }
}
