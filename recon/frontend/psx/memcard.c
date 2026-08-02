/* frontend/psx/memcard.c  --  RECONSTRUCTED  (PSX memory-card I/O; MEMCARD.C, C source)
 *   Bodies      : Ghidra decompiler (nfs4-f.exe MIPS), full re-decompile.
 *   Line numbers: PsyQ SLD per-instruction stream (8c-start, SLD-max end).
 *   C TU: SLD source = C:\nfs4\FRONTEND\PSX\MEMCARD.C -> CC1PSX lane (methodology 3.25;
 *   migrated from memcard.cpp, task #90). Self-contained per C-lane convention (local
 *   type mirrors; nfs4_types.h is C++-only). Unmangled C symbols match the SYM.
 *   3 helpers iMCRD_timersub/ascii2sjis/sjis2ascii are SYM class STAT (kept as plain
 *   globals here, same as the .cpp shape - names pair with the front oracle .s).
 *   Drives the typed global gMemCardInfo (fMemCardInfo_def) - fields decompiler-named.
 *   NOTE: a few bodies carry decompiler mis-renderings (e.g. MCRD_getopts' 8-byte RECT
 *   copy was byte-unaligned -> rewritten as a struct assignment). Local temp names are
 *   the project's type-hinted bulk names (tu/tp/...), not original source identifiers.
 */

/* ---- base scalar typedefs (self-contained C lane) ---- */
typedef unsigned char  u_char;
typedef unsigned char  uchar;
typedef unsigned char  byte;
typedef unsigned short u_short;
typedef unsigned short ushort;
typedef unsigned int   u_int;
typedef unsigned int   uint;
typedef unsigned long  u_long;

/* ---- local mirrors of the shared memcard types (nfs4_types.h) ---- */
typedef struct RECT {                 /* 8 bytes (PsyQ) */
    short x, y, w, h;
} RECT;

typedef enum {                        /* 4 bytes */
    N_AMERICA = 0,
    JAPAN = 1,
    EUROPE = 2
} PRODUCTLOC;

typedef enum {                        /* 4 bytes */
    NONE = 0,
    LOAD_CARD = 1,
    WRITE_FILE = 2,
    LOAD_FILE = 3,
    DELETE_FILE = 4
} MANAGERTASK;

typedef struct shapetbl {             /* 20 bytes (EA shape) */
    unsigned int type : 8;            /* +0x0 */
    int          next : 24;           /* +0x1 */
    short        width, height, centerx, centery;   /* +0x4 */
    int          shapex : 12;         /* +0xC */
    unsigned int reserved : 1;
    unsigned int twiddled : 1;
    unsigned int transposed : 1;
    unsigned int rotated : 1;
    int          shapey : 12;         /* +0xE */
    unsigned int mipmaps : 4;
    char         data;                /* +0x10 */
} shapetbl;

typedef struct DIRENTRY {             /* 40 bytes (PsyQ kernel) */
    char             name[20];        /* +0x0 */
    long             attr, size;      /* +0x14 */
    struct DIRENTRY *next;            /* +0x1C */
    long             head;            /* +0x20 */
    char             system[4];       /* +0x24 */
} DIRENTRY;

typedef struct CARDINFO_def {         /* 616 bytes */
    int      status, lasterror, numfiles, freeblocks;   /* +0x0 */
    DIRENTRY dir[15];                 /* +0x10 */
} CARDINFO_def;

typedef struct MCRDFILEHEADER_def {   /* 512 bytes */
    u_char  magicnumber[2];           /* +0x0 */
    u_char  type, nslots;             /* +0x2 */
    short   title[32];                /* +0x4 (SJIS codes; retail reads them with lh) */
    u_char  unused[28];               /* +0x44 */
    u_char  iconclut[32];             /* +0x60 */
    u_char  icon1[128], icon2[128], icon3[128];   /* +0x80 */
} MCRDFILEHEADER_def;

typedef struct MCRDFILEINFO_def {     /* 572 bytes */
    int                cardnum;       /* +0x0 */
    char               name[24];      /* +0x4 */
    char               *title;        /* +0x1C */
    int                size, offset;  /* +0x20 */
    unsigned int       flags;         /* +0x28 */
    MCRDFILEHEADER_def header;        /* +0x2C */
    void               *pData;        /* +0x22C */
    shapetbl           *icon[3];      /* +0x230 */
} MCRDFILEINFO_def;

typedef struct MCRDFILE_def {         /* 44 bytes */
    char         *name, *title;       /* +0x0 */
    int          size, offset;        /* +0x8 */
    unsigned int flags;               /* +0x10 */
    void         *pData;              /* +0x14 */
    shapetbl     *icon[3];            /* +0x18 */
    u_char       *numicons, *numblocks;   /* +0x24 */
} MCRDFILE_def;

typedef struct MCRDOPTS_def {         /* 36 bytes */
    PRODUCTLOC productLocation;       /* +0x0 */
    char       *productCode;          /* +0x4 */
    int        bMoveIconsToVram;      /* +0x8 */
    RECT       VramIconArea;          /* +0xC */
    void       *ConfirmFormatProc, *ConfirmOverwriteProc, *LoadingDataProc, *SavingDataProc;   /* +0x14 */
} MCRDOPTS_def;

typedef struct fMemCardInfo_def {     /* 6108 bytes */
    PRODUCTLOC         productLocation;   /* +0x0 */
    char               productCode[16];   /* +0x4 */
    int                bMoveIconsToVram;  /* +0x14 */
    RECT               VramIconArea;      /* +0x18 */
    void               *ConfirmFormatProc, *ConfirmOverwriteProc, *LoadingDataProc, *SavingDataProc;   /* +0x20 */
    MANAGERTASK        task;              /* +0x30 */
    int                bReady, fMultitap; /* +0x34 */
    long               channel;           /* +0x3C */
    int                existencecheckticks[8];   /* +0x40 */
    MCRDFILEHEADER_def header;            /* +0x60 */
    MCRDFILEINFO_def   fileinfo;          /* +0x260 */
    CARDINFO_def       card[8];           /* +0x49C */
} fMemCardInfo_def;

/* ---- memcard.obj data global ---- */
extern fMemCardInfo_def gMemCardInfo;    /* 0x80052d68  (6108 B) */
extern int timerhz;

/* ---- externs (libmcrd/libgs/eaclib/libetc/libc/sibling) ---- */
extern unsigned int shapetype(int v);    /* EA shape helpers */
extern unsigned int cluttype(int v);
extern long MemCardInit(long val);       /* PsyQ libmcrd */
extern long MemCardStart(void);
extern long MemCardStop(void);
extern void MemCardEnd(void);
extern long MemCardSync(long mode, long *result, long *result2);
extern long MemCardExist(long chan);
extern long MemCardAccept(long chan);
extern long MemCardReadFile(long chan, char *name, void *buf, long offset, long len);
extern long MemCardWriteFile(long chan, char *name, void *buf, long offset, long len);
extern long MemCardCreateFile(long chan, char *name, long nslots);
extern long MemCardDeleteFile(long chan, char *name);
extern long MemCardFormat(long chan);
extern long MemCardGetDirentry(long chan, char *pat, DIRENTRY *dir, int *count, long a, long b);
extern u_char *getshapeclut(shapetbl *shape);   /* libgs shape CLUT (1 arg: oracle @0x800F6C3C never reads $a1) */
extern void blockclear(void *dst, int size);             /* eaclib */
extern void blockmove(void *src, void *dst, int size);
extern int  addtimer(void (*proc)(void));
extern int  deltimer(void (*proc)(void));
extern void timedwait(int n);
extern void asyncidle();
extern int  VSync(int mode);                             /* libetc */
extern char *strcpy(char *dst, char *src);               /* libc */
extern char *strcat(char *dst, char *src);
extern char *strncpy(char *dst, char *src, int n);
extern unsigned int strlen(char *s);
extern int  strcmp(char *a, char *b);
extern CARDINFO_def *MCRD_getcard(int card);             /* sibling memcard TU */

/* ---- this TU's fns (fwd decls; intra-TU calls before definitions) ---- */
void MCRD_init(int fMultitap);
int  iMCRD_InitCard(int card);
void MCRD_restore(void);
void MCRD_getopts(MCRDOPTS_def *pOPT);
void MCRD_setopts(MCRDOPTS_def *pOPT);
void MCRD_loadfile(int card, MCRDFILE_def *pFILE, int bNameHasProductCode);
int  iMCRD_DoFileLoad(int card);
int  MCRD_savefile(int card, MCRDFILE_def *pFILE);
int  iMCRD_DoFileWrite(int card);
int  iMCRD_DoFileDelete(int card);
int  MCRD_handlecardevents(int card);
int  MCRD_fileexists(int card, char *name);
int  garyMemCardGrabBlocks(int card, int filenum);
int  iMCRD_LoadCard(int card);
int  iMCRD_FormatCard(int card);
int  iMCRD_HandleError(int func, int opResult, int card);
int  iMCRD_DefaultCBProc1(void);
void  iMCRD_timersub(void);              /* SYM class STAT (see header note) */
short ascii2sjis(u_char ascii_code);
u_char sjis2ascii(short sjis_code);      /* @0x80050810 */

/* file-local SJIS<->ASCII lookup tables (SYM class STAT; byte-exact from image). */
static u_short ascii_table[3][2] = {   /* 0x80052a78 : ASCII range base -> SJIS base (digit/upper/lower) */
    {0x824f, 0x0030}, {0x8260, 0x0041}, {0x8281, 0x0061}
};
static u_short ascii_k_table[33] = {   /* 0x80052a84 : ASCII punctuation -> full-width SJIS */
    0x8140, 0x8149, 0x8168, 0x8194, 0x8190, 0x8193, 0x8195, 0x8166, 0x8169, 0x816a, 0x8196,
    0x817b, 0x8143, 0x817c, 0x8144, 0x815e, 0x8146, 0x8147, 0x8171, 0x8181, 0x8172, 0x8148,
    0x8197, 0x816d, 0x818f, 0x816e, 0x814f, 0x8151, 0x8165, 0x816f, 0x8162, 0x8170, 0x8150
};
static u_char  sjis_table[3][2] = {    /* 0x80052ac8 : SJIS 2nd-byte base -> ASCII base */
    {0x4f, 0x30}, {0x60, 0x41}, {0x81, 0x61}
};
static u_char  sjis_k_table[88] = {    /* 0x80052ad0 : full-width SJIS punctuation -> ASCII */
    0x20, 0x00, 0x00, 0x2c, 0x2e, 0x00, 0x3a, 0x3b, 0x3f, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x5e,
    0x7e, 0x5f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2f, 0x00,
    0x00, 0x00, 0x7c, 0x00, 0x00, 0x60, 0x27, 0x00, 0x22, 0x28, 0x29, 0x00, 0x00, 0x5b, 0x5d, 0x7b,
    0x7d, 0x3c, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2b, 0x2d, 0x00, 0x00, 0x00,
    0x00, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x5c,
    0x24, 0x00, 0x00, 0x25, 0x23, 0x26, 0x2a, 0x40
};

/* lines 1-80: file header, #includes, static data tables (ascii/sjis), macros */

/* ---- MCRD_init  (memcard.c:81, code lines 81-126) ---- */
void MCRD_init(int fMultitap)

{
  int i;
  int card;
  
  blockclear(&gMemCardInfo,0x17dc);
  gMemCardInfo.ConfirmOverwriteProc = (void *)iMCRD_DefaultCBProc1;
  gMemCardInfo.ConfirmFormatProc = (void *)iMCRD_DefaultCBProc1;
  gMemCardInfo.task = NONE;
  gMemCardInfo.fMultitap = fMultitap;
  gMemCardInfo.SavingDataProc = (void *)asyncidle;
  gMemCardInfo.LoadingDataProc = (void *)asyncidle;
  MemCardInit(1);
  card = 1;
  do {
    timedwait(10);
    iMCRD_InitCard(card);
    card = card + 1;
  } while (card < 9);
  addtimer(iMCRD_timersub);
  MemCardStart();
  return;
}

/* lines 127-128: (static data / macros / comments - no emitted code) */

/* ---- iMCRD_InitCard  (memcard.c:129, code lines 129-143) ---- */
int iMCRD_InitCard(int card)

{
  CARDINFO_def *pCI;
  int ret;
  
  pCI = MCRD_getcard(card);
  if (pCI == (CARDINFO_def *)0x0) {
    ret = -1;
  }
  else {
    pCI->status = -1;
    pCI->lasterror = 0;
    pCI->numfiles = 0;
    pCI->freeblocks = 0xf;
    blockclear(pCI->dir,600);
    ret = 0;
  }
  return ret;
}

/* lines 144-173: (static data / macros / comments - no emitted code) */

/* ---- MCRD_restore  (memcard.c:174, code lines 174-178) ---- */
void MCRD_restore(void)

{
  deltimer(iMCRD_timersub);
  MemCardSync(0,(long *)0x0,(long *)0x0);
  MemCardStop();
  MemCardEnd();
  return;
}

/* lines 179-214: (static data / macros / comments - no emitted code) */

/* ---- MCRD_getopts  (memcard.c:215, code lines 215-223) ---- */
void MCRD_getopts(MCRDOPTS_def *pOPT)
{
  pOPT->productLocation = gMemCardInfo.productLocation;
  pOPT->productCode = (char *)0x0;
  pOPT->ConfirmFormatProc = gMemCardInfo.ConfirmFormatProc;
  pOPT->ConfirmOverwriteProc = gMemCardInfo.ConfirmOverwriteProc;
  pOPT->LoadingDataProc = gMemCardInfo.LoadingDataProc;
  pOPT->SavingDataProc = gMemCardInfo.SavingDataProc;
  pOPT->bMoveIconsToVram = gMemCardInfo.bMoveIconsToVram;
  pOPT->VramIconArea = gMemCardInfo.VramIconArea;   /* Ghidra emitted unaligned byte-ops; real = struct copy */
}

/* lines 224-279: (static data / macros / comments - no emitted code) */

/* ---- MCRD_setopts  (memcard.c:280, code lines 280-343) ---- */
void MCRD_setopts(MCRDOPTS_def *pOPT)

{
  /* MATCH: the productCode!=NULL body is the IF-ARM (the oracle's beqz pushes the
   * NULL case out-of-line to .L8004F634), and the region letter comes from a real
   * 3-case switch + default - gcc's balanced case tree emits the beq(1)/beqz(0)/
   * beq(2) ladder.  MATCH: N_AMERICA and default share ONE labelled body (two
   * separate 'A' bodies leave the case-0 arm storing through the cached &gMemCardInfo
   * base in $a0 while the default rematerializes its own lui, so their stores never
   * cross-jump - +1 insn).  One body puts both labels on the same block, which the
   * dispatch fall-through reaches by `j` = the oracle's shared sb %lo(...)($v1). */
  if (pOPT->productCode != (char *)0x0) {
    gMemCardInfo.productCode[0] = 'B';
    switch (pOPT->productLocation) {
    case JAPAN:
      gMemCardInfo.productCode[1] = 'I';
      break;
    case EUROPE:
      gMemCardInfo.productCode[1] = 'E';
      break;
    case N_AMERICA:
    default:
      gMemCardInfo.productCode[1] = 'A';
      break;
    }
    strncpy(gMemCardInfo.productCode + 2,pOPT->productCode,10);
    gMemCardInfo.productCode[0xc] = '\0';
    gMemCardInfo.productLocation = pOPT->productLocation;
  }
  else {
    gMemCardInfo.productCode[0] = '\0';
    gMemCardInfo.productLocation = N_AMERICA;
  }
  gMemCardInfo.ConfirmFormatProc = pOPT->ConfirmFormatProc;
  gMemCardInfo.ConfirmOverwriteProc = pOPT->ConfirmOverwriteProc;
  gMemCardInfo.LoadingDataProc = pOPT->LoadingDataProc;
  gMemCardInfo.SavingDataProc = pOPT->SavingDataProc;
  gMemCardInfo.bMoveIconsToVram = pOPT->bMoveIconsToVram;
  gMemCardInfo.VramIconArea = pOPT->VramIconArea;   /* Ghidra unaligned byte-ops; real = struct copy */
  return;
}

/* lines 344-396: (static data / macros / comments - no emitted code) */

/* ---- MCRD_loadfile  (memcard.c:397, code lines 397-432) ---- */
void MCRD_loadfile(int card,MCRDFILE_def *pFILE,int bNameHasProductCode)

{
  MCRDFILEINFO_def *pMFI;
  
  /* MATCH: everything goes through the fileinfo POINTER - the oracle anchors one
   * saved reg on &gMemCardInfo.fileinfo (small displacements, productCode at -0x25C
   * and the task/bReady base at -0x260 derived FROM it).  Writing the fields as
   * gMemCardInfo.fileinfo.X instead anchors on &gMemCardInfo and inflates every
   * displacement by 0x260. */
  pMFI = &gMemCardInfo.fileinfo;
  blockclear(pMFI,0x23c);
  pMFI->cardnum = card;
  if (bNameHasProductCode == 0) {
    strcpy(pMFI->name,gMemCardInfo.productCode);
  }
  strcat(pMFI->name,pFILE->name);
  pMFI->title = pFILE->title;
  pMFI->size = pFILE->size;
  pMFI->offset = pFILE->offset;
  pMFI->icon[0] = pFILE->icon[0];
  pMFI->icon[1] = pFILE->icon[1];
  pMFI->icon[2] = pFILE->icon[2];
  pMFI->pData = pFILE->pData;
  pFILE->numicons = &pMFI->header.type;
  pFILE->numblocks = &pMFI->header.nslots;
  gMemCardInfo.task = LOAD_FILE;
  gMemCardInfo.bReady = 0;
  return;
}

/* lines 433-434: (static data / macros / comments - no emitted code) */

/* ---- iMCRD_DoFileLoad  (memcard.c:435, code lines 435-525) ---- */
int iMCRD_DoFileLoad(int card)

{
  long cmd;
  long res;
  int i;
  int error;
  MCRDFILEINFO_def *pMFI;
  shapetbl *s;
  uchar ch;
  uchar *src;
  uint attr;
  uint attr2;

  /* MATCH: SYM (8c @0x8004f7a4) lists exactly SIX locals - cmd/res AUTO -0x30/-0x2C,
   * i REG $17($s1), error REG $2($v0), pMFI REG $18($s2), s REG $16($s0).  ONE index
   * `i` serves BOTH the title walk and the icon walk (the icon loop re-inits it to 0),
   * and ONE `error` carries both iMCRD_HandleError results; the remaining names here
   * are short-lived expression temps (no SYM record = compiler temps).
   * pMFI is the base anchor (retail derives &gMemCardInfo as pMFI-0x260).
   * The shape header's x/y clears are two BITFIELD assignments (0xF000FFFF then
   * 0xFFFFF000 off ONE lw/sw) - a single folded 0xF000F000 mask is a recon bug. */
  pMFI = &gMemCardInfo.fileinfo;
  if ((pMFI->title != (char *)0x0) || (pMFI->icon[0] != (shapetbl *)0x0)) {
    res = MemCardReadFile
                    (gMemCardInfo.channel,pMFI->name,
                     (u_long *)&pMFI->header,0,0x200);
    while (MemCardSync(1,&cmd,&res) == 0) {
      ((int(*)(void))gMemCardInfo.LoadingDataProc)();
      VSync(0);
    }
    error = iMCRD_HandleError(3,res,card);
    if (error != 0) {
      return error;
    }
    i = 0;
    if (pMFI->title != (char *)0x0) {
      while (1) {
        ch = sjis2ascii(pMFI->header.title[i]);
        pMFI->title[i] = ch;
        if (ch == '\0') break;
        i = i + 1;
      }
    }
    i = 0;
    /* MATCH: top-tested while - the exit test stays at the bottom and the
     * icon[i] load/NULL-check stay at the loop TOP; a do/while lets gcc rotate
     * the load out into the preheader (the oracle's loop label sits ON it). */
    while (i < 3) {
      s = pMFI->icon[i];
      if (s == (shapetbl *)0x0) break;
      src = pMFI->header.icon1;
      if (i != 0) {
        if (i == 1) {
          src = pMFI->header.icon2;
        }
        else {
          src = pMFI->header.icon3;
        }
      }
      blockmove(src,&s->data,0x80);
      attr = shapetype(4);
      s->type = attr;
      /* MATCH (w44, 31 -> PASS): the header word is TWO BITFIELD ASSIGNMENTS, not a
       * folded `hdr = attr & 0xff | 0x9000; *(uint *)s = hdr;` word store.  `s->next`
       * is a read-modify-write of word 0 whose load cse FORWARDS from the `s->type`
       * byte just stored - that is exactly retail's `sb $v0,0($s0); andi $v1,$v0,0xFF;
       * ori $v1,$v1,0x9000; sw $v1,0($s0)`.  Two consequences the folded form cannot
       * reach: (a) the RMW's mask lands in a FRESH pseudo (attr is still live at the
       * `and`, because its death is the byte store) so `andi` gets $v1 and the
       * offset-0xC RMW word keeps retail's $v0 - the folded form ties the whole
       * attr/mask/hdr chain into $v0 and pushes the 0xC word to $v1; (b) with the 0xC
       * word in $v0 the loop-test `slti $v0` clobbers it, so `sw $v0,0xC($s0)` can no
       * longer be a simple back-edge delay-slot filler and reorg EAGER-STEALS the loop
       * head's `sll $v0,$s1,2` instead (that is the 170th instruction; the folded form
       * measured 169).  attr is also SPLIT per block: one shared `attr` is a global
       * allocno barred from $v0/$v1 and costs a `move` per header. */
      s->next = 0x90;
      s->height = 0x10;
      s->width = 0x10;
      s->centery = 0;
      s->centerx = 0;
      s->shapey = 0;
      s->shapex = 0;
      /* MATCH: store-then-read-back of the `next` bitfield - cse forwards the
       * just-stored word (oracle `sw v1,0(s0); sra v1,v1,8`) instead of a reload,
       * AND the extra RTL insn puts the loop at 63 > the giv's worth (62), so
       * loop.c DECLINES to strength-reduce icon[i] into a walking pointer
       * (retail recomputes `sll i,2; addu` per iteration).  A `hdr` temp folds
       * the read away, drops the loop to 62 and costs a 9th callee-saved reg. */
      s = (shapetbl *)((int)s + s->next);
      blockmove(pMFI->header.iconclut,&s->data,0x20);
      attr2 = cluttype(0x10);
      s->type = attr2;
      i = i + 1;
      s->width = 0x10;
      s->height = 1;
      s->centery = 0;
      s->centerx = 0;
      s->next = 0;
      s->shapey = 0;
      s->shapex = 0;
    }
  }
  if (pMFI->size != 0) {
    res = MemCardReadFile
                    (gMemCardInfo.channel,pMFI->name,
                     (u_long *)pMFI->pData,pMFI->offset + 0x200,
                     pMFI->size);
    if (res == 0) {
      gMemCardInfo.bReady = 1;
      return 0x10;
    }
    while (MemCardSync(0,&cmd,&res) == 0) {
    }
    error = iMCRD_HandleError(3,res,card);
    if (error != 0) {
      return error;
    }
  }
  gMemCardInfo.bReady = 1;
  return 0xf;
}

/* lines 526-662: (static data / macros / comments - no emitted code) */

/* ---- MCRD_savefile  (memcard.c:663, code lines 663-748) ---- */
int MCRD_savefile(int card,MCRDFILE_def *pFILE)

{
  u_short sjis;
  uint len;
  uchar *clut;
  int i;
  int nIcons;
  MCRDFILEINFO_def *pMFI;

  /* MATCH: pMFI is the function's base anchor (retail keeps &gMemCardInfo.fileinfo
   * in a saved reg; productCode is reached at -0x25C off it).  Also: getshapeclut
   * takes ONE argument (its own oracle never reads $a1) - the 2nd arg was a
   * fabricated Ghidra leftover that also forced a spare saved reg for pFILE->name. */
  pMFI = &gMemCardInfo.fileinfo;
  if ((pFILE->size & 0x7fU) != 0) goto MCRDsave_errorDefault;
  {
    blockclear(pMFI,0x23c);
    pMFI->header.magicnumber[0] = 'S';
    pMFI->header.magicnumber[1] = 'C';
    strcpy(pMFI->name,gMemCardInfo.productCode);
    strcat(pMFI->name,pFILE->name);
    pMFI->cardnum = card;
    pMFI->size = pFILE->size;
    pMFI->flags = pFILE->flags;
    pMFI->offset = pFILE->offset;
    pMFI->pData = pFILE->pData;
    i = 0;
    if ((pFILE->flags & 0x200) != 0) {
      nIcons = 0;
      do {
        if (pFILE->icon[i] != (shapetbl *)0x0) {
          nIcons = nIcons + 1;
        }
        i = i + 1;
      } while (i < 3);
      if (nIcons == 0) {
        return -1;
      }
      pMFI->header.type = (char)nIcons + '';
      /* MATCH: a plain signed divide - retail's bgez/addiu 0x3FFF/sra 13 is gcc's
       * own /0x2000 guard, not a hand-written rounding branch. */
      pMFI->header.nslots = (uchar)((pFILE->size + 0x2000) / 0x2000);
      if (pFILE->title == (char *)0x0) {
        return -1;
      }
      len = strlen(pFILE->title);
      if (len == 0) {
        return -1;
      }
      len = strlen(pFILE->title);
      /* MATCH: the -1 must be the FALL-THROUGH of this test (retail's shared
       * error block sits right here and the head's size-check jumps INTO it via
       * cross-jump); a goto to a tail label puts the block at the end instead. */
      if (0x20 < len) {
MCRDsave_errorDefault:
        return -1;
      }
      i = 0;
      do {
        sjis = ascii2sjis(pFILE->title[i]);
        pMFI->header.title[i] = sjis;
        if (sjis == 0) break;
        i = i + 1;
      } while (i < 0x20);
      clut = getshapeclut(pFILE->icon[0]);
      blockmove(clut + 0x10,pMFI->header.iconclut,0x20);
      blockmove(&pFILE->icon[0]->data,pMFI->header.icon1,0x80);
      if (1 < nIcons) {
        blockmove(&pFILE->icon[1]->data,pMFI->header.icon2,0x80);
        if (nIcons == 3) {
          blockmove(&pFILE->icon[2]->data,pMFI->header.icon3,0x80);
        }
      }
    }
    gMemCardInfo.task = WRITE_FILE;
    gMemCardInfo.bReady = 0;
    return 0;
  }
}

/* lines 749-750: (static data / macros / comments - no emitted code) */

/* ---- iMCRD_DoFileWrite  (memcard.c:751, code lines 751-853) ---- */
int iMCRD_DoFileWrite(int card)

{
  int error;
  int err_state;
  long sync_done;
  int err;
  long sync;
  MCRDFILEINFO_def *pMFI;
  long cmd;
  long res;
  
  /* MATCH: the SYM's pMFI is the function's base anchor - the oracle keeps
   * &gMemCardInfo.fileinfo in a saved reg and derives &gMemCardInfo from it
   * (-0x260) for .channel; writing gMemCardInfo.fileinfo.X anchors the other way
   * and inflates every displacement by 0x260. */
  pMFI = &gMemCardInfo.fileinfo;
  if ((pMFI->flags & 0x200) != 0) {
    res = MemCardCreateFile
                    (gMemCardInfo.channel,pMFI->name,
                     (uint)pMFI->header.nslots);
    err_state = iMCRD_HandleError(2,res,card);
    if (err_state != 0) {
      return err_state;
    }
    timedwait(0x40);
    res = MemCardWriteFile
                    (gMemCardInfo.channel,pMFI->name,
                     (u_long *)&pMFI->header,0,0x200);
    if (res == 0) {
      gMemCardInfo.bReady = 1;
      return 0xd;
    }
    do {
      sync_done = MemCardSync(0,&cmd,&res);
    } while (sync_done == 0);
    err = iMCRD_HandleError(2,res,card);
    if (err != 0) {
      return err;
    }
  }
  res = MemCardWriteFile
                  (gMemCardInfo.channel,pMFI->name,
                   (u_long *)pMFI->pData,pMFI->offset + 0x200,
                   pMFI->size);
  if (res == 0) {
    gMemCardInfo.bReady = 1;
    return 0xd;
  }
  do {
    sync = MemCardSync(0,&cmd,&res);
  } while (sync == 0);
  err = iMCRD_HandleError(2,res,card);
  if (err == 0) {
    gMemCardInfo.bReady = 0;      /* MATCH: retail stores bReady BEFORE task here */
    gMemCardInfo.task = LOAD_CARD;
    return 0xc;
  }
  return err;
}

/* lines 854-904: (static data / macros / comments - no emitted code) */

/* ---- iMCRD_DoFileDelete  (memcard.c:905, code lines 905-929) ---- */
int iMCRD_DoFileDelete(int card)

{
  long del_res;
  CARDINFO_def *pcard;
  MCRDFILEINFO_def *pMFI;
  int retval;
  int ret_state;
  
  ret_state = 0x11;
  pMFI = &gMemCardInfo.fileinfo;   /* MATCH: SYM local; la(+0x260) anchor, name=+4, base=-0x260 */
  del_res = MemCardDeleteFile(gMemCardInfo.channel,pMFI->name);
  switch (del_res) {
  case 0:
    gMemCardInfo.task = LOAD_CARD;
    break;
  case 5:
    pcard = MCRD_getcard(card);
    ret_state = 0x12;
    pcard->lasterror = 0x13;
    gMemCardInfo.bReady = 1;
  }
  return ret_state;
}

/* lines 930-970: (static data / macros / comments - no emitted code) */

/* ---- MCRD_handlecardevents  (memcard.c:971, code lines 971-1168) ---- */
int MCRD_handlecardevents(int card)

{
  /* SYM 8c block (the COMPLETE local set - no others exist in retail):
   *   card   REGPARM INT   $11 = $s1      status INT           $10 = $s0
   *   pCI    PTR CARDINFO  $12 = $s2      ret    INT           $03 = $v1
   *   cmd/res ULONG AUTO   sp-0x18 / sp-0x14
   * `ret` is the MemCardSync return; `status` is the value the funnel returns. */
  CARDINFO_def *pCI;
  int ret;
  int status;
  u_long cmd;
  u_long res;

  /* MATCH: ONE result variable + a single tail `return status;` - every retail exit is
   * `j .L800501B0/B4; addu $v0,$s0,$zero`, i.e. a funnel, never a direct return
   * literal.  Keeping status in $s0 is also what lets cse reuse the constant 2 as the
   * shift amount in the res==1 arm (retail's `sllv v0,v0,s0`). */
  /* RESIDUAL 44 (209/211), THREE parts, two of them one mechanism:
  /* ============================ RESIDUAL: 2 (211/211) ============================
   * w45 RESULT: 56 -> 2 diffs, count exact.  The whole 56 was ONE root cause plus
   * two consequences, all three cracked by the gcc-2.8 REF/PRIORITY model:
   *
   * (1) $a0 HANDOUT (global_alloc).  global.c allocates in descending
   *     allocno_compare priority = floor_log2(refs)*refs/live_length.  Measured
   *     off cc1 -dg/-dl (tools/rtl_dump_c.py + tools/prio.py):
   *        p144 cmd  = 7 refs / 20 live -> 2*7/20 = .700   rank 2  -> took $a0
   *        p92  base = 4 refs / 22 live -> 2*4/22 = .364   rank 12 -> got $a1
   *     (&gMemCardInfo base of the res==0 arm).  Retail is the other way round.
   *     BOUNDARY MATH (the thing to do FIRST): p92 wins iff 4 refs & live <= 11,
   *     or 5 & <=14, or 6 & <=17, or 7 & <=19, or **8 refs at any live <= 34**
   *     (the floor_log2 step 2->3).  p144 loses iff 7 refs & live >= 39, or its
   *     refs fall to <= 3.  cmd's 7 refs and 20-insn range are structural (the
   *     dispatch + the three `bReady = cmd` stores, which cse rewrites back to
   *     cmd's reg because cmd==1 is known inside `case 1:`), so the base side is
   *     the only reachable one.  FIX = the two nested do{}while(0) around the
   *     res==0 arm (flow.c does REG_N_REFS += loop_depth): base 4 -> 12 refs
   *     (pri 1.636, rank 0) vs cmd 7 -> 9 (1.350).  DEPTH 3 IS REQUIRED: depth 2
   *     lifts BOTH to 8 refs and cmd's shorter live range then wins 1.200 vs
   *     1.091.  (This refutes the w44 note that recorded depth 3 as "wrecks the
   *     arm, 202 diffs".)                                      56 -> 28
   * (2) THE SAME DIAL AT THE LOCAL_ALLOC LAYER for the res==1 arm, whose base and
   *     timerhz are block-local QTYs, not allocnos - local-alloc.c's QTY_CMP_PRI
   *     is literally the same formula.  One do{}while(0) on the tick store alone
   *     doubles timerhz past the flr2 step (4 -> 8) while the base only picks up
   *     its addu ref (5 -> 6).                                 28 -> 16
   * (3) The 2026-08-02 USE fence at the cmd-switch join was BASIN-RELATIVE
   *     scaffolding and is now retired (receipt at its old site).  Removing it
   *     also restored reorg's fill of four `j` delay slots. 16 -> 4
   * (4) Retail's .L800500D8 trampoline: a ZERO-INSN USE fence on `status` ($s0)
   *     in an `else` arm of the NONE guard (receipt at that site).   4 -> 2
   *
   * ---------------- PARKED (2 diffs) + THE NEXT NAMED ANGLE ----------------
   * Residual = the res==1 arm's `sw a1,0x34($a0)` (bReady) emitted 5 slots EARLY:
   *     ours    lui/addiu a0 | sw a1,52(a0) | index | lw timerhz | addu | sw v1
   *     retail  lui/addiu a0 | index | lw timerhz | addu | sw a1,52(a0) | sw v1
   * Everything else in the arm is byte-identical.  MECHANISM: the do{}while(0)
   * that supplies (2)'s ref dial puts a NOTE_INSN_LOOP_BEG *between* the two
   * stores, and that note is a sched2 barrier - the res==0 arm proves the
   * scheduler WANTS retail's order when it is not fenced off (that arm, wrapped
   * as one span, matches byte for byte).
   * MEASURED / FALSIFIED (~180 spellings, all gate-verified, TU-clean):
   *   - all 24 statement orders x {no wrapper, d2 on tick, d3 on tick, d2 whole
   *     + d2 inner} -> best 2 (BSTP/SBTP/STBP with the tick wrapper);
   *   - wrapper spanning BOTH stores at depth 1/2/3 x inner tick depth 0/1/2:
   *     source order tick-then-bReady reaches the SAME 2 diffs with the barrier
   *     GONE and the registers right - but then sched2 emits the two stores in
   *     RTL order (`sw v1` then `sw a1`), the exact mirror of our miss;
   *     source order bReady-then-tick with a spanning wrapper loses the QTY order
   *     (14-54 diffs);
   *   - non-loop ref inflators on timerhz: USE fences 1..4x and a 4-operand asm
   *     (17-24, each costs an insn), duplicate idempotent tick stores x2/x3/x4
   *     (14, dse drops the copy AND the ref), `*(&arr[i])` spelling (17);
   *   - base live-length extenders: `__asm__ "r"(&gMemCardInfo)` at the arm tail
   *     (14; the address does NOT cse onto the base pseudo, it costs a real
   *     addiu - measured twice, in both the allocno and the QTY context);
   *   - 12 interleavings of the three stores/PCI inside and outside the wrapper.
   * => THE ANGLE (untried, concrete): the tick-first spanning-wrapper form
   *    (`case 1: status=2; do{do{do{ tick; bReady; }}}while(0); pCI->status=-1;`)
   *    is ONE sched2 READY-LIST TIE from PASS - registers correct, barrier gone,
   *    only the two independent stores' emission order wrong.  That is the w44
   *    "ready-list DRAIN point" family: the dial is +-1 RTL insn released late in
   *    the block.  Concretely: (a) lengthen the `lw timerhz` -> `sw v1` dependence
   *    so `sw a1` becomes the only ready insn after the addu (move the timerhz
   *    load's producer adjacent to the addu); (b) give the bReady store a
   *    different RTL PATTERN via the storage-shape menu (bitfield / sized-[1] view
   *    of gMemCardInfo, w44 six-form menu) so its sched cost differs from the
   *    tick store's; (c) permuter from THAT basin (not this one) - it is a
   *    2-insn ready-list pick, exactly what the permuter cracked on SNDplaysetdef.
   *    NOT a floor: two independent spellings already sit 1 tie-break away on
   *    opposite sides.
   * ============================================================================
   * ORIGINAL SYM/shape receipts (still authoritative, do not regress):
   *   - ONE result variable + a single tail `return status;` (every retail exit is
   *     `j .L800501B0/B4; addu $v0,$s0,$zero`, a funnel, never a return literal);
   *     keeping status in $s0 is also what lets cse reuse the constant 2 as the
   *     shift amount in the res==1 arm (retail's `sllv v0,v0,s0`).
   *   - w44 falsifications that remain falsified: named fMemCardInfo_def* base
   *     local (early/late/for every field); channel read hoisted into a local;
   *     `bReady = 1` instead of `= cmd` (byte-identical - cse reuses cmd's reg);
   *     an early cmd read to lengthen its range (folded); cmd dispatch as an
   *     if/else-if chain (-2 insns); an INVENTED `int st = pCI->status;` local
   *     (moves the dial but the SYM lists no such local -> rule 8).  */
  status = 0x17;
  pCI = MCRD_getcard(card);
  ret = MemCardSync(0,(long *)&cmd,(long *)&res);
  if (ret == 0) {
    status = 0x15;
    goto MCRDhandleCard_end;
  }
  /* MATCH: physical block order - retail lays the ret>0 (cmd/res) half FIRST and
   * the task switch last; `if (ret <= 0) {...} else {cmd half}` makes the cmd half
   * the bgtz target and pushes the task switch past it. */
  if (ret <= 0) {
    if (ret == -1) goto MCRDhandleCard_task;
    goto MCRDhandleCard_end;
  }
  else {
    if (ret != 1) goto MCRDhandleCard_end;
    switch(cmd) {
    case 1:
      switch(res) {
      case 0:
        /* MATCH (w45): DEPTH-3 REF DIAL -- the two nested do{}while(0) wrappers are a
         * semantic no-op that exist ONLY to loop-weight this arm's references x3 in
         * flow.c (REG_N_REFS += loop_depth).  They flip the $a0 caller-save handout:
         * the &gMemCardInfo base pseudo goes 4 refs/22 live (pri .364, rank 12, lost
         * $a0 to cmd) -> 12 refs/22 live (pri 1.636, rank 0, TAKES $a0), while cmd
         * only reaches 9/20 = 1.350 (its other 6 refs are outside the wrapper).
         * allocno_compare priority = floor_log2(refs)*refs/live_length, so the win
         * needs the flr2 STEP at 8 refs -- depth 2 gives base 8 (1.091) but ALSO
         * lifts cmd to 8 (1.200) and loses.  56 -> 28 diffs, count stays 211/211.
         * (This REFUTES the w44 receipt below, which recorded depth 3 as "wrecks the
         * arm (202 diffs)" -- that measurement must have wrapped a different span.)
         * DO NOT "simplify" the wrappers away.
         * (w45 re-measure from the FINAL basin: ONE wrapper also gates 2 diffs,
         * but there cmd still OUTRANKS the base (1.200 vs 1.091) and only wins
         * $a1 through a conflict/preference accident -- the two-wrapper form is
         * the rank-EXPLAINED one (base rank 0 @1.636, cmd rank 2 @1.350), so it
         * is the one kept.  Three or four wrappers regress to 54.) */
        do { do {
        gMemCardInfo.bReady = cmd;
        gMemCardInfo.existencecheckticks[card + -1] = timerhz;
        status = 0x16;
        if (pCI->status == -1) {
          MemCardAccept(gMemCardInfo.channel);
        }
        } while (0); } while (0);
        break;
      case 1:
        /* MATCH (w45): the SAME ref dial, one level, at the LOCAL_ALLOC layer.
         * local-alloc.c uses the IDENTICAL priority (QTY_CMP_PRI =
         * floor_log2(n_refs)*n_refs*size/(death-birth)) and this arm is one basic
         * block, so its base/timerhz quantities are QTYs, not global allocnos.
         * Un-wrapped, the &gMemCardInfo base outranks the timerhz value and takes
         * the lower reg ($v1), pushing timerhz to $a0 -- retail is the other way
         * round ($a0 base, $v1 timerhz).  Wrapping ONLY the tick store doubles
         * timerhz's refs (4->8, over the flr2 step) while the base picks up just
         * its addu ref (5->6), inverting the QTY order.  28 -> 16 diffs. */
        status = 2;
        gMemCardInfo.bReady = cmd;
        do {
        gMemCardInfo.existencecheckticks[card + -1] = timerhz;
        } while (0);
        pCI->status = -1;
        break;
      case 2:
        status = 3;
        gMemCardInfo.bReady = cmd;
        pCI->status = -4;
        break;
      case 3:
        status = 0x15;
        MemCardAccept(gMemCardInfo.channel);
        break;
      default:
        status = 0x17;
        break;
      }
      break;
    case 2:
      switch(res) {
      case 0:
      case 3:
        status = 4;
        gMemCardInfo.fileinfo.cardnum = card;
        gMemCardInfo.task = LOAD_CARD;
        break;
      case 1:
        iMCRD_InitCard(card);
        pCI->status = -1;
        status = 2;
        break;
      case 2:
        iMCRD_InitCard(card);
        status = 3;
        break;
      case 4:
        pCI->status = -2;
        status = 5;
        break;
      }
      break;
    }
    /* w45 RETIRED LEVER (kept as a receipt, do NOT re-add): a
     * `__asm__ volatile("" : : "r"(cmd));` USE fence sat here from 2026-08-02.
     * It was a cross-jump BLOCKER -- its USE insn made this exit path differ
     * from the sibling tails so cross_jump could not merge them, which
     * materialised retail's un-merged 2-insn reorg trampoline and took the
     * count 209 -> exact 211/211 (at 44 -> 56 diffs).  Once the $a0 handout was
     * fixed by the ref dials above, the fence became PURE COST: it is a stack
     * AUTO, so "r"(cmd) emits a real `lw a3,0x10($sp)`, it un-merges the WRONG
     * tail (the cmd==2/res==4 arm instead of retail's .L800500D8), and it also
     * suppressed reorg's fill of four `j` delay slots.  MEASURED post-dial:
     * fence-on-cmd 16 diffs / 211 insns, fence-on-status or -pCI 15 / 210,
     * NO FENCE 4 diffs / 209.  Removed.  (LEVER-ORDER-DEPENDENCE meta: a
     * spelling is only falsified inside its basin -- and so is a WINNER.) */
    goto MCRDhandleCard_end;
  }
MCRDhandleCard_task:
  /* MATCH: every dispatch here is a real SWITCH with OUT-OF-LINE case bodies
   * (retail's beq-to-arm ladders); an if/else-if chain inlines each arm and flips
   * the branches to bne.  res is unsigned, so gcc omits the low bound test on
   * case 0.  Case bodies emit in SOURCE order = the oracle's block VA order. */
  switch(gMemCardInfo.task) {
  case NONE:
    status = 0x16;
    if (gMemCardInfo.existencecheckticks[card + -1] < 0) {
      gMemCardInfo.bReady = 0;
      status = 0x17;
      if (MemCardExist(gMemCardInfo.channel) == 0) goto MCRDhandleCard_end;
      status = 0x15;
    } else {
      /* MATCH (w45): ZERO-INSN USE FENCE as a CROSS-JUMP BLOCKER.  `status` lives
       * in $s0, so "r"(status) emits no instruction -- its only effect is to make
       * this else-arm's tail textually different from the plain `return status;`
       * funnel, so cross_jump cannot fold it in.  What survives is retail's shared
       * 2-insn trampoline .L800500D8 (`j <epilogue>; addu $v0,$s0,$zero`), which
       * is ALSO the target of the res==0 arm's `bne pCI->status,-1` -- gcc merges
       * the two un-mergeable exits with EACH OTHER.  Count 209 -> exact 211/211.
       * The polarity matters: the fence must hang in an `else` (keeping the guard
       * `bgez`), NOT on an inverted `if (ticks >= 0) {...}` -- that makes the exit
       * the FALL-THROUGH, flips the branch to `bltz` and inlines the block (8). */
      __asm__ volatile("" : : "r"(status));
    }
    break;
  case LOAD_CARD:
    if (card != gMemCardInfo.fileinfo.cardnum) goto MCRDhandleCard_end;
    pCI->lasterror = 0;
    gMemCardInfo.bReady = 0;
    gMemCardInfo.task = NONE;
    return iMCRD_LoadCard(card);
  case WRITE_FILE:
    if (card != gMemCardInfo.fileinfo.cardnum) goto MCRDhandleCard_end;
    pCI->lasterror = 0;
    gMemCardInfo.bReady = 0;
    gMemCardInfo.task = NONE;
    return iMCRD_DoFileWrite(card);
  case LOAD_FILE:
    if (card != gMemCardInfo.fileinfo.cardnum) goto MCRDhandleCard_end;
    pCI->lasterror = 0;
    gMemCardInfo.bReady = 0;
    gMemCardInfo.task = NONE;
    return iMCRD_DoFileLoad(card);
  case DELETE_FILE:
    if (card != gMemCardInfo.fileinfo.cardnum) goto MCRDhandleCard_end;
    pCI->lasterror = 0;
    gMemCardInfo.bReady = 0;
    gMemCardInfo.task = NONE;
    return iMCRD_DoFileDelete(card);
  }
MCRDhandleCard_end:
  return status;
}

/* lines 1169-1311: (static data / macros / comments - no emitted code) */

/* ---- MCRD_fileexists  (memcard.c:1312, code lines 1312-1377) ---- */
int MCRD_fileexists(int card,char *name)

{
  CARDINFO_def *pCard;
  int cmp;
  int i;
  DIRENTRY *pDir;
  DIRENTRY *s1;
  char fullname [24];
  
  pCard = MCRD_getcard(card);
  s1 = pCard->dir;
  strcpy(fullname,gMemCardInfo.productCode);
  strcat(fullname,name);
  i = 0;
  do {
    cmp = strcmp((char *)s1,fullname);
    if (cmp == 0) {
      return i;
    }
    i = i + 1;
    s1 = s1 + 1;
  } while (i < 0xf);
  return -1;
}

/* lines 1378-1535: (static data / macros / comments - no emitted code) */

/* ---- iMCRD_timersub  (memcard.c:1536, code lines 1536-1541) [static] ---- */
void iMCRD_timersub(void)

{
  int i;
  
  i = 0;
  do {
    gMemCardInfo.existencecheckticks[i] = gMemCardInfo.existencecheckticks[i] + -1;
    i = i + 1;
  } while (i < 8);
  return;
}

/* lines 1542-1543: (static data / macros / comments - no emitted code) */

/* ---- garyMemCardGrabBlocks  (memcard.c:1544, code lines 1544-1561) ---- */
int garyMemCardGrabBlocks(int card,int filenum)

{
  CARDINFO_def *pCI;
  int i;
  int size;
  DIRENTRY *pDir;
  DIRENTRY *dir;
  
  pCI = MCRD_getcard(card);
  dir = pCI->dir;
  MemCardGetDirentry(gMemCardInfo.channel,"*",dir,&pCI->numfiles,0,0xf);
  i = 0;
  if (0 < filenum) {
    do {
      i = i + 1;
      dir = dir + 1;
    } while (i < filenum);
  }
  size = dir->size;
  if (size < 0) {
    size = size + 0x1fff;
  }
  return size >> 0xd;
}

/* lines 1562-1565: (static data / macros / comments - no emitted code) */

/* ---- iMCRD_LoadCard  (memcard.c:1566, code lines 1566-1693) ---- */
int iMCRD_LoadCard(int card)

{
  int error;
  CARDINFO_def *pcard;
  int i_or_size;
  int ret_state;
  long opResult;
  int size;
  int slot;
  DIRENTRY *pDir;
  DIRENTRY *dir;
  CARDINFO_def *pCI;
  
  pcard = MCRD_getcard(card);
  dir = pcard->dir;
  i_or_size = iMCRD_InitCard(card);
  if (i_or_size != 0) {
    ret_state = 0xb;
  }
  else {
    opResult = MemCardGetDirentry
                         (gMemCardInfo.channel,"*",dir,&pcard->numfiles,0,0xf);
    ret_state = iMCRD_HandleError(1,opResult,card);
    slot = 0;
    if (ret_state == 0) {
      do {
        if (dir->name[0] != '\0') {
          size = dir->size;
          if (size < 0) {
            size = size + 0x1fff;
          }
          pcard->freeblocks = pcard->freeblocks - (size >> 0xd);
        }
        slot = slot + 1;
        dir = dir + 1;
      } while (slot < 0xf);
      if (pcard->freeblocks == 0) {
        pcard->status = -3;
      }
      else {
        pcard->status = 0;
      }
      gMemCardInfo.bReady = 1;
      ret_state = 9;
    }
  }
  return ret_state;
}

/* lines 1694-1695: (static data / macros / comments - no emitted code) */

/* ---- iMCRD_FormatCard  (memcard.c:1696, code lines 1696-1732) ---- */
int iMCRD_FormatCard(int card)

{
  CARDINFO_def *pCI;
  long fmtRes;
  int result;
  
  result = 0;
  pCI = MCRD_getcard(card);
  fmtRes = MemCardFormat(gMemCardInfo.channel);
  /* MATCH: a real switch WITH the empty success case (0).  THREE case nodes is
   * what makes gcc-2.8's balance_case_nodes split the list at the middle, so the
   * root (1) gets BOTH children; emit_case_nodes' "neither subtree bounded" arm
   * then emits the discriminating compare, and jump.c collapses the empty
   * case-0 subtree into the default + inverts it -> the oracle's
   *     beq ==1 / slti $v0,$v1,2 / bnez -> default / beq ==2 / j default.
   * A plain 2-case switch keeps the list LINEAR (balance_case_nodes only splits
   * when i > 2), the root has a right child only, and emit_case_nodes takes the
   * "handle node->right explicitly" else-arm = two bare beq's, NO bound test. */
  switch (fmtRes) {
  case 0:
    break;
  case 1:
    pCI->status = -1;
    result = -1;
    break;
  case 2:
    pCI->status = -4;
    result = -1;
    break;
  }
  pCI->status = 0;
  pCI->freeblocks = 0xf;
  return result;
}

/* lines 1733-1736: (static data / macros / comments - no emitted code) */

/* ---- iMCRD_HandleError  (memcard.c:1737, code lines 1737-1895) ---- */
int iMCRD_HandleError(int func,int opResult,int card)

{
  int scratch_i;
  int tmp_int;
  CARDINFO_def *pCI;
  fMemCardInfo_def *gmi;
  int code;

  /* MATCH: SYM (8c @0x800504cc) lists FOUR locals - code REG $20($s4), pCI REG $17($s1),
   * and a NESTED block (90 @0x800505f4 .. 92 @0x80050644, source lines 76-98) holding
   * numberoftries REG $16($s0) and result REG $3($v1).  numberoftries takes func's own
   * $s0 because it is block-local and func is dead by then; declaring it at function
   * scope makes it a global allocno that can never reuse that register.
   *
   * RESIDUAL 22 (count EXACT 135/135) = ONE allocno-order inversion: retail gives
   * $s3 to `card` (SYM REGPARM $0x13) and $s4 to `code` (SYM REG $0x14); we give
   * $s3 to `code`.  FULLY QUANTIFIED from -dl/-dg (w44):
   *   allocno_compare priority = floor_log2(refs)*refs/live_length
   *   ours  code = 2*5/93 = .1075  >  card = 2*4/88 = .0909  -> code allocated first
   * The whole -dg order (102 84 103 86 83 80 85 104 81 87 82) reproduces exactly, so
   * the model is confirmed and the razor is: card needs ONE more weighted ref (2*5/88
   * = .1136), or live_length <= 74, or code must drop to 4 refs / grow past 110 insns.
   * Retail's ref counts are IDENTICAL to ours (oracle $s3: 1 def + 2 uses, one of them
   * in the retry loop = 4 weighted; $s4: 1 zero-init + 3 arms + 1 return read = 5), so
   * the divergence is in live_length or in loop-note placement, not in the source's
   * reference structure.
   * PROVEN CARRIER (diagnostic, NOT adopted - it is scaffolding): wrapping the
   * FormatCard call in a `do { } while (0)` raises its loop depth, giving card the
   * 5th weighted ref -> the rotation flips and the fn drops to 4 diffs (135/135, the
   * only residual then being the numberoftries-zero-init position + one delay slot).
   * FALSIFIED carriers (each measured): while(1)+break / for+break / call-in-condition
   * / goto-loop loop spellings (all 22, all 135 insns); `register int card` (22);
   * decl-order per SYM (22); `int code = 0` declarator init (22); duplicate `code = 0`
   * (22, deleted); code=0 after the getcard call (22); merging scratch_i/tmp_int (22);
   * un-funnelling the case-3 else arm to `return code` (27 - REFUTES that angle);
   * a block-local copy of card for the loop (39); purging the `failed` sentinel (52);
   * swapping the two loop-init statements (54).
   * NEXT ANGLE: find a zero-instruction 5th `card` reference - the phantom-ref classes
   * (cse-merged duplicate subexpression, cross-jump-merged duplicate insn) are the only
   * known ones that add REG_N_REFS without adding an instruction; or shorten card's
   * live range by 14 insns (it is live in blocks 1-12 and 18-22 per -dl).
   * RESOLVED (w44): the loop-depth ref dial in the retry loop below supplies the
   * 5th weighted `card` ref at zero instruction cost - card .1136 > code .1075 ->
   * card $s3 / code $s4 = SYM-exact.  22 -> 4 diffs (135/135 count-exact).
   * REMAINING 4 = a SECOND, independent one-rank inversion plus its delay slot:
   *   failed(sentinel) 3 refs / 16 live -> .1875   vs   pCI 7 refs / 79 live -> .1772
   * Retail materializes `numberoftries = 0` FIRST (reorg eager-steals the
   * fall-through's first insn into the `beqz` slot); writing it first in source does
   * exactly that, but it also shortens the sentinel's live range to 16, which lifts
   * it above pCI and rotates $s1<->$s2 through the whole function (36 diffs).  The
   * two are COUPLED: sentinel-first = right registers / wrong slot (4 diffs);
   * numberoftries-first = right slot / wrong registers (36).
   * NEXT ANGLE: decouple by promoting pCI to 8 weighted refs (2*8/79 = .2025 >
   * .1875) with a ZERO-INSN ref inflator (a10's class: a cse-folded re-mask or a
   * folded re-read of a pCI-based lvalue), or by lengthening the sentinel's live
   * range to >= 17 WITHOUT moving its materialization (3/17 = .1765 < .1772 - a
   * ONE-INSN razor).  Falsified for the decoupling: post-loop `result != failed`
   * (41/132); sentinel hoisted above the confirm call (5/134 - it then lands in the
   * jalr delay slot instead of the beqz slot); increment-before-call (38); Yoda loop
   * condition (36); declarator-init permutations x4 (36); decl-order x3 (36-40). */
  code = 0;
  pCI = MCRD_getcard(card);
  /* MATCH: a real switch - the oracle's beq(2)/slti BOUND/beq(1)/beq(3) ladder with
   * the three arms out-of-line is gcc's balance_case_nodes tree; the equivalent
   * if/else-if chain inlines each arm and flips every branch to bne. */
  if (opResult != 0) {
    switch (func) {
    case 1:
      code = 10;
      break;
    case 2:
      code = 0xd;
      break;
    case 3:
      code = 0x10;
      break;
    }
  }
  switch(opResult) {
  case 0:
    goto iMCRDError_return;
  case 1:
    pCI->status = -1;
    tmp_int = 2;
    break;
  case 2:
    pCI->status = -4;
    tmp_int = 3;
    break;
  case 3:
    /* MATCH: the accept==0 arm is the IF-BODY (fall-through) - retail's bnez sends
     * the success arm out-of-line. */
    /* MATCH (w44, -1 insn): retail reaches gMemCardInfo through ONE pseudo that both
     * predecessors of the setLastError join define ($s0 in both the case-3 and case-6
     * arms), so the join's `bReady = 1` store reuses it (`sw $v0,52($s0)`); a direct
     * `gMemCardInfo.bReady` there rematerializes the address (`lui`) at the join.
     * Assign the base PER-BLOCK (uninitialized decl + one assignment per arm) - a
     * function-scope initialized pointer would be GCSE-hoisted to one materialization. */
    gmi = &gMemCardInfo;
    if (MemCardAccept(gmi->channel) == 0) {
      scratch_i = 0x17;
      goto iMCRDError_setLastError;
    }
    else {
      gmi->task = LOAD_CARD;
      gmi->bReady = 0;
      goto iMCRDError_return;
    }
  case 4:
    if (func == 2) {
      if (((int(*)(void))gMemCardInfo.ConfirmFormatProc)() != 0) {
        /* MATCH: SYM nested block - numberoftries/result live only here. */
        int numberoftries;
        int result;
        int failed;   /* MATCH: the -1 sentinel loop.c hoists out of the retry test.
                       * As a bare literal it becomes a short-lived hoisted allocno
                       * whose priority (3 refs / 16 insns) beats pCI's and steals
                       * $s1; naming it lengthens its live range so pCI wins $s1 and
                       * the sentinel shares opResult's dead $s2, as retail does. */

        numberoftries = 0;   /* MATCH: written FIRST so reorg eager-steals it into the
                              * beqz delay slot (retail's pick); the register coupling
                              * this used to break is resolved by the pCI depth dial at
                              * the lasterror join below. */
        failed = -1;
        /* MATCH: the retry test is the loop CONDITION, not an in-body early return -
         * retail's `bne result,sentinel` short-circuits straight to the success block
         * (the -1 sentinel is loop-invariant, hoisted into a saved reg), and the
         * loop-exhausted path is decided by a SECOND `result == -1` compare after the
         * loop against a freshly materialized -1.  An in-body `if (result != -1)
         * return 6;` drops that second compare entirely (census beq 3v4).
         * Success is the FALL-THROUGH of that second compare (retail `beq` sends the
         * exhausted path out-of-line, physically AFTER the success block). */
        do {
          /* MATCH (w44, 22 -> 4): LOOP-DEPTH REF DIAL.  REG_N_REFS is loop-depth
           * weighted, so this inner scope doubles the weight of the refs inside it
           * at ZERO instruction cost.  It is the one dial that reconciles retail's
           * own register map with allocno_compare: `card` reaches 5 weighted refs
           * (2*5/88 = .1136) and finally outranks `code` (2*5/93 = .1075), so card
           * takes $s3 and code $s4 exactly as the SYM says (REGPARM $0x13 / REG
           * $0x14).  Without it the whole card/code pair is rotated (18 diff lines).
           * Remove this scope to fall back to the honest 22-diff form. */
          do {
            result = iMCRD_FormatCard(card);   /* MATCH: fresh pseudo for the call result */
          } while (0);
          /* MATCH (4 -> seal attempt): the success exit is an in-body GOTO PAST the
           * post-loop compare, so retail's `bne result,sentinel` lands on the success
           * block's `lui` and LABELS it - reorg then cannot steal that lui into the
           * `beq` delay slot (nop stays), while the post-loop -1 materialization is
           * stolen into the loop-back bnez slot.  A plain loop-condition exit lands
           * ON the compare, leaves the lui unlabeled, and reorg fills the wrong slot. */
          if (result != failed) goto iMCRDError_formatOK;
          numberoftries = numberoftries + 1;
        } while (numberoftries < 3);
        if (result != -1) {
          /* MATCH: label INSIDE the if-block - keeps retail's polarity (beq sends the
           * ==-1 exhausted path to the out-of-line fail arm, success = fall-through). */
iMCRDError_formatOK:
          gMemCardInfo.task = WRITE_FILE;
          return 6;
        }
        pCI->status = -2;
        tmp_int = 7;
        break;
      }
    }
    pCI->status = -2;
    tmp_int = 5;
    break;
  case 5:
    tmp_int = 0x13;
    break;
  case 6:
    gmi = &gMemCardInfo;
    if (((int(*)(void))gmi->ConfirmOverwriteProc)() != 0) {
      MemCardDeleteFile(gmi->channel,gmi->fileinfo.name);
      gmi->task = WRITE_FILE;
      return 0x15;
    }
    scratch_i = 0xe;
iMCRDError_setLastError:
    /* MATCH (w44, -12): `goto iMCRDError_return` NOT `return code` - retail has ONE
     * return-value materialization (`addu $v0,$s4,$zero`) in the shared exit block,
     * reached by `j` from here; an in-block `return code` emits a second copy AND
     * pushes the lasterror/bReady stores off retail's $v0 onto $v1. */
    pCI->lasterror = scratch_i;
    gmi->bReady = 1;
    goto iMCRDError_return;
  case 7:
    tmp_int = 0x14;
    break;
  default:
    tmp_int = 0x17;
  }
  /* MATCH: LOOP-DEPTH REF DIAL #2 (zero-insn) - doubles the weight of this pCI ref so
   * pCI reaches 8 weighted refs (2*8/79 = .2025) and outranks the loop sentinel
   * (.1875) even when `numberoftries = 0` is written first (which shortens the
   * sentinel's live range to 16).  Decouples the slot-pick from the $s1/$s2 rotation
   * (removing it rotates $s1/$s2 through the whole fn: 34 diffs). */
  do {
    pCI->lasterror = tmp_int;
    gMemCardInfo.bReady = 1;   /* MATCH: inside the wrapper - the LOOP barrier at the
                                * edge would otherwise pin its address lui BELOW the
                                * lasterror store (retail hoists it above, 2 diffs). */
  } while (0);
iMCRDError_return:
  return code;
}

/* lines 1896-1897: (static data / macros / comments - no emitted code) */

/* ---- iMCRD_DefaultCBProc1  (memcard.c:1898, code lines 1898-1899) ---- */
int iMCRD_DefaultCBProc1(void)

{
  return 1;
}

/* lines 1900-2062: (static data / macros / comments - no emitted code) */

/* ---- ascii2sjis  (memcard.c:2063, code lines 2063-2096) [static] ---- */
short ascii2sjis(u_char ascii_code)

{
  /* SYM 8c block: sjis_code USHORT $3($v1), stmp UCHAR $3($v1), stmp2 UCHAR $5($a1).
   * `base`/`pk` are compiler temps in retail (no SYM record) - kept as C locals only
   * because the exact statement split is load-bearing (see the MATCH notes below). */
  u_short sjis_code;
  u_char stmp;
  u_char stmp2;
  uint base;
  u_short *pk;

  stmp = 0;
  stmp2 = stmp;                 /* MATCH: oracle's addu a1,v1,zero = stmp2 inits from stmp's zero */
  if ((byte)(ascii_code - 0x20) < 0x10) {
    stmp2 = 1;
  }
  else if (9 < (byte)(ascii_code - 0x30)) {
    if ((byte)(ascii_code - 0x3a) < 7) {
      stmp2 = 0xb;
    }
    /* MATCH: negative literals (-0x41/-0x5b/-0x61/-0x7b), NOT the algebraically-equal
     * +0xbf/+0xa5/+0x9f/+0x85 - the oracle's addiu immediates are the signed forms. */
    else if ((byte)(ascii_code - 0x41) < 0x1a) {
      stmp = 1;
    }
    else if ((byte)(ascii_code - 0x5b) < 6) {
      stmp2 = 0x25;
    }
    else if ((byte)(ascii_code - 0x61) < 0x1a) {
      stmp = 2;
    }
    /* MATCH: the last two arms are a FLAT continuation of the same else-if chain.
     * Folding them into one `else { stmp2 = 0x3f; if (...) return 0; }` block makes
     * gcc sink the stmp=2 arm to just before the merge (its `j` then dies, ours 71
     * vs 72) and inverts the 0x61 guard to bnez; the flat chain keeps the stmp=2
     * arm out-of-line with its own `j` = the oracle's beqz + j/li v1,2 pair. */
    else if ((byte)(ascii_code - 0x7b) < 4) {
      stmp2 = 0x3f;
    }
    else {
      return 0;
    }
  }
  /* MATCH: stmp2!=0 is the IF-BODY (fall-through) - the oracle's beqz jumps to the
   * ascii_table arm; the inverted (stmp2==0 first) shape emits bnez. */
  if (stmp2 != 0) {
    /* MATCH (block-15 local_alloc, -dl/-dg receipts): TWO ingredients, both needed.
     * (a) the table base is materialized into its own pointer local BEFORE the
     *     +0x1f computation.  local-alloc's qty_compare_1 sorts LONGER-LIVED first
     *     and breaks ties by qty number (later-born wins); born first, pk's qty is
     *     strictly longer, so it sorts ahead and takes the lower hard reg $v0,
     *     leaving $v1 for the index chain = the oracle.  Materializing it AFTER the
     *     +0x1f (or `ascii_k_table[...]` directly) ties the two qtys, the later-born
     *     chain wins, and the whole 7-insn block comes out $v0<->$v1 swapped (14).
     * (b) the load is an ARRAY INDEX off pk, so the addu gets a FRESH dest that
     *     local-alloc's combine_regs unifies with the DYING index chain
     *     (addu $v1,$v1,$v0; lhu $v1,0($v1) - dest reuses the address reg).
     *     A pointer MUTATION `pk = pk + idx` makes pk itself the addu dest
     *     (insn 152 `(set (reg/v 86) (plus (reg 114) ...))`) -> addu $v0,$v1,$v0
     *     and lhu $v1,0($v0) instead (4 diffs).
     * Falsified on the way: &-taken element, idx*2 + (int)base int-casts, compound
     * +=, byte-base (char*) cast, index into sjis_code itself, hoisted idx local,
     * volatile deref - each either stays at 4/14 or costs a 73rd insn. */
    pk = ascii_k_table;
    base = stmp2;
    base = base + 0x1f;
    sjis_code = pk[(uint)ascii_code - base];
  }
  else {
    sjis_code = (ascii_table[stmp][0] + ascii_code) - ascii_table[stmp][1];
  }
  /* MATCH: sjis_code is the SYM's USHORT local - the 16-bit type is what produces
   * the oracle's `andi $v1,$v1,0xffff; srl $v1,$v1,8` byte-swap tail (a uint
   * `code` temp + a separate (ushort) cast on the shift emits the same bytes only
   * by accident and mis-schedules the else arm's sll). */
  return (sjis_code << 8) | (sjis_code >> 8);
}

/* lines 2097-2101: (static data / macros / comments - no emitted code) */

/* ---- sjis2ascii  (memcard.c:2102, code lines 2102-2122) [static] ---- */
u_char sjis2ascii(short sjis_code)

{
  uint hi;
  u_char hb;
  int kind;

  kind = 0;
  hi = sjis_code >> 8;          /* MATCH: short >> 8 = the oracle's sll 16 / sra 24 */
  hb = hi;                      /* the SECOND BYTE itself */
  /* MATCH: retail keeps TWO live values for the second byte - the sign-extended
   * word in $v1 that all three RANGE TESTS read, and a byte-typed copy in $a2
   * (the oracle's `addu $a2,$v1,$zero`, filled into the 0x81 bne's delay slot)
   * that the k-table index and the final subtraction read.  A second int/uint
   * local, a plain `hv = hi;` copy, or a textual re-evaluation of sjis_code>>8
   * are ALL copy-propagated back to one pseudo (measured, 9 spellings); only the
   * NARROWER u_char type makes the second value a genuinely distinct pseudo that
   * survives cse - and its uses need no mask because both consumers narrow anyway. */
  if ((sjis_code & 0xffU) == 0x81) {
    /* MATCH: the reverse table is its OWN symbol @0x80052ad0 indexed from 0x40 -
     * the oracle's lbu -0x40(base); modelling it as ascii_k_table+0xc folded the
     * displacement into %lo and aliased a different object (real bug). */
    return sjis_k_table[(hb & 0xff) - 0x40];
  }
  if ((sjis_code & 0xffU) == 0x82) {
    if (9 < hi - 0x4f) {
      if (hi - 0x60 < 0x1a) {
        kind = 1;
      }
      else if ((hi + 0x7f & 0xff) < 0x1a) {
        kind = 2;
      }
    }
    return sjis_table[kind][1] + (hb - sjis_table[kind][0]);
  }
  return '\0';
}

/* end of memcard.c */
