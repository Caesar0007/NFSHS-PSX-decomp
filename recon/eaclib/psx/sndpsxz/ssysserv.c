/* eaclib/psx/sndpsxz/ssysserv.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 3/3 ***
 *   Source obj : nfs4\eaclib\psx\ssysserv.obj ; archive C:\nfs4\EACLIB\PSX\SNDPSXZ.LIB (xlsx col11)
 *   3 fns @[0x8010479C .. 0x80104878].  The (per-frame) "service-client" list -- callbacks the game
 *   registers to run on each SNDSYS_service tick.  Ghidra nfs4-f.exe.c (ssysserv) + IDA sigs.
 *
 *   Client list lives at sndgs[0x19..] (int fn-ptrs); the count is sndgs[0x10]._1_1_ = ((char*)sndgs)[0x41].
 */

extern int sndgs[];

extern short *iSNDserveraddclient(int cb);       /* @0x8010479C */
extern void   iSNDserverremoveclient(int cb);    /* @0x801047CC */
extern void   SNDSYS_service(void);              /* @0x80104878 */

#define NCLIENT (((char *)sndgs)[0x41])   /* sndgs[0x10]._1_1_ : service-client count */

/* iSNDserveraddclient @0x8010479C : append callback `cb` to the service-client list; returns sndgs.
 *   The count is read SIGNED (lb) for the array index but UNSIGNED (lbu) for the increment-store. */
extern short *iSNDserveraddclient(int cb)
{
    /* MATCH: index sndgs by the raw client count ONLY (base = sndgs + count*4) and fold the 0x19-slot
     * (0x64-byte) client-array offset into the store DISPLACEMENT via a single explicit char* base --
     * oracle emits sll(count*4); addu base; sw a0,0x64(base). (Same lever as the sibling
     * iSNDserveradd100hzclient in sserver.cpp: sndgs[count+0x19] adds 0x19 to the INDEX before the *4
     * scale, and a second independent `sndgs`-typed expression makes gcc rematerialize the base twice;
     * routing EVERYTHING through one already-materialized char* base fixes both.) */
    char *base = (char *)sndgs;
    *(int *)(base + (signed char)NCLIENT * 4 + 0x64) = cb;
    NCLIENT = NCLIENT + 1;
    return (short *)sndgs;
}

/* iSNDserverremoveclient @0x801047CC : unregister `cb`, compacting the list.  void -- $v0 at every
 *   exit is incidental (numclients / slt scratch / i<<2), matching the eaclib.h `void` prototype. */
extern void iSNDserverremoveclient(int cb)
{
    int i;
    int j;
    char *base;
    char *p;
    p = (char *)sndgs;
    /* MATCH: goto-formed loops (no gcc LOOP notes -> NO strength reduction; the oracle recomputes
     * `sll i,2` EVERY iteration instead of walking a +4 offset giv); ONE char* base for every
     * access (same lever as iSNDserveraddclient above) so +0x64/+0x41 fold into DISPLACEMENTS off
     * a held base reg; the compaction saves the SCALED old offset before the increment
     * (`j = i*4; i++; [j+0x64] = [i*4+0x64]`) so BOTH sides use displacement 0x64 and the sll
     * lands in the entry/back-edge delay slots (an `[i]=[i+1]; i++` form emits 100/104 instead).
     *
     * NEAR-MISS residual (41 diffs, ours 42 / oracle 43): a pure 3-reg caller-saved ROTATION
     * {i,base,cb} = ours {a1,a2,a0} vs oracle {a0,a1,a2} -- the oracle's allocation evicts the
     * param from $a0 (entry copy `addu a2,a0,zero`, our 1 missing insn) and i takes $a0.
     * Structure/count otherwise exact.  Tried + inert (all stayed 41): all 24 decl orders,
     * `register` kw, explicit param-copy local (coalesced away), block-scope j, Yoda compare,
     * i=0 before/after guard/p-init, decl-init i, guard `<1`, base-then-i order, unsigned char*
     * bases, void* param.  Class: gcc-2.8.0 global-alloc assignment tie-break (methodology
     * SS3.15); next step = permuter multi-basin (C lane). */
    if (*(signed char *)(p + 0x41) <= 0)                      /* lb count (signed-char view of the byte) */
        return;
    i = 0;
    base = p;
findloop:
    if (*(int *)(base + i * 4 + 0x64) == cb) {                /* client slots @+0x64 */
        *(char *)(base + 0x41) = *(char *)(base + 0x41) - 1;  /* lbu/addiu/sb (plain char is unsigned) */
        if (i < *(signed char *)(base + 0x41)) {
shiftloop:                                                    /* compact the tail down one slot */
            j = i * 4;                                        /* scale BEFORE the increment (sll in the entry/back-edge delay slot) */
            i++;
            *(int *)(base + j + 0x64) = *(int *)(base + i * 4 + 0x64);
            if (i < *(signed char *)(base + 0x41))
                goto shiftloop;
        }
        return;
    }
    i++;
    if (i < *(signed char *)(base + 0x41))
        goto findloop;
}

/* SNDSYS_service @0x80104878 : run every registered service-client callback (called once per game frame).
 *   MATCH: oracle reads the count as SIGNED (`lb`, not the macro's unsigned `lbu`) and branches `blez`
 *   (signed <=0), matching the signed-char convention iSNDserverremoveclient already uses for this same
 *   byte. Walking pointer `p` starts at `base` (raw sndgs, not sndgs+0x19) and steps +4 bytes/iter with
 *   the client-array's +0x64 folded into the load DISPLACEMENT (not a separately materialized `cb`
 *   pointer var -- computing the fn-ptr via one deref expression lets the +0x64 fuse into `lw`).
 *   NEAR-MISS residual (9 diffs, ours 27/oracle 28): `base` materializes into a caller-saved temp (v1)
 *   for the initial `lb`/`blez` test and is copied into its callee-saved home (s2) only after the branch
 *   is taken; our compile promotes it to s2 one instruction earlier. Coloring floor (§A lazy-promotion
 *   tie-break), not source-shapable via decl/assignment-order tried so far. */
extern void SNDSYS_service(void)
{
    char *base;
    char *p;
    int   i;
    base = (char *)sndgs;
    if (0 < *(signed char *)(base + 0x41)) {
        p = base;
        i = 0;
        do {
            void (*cb)(void) = *(void (**)(void))(p + 0x64);
            p = p + 4;
            (*cb)();
            i++;
        } while (i < *(signed char *)(base + 0x41));
    }
}
