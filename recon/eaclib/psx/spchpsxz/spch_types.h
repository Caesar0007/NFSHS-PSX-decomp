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
    unsigned char  numSentences;  /* +0x6 OrderSentences/ChooseSentence bound; also sizes the rule data */
    signed char    numRules;      /* +0x7 2-byte rules {idByte, type<<4|paramIdx} start at +0xc+2*numSentences (iSPCH_GetRuleDataAddr) */
    unsigned char  _unk8;         /* +0x8 (no read sites found) */
    signed char    acceptProb;    /* +0x9 accept probability; 'd' tags the kept-event class */
    unsigned char  flags;         /* +0xa bit0 = filter-length, bit2 = keep-till-expires */
    unsigned char  _unkB;         /* +0xb (no read sites found) */
    unsigned short sentenceOffs[1];/* +0xc trailing: numSentences word offsets (<<2 from the event base) to the
                                    VoxSentence records, then the rule bytes.  Measured (census tool): record =
                                    0xc + 2*numSentences + 2*numRules, padded to 4. */
} VoxEvent;

/* VoxRule: one 2-byte rule entry of a VoxEvent (numRules of them right after sentenceOffs[];
 * iSPCH_GetRuleDataAddr).  typeParam: high nibble = rule type (0..4 constant rules handled by
 * RuleSet/ConstantRuleSet, 1..12 tested by GetRuleSettings, 0xf = none), low nibble = param index. */
typedef struct {
    unsigned char id;             /* +0x0 rule id passed to the gSentenceRuleSet/gSentenceRuleTest callbacks */
    unsigned char typeParam;      /* +0x1 type << 4 | paramIdx */
} VoxRule;

/* VoxRuleDecoded: a VoxRule unpacked into three words.  Retail keeps these three on the stack in
 * every rule reader (GetRuleID stores all three and reads only .id) -- gcc 2.8 does not scalarise
 * aggregate locals, so a decoded struct is the source shape that reproduces those stores. */
typedef struct {
    unsigned int id;
    unsigned int paramIdx;
    unsigned int type;
} VoxRuleDecoded;

/* VoxSentence: 4-byte head + numPhrases byte offsets, padded to 4.  Measured on the retail
 * event.dat (2026-09-05, tools/spch_eventdat_census.py, 222 sentences): record size is exactly
 * 4 + numPhrases rounded up to 4 (8 for 1..4 phrases, 12 for 5..8, 16 for 9..10).  A sentence
 * carries NO rule data -- the earlier "+6 half-length / +7 numRules / +0xc rule table" reading
 * was the VoxEvent layout seen through the mis-named `sentence` parameter of spchrule's
 * GetRuleDataAddr / GetRuleID / RuleSet / GetRuleSettings (those take the EVENT). */
typedef struct {
    unsigned short id;            /* +0x0 (its LOW byte is read as the random weight by OrderSentences) */
    unsigned char  _unk2;         /* +0x2 */
    unsigned char  flags;         /* +0x3 bits 0-1 = short rule, bits 2-7 = numPhrases */
    unsigned char  phraseOffs[1]; /* +0x4 trailing: numPhrases word offsets (<<2 from the sentence base) to VoxPhrase */
} VoxSentence;

/* VoxPhrase: one phrase template (spchpick's phraseTemplate).  VARIABLE-LENGTH record:
 * 8-byte header + count ints.  Measured on the retail ZZZZZENG.VIV event.dat (2026-09-05,
 * tools/spch_eventdat_census.py): 1059 records, count 0..4, every record exactly 8+4*count
 * bytes -- so matchValues is a trailing array, not a fixed 4-slot field. */
typedef struct {
    unsigned short bankId;        /* +0x0 wanted bank id (iSPCH_GetPhraseBank) */
    unsigned char  modeParam;     /* +0x2 high nibble = bank-select mode, low = param index */
    signed char    count;         /* +0x3 (valid < 5) */
    unsigned char  nibbles[4];    /* +0x4..0x7 per-index low-nibble selectors (iSPCH_MatchSample) */
    int            matchValues[1];/* +0x8 trailing: `count` bit-masks (0..4), one per nibbles[] index -- iSPCH_GetMatchValue */
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

/* VoxEventDat: one bound speech event-data blob (event.dat); up to 4 live in gEventDats[]
 * (bound by SPCH_ResolveData -> iSPCH_BindData, first free slot).  Layout by access census:
 * spchrand (version gate), spchevnt (numEvents / eventOffs walk, the two filter words). */
typedef struct {
    unsigned short version;        /* +0x0 must be > 0x11d to be accepted by iSPCH_BindData */
    unsigned short numEvents;      /* +0x2 entries in eventOffs[] */
    int            filterLength;   /* +0x4 default filter length (GetFilterLength: slot 0 only) */
    int            filterPriority; /* +0x8 filter priority threshold (GetFilterPriority: slot 0 only) */
    unsigned short eventOffs[1];   /* +0xc word offsets (<<2 from the blob base) to the VoxEvent records */
} VoxEventDat;

#endif
