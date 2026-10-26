/* W52-A8 2026-08-09 -- GCC-LADDER identity probe (04U lane); see the block below.
 * W52-A8 GCC-LADDER: identity = gcc-2.8.0 + maspsx (the DEFAULT lane).
 *
 *   lane            iSNDstreamparsedata
 *   default         13 (98/97)
 *   2.6.0           compile error
 *   2.6.3           compile error
 *   2.7.2-970404    17 (98/97)
 *   2.7.2           39 (98/97)
 *   2.8.0 CONTROL   13 (98/97)
 *   2.8.1           13 (98/97)
 *   2.91.66        105 (94/97)
 *   2.95.2          88 (95/97)
 *
 * READING: only 2.8.0/2.8.1 reproduce the default; compiler-version axis closed.
 */
/* eaclib/psx/sndpsxz/sst.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 16/16 ***
 *
 *   COMPILED AS C by USER RULING (2026-07-25, uniformity; w26-a4 manual C89 port -- the automated
 *   dialect fixer did not converge on this TU). Pre-migration (.cpp/cc1plus) vs post-migration
 *   (.c/cc1) per-fn diff counts, verify_asm.py authoritative -- IDENTICAL, zero regressions:
 *     iSNDstreamdestroyall=PASS(0)      iSNDstreamgetstreamptr=PASS(0)   iSNDstreamremoverequest=PASS(0)
 *     iSNDstreamreleasecallback=PASS(0) iSNDstreamnotifycallback=PASS(0) iSNDstreamparseheader=PASS(0)
 *     iSNDstreamparsenumchunks=PASS(0)  iSNDstreamparsedata=PASS(0)      iSNDstreamparseend=PASS(0)
 *     iSNDstreamparsechunk=PASS(0)      iSNDstreamisheld=PASS(0)         iSNDstreamhotroddatachunks=PASS(0)
 *     iSNDstreamservice=PASS(0)         iSNDstreamnumcreated=PASS(0)     iSNDstreamcreate=PASS(0)
 *     iSNDstreamqueue=PASS(0)
 *   16/16 PASS. Do NOT revert to .cpp without user decision.
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
 *   ===== stream object S (one slot, sndss[0], size 0x60) =====
 *     +0x00 requests (SndStreamReq[...])   +0x04 stream_handle   +0x08 start_result
 *     +0x0C packet_player   +0x10 request_counter   +0x14..+0x18 state/capacity/count/index/external flag
 *     +0x1C locked_rate   +0x20 current_rate   (each a 4-byte SNDSAMPLEFORMAT)
 *     +0x24 locked_header   +0x38 current_header   +0x4C start_params (SNDPLAYOPTS)
 *     locked_rate.channels @+0x1E   locked_header.use3dpos @+0x2F
 *   ===== request (0x2C) =====
 *     +0x00 STREAM request token   +0x04 full id (counter|slot)
 *     +0x08 first submitted packet id   +0x0C latest submitted packet id
 *     +0x10 data rate   +0x14 bytes consumed   +0x18 total size (rounded to 0x1C)   +0x1C remaining
 *     +0x20 submitted count   +0x24 num chunks   +0x28(short) hold threshold/name arg   +0x2A padding
 */
#include "sdata.h"
#include "sndserverpriv.h"
#include "../eacpsxz/stream.h"
#include "sdpacket.h"
#include "ssysserv.h"
#include "sstsetgl.h"
#include "spat2hdr.h"
#include "spvoices.h"
#include "spktplay.h"
#include "sserver.h"
#include "sst.h"
#include "sstpriv.h"
#include "sndpacketpriv.h"
#include "sndcrtpriv.h"

/* W65-A6 DATA-MAT (BSS run @0x8013EA80, 8 bytes, ends exactly at gFileDevice @0x8013EA88):
 *   sndss @0x8013EA80 size 4   +   sndStreamMap @0x8013EA84 size 4.
 * `sndss` was extern-only tree-wide (24 reloc-referenced undefined sites).  The old
 * `unsigned char sndStreamMap[64]` def also OVERRAN the retail run by 60 bytes, i.e. into
 * gFileMgr/gFileDevice's storage (a real latent clobber in a recompiled image).
 * DEVICE: a file-scope asm .bss definition, not a C tentative definition -- both objects are
 * <= the TU's -G4, and maspsx routes a `.comm` of size <= -G into `.section .sbss` WITHOUT a
 * `.globl` (maspsx/__init__.py: sbss_entries; the `.globl` guard fires for `bss` only), which
 * would make them LOCAL (not fixing the link) AND flip cc1 to gp-relative addressing.  The
 * oracle has ZERO `%gp_rel(sndss)`/`%gp_rel(sndStreamMap)` sites, so retail addressed them
 * absolutely -- the C view must therefore stay `extern` (byte-neutral by construction). */
SndStream *sndss[1] __attribute__((section(".bss"))) = { 0 };
unsigned char sndStreamMap[4] __attribute__((section(".bss"))) = { 0 };

/* ---- SNDPKTPLAY packet-player declarations come from the owner header spktplay.h. ---- */
/* ---- internal forward decls (mutually recursive) ---- */

/* ====================================================================================== */

/* iSNDstreamdestroyall @0x800E8C14 : destroy every stream (addexit/shutdown hook). */
int iSNDstreamdestroyall(void)
{
    int s;
    for (s = 0; s < 1; s++)
        SNDSTRM_destroy(s);
    return 0;
}

/* iSNDstreamgetstreamptr @0x800E8C48 : map a stream index to its object (only index 0 exists). */
SndStream *iSNDstreamgetstreamptr(int idx)
{
    if (idx)
        return 0;
    return sndss[0]; /* MATCH (7/7): array storage plus the negative guard preserves both return tails. */
}

/* iSNDstreamremoverequest @0x800E8C64 : drop the request whose id == `reqid` from a stream's packet
 *   array, compacting the remaining requests down and fixing up parseIdx/curReqCount. */
void iSNDstreamremoverequest(unsigned int reqid)
{
    /* struct-assignment (not a memcpy() call) for the compaction copy below -- oracle expands it
     * inline as a manual 4-word+3-word unrolled load/store (this build's memcpy() is a genuine
     * extern call, never inlined; the true original must have used a real struct copy, letting
     * gcc do the copy itself). The PC implementation confirms the void ABI and uses int source/
     * destination indices. Keeping the compacted index and loop index as function-scope ints gives
     * the oracle's shared-zero register allocation; fresh volatile field reads preserve its exact
     * load order and scheduling. MATCH (75/75). */
    SndStream **base = sndss;
    SndStream *S     = base[reqid & 0xff];
    int  newidx  = 0;            /* write index (compacted) */
    int  i       = 0;

    if (0 < (int)((unsigned)S->current_count << 0x18)) {     /* curReqCount > 0 (signed) */
        int rd = 0, wr = 0;
        do {
            SndStreamReq *src = (SndStreamReq *)((int)(unsigned int)((volatile SndStream *)S)->requests + rd);          /* MATCH: oracle re-reads packetsArray
                        * (S+0) FRESH every loop iteration (and again for the compaction dest below)
                        * rather than caching it once -- same volatile-reread lever as the other
                        * fields in this file. */
            if (src->request_id != reqid) {                 /* keep this request */
                if ((((int)(((volatile SndStream *)S)->parse_index) << 24) >> 24) == i)  /* MATCH:
                        * literal shift-chain, not the MSB macro's plain cast (same lever as
                        * iSNDstreamparsenumchunks/isheld/etc -- forces the oracle's lbu+sll+sra
                        * instead of a single lb) -- parseIdx pointed at it -> retarget */
                    S->parse_index = newidx;
                *(SndStreamReq *)(wr + (int)(unsigned int)((volatile SndStream *)S)->requests) = *src;
                wr += sizeof(SndStreamReq);
                newidx += 1;
            }
            rd += sizeof(SndStreamReq);
            i++;
        } while (i < (((int)(((volatile SndStream *)S)->current_count) << 24) >> 24));
    }
    ((volatile SndStream *)S)->current_count =
        ((volatile SndStream *)S)->current_count - 1;        /* curReqCount-- */
    if ((int)((unsigned)((volatile SndStream *)S)->parse_index << 0x18) >
        (int)((unsigned)((volatile SndStream *)S)->current_count << 0x18)) {  /* MATCH: oracle re-reads
                        * BOTH bytes fresh from memory for this compare (not the just-decremented/
                        * loop value still in a register); parseIdx (0x17) is evaluated FIRST. */
        int ret = ((volatile SndStream *)S)->parse_index - 1;  /* MATCH: parseIdx reloaded AGAIN here,
                        * not reused from the compare above. */
        S->parse_index = (unsigned char)ret;
    }
}

/* iSNDstreamreleasecallback @0x800E8D90 : SNDPKTPLAY release hook -- a finished sample buffer carries a
 *   back-pointer to its chunk 4 bytes ahead; the chunk's first word holds the request id whose low byte
 *   is the stream slot.  Free the chunk back to that stream's ring. */
void iSNDstreamreleasecallback(unsigned char *sample)
{
    unsigned char *chunk = *(unsigned char **)(sample - 4);
    int slot  = *chunk;
    SndStream *S = sndss[slot];
    STREAM_release(S->stream_handle, chunk);
    /* MATCH (17/17): the true sndss[] declaration fills the chunk-load delay slot with its address. */
}

/* iSNDstreamnotifycallback @0x800E8DD4 : SNDPKTPLAY play-progress hook.  `bytes` were just played on
 *   `handle`; credit them to the head request's consumed/remaining counters, and when a request is fully
 *   played out remove it.  Overflow rolls into the next request. */
void iSNDstreamnotifycallback(int handle, unsigned int bytes)
{
    SndStream **base = sndss;
    SndStream *S = base[*(signed char *)((char *)base + handle + 4)]; /* oracle lb @0x800e8df0 sign-extends */
    unsigned int over = 0;                              /* MATCH: initialized ONCE before the loop
                                                          * (oracle sets $s0=0 right after the byte
                                                          * load, before the array-index scaling) */
    for (;;) {
        SndStreamReq *req = S->requests; /* head request */
        if (((volatile SndStreamReq *)req)->remaining_bytes < bytes) {     /* more than remains in this request */
            over  = bytes - ((volatile SndStreamReq *)req)->remaining_bytes;              /* MATCH: fresh re-read (volatile) */
            bytes -= over;
        }
        ((volatile SndStreamReq *)req)->bytes_consumed = ((volatile SndStreamReq *)req)->bytes_consumed + bytes;         /* consumed += */
        ((volatile SndStreamReq *)req)->remaining_bytes = ((volatile SndStreamReq *)req)->remaining_bytes - bytes;         /* remaining -= */
        if ((unsigned int)((volatile SndStreamReq *)req)->bytes_consumed >=
            (unsigned int)((volatile SndStreamReq *)req)->total_size)
            iSNDstreamremoverequest(((volatile SndStreamReq *)req)->request_id);
        bytes = over;
        if (!bytes)                                 /* MATCH: exit-in-the-middle -- prevents
                                                          * the do-while bottom-test rotation */
            break;
        over = 0;
    }
}
/* MATCH (NFS4 sound layout + disasm-v4 trace, 18->0 diffs): sndStreamMap is the byte immediately
 * following the one-entry sndss array, so `base` must serve both the +4 map load and indexed stream
 * lookup.  Resetting `over` only at the loop back-edge preserves its entry initialization and lets
 * gcc place the reset in the oracle's jump delay slot. */

/* iSNDstreamparseheader @0x800E8E9C : 'SChl' chunk -- decode the audio header (rate/format) via
 *   iSNDpatchtohdr, compute the data rate, and lock the format on first sight (a mid-stream change errors
 *   to state 2).  Once locked, (re)start the packet player. */
int iSNDstreamparseheader(SndStream *S, SndStreamChunkHeaderPrefix *data)
{
    SndStreamReq *req = S->requests + (signed char)((volatile SndStream *)S)->parse_index;
    int outsize;

    iSNDpatchtohdr((unsigned char *)data + 0xc, &S->current_rate, &S->current_header.attributes, &outsize);
    ((volatile SndStreamReq *)req)->total_size = outsize;
    STREAM_release(S->stream_handle, (unsigned char *)data);
    ((volatile SndStreamReq *)req)->total_size = ((((volatile SndStreamReq *)req)->total_size + 0x1b) / 0x1c) * 0x1c;    /* round up to 0x1C */
    ((volatile SndStreamReq *)req)->data_rate = iSNDplatformcalcdatarate(&S->current_rate);

    if (memcmp(&S->locked_rate, &S->current_rate, sizeof(SNDSAMPLEFORMAT)) ||
        memcmp(&S->locked_header, &S->current_header, sizeof(SndPatchAttributes))) {
        if (S->locked_rate.samplerate) {    /* already locked -> illegal change */
            ((volatile SndStream *)S)->state = 2;
            return 0;
        }
        S->locked_rate = S->current_rate;
        S->locked_header = S->current_header;
    }
    if ((((int)(((volatile SndStream *)S)->state) << 24) >> 24) != 1) {  /* MATCH: shift-chain,
                        * not the MB macro's plain compare -- not yet playing -> start */
        S->start_result = SNDPKTPLAY_start(S->packet_player, &S->locked_rate,
                                         &S->locked_header,
                                         &S->start_params);
        S->state = 1;
    }
    return 0;
}

/* iSNDstreamparsenumchunks @0x800E9044 : 'SCCl' chunk -- record the stream's chunk count.
 * MATCH: preserve the oracle's sign-extension shift-chain for parse_index and scaled-index-first
 * address-sum order. `req` is a SndStreamReq * and the member is accessed directly. A natural typed
 * pointer-add candidate compiled to the same count but reversed the addu destination/source roles
 * (4 ASM diffs); this target-specific address formation is retained for exact codegen. */
int iSNDstreamparsenumchunks(SndStream *S, SndStreamChunkHeaderPrefix *data)
{
    SndStreamReq *req;
    STREAM_release(S->stream_handle, (unsigned char *)data);
    req = (SndStreamReq *)((((int)(((volatile SndStream *)S)->parse_index) << 24) >> 24) * (int)sizeof(SndStreamReq) + (int)(unsigned int)S->requests);
    req->num_chunks = data->value.chunk_count;
    return 1;
}

/* iSNDstreamparsedata @0x800E90AC : 'SCDl' chunk -- build the per-channel sample descriptor (flat or
 *   interleaved per the format), stamp the chunk with its owning request id (for the release hook), and
 *   submit it to the packet player. */
int iSNDstreamparsedata(SndStream *S, SndStreamChunkHeaderPrefix *chunk)
{
    /* MATCH (oracle re-traced in full, incl. delay slots -- was untouched, 123 diffs):
     * -- the `datalen` local is SPILLED to the stack at fn entry and only reread once, at the
     *    tail, to build `rounded` -- reproduced by REASSIGNING the same variable (not a fresh
     *    local), which gives it exactly that "write once near top, read once near tail" shape.
     * -- BOTH channel loops write through a WALKING pointer `dp` that starts at `desc[0]` (NOT
     *    `&desc[3]`) and always stores to the FIXED relative slot `dp[3]`, advancing `dp` (not
     *    the index) each iteration -- oracle's per-iter store is a constant `+0xc(v1)` displacement
     *    off a pointer that itself gets `+=4`'d in the loop-back branch's delay slot (so it runs
     *    on every iteration, unconditionally) -- i.e. a genuine C `dp++` in the loop, not an
     *    index-form `desc[3+i]` (that folds gcc's IV to base=desc+3/disp=0, not base=desc/disp=0xc).
     * -- oracle re-reads `locked_rate.channels` FRESH every loop iteration for the exit test (separate
     *    lbu each time) though the zero-guard + interleaved end-pointer calc use ONE read before
     *    the loop -- reproduced with a direct member read in the loop condition.
     * -- interleaved case walks a SEPARATE pointer `off` over the offset table and adds it to an
     *    END-of-table base (`chunk+0x10+numCh*4`) computed ONCE, not `off[i]` index form. */
    int step;
    SndPacketSubmitFrameView desc;
    int i;
    unsigned char *flatPtr;

    desc.fields.data_size = chunk->value.data_size;                     /* stash datalen in an unused desc slot --
                                                           * gcc doesn't naturally spill a plain local
                                                           * across the loops (register free the whole
                                                           * time); the oracle's stack round-trip through
                                                           * THIS exact address (sp+0x14=desc+4) only
                                                           * reproduces via a real store to desc[1]. */

    step = 0;
    if (!S->locked_header.attributes.use3dpos) {                              /* flat: every channel reads chunk+0x10 */
        unsigned char *flatBase;
        /* The one-trip wrapper is instruction-free, but gives gcc's flow pass the retail
         * reference weight for flatBase; this fixes its preheader/IV allocation (13 -> 9). */
        do {
            flatBase = (unsigned char *)chunk + 0x10;
        } while (0);
        i = step;
        if (i < S->locked_rate.channels) {
            int *dp;
            flatPtr = flatBase;
            /* Keep the seed source live past its copy without emitting code.  Otherwise
             * cc1 copy-propagates flatPtr back into flatBase and deletes retail's a3->a2 move. */
            if (flatBase)
                dp = desc.words;
            else
                dp = desc.words;                              /* MATCH: base ptr materialized ONLY here --
                                                           * oracle's `v1=sp+0x10` sits AFTER the
                                                           * numCh!=0 guard, not hoisted to fn scope. */
            do {
                ((SndPacketSubmitFrameView *)dp)->fields.channel_data[0] = (unsigned char *)(unsigned int)((int)(unsigned int)flatPtr + (int)(unsigned int)flatBase - (int)(unsigned int)flatBase);   /* zero-net use extends flatBase into loop */
                flatPtr += step;
                dp++;
            } while (S->locked_rate.channels > ++i);
        }
    } else {                                             /* interleaved: per-channel offset table */
        int *off = (int *)((unsigned char *)chunk + 0x10);
        unsigned char *base = (unsigned char *)off + S->locked_rate.channels * 4;
        i = 0;
        if (i < S->locked_rate.channels) {
            int *dp = desc.words;
            for (; i < S->locked_rate.channels; off++, i++, dp++) {
                ((SndPacketSubmitFrameView *)dp)->fields.channel_data[0] = base + *off;
            }
        }
    }

    flatPtr = desc.fields.channel_data[0];
    desc.fields.data_size = ((desc.fields.data_size + 0x1b) / 0x1c) * 0x1c;          /* round up to 0x1C -- reload of the spill */
    {
        SndStreamReq *req = S->requests + (signed char)((volatile SndStream *)S)->parse_index;
        *(unsigned char **)(flatPtr - 4) = (unsigned char *)chunk; /* back-ptr just before the first sample */
        *(int *)chunk = req->request_id;                      /* request id -> chunk[0] */
        ((volatile SndStreamReq *)req)->remaining_bytes = ((volatile SndStreamReq *)req)->remaining_bytes + desc.fields.data_size;       /* remaining += */
        ((volatile SndStreamReq *)req)->submitted = ((volatile SndStreamReq *)req)->submitted + 1;             /* submitted++ */
        ((volatile SndStreamReq *)req)->qid = SNDPKTPLAY_submit(S->packet_player, (void *)&desc);
        if (((volatile SndStreamReq *)req)->firstqid < 0)
            req->firstqid = ((SndStreamReq *)req)->qid;
    }
    return 1;
}
/* near-miss (123->9 diffs, ours 98 / oracle 97 insns). Volatile qualification on the 4 request-field
 * read/writes was needed to stop gcc from interleaving the 0x1c/0x20/0xc/8 field updates (oracle
 * does each field's read-op-write as one clean sequential block). The flat loop's explicit
 * `flatBase + offset` form preserves the oracle's separate zero-step induction register (`t1`) while
 * retaining the required walking descriptor pointer; it improves the former 17-diff pointer-walk
 * form to 13. Residual has two clusters:
 * (1) flat-loop only -- ours initializes a separate zero offset and adds `flatBase` each iteration;
 * oracle strength-reduces that pair into a derived induction value initialized from `flatBase` and
 * advanced by the zero step. Direct derived-value and index forms both lose the useful register/IV
 * split and regress to 17-68 diffs.
 * (2) tail scheduling -- oracle schedules the `desc[3]` reload (for the back-ptr store) into the `mult`
 * instruction's latency-fill slot, before `mfhi`; ours schedules it after. Tried hoisting the read
 * into its own local before the round-up division (`int backAddr=desc[3];`) -- gcc rescheduled
 * identically either way (RTL-level list-scheduler decision, not source-reachable).
 *
 * W33-a8 RE-VERDICT on cluster (1) -- root cause now EXACT, and it is a toolchain identity, not a
 * source shape.  The oracle is a plain walking pointer seeded in the loop preheader:
 *     addiu $a3,$a1,0x10        <- flatBase, before the numCh guard
 *     addu  $a2,$a3,$zero       <- REDUNDANT COPY, loop preheader
 *   .L: sw $a2,0xC($v1) / addu $a2,$a2,$t1
 * Writing exactly that in C (`int ptr = flatBase;` + `dp[3] = ptr; ptr += step;`) produces the right
 * loop body but our cc1 COPY-PROPAGATES the `a2 = a3` seed away -- ours 96 insns vs oracle 97, i.e.
 * one instruction SHORT, and 23 diffs.  So the `flatBase + offset` accumulator form kept here is not
 * a mis-derivation of the source: it is the only spelling that keeps the instruction count at
 * parity, and the residual is the sndpsxz-wide "old-gcc no-copy-prop" identity (retail's cc1 keeps a
 * redundant register copy that ours folds), already triple-confirmed for this archive in w31/w32.
 * NO SLD EVIDENCE IS AVAILABLE for this TU -- see the sndpsxz SLD note; the SYM carries only a type-2
 * symbol record for every sst.obj function, no `8c Function start` block and no line records.
 * Also tested (a3's "redundant copy = a SECOND source evaluation" lever): spelling the seed as a
 * literal re-evaluation `int ptr = chunk + 0x10;` alongside the named `flatBase` -- our cse.c folds
 * the two and copy-prop then deletes the copy, so it still lands at 96 insns (17 diffs).  The seed
 * copy is unreachable from C on this compiler.
 *
 * W35-a6 2026-07-26: independently re-derived and re-measured; every number above REPRODUCES, and
 * the trichotomy's third branch (loop.c GIV ANCHOR -- the one branch the earlier waves had not
 * applied to the seed copy) was added and also fails.  The reasoning was that a giv's preheader
 * initialisation is emitted as a COPY of its base, which is exactly the oracle's `addu a2,a3,zero`;
 * so the offset was respelled as a genuine giv `dp[3] = flatBase + i * step;` (variable stride, i
 * already the loop counter starting at 0, so it is value-identical).  loop.c does strength-reduce
 * it, but it folds the seed into the base register just like the direct form: 23 diffs at 96 insns,
 * and the index-form twin `desc[3 + i] = flatBase + i * step;` is worse still at 36 (99/97, the
 * combine_givs merge this archive shows everywhere).  Full w35 measurement set, all vs 13/98:
 * direct `addr = chunk + 0x10` 17 (96/97) | named base + copy 17 (96/97) | double evaluation
 * (`flatBase` and `addr` both spelled `chunk + 0x10`) 17 (96/97) | giv `i * step` 23 (96/97) |
 * giv index form 36 (99/97) | `off` hoisted above the flat/interleaved branch and copied in the
 * flat arm 20 (95/97).  All three trichotomy branches are now closed, so cluster (1) is a STRONG
 * no-copy-prop identity floor.  Cluster (2) re-confirmed unchanged: the oracle sinks the
 * `lw desc[3]` reload into the `mult`/`mfhi` latency window (oracle index 48) where ours issues it
 * after the quotient store (index 58) -- a list-scheduler decision, source-order-immune.
 * 🔴 w49-a8 2026-08-08: cluster (1)'s STRONG no-copy-prop verdict SURVIVES the w47 opacity fence,
 * which is the lever that was invented for exactly this symptom ("keep a retail reg-reg copy alive
 * that coalescing would delete") and which cracked trnsmult's sibling residual the same session.
 * Measured on the walking-pointer seed form (`int ptr = flatBase; dp[3] = ptr; ptr += step;`):
 * no fence 23 (96/97) | opacity fence on `ptr` after the seed 41 (96/97) | use fence 23 (96/97)
 * | void barrier 23 (96/97).  All still 96 insns, i.e. the seed copy is STILL deleted -- because
 * the fence's fresh def is of the DESTINATION, so copy-prop simply forwards `flatBase` into the
 * asm's input and the copy dies anyway.  (trnsmult's fence works because there the fence redefines
 * the SOURCE, `a`, between its two consumers.)  There is no second consumer of `flatBase` here to
 * fence between, so that route is structurally unavailable.  Cluster (1) stays a STRONG floor.
 * w50-a8 2026-08-09 -- CLUSTER (1)'s STRONG FLOOR IS REFUTED (not landed: the new basin is 14 vs
 * the kept 13, so the honest-count rule forbids it -- but the mechanism verdict above is WRONG and
 * must not be re-quoted).  A SECOND CONSUMER IS NOT REQUIRED: it is enough for the opacity fence to
 * redefine the SOURCE *after* the copy, which blocks copy-prop from forwarding it into the copy's
 * later uses.  On the walking-pointer seed form:
 *     int ptr;  ...  int *dp = desc.words;
 *     ptr = flatBase;
 *     __asm__("" : "=r"(flatBase) : "0"(flatBase));   <-- redefines the SOURCE, 0 insns
 *     do { dp[3] = ptr; ptr += step; dp++; } while (...);
 * gates 14 at COUNT-EXACT 97/97 (the kept form is 13 at 98/97, one insn LONG) and reproduces
 * retail's `addiu a3,a1,0x10 / addu <seed>,a3,zero / sw <seed>,0xC(<dp>) / addu <seed>,<seed>,t1`
 * flat loop instruction-for-instruction.  The fence MUST sit immediately after the seed copy;
 * before it (P2) or as a plain use fence (P3) leaves 23 @ 96/97, i.e. the copy still dies.
 * THE WHOLE REMAINING 14 IS ONE PAIR SWAP: retail colours seed=$a2 / dp=$v1, ours seed=$v1 /
 * dp=$a2 (plus one cascaded `lw ?,28(sp)` at the tail).  Falsified against it, all 97/97:
 * emitting the seed BEFORE `dp = desc` (14 -- the order changes, the colours do NOT, so this is a
 * qty-PRIORITY tie, not the emission-order/born-first rule that cracked SNDPKTPLAY_submit); the
 * fence between the two inits (40); a `ptr` declared inside the guard block (40); do{}while(0) ref
 * inflators on `dp++` (30), on `ptr += step` (36), on the store (34) -- all in-loop wrappers pay
 * their sched barrier; a wrapper on `dp = desc` itself (14, inert); one or two zero-insn use
 * fences on `dp` in the preheader (34); and both in-loop statement orders (14 each).
 * ==> next lever must raise `dp`'s qty priority (or lower the seed's) with a device that is NOT a
 * scheduling barrier inside the loop body.
 *
 * w58 2026-08-11: a one-trip do/while wrapper around the flatBase definition supplies that missing
 * flow-reference weight without emitting code or disturbing the loop schedule. It corrects the
 * preheader order and reduces the kept basin from 13 to 9. The remaining flat residual is the
 * extra zero-offset/add pair versus retail's preserved base-to-derived-IV copy; the other four
 * lines remain the independently confirmed post-allocation scheduler placement of desc[3]. */
/* w64 2026-08-12 -- 9 -> 4 at exact 97/97, using the Sled Storm PSX twin plus the approved
 * fork-corpus pure-C allocation idioms.  Sled's byte-identical routine confirms the flat arm is a
 * distinct pointer seeded from chunk+0x10 and advanced by the zero step.  An identical-arm `dp`
 * assignment keeps the seed source live, and `flatPtr + flatBase - flatBase` carries that lifetime
 * into the loop; together they preserve retail's otherwise-copy-propagated a3->a2 seed.  The two
 * zero guards are written as `i < numChannels`, adding exactly two REG_N_REFS to i (14 -> 16), the
 * qtytrace/allocsim-predicted floor_log2 step that swaps i/flatPtr into retail's a0/a2 handout.
 * All flat and interleaved instructions/registers now match.  The only residual is the independent
 * sched2 placement of the same desc[3] load/store pair: retail fills the mult/mfhi latency slot;
 * ours emits it after the rounded-length store. */
/* W65 2026-08-12 -- 4 -> PASS at exact 97/97 via the PS1-fork disjoint-lifetime-reuse idiom.
 * Hoisting flatPtr to function scope lets its dead flat-loop identity carry desc[3] after the two
 * arms.  It already owns retail's a2 allocation, so gcc schedules the reload into the mult/mfhi
 * latency slot and emits the store through a2 without any fence, extra instruction, or asm. */

/* iSNDstreamparseend @0x800E9230 : 'SCEl' chunk -- end of one queued sound; advance parseIdx. */
int iSNDstreamparseend(SndStream *S, unsigned char *chunk)
{
    STREAM_release(S->stream_handle, chunk);
    S->parse_index = S->parse_index + 1;
    return 1;
}

/* iSNDstreamparsechunk @0x800E9270 : dispatch a chunk by its tag. */
int iSNDstreamparsechunk(SndStream *S, unsigned char *chunk)
{
    int tag = *(int *)chunk;
    int ret = 1;
    if (tag == 0x6c444353) {                             /* 'SCDl' */
        ret = iSNDstreamparsedata(S, (SndStreamChunkHeaderPrefix *)chunk);
    } else if (tag == 0x6c484353) {                      /* 'SChl' */
        ret = iSNDstreamparseheader(S, (SndStreamChunkHeaderPrefix *)chunk);
    } else if (tag == 0x6c454353) {                      /* 'SCEl' */
        ret = iSNDstreamparseend(S, chunk);
    } else if (tag == 0x6c434353) {                      /* 'SCCl' */
        ret = iSNDstreamparsenumchunks(S, (SndStreamChunkHeaderPrefix *)chunk);
    } else {
        STREAM_release(S->stream_handle, chunk);                 /* unknown -> drop */
    }
    return ret;
}

/* iSNDstreamisheld @0x800E9318 : true if the stream should hold (not feed more) because the ring buffer
 *   has run low relative to the data rate -- prevents starving the player on a slow disc. */
int iSNDstreamisheld(SndStream *S)
{
    SndStreamReq *req = S->requests + (signed char)((volatile SndStream *)S)->parse_index;

    if (!req->data_rate)                              /* data rate unknown -> not held */
        return 0;
    if (((volatile SndStreamReq *)req)->hold_threshold < 0)  /* held threshold negative -> held */
        return 1;
    if (!((volatile SndStreamReq *)req)->hold_threshold)  /* no threshold -> not held */
        return 0;

    {
        unsigned int avail = STREAM_gettable(S->stream_handle);
        int thresh;
        if (avail > 4000000)
            avail = 4000000;
        thresh = ((volatile SndStreamReq *)req)->hold_threshold;
        /* MATCH (disasm-v4 trace, 9->0 diffs): keep the clear-threshold block physically before
         * the state check.  The true comparison branches forward to `check_state`; state==2 then
         * branches backward into the shared clear block, while state!=2 falls through with 1. */
        if (avail * 1000 / req->data_rate < thresh)
            goto check_state;
clear_threshold:
        req->hold_threshold = 0;
        return 0;
check_state:
        if (STREAM_state(S->stream_handle) == 2)
            goto clear_threshold;
        return 1;
    }
}

/* iSNDstreamhotroddatachunks @0x800E9438 : opportunistically pull and submit pending data chunks (up to
 *   ~0x4000 bytes total) for any playing, non-held stream that has player space -- keeps the buffer fed
 *   ahead of demand. */
void iSNDstreamhotroddatachunks(void)
{
    int total = 0;
    int slot  = 0;
    SndStream **p = sndss;
    do {
        /* MATCH: the zero-iteration guard scope below is behavior-neutral, but gives GCC
         * the oracle's saved-register coloring for S and the later availability value. */
        SndStream *S = *p;
        if (!S)
            goto next;
        do {
            if (!S->current_count)
                goto next;
            if ((((int)(((volatile SndStream *)S)->state) << 24) >> 24) != 1)
                goto next;
            if (iSNDstreamisheld(S))
                goto next;
        } while (0);
        {
            SndStreamReq *req = S->requests + (signed char)((volatile SndStream *)S)->parse_index;
            if (!req->num_chunks)                          /* numChunks -- MATCH: split guards,
                        * not an `&&` (oracle branches per-condition straight to `next`, not via a
                        * combined boolean -- same &&-chain->goto lever as the rest of this fn). */
                goto next;
            if (!req->submitted)                          /* submitted */
                goto next;
            {
                int avail = ((volatile SndStreamReq *)req)->num_chunks - ((volatile SndStreamReq *)req)->submitted; /* MATCH: volatile -- oracle RELOADS
                            * both fields fresh here rather than reusing the guards' loaded values. */
                int space = SNDPKTPLAY_submitspace(S->packet_player);
                int n = avail < space ? avail : space;
                if (n > 0) {
                    do {
                        unsigned char *chunk;
                        n--;
                        /* MATCH: oracle sets ONLY $a0 for this call -- $a1/$a2 are stale, never
                         * loaded (`jal STREAM_get` with no arg-2/3 setup at either call site in
                         * this file). Cast the fn-ptr to a 1-arg signature at THIS call site only
                         * (§3.11/D "dropped call arg"); the 3-arg extern decl stays for any other
                         * caller in the codebase that DOES pass buf/len. */
                        chunk = (unsigned char *)STREAM_get(S->stream_handle);
                        if (chunk) {
                            int bytes = *(int *)(chunk + 4);
                            total += bytes;
                            iSNDstreamparsedata(S, (SndStreamChunkHeaderPrefix *)chunk);
                        }
                    } while (0 < n && total < 0x4000);
                }
            }
        }
    next:
        slot++; p++;
    } while (slot < 1);
}
/* MATCH (67->60->46->30->26->0 diffs, 86 instructions).
 * This pass fully re-traced 0x800E9438..0x800E9590 against the raw and found 3 real fixes:
 * (1) the `numChunks!=0 && submitted!=0` guard must be TWO split goto-checks, not an `&&` --
 * same &&-chain->goto lever already used for the other guards in this fn (oracle branches
 * per-condition straight to `next`; a combined `&&` boolean materializes via `sltu`, wrong shape).
 * (2) `num_chunks-submitted` needs volatile member reads -- the oracle RELOADS both fields
 * fresh for this calc instead of reusing the guard's just-loaded values (2 loads -> 4, matches).
 * wave-22 (46->30): the prior wave's fix #3 for `total += bytes` was WRONG -- it claimed deferring
 * the accumulate to AFTER `iSNDstreamparsedata()` was the MATCH, but the permuter (base score 215,
 * found 100 in <20 iterations) proved the OPPOSITE: `total += bytes;` BEFORE the call is the real
 * oracle shape. Verified against verify_asm (not just the permuter's own scorer): 46->30 diffs, a
 * real drop, not a coloring artifact. The stale "MATCH...defer until after the call" comment was
 * simply incorrect -- a documented "confirmed" fix that had never actually been diffed this
 * precisely. The final zero-iteration scope around the three post-null guards changes no CFG,
 * but recovers the oracle's S->$s1 and avail->$s2 allocation. */

/* iSNDstreamservice @0x800E9590 : per-tick service.  For each active stream: restart the player if it
 *   flagged a format change (state 2), then, unless held, drain chunks from the ring through
 *   iSNDstreamparsechunk into the player. */
void iSNDstreamservice(void)
{
    int slot;
    SndStream **p;

    iSNDenteraudio();
    slot = 0;
    p    = sndss;
    for (; slot < 1; slot++, p++) {
        SndStream *S = *p;
        if (S && S->current_count) {                /* curReqCount != 0 */
            if ((((int)(((volatile SndStream *)S)->state) << 24) >> 24) == 2) {  /* needs restart */
                if (0 < SNDPKTPLAY_framesoutstanding(S->packet_player))
                    continue;
                S->locked_rate = S->current_rate;
                SNDPKTPLAY_stop(S->packet_player);
                S->start_result = SNDPKTPLAY_start(S->packet_player, &S->locked_rate,
                                         &S->locked_header,
                                         &S->start_params);
                S->state = 1;
            }
            if (!(iSNDstreamisheld(S))) {
                int n, r;
                if ((((int)(((volatile SndStream *)S)->state) << 24) >> 24) == 1) {
                    n = SNDPKTPLAY_submitspace(S->packet_player);
                    if (!n)
                        continue;
                    r = 0;
                } else {
                    n = 10;
                }
                r = 0;
                do {
                    unsigned char *chunk;
                    n--;
                    /* MATCH: only $a0 set at this call site too (§3.11/D dropped call arg). */
                    chunk = (unsigned char *)STREAM_get(S->stream_handle);
                    if (chunk)
                        r = iSNDstreamparsechunk(S, chunk);
                    if (!r)
                        break;
                } while (n > 0);
            }
        }
    }
    iSNDleaveaudio();
}
/* near-miss floor (37->26->18->14 diffs, ours 88 / oracle 90 insns; real fixes kept per verify-or-revert
 * rule 1: `n=10` is unconditional -- not an if/else -- and BOTH `STREAM_get` call sites in this
 * file pass only $a0, the other 2 params are stale (dropped-arg fn-ptr cast, §3.11/D). This also
 * fixed a genuine BUG: our old if/else form left a duplicate/cancelling `n--`/`n++` pair at the
 * loop tail vs the oracle's clean `bgtz s1,LOOP`.) A packed rate assignment now reproduces the
 * oracle's unaligned copy. Residual differences are the sndss base-address materialization and a
 * caller-saved v0/v1 swap in the following state test. */

/* iSNDstreamnumcreated @0x800E96F8 : count the live streams. */
int iSNDstreamnumcreated(void)
{
    int count = 0;
    int slot;
    for (slot = 0; slot < 1; slot++) {
        if (sndss[slot])
            count++;
    }
    return count;       /* MATCH (14/14): true sndss[] storage gives the oracle's split address. */
}

/* iSNDstreamcreate @0x800E9730 : carve a stream object + its packet array, packet player and (optionally)
 *   its own ring out of `objbuf`/`memsize`, wire up the priority params, and register it.  Returns the
 *   stream slot, or a negative error.  `extFlag` reuses an external STREAM (extHandle) instead of creating
 *   one.
 * *** MATCH 144/144 (w32-a8, 7 -> 0 diffs).  Two fixes:
 * (a) THE PARAMETER *IS* THE ALLOCATION CURSOR -- there is no separate `alloc` local.  The oracle
 *     copies the incoming $a3 into $s2 in the PROLOGUE and only then copies $s2 -> $s1 (`S`) in the
 *     search loop's beqz delay slot; a separate `alloc` local let gcc coalesce `objbuf` straight into
 *     $a3 and copy-propagate `S = objbuf` into ONE pseudo (`addu s1,a3,zero`, 1 insn short -- the
 *     residual this file previously filed as an unreachable dead-copy class).  Re-using the PARAM as
 *     the running cursor (`objbuf = S + sizeof(SndStream); ... objbuf += reqBytes; ...`) makes it a pseudo that is
 *     both live across the calls (-> callee-saved $s2, hence the prologue copy) and reassigned after
 *     the `S = objbuf` read (-> the copy cannot be propagated away).  This is what EA wrote: C lets a
 *     parameter be reassigned, and the whole carve walks the caller's buffer forward in place.
 * (b) `i = 0;` must be written BEFORE `pp = sndss;` -- the oracle emits `addu a1,zero,zero` ahead of
 *     the sndss `lui/addiu`; the `for (i = 0; ...)` init form put it after. */
int iSNDstreamcreate(SNDPLAYOPTS *priority, int numReq, int pktArg, char *objbuf,
                                int memsize, int extHandle, int extFlag)
{
    int i, slot;
    SndStream *S;
    int memrem, reqBytes, oh;
    char *pktbuf;

    memrem = memsize;                                    /* W31: cache the stack param FIRST -- the
                                                          * oracle loads 80(sp) into $s3 in the
                                                          * prologue and mutates it in place */
    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)                /* SND not initialised */
        return -10;

    {
        SndStream **pp;
        i = 0;
        pp = sndss;
        for (; i < 1; i++, pp++) {                  /* find a free slot (real search loop in the
                                                           * oracle even though this build only has 1).
                                                           * W31: `i` is a SEPARATE caller-saved counter
                                                           * ($a1, dies here); `slot` is copied from it
                                                           * at found (oracle addu s4,a1 in the first
                                                           * overhead jal's delay slot). */
            if (*pp == 0)
                goto found;
        }
    }
    return -9;                                           /* no free slot */
found:
    slot     = i;
    S        = (SndStream *)objbuf;
    objbuf   = (char *)S + sizeof(SndStream);                                 /* after sizeof(SndStream); from here
                                                          * on `objbuf` IS the allocation cursor (see the
                                                          * header note (a) -- do NOT reintroduce a
                                                          * separate `alloc` local, it costs the oracle's
                                                          * prologue `addu s2,a3,zero` + the `addu s1,s2`
                                                          * copy in the search loop's beqz delay slot). */
    memrem  -= 0x60;
    reqBytes = numReq * (int)sizeof(SndStreamReq);
    S->requests = (SndStreamReq *)objbuf;                                    /* packetsArray */
    objbuf += reqBytes; memrem -= reqBytes;

    oh     = SNDPKTPLAY_overhead(pktArg);
    pktbuf = objbuf;
    objbuf += oh; memrem -= oh;
    oh     = SNDPKTPLAY_overhead(pktArg);
    ((volatile SndStream *)S)->packet_player = SNDPKTPLAY_create(pktbuf, oh,
                  iSNDstreamreleasecallback, iSNDstreamnotifycallback);
    if (((volatile SndStream *)S)->packet_player < 0)
        return ((volatile SndStream *)S)->packet_player;
    /* W31: the oracle addresses the handle->slot map THROUGH sndss (sb slot,4(sndss+handle) --
     * literal displacement 4, one symbol; sndStreamMap is the +4 tail of the same block), with the
     * base REMATERIALIZED here (5.0c per-block assign), not CSE-shared with the search loop's. */
    {
        unsigned char *map;
        map = (unsigned char *)sndss;
        map[((volatile SndStream *)S)->packet_player + 4] = (unsigned char)slot;      /* handle -> slot (delay slot) */
    }

    if (extFlag) {                                  /* external ring */
        S->stream_handle    = extHandle;
        ((volatile SndStream *)S)->external_stream = 1;   /* volatile: keeps the sb out of the j slot
                                                      * so the tail's li -1 gets target-stolen (W31) */
    } else {                                             /* own ring */
        S->stream_handle    = STREAM_create(numReq + 1, 1, 1, objbuf, memrem);
        ((volatile SndStream *)S)->external_stream = 0;
        SNDSTRM_setgreedylevel(S->stream_handle, STREAM_buffersize(S->stream_handle) / 3);
    }
    S->request_counter = 0;
    S->start_result = -1;
    S->max_requests = (unsigned char)numReq;
    S->start_params = *priority; /* W31: ONE 20-byte struct assignment -- the
                        * movstrsi block move emits the 4-word t-reg batch PLUS the trailing 5th word
                        * (tail lw t1/sw 0x5C) itself; a four-word copy plus separate word mis-schedules
                        * the tail. */

    if (!(iSNDstreamnumcreated())) {                   /* first stream -> register the service hook */
        iSNDserveraddclient(iSNDstreamservice);
        ((struct SndGlobalLifecycleHookView *)sndgs)->stream_destroy_all_hook = iSNDstreamdestroyall;
    }
    sndss[slot] = S;
    SNDSTRM_purge(slot);
    return slot;
}
/* Exact-match notes for iSNDstreamcreate: the request array and player fields are named in
 * SndStream/SndStreamReq, the +0x4C parameter block is SNDPLAYOPTS, and objbuf remains the reassigned
 * byte cursor. Initialize the stream-table search index before materializing sndss for the retail
 * register schedule. In iSNDstreamqueue, req is now a typed request pointer; current_count retains
 * its existing sign-extended byte interpretation when selecting the request slot. */

/* iSNDstreamqueue @0x800E9970 : queue a sound on a stream -- from a file, a memory image, or an
 *   already-built STREAM request id.  Fills a fresh packet slot, stamps a unique id, and returns it.
 *   `mode`: 0=file (filename/off), 1=memory (filename=block), other=pre-built id (off). */
int iSNDstreamqueue(unsigned int s, int name, char *filename, int off, int mode)
{
    SndStream *p;
    SndStreamReq *req;

    if (!((struct SndGlobalServerStateView *)sndgs)->initialized)
        return -10;
    p = iSNDstreamgetstreamptr(s);
    if (!p)
        return -8;

    iSNDenteraudio();
    if (!((int)((unsigned)p->current_count << 0x18) < (int)((unsigned)p->max_requests << 0x18))) {  /* no room */
        iSNDleaveaudio();
        return -0xd;
    }

    req = p->requests + (signed char)((volatile SndStream *)p)->current_count;
    if (!mode)
        ((volatile SndStreamReq *)req)->stream_request_id = STREAM_queuefile(p->stream_handle, filename, off, 0x6c454353);
    else if (mode == 1)
        ((volatile SndStreamReq *)req)->stream_request_id = STREAM_queuemem(p->stream_handle, filename, 0, 0x6c454353);
    else
        ((volatile SndStreamReq *)req)->stream_request_id = off;

    if (!req->stream_request_id) {
        iSNDleaveaudio();
        return -1;
    }

    ((volatile SndStream *)p)->request_counter = ((volatile SndStream *)p)->request_counter + 0x100;         /* bump the id counter */
    if (((volatile SndStream *)p)->request_counter < 0)                        /* near-miss residual: oracle leaves this bgez's
                                                   * delay slot a plain nop (store happens BEFORE
                                                   * the branch); ours schedules the store INTO the
                                                   * delay slot. Tried named `newid` temp: no change
                                                   * -- scheduler-fill floor (same class as the
                                                   * lui-scratch/lwl-lwr floors documented above). */
        ((volatile SndStream *)p)->request_counter = 0;
    ((volatile SndStreamReq *)req)->request_id = ((volatile SndStream *)p)->request_counter | s;        /* full id = counter | slot */
    ((volatile SndStreamReq *)req)->hold_threshold = name;
    p->current_count = p->current_count + 1;               /* curReqCount++ */
    req->data_rate = 0;
    req->firstqid    = -1;
    req->qid  = -1;
    req->bytes_consumed = 0;
    req->remaining_bytes = 0;
    req->submitted = 0;
    ((volatile SndStreamReq *)req)->num_chunks = 0;
    iSNDleaveaudio();
    return req->request_id;
}
