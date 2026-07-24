/* eaclib/psx/sndpsxz/spktplay.cpp -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 13/13 ***
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

extern "C" int  sndpps[];                /* @0x80148574 -- one-slot player pointer array */
extern "C" int  sndgs[];                  /* (signed char)sndgs[0xf]=init, sndgs[0x25]=channel pool base */
/* HEADER WISH: the oracle actually loads this global from D_80147900 (SNDPKTPLAY_start @0x80102C34,
 * iSNDplaytaggedtimbre @0x801020D8 -- same "rate * ch-field * ch-field, magic-const mult, dur"
 * idiom both places), NOT 0x80147840 as this decl previously claimed. Doesn't affect verify_asm
 * (relocations are name/addend-erased) but the address comment was wrong; not chased further this
 * pass -- flag for whoever materializes/cross-checks sndpsxz globals next. */
extern "C" int  iSNDplatformrate[1];      /* @0x80147900 -- platform sample rate (pitch calc) */

/* ---- backends ---- */
extern "C" int  iSNDplatformpacketoverhead(void);                           /* sdpacket */
extern "C" int  iSNDplatformpacketplaycreate(int slot, int *mem);
/* H10: 9-arg per oracle call @0x80102C94 (a0..a3 + sp+16/20/24/28/32). sdpacket's def reads 8
 *   (volAngle,level,pitch,a6,fxlevel,hdr-ptr); a9=hdr+0xc is pushed-but-unused, matching the binary. */
extern "C" int  iSNDplatformpacketplay(int p, int note, int volAngle, int level,
                                       int pitch, int a6, int fxlevel, int hdr, int a9);
extern "C" void iSNDplatformpacketplaydestroy(int p);
extern "C" int  iSNDallocchan(int a, int b, int c, int *out);               /* salloc */
extern "C" void iSNDfreechan(int note);
extern "C" void iSNDcalcpitch(int note);                                    /* sclcptch */
extern "C" void iSNDcalcvol(int note);                                      /* spatkey  */
extern "C" void SNDstop(unsigned int voice);                                /* sstop    */
extern "C" void iSNDenteraudio(void);                                       /* sserver  */
extern "C" void iSNDleaveaudio(void);

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
extern "C" int iSNDpacketplayoverhead(int n);                /* @0x801028BC */
extern "C" int SNDPKTPLAY_overhead(int n);                   /* @0x801028D0 */
extern "C" int SNDPKTPLAY_create(int mem, int memsize, int relcb, int notifycb); /* @0x801028FC */
extern "C" int SNDPKTPLAY_start(int p, int rate, int hdr, int params);       /* @0x80102A10 */
extern "C" int SNDPKTPLAY_submit(int p, int frame);          /* @0x80102CFC */
extern "C" int SNDPKTPLAY_submitspace(int p);                /* @0x80102E70 */
extern "C" int SNDPKTPLAY_unsafeframesoutstanding(int p);    /* @0x80102EC4 */
extern "C" int SNDPKTPLAY_framesoutstanding(int p);          /* @0x80102EEC */
extern "C" int SNDPKTPLAY_purge(int p, int lo, int hi);      /* @0x80102F3C */
extern "C" int SNDPKTPLAY_stop(int p);                       /* @0x80103118 */
extern "C" int SNDPKTPLAY_destroy(int p);                    /* @0x801031F4 */
extern "C" int iSNDpacketget(int p, int idx, int *out);      /* @0x80103248 */
extern "C" unsigned int iSNDpacketfreeframes(int p, int idx, int bytes);     /* @0x801033C4 */

/* ====================================================================================== */

/* iSNDpacketplayoverhead @0x801028BC : bytes of player bookkeeping for `n` frames. */
extern "C" int iSNDpacketplayoverhead(int n)
{
    return n * 0x18 + 0x40;
}

/* SNDPKTPLAY_overhead @0x801028D0 : total player overhead (bookkeeping + platform). */
extern "C" int SNDPKTPLAY_overhead(int n)
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
extern "C" int SNDPKTPLAY_create(int mem, int memsize, int relcb, int notifycb)
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
extern "C" int SNDPKTPLAY_start(int p, int rate, int hdr, int params)
{
    int ppp, note, allocOut, ch, s3len, t4, v1, dur, r;
    int rateb2;
    char *gp = (char *)sndgs;                     /* MATCH: hoist &sndgs ONCE into a var that
                                                    * survives across enteraudio/allocchan -- the
                                                    * guard and the 0x25 pool-base lookup share the
                                                    * SAME materialized base in the oracle ($s3),
                                                    * held in a callee-saved reg across both calls. */
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

    MI(ppp, 0)    = allocOut;
    MH(ppp, 0xa)  = 0;
    MH(ppp, 0xe)  = 0;
    MI(ppp, 0x10) = 0;
    MI(ppp, 4)    = 0;
    MI(ppp, 0x14) = 0;
    MH(ppp, 0xc)  = (short)0xffff;
    ch = *(int *)(gp + 0x94) + note * 100;        /* MATCH: note*100 computed right after the
                                                    * marker store, before the unaligned copy;
                                                    * the pool-base add is a branch delay-slot
                                                    * filler for the s3len test below either way */
    *(int *)(ppp + 0x24) = *(int *)rate;          /* unaligned rate-word copy (asm: lwl/lwr) */

    if (MSB(params, 0xb) != 0)
        s3len = MUH(params, 0x10);
    else
        s3len = ((MSB(params, 7) - 0x40) << 8) & 0xffff;

    MB(ch, 0xa)   = 0xff;
    MUH(ch, 0x5c) = MUH(hdr, 4);
    MI(ch, 0x14)  = 0;
    MUH(ch, 0x60) = MUH(params, 0xc);
    MI(ch, 0x20)  = 0;
    MI(ch, 0x28)  = 0x7fffffff;
    MI(ch, 0x24)  = 0x7f0000;
    MI(ch, 0x1c)  = (int)MSB(params, 8) << 0x10;
    MB(ch, 0x2c)  = MB(hdr, 7);
    MB(ch, 0x2e)  = MB(hdr, 8);
    MB(ch, 0x30)  = 1;
    MB(ch, 0x31)  = 0;
    MB(ch, 0x32)  = 0;
    MB(ch, 0x33)  = 1;
    MB(ch, 0x2f)  = MB(params, 9);   /* H09: src was hdr (oracle 0x80102B90 *(u8)(9+$s4=params)) */
    MB(ch, 0x34)  = MB(hdr, 9);      /* H09: src was params (oracle 0x80102BAC *(u8)(9+$s5=hdr)) */
    MB(ch, 0x35)  = MB(params, 10);  /* H09: src was hdr (oracle 0x80102BB8 *(u8)(10+$s4=params)) */
    MH(ch, 0x5a)  = (short)(MSB(hdr, 10) * 100);
    MB(ch, 0x37)  = 0;
    MB(ch, 0x36)  = 0;
    /* MATCH: 0x40/0x44 zeros BEFORE the 0x3d store, 0x48/0x4c/0x50/0x54 AFTER -- oracle interleaves
     * `a0=note` (calcpitch's arg) between MB(params,7) and the first zero pair. */
    MI(ch, 0x40)  = 0;
    MI(ch, 0x44)  = 0;
    MB(ch, 0x3d)  = MB(params, 7);   /* H09: src was hdr (oracle 0x80102BE8 *(u8)(7+$s4=params)) */
    MI(ch, 0x48)  = 0;
    MI(ch, 0x4c)  = 0;
    MI(ch, 0x50)  = 0;
    MI(ch, 0x54)  = 0;

    iSNDcalcpitch(note);
    MH(ch, 0x5e)  = 0;               /* MATCH: independent store -- oracle schedules it into the
                                       * calcpitch jal's delay slot */
    iSNDcalcvol(note);

    /* pitch -> playback duration: rate * ch[0x34] * ch[0x35], divided by a fixed constant */
    t4 = iSNDplatformrate[0] * MSB(ch, 0x34);
    v1 = t4 * MSB(ch, 0x35);
    {
        long long pr = (long long)v1 * (int)0x82061029;
        dur = (((int)(pr >> 32) + v1) >> 0xD) - (v1 >> 0x1f);
    }
    /* H10: oracle (0x80102C94) passes 9 args; was 6 with dur/rate/hdr+0xc in the wrong slots and
       ch[0x2d]/ch[0x62]/params[0xe] missing.  a0..a3 + sp+16/20/24/28/32. */
    r = iSNDplatformpacketplay(p, note, s3len, MSB(ch, 0x2d), MUH(ch, 0x62),
                               MUH(params, 0xe), dur, rate, hdr + 0xc);
    if (r < 0) {
        iSNDfreechan(note);
        iSNDleaveaudio();
        return r;
    }
    iSNDleaveaudio();
    return MI(ppp, 0);
}
/* near-miss floor (183->179 diffs, ours 186 / oracle 187 insns). This is the biggest fn in the file
 * (9 params/locals -- p,rate,hdr,params,&sndgs,ppp,note,ch,s3len -- all callee-saved, live across
 * 2-3 calls each). Fixes kept: `MB(rate,2)` evaluated before the ppp lookup (oracle hoists this
 * alloc-arg early), the 0x40/0x44-then-0x3d-then-0x48.. zero-store interleave + MH(ch,0x5e)=0 as
 * its own statement (lands in calcpitch's jal delay slot), `ch`'s note*100 positioned right after
 * the 0xc marker store (before the unaligned rate copy). Tried and NOT kept as a further win: an
 * explicit `char *gp=(char*)sndgs;` hoisted pointer for the guard+pool-base lookup (matches the
 * oracle's single materialize-once-reuse-across-calls shape SEMANTICALLY, and gp DOES land in a
 * saved reg spanning the calls) -- but it doesn't change the diff count; the residual is a pure
 * GLOBAL-ALLOCATOR REGISTER-NUMBER PERMUTATION (same class as SNDPKTPLAY_purge's ppp/wrptr swap):
 * the SAME set of ~9 long-lived locals gets the SAME 9 callee-saved registers, just numbered
 * differently (ours: hdr/params/gp -> s4/s3/s5; oracle: s5/s4/s3) -- decl order/scope permutations
 * don't move this (per purge's finding); needs an RTL -dg/-dl dump or the permuter. Every `!=` line
 * in the diff is register-renumbering fallout of this one root cause; no further structural bugs
 * were found on this pass. */

/* SNDPKTPLAY_submit @0x80102CFC : append a frame (descriptor `frame`) to the player's ring.  Returns the
 *   submit sequence number, or -0xD if the ring is full. */
extern "C" int SNDPKTPLAY_submit(int p, int frame)
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
 * branch; reversing their source order swaps a1/v1 throughout the loop and is worse. */

/* SNDPKTPLAY_submitspace @0x80102E70 : free frame slots in the ring. */
extern "C" int SNDPKTPLAY_submitspace(int p)
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
extern "C" int SNDPKTPLAY_unsafeframesoutstanding(int p)
{
    int ppp = sndpps[p];
    return MI(ppp, 0x10) + MI(ppp, 0x14);
}

/* SNDPKTPLAY_framesoutstanding @0x80102EEC : same, inside a critical section. */
extern "C" int SNDPKTPLAY_framesoutstanding(int p)
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
 *   MATCH (oracle-traced): (1) VH() volatile-short reads for wr/rd/total/ringsize -- same async-slot
 *   shape as submit/submitspace/stop/iSNDpacketget; (2) REMOVE ("lo<=fr0<=hi") is the branch-away/
 *   fallthrough arm and KEEP is the oracle's explicit two-`bnez`-to-the-same-label branch target --
 *   logically identical to the old "keep-first" if/else, just the inverse polarity gcc actually
 *   emits for this `&&`/`||` pair (not a correctness bug, a codegen-shape fix). */
extern "C" int SNDPKTPLAY_purge(int p, int lo, int hi)
{
    int   ppp, i, wr, rd, total, rdoff, wrptr;

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
    wr    = VH(ppp, 0xa);                          /* write (compaction) index  */
    rd    = VH(ppp, 0xa);                          /* read index (re-read, MATCH: async slot) */
    total = VH(ppp, 0xe);                          /* frames to scan            */
    if (0 < total) {
        rdoff = rd * 0x18 + 0x28;
        wrptr = wr * 0x18 + ppp;
        do {
            int *fr = (int *)(ppp + rdoff);
            if (lo <= fr[0] && fr[0] <= hi) {      /* remove (branch-away, oracle fallthrough) */
                MUH(ppp, 0xe) = MUH(ppp, 0xe) - 1;  /* plain lhu, no shift (no compare) */
                MI(ppp, 0x10) = MI(ppp, 0x10) - fr[1];
                if (*(void **)(ppp + 0x1c) != 0)
                    (*(void (**)(int))(ppp + 0x1c))(fr[2]);
            } else {                               /* keep -> move down (oracle branch target) */
                /* MATCH (load-3/store-3 family, catalog §A row 38): the oracle batches the 6-word
                 * copy as load-4/store-4 then load-2/store-2 (4 then 2 distinct caller-saved temps,
                 * $a3/$t0/$t1/$t2) instead of interleaving one load+store per field -- named temps
                 * reproduce the parallel chains and kill the load-delay nop per field. */
                int c0 = fr[0], c1 = fr[1], c2 = fr[2], c3 = fr[3];
                MI(wrptr, 0x28) = c0;
                MI(wrptr, 0x2c) = c1;
                MI(wrptr, 0x30) = c2;
                MI(wrptr, 0x34) = c3;
                {
                    int c4 = fr[4], c5 = fr[5];
                    MI(wrptr, 0x38) = c4;
                    MI(wrptr, 0x3c) = c5;
                }
                wr++;
                wrptr += 0x18;
                if (VH(ppp, 8) <= wr) {
                    wr = 0;
                    wrptr = ppp;
                }
            }
            rdoff += 0x18;
            rd++;
            if (VH(ppp, 8) <= rd) {
                rdoff = 0x28;
                rd = 0;
            }
            i++;
        } while (i < total);
    }
    iSNDleaveaudio();
    return 0;
}
/* near-miss floor (102->65->66 diffs, ours 124->119 / oracle 119 insns -- INSN COUNT NOW EXACT).
 * wave 21-a8: applied the load-3/store-3 batching lever (catalog §A row 38) to the "keep" branch's
 * 6-word field copy -- named temps `c0..c3` (load all 4, then store all 4) + a nested `{c4,c5}`
 * pair reproduce the oracle's load-4/store-4-then-load-2/store-2 shape (was: one interleaved
 * load+store per field, costing a load-delay nop each -> 5 extra insns). Diff count is technically
 * flat (65->66, +1) but insn count moved DECISIVELY to an exact match (124->119 == oracle's 119) --
 * kept per verify-or-revert rule 1's insn-count carve-out; the diff floor is now PURELY the
 * pre-existing s0/s1 swap below, not a real regression.
 * ALL remaining diffs trace to ONE root cause: `ppp` colors to `$s1` in ours vs the oracle's `$s0`,
 * and `wrptr` takes the register ours gives `ppp` -- i.e. `ppp`/`wrptr` are SWAPPED in the s0..s7+fp
 * permutation (9 locals live across the in-loop `jalr` callback -> every callee-saved reg incl.
 * `$fp` is in play). Tried (both waves): moving `i=0` earlier (81->78, real partial win, kept),
 * `wrptr` at function scope vs block scope (no effect), decl order permutations incl. one matching
 * the oracle's exact definition order ppp,i,wr,rd,total,rdoff,wrptr (no effect), the load-3/store-3
 * batching above (fixed insn count but not the swap) -- decl order/scope/batching do NOT move this
 * specific swap. This is a global-allocator PRIORITY tie-break (refs/live-length, §3.12b) between
 * two heavily-used long-lived pseudos, not a source-shape lever on hand; needs an `-dg`/`-dl` RTL
 * dump or the permuter to crack (permuter run launched this pass, see permuter_work/SNDPKTPLAY_purge
 * for results). Every downstream `!=` line in the diff is this same swap propagating (tail fully
 * matches once s0<->s1 is mentally swapped). */

/* SNDPKTPLAY_stop @0x80103118 : stop the voice, purge the whole ring, and idle the player.
 * MATCH: the +0xc pitch field is read TWICE (guard + multiply) and the +0 state word is re-set right
 * before iSNDleaveaudio -- the oracle genuinely RELOADS +0xc a second time (fresh `lhu`) and does NOT
 * sink the +0 store into iSNDleaveaudio's jal delay slot, both of which gcc's CSE/scheduler undo unless
 * the accesses are `volatile` (this player slot IS touched by async playback/IRQ, so the qualifier is
 * semantically correct, not just a match hack). */
extern "C" int SNDPKTPLAY_stop(int p)
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
extern "C" int SNDPKTPLAY_destroy(int p)
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
extern "C" int iSNDpacketget(int p, int idx, int *out)
{
    struct PacketFrame {
        int reserved;
        int size;
        int channel[4];
    };
    int   ppp = sndpps[p];
    short m;
    PacketFrame *fr;

    if ((unsigned)(idx + 1) == (unsigned)MB(ppp, 0x26) &&
        -1 < (int)((unsigned)(*(volatile unsigned short *)(ppp + 0xc)) << 0x10)) {
        m = *(volatile short *)(ppp + 0xc);
        *(volatile short *)(ppp + 0xc) = (short)0xffff;
        {
            /* MATCH: compute the completed PacketFrame address before fetching the callback
             * pointer.  The oracle schedules the +0x1c load late, after the independent index
             * arithmetic, and forms the final entry base in the branch delay slot. */
            fr = ((PacketFrame *)(ppp + 0x28)) + m;
            void (*cb)(int) = *(void (**)(int))(ppp + 0x1c);
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
extern "C" unsigned int iSNDpacketfreeframes(int p, int idx, int bytes)
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
extern "C" { int iSNDplatformrate[1]; }
