/* eaclib/psx/sndpsxz/sdpacket.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 6/13 PASS
 *   (w20-a8 2026-07-19/20: getirq 76->39, setirq 31->10, purgeframes 85->15, serve 75->60,
 *   platformpacketplaycreate 55->0 PASS, psxpacketstop 42->18; residual = fillspuwithpackets 480,
 *   platformpacketplay 271, plus the above near-misses -- see commit log for per-fn detail)
 *   (w21-a3 2026-07-20: dedicated instruction-trace pass on the two file monsters --
 *   fillspuwithpackets 480->167, platformpacketplay 271->148. Real bugs fixed: vt sign
 *   (char->signed char, lbu tautology), iSNDpsxzerospu called with hardcoded len=0 at both
 *   sites in fillspuwithpackets (real correctness bug -- oracle passes 16 / rem), iSNDdmqueue
 *   called 1-arg where its real sig (sdma.c) is 5-arg (dst_spu,src_ram,len,prio,flag) --
 *   dropped-args, a *hdr*0x17c7>>0x10 pitch-scale shift had a stray (unsigned) cast forcing
 *   srl vs oracle's sra. Levers: materialize `voice`=&sndpd[0xD8+vt] ONCE and access ALL small
 *   (0x00-0x27) fields via FIXED displacement off it instead of re-expanding the
 *   VB/VI/VUH/VH(DAT_xxx,vt) macros fresh at each site (oracle: one shared s2/s4); the
 *   DAT_80147e10[p] macro folds +0x4F8 into the base before the p*4 index -- materialize
 *   base+p*4 first and let +0x4F8 be the LOAD DISPLACEMENT instead (matches iSNDpacketgetirq's
 *   established lever); loop-rotation top-test->do-while; i=0/ch=pp split across a branch's
 *   delay slot vs the guard body. Residual 167+148 = mostly register-coloring/scheduling
 *   floors (a `take` value kept in v0 vs s3 across a large intervening block; a
 *   `(signed char)voice[N]` cast compiling to lbu+sll24+sra24 on its first occurrence but a
 *   plain `lb` on repeats -- context-dependent CSE, not source-shapable in the time available).
 *   Other 5 near-misses in this file untouched this pass (getirq/setirq/purgeframes/serve/
 *   psxpacketstop) -- same DAT_ macro re-expansion pattern likely applies there too.)
 *   (w22-a10 2026-07-20: dedicated structural pass on fillspuwithpackets 167->74 (ours/oracle
 *   INSTRUCTION COUNT NOW MATCHES 308=308 -- residual is 100% coloring/scheduling, 0 missing/
 *   extra ops). Key levers (all NEW beyond the w21-a3 set, each independently verified against
 *   the gate): (1) eliminate ALL persistent `rem`/initial-`take` locals in favor of DIRECT
 *   `*(unsigned short*)(pp+off)` re-reads at every test site -- a `short rem = *(unsigned
 *   short*)p;` forces gcc to fold the load to a SIGN-EXTENDING `lh` (since the value flows into
 *   a signed-short lvalue later read in int context), where the oracle never materializes the
 *   var at all and stays strictly `lhu`. (2) a NAMED temp for a divide-by-constant result
 *   (`int chunkSize = (frameSize*4)/7;` before storing) beat inlining the expression directly
 *   into the store -- single biggest jump this pass (164->142). (3) `volatile` on a re-read
 *   defeats not just VALUE-cse (established w21-a3) but also ADDRESS-cse: `*(volatile
 *   int*)(ch+0x48)` referenced twice in one iteration stops gcc from hoisting `ch+0x48` into its
 *   own register (`addiu v0,base,72`) and reusing it 0-displacement -- oracle re-issues the
 *   `+0x48` as the LOAD's own immediate at each site. Same volatile-on-reread lever also fixed
 *   two do-while back-edge tests that were reusing an already-in-register just-stored value
 *   instead of reloading (the loop-bottom `rem`-equivalent test, and BOTH arms of the
 *   take-vs-rem clamp -- this last one alone was 112->98 and made ours/oracle instruction counts
 *   converge exactly). (4) SEPARATE per-loop walk-pointer locals (`fch`/`lch`/`ech`, not the
 *   one function-wide `ch`) for loops AFTER the `queue_dma:` label -- the oracle picks a FRESH
 *   register (often `a0`) per loop there instead of gcc's natural single-register reuse of one
 *   persistent `ch`/s1 across all ~9 count-loops in the fn; combined with keeping the `ch+0x48`
 *   dereference INLINE (not through a separately-assigned pointer var) to keep +0x48 as a load
 *   displacement rather than folded into the base. (5) the established i=0-in-delay-slot /
 *   ch=pp-inside-guard split (w20-a8) needed re-applying at TWO more sites this function's
 *   later half didn't have it yet (before the blockmove loop, before the final DMA-kick loop) --
 *   worth -20 and -20 diffs respectively, the two single biggest wins after the chunkSize temp.
 *   CONFIRMED FLOORS (tried >=2 source variants, no gate improvement, reverted): the
 *   iSNDpacketget i-loop's a0=p refresh sits in the BACK-BRANCH's delay slot in the oracle vs as
 *   this fn's OWN loop-rotated branch-target in ours -- same total instr count (10 either way),
 *   pure scheduling, `ch+=4` statement-order swaps (`i++;ch+=4;` vs `ch+=4;i++;`) both tested,
 *   neither reproduces it; the `avail = pp[0x14]-pp[0x18]` return-value computation colors into
 *   a0/v1 in ours vs oracle's v0/v1 (an extra `addu v0,a0,zero` move ours needs that oracle
 *   doesn't, since oracle's avail is ALREADY in v0 for the return) -- local-scope decl, a
 *   pp+0x40-first eval order, and an intermediate `lim` var were all tried, 0 effect, likely tied
 *   to how the SHARED magic-constant delay-slot preload (reused by the sibling `frameSize*4/7`
 *   branch) colors; the post-blockmove position-update block's pp+0x32/+0x3c LOAD ORDER (oracle:
 *   0x3e,0x32(load),v0=0x3c(reload),v1+=,store 0x32,v0-=,store 0x3c -- ours loads 0x3c earlier
 *   than 0x32) is a load-scheduling reorder for latency-hiding that source-level statement order
 *   didn't influence; the loop-start-flag loop's do-while-vs-for/break SHAPE (oracle uniquely
 *   emits `beqz exit;nop;j top;nop` here, not a single back-branch) was reproduced structurally
 *   via `for(;;){body;if(!c)break;}` but cost an extra instr net-ZERO elsewhere in the fn, so
 *   reverted to do-while (see inline FLOOR comment at that loop). ~40 diffs remain scattered
 *   across these + a handful of single-instruction reg-swaps (`slti+addu`-vs-`sltiu`,
 *   `lhu a2`-position, `andi a2,s3,65535`-vs-plain-move for an already-clean unsigned-short arg)
 *   that a `(unsigned)`-cast/no-cast and named-temp/inline experiments (each tested) didn't move
 *   -- register-coloring floors per the w21-a3 classification, not source-shapable further in
 *   this pass.) ***
 *   Source obj : nfs4\eaclib\psx\sdpacket.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   13 fns @[0x80103784 .. 0x801046C8].  THE SPU/DMA HARDWARE FLOOR of the EA packet player -- the
 *   platform layer iSNDstream/spktplay call to actually stream ADPCM packets into the PSX SPU voice
 *   buffers via DMA, plus the SPU-IRQ-driven double-buffer service loop.
 *   Ghidra nfs4-f.exe.c (sdpacket) + disasm-v3 L<80103784+> -- disasm AUTHORITATIVE for every dropped arg:
 *     iSNDpsxzerospu(addr,LEN) [Ghidra in_a1]; iSNDpacketpurgeframes(p,byteoff,count) [Ghidra __thiscall];
 *     iSNDfillspuwithpackets(p,chunk) + its local frameSize is iSNDpacketget's 3rd (out) arg [Ghidra
 *     local_30]; iSNDplatformpacketplay is 8-ARG (p,note,volAngle:u16,level:u8,pitch:int,a6:int,fx:u8,
 *     hdr:u16*) [Ghidra dropped a3..a8 -> in_a2/in_a3/in_stack_*]; iSNDplatformpacketoverhead RETURNS a
 *     computed size [Ghidra emptied the delay-slot return]; iSNDpacketget(this,chanIdx,&frameSize) 3-arg.
 *
 *   PACKET-VOICE STATE TABLE @0x801479F0 (0x2c byte / 0xb int stride per voice, indexed [voice]):
 *     int +0x00 (DAT_801479f0) hdr-word0   int +0x04 (DAT_801479f4)   int +0x0c (DAT_801479fc) bytePos<<12
 *     int +0x10 (DAT_80147a00) servedPos   int +0x14 (DAT_80147a04) loopLen<<12
 *     u16 +0x18 (DAT_80147a08) volAngle    u16 +0x1a (DAT_80147a0a) pitch base
 *     b   +0x1c (DAT_80147a0c) playstate   b +0x1e (DAT_80147a0e) route   b +0x1f (DAT_80147a0f) channels
 *     b   +0x20 (DAT_80147a10) link        b +0x21 (DAT_80147a11) linkflag  b +0x22/0x23 (a12/a13) lvl/fx
 *     b   +0x27 (DAT_80147a17) voice-done flag (bit7 set == done)
 *   PER-PLAYER ctx (pp = (&DAT_80147e10)[player], malloc'd in create, int-indexed):
 *     +0x00 spuAddr  +0x04 spuSize  +0x0c bufBytes  +0x14 writePos  +0x18 servePos  +0x1c lastNewPos
 *     +0x20 dmaHandle  +0x2c frameSizeTbl  +0x34..0x46 fill state  +0x42(b) activeNote(-1 idle)
 *     +0x44(u16) blockBytes  +0x46(u16) framesPerBlock  +0x48.. per-channel SPU buffer ptrs
 */

extern int           sndgs[];
extern int           sndpp;                 /* current-player IRQ cursor                 */
extern unsigned char sndpd[];               /* EA sound-driver state base @0x80147918 (unsized array:
                                              * forces the oracle's `lui;addiu &sndpd; lw/sw r,0x4F8(base)`
                                              * base+offset shape for the per-player ctx ptr array, which
                                              * lives INSIDE the sndpd block at +0x4F8, not as its own
                                              * separately-materialized symbol -- see spatkey.c SNDPD_*) */
#define DAT_80147e10 (((int *)sndpd)[0x4F8/4])   /* per-player ctx ptr array @0x80147e10 == sndpd+0x4F8 */
extern int           DAT_80147e2c;          /* SPU control reg base (address) @0x80147e2c */
/* 🔴 BUG FIX + HEADER WISH: DAT_801234e4 was double-defined here AND in snddata.c (real dup-symbol
 * bug) as its own scalar -- but the oracle (iSNDplatformpacketplaycreate: `lui s0,%hi(sndpsxlimits);
 * lw a0,0x10(s0)`) proves it's really `sndpsxlimits[4]`, the 5th int of the sndpsxlimits block
 * (sndpsxlimits @0x801234D4, DAT_801234e4 @0x801234D4+0x10). A standalone 4-byte scalar is
 * `-G4` gp-relative-eligible (`sw v0,0(gp)`); the array-element form forces the oracle's absolute
 * lui/addiu(sndpsxlimits)+displacement addressing. Removed the owning def (kept in snddata.c);
 * slimits.c/snddata.c model sndpsxlimits+the 4 DAT_ words as 5 separate scalars -- unifying them
 * into one real array is out of THIS file's scope (memstd.cpp/sdpacket.c only). */
extern int            sndpsxlimits;         /* base @0x801234D4 (5-int block; +0x10 = DAT_801234e4) */
#define DAT_801234e4 (*(int *)((char *)&sndpsxlimits + 0x10))
#define DAT_80147919 (sndpd[1])              /* setirq re-entry guard byte @0x80147919 == sndpd+1 */

/* packet-voice state table fields (byte base; cast for int/short views).  The table lives INSIDE the
 * sndpd block at +0xD8 (0x801479f0 - 0x80147918 = 0xD8) -- same relationship as DAT_80147e10/DAT_80147919
 * above (oracle materializes ONE `$a3 = &sndpd` and reaches every field via a3+OFFSET displacement, never
 * a separately-materialized %hi/%lo(DAT_...) symbol -- see iSNDpacketgetirq/iSNDpacketsetirq oracle). */
#define DAT_801479f0 (sndpd[0xD8])           /* +0x00 */
#define DAT_801479f4 (sndpd[0xDC])           /* +0x04 */
#define DAT_801479fc (sndpd[0xE4])           /* +0x0c */
#define DAT_80147a00 (sndpd[0xE8])           /* +0x10 */
#define DAT_80147a04 (sndpd[0xEC])           /* +0x14 */
#define DAT_80147a08 (sndpd[0xF0])           /* +0x18 */
#define DAT_80147a0a (sndpd[0xF2])           /* +0x1a */
#define DAT_80147a0c (sndpd[0xF4])           /* +0x1c playstate */
#define DAT_80147a0e (sndpd[0xF6])           /* +0x1e route     */
#define DAT_80147a0f (sndpd[0xF7])           /* +0x1f channels  */
#define DAT_80147a10 (sndpd[0xF8])           /* +0x20 link      */
#define DAT_80147a11 (sndpd[0xF9])           /* +0x21 link flag */
#define DAT_80147a12 (sndpd[0xFA])           /* +0x22 level     */
#define DAT_80147a13 (sndpd[0xFB])           /* +0x23 fx level  */
#define DAT_80147a17 (sndpd[0xFF])           /* +0x27 voice-done flag */

/* host/IRQ hooks (function-pointer globals installed by play/stop).
 * 🔴 HEADER WISH / correctness note: these three are NOT independent globals -- the oracle
 * (iSNDplatformpacketplaycreate: `sw v0,0x724(s2)` with s2=&sndpd) proves they are FIELDS
 * embedded in the sndpd block itself (sndpd+0x720/+0x724/+0x728, same relationship as
 * DAT_80147e10/DAT_80147919/the packet-voice table above), NOT separately-materialized
 * %hi/%lo(DAT_...) symbols. The standalone-global defs below are KEPT (unused by this TU
 * from here on) only because sdma.c/sdriver.c/slib.c/spchevnt.c/spchpick.cpp elsewhere in
 * the tree still declare/reference them as independent externs -- out of THIS file's scope
 * to retarget; a follow-up should migrate all 6 sites to sndpd-relative macros + delete
 * these standalone defs. Function bodies in THIS file use the HOOK_* macros below instead. */
extern void (*snd_voice_done_hook)(void *voice);   /* @0x8014803c */
 void (*snd_voice_done_hook)(void *voice) = 0;  /* def @0x8014803c */
             void  *snd_user_serve_hook = 0;               /* def @0x80148038 */
extern void  *snd_user_serve_hook;                 /* @0x80148038 */
extern void  *gPreLoadTicks;                       /* @0x80148040 (fn-ptr) */
#define HOOK_user_serve  (*(void **)(sndpd + 0x720))          /* @0x80148038, sndpd-relative */
#define HOOK_voice_done  (*(void (**)(void *))(sndpd + 0x724)) /* @0x8014803c, sndpd-relative */
#define HOOK_preload     (*(void **)(sndpd + 0x728))          /* @0x80148040, sndpd-relative */

/* sibling-obj dependencies */
extern int  iSNDpsxmalloc(int size);                       /* sdmemman */
extern void iSNDpsxfree(void *p);                          /* sdmemman */
extern void iSNDpsxdisablespuirq(void);                    /* sdspuirq */
extern void iSNDpsxenablespuirq(void);                     /* sdspuirq */
extern void InterruptCallback(int idx, void (*handler)(void));  /* syslib INTR (real 2-arg sig -- see INTR_DMA.cpp/INTR_VB.c/drv.cpp) */
extern int  iSNDpacketget(int p, int chanIdx, int *frameSizeOut);   /* spktplay */
extern unsigned int iSNDpacketfreeframes(int p, int idx, int bytes);   /* spktplay @0x801033C4, real 3-arg sig
                                                                          * (see spktplay.cpp) -- the oracle call
                                                                          * site sets up a0=p/a1=i/a2=taken. */
extern void iSNDstreamhotroddatachunks(void);              /* sst */
extern int  iSNDdmqueue(int dst_spu, unsigned int src_ram, int len, unsigned char prio, unsigned char flag);  /* sdma
                                                             * -- real 5-arg sig (see sdma.c): the fillspu
                                                             * DMA-kick call was a DROPPED-ARGS bug (1-arg
                                                             * called as if void(spuBuf)); oracle sets up
                                                             * all 5: a0=chBuf, a1=pp->0+chunk<<pp->0x43+
                                                             * pp->8*i, a2=pp->0x44(blockBytes), a3=2,
                                                             * stack=flag(chunk==0&&i==0). */
extern int  iSNDdmcomplete(int dmaHandle);                 /* sdma */
extern void blockmove(int *dst, int *src, unsigned int len);  /* blkmov */
extern int  iSNDplatformpitch(int chan, int pitch);        /* sdriver */
extern void trap(unsigned int code);                       /* compiler div-by-zero break */

/* forward decls (mutually referential within this obj) */
extern void iSNDpacketgetirq(void);
extern void iSNDpacketsetirq(void);
extern void iSNDpacketirqcallback(void);
extern int  iSNDfillspuwithpackets(int p, int chunk);
extern unsigned int iSNDpacketpurgeframes(int p, unsigned int byteoff, int count);
extern void iSNDpsxpacketstop(void *p);
extern void iSNDpsxzerospu(int *addr, int len);

#define VB(base,idx)  ((&(base))[idx])                 /* byte at base+idx        */
#define VI(base,idx)  (*(int *)(&(base) + (idx)))      /* int  at base+idx        */
#define VH(base,idx)  (*(short *)(&(base) + (idx)))    /* short at base+idx       */
#define VUH(base,idx) (*(unsigned short *)(&(base) + (idx)))

/* cop0-Status critical section wrapping the SPU-IRQ re-arm (target-only; host calls through). */
static inline void sdpacket_setirq_cs(void)
{
#if defined(__mips__)
    /* MATCH: transcribed as ONE asm block reproducing the oracle's exact register choice
     * ($at for the mask literal, $8/t0 for the masked result) + its 3 trailing nops (the
     * mtc0-IEc-bit-change hazard window, per the ISA ref: up to 3 insns after a Status-reg
     * mtc0 see the OLD state). A plain `sr & 0xfffffbfe` in C left the mask/and register
     * choice to the allocator (picked v0, no explicit $at) and dropped the nops. */
    unsigned int sr;
    __asm__ volatile(
        "mfc0 %0,$12\n\t"
        "nop\n\t"
        "li $1,-0x402\n\t"
        "and $8,%0,$1\n\t"
        "mtc0 $8,$12\n\t"
        "nop\n\t"
        "nop\n\t"
        "nop"
        : "=r"(sr) : : "$1", "$8");
    iSNDpacketsetirq();
    __asm__ volatile("mtc0 %0,$12" : : "r"(sr));
#else
    iSNDpacketsetirq();
#endif
}

/* iSNDpacketgetirq @0x80103784 : on the SPU end-of-block IRQ, latch the current play byte-position of the
 *   active voice (and its linked partner) into the served-position slot, clamping at loop bounds. */
extern void iSNDpacketgetirq(void)
{
    unsigned char *base = sndpd;                    /* materialize the bare sndpd address ONCE (oracle $a3) */
    unsigned char *slot = base + sndpp * 4;          /* runtime index first, fixed OFFSET as load displacement */
    int pp = *(int *)(slot + 0x4F8);                 /* DAT_80147e10[sndpp] */
    int note = (int)*(signed char *)(pp + 0x42);   /* plain char is UNSIGNED on this build -- lbu vs oracle lb */
    int vt, link;
    if (note < 0)
        return;
    vt = note * 0x2c;
    /* MATCH: materialize `voice = &table[vt]` (base+0xD8+vt) ONCE and access its fields via SMALL
     * fixed displacements (+0xC=DAT_801479fc, +0x10=DAT_80147a00, +0x20=DAT_80147a10 link byte) --
     * oracle computes this ONE address (`a0`) and reuses it for every field ref (`lw v0,0xC(a0)`
     * appears FOUR times). The prior `base+vt+CONST` form recomputed the whole vt*0x2c multiply
     * chain at EVERY occurrence instead of once. */
    {
        unsigned char *tablebase = base + 0xD8;    /* MATCH: fold +0xD8 into base FIRST (oracle:
                                                     * `addiu v1,a3,0xD8` before `addu a0,v0,v1`) --
                                                     * left-to-right `base+0xD8+vt` associativity alone
                                                     * didn't stop gcc from folding +0xD8 into vt's chain
                                                     * instead; a separate statement pins the add order. */
        unsigned char *voice = tablebase + vt;     /* &DAT_801479f0[vt] (table-element base) */
        /* MATCH: the oracle RE-LOADS this field fresh at every occurrence (`lw v0,0xC(a0)` appears
         * FOUR times) rather than caching the value across the branches -- an ordinary (non-volatile)
         * repeated dereference lets gcc's local CSE reuse the FIRST load's register at every later
         * occurrence (address is proven unchanged, no intervening store), one load too few vs oracle.
         * `volatile` forces the re-reads while still sharing the ONE address computation. */
        if ((*(volatile unsigned int *)(voice + 0xC) >> 0xc <= (unsigned)*(unsigned short *)(pp + 0x40)) ||     /* DAT_801479fc[vt] */
            (*(volatile unsigned int *)(voice + 0xC) >> 0xc >=          /* MATCH: voice-side operand FIRST
                                                                          * (oracle loads+shifts voice+0xC
                                                                          * before pp+0xc in this clause) */
             (unsigned)(*(int *)(pp + 0xc) - (unsigned)*(unsigned short *)(pp + 0x40)))) {
            if (*(volatile unsigned int *)(voice + 0xC) >> 0xb < (unsigned)*(int *)(pp + 0xc)) {
                /* DAT_80147a00 is the SAME 0x2c-stride struct's +0x10 field (0xE8-0xD8=0x10) -- index
                 * by vt/link*0x2c (BYTES), NOT *0xb (a stale int-array-index unit mismatch bug: 0xb*4==0x2c
                 * only if scaled by sizeof(int), but VI/raw-pointer here adds bytes directly). */
                *(int *)(voice + 0x10) = *(volatile int *)(voice + 0xC);
                /* FLOOR (confirmed): oracle re-reads the link byte (+0x20) a SECOND time after the
                 * bltz test instead of reusing the tested value -- but marking EITHER occurrence
                 * `volatile` defeats gcc's `sll 24;bltz` sign-test pattern match for the FIRST
                 * (regresses to `srl 7;bnez`, a net loss); accept the single cached read here. */
                if (-1 < (int)((unsigned)voice[0x20] << 0x18)) {                        /* DAT_80147a10[vt] */
                    link = (signed char)voice[0x20];
                    *(int *)(base + link * 0x2c + 0xE8) = *(int *)(voice + 0xC);
                }
            } else {
                *(int *)(voice + 0xC) = 0;
                if (-1 < (int)((unsigned)voice[0x20] << 0x18)) {
                    link = (signed char)voice[0x20];
                    *(int *)(base + link * 0x2c + 0xE4) = 0;
                }
            }
        }
    }
}

/* iSNDpacketsetirq @0x801038BC : advance to the next playing player and arm the SPU IRQ on its next block
 *   boundary (writes the SPU IRQ-address register and re-installs the InterruptCallback). */
extern void iSNDpacketsetirq(void)
{
    int i = 0;
    int pp;
    unsigned char *base;
    iSNDpsxdisablespuirq();
    base = sndpd;                        /* materialize the sndpd address AFTER the call (oracle: post-call $v0/$v1) */
    if (base[1] == 0) {                  /* DAT_80147919 == sndpd+1 */
        /* MATCH: &sndpp materialized ONCE right before the loop (oracle: `lui a0,%hi(sndpp)` here,
         * shared via %lo(sndpp)(a0) displacement addressing across every read/write below) -- a
         * bare `sndpp` global reference at each site instead makes GNU-as re-materialize a fresh
         * full address per access (self-temp read / $at-store), ~2x the instruction count. */
        int *psndpp = &sndpp;
        unsigned char *pbase = base;   /* MATCH: oracle copies the checked base into a SECOND reg
                                         * (`addu a1,v1,zero`) right before the loop -- base is v1
                                         * for the early sndpd[1] check, pbase/a1 for the loop body. */
        do {
            unsigned char *slot;
            *psndpp = *psndpp + 1;
            if (0 < *(volatile int *)psndpp)
                *psndpp = 0;                              /* single player -> wrap to 0 */
            slot = pbase + *(volatile int *)psndpp * 4;     /* runtime index first, fixed OFFSET as displacement */
            pp = *(int *)(slot + 0x4F8);                 /* DAT_80147e10[sndpp] */
            /* MATCH: single merged guard `pp!=0 && note>=0` with a `goto success` to a block placed
             * AFTER the loop (oracle: `beqz v1,.increment; lb; bgez v0,.success` -- the success code
             * sits past the loop's back-edge `j`, reached only by this forward branch). BUG FIX: plain
             * `char` is UNSIGNED on this build (lbu) -- `-1 < (unsigned char)x` is a gcc-provable
             * TAUTOLOGY, so a `(char)` cast here silently deletes the whole note-idle check as dead
             * code. Must be `signed char` (oracle: `lb`/`bgez`), same field iSNDpacketgetirq reads. */
            if (pp != 0 && *(signed char *)(pp + 0x42) >= 0)
                goto success;
            i++;
        } while (i < 2);
        return;
success:
        *(short *)(DAT_80147e2c + 0x1a4) = (short)(*(int *)pp + 8 >> 3);
        InterruptCallback(9, iSNDpacketirqcallback);   /* re-arm: 9 == SPU IRQ index, handler = self */
        iSNDpsxenablespuirq();
    }
}

/* iSNDpacketirqcallback @0x8010399C : the SPU IRQ handler -- latch positions then re-arm. */
extern void iSNDpacketirqcallback(void)
{
    iSNDpacketgetirq();
    iSNDpacketsetirq();
}

/* iSNDpsxzerospu @0x801039C4 : write SPU "silent loop" ADPCM (0x200 flag word + zero data) over `len`
 *   bytes at `addr`.  (Ghidra dropped the length arg as in_a1.) */
extern void iSNDpsxzerospu(int *addr, int len)
{
    int i = 0;
    len = len >> 2;                     /* mutate param in place -- reused as the loop bound (oracle: $a1) */
    if (0 < len) {
        do {
            addr[i] = 0x200;
            addr[i + 1] = 0;
            addr[i + 2] = 0;
            addr[i + 3] = 0;
            i += 4;
        } while (i < len);
    }
}

/* iSNDpacketpurgeframes @0x801039FC : release the packet frames that have finished playing, walking the
 *   ring from byte offset `byteoff` for `count` bytes and calling iSNDpacketfreeframes per channel as each
 *   frame's outstanding-byte counter drains.  Returns whether the cursor stayed within the buffer.
 *   (Ghidra rendered as __thiscall(this,p,arg2): this=player, p=byteoff, arg2=count.) */
extern unsigned int iSNDpacketpurgeframes(int p, unsigned int byteoff, int count)
{
    /* FLOOR (confirmed): tried the bare-base + LOAD-displacement form (`*(int*)(sndpd+p*4+0x4F8)`,
     * matching iSNDpacketgetirq's style) hoping to reproduce the oracle's `lw s5,0x4F8(v0)` -- gcc
     * folds the +0x4F8 into the base pointer's own materialization EITHER way (0 real diff), so this
     * is the SAME address-fold floor already documented for the p=0-constant call sites in this file. */
    int          pp = (&DAT_80147e10)[p];
    int          vt = *(signed char *)(pp + 0x42) * 0x2c;  /* BUG FIX: plain char is UNSIGNED on this
                                                             * build (lbu) -- oracle uses `lb` (signed). */
    unsigned int blk, span, taken, wrapped;
    unsigned short *fcnt;
    int          i;

    do {
        blk = (unsigned)*(unsigned short *)(pp + 0x46);
        span = (byteoff / blk + 1) * blk - byteoff;     /* bytes to next block boundary */
        if (count < (int)span)
            span = count;
        fcnt = (unsigned short *)((byteoff / blk) * 2 + *(int *)(pp + 0x2c));
        taken = span;
        /* MATCH: read `*fcnt` directly at each use (no separately-named `n` local) -- oracle keeps
         * the raw `lhu` value in ONE register across both the compare and the later subtraction with
         * no re-mask; a named `unsigned short n` local re-loaded/re-masked into a SECOND register for
         * the promoted-int compare (gcc-2.8 conservatism), an extra `andi 0xffff` the oracle lacks. */
        if (*fcnt < (int)span)
            taken = *fcnt;
        *fcnt = *fcnt - (unsigned short)taken;
        if (taken != 0 && VB(DAT_80147a0f, vt) != 0) {
            i = 0;
            do {
                iSNDpacketfreeframes(p, i, (int)taken);
                i++;
            } while (i < (int)(unsigned)(unsigned char)VB(DAT_80147a0f, vt));
        }
        byteoff = byteoff + span;
        wrapped = (unsigned)(byteoff < *(unsigned int *)(pp + 0xc));
        /* @0x80103B14-1C: count -= span AND byteoff = 0 happen ONLY in the wrapped==0 (byteoff>=limit)
         * fall-through. The recon decremented count UNCONDITIONALLY, so the purge consumed `count` on
         * every step instead of only on a buffer wrap (M07). */
        if (wrapped == 0) {
            count = count - span;
            byteoff = 0;
        }
    } while (0 < count);
    return wrapped;
}

/* iSNDfillspuwithpackets @0x80103B54 : the core DMA pump -- pull packet frames (iSNDpacketget), block-move
 *   their ADPCM into each channel's SPU buffer, set the ADPCM loop/end flags for `chunk` of the double
 *   buffer, and queue the SPU DMA (iSNDdmqueue).  (Ghidra __thiscall(this,p): this=player, p=chunk; the
 *   uninit local_30 is iSNDpacketget's frameSize out-param.) */
extern int iSNDfillspuwithpackets(int p, int chunk)
{
    /* MATCH: materialize the bare &sndpd ONCE (oracle: a0) and reach BOTH DAT_80147e10[p] (via
     * base+p*4, +0x4F8 as the LOAD DISPLACEMENT -- the `(&DAT_80147e10)[p]` macro instead folds
     * 0x4F8 into the pointer chain before the index, forcing displacement-0) and the voice-table
     * base (a0 += 0xD8, the SAME register reused after the load) off this one pointer. */
    unsigned char *base0 = sndpd;
    unsigned char *slot0 = base0 + p * 4;
    int  pp = *(int *)(slot0 + 0x4F8);
    int  vt = (int)*(signed char *)(pp + 0x42) * 0x2c;   /* BUG FIX: plain char is UNSIGNED on this
                                                           * build (lbu) -- oracle uses `lb` (signed),
                                                           * same field iSNDpacketgetirq/setirq read. */
    /* MATCH: materialize `voice = &table[vt]` (sndpd+0xD8+vt) ONCE at entry (oracle: `s4`, a
     * callee-saved reg computed from the SAME vt multiply chain that feeds it) and read the
     * per-voice CHANNEL COUNT (+0x1F == DAT_80147a0f[vt]) via this ONE fixed displacement at
     * every one of the ~9 loop guards below (oracle: `lbu v0,0x1F(s4)`, reused verbatim). The
     * VB(DAT_80147a0f,vt) macro form instead re-materializes base+0xF7+vt fresh at each site. */
    unsigned char *tablebase0 = base0 + 0xD8;    /* MATCH: fold +0xD8 into base0 FIRST (oracle:
                                                   * `addiu a0,a0,0xD8` right after the pp load,
                                                   * reusing $a0) -- same lever iSNDpacketgetirq
                                                   * uses for its tablebase/voice split. */
    unsigned char *voice = tablebase0 + vt;
    int  i, ch, dma;
    unsigned short take;
    int  *cbuf;
    short *ringp;
    int  frameSize;      /* MATCH: genuinely uninitialized (Ghidra local_30) -- iSNDpacketget always
                           * writes it before any read; a `=0` initializer emits a dead `sw zero,..(sp)`
                           * the oracle lacks. */

    if (*(unsigned short *)(pp + 0x3c) == 0) {   /* MATCH: oracle reads this SPECIFIC occurrence via
                                                   * `lhu` (unsigned); other pp+0x3c reads elsewhere in
                                                   * this fn use `lh`/`lhu` per their own oracle site. */
        *(short *)(pp + 0x3e) = 0;
        *(short *)(pp + 0x3c) = *(short *)(pp + 0x44);
        *(short *)(chunk * 2 + *(int *)(pp + 0x2c)) = 0;
    }
    if (*(int *)(pp + 0x14) == 0) {                     /* fresh start -> silence all SPU channels */
        /* MATCH: oracle materializes `i=0` in the count-check BRANCH'S DELAY SLOT (`beqz
         * count,skip / addu s0,zero,zero`); `ch=pp` is set only on the taken (nonzero) path,
         * inside the guard -- split the two inits instead of setting both before the `if`. */
        i = 0;
        if (voice[0x1F] != 0) {
            ch = pp;
            /* BUG FIX: len=0x10 (16) -- oracle loads `li a1,16` before the loop and re-materializes
             * it in the branch-back delay slot every iter (a1 is caller-saved, clobbered by the
             * jal); the previous recon passed a constant 0, silencing nothing (correctness bug). */
            /* MATCH: oracle increments `ch` in the JAL's OWN delay slot (right after the call),
             * `i` afterward -- swap the statement order from the natural i++/ch+=4. */
            do { iSNDpsxzerospu(*(int **)(ch + 0x48), 16); ch += 4; i++; }
            while (i < (int)(unsigned)(unsigned char)voice[0x1F]);
        }
        *(unsigned short *)(pp + 0x3e) = *(short *)(pp + 0x3e) + 0x10;
        *(unsigned short *)(pp + 0x3c) = *(short *)(pp + 0x3c) - 0x10;
    }
    /* MATCH: oracle tests pp+0x3c!=0 ONCE before the loop (`beqz v0,.queue_dma`) then BOTTOM-tests
     * the back-edge (`bnez v1,.top`) via a FRESH re-read each time -- NO persistent `rem` variable
     * at all (a stored `short rem = *(unsigned short*)...;` forces gcc to pick a SIGN-EXTENDING
     * `lh` for the load, since the value flows into a signed-short-typed lvalue later read in an
     * int context -- oracle keeps it strictly `lhu` by never materializing the intermediate var). */
    if (*(unsigned short *)(pp + 0x3c) != 0) {
        int endFlag = 2;       /* MATCH: oracle materializes `li s6,2` ONCE here, reused at both
                                 * flag-byte stores below instead of two separate `li v,2` literals. */
        do {
            if (*(unsigned short *)(pp + 0x34) == 0) {      /* need a new packet frame -- MATCH:
                                                               * tested directly (no `take=...;
                                                               * if(take==0)` -- see rem note above,
                                                               * plus this lets the clamp below CSE
                                                               * the SAME v0 across both join paths). */
                i = 0;
                if (voice[0x1F] != 0) {
                    ch = pp;
                    do {
                        *(int *)(ch + 0x24) = iSNDpacketget(p, i, &frameSize);
                        ch += 4; i++;
                    } while (i < (int)(unsigned)(unsigned char)voice[0x1F]);
                }
                if (*(int *)(pp + 0x24) == 0) {             /* no frame available -> finish/flush */
                    int avail = *(int *)(pp + 0x14) - *(int *)(pp + 0x18);
                    if ((int)(unsigned)*(unsigned short *)(pp + 0x40) < avail)
                        return avail;
                    if (*(unsigned short *)(pp + 0x38) < *(unsigned short *)(pp + 0x36))
                        goto advance;
                    if (*(unsigned short *)(pp + 0x36) < 2) {     /* mark SPU loop-back */
                        i = 0;
                        if (voice[0x1F] != 0) {
                            ch = pp;
                            do {
                                /* MATCH: read *(int*)(ch+0x48) via LOAD DISPLACEMENT off the bare
                                 * `ch` (oracle: `lw v0,72(s1)`) -- a separate `cbuf` pointer var
                                 * folds the +0x48 into the address before the load (0-displacement). */
                                int chval = *(int *)(ch + 0x48);
                                ch += 4;
                                /* BUG FIX: len=rem (pp+0x3c), not 0 -- oracle loads `lhu a1,0x3C(s2)`
                                 * as the 2nd arg right before this call. */
                                iSNDpsxzerospu((int *)(chval + (unsigned)*(unsigned short *)(pp + 0x3e)),
                                               *(unsigned short *)(pp + 0x3c));
                                i++;
                            } while (i < (int)(unsigned)(unsigned char)voice[0x1F]);
                        }
                    } else {                                      /* mark SPU end (flag byte = 2) */
                        i = 0;
                        if (voice[0x1F] != 0) {
                            int ech = pp;   /* MATCH: a SEPARATE block-scoped walk pointer (oracle
                                              * picks `a0`, not the function-wide `ch`/s1, for this
                                              * loop) -- reusing the persistent `ch` name here forces
                                              * gcc's allocator to keep it in the SAME physical reg
                                              * as every other loop in the fn. */
                            do {
                                *(char *)(*(volatile int *)(ech + 0x48) + 1) = (char)endFlag;
                                i++;
                                *(char *)((unsigned)*(unsigned short *)(pp + 0x44) + *(volatile int *)(ech + 0x48) - 0xf) = (char)endFlag;
                                ech += 4;
                            } while (i < (int)(unsigned)(unsigned char)voice[0x1F]);
                        }
                    }
                    if (*(unsigned short *)(pp + 0x3e) == 0)
                        *(short *)(pp + 0x36) = *(short *)(pp + 0x36) + 1;
                    *(short *)(pp + 0x3c) = 0;
                    goto queue_dma;
                }
                {
                    int chunkSize = (frameSize * 4) / 7;   /* ADPCM bytes per chunk */
                    *(short *)(pp + 0x36) = 0;
                    *(short *)(pp + 0x32) = 0;
                    *(short *)(pp + 0x34) = (short)chunkSize;
                    *(short *)(pp + 0x30) = *(short *)(pp + 0x34);
                }
            }
            /* MATCH: oracle RE-READS from memory on ALL THREE sides of the clamp (`lhu v0,0x34(s2)`
             * for the LHS test AND the true-branch value, `lhu v1,0x3C(s2)` for the RHS/false-branch)
             * -- no `take` variable feeds the compare; both incoming paths to this point (the
             * take==0 branch's LAST store above, and the take!=0 skip's test above) leave
             * pp+0x34's value fresh in the SAME register, so gcc's own CSE across the join point
             * supplies the LHS for free -- an explicit `take` read here would break that reuse. */
            if (*(unsigned short *)(pp + 0x34) < *(unsigned short *)(pp + 0x3c))
                take = *(volatile unsigned short *)(pp + 0x34);
            else
                take = *(volatile unsigned short *)(pp + 0x3c);
            ringp = (short *)(chunk * 2 + *(int *)(pp + 0x2c));
            *ringp = *ringp + (short)((int)((unsigned)take * 7) >> 2);
            i = 0;
            if (voice[0x1F] != 0) {
                ch = pp;
                do {
                    blockmove((int *)(*(int *)(pp + 0x24) + (unsigned)*(unsigned short *)(pp + 0x32) +
                                      (unsigned)*(unsigned short *)(pp + 0x30) * i),
                              (int *)(*(int *)(ch + 0x48) + (unsigned)*(unsigned short *)(pp + 0x3e)),
                              (unsigned)take);
                    i++; ch += 4;
                } while (i < (int)(unsigned)(unsigned char)voice[0x1F]);
            }
            *(unsigned short *)(pp + 0x3e) = *(short *)(pp + 0x3e) + take;
            *(unsigned short *)(pp + 0x32) = *(short *)(pp + 0x32) + take;
            *(unsigned short *)(pp + 0x3c) = *(short *)(pp + 0x3c) - take;
            *(unsigned short *)(pp + 0x34) = *(short *)(pp + 0x34) - take;
        } while (*(volatile unsigned short *)(pp + 0x3c) != 0);
    }
queue_dma:
    if (chunk == 0) {                            /* first chunk -> set SPU loop-start flag (|4) */
        /* MATCH: loop guard is `chunk < channelcount`, not `channelcount != 0` -- chunk is
         * provably 0 here (just tested), and oracle's guard `slt v0,s5,v0` reuses THAT register
         * (chunk==s5) rather than materializing a fresh `!=0`/`beqz` compare against zero. */
        if (chunk < (int)(unsigned char)voice[0x1F]) {
            int fch = pp;   /* MATCH: a SEPARATE walk pointer (oracle: `a0`), not the function-wide
                              * `ch`/s1. */
            i = 0;
            /* FLOOR (confirmed): oracle shapes this ONE loop (uniquely among this fn's ~9
             * count-loops) as a trailing conditional-EXIT + unconditional jump-back
             * (`beqz v0,exit;nop; j top;nop`) instead of a single conditional back-branch --
             * tried the `for(;;){body;if(!c)break;}` loop-rotation form (matches the SHAPE) but
             * it costs an extra instruction elsewhere in the fn net-negative vs the do-while;
             * reverted, keeping the do-while (0 net diff difference either way here). */
            do {
                /* MATCH: read *(int*)(fch+0x48) via LOAD DISPLACEMENT off the bare `fch` (oracle:
                 * `lw v0,72(a0)`) -- a separately-assigned `cbuf` pointer var forces gcc to
                 * materialize the +0x48 addend into its OWN register (`addiu v0,a0,72`) before the
                 * 0-displacement load; an inline dereference keeps the offset as the load's
                 * immediate instead (same lever as the earlier `chval`/`ech` sites in this fn).
                 * MATCH: oracle fills the flag-byte load's OWN delay slot with `fch+=4` (`lbu
                 * v1,1(v0); addiu a0,a0,4; ori v1,v1,4`) -- split the read-modify-write so the
                 * increment sits BETWEEN the load and the or/store, not after the whole stmt. */
                {
                    unsigned char *fb = (unsigned char *)(*(int *)(fch + 0x48) + 1);
                    unsigned char fv = *fb;
                    fch += 4;
                    *fb = fv | 4;
                }
                i++;
            } while (i < (int)(unsigned)(unsigned char)voice[0x1F]);
        }
    } else if (chunk == *(unsigned short *)(pp + 0x38) - 1) {   /* last chunk -> loop-end (|1) */
        /* MATCH: `i=0` in the count-check branch's delay slot; `ch=pp` only on the taken path,
         * via a SEPARATE walk pointer (oracle: `a0`) -- same levers as the loop-start-flag loop
         * above and the earlier zerospu warm-up loop. */
        i = 0;
        if (voice[0x1F] != 0) {
            int lch = pp;
            do {
                int e = (unsigned)*(unsigned short *)(pp + 0x44) + *(int *)(lch + 0x48);
                *(unsigned char *)(e - 0xf) |= 1;
                i++; lch += 4;
            } while (i < (int)(unsigned)(unsigned char)voice[0x1F]);
        }
    }
    i = 0;                                   /* kick the SPU DMA for each channel */
    if (voice[0x1F] != 0) {
        ch = pp;
        do {
            /* MATCH: oracle evaluates pp->0x08*i (mult/mflo) BEFORE the shift/add chain, and the
             * per-first-channel flag as an unconditional a0=0 overwritten to (i<1) only when
             * chunk==0 (the bnez-delay-slot idiom -- both paths always compute src the same). */
            int  stride = *(int *)(pp + 0x8) * i;
            unsigned int src = (unsigned int)*(int *)(pp + 0x0) +
                                (unsigned int)(chunk << *(unsigned char *)(pp + 0x43)) +
                                (unsigned int)stride;
            unsigned char flag = (chunk == 0 && i < 1) ? 1 : 0;
            dma = iSNDdmqueue(*(int *)(ch + 0x48), src, *(unsigned short *)(pp + 0x44), 2, flag);
            *(int *)(pp + 0x20) = dma;
            i++; ch += 4;
        } while (i < (int)(unsigned)(unsigned char)voice[0x1F]);
    }
advance:
    *(short *)(pp + 0x3a) = (short)chunk;
    *(int *)(pp + 0x14) = *(int *)(pp + 0x14) + (unsigned)*(unsigned short *)(pp + 0x46);
    return *(int *)(pp + 0x14);
}

/* iSNDpacketserve @0x80104024 : per-tick service -- pull fresh stream chunks, advance each player's served
 *   position from the SPU play-cursor, purge finished frames, and top up the SPU double buffer. */
extern void iSNDpacketserve(void)
{
    int p;
    iSNDstreamhotroddatachunks();
    for (p = 0; p < 1; p++) {
        /* NOTE: tried index-first `sndpd+p*4+0x4F8` to match the oracle's `sll;addu;lw,1272`
         * shape (vs the macro's pre-combined-base form) -- gcc constant-propagates p=0 (just
         * set by the loop init) through EITHER form identically, so it made no difference;
         * reverted to the macro for clarity. Accept as a floor (single-iteration-loop CSE). */
        int pp = (&DAT_80147e10)[p];
        if (pp != 0 && *(signed char *)(pp + 0x42) >= 0) {
            int servePos = *(int *)(pp + 0x1c);
            /* MATCH: 0x1c000 == 4096*0x1c (28) -- mathematically `x/0x1c000` == `(x>>0xc)/0x1c` for the
             * non-negative values here, but the ORACLE keeps the >>0xc as an EXPLICIT separate step
             * (`srl s1,v0,12` then a real `/0x1c` with its OWN shift-4 magic-mult) instead of letting gcc
             * fold the /4096 into one combined post-mult shift (`sra v0,v0,0x10` -- what a single `/0x1c000`
             * emits). Empirically verified (isolated probe): the divisor after removing the power-of-2
             * factor is 28 (magic 0x92492493, shift 4), NOT 7 (same magic constant, but shift 2) -- the
             * `(unsigned)` cast on the shift is required to get `srl` (else `sra`, wrong opcode). */
            int newPos = ((int)((unsigned)*(int *)(&DAT_801479fc + *(signed char *)(pp + 0x42) * 0x2c) >> 0xc) / 0x1c) * 0x1c;
            unsigned int adv = (newPos < servePos) ? (unsigned)((newPos + *(int *)(pp + 0xc)) - servePos)
                                                   : (unsigned)(newPos - servePos);
            if (0x70ffffff < *(int *)(pp + 0x18)) {     /* keep the 64-bit-ish byte counters from overflowing */
                *(int *)(pp + 0x18) -= 0x70000000;
                *(int *)(pp + 0x14) -= 0x70000000;
            }
            *(int *)(pp + 0x18) += adv;
            iSNDpacketpurgeframes(p, (unsigned)servePos, (int)adv);
            /* @0x80104148-415C: *(pp+0x1c)=newPos (served-position advance) is stored ONLY when the
             * buffer-level check passes (bufLevel < threshold), BEFORE the iSNDdmcomplete refill gate.
             * The recon stored newPos UNCONDITIONALLY (before the check), advancing the served pos even
             * when the buffer was full enough that no refill was due (M08). */
            if (*(int *)(pp + 0x14) - *(int *)(pp + 0x18) < *(int *)(pp + 0x10)) {
                *(int *)(pp + 0x1c) = newPos;
                if (iSNDdmcomplete(*(int *)(pp + 0x20)) != 0) {
                    unsigned int idx = (unsigned)*(unsigned short *)(pp + 0x3a) + 1;
                    if (*(unsigned short *)(pp + 0x38) <= idx)
                        idx -= *(unsigned short *)(pp + 0x38);
                    iSNDfillspuwithpackets(p, (int)idx);
                }
            }
        }
    }
}

/* iSNDplatformpacketoverhead @0x801041B8 : per-player SPU-context byte overhead (the malloc'd voice ctx
 *   sized from DAT_801234e4, /4096 rounded up to 4, *2, + 0x1050).  (Ghidra emptied the delay-slot return.) */
extern int iSNDplatformpacketoverhead(void)
{
    int v = DAT_801234e4;
    if (v < 0)
        v += 0xfff;
    v >>= 0xc;
    return ((v + 3) & ~3) * 2 + 0x1050;
}

/* iSNDplatformcalcdatarate @0x801041EC : bytes/second for a sample of rate `sample_rate[0]` and channel
 *   count `sample_rate[1]`, scaled by 0x92/256 (ADPCM ratio). */
extern int iSNDplatformcalcdatarate(unsigned short *sample_rate)
{
    return (int)((unsigned)*sample_rate * (unsigned)(unsigned char)sample_rate[1] * 0x92) >> 8;
}

/* iSNDplatformpacketplaycreate @0x8010421C : allocate a player's SPU context, install the voice-done hook,
 *   register the ctx in DAT_80147e10[p].  Returns 0 / -9 on malloc failure. */
extern int iSNDplatformpacketplaycreate(int p, int *mem)
{
    /* MATCH: materialize the BARE &sndpd once and keep it live ACROSS the malloc call (oracle: `s2`,
     * a callee-saved reg) -- both the HOOK_voice_done store (before the call) and the
     * DAT_80147e10[p]=mem store (after) are sndpd-relative; the HOOK_/DAT_ macros each independently
     * fold their OWN offset into a freshly-materialized address instead of sharing one base. */
    unsigned char *base = sndpd;
    int *limitsBase = &sndpsxlimits;   /* MATCH: same lever for DAT_801234e4 -- oracle materializes
                                         * &sndpsxlimits ONCE (its own callee-saved reg, ALSO kept
                                         * live across the call) and reads +0x10 by displacement
                                         * TWICE; the macro form re-materialized the full address
                                         * from scratch at each of its two uses. */
    *(void (**)(void *))(base + 0x724) = (void (*)(void *))iSNDpsxpacketstop;   /* HOOK_voice_done */
    *(signed char *)((int)mem + 0x42) = -1;   /* MATCH: li v0,-1 vs li v0,255 (unsigned-char lvalue folds to +255) */
    mem[0xb] = (int)(mem + 0x414);
    mem[0] = iSNDpsxmalloc(limitsBase[4]);   /* DAT_801234e4 == sndpsxlimits[4] (+0x10/4) */
    mem[1] = limitsBase[4];
    if (mem[0] == 0)
        return -9;
    *(int *)(base + p * 4 + 0x4F8) = (int)mem;   /* DAT_80147e10[p] = mem */
    return 0;
}

/* iSNDplatformpacketplaydestroy @0x801042C0 : free a player's SPU context and clear its slot.
 * (true return is void -- spktplay.cpp/eaclib.h already declare `void`; $v0 after the tail-call
 * to iSNDpsxfree is incidental/unused, per §3.2.) */
extern void iSNDplatformpacketplaydestroy(int p)
{
    unsigned char *sndpdbase = sndpd;              /* force the sndpd address materialization first */
    unsigned char *base = sndpdbase + p * 4;       /* base = sndpd + p*4 (runtime index) */
    int *pp = *(int **)(base + 0x4F8);             /* deref at base+0x4F8 (fixed field OFFSET, not folded) */
    iSNDpsxfree((void *)*pp);                      /* pp dies here -- caller-saved, no s-reg needed */
    *(int *)(base + 0x4F8) = 0;
}

/* iSNDplatformpacketplay @0x80104304 : start a voice playing a packet stream -- program the voice state
 *   table, derive the SPU block geometry from the player ctx, prime two buffers via iSNDfillspuwithpackets,
 *   install the serve + IRQ hooks, set initial pitch, and key the voice.  8-arg (Ghidra dropped a3..a8). */
extern int iSNDplatformpacketplay(int p, int note, unsigned short volAngle, unsigned char level,
                                      int pitch, int a6, unsigned char fxlevel, unsigned short *hdr)
{
    /* MATCH: same base-sharing lever as iSNDfillspuwithpackets/iSNDpacketgetirq -- ONE bare &sndpd
     * (oracle: v1) feeds BOTH the DAT_80147e10[p] load (base+p*4, +0x4F8 as the LOAD DISPLACEMENT,
     * not folded into the pointer) and, after +=0xD8, the `voice` table pointer (+vt). */
    unsigned char *base = sndpd;
    unsigned char *slot = base + p * 4;
    int *pp = *(int **)(slot + 0x4F8);
    int  vt = note * 0x2c;
    unsigned char *tablebase = base + 0xD8;
    unsigned char *voice = tablebase + vt;      /* &DAT_801479f0[vt] -- ALL small (0x00-0x27) field
                                                  * accesses below go through this ONE fixed-displacement
                                                  * pointer (oracle: `s2`), not the VB/VI(DAT_xxx,vt)
                                                  * macro (each of which re-derives base+OFFSET+vt fresh
                                                  * from its OWN symbol, defeating the CSE the oracle
                                                  * achieves by materializing ONE base). */
    unsigned int chunkBytes, frames, perCh;
    /* NOTE (tried, reverted): oracle's frames/perCh divide emits the FULL signed div-guard
     * (li at,-1;bne;lui 0x8000;bne;break 6), not a plain `divu` (zero-check only) -- changing
     * frames/perCh to signed `int` DOES reproduce that guard's shape at its own site, but ripples
     * register allocation earlier in the fn (the `ch`/blockSamps block) and nets MORE total diffs
     * (128->134). Left unsigned; the correct fix likely needs the `ch`/blockSamps block's own
     * near-miss resolved FIRST so the later ripple doesn't cost more than it gains. */
    int  blockSamps;
    int  i;
    (void)a6;

    voice[0x21] = 0;                              /* DAT_80147a11 = linkflag */
    *(signed char *)(voice + 0x20) = -1;          /* DAT_80147a10 = link (-1 idle) -- MATCH: `li
                                                    * v0,-1` (oracle) vs `li v0,255` -- assigning
                                                    * -1 through an UNSIGNED lvalue (`voice[N]`,
                                                    * `unsigned char*`) still constant-folds to 255
                                                    * at compile time (gcc evaluates the conversion
                                                    * before codegen, same either way for `-1` or
                                                    * `0xff`); a SIGNED-char pointer cast is required
                                                    * to keep the fold negative -- same lever as
                                                    * iSNDplatformpacketplaycreate's `*(signed
                                                    * char*)(mem+0x42) = -1`. */
    voice[0x1e] = 0;                              /* DAT_80147a0e = route */
    *(volatile unsigned char *)(voice + 0x1f) = (unsigned char)hdr[1]; /* DAT_80147a0f = channel
                                                    * count -- volatile keeps this store pinned
                                                    * right after its own load, ahead of the OTHER
                                                    * (also-volatile) field stores below. */
    *(volatile int *)(voice + 0x04) = 0;          /* DAT_801479f4 -- MATCH: this whole field-store
                                                    * run must complete BEFORE the chunkBytes
                                                    * division below (oracle keeps them in program
                                                    * order); plain (non-volatile) stores through an
                                                    * unaliased pointer let gcc's scheduler hoist the
                                                    * independent division block ahead of them. */
    *(volatile unsigned short *)(voice + 0x18) = volAngle; /* DAT_80147a08 */
    *(volatile unsigned char *)(voice + 0x22) = level;      /* DAT_80147a12 */
    *(volatile unsigned char *)(voice + 0x23) = fxlevel;    /* DAT_80147a13 */
    *(volatile int *)(voice + 0x00) = pp[0];       /* DAT_801479f0 */
    *(volatile unsigned char *)(voice + 0x27) = (unsigned char)p; /* DAT_80147a17 */

    chunkBytes = 0x1000 / (unsigned char)*(volatile unsigned char *)(voice + 0x1f);
    *(short *)(pp + 0x11) = (short)chunkBytes;
    *(short *)((int)pp + 0x46) = (short)((int)(chunkBytes * 0x1c) >> 4);
    {
        unsigned char ch = (unsigned char)voice[0x1f];
        pp[0x12] = (int)(pp + 0x14);
        *(char *)((int)pp + 0x43) = (char)(0xd - ch);
        pp[0x13] = (int)pp + *(unsigned short *)(pp + 0x11) + 0x50;
        blockSamps = (int)pp[1] >> (0xd - ch);
    }
    *(short *)(pp + 0xe) = (short)blockSamps;
    frames = (unsigned)(blockSamps & 0xffff);
    perCh = (unsigned char)voice[0x1f];
    *(short *)(pp + 0xe) = (short)(frames / perCh);
    {
        int total = (int)(frames / perCh) * *(unsigned short *)((int)pp + 0x46);
        *(short *)(pp + 0x10) = *(short *)((int)pp + 0x46);
        *(char *)((int)pp + 0x42) = (char)note;
        *(short *)((int)pp + 0x36) = 0;
        *(short *)(pp + 0xc) = 0;
        *(short *)(pp + 0xd) = 0;
        *(short *)((int)pp + 0x32) = 0;
        *(short *)(pp + 0xf) = 0;
        pp[9] = 0; pp[8] = 0; pp[7] = 0; pp[6] = 0; pp[5] = 0;
        pp[2] = (unsigned)*(unsigned short *)(pp + 0xe) << (*(unsigned char *)((int)pp + 0x43));
        pp[3] = total;
        pp[4] = total - (unsigned)*(unsigned short *)((int)pp + 0x46);
    }
    i = 0;
    do {
        while (iSNDdmcomplete(pp[8]) == 0) { }
        iSNDfillspuwithpackets(p, i);
        i++;
    } while (i < 2);

    {
        /* MATCH: oracle re-materializes a FRESH bare &sndpd here (a0), shared between the HOOK_
         * stores and the linked-partner writes below -- both anchor off it with large absolute-style
         * displacements (0x720/0x728/0xE4/0xE8/0xEC/0xF9), unlike the small-offset `voice` accesses
         * above. Using the HOOK_/DAT_ macros here would each re-derive their own address. */
        unsigned char *base2 = sndpd;
        *(void **)(base2 + 0x720) = (void *)iSNDpacketserve;    /* HOOK_user_serve */
        *(void **)(base2 + 0x728) = (void *)iSNDpacketsetirq;   /* HOOK_preload */
        *(int *)(voice + 0xc) = 0;    /* DAT_801479fc, vt */
        *(int *)(voice + 0x10) = 0;   /* DAT_80147a00, vt -- was note*0xb, stride-scaling bug (see
                                        * iSNDpacketgetirq); this is the SAME 0x2c-stride struct's
                                        * +0x10 field, indexed in BYTES not sizeof(int) units */
        *(int *)(voice + 0x14) = pp[3] << 0xc;    /* DAT_80147a04, vt */
        /* MATCH: no `(unsigned)` cast -- the oracle's final scale is a SIGNED `sra` (the magic-mult
         * chain for *0x17c7 stays in a signed int; forcing unsigned emits `srl` instead). */
        *(short *)(voice + 0x1a) = (short)(*hdr * 0x17c7 >> 0x10);   /* DAT_80147a0a, vt */
        if (1 < (unsigned char)voice[0x1f]) {       /* arm the linked partner voice */
            voice[0x20] = *(unsigned char *)(note * 100 + sndgs[0x25] + 4);
            base2[0xf9 + (signed char)voice[0x20] * 0x2c] = 1;                          /* DAT_80147a11 */
            *(int *)(base2 + 0xe4 + (signed char)voice[0x20] * 0x2c) = 0;               /* DAT_801479fc */
            *(int *)(base2 + 0xe8 + (signed char)voice[0x20] * 0x2c) = 0;               /* DAT_80147a00 */
            *(int *)(base2 + 0xec + (signed char)voice[0x20] * 0x2c) = *(int *)(voice + 0x14);  /* DAT_80147a04 */
        }
    }
    iSNDplatformpitch(note, pitch);
    sdpacket_setirq_cs();
    voice[0x1c] = 1;                             /* DAT_80147a0c = playstate = playing */
    return 0;
}

/* iSNDpsxpacketstop @0x801046C8 : tear down a finished voice -- mark its player + voice slot idle, and if no
 *   voices remain active, drop the serve hook and point the pre-load tick back at the bare IRQ re-arm. */
extern void iSNDpsxpacketstop(void *parg)
{
    unsigned char *p = (unsigned char *)parg;   /* MATCH: real sig is void(void*) -- eaclib.h/HOOK_voice_done;
                                                  * the oracle NEVER sets up $v0 at any epilogue (§3.2 void). Our
                                                  * previous `int p ... return pp;` forced pp into a CALLEE-SAVED
                                                  * reg to survive the trailing sdpacket_setirq_cs() call -> an
                                                  * extra $s1 save/restore + 8-byte-bigger frame the oracle lacks. */
    unsigned char *base = sndpd;
    /* MATCH: the oracle reads the note byte UNSIGNED (`lbu`) then sign-extends+scales-by-4 with the
     * `sll 24 / sra 22` idiom (net +2 shift, arithmetic) in ONE fused expression -- our previous
     * "cast to (signed char) THEN index a DAT_ array" form let gcc collapse this to a direct signed
     * `lb` + separate `sll 2`, which is semantically identical but a different instruction sequence. */
    int vt4 = (int)((int)(*(unsigned char *)(p + 0x27)) << 24) >> 22;
    int pp = *(int *)(base + vt4 + 0x4F8);
    int i, active = 0;
    *(signed char *)(pp + 0x42) = -1;
    *(signed char *)(p + 0x27)  = -1;
    if (((unsigned char *)sndgs)[0x11] != 0) {           /* sndgs[4]._1_1_ = channel count */
        /* MATCH: POINTER WALK (oracle: v1=base+0xFF, `addiu v1,v1,0x2C` in the loop-back branch's
         * delay slot every iter) not an index-multiply `i*0x2c` -- §3.12 #1 array-index-vs-pointer-
         * walk flip. */
        unsigned char *q;
        int count = (int)(unsigned)((unsigned char *)sndgs)[0x11];
        /* MATCH: q walks from `base` (not base+0xFF) and reads the byte at the FIXED +0xFF
         * displacement each iter (oracle: `lbu v0,0xFF(v1)` -- offset stays in the load, base
         * is bare); and the sign test is the raw `(byte<<24)>=0` shift-idiom (oracle: unsigned
         * `lbu` + `sll 24` + `bltz`), not a `(signed char)` cast (that folds to a direct `lb`). */
        for (i = 0, q = base; i < count; i++, q += 0x2c)
            if ((int)(q[0xFF]) << 24 >= 0)   /* bit7 clear == still active */
                active++;
    }
    if (active == 0) {
        HOOK_user_serve = 0;
        HOOK_preload = (void *)iSNDpacketsetirq;
    }
    sdpacket_setirq_cs();
}
