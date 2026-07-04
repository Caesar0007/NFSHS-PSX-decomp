/* eaclib/psx/sndpsxz/sst.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 16/16 ***
 *   Source obj : nfs4\eaclib\psx\sst.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   16 fns @[0x800E8C14 .. 0x800E9970].  EA SCxl STREAMING-AUDIO decoder ("iSNDstream*").
 *   Pulls audio chunks out of the stream.obj ring (STREAM_get) and feeds them to the SNDPKTPLAY
 *   packet player.  Chunk tags (little-endian): 'SChl'=0x6C485343 header / 'SCCl'=0x6C435343 count /
 *   'SCDl'=0x6C445343 data / 'SCEl'=0x6C455343 end.
 *
 *   Dual-source reconstruction: Ghidra `C:\Temp\claud\nfs4-f.exe.c` L145852..146572 (bodies) verified
 *   vs disasm-v3 L299099..300132 (authoritative -- Ghidra mangled 6 fns: lwl/lwr unaligned format
 *   copies in parseheader/service, dropped register args in parsedata/hotrod/create/queue).
 *
 *   ===== stream object S (one slot, sndss[0]) =====
 *     +0x00 packetsArray (request stride 0x2C)   +0x04 STREAM handle (stream.obj)
 *     +0x08 SNDPKTPLAY_start result (-1 idle)    +0x0C SNDPKTPLAY handle
 *     +0x10 request-id counter (+=0x100)         +0x14(b) state (0/1=playing/2=needs-restart)
 *     +0x15(b) maxReq   +0x16(b) curReqCount   +0x17(b) parseIdx   +0x18(b) extStreamFlag
 *     +0x1C..0x37 LOCKED format (rate word @+0x1C, 0x14-byte header @+0x24)
 *     +0x1E(b) numChannels  +0x2F(b) interleaved-flag
 *     +0x20..0x4B CURRENT format (rate @+0x20, header @+0x38)   +0x4C..0x5C priority/params [5 words]
 *   ===== request (0x2C) =====
 *     +0x00 STREAM req id   +0x04 full id (counter|slot)   +0x08 submit-overflow   +0x0C submit handle
 *     +0x10 data rate   +0x14 bytes consumed   +0x18 total size (round-up 0x1C)   +0x1C remaining
 *     +0x20 submitted count   +0x24 num chunks   +0x28(short) name
 */

/* ---- globals ---- */
extern "C" int sndss;                       /* @0x8013EA80 -- single stream slot (loops are `<1`) */
extern "C" int sndgs[];                      /* SND global state: (char)sndgs[0xf]=init, sndgs[0x22]=destroyall hook */
extern "C" unsigned char sndStreamMap[];     /* @0x8013EA84 (=sndss+4): pktplay-handle -> stream slot */
unsigned char sndStreamMap[64];  /* def @0x8013EA84 (owning TU; BSS; FIXME size approx) */

/* ---- stream.obj ring (the layer below; already reconstructed) ---- */
extern "C" void         STREAM_release(int strm, int chunk);
extern "C" int          STREAM_get(int consumer, void *buf, int len);
extern "C" int          STREAM_gettable(int strm);
extern "C" int          STREAM_state(int strm);
extern "C" int          STREAM_buffersize(int strm);
extern "C" int          STREAM_create(int nReq, int nFilt, int nCons, int objbuf, int bufsize);
extern "C" unsigned int STREAM_queuefile(int strm, char *name, int off, int len);
extern "C" unsigned int STREAM_queuemem(int strm, int blocklist, void *ptr, int len);

/* ---- SNDPKTPLAY packet player (spktplay.obj) ---- */
extern "C" int  SNDPKTPLAY_start(int pktplay, int rate, int fmt, int *params);
extern "C" int  SNDPKTPLAY_submit(int pktplay, void *desc);
extern "C" int  SNDPKTPLAY_submitspace(int pktplay);
extern "C" int  SNDPKTPLAY_framesoutstanding(int pktplay);
extern "C" void SNDPKTPLAY_stop(int pktplay);
extern "C" int  SNDPKTPLAY_overhead(int arg);
extern "C" int  SNDPKTPLAY_create(int buf, int size, void *relcb, void *notifycb);

/* ---- other SND helpers ---- */
extern "C" int  iSNDpatchtohdr(short *src, int *rateDst, int *fmtDst, int *outSize); /* spat2hdr */
extern "C" int  iSNDplatformcalcdatarate(void *rate);                                /* sdpacket  */
extern "C" void iSNDenteraudio(void);                                                /* sserver   */
extern "C" void iSNDleaveaudio(void);
extern "C" void iSNDserveraddclient(void *cb);                                       /* ssysserv  */
extern "C" void SNDSTRM_setgreedylevel(int strm, int lvl);                           /* sstsetgl  */
extern "C" int  SNDSTRM_destroy(int s);                                              /* spvoices  */
extern "C" void SNDSTRM_purge(int s);
extern "C" int  memcmp(const void *a, const void *b, int n);
extern "C" void *memcpy(void *d, const void *s, int n);

/* ---- internal forward decls (mutually recursive) ---- */
extern "C" int  iSNDstreamdestroyall(void);                       /* @0x800E8C14 */
extern "C" int  iSNDstreamgetstreamptr(int idx);                  /* @0x800E8C48 */
extern "C" int  iSNDstreamremoverequest(unsigned int reqid);      /* @0x800E8C64 */
extern "C" void iSNDstreamreleasecallback(int sample);            /* @0x800E8D90 */
extern "C" void iSNDstreamnotifycallback(int handle, unsigned int bytes); /* @0x800E8DD4 */
extern "C" int  iSNDstreamparseheader(int S, int data);           /* @0x800E8E9C */
extern "C" int  iSNDstreamparsenumchunks(int S, int data);        /* @0x800E9044 */
extern "C" int  iSNDstreamparsedata(int S, int chunk);            /* @0x800E90AC (oracle: always returns 1) */
extern "C" int  iSNDstreamparseend(int S, int chunk);             /* @0x800E9230 */
extern "C" int  iSNDstreamparsechunk(int S, int chunk);           /* @0x800E9270 */
extern "C" int  iSNDstreamisheld(int S);                          /* @0x800E9318 */
extern "C" void iSNDstreamhotroddatachunks(void);                 /* @0x800E9438 */
extern "C" void iSNDstreamservice(void);                          /* @0x800E9590 */
extern "C" int  iSNDstreamnumcreated(void);                       /* @0x800E96F8 */

/* byte-offset accessors on an object held as an int address */
#define MI(p,o)  (*(int*)((p)+(o)))
#define MB(p,o)  (*(unsigned char*)((p)+(o)))
#define MSB(p,o) (*(signed char*)((p)+(o)))
#define MH(p,o)  (*(short*)((p)+(o)))

/* ====================================================================================== */

/* iSNDstreamdestroyall @0x800E8C14 : destroy every stream (addexit/shutdown hook). */
extern "C" int iSNDstreamdestroyall(void)
{
    int s = 0;
    do {
        SNDSTRM_destroy(s);
        s = s + 1;
    } while (s < 1);
    return 0;
}

/* iSNDstreamgetstreamptr @0x800E8C48 : map a stream index to its object (only index 0 exists). */
extern "C" int iSNDstreamgetstreamptr(int idx)
{
    if (idx == 0)
        return sndss;
    return 0;       /* near-miss (3 insns): oracle keeps 2 un-merged `jr ra` tails (zero-return in the
                     * 2nd jr's delay slot); our gcc -O2 cross-jump-merges the epilogue. RTL-level, not
                     * source-reachable; permuter multi-basin candidate. Tried: if/else-braces, ternary,
                     * flipped-condition, goto-split -- ALL cross-jump identically (confirmed source-invariant). */
}

/* iSNDstreamremoverequest @0x800E8C64 : drop the request whose id == `reqid` from a stream's packet
 *   array, compacting the remaining requests down and fixing up parseIdx/curReqCount.  Returns the
 *   (possibly adjusted) parseIdx. */
extern "C" int iSNDstreamremoverequest(unsigned int reqid)
{
    /* struct-assignment (not a memcpy() call) for the compaction copy below -- oracle expands it
     * inline as a manual 4-word+3-word unrolled load/store (this build's memcpy() is a genuine
     * extern call, never inlined; the true original must have used a real struct copy, letting
     * gcc do the copy itself). Landed 121->94 diffs. Residual: S colors to $a3 (oracle: $a1) --
     * same reload/coloring-tie-break floor class as iSNDstreamnumcreated/service. */
    struct ReqRec { int w[0x2c / 4]; };
    int *base = &sndss;
    int  S       = base[reqid & 0xff];
    int  packets = MI(S, 0);
    char newidx  = 0;            /* write index (compacted) */
    int  ret     = 0;

    if (0 < (int)((unsigned)MB(S, 0x16) << 0x18)) {     /* curReqCount > 0 (signed) */
        int rd = 0, wr = 0, i = 0;
        do {
            int *src = (int *)(packets + rd);
            if (src[1] != (int)reqid) {                 /* keep this request */
                if (MSB(S, 0x17) == i)                  /* parseIdx pointed at it -> retarget */
                    MB(S, 0x17) = newidx;
                *(struct ReqRec *)(packets + wr) = *(struct ReqRec *)src;
                wr += 0x2c;
                newidx = newidx + 1;
            }
            rd += 0x2c;
            i++;
        } while (i < MSB(S, 0x16));
    }
    MB(S, 0x16) = MB(S, 0x16) - 1;                       /* curReqCount-- */
    if ((int)((unsigned)MB(S, 0x16) << 0x18) < (int)((unsigned)MB(S, 0x17) << 0x18)) {
        ret = MB(S, 0x17) - 1;                          /* clamp parseIdx into range */
        MB(S, 0x17) = (unsigned char)ret;
    }
    return ret;
}

/* iSNDstreamreleasecallback @0x800E8D90 : SNDPKTPLAY release hook -- a finished sample buffer carries a
 *   back-pointer to its chunk 4 bytes ahead; the chunk's first word holds the request id whose low byte
 *   is the stream slot.  Free the chunk back to that stream's ring. */
extern "C" void iSNDstreamreleasecallback(int sample)
{
    int chunk = *(int *)(sample - 4);
    int slot  = *(unsigned char *)chunk;
    int S     = (&sndss)[slot];
    STREAM_release(MI(S, 4), chunk);
    /* near-miss floor (1 insn): oracle hoists `lui %hi(sndss)` into the `lw a1` load-delay
     * slot; our gcc -O2 leaves a nop there + emits the lui after the lbu. Scheduling-only;
     * explicit base-pointer + index forms, statement-split (separate `sndssp`/`handle` locals),
     * and inlined-index forms all produce BYTE-IDENTICAL codegen (confirmed source-invariant). */
}

/* iSNDstreamnotifycallback @0x800E8DD4 : SNDPKTPLAY play-progress hook.  `bytes` were just played on
 *   `handle`; credit them to the head request's consumed/remaining counters, and when a request is fully
 *   played out remove it.  Overflow rolls into the next request. */
extern "C" void iSNDstreamnotifycallback(int handle, unsigned int bytes)
{
    int S = (&sndss)[(signed char)sndStreamMap[handle]];   /* oracle lb @0x800e8df0 sign-extends */
    do {
        int          req  = MI(S, 0);                   /* head request */
        unsigned int over = 0;
        if ((unsigned int)MI(req, 0x1c) < bytes) {      /* more than remains in this request */
            over  = bytes - MI(req, 0x1c);
            bytes = bytes - over;
        }
        MI(req, 0x14) = MI(req, 0x14) + bytes;          /* consumed += */
        MI(req, 0x1c) = MI(req, 0x1c) - bytes;          /* remaining -= */
        if ((unsigned int)MI(req, 0x18) <= (unsigned int)MI(req, 0x14))   /* totalSize <= consumed */
            iSNDstreamremoverequest(MI(req, 4));
        bytes = over;
    } while (bytes != 0);
}

/* iSNDstreamparseheader @0x800E8E9C : 'SChl' chunk -- decode the audio header (rate/format) via
 *   iSNDpatchtohdr, compute the data rate, and lock the format on first sight (a mid-stream change errors
 *   to state 2).  Once locked, (re)start the packet player. */
extern "C" int iSNDstreamparseheader(int S, int data)
{
    int req = MI(S, 0) + (((int)(*(volatile unsigned char *)(S + 0x17)) << 24) >> 24) * 0x2c;
    int outsize;

    iSNDpatchtohdr((short *)(data + 0xc), (int *)(S + 0x20), (int *)(S + 0x38), &outsize);
    MI(req, 0x18) = outsize;
    STREAM_release(MI(S, 4), data);
    MI(req, 0x18) = ((MI(req, 0x18) + 0x1b) / 0x1c) * 0x1c;    /* round up to 0x1C */
    MI(req, 0x10) = iSNDplatformcalcdatarate((void *)(S + 0x20));

    if (memcmp((void *)(S + 0x1c), (void *)(S + 0x20), 4) != 0)
        goto formatdiffers;
    if (memcmp((void *)(S + 0x24), (void *)(S + 0x38), 0x14) == 0)
        goto formatsame;
formatdiffers:
    if (*(unsigned short *)(S + 0x1c) != 0) {        /* already locked -> illegal change */
        MB(S, 0x14) = 2;
        return 0;
    }
    /* lock the current format -- near-miss residual (9 diffs): oracle copies JUST the rate word
     * (this line) via an lwl/lwr+swl/swr UNALIGNED-safe pair (4 insns) even though S+0x1c/S+0x20
     * are 4-aligned; our direct `*(int*)=*(int*)` folds to a plain lw/sw (2 insns), then the 5
     * header words merge into one lw-block/sw-block that desyncs the tail. Tried: real `memcpy`
     * (this build's `memcpy` is a genuine extern call -- NOT inlined, wrong register pressure,
     * 39->92 diffs, reverted) and a `char*`-typed base-pointer indirection (no change). Likely
     * needs the TRUE original's own byte-range copy helper we don't have visibility into; accept
     * as a floor for now. */
    *(int *)(S + 0x1c) = *(int *)(S + 0x20);         /* rate word */
    *(int *)(S + 0x24) = *(int *)(S + 0x38);         /* 0x14-byte header */
    *(int *)(S + 0x28) = *(int *)(S + 0x3c);
    *(int *)(S + 0x2c) = *(int *)(S + 0x40);
    *(int *)(S + 0x30) = *(int *)(S + 0x44);
    *(int *)(S + 0x34) = *(int *)(S + 0x48);
formatsame:
    if (MB(S, 0x14) != 1) {                              /* not yet playing -> start */
        MI(S, 0x08) = SNDPKTPLAY_start(MI(S, 0xc), S + 0x1c, S + 0x24, (int *)(S + 0x4c));
        MB(S, 0x14) = 1;
    }
    return 0;
}

/* iSNDstreamparsenumchunks @0x800E9044 : 'SCCl' chunk -- record the stream's chunk count.
 * MATCH: parseIdx (+0x17) needs the LITERAL oracle shift-chain `((u8<<24)>>24)`, not the `MSB` macro's
 * `*(signed char*)` cast -- plain `(signed char)`/`(int)(signed char)` both compile to a bare `lb` and
 * gcc-2.8.0 collapses even the manual shift-chain right back to `lb` UNLESS the byte read is `volatile`
 * (blocks that specific reassociation, forcing the oracle's `lbu;sll24;sra24`). Also: the scaled-index
 * term must come FIRST in the `+ MI(S,0)` addition (index-first commutative-addu tie-break, matching
 * `addu v0,v0,v1` not `addu v1,v1,v0`). */
extern "C" int iSNDstreamparsenumchunks(int S, int data)
{
    int req;
    STREAM_release(MI(S, 4), data);
    req = (((int)(*(volatile unsigned char *)(S + 0x17)) << 24) >> 24) * 0x2c + MI(S, 0);
    MI(req, 0x24) = *(int *)(data + 0xc);
    return 1;
}

/* iSNDstreamparsedata @0x800E90AC : 'SCDl' chunk -- build the per-channel sample descriptor (flat or
 *   interleaved per the format), stamp the chunk with its owning request id (for the release hook), and
 *   submit it to the packet player. */
extern "C" int iSNDstreamparsedata(int S, int chunk)
{
    int datalen = *(int *)(chunk + 0xc);
    int desc[8];
    int numCh = MB(S, 0x1e);
    int i;

    if (MB(S, 0x2f) == 0) {                              /* flat: every channel reads chunk+0x10 */
        for (i = 0; i < numCh; i++)
            desc[3 + i] = chunk + 0x10;
    } else {                                             /* interleaved: per-channel offset table */
        int *off = (int *)(chunk + 0x10);
        for (i = 0; i < numCh; i++)
            desc[3 + i] = (chunk + 0x10) + off[i] + numCh * 4;
    }

    {
        int rounded = ((datalen + 0x1b) / 0x1c) * 0x1c;
        int req = MI(S, 0) + (((int)(*(volatile unsigned char *)(S + 0x17)) << 24) >> 24) * 0x2c;
        *(int *)(desc[3] - 4) = chunk;                   /* back-ptr just before the first sample */
        *(int *)chunk = MI(req, 4);                      /* request id -> chunk[0] */
        MI(req, 0x1c) = MI(req, 0x1c) + rounded;         /* remaining += */
        MI(req, 0x20) = MI(req, 0x20) + 1;               /* submitted++ */
        MI(req, 0x0c) = SNDPKTPLAY_submit(MI(S, 0xc), (void *)desc);
        if (MI(req, 8) < 0)
            MI(req, 8) = MI(req, 0xc);
    }
    return 1;
}

/* iSNDstreamparseend @0x800E9230 : 'SCEl' chunk -- end of one queued sound; advance parseIdx. */
extern "C" int iSNDstreamparseend(int S, int chunk)
{
    STREAM_release(MI(S, 4), chunk);
    MB(S, 0x17) = MB(S, 0x17) + 1;
    return 1;
}

/* iSNDstreamparsechunk @0x800E9270 : dispatch a chunk by its tag. */
extern "C" int iSNDstreamparsechunk(int S, int chunk)
{
    int tag = *(int *)chunk;
    int ret = 1;
    if (tag == 0x6c444353) {                             /* 'SCDl' */
        ret = iSNDstreamparsedata(S, chunk);
    } else if (tag == 0x6c484353) {                      /* 'SChl' */
        ret = iSNDstreamparseheader(S, chunk);
    } else if (tag == 0x6c454353) {                      /* 'SCEl' */
        ret = iSNDstreamparseend(S, chunk);
    } else if (tag == 0x6c434353) {                      /* 'SCCl' */
        ret = iSNDstreamparsenumchunks(S, chunk);
    } else {
        STREAM_release(MI(S, 4), chunk);                 /* unknown -> drop */
    }
    return ret;
}

/* iSNDstreamisheld @0x800E9318 : true if the stream should hold (not feed more) because the ring buffer
 *   has run low relative to the data rate -- prevents starving the player on a slow disc. */
extern "C" int iSNDstreamisheld(int S)
{
    int req = MI(S, 0) + (((int)(*(volatile unsigned char *)(S + 0x17)) << 24) >> 24) * 0x2c;

    if (MI(req, 0x10) == 0)                              /* data rate unknown -> not held */
        return 0;
    if ((((int)(*(volatile unsigned short *)(req + 0x28)) << 16) >> 16) < 0)  /* held threshold negative -> held */
        return 1;
    if ((((int)(*(volatile unsigned short *)(req + 0x28)) << 16) >> 16) == 0)  /* no threshold -> not held */
        return 0;

    {
        unsigned int avail = STREAM_gettable(MI(S, 4));
        unsigned int thresh;
        if (4000000 < avail)
            avail = 4000000;
        thresh = (unsigned int)((((int)(*(volatile unsigned short *)(req + 0x28)) << 16) >> 16));
        if (avail * 1000 / (unsigned int)MI(req, 0x10) < thresh && STREAM_state(MI(S, 4)) != 2)
            return 1;
        MH(req, 0x28) = 0;
        return 0;
        /* near-miss floor (1 insn, 9 diffs): oracle fuses the `avail<thresh` compare + STREAM_state()==2
         * check into ONE branch-sense/block-layout (clear-path physically FIRST/fallthrough, state-check
         * SECOND/branch-target, backward-jumping into a SHARED clear block). Tried 6 equivalent source
         * shapes -- goto both directions, &&-combined, split-if clear-first, split-if clear-last, named
         * `thresh` local vs inline, negated (`>=`) early-return -- ALL six compile BYTE-IDENTICAL (same
         * bnez/beqz sense, same block order). gcc-2.8.0's -O2 CFG/branch-fusion pass canonicalizes this
         * shape independent of source form; genuine scheduler/optimizer floor, not source-reachable
         * without a register-asm pin. */
    }
}

/* iSNDstreamhotroddatachunks @0x800E9438 : opportunistically pull and submit pending data chunks (up to
 *   ~0x4000 bytes total) for any playing, non-held stream that has player space -- keeps the buffer fed
 *   ahead of demand. */
extern "C" void iSNDstreamhotroddatachunks(void)
{
    int total = 0;
    int slot  = 0;
    int *p    = &sndss;
    do {
        /* near-miss residual (1 insn): oracle colors S->$s1 + the &sndss scratch via
         * lui$v0->addiu$s4 (ours: S->$s2, lui$s4 direct -- same reload/coloring tie-break
         * class as iSNDstreamnumcreated/iSNDstreamservice). Tried S at function-scope: no
         * change. The &&-chain->goto rewrite below (matching the oracle's direct per-condition
         * branch-to-`next` shape instead of a materialized boolean) already cracked the BULK
         * of this function's diffs (87->67). */
        int S = *p;
        if (S == 0)
            goto next;
        if (MB(S, 0x16) == 0)
            goto next;
        if ((((int)(*(volatile unsigned char *)(S + 0x14)) << 24) >> 24) != 1)
            goto next;
        if (iSNDstreamisheld(S) != 0)
            goto next;
        {
            int req = MI(S, 0) + (((int)(*(volatile unsigned char *)(S + 0x17)) << 24) >> 24) * 0x2c;
            if (MI(req, 0x24) != 0 && MI(req, 0x20) != 0) {      /* numChunks && submitted */
                int avail = MI(req, 0x24) - MI(req, 0x20);
                int space = SNDPKTPLAY_submitspace(MI(S, 0xc));
                int n = (avail < space) ? avail : space;
                if (0 < n) {
                    do {
                        n--;
                        int chunk = STREAM_get(MI(S, 4), 0, 0);
                        if (chunk != 0) {
                            total += *(int *)(chunk + 4);
                            iSNDstreamparsedata(S, chunk);
                        }
                    } while (0 < n && total < 0x4000);
                }
            }
        }
    next:
        slot++; p++;
    } while (slot < 1);
}

/* iSNDstreamservice @0x800E9590 : per-tick service.  For each active stream: restart the player if it
 *   flagged a format change (state 2), then, unless held, drain chunks from the ring through
 *   iSNDstreamparsechunk into the player. */
extern "C" void iSNDstreamservice(void)
{
    int slot;
    int *p;

    iSNDenteraudio();
    slot = 0;
    p    = &sndss;
    do {
        int S = *p;
        if (S != 0 && MB(S, 0x16) != 0) {                /* curReqCount != 0 */
            if ((((int)(*(volatile unsigned char *)(S + 0x14)) << 24) >> 24) == 2) {  /* needs restart */
                if (0 < SNDPKTPLAY_framesoutstanding(MI(S, 0xc)))
                    goto next;
                *(int *)(S + 0x1c) = *(int *)(S + 0x20); /* lock the new rate -- near-miss residual:
                    * oracle uses lwl/lwr+swl/swr (4 insns, SAME pattern as iSNDstreamparseheader's
                    * rate-word copy); ours folds to plain lw/sw (2 insns). Tried real memcpy() (bad
                    * -- real extern call) and a local struct-copy (no change); floor for now. */
                SNDPKTPLAY_stop(MI(S, 0xc));
                MI(S, 0x08) = SNDPKTPLAY_start(MI(S, 0xc), S + 0x1c, S + 0x24, (int *)(S + 0x4c));
                MB(S, 0x14) = 1;
            }
            if (iSNDstreamisheld(S) == 0) {
                int n, r = 0;
                if ((((int)(*(volatile unsigned char *)(S + 0x14)) << 24) >> 24) == 1) {
                    n = SNDPKTPLAY_submitspace(MI(S, 0xc));
                    if (n == 0)
                        goto next;
                } else {
                    n = 10;
                }
                do {
                    n--;
                    int chunk = STREAM_get(MI(S, 4), 0, 0);
                    if (chunk != 0)
                        r = iSNDstreamparsechunk(S, chunk);
                    if (r == 0)
                        break;
                } while (0 < n);
            }
        }
    next:
        slot++; p++;
    } while (slot < 1);
    iSNDleaveaudio();
}

/* iSNDstreamnumcreated @0x800E96F8 : count the live streams. */
extern "C" int iSNDstreamnumcreated(void)
{
    int count = 0;
    int slot;
    for (slot = 0; slot < 1; slot++) {
        if ((&sndss)[slot] != 0)
            count++;
    }
    return count;       /* near-miss floor (4 diffs): oracle's &sndss address-materialization uses
                         * `lui v0,%hi;addiu v1,v0,%lo` (v0 scratch -> v1 final); ours picks
                         * `lui v1,%hi;addiu v1,v1,%lo` (v1 direct, no scratch hop) -- a genuine
                         * gcc-2.8.0 reload scratch-register tie-break (§3.15 v0-vs-a2 family), not
                         * source-reachable. Tried: named `base` pointer local, declaration-order
                         * swap, do-while-vs-for -- all byte-identical. (Loop-SHAPE fix landed
                         * separately: array-index form vs pointer-walk took this 14->4.) */
}

/* iSNDstreamcreate @0x800E9730 : carve a stream object + its packet array, packet player and (optionally)
 *   its own ring out of `objbuf`/`memsize`, wire up the priority params, and register it.  Returns the
 *   stream slot, or a negative error.  `extFlag` reuses an external STREAM (extHandle) instead of creating
 *   one. */
extern "C" int iSNDstreamcreate(int *priority, int numReq, int pktArg, int objbuf,
                                int memsize, int extHandle, int extFlag)
{
    int S, alloc, memrem, reqBytes, oh, pktbuf, pktplay;
    int slot = 0;

    if (*(signed char *)&sndgs[0xf] == 0)                /* SND not initialised */
        return -10;
    if ((&sndss)[0] != 0)                                /* no free slot */
        return -9;

    S        = objbuf;
    alloc    = S + 0x60;                                 /* after the 0x60-byte stream header */
    memrem   = memsize - 0x60;
    reqBytes = numReq * 0x2c;
    MI(S, 0) = alloc;                                    /* packetsArray */
    alloc += reqBytes; memrem -= reqBytes;

    oh     = SNDPKTPLAY_overhead(pktArg);
    pktbuf = alloc;
    alloc += oh; memrem -= oh;
    oh     = SNDPKTPLAY_overhead(pktArg);
    pktplay = SNDPKTPLAY_create(pktbuf, oh,
                  (void *)iSNDstreamreleasecallback, (void *)iSNDstreamnotifycallback);
    MI(S, 0xc) = pktplay;
    if (pktplay < 0)
        return pktplay;
    sndStreamMap[pktplay] = (unsigned char)slot;         /* handle -> slot (asm: delay slot, always) */

    if (extFlag != 0) {                                  /* external ring */
        MI(S, 4)    = extHandle;
        MB(S, 0x18) = 1;
    } else {                                             /* own ring */
        MI(S, 4)    = STREAM_create(numReq + 1, 1, 1, alloc, memrem);
        MB(S, 0x18) = 0;
        SNDSTRM_setgreedylevel(MI(S, 4), STREAM_buffersize(MI(S, 4)) / 3);
    }
    MI(S, 0x10) = 0;
    MI(S, 0x08) = -1;
    MB(S, 0x15) = (unsigned char)numReq;
    MI(S, 0x4c) = priority[0];
    MI(S, 0x50) = priority[1];
    MI(S, 0x54) = priority[2];
    MI(S, 0x58) = priority[3];
    MI(S, 0x5c) = priority[4];

    if (iSNDstreamnumcreated() == 0) {                   /* first stream -> register the service hook */
        iSNDserveraddclient((void *)iSNDstreamservice);
        sndgs[0x22] = (int)iSNDstreamdestroyall;
    }
    (&sndss)[slot] = S;
    SNDSTRM_purge(slot);
    return slot;
}

/* iSNDstreamqueue @0x800E9970 : queue a sound on a stream -- from a file, a memory image, or an
 *   already-built STREAM request id.  Fills a fresh packet slot, stamps a unique id, and returns it.
 *   `mode`: 0=file (filename/off), 1=memory (filename=block), other=pre-built id (off). */
extern "C" int iSNDstreamqueue(unsigned int s, int name, char *filename, int off, int mode)
{
    int p, req;

    if (*(signed char *)&sndgs[0xf] == 0)
        return -10;
    p = iSNDstreamgetstreamptr(s);
    if (p == 0)
        return -8;

    iSNDenteraudio();
    if (!((int)((unsigned)MB(p, 0x16) << 0x18) < (int)((unsigned)MB(p, 0x15) << 0x18))) {  /* no room */
        iSNDleaveaudio();
        return -0xd;
    }

    req = MI(p, 0) + (((int)(*(volatile unsigned char *)(p + 0x16)) << 24) >> 24) * 0x2c;
    if (mode == 0)
        MI(req, 0) = STREAM_queuefile(MI(p, 4), filename, off, 0x6c454353);
    else if (mode == 1)
        MI(req, 0) = STREAM_queuemem(MI(p, 4), (int)filename, 0, 0x6c454353);
    else
        MI(req, 0) = off;

    if (MI(req, 0) == 0) {
        iSNDleaveaudio();
        return -1;
    }

    MI(p, 0x10) = MI(p, 0x10) + 0x100;           /* bump the id counter */
    if (MI(p, 0x10) < 0)                         /* near-miss residual: oracle leaves this bgez's
                                                   * delay slot a plain nop (store happens BEFORE
                                                   * the branch); ours schedules the store INTO the
                                                   * delay slot. Tried named `newid` temp: no change
                                                   * -- scheduler-fill floor (same class as the
                                                   * lui-scratch/lwl-lwr floors documented above). */
        MI(p, 0x10) = 0;
    MI(req, 4)  = MI(p, 0x10) | (int)s;          /* full id = counter | slot */
    MH(req, 0x28) = (short)name;
    MB(p, 0x16) = MB(p, 0x16) + 1;               /* curReqCount++ */
    MI(req, 0x10) = 0;
    MI(req, 8)    = -1;
    MI(req, 0xc)  = -1;
    MI(req, 0x14) = 0;
    MI(req, 0x1c) = 0;
    MI(req, 0x20) = 0;
    MI(req, 0x24) = 0;
    iSNDleaveaudio();
    return MI(req, 4);
}
