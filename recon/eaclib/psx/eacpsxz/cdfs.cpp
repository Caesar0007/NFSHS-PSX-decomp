/* eaclib/psx/eacpsxz/cdfs.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 14/14 SEALED ***
 *   Source obj : nfs4\eaclib\psx\cdfs.obj ; archive C:\nfs4\EACLIB\PSX\EACPSXZ.LIB (xlsx col11)
 *   14 fns @[0x800F9AE8 .. 0x800FA920].  EA CD-ROM filesystem (fs 1): the CD_* backend fileroot calls.
 *   Dual-source reconstruction: Ghidra `C:\Temp\claud\nfs4-f.exe.c` (primary) verified vs disasm-v3.
 *
 *   A CD context struct lives @0x80146CC4:  +0x00 Cdinfo (state flags), +0x04 CD_maxOpen, +0x08
 *   CD_dirEntryCount, +0x20 read-state, +0x34 CD_handleTable, +0x38 CD_dirEntryArray.  An open file is a
 *   1-based index into CD_handleTable[]; each slot holds a pointer to the file's ISO9660 directory entry
 *   (0x14 bytes: name[0xC], start sector @+0xC, size @+0x10).
 *
 *   PROGRESS (incremental):
 *     [done] CD_Open, CD_Close, CD_Stopread, CD_Getinfo, CD_Read   -- leaves + the sector-ring read entry
 *     [done] readsectorB (sync sector read), loaddirinfo (recursive ISO9660 dir walker), dircompare,
 *            CD_Restore (addexit cleanup), CD_Init (mount: PVD->root dir), CD_Restart (re-seek/read),
 *            CD_systaskfunc (disc-swap recovery task), CD_timerfunc (read watchdog),
 *            CdReadyHandler (1200B CD IRQ -- the streaming sector engine)   -- the CD machinery
 *
 *   ISO9660 directory record (loaddirinfo/CD_Init):  [0]=reclen [1]=ext_attr_len  extent(LE)@+0x02
 *     data_len(LE)@+0x0A  flags@+0x19(bit1=directory)  name_len@+0x20  name@+0x21 (";1" stripped).
 *     A collected dir entry is 0x14 bytes: name[0xC], extent@+0xC, size@+0x10.
 */

/* ---- CD context globals @0x80146CC4 (data-materialization pass owns the addresses) ---- */
extern "C" int    Cdinfo;            /* +0x00 CD state flags (bit2 == stop-requested)            */
extern "C" int    CD_maxOpen;        /* +0x04 number of handle slots                             */
extern "C" int    CD_dirEntryCount;  /* +0x08 number of ISO9660 directory entries                */
extern "C" void **CD_handleTable;    /* +0x34 open-file slots (each -> a directory entry)        */
extern "C" void  *CD_dirEntryArray;  /* +0x38 the sorted directory-entry array (0x14-byte stride)*/

/* ---- helpers ---- */
extern "C" int   toupper(int c);                                  /* @0x8010907C (libc C37)      */
extern "C" void *bsearch(const void *key, const void *base, int n, int size,
                         int (*cmp)(const void *, const void *)); /* @0x801091DC (libc)          */
extern "C" int   dircompare(const void *a, const void *b);        /* @0x800FA344 (cdfs, below)   */
extern "C" char *strncpy(char *d, const char *s, int n);          /* @0x800F6104 (libc C26)      */

/* ---- CD read-state (ctx+0x20 sub-struct) + sector cache + the read machinery CD_Read arms ---- */
extern "C" int   CD_curOff;          /* byte offset within the current 0x800 sector              */
extern "C" int   CD_curLen;          /* bytes to transfer from the current sector                */
extern "C" int   CD_remLen;          /* bytes still to transfer after the current sector         */
extern "C" int   CD_ringIdx;         /* libcd read-ring index                                    */
extern "C" int   CD_curSector;       /* the sector currently being read                          */
extern "C" int   CD_timeout;         /* watchdog (timer ticks)                                   */
extern "C" void *CD_curDst;          /* current memory destination                               */
extern "C" void (*CD_completionCallback)(int);  /* fired (with 1) when a read finishes            */
extern "C" int   timerhz;            /* timer frequency                                          */
extern "C" int   g_currentthread;    /* execution context id                                     */
extern "C" int   CD_cachedSector;    /* @0x80146CD0 sector currently in the cache buffer          */
extern "C" unsigned char CD_sectorCache[]; /* @0x80146D00 the cached 0x800-byte sector            */
extern "C" void  CD_timerfunc(void); /* @0x800F9C44 (cdfs read watchdog/poll, below)             */

extern "C" void  addtimer(void *fn, void *arg);   /* @0x800EAFE8 (eaclib)                        */
extern "C" void  deltimer(void *fn);              /* @0x800EB048 (eaclib)                        */
extern "C" void  blockmove(void *src, void *dst, int n);  /* @0x800E62DC                          */
extern "C" int   savegp(void *ctx);               /* save $gp around a cross-module callback     */
extern "C" void  restoregp(int saved);

/* ---- additional CD context globals + the CD machinery ---- */
extern "C" int   CD_lastSector;      /* @0x80146CD4 (ctx+0x10) completion/prefetch loop marker   */

/* ---- cdfs.obj-OWNED storage definitions for the CD-filesystem state above.
 *      These were `extern`-declared (a promise) but never defined -> surfaced by the
 *      link harness. They are the fields of the CD context (Cdinfo @0x80146CC4 region;
 *      IDA-confirmed: CD_curLen=dword_80146CE4, CD_curDst=dword_80146CF0,
 *      CD_sectorCache=unk_80146D00, CD_handleTable=ctx+0x34, CD_dirEntryArray=ctx+0x38).
 *      The original is one struct; the reconstruction uses flat names, so each gets its
 *      own zero-init (BSS) storage here in the owning TU. */
/* CD_handleTable is NOT in this tentative-def block: the oracle accesses it via absolute
 * lui/lw (D_80146CF8 = cdctx+0x34) -- a tentative def here would emit .comm (4 bytes, sbss)
 * making it gp-rel under -G4, which disagrees with the oracle.  It is defined in the data-mat pass.
 * All other flat-name fields below are truly owned here (never gp-rel in any oracle fn). */
extern "C" {
int    CD_maxOpen;
int    CD_dirEntryCount;
void  *CD_dirEntryArray;
int    CD_curOff;
int    CD_curLen;
int    CD_remLen;
int    CD_ringIdx;
int    CD_curSector;
int    CD_timeout;
void  *CD_curDst;
void (*CD_completionCallback)(int);
int    CD_cachedSector;
unsigned char CD_sectorCache[0x800];   /* @0x80146D00 : the cached 0x800-byte sector */
int    CD_lastSector;
}

/* PsyQ libcd location: BCD minute/second/sector + mode/track */
typedef struct CdlLOC { unsigned char minute, second, sector, track; } CdlLOC;

/* ---- syslib / PsyQ libcd backend (toolchain-provided; declared, not reconstructed) ---- */
extern "C" int  CdInit(void);                                                  /* @0x800F908C */
extern "C" void CdReset(int mode);                                             /* @0x800F77AC */
extern "C" void CdSetDebug(int level);                                         /* @0x800F7838 */
extern "C" int  CdGetToc(CdlLOC *toc);                                         /* @0x800F929C */
extern "C" int  CdControlB(unsigned char com, unsigned char *p, unsigned char *r); /* @0x800F7B24 */
extern "C" int  CdControl(unsigned char com, unsigned char *p, unsigned char *r);  /* @0x800F78B4 */
extern "C" int  CdSync(int mode, unsigned char *r);                            /* @0x800F784C */
extern "C" int  CdFlush(void);                                                 /* @0x800F7818 */
extern "C" void CdReadyCallback(void (*fn)(int, unsigned char *));             /* @0x800F78A0 */
extern "C" void CdIntToPos(int i, unsigned char *p);                           /* @0x800F7CF4 */
extern "C" int  CdPosToInt(CdlLOC *p);                                         /* syslib SYS  */
extern "C" int  CdGetSector(void *madr, int size);                             /* syslib SYS  */
extern "C" int  CdDataSync(int mode);                                          /* syslib SYS  */
extern "C" int  CdDiskReady(int mode);                                         /* syslib TYPE */
extern "C" int  CdGetDiskType(void);                                           /* syslib TYPE */
extern "C" void VSync(int mode);                                               /* @0x800F231C */

extern "C" void addsystemtask(void *fn, void *a, void *b); /* @ systask  */
extern "C" void delsystemtask(void *fn);                   /* @ systask  */
extern "C" void addexit(void *fn);                         /* @0x800F1CF8 (exit) */
extern "C" void blockclear(void *dst, int n);              /* @0x800F17A0 (blkfill) */
extern "C" int  strncmp(const char *a, const char *b, int n); /* @0x800EB1D0 (syslib C24) */
extern "C" void *memcpy(void *d, const void *s, int n);       /* @0x800EAAC4 (syslib C42) */
extern "C" void qsort(void *base, int n, int sz, int (*cmp)(const void *, const void *)); /* @0x800E5D8C */

/* ---- cdfs internal forward decls (mutually recursive CD machinery) ---- */
extern "C" unsigned char *readsectorB(void);                       /* @0x800FA154 */
extern "C" int  *loaddirinfo(int startSector, int numSectors, int maxEntries); /* @0x800FA1A8 */
extern "C" int   CD_Restart(int startSector);                      /* @0x800FA4A8 */
extern "C" void  CD_systaskfunc(void);                             /* @0x800F9AE8 */
extern "C" void  CdReadyHandler(int intr, unsigned char *result);  /* @0x800F9CA4 */

/* unaligned little-endian 32-bit load (the asm uses lwl/lwr; ISO9660 stores LE first) */
static int rd_le32(const unsigned char *q)
{
    return (int)((unsigned)q[0] | ((unsigned)q[1] << 8) |
                 ((unsigned)q[2] << 16) | ((unsigned)q[3] << 24));
}

/* CD_Open @0x800FA554 : open `name` on the CD; writes the 1-based handle to *outp.  Finds a free slot,
 *   upper-cases the name, binary-searches the directory, and parks the matching entry in the slot.
 *   Returns 1 if found, 0 if not.  (`flags` is unused -- the CD is read-only.) */
extern "C" int CD_Open(char *name, int flags, int *outp)
{
    char   upper[16];
    char  *p    = upper;
    void **h    = CD_handleTable;
    int    slot = 0;
    void  *entry;
    int    c;
    (void)flags;

    if (CD_maxOpen > 0) {                       /* find the first free slot */
        while (slot < CD_maxOpen) {
            if (*h == 0) break;
            slot++; h++;
        }
    }
    do {                                        /* upper-case the name into a scratch buffer */
        c = toupper((unsigned char)*name++);
        *p++ = (char)c;
    } while ((c & 0xFF) != 0);

    entry = bsearch(upper, CD_dirEntryArray, CD_dirEntryCount, 0x14, dircompare);
    CD_handleTable[slot] = entry;
    if (CD_handleTable[slot] == 0) {            /* not on the disc */
        *outp = 0;
        return 0;
    }
    *outp = slot + 1;
    return 1;
}

/* CD_Close @0x800FA65C : release a CD handle slot (1-based). */
extern "C" int CD_Close(int handle)
{
    CD_handleTable[handle - 1] = 0;
    return 0;
}

/* CD_Stopread @0x800FA904 : request the in-flight CD read to stop (sets Cdinfo bit 2). */
extern "C" int CD_Stopread(int dev)
{
    (void)dev;
    Cdinfo |= 4;
    return 0;
}

/* CD_Getinfo @0x800FA920 : query an open CD file -- optionally copy its 0xC-byte name into `namebuf`
 *   and write its size to *sizeout; returns the size. */
extern "C" int CD_Getinfo(int handle, int namebuf, int *sizeout)
{
    void *entry = CD_handleTable[handle - 1];
    if (namebuf != 0)
        strncpy((char *)namebuf, (char *)entry, 0xC);     /* directory entry name (0xC bytes) */
    if (sizeout != 0)
        *sizeout = *(int *)((char *)entry + 0x10);        /* file size */
    return *(int *)((char *)entry + 0x10);
}

/* CD_Read @0x800FA678 : arm a read of `len` bytes from file `dev` at `offset` into `dest`.  Sets up the
 *   sector-ring read state (clamping `len` to the file and to the 0x800 sector boundary) and starts the
 *   watchdog timer; the transfer itself proceeds asynchronously via CD_timerfunc/CdReadyHandler.  If the
 *   target sector happens to already be in the sector cache (same execution context), it is copied
 *   immediately -- completing the read (calling the completion callback) or advancing to the next sector.
 *   Returns the (clamped) byte count, or 0 if the CD is busy. */
extern "C" int CD_Read(int dev, int dest, int offset, int len)
{
    char *entry = (char *)CD_handleTable[dev - 1];
    int   q, remaining;

    if ((Cdinfo & 3) != 0)                              /* CD busy -> reject */
        return 0;

    remaining = *(int *)(entry + 0x10) - offset;        /* clamp len to bytes left in the file */
    if (remaining < len)
        len = remaining;

    q = (offset < 0) ? offset + 0x7FF : offset;
    CD_curOff = offset - ((q >> 0xB) << 0xB);            /* byte offset within the 0x800 sector */
    if (CD_curOff != 0 || len < 0x800)
        Cdinfo |= 8;                                    /* partial-sector transfer */
    CD_curLen = len;
    if (CD_curOff + len > 0x800)
        CD_curLen = 0x800 - CD_curOff;                  /* clamp this chunk to the sector boundary */
    CD_remLen = len - CD_curLen;

    q = (offset < 0) ? offset + 0x7FF : offset;
    CD_ringIdx   = 0;
    CD_curSector = *(int *)(entry + 0xC) + (q >> 0xB);  /* start sector + offset / 0x800 */
    Cdinfo |= 2;                                        /* read in progress */
    CD_timeout   = timerhz * 6;
    CD_curDst    = (void *)dest;
    addtimer((void *)CD_timerfunc, (void *)dest);

    if (CD_cachedSector == CD_curSector && (Cdinfo & 0x10) && g_currentthread == 2) {
        blockmove(&CD_sectorCache[CD_curOff], CD_curDst, CD_curLen);   /* sector already cached */
        if (CD_remLen < 1) {                            /* whole request satisfied -> complete now */
            int gpctx[2];
            CD_timeout = 0;
            Cdinfo &= ~2;
            deltimer((void *)CD_timerfunc);
            if (CD_completionCallback != 0) {
                savegp(gpctx);
                CD_completionCallback(1);
                restoregp(gpctx[0]);
            }
        } else {                                        /* more to read -> advance to the next sector */
            CD_curOff = 0;
            CD_curDst = (char *)CD_curDst + CD_curLen;
            if (CD_remLen < 0x800) { CD_curLen = CD_remLen; Cdinfo |= 8; }
            else                   { CD_curLen = 0x800;     Cdinfo &= ~8; }
            CD_remLen   -= CD_curLen;
            CD_curSector += 1;
        }
    }
    return len;
}

/* readsectorB @0x800FA154 : synchronously read CD_curSector into the global sector cache.  Arms a
 *   single-sector transfer (CD_curLen=0x800, in-progress|partial flags) into the cache buffer and
 *   busy-waits until CdReadyHandler clears the in-progress bits.  Returns the cache pointer.
 *   (Ghidra rendered the spin-wait as an "infinite loop" -- the loop exits when the IRQ runs.) */
extern "C" unsigned char *readsectorB(void)
{
    CD_curLen  = 0x800;
    CD_ringIdx = 0;
    Cdinfo     = 0xA;                     /* read-in-progress (2) | partial (8) */
    if ((Cdinfo & 3) != 0)
        CD_curDst = CD_sectorCache;       /* ctx+0x3C == &CD_sectorCache (0x80146D00) */
    while ((Cdinfo & 3) != 0)
        ;                                 /* spin until the CD IRQ completes this sector */
    return CD_sectorCache;
}

/* loaddirinfo @0x800FA1A8 : recursively walk an ISO9660 directory, appending every FILE record to the
 *   global directory-entry array.  Skips the "." and ".." records of the first sector; recurses into
 *   subdirectory records.  Stops when the directory's sectors run out or CD_dirEntryCount hits
 *   `maxEntries` (a budget shared across the recursion).  The return value (a fixed address) is unused. */
extern "C" int *loaddirinfo(int startSector, int numSectors, int maxEntries)
{
    int            savedSector = CD_curSector;
    int            sectorsLeft;
    unsigned char *p;

    CD_curSector = startSector;
    p = readsectorB();                    /* load the directory's first sector into the cache */
    sectorsLeft = numSectors - 1;
    p = p + p[0];                         /* skip the "." self record (record 0) */

    while (CD_dirEntryCount < maxEntries) {
        p = p + p[0];                     /* advance to the next record (first pass: skip ".." -> rec 2) */

        if (p[0] == 0) {                  /* zero reclen -> no more records in this sector */
            if (sectorsLeft == 0)
                break;
            CD_curSector = CD_curSector + 1;
            p = readsectorB();            /* load the next directory sector (start at its record 0) */
            sectorsLeft--;
        }

        if ((p[0x19] & 2) != 0) {         /* flags bit1 == directory -> recurse */
            int subExtent = rd_le32(p + 2);
            int subSize   = rd_le32(p + 10);
            loaddirinfo(subExtent, subSize >> 0xB, maxEntries);
            readsectorB();                /* recursion reused the cache -> reload our own sector */
        } else {                          /* a FILE -> append a 0x14-byte directory entry */
            unsigned char *name    = p + 0x21;
            int            namelen = p[0x20];
            unsigned char *slot    = (unsigned char *)CD_dirEntryArray + CD_dirEntryCount * 0x14;
            memcpy(slot, name, namelen - 2);          /* drop the ";1" version suffix */
            slot[namelen - 2]     = 0;                /* NUL-terminate the name */
            *(int *)(slot + 0xC)  = rd_le32(p + 2);   /* extent (start sector) */
            *(int *)(slot + 0x10) = rd_le32(p + 10);  /* file size in bytes */
            CD_dirEntryCount = CD_dirEntryCount + 1;
        }
    }

    CD_curSector = savedSector;
    return (int *)0x80140000;             /* fixed return; callers ignore it */
}

/* dircompare @0x800FA344 : qsort/bsearch comparator -- compares the 0xC-byte names of two dir entries. */
extern "C" int dircompare(const void *a, const void *b)
{
    return strncmp((const char *)a, (const char *)b, 0xC);
}

/* CD_Restore @0x800FA364 : addexit() cleanup -- reset the drive and clear the CD context block. */
extern "C" void CD_Restore(void)
{
    CdReset(0);
    blockclear(&Cdinfo, 0x83C);           /* ctx header (0x3C) + sector cache (0x800) = 0x83C */
}

/* CD_Init @0x800FA394 : mount the CD filesystem.  Brings up libcd, reads the Primary Volume Descriptor
 *   (sector 0x10), walks its root directory into the caller-provided buffer, sorts the entry array, and
 *   registers the at-exit drive-reset.  `buffer` holds `maxOpen` handle pointers followed by the
 *   `numEntries`-slot (0x14-byte) directory array.  Returns the number of entries found (0 on failure). */
extern "C" int CD_Init(int maxOpen, int numEntries, void *buffer, void (*callback)(int))
{
    CdlLOC         toc[2];
    unsigned char *root;
    int            rootExtent, rootSize;

    if (CD_dirEntryCount != 0)            /* already mounted */
        return 0;
    if (CdInit() == 0)
        return 0;
    CdSetDebug(0);
    if (CdGetToc(toc) == 0)               /* no disc / unreadable TOC */
        return 0;

    CD_maxOpen       = maxOpen;
    CD_handleTable   = (void **)buffer;                            /* ctx+0x34 */
    CD_dirEntryArray = (void *)((char *)buffer + maxOpen * 4);     /* ctx+0x38, after the handle table */
    blockclear(buffer, maxOpen * 4 + numEntries * 0x14);

    CD_Restart(0x10);                     /* seek + read the PVD (sector 0x10) */
    root = readsectorB();                 /* ensure it is in the cache; root = &CD_sectorCache */
    rootExtent = rd_le32(root + 158);     /* PVD root dir record @+156: extent  @ +156+2  */
    rootSize   = rd_le32(root + 166);     /* PVD root dir record @+156: data len @ +156+10 */
    loaddirinfo(rootExtent, rootSize >> 0xB, numEntries);

    qsort(CD_dirEntryArray, CD_dirEntryCount, 0x14, dircompare);
    CD_completionCallback = callback;     /* ctx+0x30 */
    addexit((void *)CD_Restore);
    return CD_dirEntryCount;
}

/* CD_Restart @0x800FA4A8 : (re)set the read mode and start a streaming read at `startSector` (default
 *   0x10).  Loops CdlSetmode until accepted, flushes, installs CdReadyHandler, and issues CdlReadN. */
extern "C" int CD_Restart(int startSector)
{
    unsigned char mode[8];
    unsigned char pos[8];
    int           rc;

    mode[0] = 0xA0;                       /* double-speed read mode */
    do {
        rc = CdControlB(0x0E, mode, 0);   /* CdlSetmode -- retry until the drive accepts it */
    } while (rc == 0);
    VSync(3);
    CdFlush();
    CdSync(0, 0);
    if (startSector == 0)
        startSector = 0x10;
    CD_cachedSector = startSector;        /* ctx+0x0C read-head */
    CD_curSector    = startSector;        /* ctx+0x14 target  */
    CdReadyCallback(CdReadyHandler);
    CdIntToPos(CD_curSector, pos);
    return CdControl(0x1B, pos, 0);       /* CdlReadN */
}

/* CD_systaskfunc @0x800F9AE8 : disc-swap recovery system task.  Polls CdDiskReady; on a stable disc
 *   (or a timed-out error) it resets the drive, re-arms the read mode + CdReadyHandler, and resumes the
 *   in-flight transfer if one was pending. */
extern "C" void CD_systaskfunc(void)
{
    unsigned char mode[8];
    unsigned char result[8];
    unsigned char pos[8];
    int           ready;
    int           done = 0;

    ready = CdDiskReady(1);
    if (ready == 5) {                     /* CdlDiskError -> run down the watchdog */
        /* @0x800F9B48-B74: the watchdog only writes back at the boundaries -- CD_timeout==0 re-arms to
         * timerhz*5; CD_timeout==1 stores 0 + done=1; for CD_timeout>=2 the branch at 0x800F9B6C exits
         * WITHOUT storing, so the timeout is left UNCHANGED here (decremented elsewhere). The recon
         * decremented unconditionally, persisting timeout-1 for >=2 (M01). */
        if (CD_timeout == 0)
            CD_timeout = timerhz * 5;     /* re-arm */
        else if (CD_timeout == 1) {
            CD_timeout = 0;
            done = 1;
        }
    } else if (ready == 2) {              /* CdlComplete -> a disc settled */
        int t = CdGetDiskType();
        done = ((unsigned)(t - 1) < 2);   /* disc type 1 or 2 == a usable disc */
    }

    if (done) {
        delsystemtask((void *)CD_systaskfunc);   /* remove ourselves */
        CdReset(0);
        mode[0] = 0xA0;
        CdControlB(0x0E, mode, result);
        VSync(3);
        CdFlush();
        CdSync(0, 0);
        CdIntToPos(CD_cachedSector, pos);
        CdControl(0x1B, pos, result);
        CdReadyCallback(CdReadyHandler);
        if (CD_remLen > 0) {              /* a transfer was in progress -> resume it */
            CD_ringIdx = 0;
            CD_timeout = timerhz * 6;
            addtimer((void *)CD_timerfunc, pos);
        }
    }
}

/* CD_timerfunc @0x800F9C44 : read watchdog (timer callback).  When the countdown reaches zero it queues
 *   the disc-swap recovery system task and removes itself from the timer list. */
extern "C" void CD_timerfunc(void)
{
    if (CD_timeout != 0) {
        CD_timeout = CD_timeout - 1;
        if (CD_timeout == 0) {
            addsystemtask((void *)CD_systaskfunc, 0, 0);
            CD_timeout = 0;
            deltimer((void *)CD_timerfunc);
        }
    }
}

/* CdReadyHandler @0x800F9CA4 : the CD data-ready interrupt callback -- the streaming sector engine.
 *   `intr` is the libcd interrupt type (1=DataReady, 2=Complete, 5=DiskError); `result` is the status
 *   buffer.  On each ready sector it pulls the 0x800-byte payload (whole into CD_curDst, or via the
 *   cache for a partial slice), validates the sector address, advances the transfer, and fires the
 *   completion callback when the request is satisfied.  It also keeps the drive streaming/prefetching
 *   ahead of CD_curSector and re-installs itself on exit. */
extern "C" void CdReadyHandler(int intr, unsigned char *result)
{
    CdlLOC        hdr[3];                 /* sector address header (CdGetSector .. 3 words) */
    unsigned char sub[284];               /* trailing sector bytes (CdGetSector .. 0x46 words) */
    unsigned char pos[8];
    int           gpctx[2];
    unsigned char com;
    unsigned char *param;
    void          *madr;
    int           done = 0;

    CdReadyCallback(0);                   /* disarm while we run */

    if ((*result & 0x10) != 0) {          /* shell open / hard error -> hand off to the recovery task */
        deltimer((void *)CD_timerfunc);
        addsystemtask((void *)CD_systaskfunc, 0, 0);
        return;
    }

    if (intr == 2) {                      /* CdlComplete */
        if (CD_ringIdx == -1) {
            CD_ringIdx = 0;
            Cdinfo |= 2;
        }
        goto advance;
    }

    if (intr < 3) {
        if (intr != 1)                    /* intr 0 -> nothing to do but advance */
            goto advance;

        /* intr == 1 : CdlDataReady -- a sector is in the drive buffer */
        if ((Cdinfo & 1) == 0) {
            CdFlush();
            CdSync(0, 0);
        } else if ((Cdinfo & 4) != 0) {   /* stop requested (CD_Stopread) */
            done = 1;
            Cdinfo &= ~4;
            CdFlush();
            CdSync(0, 0);
        } else {
            madr = (Cdinfo & 8) ? (void *)CD_sectorCache : CD_curDst;
            CdGetSector(hdr, 3);          /* 12-byte sector address header */
            CdGetSector(madr, 0x200);     /* 0x800 bytes of user data */
            CdGetSector(sub, 0x46);       /* trailing bytes */
            CdDataSync(0);
            if (CdPosToInt(hdr) == CD_cachedSector) {     /* the sector we were expecting */
                CD_timeout = timerhz * 6;
                if ((Cdinfo & 8) != 0) {  /* partial -> copy the wanted slice out of the cache */
                    Cdinfo = (Cdinfo & ~8) | 0x10;
                    blockmove(&CD_sectorCache[CD_curOff], CD_curDst, CD_curLen);
                    CD_curOff = 0;
                }
                if (CD_remLen < 1) {
                    done = 1;
                } else {                  /* advance to the next chunk/sector */
                    CD_curDst = (char *)CD_curDst + CD_curLen;
                    if (CD_remLen < 0x800) { CD_curLen = CD_remLen; Cdinfo |= 8; }
                    else                   { CD_curLen = 0x800; }
                    CD_remLen -= CD_curLen;
                }
            } else {                      /* wrong sector -> retry up to 4 ring slots */
                CD_ringIdx++;
                CD_curSector = CD_cachedSector;
                if (CD_ringIdx > 3) {
                    CD_ringIdx = -1;
                    com = 0x09;           /* CdlPause */
                    param = 0;
                    result = 0;
                    goto issue;
                }
                Cdinfo |= 2;
            }
        }

        if (done) {                       /* request satisfied -> fire the completion callback */
            Cdinfo &= ~1;
            CD_timeout = 0;
            CD_lastSector = CD_cachedSector;
            deltimer((void *)CD_timerfunc);
            if (CD_completionCallback != 0) {
                g_currentthread = 2;
                savegp(gpctx);
                CD_completionCallback(1);
                restoregp(gpctx[0]);
                g_currentthread = 0;
            }
        }
        goto advance;
    }

    /* intr >= 3 */
    if (intr != 5 || (Cdinfo & 1) == 0)   /* only CdlDiskError while actively reading is interesting */
        goto advance;
    CdControl(0x01, 0, &hdr[0].minute);   /* CdlNop -- read the drive status */
    CD_ringIdx++;
    CD_curSector = CD_cachedSector;
    if (CD_ringIdx < 4) {
        Cdinfo |= 2;
        goto advance;
    }
    CD_ringIdx = -1;
    com = 0x09;                           /* CdlPause */
    param = 0;
    result = 0;
    goto issue;

advance:
    CD_cachedSector++;
    if ((Cdinfo & 2) != 0) {
        Cdinfo = (Cdinfo & ~0x12) | 1;    /* clear in-progress|copied, mark reading */
        if (CD_cachedSector != CD_curSector) {   /* seek to the requested sector */
            CdFlush();
            CdSync(0, 0);
            CD_cachedSector = CD_curSector;
            CdIntToPos(CD_curSector, pos);
            CdControl(0x1B, pos, result);
        }
    }
    if ((Cdinfo & 1) != 0 || (CD_cachedSector - CD_lastSector < 0x15)) {
        CdReadyCallback(CdReadyHandler);  /* still streaming / within prefetch window -> re-arm */
        return;
    }
    /* prefetched too far past the last delivered sector -> rewind the read head */
    CD_cachedSector = CD_lastSector;
    CdIntToPos(CD_lastSector, pos);
    com   = 0x1B;                          /* CdlReadN */
    param = pos;
issue:
    CdControl(com, param, result);
    CdReadyCallback(CdReadyHandler);       /* re-install ourselves */
}
