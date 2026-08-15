/* eaclib/psx/sndpsxz/sdmemlu.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sdmemlu.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7CEC.  SNDmemlargestunused -- find the largest free SPU-RAM gap; returns its byte size and
 *   writes its byte start to *out (both << 6 from block units).  Ghidra nfs4-f.exe.c (sdmemlu).
 *
 *   SPLIT-STORAGE FIX (wave-22 a1): a prior pass modeled snd_spu_engine_ver/block_total/reverb_mode/
 *   alloc_count as ordinary standalone extern/BSS globals OWNED by this TU. That was a genuine aliasing
 *   bug: the oracle proves (this fn + iSNDpsxmemconstrain/iSNDpsxmalloc/iSNDpsxfree in sdmemman.c +
 *   iSNDinit in slib.c + iSNDpsxfxinit in sdfx.cpp -- five independent raw-disasm cross-checks, all
 *   agreeing on the same offsets) that these fields are NOT their own linked objects: they are FIXED
 *   DISPLACEMENTS off the single `sndpd` voice/queue-state blob (@0x80147918), materialized via ONE
 *   lui/addiu(%hi/%lo(sndpd)) and read/written sndpd-relative:
 *       sndpd+0x518 = alloc_count (u16)   sndpd+0x51A = engine_ver (u16)
 *       sndpd+0x51C = block_total (u16)   sndpd+0x51E = reverb_mode (u16)
 *       sndpd+0x520..= {block:u16,size:u16}[alloc_count]  free-list table (4-byte stride)
 *   (SNDmemlargestunused's own oracle nails this directly: `lhu v0,0x518(sndpd)` for alloc_count,
 *   `lhu v0,0x51E(sndpd)` for reverb_mode, table walk from `addiu a2,sndpd,0x520`, and the post-loop tail
 *   re-materializes a FRESH symbol `D_80147E34` == sndpd+0x51C -- i.e. block_total's own address doubles
 *   as the free-list's "virtual entry[-1]" {block=block_total, size=reverb_mode} used to bound the first
 *   gap. That aliasing is REQUIRED for the algorithm to be correct, not just an address coincidence.)
 *   On a real link, standalone globals do NOT share storage with sndpd -- iSNDinit's writes (already
 *   sndpd-relative in slib.c, see its DAT_80147e32/e34) would never be observed by this fn's reads, and
 *   this fn's own pointer-arithmetic table walk ((&snd_spu_block_total)[i*2] etc) would run off into
 *   unrelated BSS instead of the real alloc table. Fixed by aliasing onto `sndpd` here (matching
 *   sdpacket.c/sdma.c/slib.c's established per-file macro-view convention -- no shared header needed,
 *   every consumer just redeclares `extern unsigned char sndpd[]` + its own local DAT_<va> macros).
 *   sdmemman.c's iSNDpsxmalloc/iSNDpsxfree and sdfx.cpp's iSNDpsxfxinit (the OTHER readers/writers of
 *   this same storage) were updated identically in the same commit so every access genuinely aliases.
 */

extern unsigned char sndpd[];   /* EA sound-driver state base @0x80147918 (shared, sdma.c/sdpacket.c/slib.c) */

/* {block,size} free-list entry, 4-byte stride */
typedef struct { unsigned short blk, sz; } SndSpuEnt;

#define SND_ALLOCCNT (*(unsigned short *)(sndpd + 0x518))  /* # of live SPU allocations */
#define SND_REVERB   (*(unsigned short *)(sndpd + 0x51E))  /* reverb-work-area boundary */
#define SND_PREVTBL  ((SndSpuEnt *)(sndpd + 0x51C))        /* virtual entry[-1] = {block_total,reverb_mode} */
#define SND_TBL      ((unsigned short *)(sndpd + 0x520))   /* real free-list table */

extern int SNDmemlargestunused(int *out);   /* @0x800E7CEC */

/* SNDmemlargestunused @0x800E7CEC : scan the gaps between SPU allocations for the biggest, in 64-byte
 *   blocks; report start (*out) and size, both converted to bytes (<<6).
 *   MATCH (w31-a2, from the raw oracle): `base` local anchors the entry/loop accesses at sndpd+0 with
 *   literal displacements (0x518/0x51E, oracle $v1); the loop hoists prevt (+0x51C, oracle $t2) and
 *   tbl (+0x520, oracle $a2); the post-loop tail deliberately does NOT use `base` (see its comment).
 *   prev entries are INDEX-form (oracle `sll i,2` in the loop-top delay slot, NOT strength-reduced --
 *   see the gap-reuse comment); `tbl` is a WALKED u16 pointer (oracle `addiu a2,a2,4` in the loop-back
 *   delay slot); both hit-arms assign `best` before `*out`. */
extern int SNDmemlargestunused(int *out)
{
    int             best, gap, i, end, n;
    unsigned short  count;
    unsigned short *tbl;
    unsigned short *prevt;
    unsigned char  *q;
    unsigned char  *base = sndpd;

    *out = 0x41;
    best = 0;
    count = *(unsigned short *)(base + 0x518);
    if (count == 0) {
        best = *(unsigned short *)(base + 0x51E) - 0x41;
    } else {
        i = 0;
        if (i < (int)count) {
            /* MATCH preamble order (oracle t2/t0/a2): prevt off the entry base, then the q COPY
             * of the base (oracle addu t0,v1,zero), then tbl off q -- the loop-side accesses
             * (tbl init + fresh count re-read) go through q, splitting the base live range. */
            prevt = (unsigned short *)(base + 0x51C);
            q = base;
            tbl = (unsigned short *)(q + 0x520);
            do {
                if (i == 0) {
                    gap = *tbl - 0x41;
                    if (best < gap)
                        best = gap;
                } else {
                    /* virtual entry[i-1]: block_total(+0x51C)/reverb_mode(+0x51E) double as the
                     * free-list's own header slot, one stride before the real table (file banner).
                     * MATCH -- do NOT "simplify" the gap-reused byte-offset arithmetic: computing
                     * the entry address into the MULTIPLY-SET `gap` variable blocks gcc loop.c
                     * induction-variable recognition (a multiply-set reg is never a giv), keeping
                     * the oracle's per-iteration `sll i,2; addu` instead of a strength-reduced
                     * walking pointer; the separate `gap += ...` statement gives the oracle's
                     * IN-PLACE `addu v1,v1,t2` (dest == sll reg). */
                    gap = i << 2;
                    gap += (int)prevt;
                    end = *(unsigned short *)gap + *(unsigned short *)(gap + 2);
                    gap = *tbl - end;
                    if (best < gap) {
                        best = gap;
                        *out = end;
                    }
                }
                /* MATCH: fresh count re-read loaded FIRST, i++ LAST (statement order chosen so the
                 * scheduler puts addiu i in the load delay and tbl += 2 in the branch delay slot). */
                n = *(unsigned short *)(q + 0x518);
                tbl += 2;
                i++;
            } while (i < n);
        }
        /* post-loop tail: also reached from the guard-skip path, where no base register is live --
         * the direct global expressions make gcc re-materialize the fused %hi/%lo(sndpd+0x51C)
         * symbol (the oracle's D_80147E34); reverb is read at +2 off it (block_total/reverb_mode
         * double as the virtual entry[-1], see banner), and the sll comes FIRST (oracle order). */
        gap = i << 2;
        gap += (int)SND_PREVTBL;
        end = *(unsigned short *)gap + *(unsigned short *)(gap + 2);
        gap = *((unsigned short *)SND_PREVTBL + 1) - end;
        if (best < gap) {
            best = gap;
            *out = end;
        }
    }
    *out = *out << 6;
    return best << 6;
}
