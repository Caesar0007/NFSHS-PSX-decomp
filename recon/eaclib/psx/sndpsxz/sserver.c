/* eaclib/psx/sndpsxz/sserver.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 6/6 ***
 *   Source obj : nfs4\eaclib\psx\sserver.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   6 fns @[0x800EA138 .. 0x800EA620].  The sound-system tick server: catches the audio clock up to real
 *   time (iSNDserver), runs one 100 Hz tick (iSND100hzserver: per-voice pitch/vol envelopes + portamento +
 *   pitch sweeps), the audio re-entrancy lock (iSNDenteraudio/leaveaudio) and the 100 Hz client list.
 *   Ghidra nfs4-f.exe.c (sserver) + IDA sigs.
 *
 *   sndgs (int[]) fields used here:  [0xf] byte2 (0x3e) = "in server" flag, byte3 (0x3f) = audio-lock depth;
 *   [4] byte1 (0x11) = channel count; [0x10] byte0 (0x40) = 100 Hz client count; [0x11] = audio tick;
 *   [0x12] = serve callback; [0x13..] = 100 Hz client fn-ptrs; [0x25] = channel pool; [0x2b] = real ticks.
 *   Channel slot (sndgs[0x25] + voice*100): +0x0 tag, +0xb state, +0x14 vel-env ptr, +0x15(*0x54) lfo ptr,
 *   +0x20/+0x24/+0x28 sweep step/accum/count, +0x2d vol, +0x30 sweep cnt, +0x31 sweep idx, +0x39/0x3a/0x3b
 *   lfo/vel/pitch phase, +0x40 sweep tbl, +0x5e pitch cache, +0x62 final pitch.
 */

extern int           sndgs[];
extern int           timerhz[];          /* hardware tick rate            */
/* sndgs = 0x80147860 (configs/symbol_addrs.txt); DAT_80147910/DAT_80147912 are FIELDS of sndgs itself
 * (+0xB0 / +0xB2), not separate globals -- confirmed by oracle's lhu/sh %B2(s0) off the SAME &sndgs base
 * used for GB()/GUB() field accesses (iSNDleaveaudio). Both are SHORT (16-bit lhu/sh), not int. */
#define DAT_80147910 (*(short *)((char *)sndgs + 0xB0))   /* last-seen timerhz             */
#define DAT_80147912 (*(short *)((char *)sndgs + 0xB2))   /* deferred-server request count */

extern void SNDI_mutexlock(void);        /* sdfx     */
extern void SNDI_mutexunlock(void);      /* sdfx     */
extern void iSNDserve(void);             /* slib     */
extern int  iSNDcalcpitch(int note);     /* sclcptch */
extern int  iSNDplatformpitch(int chan, int pitch);   /* sdriver */
extern int  iSNDvol(int chan, int level);             /* sdriver */
extern void iSNDcalcvol(int chan);            /* spatkey */
extern int  SNDstop(unsigned int tag);                /* sstop   */
extern void trap(unsigned int code);

extern void iSNDserver(void);                         /* @0x800EA138 */
extern void iSND100hzserver(void);                    /* @0x800EA254 */
extern void iSNDenteraudio(void);                     /* @0x800EA534 */
extern void iSNDleaveaudio(void);                     /* @0x800EA56C */

#define GB(idx) (((char *)sndgs)[idx])            /* signed byte of sndgs    */
#define GUB(idx) (((unsigned char *)sndgs)[idx])  /* unsigned byte of sndgs  */

/* iSNDserver @0x800EA138 : advance the audio clock -- run iSND100hzserver (sndgs[0x12]) once per elapsed
 *   100 Hz tick to catch sndgs[0x11] up to (real ticks * 100 / timerhz).  Defers if audio is locked.
 * MATCH (w29-a5, 72->37 diffs, ours 69/71->66/71 insns): four structural fixes over the prior recon:
 * (1) the `timerhz==0` guard is NOT a call to trap() -- the oracle's `divu zero,v0,a1 / bnez a1,T / nop /
 *     break 7` is the RAW unchecked `divu` immediately followed by hand-written zero-check code that
 *     compiles straight to a bare `break 7`; a `trap(0x1c00)` C call instead emits a genuine `jal`+arg
 *     setup the oracle never has. Just divide -- no explicit zero-check statement needed in C.
 * (2) needs ONE shared base pointer `p=(char*)sndgs` routed through EVERY field access (matching the
 *     sibling iSND100hzserver/iSNDserverremove100hzclient idiom) -- using the GB()/DAT_* macros' own
 *     separate `(char*)sndgs` casts per access kept re-deriving the address instead of reusing one lui/addiu.
 * (3) `if (locked) { defer; return; }` (inverted polarity + early-return), not `if (!locked){work}else{defer}`
 *     -- the oracle's branch falls through into the deferred-count path and jumps PAST the work section,
 *     the opposite of a natural if/else lowering.
 * (4) sndgs[0x2b] (real-tick counter, offset 0xac) needs a VOLATILE re-read for the multiply operand --
 *     oracle stores the incremented count back to memory then re-loads it fresh for `*100/timerhz` instead
 *     of reusing the just-computed register value (same re-read lever as sst.c's MVI macro).
 * A SEPARATE `g` (not `p`) feeds the loop/callback pointer: `p` only needs to live in a0 up to the
 * point the loop's `jalr` call clobbers caller-saved regs; the sibling-idiom base pointer must NOT itself
 * be the value carried across that call, or gcc pins it into s0 for the WHOLE function (oracle only makes
 * that copy right before the loop, and recomputes sndgs fresh again for the final `GB(0x3e)=0` after it).
 * *** MATCH 71/71 (w32-a8, 37 -> 0 diffs).  Four more fixes, in the order they landed:
 * (5) ROTATED LOOP WITH AN ENTRY GUARD, guard and body on DIFFERENT pointers (37->21, 66->70 insns).
 *     The oracle peels the first `<= target` test before the loop (`lw v0,0x44(a0); sltu; bnez -> exit`),
 *     puts `addu s0,a0,zero` after it, and re-tests through s0 at the back edge -- i.e.
 *     `if (test on p) { g = p; do {...} while (test on g); }`.  A plain `while` lowers to the un-rotated
 *     jump-to-test form and is 5 insns short.  NOTE the earlier attempt logged here as "no diff-count
 *     effect" used the SAME variable in the guard and the back-edge test, so gcc cross-jump-merged the
 *     two tests back into one; keeping them textually distinct (p vs g) is what makes the rotation stick.
 * (6) `extern int timerhz[];` + `timerhz[0]` -- the UNSIZED-ARRAY declaration lever (methodology 3.12 #5),
 *     here in its ADDRESS-materialization form (21->9): it forces &timerhz into its OWN register
 *     (`lui v1,%hi(timerhz)` hoisted to the top of the block) which the oracle then SHARES between the
 *     `lw a1,%lo(timerhz)(v1)` compare load and the later `lhu v0,%lo(timerhz)(v1)` halfword re-read.
 *     Declared as a scalar, each access self-temps its own `lui` (2 extra insns, no sharing).  This also
 *     freed the `li v0,1` that reorg then steals into the `beqz` delay slot for the `GB(0x3e)=1` store.
 * (7) VOLATILE on the three fields the 100 Hz callback / IRQ path also touches -- sndgs[0x11] (0x44,
 *     the audio clock, already volatile in iSND100hzserver), sndgs[0x2b] (0xac, the real-tick counter)
 *     and the 0xb2 deferred-request count (already volatile in iSNDleaveaudio).  Without them gcc's
 *     scheduler hoists the two `sw zero` clears above the `sh` into the timerhz load-delay slot, and
 *     reorg steals the 0xb2 `sh` into the `j` delay slot where the oracle leaves a nop (9->6->3).
 * (8) the trailing flag clear is a VOLATILE-pointer store `{volatile char *q = (volatile char*)sndgs;
 *     q[0x3e] = 0;}` (3->0).  Only the volatile-qualified pointer makes gcc materialize the ADDRESS in a
 *     register (`lui;addiu;sb 0x3E(v0)` -- and reorg then steals that `lui` into BOTH loop-exit delay
 *     slots) instead of folding +0x3e into the reloc (`lui;sb %lo(sndgs+0x3e)`, 1 insn short).  A plain
 *     `char *q`, a bare `((char*)sndgs)[0x3e]`, an `(int)` cast and a volatile MEM cast all fold.
 *     Re-using `p` here instead is NOT the answer: it makes p live across the jalr, so gcc pins it in s1
 *     for the whole function (71/71 insns but 56 diffs).  The 0x3e re-entrancy flag is genuinely volatile
 *     (it guards against re-entry from the IRQ/leaveaudio path), so its read and its `=1` store carry the
 *     qualifier too -- all four spellings byte-match, the consistent one is kept. */
extern void iSNDserver(void)
{
    char *p;
    char *g;
    unsigned int target;

    p = (char *)sndgs;
    if (*(volatile unsigned char *)(p + 0x3e) == 0) {           /* not already inside the server */
        if (*(unsigned char *)(p + 0x3f) != 0) {       /* audio locked -- defer */
            *(volatile short *)(p + 0xb2) = *(volatile short *)(p + 0xb2) + 1;   /* run it later, on leaveaudio */
            return;
        }
        *(volatile unsigned char *)(p + 0x3e) = 1;
        if (timerhz[0] != (((int)(*(volatile unsigned short *)(p + 0xb0)) << 16) >> 16)) {
            *(volatile short *)(p + 0xb0) = (short)timerhz[0];
            *(volatile int *)(p + 0x44) = 0;
            *(volatile int *)(p + 0xac) = 0;
        }
        *(volatile int *)(p + 0xac) = *(volatile int *)(p + 0xac) + 1;
        target = (unsigned int)(*(volatile int *)(p + 0xac) * 100) / (unsigned int)timerhz[0];
        if ((unsigned int)*(int *)(p + 0x44) <= target) {
            g = p;
            do {
                (*(void (*)(void))*(int *)(g + 0x48))();
            } while ((unsigned int)*(int *)(g + 0x44) <= target);
        }
        { volatile char *q = (volatile char *)sndgs; q[0x3e] = 0; }
    }
}
/* iSND100hzserver @0x800EA254 : one 100 Hz tick -- bump the audio clock, run the stream/serve pump and the
 *   registered 100 Hz clients, then for every held voice step its pitch LFO, the AUTO-VOLUME ramp and the
 *   VOLUME ENVELOPE, recomputing SPU pitch/volume (and stopping voices whose envelope runs out).
 *   FIELD SEMANTICS PROVEN by the NFS2-PC beta ancestor (Watcom debug names, byte-matched:
 *   C:/Temp/nfs2-clean/pc-beta/match/sserver.obj/iSND100hzserver.c -- same TU cmn/sserver.c):
 *   p[5]/p[6]/p[7] = autovol_step/autovol_target/current_volume (0x14/0x18/0x1C -- a volume ramp, NOT
 *   portamento); p[8]/p[9]/p[10] = envelope_step/envelope_volume/envelope_duration (0x20/0x24/0x28);
 *   +0x2d = mixed_volume (s8, the iSNDvol arg); +0x30/+0x31 = envelope_count/envelope_index;
 *   p[0x10] = SND_ENVELOPE_POINT{int duration; int volume;}[] (the stride-8 table; <<16 = 16.16 volume);
 *   the 100 Hz client array generalizes NFS2's discrete midiserver/speechserver/crowdserver/pathserver
 *   pointers; NFS4 dropped NFS2's malformed-envelope abortmessage and added the pitch-LFO block. */
extern void iSND100hzserver(void)
{
    int *g;
    int i;
    int chanIdx;
    int *channelBase;
    int *globalBase;
    unsigned int *p;
    int dirty;

    g = sndgs;
    *(volatile int *)(g + 0x11) = *(volatile int *)(g + 0x11) + 1;
    i = 0;
    iSNDserve();
    if (0 < *(signed char *)((char *)g + 0x40)) { /* run the 100 Hz client callbacks */
        int *clientBase = g;
        do {
            (*(void (*)(void))g[0x13])();
            g++;
            i++;
        } while (i < (int)*(signed char *)((char *)clientBase + 0x40));
    }

    channelBase = sndgs;
    i = 0;
    if (*(unsigned char *)((char *)channelBase + 0x11) != 0) { /* over every channel */
        globalBase = channelBase;
        chanIdx = i;
        do {
            p = (unsigned int *)(globalBase[0x25] + chanIdx);
            if (*(signed char *)((int)p + 0xb) == 1 && -1 < (int)*p) { /* held, valid tag */
                if (p[0x15] != 0) {                                 /* pitch LFO active */
                    unsigned char phase = *(unsigned char *)((int)p + 0x3b) + 1;
                    *(unsigned char *)((int)p + 0x3b) = phase;
                    if (*(unsigned char *)((int)p + 0x39) <= phase)
                        *(unsigned char *)((int)p + 0x3b) = 0;
                    *(short *)((int)p + 0x5e) = 0;
                    iSNDcalcpitch(i);
                    iSNDplatformpitch(i, (int)(unsigned)*(unsigned short *)((int)p + 0x62));
                }
                dirty = 0;
                if (p[0x14] != 0) {                                 /* velocity envelope active */
                    unsigned char phase;
                    dirty = 1;
                    phase = *(unsigned char *)((int)p + 0x3a) + 1;
                    *(unsigned char *)((int)p + 0x3a) = phase;
                    if (*(unsigned char *)((int)p + 0x38) <= phase)
                        *(unsigned char *)((int)p + 0x3a) = 0;
                }
                {
                    /* MATCH (184/184): keep the step as direct field reads. GCC CSEs them into the
                     * oracle's step/sign register pair while retaining `position` as the add result. */
                    if (p[5] != 0) {                                   /* autovol ramp step */
                        int position;
                        dirty = 1;
                        position = (int)p[7] + (int)p[5];
                        p[7] = (unsigned int)position;
                        if ((int)p[5] < 0) {
                            if (!((int)p[6] < position)) {
                                p[7] = p[6];
                                p[5] = 0;
                            }
                        } else if (!(position < (int)p[6])) {
                            p[7] = p[6];
                            p[5] = 0;
                        }
                        /* 🔴 2026-08-10 REAL BUG FIX (found by the real-ASPSX byte confirm):
                         * this negative-volume stop is INSIDE the ramp block -- retail's
                         * `beqz a0` skips PAST it when the step is 0 (word 10800015 vs our
                         * old 10800011), and the NFS2-PC ancestor agrees (current_volume<0
                         * check nested in `if (step != 0)`).  The old placement ran the
                         * check every tick.  verify_asm was BLIND to it (branch-target
                         * lenient by design) -- objdiff's 99.97% was flagging exactly this. */
                        if ((int)p[7] < 0) { SNDstop(*p); goto next_chan; }
                    }
                }
                /* portamento done -> pitch sweep */
                if (p[8] != 0) { dirty = 1; p[9] = p[9] + p[8]; }
                if (p[10] == 0) {                                   /* advance to next sweep segment */
                    signed char index = *(unsigned char *)((int)p + 0x31) + 1;
                    *(unsigned char *)((int)p + 0x31) = index;
                    if (!(index < *(signed char *)((int)p + 0x30))) {
                        SNDstop(*p);
                        goto next_chan;
                    } else {
                        int *table = (int *)(p[0x10] + index * 8);
                        p[10] = table[0];
                        if ((int)p[10] < 0)
                            p[10] = 0x7fffffff;
                        p[8] = (table[1] * 0x10000 - (int)p[9]) / (int)p[10];
                    }
                }
                p[10] = p[10] - 1;
                if (dirty) {
                    iSNDcalcvol(i);
                    if (-1 < (int)*p)
                        iSNDvol(i, (int)*(signed char *)((int)p + 0x2d));
                }
            }
next_chan:
            chanIdx += 100;
            i++;
        } while (i < (int)(unsigned)*(unsigned char *)((char *)globalBase + 0x11));
    }
}

/* iSNDenteraudio @0x800EA534 : take the audio re-entrancy lock (mutex + depth++). */
extern void iSNDenteraudio(void)
{
    char *g;
    SNDI_mutexlock();
    g = (char *)sndgs;   /* materialize &sndgs (lui+addiu) AFTER the call so it lands in a caller-saved reg */
    g[0x3f] = g[0x3f] + 1;
}

/* iSNDleaveaudio @0x800EA56C : release the audio lock; at depth 0, flush any servers deferred while held. */
extern void iSNDleaveaudio(void)
{
    char *g = (char *)sndgs;      /* held across the call (oracle: callee-saved $s0) */
    *(volatile unsigned char *)(g + 0x3f) =
        *(volatile unsigned char *)(g + 0x3f) - 1;
    SNDI_mutexunlock();
    if (*(volatile unsigned char *)(g + 0x3f) == 0) {
        while (*(volatile unsigned short *)(g + 0xB2) != 0) {
            *(volatile unsigned short *)(g + 0xB2) =
                *(volatile unsigned short *)(g + 0xB2) - 1;
            iSNDserver();
        }
    }
}

/* iSNDserveradd100hzclient @0x800EA5F0 : register a 100 Hz tick callback `cb`; returns sndgs.
 *   Count read SIGNED (lb) for the index, UNSIGNED (lbu) for the increment-store.
 * MATCH: byte-base cast keeps oracle's sll(lb*4) then addu then sw a0,0x4c(v1) displacement form */
extern short *iSNDserveradd100hzclient(int cb)
{
    /* MATCH: index sndgs by the raw client count ONLY (base = sndgs + count*4, scaled by sizeof(int)
     * with no other term folded into the index) and fold the 0x13-slot (0x4c-byte) client-array
     * offset into the store DISPLACEMENT via a byte-base cast -- oracle emits sll(count*4); addu
     * base; sw a0,0x4c(base). Indexing sndgs[count+0x13] instead adds 0x13 to the INDEX before the
     * *4 scale (extra addiu v1,v1,19 before the sll) -- not what the oracle does. */
    char *base = (char *)sndgs;
    *(int *)(base + (signed char)base[0x40] * 4 + 0x4c) = cb;
    GB(0x40) = GB(0x40) + 1;
    return (short *)sndgs;
}

/* iSNDserverremove100hzclient @0x800EA620 : unregister a 100 Hz callback, compacting the client list.
 *
 * MATCH (w49-a7, 3 -> PASS 43/43): the twin of ssysserv.c iSNDserverremoveclient, cracked by the same
 * single lever -- the w47 OPACITY/IDENTITY FENCE `__asm__("" : "=r"(target) : "0"(cb))` as the FIRST
 * statement, with the parameter back to an honest plain `int cb`.  `target`'s def is an asm_operands
 * (not a REG) so global.c `set_preference` never gives it the $a0 copy preference, and `cb` now dies
 * at the fence so it stops conflicting with the loop index -- `regs_someone_prefers[i]` loses $a0 and
 * the {i,base,cb} = {$a0,$a1,$a2} rotation lands; the `"0"` matching constraint makes reload emit
 * retail's `addu $a2,$a0,$zero` at insn 0 at zero cost.  Full mechanism + the -dg receipt is on the
 * twin in ssysserv.c.  (Retires the w33/w34 `volatile`-param 3-diff floor on BOTH twins.) */
extern void iSNDserverremove100hzclient(int cb)
{
    int i;
    int j;
    int target;
    char *base;
    char *p;

    __asm__("" : "=r"(target) : "0"(cb));
    p = (char *)sndgs;
    if (*(signed char *)(p + 0x40) <= 0)
        return;
    i = 0;
    base = p;
findloop:
    if (*(int *)(base + i * 4 + 0x4c) == target) {
        *(char *)(base + 0x40) = *(char *)(base + 0x40) - 1;
        if (i < *(signed char *)(base + 0x40)) {
shiftloop:
            j = i * 4;
            i++;
            *(int *)((unsigned int)j + (unsigned int)base + 0x4c) =
                *(int *)(base + i * 4 + 0x4c);
            if (i < *(signed char *)(base + 0x40))
                goto shiftloop;
        }
        return;
    }
    i++;
    if (i < *(signed char *)(base + 0x40))
        goto findloop;
}
