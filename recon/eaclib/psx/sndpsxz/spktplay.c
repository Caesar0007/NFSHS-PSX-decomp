/* eaclib/psx/sndpsxz/spktplay.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 13/13 ***
 *
 *   COMPILED AS C by USER RULING (2026-07-25, uniformity; w26-a4 manual C89 port -- the automated
 *   dialect fixer did not converge on this TU). Pre-migration (.cpp/cc1plus) vs post-migration
 *   (.c/cc1) per-fn diff counts, verify_asm.py authoritative -- IDENTICAL, zero regressions:
 *     iSNDpacketplayoverhead=PASS(0)  SNDPKTPLAY_overhead=PASS(0)   SNDPKTPLAY_create=PASS(0)
 *     SNDPKTPLAY_start=FAIL(4 w35, 187/187)    SNDPKTPLAY_submit=FAIL(2)  SNDPKTPLAY_submitspace=PASS(0)
 *     SNDPKTPLAY_unsafeframesoutstanding=PASS(0)  SNDPKTPLAY_framesoutstanding=PASS(0)
 *     SNDPKTPLAY_purge=PASS(0, w34)                                          SNDPKTPLAY_stop=PASS(0)
 *     SNDPKTPLAY_destroy=PASS(0)      iSNDpacketget=PASS(0)         iSNDpacketfreeframes=PASS(0)
 *   11/13 PASS, 2/13 FAIL (start/submit) as of w34-a6.  Do NOT revert to .cpp without user decision.
 *   Source obj : nfs4\eaclib\psx\spktplay.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   13 fns @[0x801028BC .. 0x80103424].  SNDPKTPLAY -- the packet player sst.obj feeds.  A ring of
 *   "frames" (each a list of per-channel sample-data pointers) is submitted, then drained by the platform
 *   audio layer; per-frame release/notify callbacks report consumption back up to the stream layer.
 *
 *   Dual-source: Ghidra `C:\Temp\claud\nfs4-f.exe.c` L166899..167407 + disasm-v3 L334627+ (authoritative;
 *   Ghidra mangled SNDPKTPLAY_start's unaligned copy AND swapped its hdr/arg3 param naming, and dropped
 *   the bodies of unsafeframesoutstanding/framesoutstanding and args of iSNDpacketget/freeframes).
 *
 *   ===== player ppp = sndpps[i] (@0x80148574, one slot) =====
 *     +0x00 voice id (-1 idle)   +0x04 submit sequence   +0x08(h) ring size (numFrames)
 *     +0x0A(h) read index   +0x0C(h) last-channel marker (0xffff)   +0x0E(h) outstanding frame count
 *     +0x10 bytes pending   +0x14 bytes consumed   +0x18 mem base   +0x1C release cb   +0x20 notify cb
 *     +0x24 rate word (unaligned copy)   +0x26(b) channels per frame   +0x28.. frame ring (0x18 each:
 *           +0=seq, +4=size, +8.. = up-to-channels sample pointers)
 *   ===== voice ch = sndgs[0x25] + note*100 (the global channel pool slot) =====
 */

extern int  sndpps[];                /* @0x80148574 -- one-slot player pointer array */
extern int  sndgs[];                  /* (signed char)sndgs[0xf]=init, sndgs[0x25]=channel pool base */
/* HEADER WISH: the oracle actually loads this global from D_80147900 (SNDPKTPLAY_start @0x80102C34,
 * iSNDplaytaggedtimbre @0x801020D8 -- same "rate * ch-field * ch-field, magic-const mult, dur"
 * idiom both places), NOT 0x80147840 as this decl previously claimed. Doesn't affect verify_asm
 * (relocations are name/addend-erased) but the address comment was wrong; not chased further this
 * pass -- flag for whoever materializes/cross-checks sndpsxz globals next. */
extern int  iSNDplatformrate[];       /* @0x80147900 -- platform sample rate (pitch calc); UNSIZED: oracle loads it absolute (lui+lw), a sized [1] goes gp-rel */

/* ---- backends ---- */
extern int  iSNDplatformpacketoverhead(void);                           /* sdpacket */
extern int  iSNDplatformpacketplaycreate(int slot, int *mem);
/* H10: 9-arg per oracle call @0x80102C94 (a0..a3 + sp+16/20/24/28/32). sdpacket's def reads 8
 *   (volAngle,level,pitch,a6,fxlevel,hdr-ptr); a9=hdr+0xc is pushed-but-unused, matching the binary. */
extern int  iSNDplatformpacketplay(int p, int note, int volAngle, int level,
                                       int pitch, int a6, int fxlevel, int hdr, int a9);
extern void iSNDplatformpacketplaydestroy(int p);
extern int  iSNDallocchan(int a, int b, int c, int *out);               /* salloc */
extern void iSNDfreechan(int note);
extern void iSNDcalcpitch(int note);                                    /* sclcptch */
extern void iSNDcalcvol(int note);                                      /* spatkey  */
extern void SNDstop(unsigned int voice);                                /* sstop    */
extern void iSNDenteraudio(void);                                       /* sserver  */
extern void iSNDleaveaudio(void);

#define MI(p,o)  (*(int*)((p)+(o)))
#define MB(p,o)  (*(unsigned char*)((p)+(o)))
#define MSB(p,o) (*(signed char*)((p)+(o)))
#define MH(p,o)  (*(short*)((p)+(o)))
#define MUH(p,o) (*(unsigned short*)((p)+(o)))
/* MATCH: `volatile` forces the oracle's lhu+sll16+sra16 sign-extend shape on a signed-short field
 * read (a plain `(short)`/MH() load collapses to one `lh`) -- see submitspace's near-miss comment.
 * Use for ring-index/count comparisons (the async-touched player-slot fields); plain MH()/MUH() for
 * straight-line count/byte updates that the oracle compiles as a bare `lhu`, no shift. */
#define VH(p,o)  ((((int)(*(volatile unsigned short *)((p)+(o)))) << 16) >> 16)
/* MVUH: plain volatile unsigned-short data move (no sign-extend) -- for a straight-line field
 * read/write that must NOT be hoisted/reordered/CSE'd past a neighboring field's read or write
 * (two accesses to the SAME field with an unrelated field's access in between). */
#define MVUH(p,o) (*(volatile unsigned short *)((p)+(o)))
/* VHR: raw << 16, no >> 16 -- for a comparison-ONLY context where the oracle skips the final `sra`
 * (both sides shifted equally preserve `<`/`<=` order without needing the true sign-extended value). */
#define VHR(p,o) (((int)(*(volatile unsigned short *)((p)+(o)))) << 16)

/* forward decls (mutual) */
extern int iSNDpacketplayoverhead(int n);                /* @0x801028BC */
extern int SNDPKTPLAY_overhead(int n);                   /* @0x801028D0 */
extern int SNDPKTPLAY_create(int mem, int memsize, int relcb, int notifycb); /* @0x801028FC */
extern int SNDPKTPLAY_start(int p, int rate, int hdr, int params);       /* @0x80102A10 */
extern int SNDPKTPLAY_submit(int p, int frame);          /* @0x80102CFC */
extern int SNDPKTPLAY_submitspace(int p);                /* @0x80102E70 */
extern int SNDPKTPLAY_unsafeframesoutstanding(int p);    /* @0x80102EC4 */
extern int SNDPKTPLAY_framesoutstanding(int p);          /* @0x80102EEC */
typedef struct { int w[6]; } PktCopy6;   /* 0x18-byte ring frame, block-copied in purge */
typedef struct { int w[4]; } PktCopy4;
typedef struct { int w[2]; } PktCopy2;
typedef struct { char b[4]; } Unal4;     /* alignment-1 word: movstrsi emits the lwl/lwr+swl/swr pair */
extern int SNDPKTPLAY_purge(int p, int lo, int hi);      /* @0x80102F3C */
extern int SNDPKTPLAY_stop(int p);                       /* @0x80103118 */
extern int SNDPKTPLAY_destroy(int p);                    /* @0x801031F4 */
extern int iSNDpacketget(int p, int idx, int *out);      /* @0x80103248 */
extern unsigned int iSNDpacketfreeframes(int p, int idx, int bytes);     /* @0x801033C4 */

/* ====================================================================================== */

/* iSNDpacketplayoverhead @0x801028BC : bytes of player bookkeeping for `n` frames. */
extern int iSNDpacketplayoverhead(int n)
{
    return n * 0x18 + 0x40;
}

/* SNDPKTPLAY_overhead @0x801028D0 : total player overhead (bookkeeping + platform). */
extern int SNDPKTPLAY_overhead(int n)
{
    int a = iSNDpacketplayoverhead(n);
    return a + iSNDplatformpacketoverhead();
}

/* SNDPKTPLAY_create @0x801028FC : claim a player slot in `mem`, size its frame ring, store the callbacks.
 *   Returns the slot index, or a negative error.
 *   MATCH (oracle-traced, real bug fixes vs the earlier flat-if reconstruction):
 *   (1) `sndpps` is a genuine ONE-SLOT array (SYM confirms only 4 bytes between sndpps@0x80148574 and
 *       the next symbol sndpp@0x80148578) reached via a real `for(slot=0;slot<1;slot++)` loop the
 *       compiler did NOT unroll (`slot<1` folds to a `blez` test) -- not a scalar `if`. The loop
 *       rematerializes `&sndpps` into a walking pointer and computes `slot*4` in the found-branch's
 *       delay slot (used later as the store index), matching lever #1 (index-loop, not a hand-flattened
 *       `if`).
 *   (2) `iSNDplatformpacketoverhead()` is called TWICE with its return values genuinely CONSUMED --
 *       first call's return offsets `mem` into `ppp` (`mem += overhead()`), second call's return is
 *       subtracted from `memsize` for the ring-size divide. `off` (iSNDplatformpacketplaycreate's
 *       return) is used ONLY for the `<0` error check and never reused -- the earlier "off reused for
 *       both offset and ring-size, overhead()'s results discarded" reconstruction was a genuine bug.
 *   (3) `mem` is DEAD after the offset add (lever #14 in-place mutate): reassigned in place to become
 *       `ppp` and used directly for every subsequent field store; the pre-offset value is saved to
 *       `savedmem` (oracle's `$s0`) before the reassignment for the +0x18 store. */
extern int SNDPKTPLAY_create(int mem, int memsize, int relcb, int notifycb)
{
    int slot, off, savedmem;
    if ((signed char)sndgs[0xf] == 0)
        return -10;
    for (slot = 0; slot < 1; slot++) {
        if (sndpps[slot] == 0)
            goto found;
    }
    return -9;
found:
    off = iSNDplatformpacketplaycreate(slot, (int *)mem);
    if (off < 0) {
        do { } while (0);
        return -6;
    }
    savedmem = mem;
    mem = mem + iSNDplatformpacketoverhead();
    memsize = memsize - iSNDplatformpacketoverhead();
    sndpps[slot] = mem;
    MI(mem, 0x18) = savedmem;                     /* puVar4[6] */
    MI(mem, 0x1c) = relcb;                        /* puVar4[7] */
    MI(mem, 0x20) = notifycb;                     /* puVar4[8] */
    *(volatile short *)(mem + 8) =
        (short)(((unsigned)(memsize - 0x40)) / 0x18);     /* ring size */
    *(volatile int *)mem = -1;
    return slot;
}
/* near-miss floor (66->35 diffs, ours 64 / oracle 69 insns; the two logic-bug fixes above ARE real
 * and oracle-confirmed -- kept per verify-or-revert rule 1, count strictly dropped). Residual:
 * gcc-2.8 CSEs `&sndpps` (the loop test's array base) into ONE callee-saved reg (s3) reused verbatim
 * for the post-call store with a proven-zero offset, where the oracle keeps the base CALLER-saved
 * (v0/v1) and REMATERIALIZES it fresh (2 fresh insns) AFTER the two overhead() calls, using a real
 * (non-folded) `s4=slot*4` offset computed once in the loop's found-branch delay slot. Tried: a
 * scoped `int *slotp=&sndpps+slot;` barrier after the calls (no effect -- gcc still CSEs across
 * calls here), pointer-walk loop form (regressed to 40 diffs). Not source-reachable with the levers
 * on hand; permuter candidate. */

/* SNDPKTPLAY_start @0x80102A10 : begin playing a stream on player `p`.  Allocates a hardware voice, copies
 *   the format/rate into the voice, fills the ~50-field voice descriptor (sources per the disasm -- NOTE
 *   Ghidra's hdr/arg3 param naming is swapped), computes the playback pitch/duration, and hands off to the
 *   platform.  Returns the voice id, or a negative error.
 *   Args (per the caller, sst): rate = locked rate word, hdr = 0x14-byte header, params = 5-word params. */
extern int SNDPKTPLAY_start(int p, int rate, int hdr, int params)
{
    int ppp, note, allocOut, ch, dur, r;
    int rateb2;
    int gp;                                       /* &sndgs as an int, then REUSED to hold the
                                                    * packet-play length (retail's s3: the oracle
                                                    * redefines the very register that held the
                                                    * sndgs base with the 0x10/-0x40<<8 length right
                                                    * after `lw v1,0x94(s3)` -- one source variable,
                                                    * two roles) */                     /* MATCH: hoist &sndgs ONCE into a var that
                                                    * survives across enteraudio/allocchan -- the
                                                    * guard and the 0x25 pool-base lookup share the
                                                    * SAME materialized base in the oracle ($s3),
                                                    * held in a callee-saved reg across both calls.
                                                    * W31 RESIDUAL: retail allocates gp->s3 BEFORE the
                                                    * params/hdr copies (s4/s5); ours orders params,
                                                    * hdr, gp (s3,s4,s5) -- the same constant-init-
                                                    * promoted allocno ordering seen in sbdload/purge
                                                    * this wave; decl order, direct-sndgs (140, rev.),
                                                    * and psq45 cc1 (same as ours) all fail to move it.
                                                    * ~100 of the 132 diffs are this one rotation
                                                    * cascading through the field stores. */
    gp = (int)sndgs;
    if (*(signed char *)(gp + 0x3c) == 0)
        return -10;
    rateb2 = MB(rate, 2);                         /* MATCH: evaluated before the ppp lookup/
                                                    * enteraudio -- oracle hoists this arg early */
    ppp = sndpps[p];
    iSNDenteraudio();
    note = iSNDallocchan(*(int *)hdr, rateb2, MSB(hdr, 6), &allocOut);
    if (note < 0) {
        iSNDleaveaudio();
        return -9;
    }

    /* MATCH (w32-a8, 132 -> 114 diffs AND insn count 185 -> EXACT 187): the whole ring HEADER is
     * volatile -- these are the async-touched player-slot words (same justification the VH()/MVUH()
     * reads and SNDPKTPLAY_stop already carry).  With plain stores gcc's scheduler hoists the
     * `li -1` + `sh 0xc` marker to the top of the block (stealing the `bgez` delay slot on the way)
     * and sinks `sw allocOut,0(ppp)` to the bottom; the oracle keeps the written order and leaves
     * that delay slot unfilled.  Making ONLY the first or only the two end stores volatile is not
     * enough (132 / 119) -- the run has to be ordered as a whole. */
    *(volatile int *)(ppp + 0)      = allocOut;
    *(volatile short *)(ppp + 0xa)  = 0;
    *(volatile short *)(ppp + 0xe)  = 0;
    *(volatile int *)(ppp + 0x10)   = 0;
    *(volatile int *)(ppp + 4)      = 0;
    *(volatile int *)(ppp + 0x14)   = 0;
    *(volatile short *)(ppp + 0xc)  = (short)0xffff;
    *(Unal4 *)(ppp + 0x24) = *(Unal4 *)rate;      /* unaligned rate-word copy: lwl/lwr + swl/swr */
    ch = *(int *)(gp + 0x94) + note * 100;        /* MATCH: AFTER the unaligned copy -- the oracle's
                                                    * `lw v1,0x94(s3)` sits between the swl/swr pair
                                                    * and the params[0xb] test, with the pool-base
                                                    * add filling the test's beqz delay slot (sched1
                                                    * still hoists the note*100 multiply chain above
                                                    * the copy, exactly as retail). */

    if (MSB(params, 0xb) != 0)
        gp = MUH(params, 0x10);
    else {
        /* TWO statements, not one and not three.  `gp` is the retail two-role variable (&sndgs,
         * then the packet length) and its REG_N_REFS decides whether it wins the oracle's $s3:
         *   1 stmt  `gp = ((MSB(params,7)-0x40)<<8)&0xffff;`  ->  6 refs, prio 12/97=.124 < params'
         *           30/224=.134  ->  gp lands $s4, params $s3 (the old 100-diff swap);
         *   2 stmts (this)                                    ->  8 refs, 24/98=.245 -> gp $s3 OK;
         *   3 stmts (the oracle's own in-place addiu/sll/andi chain) -> 10 refs, 30/99=.303, which
         *           outranks `note`/`ppp` and takes $s1 (120 diffs).
         * So we spell the subtraction in place (matching the oracle's `addiu s3,v0,-0x40`) and fuse
         * the shift+mask, leaving a 2-insn `sll v0,s3,8 / andi s3,v0,0xffff` vs the oracle's in-place
         * `sll s3,s3,8 / andi s3,s3,0xffff` -- the price of staying at 8 refs.
         * W47-a3 (2026-08-03) re-measured in the current basin, both REVERTED:
         *   - 3 statements (`gp = gp << 8; gp = gp & 0xffff;`): 60 diffs (the w35 note's 10-ref
         *     prediction confirmed -- s1/s2/s3 rotate through the whole fn).
         *   - mask-then-shift `gp = (gp & 0xff) << 8;` (algebraically identical, same ref count):
         *     4 diffs, different shape (`andi v0,s3,255 / sll s3,v0,8`) -- the temp just moves to
         *     the other operand.  NEW NAMED ANGLE: the in-place `sll s3,s3,8` REQUIRES an RTL
         *     `(set gp (ashift gp 8))`, which expand_expr only produces when the assignment target
         *     IS the shift's own operand and is its own statement (safe_from_p refuses the target
         *     as a subexpression temp).  So the shape is structurally tied to the 3-statement form
         *     and the fix must come from the OTHER side: a zero-insn ref DELETER on `gp` (w45
         *     store-read-back family) or a zero-insn ref INFLATOR on its rivals (`note`/`ppp`) to
         *     restore the 8-ref ranking with 10 real refs.  Not attempted -- both need reqdelta. */
        gp = MSB(params, 7) - 0x40;
        gp = (gp << 8) & 0xffff;
    }

    MSB(ch, 0xa)  = -1;              /* li -1 (signed char), not li 255 */
    MUH(ch, 0x5c) = MUH(hdr, 4);
    MUH(ch, 0x60) = MUH(params, 0xc);
    MI(ch, 0x14)  = 0;
    MI(ch, 0x1c)  = (int)MSB(params, 8) << 0x10;
    MI(ch, 0x20)  = 0;
    MI(ch, 0x28)  = 0x7fffffff;
    MI(ch, 0x24)  = 0x7f0000;
    MB(ch, 0x2c)  = MB(hdr, 7);
    MB(ch, 0x2e)  = MB(hdr, 8);
    MB(ch, 0x2f)  = MB(params, 9);   /* H09: src was hdr (oracle 0x80102B90 *(u8)(9+$s4=params)) */
    MB(ch, 0x30)  = 1;
    MB(ch, 0x31)  = 0;
    MB(ch, 0x32)  = 0;
    MB(ch, 0x33)  = 1;
    MB(ch, 0x34)  = MB(hdr, 9);      /* H09: src was params (oracle 0x80102BAC *(u8)(9+$s5=hdr)) */
    MB(ch, 0x35)  = MB(params, 10);  /* H09: src was hdr (oracle 0x80102BB8 *(u8)(10+$s4=params)) */
    MH(ch, 0x5a)  = (short)(MSB(hdr, 10) * 100);
    MB(ch, 0x37)  = 0;
    MB(ch, 0x36)  = 0;
    /* MATCH: 0x40/0x44 zeros BEFORE the 0x3d store, 0x48/0x4c/0x50/0x54 AFTER -- oracle interleaves
     * `a0=note` (calcpitch's arg) between MB(params,7) and the first zero pair. */
    MB(ch, 0x3d)  = MB(params, 7);   /* H09: src was hdr (oracle 0x80102BE8 *(u8)(7+$s4=params)) */
    MI(ch, 0x40)  = 0;
    MI(ch, 0x44)  = 0;
    MI(ch, 0x48)  = 0;
    MI(ch, 0x4c)  = 0;
    MI(ch, 0x50)  = 0;
    MI(ch, 0x54)  = 0;

    MH(ch, 0x5e)  = 0;               /* MATCH: independent store -- oracle schedules it into the
                                       * calcpitch jal's delay slot */
    iSNDcalcpitch(note);
    iSNDcalcvol(note);

    /* pitch -> playback duration: rate * ch[0x34] * ch[0x35], divided by a fixed constant.
     * PC twin (nfs4-sound SNDPKTPLAY_start): ONE accumulator reassigned across two statements. */
    /* H10: oracle (0x80102C94) passes 9 args; was 6 with dur/rate/hdr+0xc in the wrong slots and
       ch[0x2d]/ch[0x62]/params[0xe] missing.  a0..a3 + sp+16/20/24/28/32. */
    r = iSNDplatformpacketplay(p, note, gp, MSB(ch, 0x2d), MUH(ch, 0x62),
                               MUH(params, 0xe),
                               iSNDplatformrate[0] * MSB(ch, 0x34) * MSB(ch, 0x35) / 0x3f01,
                               rate, hdr + 0xc);
    if (r < 0) {
        iSNDfreechan(note);
        iSNDleaveaudio();
        return r;
    }
    iSNDleaveaudio();
    return MI(ppp, 0);
}
/* near-miss 100 -> 70 diffs (ours 187 / oracle 187) -- w34-a6, cc1 -dl/-dg allocno instrument.
 * ROOT CAUSE of the old 100: a single s3<->s4 permutation, `gp`(&sndgs/length) vs `params`.  The dump
 * gave the exact numbers -- gp 6 refs/97 insns = 12/97 = .124 vs params 10/224 = 30/224 = .134 -- so
 * splitting the else-arm's length arithmetic into two statements (8 refs, .245) lifts gp over params
 * and pins the whole cascade.  See the in-place comment at that arm for why 1 and 3 statements both
 * fail.  Second fix: `ch = *(int*)(gp+0x94) + note*100;` moved AFTER the unaligned rate copy (the
 * oracle's `lw v1,0x94(s3)` sits between the swl/swr pair and the params[0xb] test; sched1 still
 * hoists the note*100 chain above the copy).  100 -> 78 -> 70.
 * RESIDUAL (70), three clusters, all sched1/local-alloc ties at EXACT insn parity:
 *  (a) the movstrsi rate-copy temp: ours $t1, oracle $t0 (2 lwl/lwr + 2 swl/swr = 4 diffs);
 *  (b) the ch-field store block: the STORE ORDER already matches the oracle exactly; what differs is
 *      where the 0x7fffffff `lui`/`ori` pair and the `lhu 0xC(params)` land between them (the oracle
 *      splits the lui from the ori and fills the `lb 0x8(params)` load-delay with the 0x28 store);
 *  (c) the tail: the oracle interleaves the four stack-arg stores INTO the two multiplies' latency
 *      (mflo/mfhi in $t4) where ours issues mflo/mult first.
 * Kept from earlier waves: MB(rate,2) evaluated before the ppp lookup; the whole ring-header store
 * run `volatile` (ordering); signed division by 0x3f01 at the C level (NFS4-PC twin confirms),
 * which recovers the retail 88-byte frame.
 *
 * ===== w35-a2 2026-07-26: 70 -> 4 diffs, insn parity held at 187/187 throughout =====
 * All FIVE remaining levers were pure STATEMENT ORDER / expression placement -- sched1 + reorg
 * decisions, no allocno dialing needed (the w34-a6 `gp` allocno fix still carries the register map).
 * Applied in this order, each measured with verify_asm:
 *   1. 70 -> 66  MB(ch,0x3d) BEFORE the 0x40/0x44 zero pair (was after).  The zeros were being
 *                stolen upward to fill the `lb 10(hdr)` load-delay of the 0x5a multiply chain;
 *                with the 0x3d load first they fill ITS `lbu 7(params)` delay instead, exactly
 *                as retail.  (This REVERSES the old "0x40/0x44 before the 0x3d store" note.)
 *   2. 66 -> 37  the WHOLE duration expression folded into the call's argument list
 *                (`iSNDplatformrate[0] * MSB(ch,0x34) * MSB(ch,0x35) / 0x3f01` as arg 7, no `dur`
 *                local).  As separate statements gcc has the product ready before expand_call and
 *                stores it first; as an argument, expand_call evaluates/stores args 4/5/6/8 first
 *                and the multiply chain lands INSIDE their latency -- which is also what puts the
 *                mflo/mfhi accumulator in retail's $t4 instead of $v0/$t5.
 *   3. 37 -> 22  MI(ch,0x1c) BEFORE the 0x28/0x24 constant pair: the `sw 0x28` then fills the
 *                `lb 8(params)` load delay (ours had a bare `nop` there = the +1 instruction).
 *   4. 22 -> 12  MB(ch,0x2f) moved up to directly after MB(ch,0x2e) (ASCENDING field order --
 *                almost certainly what EA wrote): its `lbu 9(params)` issues early and the
 *                0x30..0x33 constant run fills the load delay, leaving `sb 0x2f` at the end.
 *   5. 22 -> 18 / 12 -> 8   MH(ch,0x5e)=0 moved BEFORE iSNDcalcpitch(note) (was after).  reorg's
 *                backward scan then picks `sh 0x5e` for calcpitch's delay slot instead of the
 *                nearest preceding `sw 0x54`, and calcvol's slot gets `addu a0,note` -- retail's
 *                pairing.  (Combined 4+5 = 8.)
 *   6. 8 -> 4    MI(ch,0x14) and MI(ch,0x20) moved one statement LATER each (after MUH(ch,0x60)
 *                and after MI(ch,0x1c) respectively) -- same delay-slot-filler class as 1/3.
 * RESIDUAL (4 diffs, exact parity): the else-arm length shift/mask.  Ours `sll v0,s3,8 /
 * andi s3,v0,0xffff` vs retail's IN-PLACE `sll s3,s3,8 / andi s3,s3,0xffff` -- a coalescing choice
 * on the anonymous shift temp (catalog "trichotomy" case 3).  Re-measured this wave at the 4-diff
 * base: every 3-statement in-place spelling (`gp <<= 8; gp &= 0xffff;`, `gp = gp << 8; gp = gp &
 * 0xffff;`, and the `& 0xff` variant) costs gp 2 more REG_N_REFS, which lifts it over note/ppp and
 * takes $s1 -> 60 diffs.  `(unsigned short)(gp << 8)` is byte-identical to the current form.  So
 * the in-place shape is only reachable if gp's refs are simultaneously cut by 2 elsewhere (the two
 * candidates are the 0x3c guard and the 0x94 pool-base read, both currently through gp). */

/* SNDPKTPLAY_submit @0x80102CFC : append a frame (descriptor `frame`) to the player's ring.  Returns the
 *   submit sequence number, or -0xD if the ring is full. */
extern int SNDPKTPLAY_submit(int p, int frame)
{
    int ppp, slot;
    if ((signed char)sndgs[0xf] == 0)
        return -10;
    ppp = sndpps[p];
    iSNDenteraudio();
    if (VH(ppp, 0xe) < VH(ppp, 8) - 1)                    /* MATCH: positive (room-available) test
                                                             * branches AWAY to `room`; the FALLTHROUGH
                                                             * is the error path with its own explicit
                                                             * jump to `leave` -- oracle's exact
                                                             * `slt;bnez room / [fallthrough] j leave`
                                                             * shape, not an if/else. */
        goto room;
    frame = -0xd;                                         /* MATCH: the oracle reuses `frame`'s OWN
                                                             * register ($s1) as the return-value
                                                             * carrier for the whole fn -- its ONLY
                                                             * use past this point is the dead-param
                                                             * reuse `addiu s1,zero,-0xD`, no separate
                                                             * `seq` pseudo. */
    goto leave;
room:
    {
        int idx = VH(ppp, 0xa) + VH(ppp, 0xe);            /* (read + count) wrapped */
        if (VH(ppp, 8) <= idx)
            idx -= VH(ppp, 8);
        {
            int off = idx * 0x18 + 0x28;
            slot = ppp + off;
        }
        MI(slot, 4) = *(int *)(frame + 4);                /* size */
        MI(slot, 0) = MI(ppp, 4);                         /* sequence */
        if (MB(ppp, 0x26) != 0) {                         /* copy the per-channel pointers */
            int src = frame, j = 0;
            do {                                          /* MATCH: walks `slot` itself in place
                                                             * (lever #14) -- `frame` stays intact
                                                             * (re-read below), `slot`/a0 is dead
                                                             * after the loop. */
                MI(slot, 8) = *(int *)(src + 0xc);
                src += 4;
                j++;
                slot += 4;
            } while (j < (int)MB(ppp, 0x26));
        }
        MUH(ppp, 0xe) = MUH(ppp, 0xe) + 1;                /* count++ (plain lhu, no shift) */
        *(volatile int *)(ppp + 0x10) = MI(ppp, 0x10) + *(int *)(frame + 4);  /* bytes pending += size */
        frame = *(volatile int *)(ppp + 4);               /* MATCH: reuse `frame` (dead after the
                                                             * loop) as `seq` -- oracle's `lw s1,4(s0)`
                                                             * right here, same register as the param. */
        MI(ppp, 4) = *(volatile int *)(ppp + 4) + 1;      /* sequence++ */
    }
leave:
    iSNDleaveaudio();
    return frame;
}
/* Pure-C near miss (106->49->19->2 diffs, ours 93 / oracle 93 insns). The earlier pass
 * (wave 21-a8) landed THREE real structural wins per verify-or-revert rule 1, cracking every
 * residual the prior pass had flagged:
 *   (a) DEAD-PARAM REUSE: `frame` is dead after the copy loop, so REASSIGN it (`frame = -0xd;` /
 *       `frame = MI(ppp,4);`) instead of a separate `seq` local -- the oracle reuses `frame`'s own
 *       $s1 register as the return-value carrier for the WHOLE function, including the early-exit
 *       (`addiu s1,zero,-0xD` overwrites the param register directly). This alone was 49->30.
 *   (b) BRANCH-POLARITY: rewritten as explicit `goto` -- positive condition (`<`, room-available)
 *       branches AWAY to `room:`; the FALLTHROUGH is the error path with `frame=-13; goto leave;`
 *       -- matches the oracle's `slt;bnez room` / `[fallthrough] j leave` shape exactly (an if/else
 *       compiled to a WORSE CFG here, an extra out-of-line `j`+`li` -- reverted that attempt).
 *       30->27.
 *   (c) BLOCK-SCOPE-FRESH-PSEUDO (§3.12/catalog row A36): the copy-loop counter `i` was declared at
 *       FUNCTION scope (shared with `slot`/`ppp`) but only ever used inside the `if(channels!=0){}`
 *       block -- moving its declaration (renamed `j`) inside that block, after `src`, un-swapped the
 *       oracle's a1(src)/v1(counter) vs our v1(src)/a1(counter) register assignment. 27->19.
 * Historical residual from that pass: the `slot` pre-loop stores. Oracle computes the offset-only
 * `idx*24+0x28` into v0,
 * adds the base ONCE into `a0`, then reuses `a0` for BOTH the size store (`sw v1,4(a0)`) AND the
 * sequence store (`sw v0,0(a0)`). Ours instead recomputes the 2nd store's address as `v0+0x28`
 * (v0 = the pre-`+0x28` partial `s0+idx*24`) rather than reusing the already-materialized `a0`.
 * Tried: swapping the two stores' source order (worse, 19->20); making the 2nd `MI(ppp,4)` read
 * volatile to force a fresh re-read for the increment instead of reusing the `frame=MI(ppp,4)`
 * value (worse, 19->25 in the old basin). The final reduction came from an explicit offset local,
 * volatile ordering on the pending-byte store and sequence reloads, and moving `j++` after the
 * source-pointer advance. Residual: only `src=frame` and `j=0` trade places across the channel-count
 * branch; reversing their source order swaps a1/v1 throughout the loop and is worse.
 * W47-a3 (2026-08-03), 2-diff residual re-diagnosed + one more form falsified:
 *   MECHANISM: both inits sit in the loop PREHEADER (the `beqz channels` fall-through) and reorg
 *   EAGER-STEALS that block's FIRST insn into the guard's delay slot.  Retail's preheader starts
 *   with `addu v1,zero,zero` (j = 0), ours with `addu a1,s1,zero` (src = frame) -- so the dial is
 *   purely which init is emitted first.  But emission order is WELDED to first-use order, which
 *   picks the a1/v1 assignment: hoisting `int j = 0;` above the guard (tested: 12 diffs) flips
 *   src/counter to v1/a1 through the whole loop.
 *   NEW NAMED ANGLE: we need a dial that separates EMISSION order from FIRST-USE order for two
 *   independent register copies.  Untried: give `src` an earlier zero-insn first use (a use fence
 *   on `frame` before the block -- w45 measured `"r"(reg-resident local)` at 0 insns) so src keeps
 *   the lower pseudo while `j = 0;` is written first.  Fences were not swept here this wave. */

/* SNDPKTPLAY_submitspace @0x80102E70 : free frame slots in the ring. */
extern int SNDPKTPLAY_submitspace(int p)
{
    if ((signed char)sndgs[0xf] == 0)
        return -10;
    {
        int base = sndpps[p];
        /* MATCH: volatile forces the oracle's lhu+sll16+sra16 shape -- a plain `(short)` load
         * collapses to a single `lh` (still correct, but byte-mismatched). */
        int a = ((int)(*(volatile unsigned short *)(base + 8)) << 16) >> 16;
        int b = ((int)(*(volatile unsigned short *)(base + 0xe)) << 16) >> 16;
        return a - b - 1;
        /* MATCH: NFS3 confirms sndpps is an array of player pointers. Giving the PSX symbol that
         * array type selects the oracle's `lui` for the guard delay slot and moves p*4 one instruction
         * later; the volatile short reads retain the required lhu+sll16+sra16 shape. */
    }
}

/* SNDPKTPLAY_unsafeframesoutstanding @0x80102EC4 : bytes still to be played (no critical section). */
extern int SNDPKTPLAY_unsafeframesoutstanding(int p)
{
    int ppp = sndpps[p];
    return MI(ppp, 0x10) + MI(ppp, 0x14);
}

/* SNDPKTPLAY_framesoutstanding @0x80102EEC : same, inside a critical section. */
extern int SNDPKTPLAY_framesoutstanding(int p)
{
    int r;
    if ((signed char)sndgs[0xf] == 0)
        return -10;
    iSNDenteraudio();
    r = SNDPKTPLAY_unsafeframesoutstanding(p);
    iSNDleaveaudio();
    return r;
}

/* SNDPKTPLAY_purge @0x80102F3C : drop every frame whose sequence falls within [lo, hi] from the ring,
 *   compacting the survivors down, firing the release callback for each removed frame.
 *   PASS (119/119) as of w34-a6 -- cracked with the gcc-2.8 ALLOCNO-PRIORITY model read straight off
 *   the cc1 `-dl`/`-dg` RTL dumps (priority = floor_log2(refs)*refs/live_length; allocation order IS
 *   the s-register rank).  The residual was a 3-way rotation of {wrptr,rd,wr} over s1/s2/s3:
 *     - dump (before): wr 7 refs/52 insns = .269, rd 7/54 = .259, wrptr 5/40 = .250
 *                      -> order wr(s1), rd(s2), wrptr(s3);  oracle wants wrptr(s1), rd(s2), wr(s3).
 *     - LEVER 1 (live-length): SWAP the two identical `lhu +0xa` reads back to `wr` FIRST -- the
 *       earlier-defined pseudo lives longer, giving wr 7/55 = .2545 < rd 7/51 = .2745, i.e. rd now
 *       outranks wr (the oracle's own read order: its FIRST `sra` lands in $s3 = wr).
 *     - LEVER 2 (ref count): SPLIT the 0x18-byte ring copy into the movstrsi 4-word + 2-word halves
 *       as TWO struct assignments.  Byte-identical codegen (a 24-byte movstrsi is emitted as exactly
 *       load-4/store-4 + load-2/store-2 anyway), but it gives `wrptr` a SECOND address reference ->
 *       6 refs/40 = .300, lifting it above rd and completing the rotation.
 *     - LEVER 3: statement order inside the wrap-reset block (`wrptr = ppp;` BEFORE `wr = 0;`) --
 *       the last 2 diffs.
 *   The earlier note that this was an "unmodelable retail allocno_compare delta" was WRONG: the
 *   delta was entirely explained by our own dump's refs/live-length numbers.  (Same instrument is
 *   worth re-running on sbdload/start, whose floors were filed with the same reasoning.)
 *   W31 findings that still hold: goto loop kills the strength-reduced store anchor; VH() volatile
 *   short reads for wr/rd/total/ringsize; REMOVE ("lo<=fr0<=hi") is the branch-away/fallthrough arm
 *   and KEEP is the oracle's explicit two-`bnez`-to-the-same-label branch target. */
extern int SNDPKTPLAY_purge(int p, int lo, int hi)
{
    int   ppp, i, wrptr, wr, rd, total, rdoff;

    if ((signed char)sndgs[0xf] == 0)
        return -10;
    ppp = sndpps[p];
    i = 0;                                         /* MATCH: set before the ring reads -- oracle
                                                      * schedules this into iSNDenteraudio's jal
                                                      * delay slot (independent of the call), and
                                                      * this decl-order is what pins ppp/i/wr/rd/
                                                      * total/rdoff/wrptr onto the oracle's exact
                                                      * s0..s7/fp permutation (9 live-across-a-call
                                                      * locals -> every callee-saved reg is used). */
    iSNDenteraudio();
    wr    = VH(ppp, 0xa);                          /* write (compaction) index -- READ FIRST: the
                                                      * earlier def gives `wr` the LONGER live range
                                                      * (55 vs rd's 51), which drops its allocno
                                                      * priority below `rd`'s.  Retail's weaker CSE
                                                      * keeps BOTH identical lhu's; their ASSIGNMENT
                                                      * ORDER is the live-length lever. */
    rd    = VH(ppp, 0xa);                          /* read index (2nd identical volatile read) */
    total = VH(ppp, 0xe);                          /* frames to scan            */
    if (0 < total) {
        rdoff = rd * 0x18 + 0x28;
        wrptr = wr * 0x18 + ppp;
        /* GOTO loop (W31, same finding as sbdload): a natural do/while gets loop notes and gcc
         * strength-reduces the 0x28..0x3C store addresses onto a REBASED anchor (wrptr+0x3C-held
         * base, negative displacements); the oracle keeps the raw wrptr/rdoff IVs and recomputes
         * src = ppp+rdoff each iteration.  No loop notes -> no SR -> source IVs survive. */
purge_next: {
            int *fr = (int *)(ppp + rdoff);
            if (lo <= fr[0] && fr[0] <= hi) {      /* remove (branch-away, oracle fallthrough) */
                MUH(ppp, 0xe) = MUH(ppp, 0xe) - 1;  /* plain lhu, no shift (no compare) */
                *(volatile int *)(ppp + 0x10) = MI(ppp, 0x10) - fr[1];
                if (*(void **)(ppp + 0x1c) != 0)
                    (*(void (**)(int))(ppp + 0x1c))(fr[2]);
            } else {                               /* keep -> move down (oracle branch target) */
                /* The 0x18-byte ring copy, written as the TWO movstrsi batches gcc would emit for a
                 * single 24-byte struct assignment anyway (load-4/store-4 then load-2/store-2 in
                 * $a3/$t0/$t1/$t2).  Codegen-identical to `*(PktCopy6*)(wrptr+0x28) = *(PktCopy6*)fr`
                 * -- but it references `wrptr` TWICE, which is the point: 5 -> 6 REG_N_REFS lifts
                 * wrptr's allocno priority (12/40 = .300) above rd's (14/51 = .2745) and pins it to
                 * the oracle's $s1.  Do NOT re-merge into one assignment (reverts to 32 diffs). */
                *(PktCopy4 *)(wrptr + 0x28) = *(PktCopy4 *)fr;
                *(PktCopy2 *)(wrptr + 0x38) = *(PktCopy2 *)(fr + 4);
                wrptr += 0x18;
                wr++;
                if (VH(ppp, 8) <= wr) {
                    wrptr = ppp;
                    wr = 0;
                }
            }
            rdoff += 0x18;
            rd++;
            if (VH(ppp, 8) <= rd) {
                rdoff = 0x28;
                rd = 0;
            }
            i++;
            if (i < total)
                goto purge_next;
        }
    }
    iSNDleaveaudio();
    return 0;
}
/* SNDPKTPLAY_stop @0x80103118 : stop the voice, purge the whole ring, and idle the player.
 * MATCH: the +0xc pitch field is read TWICE (guard + multiply) and the +0 state word is re-set right
 * before iSNDleaveaudio -- the oracle genuinely RELOADS +0xc a second time (fresh `lhu`) and does NOT
 * sink the +0 store into iSNDleaveaudio's jal delay slot, both of which gcc's CSE/scheduler undo unless
 * the accesses are `volatile` (this player slot IS touched by async playback/IRQ, so the qualifier is
 * semantically correct, not just a match hack). */
extern int SNDPKTPLAY_stop(int p)
{
    int ppp;
    if ((signed char)sndgs[0xf] == 0)
        return -10;
    ppp = sndpps[p];
    iSNDenteraudio();
    SNDstop(MI(ppp, 0));
    SNDPKTPLAY_purge(p, 0, 0x7fffffff);
    if (*(void **)(ppp + 0x1c) != 0 &&
        -1 < (int)((unsigned)*(volatile unsigned short *)(ppp + 0xc) << 0x10)) {
        (*(void (**)(int))(ppp + 0x1c))(MI(ppp, (short) * (volatile short *)(ppp + 0xc) * 0x18 + 0x30));
    }
    *(volatile int *)(ppp + 0) = -1;
    iSNDleaveaudio();
    return 0;
}

/* SNDPKTPLAY_destroy @0x801031F4 : release the player slot. */
extern int SNDPKTPLAY_destroy(int p)
{
    if ((signed char)sndgs[0xf] == 0)
        return -10;
    iSNDplatformpacketplaydestroy(p);
    sndpps[p] = 0;
    return 0;
}

/* iSNDpacketget @0x80103248 : platform pull -- hand out the next sample pointer for channel `idx` of the
 *   head frame, advancing the ring (and firing the release callback) once the last channel is taken.
 *   Writes the frame size to *out.  Returns the channel's sample pointer (0 if none). */
extern int iSNDpacketget(int p, int idx, int *out)
{
    typedef struct PacketFrame {
        int reserved;
        int size;
        int channel[4];
    } PacketFrame;
    int   ppp = sndpps[p];
    short m;
    PacketFrame *fr;

    if ((unsigned)(idx + 1) == (unsigned)MB(ppp, 0x26) &&
        -1 < (int)((unsigned)(*(volatile unsigned short *)(ppp + 0xc)) << 0x10)) {
        m = *(volatile short *)(ppp + 0xc);
        *(volatile short *)(ppp + 0xc) = (short)0xffff;
        {
            void (*cb)(int);
            /* MATCH: compute the completed PacketFrame address before fetching the callback
             * pointer.  The oracle schedules the +0x1c load late, after the independent index
             * arithmetic, and forms the final entry base in the branch delay slot. */
            fr = ((PacketFrame *)(ppp + 0x28)) + m;
            cb = *(void (**)(int))(ppp + 0x1c);
            if (cb != 0)
                cb(fr->channel[0]);
        }
    }
    if (MUH(ppp, 0xe) == 0)                           /* MATCH: direct `return 0` (oracle's v0=0
                                                        * lands in the beqz's delay slot -- the
                                                        * epilogue label IS the return), not a
                                                        * fall-through `fr=0`. */
        return 0;
    fr = ((PacketFrame *)(ppp + 0x28)) + VH(ppp, 0xa);
    *out = fr->size;
    if ((unsigned)(idx + 1) == (unsigned)MB(ppp, 0x26)) {
        MVUH(ppp, 0xc) = MVUH(ppp, 0xa);              /* MATCH: volatile -- two 0xa reads separated
                                                        * by the 0xe store must NOT be hoisted/CSE'd
                                                        * together (oracle keeps them apart). */
        MVUH(ppp, 0xe) = MVUH(ppp, 0xe) - 1;          /* MATCH: volatile -- forces this store to act
                                                        * as an ordering barrier so the SECOND 0xa
                                                        * read (below) doesn't float ahead of it. */
        MVUH(ppp, 0xa) = MVUH(ppp, 0xa) + 1;
        MI(ppp, 0x14) = MI(ppp, 0x14) + fr->size;
        *(volatile int *)(ppp + 0x10) = MI(ppp, 0x10) - fr->size;
        if (VHR(ppp, 0xa) < VHR(ppp, 8))              /* MATCH: raw <<16, no sra (compare-only);
                                                        * goto-skip form (not `>=`) avoids an xori */
            goto rd_ok;
        MVUH(ppp, 0xa) = 0;
    rd_ok:
        ;
    }
    return fr->channel[idx];
}
/* Exact match: modeling each 0x18-byte ring entry as PacketFrame fixes both head-frame addressing
 * and the completed-frame callback argument.  Reusing `fr` for that callback is significant: it
 * retains the natural `m*0x18+0x28` entry base and loads channel[0] at +8, matching the oracle's
 * branch-delay scheduling.  Volatile stores to +0x10 and the wrapped +0x0a index preserve the
 * oracle's ordering and duplicate tail-index calculation. */

/* iSNDpacketfreeframes @0x801033C4 : platform notify -- once the last channel of a frame is consumed,
 *   credit `bytes` back and call the notify callback. */
extern unsigned int iSNDpacketfreeframes(int p, int idx, int bytes)
{
    int          ppp = sndpps[p];
    unsigned int v = (unsigned int)MB(ppp, 0x26);
    do {
        if ((unsigned)(idx + 1) == v) {
            v = MI(ppp, 0x14) - bytes;
            *(volatile int *)(ppp + 0x14) = (int)v;   /* MATCH: volatile blocks gcc from sinking this
                                                    * store into the `beqz` guard's delay slot -- the
                                                    * oracle keeps it a separate unconditional insn
                                                    * (with an explicit nop in the slot) because this
                                                    * field (+0x14 bytes-consumed) is async-touched,
                                                    * same class as the ring-index VH() fields. Was
                                                    * 13->10 diffs, insn count 23->24 (now == oracle). */
            if (*(void **)(ppp + 0x20) != 0)
                v = (*(unsigned int (**)(int, unsigned int))(ppp + 0x20))(p, (unsigned int)bytes);
            /* MATCH: the 2-arg callback keeps the original p in $a0; the zero-iteration
             * scope around this block and return recovers the oracle's v0/v1 coloring. Previously
             * a 10-diff floor (was 23 after landing the callback signature): oracle NEVER
             * clobbers $a0 across the whole function -- it keeps `ppp` in $v1, not $a0, specifically
             * so the ORIGINAL param `p` survives unchanged in $a0 for this final call, which passes
             * (p, bytes) not just (bytes). Residual = a PURE v0/v1 scratch-register tie-break on the
             * `&sndpps + p*4` address materialization (§3.15 family; identical shape to
             * SNDPKTPLAY_submitspace's 2-diff floor): oracle materializes the base ptr into $v1 THEN
             * the index into $v0, ours does the reverse. Tried: splitting `&sndpps` into a named
             * pointer local before indexing (no change, both here and in submitspace). Allocator/
             * scheduler floor, not source-reachable; permuter candidate. */
        }
        return v;
    } while (0);
}

/* owning-TU def (extern-declared, never defined; link-harness) */
int iSNDplatformrate[1];
