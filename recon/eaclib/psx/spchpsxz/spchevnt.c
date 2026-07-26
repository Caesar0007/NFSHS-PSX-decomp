/* eaclib/psx/spchpsxz/spchevnt.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 13/16 PASS ***
 *   Indexed queue walks now match SPCH_ClearEventQueue exactly and cut iSPCH_InitEventQueue from 42 to
 *   17 diffs; reconstructing gReparm as one-word callback storage made SPCH_ChooseSpeech PASS.
 *   Remaining FAILs are iSPCH_InitEventQueue(17), SPCH_AddEvent(18), and iSPCH_ChooseEvent(58).
 *   Source obj : nfs4\eaclib\psx\spchevnt.obj ; archive C:\nfs4\EACLIB\PSX\SPCHPSXZ.LIB (xlsx col12 / SYM v3)
 *   16 fns @[0x800E6E88 .. 0x800E7684].  The speech EVENT QUEUE -- 16 slots (gVoxEvents, base 0x80148060,
 *   stride 0x3c) selected by priority/age/subtick; events are looked up in the bound gEventDats[] blobs.
 *   Ghidra nfs4-f.exe.c (spchevnt) + disasm-v3 (authoritative) + IDA sigs.
 *
 *   Slot layout (0x3c) @ &gVoxEvents + i*0x3c:  +0x8 enabled(short) +0xa subTick(short) +0xc insertTick(int)
 *     +0x10 voxEvent(int ptr) +0x14 eventArgs[12](int).  gVoxEvents itself = the live-count (slot[0] +0).
 *   VoxEvent fields: +2 maxAge(u16) +4 priority(u16) +9 acceptProb/'d'(char) +0xa flags.
 *
 *   Ghidra-isms resolved (from updated disasm-v3): iSPCH_ChooseEvent returns the winner slot in $s4 which
 *   Ghidra DROPPED; GetFilterLength/Priority were EMPTIED; FindEventSlot/AddEvent drop the gettick() capture
 *   (iVar=gettick, not =0/=slotIdx); ChooseSpeech's `winnerSlot=&DAT_80150000` is really =iSPCH_ChooseEvent().
 *   VoxEvent_GetFilterLengthFlag / iSPCH_GetOffset16 are per-TU `static` copies (canon in spchdata.obj).
 */

extern int            gVoxEvents[];      /* @0x80148060 : live event count + base of the 16-slot queue */
extern int            DAT_80148064;   /* @0x80148064 : "kept a 'd' event" flag */
extern int            gLastTick[];    /* last insert tick (array decl -> explicit lui+%lo) */
extern unsigned short gLastSubTick[]; /* sub-tick counter for same-tick inserts */
extern int            gPreLoadTicks;  /* speech pre-load tick offset */
extern int            gFilterSetting[]; /* active filter mode (1 = length/priority filter on) */
extern int            gEventDats[];   /* @0x80148048 : int[4] bound event-data blobs (spchrand-owned) */

extern int  gettick(void);                                  /* eaclib timer.obj */
extern int  iSPCH_Rand(int n);                              /* spchrand */
extern int  iSPCH_OneChosen(void);                          /* spchpick */
extern void iSPCH_PlayChosen(void);                         /* spchpick */
extern int  iSPCH_ChooseSentence(unsigned int *eventArgs);  /* spchpick (returns chosen-count) */

/* gReparm @0x801370A0 : optional "re-parameterize" hook -- if set, retried per index until a sentence
 *   is chosen or the hook returns <=0.  Signature from SPCH_ChooseSpeech's jalr call site. */
extern int gReparm[];  /* one-word callback storage; cast to its callable signature at use */

/* ---- per-TU static copies of shared helpers (canon in spchdata.obj) ---- */
static int VoxEvent_GetFilterLengthFlag(int e)   /* @0x800E6E88 */
{
    return (int)*(unsigned char *)(e + 0xa) & 1;
}
static int iSPCH_GetOffset16(int base, int tableBase, int index)  /* @0x800E6EA8 */
{
    return base + ((int)*(unsigned short *)(tableBase + index * 2) << 2);
}
static inline int *iSPCH_EventBase(int *base)
{
    /* Identity keeps the winner lookup's base materialization ahead of its index arithmetic. */
    return base;
}

extern unsigned int VoxEvent_GetKeepTillExpiresFlag(int e);            /* @0x800E6E94 */
extern int  iSPCH_SearchEventDat(int dat, unsigned int eventID);      /* @0x800E6EC4 */
extern int  iSPCH_FindEvent(unsigned int eventID);                    /* @0x800E6F4C */
extern void iSPCH_InitEventDat(void);                                 /* @0x800E6FBC */
extern int  GetFilterLength(void);                                    /* @0x800E6FE4 */
extern int  GetFilterPriority(void);                                  /* @0x800E6FFC */
extern void iSPCH_InitEventQueue(void);                               /* @0x800E7014 */
extern int  iSPCH_FindEventSlot(unsigned int priority);              /* @0x800E7088 */
extern int  SPCH_AddEvent(unsigned int *table);                      /* @0x800E71B8 */
extern int  iSPCH_ChooseEvent(void);                                 /* @0x800E7300 */
extern void SPCH_ClearEventQueue(void);                              /* @0x800E74E0 */
extern void iSPCH_ClearOldEvents(int winnerSlot);                    /* @0x800E7528 */
extern void SPCH_PlaySpeech(void);                                   /* @0x800E7644 */
extern int  SPCH_ChooseSpeech(void);                                 /* @0x800E7684 */

#define SLOT(i)  ((unsigned char *)gVoxEvents + (i) * 0x3c)

/* VoxEvent_GetKeepTillExpiresFlag @0x800E6E94 : bit 2 of the event flags byte (+0xa). */
extern unsigned int VoxEvent_GetKeepTillExpiresFlag(int e)
{
    return (unsigned int)*(unsigned char *)(e + 10) >> 2 & 1;
}

/* iSPCH_SearchEventDat @0x800E6EC4 : address of the entry in blob `dat` whose id == eventID, or 0. */
extern int iSPCH_SearchEventDat(int dat, unsigned int eventID)
{
    unsigned int count = *(unsigned short *)(dat + 2);
    int table = 0;
    if (count != 0) {
        do {
            unsigned short *p = (unsigned short *)iSPCH_GetOffset16(dat, dat + 0xc, table);
            table = table + 1;
            if (*p == eventID)
                return (int)p;
        } while (table < (int)count);
    }
    return 0;
}

/* iSPCH_FindEvent @0x800E6F4C : search all 4 bound blobs for eventID; returns its entry ptr, or 0. */
extern int iSPCH_FindEvent(unsigned int eventID)
{
    int  i = 0;
    int *p = gEventDats;
    int  result;
    while (*p == 0 || (result = iSPCH_SearchEventDat(*p, eventID), result == 0)) {
        i = i + 1;
        p = p + 1;
        if (3 < i)
            return 0;
    }
    return result;
}

/* iSPCH_InitEventDat @0x800E6FBC : clear the 4 bound event-data blob pointers. */
extern void iSPCH_InitEventDat(void)
{
    int i = 3;
    do {
        gEventDats[i] = 0;
        i = i - 1;
    } while (-1 < i);
}

/* GetFilterLength @0x800E6FE4 : the filter-length config word from the first bound blob (+4). */
extern int GetFilterLength(void)
{
    return *(int *)(gEventDats[0] + 4);
}

/* GetFilterPriority @0x800E6FFC : the filter-priority config word from the first bound blob (+8). */
extern int GetFilterPriority(void)
{
    return *(int *)(gEventDats[0] + 8);
}

/* iSPCH_InitEventQueue @0x800E7014 : zero all 16 queue slots (header + 12 eventArgs each) and the ticks. */
extern void iSPCH_InitEventQueue(void)
{
    /* Residual 17: the indexed outer walk and volatile ascending argument clear recover the oracle's
     * offsets/up-count loop; gcc still folds the separate base, slot, and end induction values together.
     *
     * w32-a9 INVESTIGATION (kept as a floor + a toolchain-identity data point, source form NOT changed):
     * the retail SHAPE is a label+goto double loop with SIX live values -- argBase($a2), base($a3),
     * slot($a0), end($t0), j($a1), off($v1) -- i.e. it never went through loop.c (no biv elimination,
     * no giv reduction of `base+off`, no up-count->down-count reversal).  Writing both loops as
     * label+goto reproduces that shape EXACTLY: 28/29 insns, every instruction in the oracle's order,
     * every value in its own register.  It is REJECTED here only because the ALLOCATION order differs
     * and costs more textual diffs than this form (31 vs 17):
     *   cc1 -dl says slot = 11 refs / 21 insns => prio floor_log2(11)*11/21 = 1.57  -> takes $v1 (1st)
     *                off  =  4 refs / 12 insns => prio            2*4/12 = 0.67  -> takes $a0 (3rd)
     *   retail has the REVERSE (off=$v1 first, slot=$a0 second), which this priority formula cannot
     *   produce for ANY spelling of the same six values: with slot at 9-11 refs it would need
     *   live_length(slot) > 3.4x live_length(off), impossible in a 29-insn function.  => retail's cc1
     *   weights SHORT LIVE RANGE over REF COUNT more strongly than psq43 cc1 does; same family as the
     *   catalog's suspected `allocno_compare` delta (sbdload/purge/start/serve).  Additionally retail
     *   keeps a redundant `addu a3,v0,zero` copy of the la result that our cc1 always fuses into the
     *   `addiu` (the known no-copy-prop identity gap) -- that is the 29th instruction. */
    int argBase = 0;
    int base = (int)gVoxEvents;
    gVoxEvents[0]   = 0;
    *(int *)(base + 4) = 0;   /* DAT_80148064: stored via base+4 (oracle sw 0,4(a3)) */
    do {
        int slot = base + argBase;
        int j = 0;
        *(short *)(slot + 8)  = 0;
        *(short *)(slot + 0xa) = 0;
        *(int *)(slot + 0xc)  = 0;
        *(int *)(slot + 0x10) = 0;
        do {
            ((volatile int *)(base + argBase))[j + 5] = 0;
            j = j + 1;
        } while (j < 0xc);
        argBase = argBase + 0x3c;
    } while (argBase < 0x3c0);
    gLastTick[0]    = 0;
    gLastSubTick[0] = 0;
}

/* iSPCH_FindEventSlot @0x800E7088 : pick a slot for a new event of `priority` -- first a free slot, else the
 *   first expired slot, else evict the first slot with priority <= `priority`.  Returns the index, or -1. */
extern int iSPCH_FindEventSlot(unsigned int priority)
{
    int result = -1;
    int i;
    if (gVoxEvents[0] < 0x10) {
        i = 0;
        do {
            unsigned char *slot = (unsigned char *)gVoxEvents + i * 0x3c;
            if (*(unsigned short *)(slot + 8) == 0) {
                result = i;
                goto done;
            }
            i = i + 1;
        } while (i < 0x10);
    }
    {
        int tick = gettick();
        i = 0;
        do {
            unsigned char *slot     = (unsigned char *)gVoxEvents + i * 0x3c;
            int            voxEvent = *(int *)(slot + 0x10);
            unsigned short maxAge   = *(unsigned short *)(voxEvent + 2);
            if (maxAge != 0 &&
                maxAge < (unsigned int)(tick - *(int *)(slot + 0xc))) {
                *(short *)(slot + 8) = 0;
                result = i;
                gVoxEvents[0] = gVoxEvents[0] - 1;
                goto done;
            }
            i  = i + 1;
        } while (i < 0x10);
    }
    i = 0;
    do {
        unsigned char *slot       = (unsigned char *)gVoxEvents + i * 0x3c;
        int            voxEvent   = *(int *)(slot + 0x10);
        unsigned int   evPriority = (unsigned int)*(unsigned short *)(voxEvent + 4);
        if (priority >= evPriority) {
            *(short *)(slot + 8) = 0;
            result = i;
            gVoxEvents[0] = gVoxEvents[0] - 1;
            goto done;
        }
        i = i + 1;
    } while (i < 0x10);
  done:
    return result;
}

/* SPCH_AddEvent @0x800E71B8 : queue the event identified by table[0] (randomly accepted per its accept
 *   probability), copying table[0..11] into the chosen slot's eventArgs.  Returns 0.
 *   MATCH (w32-a9, 18 -> 16 diffs): the slot address is built OFFSET-FIRST (`off + base`, both plain
 *   ints) -- the oracle's per-iteration `addu v0,a1,t0` has the byte offset as operand 0, and C
 *   pointer arithmetic (`base + off`, base a `char *`) always canonicalises the POINTER to operand 0,
 *   giving the reversed `addu v0,t0,a1`.  RESIDUAL 16 (80/82) = the two redundant preheader COPIES
 *   retail keeps and our cc1 fuses (`lui;addiu v0;addu t0,v0,zero` vs our `lui;addiu t0,v0`, and
 *   `sll v0,v0,2;addu a1,v0,zero` vs our `sll a1,v0,2`) -- the per-obj no-copy-prop identity
 *   (catalog SSG), not a source shape. */
extern int SPCH_AddEvent(unsigned int *table)
{
    int voxEvent = iSPCH_FindEvent(*table);
    if (voxEvent != 0) {
        int acceptProb = *(signed char *)(voxEvent + 9);
        if (iSPCH_Rand(100) <= acceptProb) {
            int slot = iSPCH_FindEventSlot((unsigned int)*(unsigned short *)(voxEvent + 4));
            if (-1 < slot) {
                int            tick = gettick();
                short          sub;
                int            j;
                int            base;
                int            off;
                unsigned int  *p;
                if (tick == gLastTick[0])
                    gLastSubTick[0] = gLastSubTick[0] + 1;
                else
                    gLastSubTick[0] = 0;
                sub  = (short)gLastSubTick[0];
                j    = 0;
                base = (int)gVoxEvents;
                p    = table;
                off  = slot * 0x3c;
                gLastTick[0] = tick;
                *(int *)(off + base + 0x10)  = voxEvent;
                *(int *)(off + base + 0xc)   = tick;
                *(short *)(off + base + 0xa) = sub;
                do {
                    *(unsigned int *)(off + base + 0x14) = *p;
                    p   = p + 1;
                    off = off + 4;
                    j   = j + 1;
                } while (j < 0xc);
                gVoxEvents[0] = gVoxEvents[0] + 1;
                *(short *)((unsigned char *)gVoxEvents + slot * 0x3c + 8) = 1;
            }
        }
    }
    return 0;
}

/* iSPCH_ChooseEvent @0x800E7300 : pick the best pending event slot (highest priority, then lowest age, then
 *   lowest subtick), disabling any expired/filtered slots along the way.  Returns the slot index, or -1. */
extern int iSPCH_ChooseEvent(void)
{
    int            winner  = -1;
    /* MATCH: now/bestPri/bestSub genuinely stack-resident in the oracle (sp+0x10/0x14/0x18,
     * contiguous, reloaded every use -- NOT register-promoted) -- reproduce as an on-stack
     * aggregate so gcc doesn't SRA/register-allocate the fields (2 ints + 1 short == the exact
     * 0x10/0x14/0x18 layout). winner/bestAge/slotIdx stay plain locals (oracle keeps them s4/fp/s7). */
    struct { int now; int bestPri; unsigned short bestSub; } L;
    int            bestAge;
    int            slotIdx;
    L.now     = gettick() + gPreLoadTicks;
    bestAge   = winner;
    L.bestPri = 0;
    L.bestSub = 0;
    slotIdx = 0;
    do {
        unsigned char *slot = (unsigned char *)gVoxEvents + slotIdx * 0x3c;
        if (*(unsigned short *)(slot + 8) != 0) {
            int            voxEvent   = *(int *)(slot + 0x10);
            int            tick       = *(int *)(slot + 0xc);
            int            age        = L.now - tick;
            int            expired    = 0;
            int            filtered   = 0;
            unsigned short maxAge     = *(unsigned short *)(voxEvent + 2);
            if (maxAge != 0) {
                /* w31-a4 residual (46, 118/120): oracle has an extra `addu v0,v1,zero` copy of
                 * maxAge feeding the sltu (named-int-temp shape; an `int m = maxAge` folds away
                 * under CSE) and a slot/age s2<->s3 + reload-reg rotation downstream -- the
                 * ours-2-shorter receiver-reuse class, permuter territory. Named `tick` temp
                 * (load order 12(slot) before now-reload) was the real -12 lever. */
                int m = maxAge;
                expired = ((unsigned int)m < (unsigned int)age);
            }
            if (gFilterSetting[0] == 1) {
                if ((VoxEvent_GetFilterLengthFlag(voxEvent) & 0xff) != 0) {
                    unsigned short pri = *(unsigned short *)(voxEvent + 4);
                    if ((int)(unsigned int)pri < GetFilterPriority())
                        filtered = 1;
                }
            }
            if (expired != 0 || filtered != 0) {
                *(short *)(slot + 8) = 0;
                gVoxEvents[0] = gVoxEvents[0] - 1;
            } else {
                unsigned short pri = *(unsigned short *)(voxEvent + 4);
                if (L.bestPri < (int)(unsigned int)pri) {
                    unsigned char *winSlot;
                    winner  = slotIdx;
                    winSlot = SLOT(slotIdx);
                    L.bestSub = *(unsigned short *)(winSlot + 0xa);
                    bestAge = age;
                    L.bestPri = (int)(unsigned int)pri;
                } else if ((int)(unsigned int)pri == L.bestPri) {
                    unsigned short sub = *(unsigned short *)(slot + 0xa);
                    if ((unsigned int)age < (unsigned int)bestAge ||
                        (age == bestAge && (int)(unsigned int)L.bestSub < (int)(unsigned int)sub)) {
                        unsigned char *winSlot;
                        winner  = slotIdx;
                        bestAge = age;
                        winSlot = SLOT(slotIdx);
                        L.bestSub = *(unsigned short *)(winSlot + 0xa);
                    }
                }
            }
        }
        slotIdx = slotIdx + 1;
    } while (slotIdx < 0x10);
    return winner;
}

/* SPCH_ClearEventQueue @0x800E74E0 : disable every active slot. */
extern void SPCH_ClearEventQueue(void)
{
    /* MATCH: indexing by i before strength reduction keeps the walking pointer at the slot base. */
    int            i = 0;
    do {
        unsigned char *slot = (unsigned char *)gVoxEvents + i * 0x3c;
        if (*(unsigned short *)(slot + 8) != 0) {
            *(short *)(slot + 8) = 0;
            gVoxEvents[0] = gVoxEvents[0] - 1;
        }
        i = i + 1;
    } while (i < 0x10);
}

/* iSPCH_ClearOldEvents @0x800E7528 : disable slots older than the winner (unless keep-till-expires); note a
 *   surviving 'd'-tagged event in DAT_80148064.  Returns 0. */
extern void iSPCH_ClearOldEvents(int winnerSlot)
{
    /* MATCH: the inlined identity above moves the base copy into the oracle's early schedule. */
    unsigned char *win     = (unsigned char *)iSPCH_EventBase(gVoxEvents) + winnerSlot * 0x3c;
    unsigned int   winTick = (unsigned int)*(int *)(win + 0xc);
    unsigned int   winSub  = (unsigned int)*(unsigned short *)(win + 0xa);
    unsigned char *base    = (unsigned char *)gVoxEvents;
    int            i       = 0;
    *(int *)(base + 4) = 0;   /* DAT_80148064: stored via base+4 (oracle sw 0,4(s4)) */
    do {
        unsigned char *slot = base + i * 0x3c;
        if (i == winnerSlot)
            goto cont;
        if (*(unsigned short *)(slot + 8) == 0)
            goto cont;
        {
            unsigned int tick = (unsigned int)*(int *)(slot + 0xc);
            unsigned int sub  = (unsigned int)*(unsigned short *)(slot + 0xa);
            if (tick < winTick)
                goto disable;
            if (tick != winTick)
                goto dcheck;
            if (sub >= winSub)
                goto dcheck;
          disable:
            if ((VoxEvent_GetKeepTillExpiresFlag(*(int *)(slot + 0x10)) & 0xff) != 0)
                goto cont;
            *(short *)(slot + 8) = 0;
            gVoxEvents[0] = gVoxEvents[0] - 1;
            goto cont;
          dcheck:
            if (*(signed char *)(*(int *)(slot + 0x10) + 9) == 'd')
                *(int *)(base + 4) = 1;
        }
      cont:
        i = i + 1;
    } while (i < 0x10);
}

/* SPCH_PlaySpeech @0x800E7644 : if nothing chosen, choose; then play the chosen speech. */
extern void SPCH_PlaySpeech(void)
{
    if (iSPCH_OneChosen() != 0) {
        iSPCH_PlayChosen();
        return;
    }
    if (SPCH_ChooseSpeech() != 0)
        iSPCH_PlayChosen();
}

/* SPCH_ChooseSpeech @0x800E7684 : pick the winning event, clear the events it supersedes, and hand its
 *   eventArgs to the sentence picker.  If no sentence is chosen and a gReparm hook is installed, retry
 *   per index until one is chosen or the hook gives up.  Returns the chosen-sentence count. */
extern int SPCH_ChooseSpeech(void)
{
    int result = 0;
    if (gVoxEvents[0] != 0) {
        int winner = iSPCH_ChooseEvent();
        if (-1 < winner) {
            unsigned int *eventArgs;
            iSPCH_ClearOldEvents(winner);
            eventArgs = (unsigned int *)(SLOT(winner) + 0x14);
            result = iSPCH_ChooseSentence(eventArgs);
            if (result == 0) {
                if (gReparm[0] != 0) {
                    int i = 0;
                    int rc;
                    do {
                        rc = ((int (*)(int, unsigned int *))gReparm[0])(i, eventArgs);
                        if (-1 < rc)
                            result = iSPCH_ChooseSentence(eventArgs);
                        i = i + 1;
                        if (result != 0)
                            break;
                    } while (0 < rc);
                }
            }
            if (result < 0)
                result = 0;
            {
                unsigned char *g = (unsigned char *)gVoxEvents;
                ((int *)g)[0] = ((int *)g)[0] - 1;
                *(short *)(g + winner * 0x3c + 8) = 0;
            }
        }
    }
    return result;
}
