/* eaclib/psx/spchpsxz/spchevnt.c -- RECONSTRUCTED from nfs4-f.exe. NOT original source.  *** 16/16 ***
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
extern int            gLastTick;      /* last insert tick */
extern unsigned short gLastSubTick;   /* sub-tick counter for same-tick inserts */
extern int            gPreLoadTicks;  /* speech pre-load tick offset */
extern int            gFilterSetting; /* active filter mode (1 = length/priority filter on) */
extern int            gEventDats[];   /* @0x80148048 : int[4] bound event-data blobs (spchrand-owned) */

extern int  gettick(void);                                  /* eaclib timer.obj */
extern int  iSPCH_Rand(int n);                              /* spchrand */
extern int  iSPCH_OneChosen(void);                          /* spchpick */
extern void iSPCH_PlayChosen(void);                         /* spchpick */
extern int  iSPCH_ChooseSentence(unsigned int *eventArgs);  /* spchpick (returns chosen-count) */

/* gReparm @0x801370A0 : optional "re-parameterize" hook -- if set, retried per index until a sentence
 *   is chosen or the hook returns <=0.  Signature from SPCH_ChooseSpeech's jalr call site. */
extern int (*gReparm)(int index, unsigned int *eventArgs);

/* ---- per-TU static copies of shared helpers (canon in spchdata.obj) ---- */
static int VoxEvent_GetFilterLengthFlag(int e)   /* @0x800E6E88 */
{
    return (int)*(unsigned char *)(e + 0xa) & 1;
}
static int iSPCH_GetOffset16(int base, int tableBase, int index)  /* @0x800E6EA8 */
{
    return base + ((int)*(unsigned short *)(tableBase + index * 2) << 2);
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
extern int  iSPCH_ClearOldEvents(int winnerSlot);                    /* @0x800E7528 */
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
    unsigned char *base = (unsigned char *)gVoxEvents;
    unsigned char *slot = base;
    unsigned char *end  = base + 0x3c0;
    int argBase = 0;
    gVoxEvents[0]   = 0;
    DAT_80148064 = 0;
    do {
        int j = 0;
        int off = argBase;
        *(short *)(slot + 8)  = 0;
        *(short *)(slot + 0xa) = 0;
        *(int *)(slot + 0xc)  = 0;
        *(int *)(slot + 0x10) = 0;
        do {
            *(int *)(base + off + 0x14) = 0;
            j = j + 1;
            off = off + 4;
        } while (j < 0xc);
        slot = slot + 0x3c;
        argBase = argBase + 0x3c;
    } while (slot < end);
    gLastTick    = 0;
    gLastSubTick = 0;
}

/* iSPCH_FindEventSlot @0x800E7088 : pick a slot for a new event of `priority` -- first a free slot, else the
 *   first expired slot, else evict the first slot with priority <= `priority`.  Returns the index, or -1. */
extern int iSPCH_FindEventSlot(unsigned int priority)
{
    int            i;
    unsigned char *slot;
    if (gVoxEvents[0] < 0x10) {
        i = 0;
        slot = (unsigned char *)gVoxEvents;
        do {
            if (*(short *)(slot + 8) == 0)
                return i;
            i = i + 1;
            slot = slot + 0x3c;
        } while (i < 0x10);
    }
    {
        int tick = gettick();
        int idx  = 0;
        slot = (unsigned char *)gVoxEvents;
        while (1) {
            int            voxEvent = *(int *)(slot + 0x10);
            unsigned short maxAge   = *(unsigned short *)(voxEvent + 2);
            if (!(maxAge == 0 || (unsigned int)(tick - *(int *)(slot + 0xc)) <= (unsigned int)maxAge))
                break;
            idx  = idx + 1;
            slot = slot + 0x3c;
            if (0xf < idx) {
                i = 0;
                slot = (unsigned char *)gVoxEvents;
                do {
                    if (*(unsigned short *)(*(int *)(slot + 0x10) + 4) <= priority) {
                        *(short *)(slot + 8) = 0;
                        gVoxEvents[0] = gVoxEvents[0] - 1;
                        return i;
                    }
                    i = i + 1;
                    slot = slot + 0x3c;
                } while (i < 0x10);
                return -1;
            }
        }
        *(short *)(slot + 8) = 0;
        gVoxEvents[0] = gVoxEvents[0] - 1;
        return idx;
    }
}

/* SPCH_AddEvent @0x800E71B8 : queue the event identified by table[0] (randomly accepted per its accept
 *   probability), copying table[0..11] into the chosen slot's eventArgs.  Returns 0. */
extern int SPCH_AddEvent(unsigned int *table)
{
    int voxEvent = iSPCH_FindEvent(*table);
    if (voxEvent != 0) {
        signed char acceptProb = *(signed char *)(voxEvent + 9);
        if (iSPCH_Rand(100) <= (int)acceptProb) {
            int slot = iSPCH_FindEventSlot((unsigned int)*(unsigned short *)(voxEvent + 4));
            if (-1 < slot) {
                unsigned char *s = SLOT(slot);
                int            tick = gettick();
                short          sub;
                int            j;
                if (tick == gLastTick)
                    gLastSubTick = gLastSubTick + 1;
                else
                    gLastSubTick = 0;
                sub = (short)gLastSubTick;
                gLastTick = tick;
                *(int *)(s + 0x10)  = voxEvent;
                *(int *)(s + 0xc)   = tick;
                *(short *)(s + 0xa) = sub;
                j = 0;
                do {
                    *(unsigned int *)(s + 0x14 + j * 4) = table[j];
                    j = j + 1;
                } while (j < 0xc);
                gVoxEvents[0] = gVoxEvents[0] + 1;
                *(short *)(s + 8) = 1;
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
    int            bestAge = -1;
    int            bestPri = 0;
    unsigned short bestSub = 0;
    int            now     = gettick() + gPreLoadTicks;
    int            slotIdx = 0;
    unsigned char *slot    = (unsigned char *)gVoxEvents;
    do {
        if (*(unsigned short *)(slot + 8) != 0) {
            int            voxEvent   = *(int *)(slot + 0x10);
            int            age        = now - *(int *)(slot + 0xc);
            int            expired    = 0;
            int            filtered   = 0;
            unsigned short maxAge     = *(unsigned short *)(voxEvent + 2);
            if (maxAge != 0)
                expired = ((int)(unsigned int)maxAge < age);
            if (gFilterSetting == 1) {
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
                if (bestPri < (int)(unsigned int)pri) {
                    winner  = slotIdx;
                    bestSub = *(unsigned short *)(slot + 0xa);
                    bestAge = age;
                    bestPri = (int)(unsigned int)pri;
                } else if ((int)(unsigned int)pri == bestPri) {
                    if (age < bestAge ||
                        (age == bestAge && (int)(unsigned int)bestSub < (int)(unsigned int)*(unsigned short *)(slot + 0xa))) {
                        winner  = slotIdx;
                        bestAge = age;
                        bestSub = *(unsigned short *)(slot + 0xa);
                    }
                }
            }
        }
        slotIdx = slotIdx + 1;
        slot    = slot + 0x3c;
    } while (slotIdx < 0x10);
    return winner;
}

/* SPCH_ClearEventQueue @0x800E74E0 : disable every active slot. */
extern void SPCH_ClearEventQueue(void)
{
    int            i = 0;
    unsigned char *slot = (unsigned char *)gVoxEvents;
    do {
        if (*(unsigned short *)(slot + 8) != 0) {
            *(short *)(slot + 8) = 0;
            gVoxEvents[0] = gVoxEvents[0] - 1;
        }
        i = i + 1;
        slot = slot + 0x3c;
    } while (i < 0x10);
}

/* iSPCH_ClearOldEvents @0x800E7528 : disable slots older than the winner (unless keep-till-expires); note a
 *   surviving 'd'-tagged event in DAT_80148064.  Returns 0. */
extern int iSPCH_ClearOldEvents(int winnerSlot)
{
    int            i    = 0;
    unsigned char *slot = (unsigned char *)gVoxEvents;
    unsigned int   winTick = (unsigned int)*(int *)(SLOT(winnerSlot) + 0xc);
    unsigned short winSub  = *(unsigned short *)(SLOT(winnerSlot) + 0xa);
    DAT_80148064 = 0;
    do {
        if (i != winnerSlot && *(short *)(slot + 8) != 0) {
            if ((unsigned int)*(int *)(slot + 0xc) < winTick ||
                (*(int *)(slot + 0xc) == (int)winTick &&
                 (int)(unsigned int)*(unsigned short *)(slot + 0xa) < (int)(unsigned int)winSub)) {
                if ((VoxEvent_GetKeepTillExpiresFlag(*(int *)(slot + 0x10)) & 0xff) == 0) {
                    *(short *)(slot + 8) = 0;
                    gVoxEvents[0] = gVoxEvents[0] - 1;
                }
            } else if (*(char *)(*(int *)(slot + 0x10) + 9) == 'd') {
                DAT_80148064 = 1;
            }
        }
        i = i + 1;
        slot = slot + 0x3c;
    } while (i < 0x10);
    return 0;
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
            unsigned int *eventArgs = (unsigned int *)(SLOT(winner) + 0x14);
            iSPCH_ClearOldEvents(winner);
            result = iSPCH_ChooseSentence(eventArgs);
            if (result == 0 && gReparm != 0) {
                int i  = 0;
                int rc;
                do {
                    rc = gReparm(i, eventArgs);
                    if (-1 < rc)
                        result = iSPCH_ChooseSentence(eventArgs);
                    if (result != 0)
                        break;
                    i = i + 1;
                } while (0 < rc);
            }
            if (result < 0)
                result = 0;
            gVoxEvents[0] = gVoxEvents[0] - 1;
            *(short *)(SLOT(winner) + 8) = 0;
        }
    }
    return result;
}
