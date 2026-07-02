/* eaclib/psx/sndpsxz/ssysserv.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 3/3 ***
 *   Source obj : nfs4\eaclib\psx\ssysserv.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   3 fns @[0x8010479C .. 0x80104878].  The (per-frame) "service-client" list -- callbacks the game
 *   registers to run on each SNDSYS_service tick.  Ghidra nfs4-f.exe.c (ssysserv) + IDA sigs.
 *
 *   Client list lives at sndgs[0x19..] (int fn-ptrs); the count is sndgs[0x10]._1_1_ = ((char*)sndgs)[0x41].
 */

extern "C" int sndgs[];

extern "C" short *iSNDserveraddclient(int cb);       /* @0x8010479C */
extern "C" int    iSNDserverremoveclient(int cb);    /* @0x801047CC */
extern "C" void   SNDSYS_service(void);              /* @0x80104878 */

#define NCLIENT (((char *)sndgs)[0x41])   /* sndgs[0x10]._1_1_ : service-client count */

/* iSNDserveraddclient @0x8010479C : append callback `cb` to the service-client list; returns sndgs.
 *   The count is read SIGNED (lb) for the array index but UNSIGNED (lbu) for the increment-store. */
extern "C" short *iSNDserveraddclient(int cb)
{
    /* near-miss (3 diffs): oracle folds +0x19*4=+100 into the store displacement (`sll;addu sndgs;
     * sw a0,100(v1)`); gcc-2.8.0 here distributes it as `addiu v1,v1,25` first (count+0x19)*4. Every
     * explicit-pointer-arith form makes gcc CSE the NCLIENT-read base (sndgs+0x41) and anchor there
     * (displacement 35/-65) -- WORSE. base+offset fusion floor; permuter multi-basin candidate. */
    sndgs[(int)(signed char)NCLIENT + 0x19] = cb;
    NCLIENT = NCLIENT + 1;
    return (short *)sndgs;
}

/* iSNDserverremoveclient @0x801047CC : unregister `cb`, compacting the list.  (Ghidra's `while(iVar2=0,..)`
 *   zeroes the return on each check -> the found path returns 0; reconstructed faithfully.) */
extern "C" int iSNDserverremoveclient(int cb)
{
    int i = 0, off = 0;
    int more;
    if (0 < (int)NCLIENT) {
        off = 0;
        while (*(int *)((int)sndgs + off + 100) != cb) {     /* find slot (sndgs[0x19] == sndgs+100) */
            i++;
            off = i * 4;
            if (NCLIENT <= i)
                return off;                                   /* not found */
        }
        NCLIENT = NCLIENT - 1;
        more = (i < (int)NCLIENT);
        while (off = 0, more) {                               /* compact the tail down one slot */
            sndgs[i + 0x19] = sndgs[i + 0x1a];
            more = (i + 1 < (int)NCLIENT);
            i++;
        }
    }
    return off;
}

/* SNDSYS_service @0x80104878 : run every registered service-client callback (called once per game frame). */
extern "C" void SNDSYS_service(void)
{
    int *clientp = sndgs;
    int  i = 0;
    if (0 < NCLIENT) {
        do {
            int *cb = clientp + 0x19;
            clientp = clientp + 1;
            (*(void (*)(void))*cb)();
            i++;
        } while (i < (int)NCLIENT);
    }
}
