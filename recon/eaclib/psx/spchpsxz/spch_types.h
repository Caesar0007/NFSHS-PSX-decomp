#ifndef _SPCH_TYPES_H_
#define _SPCH_TYPES_H_

/* VoxBank: one speech sample bank blob (layout recovered by access census across
 * spchbank/spchpick/spchsamp, 2026-09-04 -- the lib's SYM is bare, so every field
 * below is evidenced by at least one read/write site, most by several TUs). */
typedef struct {
    unsigned short id;           /* +0x0 bank id (iSPCH_FindBank / iSPCH_GetPhraseBank key) */
    unsigned char  flags;        /* +0x2 low nibble = filterCnt (sample entry stride - 2);
                                  *      high nibble != 0 -> bank carries cycle bits */
    unsigned char  numSamples;   /* +0x3 */
    unsigned short dataSize256;  /* +0x4 SPU data size of one sub-bank, in 256-byte units */
    unsigned short subBankCount; /* +0x6 (0xffff = no sub-banks) */
    /* +0x8: numSamples packed sample entries of (2 + filterCnt) bytes each --
     *       entry[0..1] = big-endian16 start offset (<<8 = SPU bytes), entry[0]&0x80 =
     *       redirect to entry #entry[1], entry[2..] = filter bytes -- followed by the
     *       cycle-bits array (its byte[0] = nGroups). */
} VoxBank;

/* VoxEvent: one event record inside a bound EventDat blob (found by id via
 * iSPCH_SearchEventDat over the blob's +0xc offset table). */
typedef struct {
    unsigned short id;            /* +0x0 */
    unsigned short maxAge;        /* +0x2 ticks, 0 = never expires (FindEventSlot/ChooseEvent) */
    unsigned short priority;      /* +0x4 slot eviction + winner choice */
    unsigned char  numSentences;  /* +0x6 OrderSentences/ChooseSentence bound */
    unsigned char  _unk7;         /* +0x7 (no read sites found) */
    unsigned char  _unk8;         /* +0x8 (no read sites found) */
    signed char    acceptProb;    /* +0x9 accept probability; 'd' tags the kept-event class */
    unsigned char  flags;         /* +0xa bit0 = filter-length, bit2 = keep-till-expires */
    unsigned char  _unkB;         /* +0xb (no read sites found) */
    /* +0xc: u16 sentence-offset table (numSentences entries, <<2 from the event base;
     *       walked via iSPCH_GetOffset16). */
} VoxEvent;

/* VoxSentence: PARTIAL map -- only the unambiguous head is typed; the tail is variable.
 * Full layout by census (2026-09-04, corrected -- the "+6 rule table" reading was short*
 * arithmetic misread as bytes):
 *   +0x4  u8 phrase-offset table (numPhrases entries; iSPCH_GetOffset8(sentence, +4, i))
 *   +0x6  u8 rule-table half-length (iSPCH_GetRuleDataAddr: ruleData = sentence + [+6]*2 + 0xc)
 *   +0x7  s8 numRules (iSPCH_RuleSet)
 *   +0xc  u16 rule-offset table (spchrule RuleSet: GetOffset16(sentence, byte +0xc, rule))
 *   ruleData (@ +0xc + [+6]*2): 2-byte rule entries {idByte, packed nibble-pair}
 * (+4..+5 phrase offsets vs +6..+7 metadata coexist only for numPhrases <= 2 -- the format
 * evidently sizes the phrase table into the +4 region for the sentences that use rules). */
typedef struct {
    unsigned short id;            /* +0x0 (its LOW byte is read as the random weight by OrderSentences) */
    unsigned char  _unk2;         /* +0x2 */
    unsigned char  flags;         /* +0x3 bits 0-1 = short rule, bits 2-7 = numPhrases */
} VoxSentence;

/* VoxPhrase: one phrase template (spchpick's phraseTemplate). */
typedef struct {
    unsigned short bankId;        /* +0x0 wanted bank id (iSPCH_GetPhraseBank) */
    unsigned char  modeParam;     /* +0x2 high nibble = bank-select mode, low = param index */
    signed char    count;         /* +0x3 (valid < 5) */
    unsigned char  nibbles[4];    /* +0x4..0x7 per-index low-nibble selectors (iSPCH_MatchSample) */
    /* +0x8: int matchValues[count] -- iSPCH_GetMatchValue */
} VoxPhrase;

/* EA's TRUE record (2026-09-03, user model): the queue header is the run's first 8 bytes and
 * the 16 records start at run+8, stride 0x3c -- args[12] fills a record EXACTLY (2+2+4+4+48),
 * no cross-slot overlay games.  MEASURED: with INDEXED addressing this honest spelling is
 * codegen-identical to the old -8-shifted window (cc1 anchors the giv base at run+0 and folds
 * the +8 into the field displacements). */
#define VOX_NSLOTS 16

typedef struct {
    unsigned short enabled;      /* +0x0 (run-relative +0x8)  */
    unsigned short subTick;      /* +0x2 (+0xa)  */
    int            tick;         /* +0x4 (+0xc)  insert tick */
    VoxEvent      *event;        /* +0x8 (+0x10) */
    int            args[12];     /* +0xc..0x3b (+0x14..+0x43) */
} VoxSlot;                       /* 0x3c */
typedef struct {
    int     liveCount;           /* +0x0 number of enabled slots (AddEvent ++, FindEventSlot/
                                  * ClearEventQueue/ClearOldEvents/ChooseEvent/ChooseSpeech --,
                                  * gated `< 16` / `!= 0`) */
    int     dFlag;               /* +0x4 "a 'd'-tagged event survived" flag (set by
                                  * ClearOldEvents, read by spchpick's filter bump;
                                  * retail's DAT_80148064) */
    VoxSlot slots[VOX_NSLOTS];   /* +0x8 the 16 records */
} VoxSlotsStruct;                /* 8 + 16*0x3c = 968 */

#endif
