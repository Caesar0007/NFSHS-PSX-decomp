/* eaclib/psx/sndpsxz/sdmemlu.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 1/1 ***
 *   Source obj : nfs4\eaclib\psx\sdmemlu.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   1 fn @0x800E7CEC. SNDmemlargestunused scans the gaps between allocated SPU-RAM blocks, returns the
 *   largest size in bytes, and writes its start through `out`.
 *
 *   SPLIT-STORAGE FIX (wave-22 a1): the old standalone globals did not alias the allocator state in
 *   `sndpd` (@0x80147918). Oracle evidence across this function, sdmemman.c, slib.c, and sdfx.c places
 *   the fields at fixed offsets from that single base:
 *       +0x518 alloc_count  +0x51A engine_ver  +0x51C block_total  +0x51E reverb_mode
 *       +0x520 free-list entries, each {block:u16,size:u16}, 4-byte stride
 *   `sndmempriv.h` now models these fields as `SndSpuMemoryState` and the 0x80-entry table as
 *   `SndSpuMemoryStateView`. Its union at +0x51C also represents the allocator's virtual entry[-1]
 *   ({block=block_total,size=reverb_mode}), which bounds the first and trailing gaps.
 *   The consumers share this typed view; the tail below still uses a fresh sndpd-relative expression
 *   because that symbol materialization is part of the byte-matched code generation.
 */
#include "sdmemlu.h"
#include "slib.h"
#include "snd_state.h"
#include "sndmempriv.h"


/* SNDmemlargestunused @0x800E7CEC : scan the gaps between SPU allocations for the biggest, in 64-byte
 *   blocks; report start (*out) and size, both converted to bytes (<<6).
 *   MATCH (w31-a2, from the raw oracle): `base` local anchors the entry/loop accesses at sndpd+0 with
 *   literal displacements (0x518/0x51E, oracle $v1); the loop hoists prevt (+0x51C, oracle $t2) and
 *   tbl (+0x520, oracle $a2); the post-loop tail deliberately does NOT use `base` (see its comment).
 *   prev entries retain INDEX-form (oracle `sll i,2` in the loop-top delay slot, NOT strength-reduced --
 *   see the gap-reuse comment); `tbl` is a walked SndSpuFreeBlock pointer (oracle `addiu a2,a2,4` in
 *   the loop-back delay slot); both hit-arms assign `best` before `*out`. */
int SNDmemlargestunused(unsigned char **out)
{
    int             best, gap, i, end, n;
    unsigned short  count;
    struct SndSpuFreeBlock *tbl;
    struct SndSpuFreeBlock *prevt;
    unsigned char  *q;
    unsigned char  *base = sndpd;

    *out = (unsigned char *)0x41;
    best = 0;
    count = ((struct SndSpuMemoryStateView *)base)->memory.alloc_count;
    if (!count) {
        best = ((struct SndSpuMemoryStateView *)base)->memory.boundary.view.limits.reverb_mode - 0x41;
    } else {
        i = 0;
        if (i < count) {
            /* MATCH preamble order (oracle t2/t0/a2): prevt off the entry base, then the q COPY
             * of the base (oracle addu t0,v1,zero), then tbl off q -- the loop-side accesses
             * (tbl init + fresh count re-read) go through q, splitting the base live range. */
            prevt = &((struct SndSpuMemoryStateView *)base)->memory.boundary.view.virtual_previous;
            q = base;
            tbl = ((struct SndSpuMemoryStateView *)q)->entries;
            n = count;
            for (; i < n;
                 n = ((struct SndSpuMemoryStateView *)q)->memory.alloc_count, tbl++, i++) {
                if (!i) {
                    gap = tbl->block - 0x41;
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
                    end = ((struct SndSpuFreeBlock *)(unsigned int)gap)->block +
                          ((struct SndSpuFreeBlock *)(unsigned int)gap)->size;
                    gap = tbl->block - end;
                    if (best < gap) {
                        best = gap;
                        *out = (unsigned char *)(unsigned int)end;
                    }
                }
            }
        }
        /* post-loop tail: also reached from the guard-skip path, where no base register is live --
         * the direct global expressions make gcc re-materialize the fused %hi/%lo(sndpd+0x51C)
         * symbol (the oracle's D_80147E34); reverb is read at +2 off it (block_total/reverb_mode
         * double as the virtual entry[-1], see banner), and the sll comes FIRST (oracle order). */
        gap = i << 2;
        gap += (int)&((struct SndSpuMemoryStateView *)sndpd)->memory.boundary.view.virtual_previous;
        end = ((struct SndSpuFreeBlock *)(unsigned int)gap)->block +
                          ((struct SndSpuFreeBlock *)(unsigned int)gap)->size;
        gap = ((struct SndSpuMemoryStateView *)sndpd)->memory.boundary.view.virtual_previous.size - end;
        if (best < gap) {
            best = gap;
            *out = (unsigned char *)(unsigned int)end;
        }
    }
    *out = (unsigned char *)((unsigned int)*out << 6);
    return best << 6;
}
