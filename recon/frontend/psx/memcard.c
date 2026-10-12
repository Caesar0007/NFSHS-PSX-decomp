/* frontend/psx/memcard.c  --  RECONSTRUCTED  (PSX memory-card I/O; MEMCARD.C, C source)
 *   Bodies      : Ghidra decompiler (nfs4-f.exe MIPS), full re-decompile.
 *   Line numbers: PsyQ SLD per-instruction stream (8c-start, SLD-max end).
 *   C TU: SLD source = C:\nfs4\FRONTEND\PSX\MEMCARD.C -> CC1PSX lane (methodology 3.25;
 *   migrated from memcard.cpp, task #90). Self-contained per C-lane convention (local
 *   type mirrors; nfs4_types.h is C++-only). Unmangled C symbols match the SYM.
 *   3 helpers iMCRD_timersub/ascii2sjis/sjis2ascii are SYM class STAT and are
 *   reconstructed with their original file-local storage class.
 *   Drives the typed global gMemCardInfo (fMemCardInfo_def) - fields decompiler-named.
 *   NOTE: a few bodies carry decompiler mis-renderings (e.g. MCRD_getopts' 8-byte RECT
 *   copy was byte-unaligned -> rewritten as a struct assignment). Local temp names are
 *   the project's type-hinted bulk names (tu/tp/...), not original source identifiers.
 */

/* ---- base scalar typedefs (self-contained C lane) ---- */
typedef unsigned char  u_char;
typedef unsigned short u_short;
typedef unsigned short ushort;
typedef unsigned int   u_int;
typedef unsigned long  u_long;

/* ---- exact memcard.obj SYM type preamble ----
 * MEMCARD.C was compiled through EA's reduced PSX platform headers, not the
 * stock all-types PsyQ headers: the retail object emits precisely these named
 * kernel/GTE/GPU types before the EA shape, stream and memory-card records.
 * Keep tag and typedef names distinct where the SYM does (for example,
 * `struct MCRDFILE_def` is typedef'd as `MCRDFILE`, not MCRDFILE_def). */
struct TCB {                         /* 192 bytes (PsyQ kernel) */
    long   status, mode;
    u_long reg[40];
    long   system[6];
};

struct EXEC {                        /* 60 bytes (PsyQ kernel) */
    u_long pc0, gp0, t_addr, t_size, d_addr, d_size;
    u_long b_addr, b_size, s_addr, s_size, sp, fp, gp, ret, base;
};

struct DIRENTRY {                    /* 40 bytes (PsyQ kernel) */
    char             name[20];
    long             attr, size;
    struct DIRENTRY *next;
    long             head;
    char             system[4];
};

typedef struct VECTOR {              /* 16 bytes (PsyQ libgte) */
    long vx, vy, vz, pad;
} VECTOR;

typedef struct SVECTOR {             /* 8 bytes (PsyQ libgte) */
    short vx, vy, vz, pad;
} SVECTOR;

typedef struct CVECTOR {             /* 4 bytes (PsyQ libgte) */
    u_char r, g, b, cd;
} CVECTOR;

typedef struct DVECTOR {             /* 4 bytes (PsyQ libgte) */
    short vx, vy;
} DVECTOR;

typedef struct RVECTOR {             /* 24 bytes (PsyQ libgte) */
    SVECTOR v;
    u_char  uv[2];
    u_short pad;
    CVECTOR c;
    DVECTOR sxy;
    u_long  sz;
} RVECTOR;

typedef struct CRVECTOR3 {           /* 88 bytes (PsyQ libgte) */
    RVECTOR r01, r12, r20;
    RVECTOR *r0, *r1, *r2;
    u_long  *rtn;
} CRVECTOR3;

typedef struct CRVECTOR4 {           /* 140 bytes (PsyQ libgte) */
    RVECTOR r01, r02, r31, r32, rc;
    RVECTOR *r0, *r1, *r2, *r3;
    u_long  *rtn;
} CRVECTOR4;

typedef struct RECT {                /* 8 bytes (PsyQ libgpu) */
    short x, y, w, h;
} RECT;

typedef struct DR_ENV {              /* 64 bytes (PsyQ libgpu) */
    u_long tag;
    u_long code[15];
} DR_ENV;

typedef struct DRAWENV {             /* 92 bytes (PsyQ libgpu) */
    RECT    clip;
    short   ofs[2];
    RECT    tw;
    u_short tpage;
    u_char  dtd, dfe, isbg, r0, g0, b0;
    DR_ENV  dr_env;
} DRAWENV;

typedef struct DISPENV {             /* 20 bytes (PsyQ libgpu) */
    RECT   disp, screen;
    u_char isinter, isrgb24, pad0, pad1;
} DISPENV;

typedef struct shapetbl {            /* 20 bytes (EA shape) */
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
} SHAPE;

typedef struct cdstreamstruct {      /* 152 bytes (EA CD stream) */
    long id;
    char *start, *end, *write, *header, *get, *release;
    int  handle, state, control, status, abort, datahascrc;
    int  crcerrors, crcretries, buffersize;
    long blocksize;
    int  readsize, chunksize, relocationsize;
    long fileoffset;
    int  fileend;
    long filesize;
    int  dataoffset, seekposition, seekoffset, idtype, idmask;
    struct cdstreamstruct *nextstream;
    void *emptyblock, *head, *tail, *block;
    int  timer, blocktime, streamfull, getable, releaseable;
} CDSTREAM;

typedef enum PRODUCTLOC {            /* 4 bytes */
    N_AMERICA = 0,
    JAPAN = 1,
    EUROPE = 2
} PRODUCTLOC;

typedef struct MCRDOPTS_def {        /* 36 bytes */
    PRODUCTLOC productLocation;       /* +0x0 */
    char       *productCode;          /* +0x4 */
    int        bMoveIconsToVram;      /* +0x8 */
    RECT       VramIconArea;          /* +0xC */
    int        (*ConfirmFormatProc)(void), (*ConfirmOverwriteProc)(void);   /* +0x14 */
    void       (*LoadingDataProc)(void), (*SavingDataProc)(void);   /* +0x1C */
} MCRDOPTS;

typedef struct CARDINFO_def {        /* 616 bytes */
    int      status, lasterror, numfiles, freeblocks;   /* +0x0 */
    struct DIRENTRY dir[15];          /* +0x10 */
} CARDINFO;

typedef struct MCRDFILE_def {        /* 44 bytes */
    char         *name, *title;       /* +0x0 */
    int          size, offset;        /* +0x8 */
    unsigned int flags;               /* +0x10 */
    void         *pData;              /* +0x14 */
    SHAPE        *icon[3];            /* +0x18 */
    u_char       *numicons, *numblocks;   /* +0x24 */
} MCRDFILE;

typedef enum MANAGERTASK {           /* 4 bytes */
    NONE = 0,
    LOAD_CARD = 1,
    WRITE_FILE = 2,
    LOAD_FILE = 3,
    DELETE_FILE = 4
} MANAGERTASK;

typedef struct MCRDFILEHEADER_def {   /* 512 bytes */
    u_char  magicnumber[2];           /* +0x0 */
    u_char  type, nslots;             /* +0x2 */
    u_short title[32];                /* +0x4 (SYM: ARY USHORT title[32]) */
    u_char  unused[28];               /* +0x44 */
    u_char  iconclut[32];             /* +0x60 */
    u_char  icon1[128], icon2[128], icon3[128];   /* +0x80 */
} MCRDFILEHEADER;

typedef struct MCRDFILEINFO_def {     /* 572 bytes */
    int                cardnum;       /* +0x0 */
    char               name[24];      /* +0x4 */
    char               *title;        /* +0x1C */
    int                size, offset;  /* +0x20 */
    unsigned int       flags;         /* +0x28 */
    MCRDFILEHEADER     header;        /* +0x2C */
    void               *pData;        /* +0x22C */
    SHAPE              *icon[3];      /* +0x230 */
} MCRDFILEINFO;

typedef struct fMemCardInfo_def {     /* 6108 bytes */
    PRODUCTLOC         productLocation;   /* +0x0 */
    char               productCode[16];   /* +0x4 */
    int                bMoveIconsToVram;  /* +0x14 */
    RECT               VramIconArea;      /* +0x18 */
    int                (*ConfirmFormatProc)(void), (*ConfirmOverwriteProc)(void);   /* +0x20 */
    void               (*LoadingDataProc)(void), (*SavingDataProc)(void);   /* +0x28 */
    MANAGERTASK        task;              /* +0x30 */
    int                bReady, fMultitap; /* +0x34 */
    long               channel;           /* +0x3C */
    int                existencecheckticks[8];   /* +0x40 */
    MCRDFILEHEADER     header;            /* +0x60 */
    MCRDFILEINFO       fileinfo;          /* +0x260 */
    CARDINFO           card[8];           /* +0x49C */
} fMemCardInfo;

typedef unsigned int size_t;
typedef void (*MemCB)(long cmds, long rslt); /* PsyQ 4.3 <libmcrd.h> */
/* PsyQ SYS/TYPES.H body; its private tag block is filtered from retail SYM. */
struct _physadr { int r[1]; };
typedef struct _physadr *physadr;
typedef long daddr_t;
typedef char *caddr_t;
typedef long *qaddr_t;
typedef u_long ino_t;
typedef long swblk_t;
typedef long time_t;
typedef short dev_t;
typedef long off_t;
typedef u_short uid_t;
typedef u_short gid_t;
typedef u_long wchar_t;
typedef void (*VOIDFN)();
typedef int FILEOP;
typedef void FILE_CALLBACK();
typedef int FILE_ATOM();
typedef void THREADPROC();
typedef void THREAD2PROC();
typedef int SYSTEMTASK();
typedef int THREAD;

/* ---- memcard.obj data global ---- */
/* SYM: memcard.obj OWNS gMemCardInfo (Def2 EXT in its block, right after the
 * static sjis tables).  A C tentative definition here (retail: .comm folded
 * into front.bss by psylink) lets the placed link put it at 0x80052d68; an
 * extern alone left it undefined -> catch-all .bss. */
fMemCardInfo gMemCardInfo;               /* 0x80052d68  (6108 B) */
extern int timerhz;

/* ---- externs (libmcrd/libgs/eaclib/libetc/libc/sibling) ---- */
extern unsigned int shapetype(int v);    /* EA shape helpers */
extern unsigned int cluttype(int v);
extern void MemCardInit(long val);       /* PsyQ 4.3 <libmcrd.h> */
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
extern long MemCardGetDirentry(long chan, char *pat, struct DIRENTRY *dir, int *count, long a, long b);
extern u_char *getshapeclut(SHAPE *shape);   /* libgs shape CLUT (1 arg: oracle @0x800F6C3C never reads $a1) */
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
extern CARDINFO *MCRD_getcard(int card);                 /* sibling memcard TU */

/* ---- this TU's fns (fwd decls; intra-TU calls before definitions) ---- */
void MCRD_init(int fMultitap);
int  iMCRD_InitCard(int card);
void MCRD_restore(void);
void MCRD_getopts(MCRDOPTS *pOPT);
void MCRD_setopts(MCRDOPTS *pOPT);
void MCRD_loadfile(int card, MCRDFILE *pFILE, int bNameHasProductCode);
int  iMCRD_DoFileLoad(int card);
int  MCRD_savefile(int card, MCRDFILE *pFILE);
int  iMCRD_DoFileWrite(int card);
int  iMCRD_DoFileDelete(int card);
int  MCRD_handlecardevents(int card);
int  MCRD_fileexists(int card, char *name);
int  garyMemCardGrabBlocks(int card, int filenum);
int  iMCRD_LoadCard(int card);
int  iMCRD_FormatCard(int card);
int  iMCRD_HandleError(int func, int opResult, int card);
int  iMCRD_DefaultCBProc1(void);
static void  iMCRD_timersub(void);
static short ascii2sjis(u_char ascii_code);
static u_char sjis2ascii(short sjis_code);      /* @0x80050810 */

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
  
  blockclear(&gMemCardInfo,0x17dc);
  gMemCardInfo.ConfirmOverwriteProc = iMCRD_DefaultCBProc1;
  gMemCardInfo.ConfirmFormatProc = iMCRD_DefaultCBProc1;
  gMemCardInfo.task = NONE;
  gMemCardInfo.fMultitap = fMultitap;
  gMemCardInfo.SavingDataProc = (void (*)(void))asyncidle;
  gMemCardInfo.LoadingDataProc = (void (*)(void))asyncidle;
  MemCardInit(1);
  i = 1;
  do {
    timedwait(10);
    iMCRD_InitCard(i);
    i = i + 1;
  } while (i < 9);
  addtimer(iMCRD_timersub);
  MemCardStart();
  return;
}

/* lines 127-128: (static data / macros / comments - no emitted code) */

/* ---- iMCRD_InitCard  (memcard.c:129, code lines 129-143) ---- */
int iMCRD_InitCard(int card)

{
  CARDINFO *pCI;

  pCI = MCRD_getcard(card);
  if (pCI != (CARDINFO *)0x0) {
    pCI->status = -1;
    pCI->lasterror = 0;
    pCI->numfiles = 0;
    pCI->freeblocks = 0xf;
    blockclear(pCI->dir,600);
    return 0;
  }
  return -1;
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
void MCRD_getopts(MCRDOPTS *pOPT)
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
void MCRD_setopts(MCRDOPTS *pOPT)

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
void MCRD_loadfile(int card,MCRDFILE *pFILE,int bNameHasProductCode)

{
  MCRDFILEINFO *pMFI;
  
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
  MCRDFILEINFO *pMFI;
  SHAPE *s;

  /* MATCH: SYM (8c @0x8004f7a4) lists exactly SIX locals - cmd/res AUTO -0x30/-0x2C,
   * i REG $17($s1), error REG $2($v0), pMFI REG $18($s2), s REG $16($s0).  ONE index
   * `i` serves BOTH the title walk and the icon walk (the icon loop re-inits it to 0),
   * and ONE `error` carries both iMCRD_HandleError results; the remaining names here
   * are short-lived expression temps (no SYM record = compiler temps).
   * pMFI is the base anchor (retail derives &gMemCardInfo as pMFI-0x260).
   * The shape header's x/y clears are two BITFIELD assignments (0xF000FFFF then
   * 0xFFFFF000 off ONE lw/sw) - a single folded 0xF000F000 mask is a recon bug. */
  pMFI = &gMemCardInfo.fileinfo;
  if ((pMFI->title != (char *)0x0) || (pMFI->icon[0] != (SHAPE *)0x0)) {
    res = MemCardReadFile
                    (gMemCardInfo.channel,pMFI->name,
                     (u_long *)&pMFI->header,0,0x200);
    while (MemCardSync(1,&cmd,&res) == 0) {
      gMemCardInfo.LoadingDataProc();
      VSync(0);
    }
    error = iMCRD_HandleError(3,res,card);
    if (error != 0) {
      return error;
    }
    i = 0;
    if (pMFI->title != (char *)0x0) {
      while (1) {
        if ((pMFI->title[i] = sjis2ascii(pMFI->header.title[i])) == '\0') break;
        i = i + 1;
      }
    }
    i = 0;
    /* MATCH: top-tested while - the exit test stays at the bottom and the
     * icon[i] load/NULL-check stay at the loop TOP; a do/while lets gcc rotate
     * the load out into the preheader (the oracle's loop label sits ON it). */
    while (i < 3) {
      s = pMFI->icon[i];
      if (s == (SHAPE *)0x0) break;
      if (i == 0) {
        blockmove(pMFI->header.icon1,&s->data,0x80);
      }
      else if (i == 1) {
        blockmove(pMFI->header.icon2,&s->data,0x80);
      }
      else {
        blockmove(pMFI->header.icon3,&s->data,0x80);
      }
      s->type = shapetype(4);
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
      s = (SHAPE *)((int)s + s->next);
      blockmove(pMFI->header.iconclut,&s->data,0x20);
      s->type = cluttype(0x10);
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
int MCRD_savefile(int card,MCRDFILE *pFILE)

{
  /* decl order = SYM Def-record order (pMFI, nIcons, i) -- w86-S5 */
  MCRDFILEINFO *pMFI;
  int nIcons;
  int i;

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
        if (pFILE->icon[i] != (SHAPE *)0x0) {
          nIcons = nIcons + 1;
        }
        i = i + 1;
      } while (i < 3);
      if (nIcons == 0) {
        return -1;
      }
      pMFI->header.type = (char)nIcons + 16;
      /* MATCH: a plain signed divide - retail's bgez/addiu 0x3FFF/sra 13 is gcc's
       * own /0x2000 guard, not a hand-written rounding branch. */
      pMFI->header.nslots = (u_char)((pFILE->size + 0x2000) / 0x2000);
      if (pFILE->title == (char *)0x0) {
        return -1;
      }
      if (strlen(pFILE->title) == 0) {
        return -1;
      }
      /* MATCH: the -1 must be the FALL-THROUGH of this test (retail's shared
       * error block sits right here and the head's size-check jumps INTO it via
       * cross-jump); a goto to a tail label puts the block at the end instead. */
      if (0x20 < strlen(pFILE->title)) {
MCRDsave_errorDefault:
        return -1;
      }
      i = 0;
      do {
        pMFI->header.title[i] = ascii2sjis(pFILE->title[i]);
        if (pMFI->header.title[i] == 0) break;
        i = i + 1;
      } while (i < 0x20);
      blockmove(getshapeclut(pFILE->icon[0]) + 0x10,pMFI->header.iconclut,0x20);
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
  /* decl order = SYM Def-record order (cmd, res, error, pMFI) -- w86-S5 */
  long cmd;
  long res;
  int error;
  MCRDFILEINFO *pMFI;
  
  /* MATCH: the SYM's pMFI is the function's base anchor - the oracle keeps
   * &gMemCardInfo.fileinfo in a saved reg and derives &gMemCardInfo from it
   * (-0x260) for .channel; writing gMemCardInfo.fileinfo.X anchors the other way
   * and inflates every displacement by 0x260. */
  pMFI = &gMemCardInfo.fileinfo;
  if ((pMFI->flags & 0x200) != 0) {
    res = MemCardCreateFile
                    (gMemCardInfo.channel,pMFI->name,
                     (u_int)pMFI->header.nslots);
    error = iMCRD_HandleError(2,res,card);
    if (error != 0) {
      return error;
    }
    timedwait(0x40);
    res = MemCardWriteFile
                    (gMemCardInfo.channel,pMFI->name,
                     (u_long *)&pMFI->header,0,0x200);
    if (res == 0) {
      gMemCardInfo.bReady = 1;
      return 0xd;
    }
    while (MemCardSync(0,&cmd,&res) == 0) {
    }
    error = iMCRD_HandleError(2,res,card);
    if (error != 0) {
      return error;
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
  while (MemCardSync(0,&cmd,&res) == 0) {
  }
  error = iMCRD_HandleError(2,res,card);
  if (error == 0) {
    gMemCardInfo.bReady = 0;      /* MATCH: retail stores bReady BEFORE task here */
    gMemCardInfo.task = LOAD_CARD;
    return 0xc;
  }
  return error;
}

/* lines 854-904: (static data / macros / comments - no emitted code) */

/* ---- iMCRD_DoFileDelete  (memcard.c:905, code lines 905-929) ---- */
int iMCRD_DoFileDelete(int card)

{
  /* decl order = SYM Def-record order (retval, pMFI) -- w86-S5 */
  int retval;
  MCRDFILEINFO *pMFI;
  
  retval = 0x11;
  pMFI = &gMemCardInfo.fileinfo;   /* MATCH: SYM local; la(+0x260) anchor, name=+4, base=-0x260 */
  switch (MemCardDeleteFile(gMemCardInfo.channel,pMFI->name)) {
  case 0:
    gMemCardInfo.task = LOAD_CARD;
    break;
  case 5:
    MCRD_getcard(card)->lasterror = (retval = 0x12, 0x13);
    gMemCardInfo.bReady = 1;
  }
  return retval;
}

/* lines 930-970: (static data / macros / comments - no emitted code) */

/* ---- MCRD_handlecardevents  (memcard.c:971, code lines 971-1168) ---- */
/* 2026-10-12: remove idx, then reprice g/t as a pair. Direct indexed stores
   with only t remaining were14dif/211; removing g and t left2dif/211 (bReady
   store before address/timer setup). Putting both stores inside the old
   wrappers was54/211. Removing ALL four dummy do/while wrappers from BOTH
   res==0 and res==1 readiness/timer arms instead reproduces211/211 PASS.
   All six ordered retail local/type/home/depth tuples and root region match;
   no false struct-base view, source capture, dummy loop or replacement fence
   remains in this handler. The real status=0x16 shared-tail statements and
   store order are retained. Older necessity/loop-dial claims were specific to
   the synthetic source shape, not proof of original declarations/macros.
   MATCH: keep the existing out-of-line switch order and real status=0x16
   shared-tail assignments. They preserve retail's merge direction without
   an asm blocker; final branch-distance checks cover all21 owner functions.
   Full original text and SLD remain unsealed. */
int MCRD_handlecardevents(int card)

{
  int status;
  CARDINFO *pCI;
  u_long cmd;
  u_long res;
  int ret;

  status = 0x17;
  pCI = MCRD_getcard(card);
  ret = MemCardSync(0,(long *)&cmd,(long *)&res);
  if (ret == 0) {
    status = 0x15;
    goto MCRDhandleCard_end;
  }
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
        gMemCardInfo.bReady = cmd;
        gMemCardInfo.existencecheckticks[card + -1] = timerhz;
        if (pCI->status == -1) {
          MemCardAccept(gMemCardInfo.channel);
        }
        status = 0x16;
        break;
      case 1:
        status = 2;
          gMemCardInfo.bReady = cmd;
          gMemCardInfo.existencecheckticks[card + -1] = timerhz;
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
    goto MCRDhandleCard_end;
  }
MCRDhandleCard_task:
  switch(gMemCardInfo.task) {
  case NONE:
    if (gMemCardInfo.existencecheckticks[card + -1] < 0) {
      gMemCardInfo.bReady = 0;
      status = 0x17;
      if (MemCardExist(gMemCardInfo.channel) == 0) goto MCRDhandleCard_end;
      status = 0x15;
    } else {
      status = 0x16;
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
  int i;
  struct DIRENTRY *pDir;
  char fullname [24];
  
  pDir = MCRD_getcard(card)->dir;
  strcpy(fullname,gMemCardInfo.productCode);
  strcat(fullname,name);
  i = 0;
  do {
    if (strcmp((char *)pDir,fullname) == 0) {
      return i;
    }
    i = i + 1;
    pDir = pDir + 1;
  } while (i < 0xf);
  return -1;
}

/* ---- MCRD_getcard  (memcard.c:1364, code lines 1364-1377) ---- */
CARDINFO *MCRD_getcard(int card)
{
  card = card - 1;
  gMemCardInfo.channel = ((card & 4) << 2) | (card & 3);
  return &gMemCardInfo.card[card];
}

/* lines 1378-1535: (static data / macros / comments - no emitted code) */

/* ---- iMCRD_timersub  (memcard.c:1536, code lines 1536-1541) [static] ---- */
static void iMCRD_timersub(void)

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
/* Declaration order follows retail SYM: i, pCI, pDir. */
int garyMemCardGrabBlocks(int card,int filenum)

{
  int i; CARDINFO *pCI; struct DIRENTRY *pDir;
  pCI = MCRD_getcard(card);
  pDir = pCI->dir;


  MemCardGetDirentry(gMemCardInfo.channel,"*",pDir,&pCI->numfiles,0,0xf);


  for (i = 0; i < filenum; i++) pDir = pDir + 1;
  /* Retail SLD has six un-emitted source lines before the signed
     size-to-block return. Their original contents are not recoverable
     from the optimized image or the available SYM records; this
     annotation preserves the line region without claiming text.
     No executable statement or post-compile rewrite is inserted.
     The division below is the compiler's original sign-bias idiom. */
  return pDir->size / 0x2000;
}

/* lines 1562-1565: (static data / macros / comments - no emitted code) */

/* ---- iMCRD_LoadCard  (memcard.c:1566, code lines 1566-1693) ---- */
int iMCRD_LoadCard(int card)

{
  /* decl order = SYM Def-record order (error, slot, pCI, pDir); the non-SYM
     carrier follows it -- w86-S5 */
  int error;
  int slot;
  CARDINFO *pCI;
  struct DIRENTRY *pDir;
  
  pCI = MCRD_getcard(card);
  pDir = pCI->dir;
  error = iMCRD_InitCard(card);
  if (error != 0) {
    error = 0xb;
  }
  else {
    error = iMCRD_HandleError
        (1,MemCardGetDirentry(gMemCardInfo.channel,"*",pDir,&pCI->numfiles,0,0xf),card);
    slot = 0;
    if (error == 0) {
      do {
        if (pDir->name[0] != '\0') {
          pCI->freeblocks = pCI->freeblocks - pDir->size / 0x2000;
        }
        slot = slot + 1;
        pDir = pDir + 1;
      } while (slot < 0xf);
      if (pCI->freeblocks == 0) {
        pCI->status = -3;
      }
      else {
        pCI->status = 0;
      }
      gMemCardInfo.bReady = 1;
      error = 9;
    }
  }
  return error;
}

/* lines 1694-1695: (static data / macros / comments - no emitted code) */

/* ---- iMCRD_FormatCard  (memcard.c:1696, code lines 1696-1732) ---- */
int iMCRD_FormatCard(int card)

{
  /* decl order = SYM Def-record order (result, pCI) -- w86-S5 */
  int result;
  CARDINFO *pCI;
  
  result = 0;
  pCI = MCRD_getcard(card);
  /* MATCH: a real switch WITH the empty success case (0).  THREE case nodes is
   * what makes gcc-2.8's balance_case_nodes split the list at the middle, so the
   * root (1) gets BOTH children; emit_case_nodes' "neither subtree bounded" arm
   * then emits the discriminating compare, and jump.c collapses the empty
   * case-0 subtree into the default + inverts it -> the oracle's
   *     beq ==1 / slti $v0,$v1,2 / bnez -> default / beq ==2 / j default.
   * A plain 2-case switch keeps the list LINEAR (balance_case_nodes only splits
   * when i > 2), the root has a right child only, and emit_case_nodes takes the
   * "handle node->right explicitly" else-arm = two bare beq's, NO bound test. */
  switch (MemCardFormat(gMemCardInfo.channel)) {
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
/* 2026-10-12 MATCH135/135: first attempt followed by retries gives card the
   natural source lifetime/reference edge. Reuse the consumed opResult as
   the retry -1 value: GCC merges the two source call sites to one retail
   call/backedge and restores card/code homes, without failed or a dummy loop.
   Per-arm error/readiness stores then merge to the exact shared tail with
   its global LUI before the error store. scratch_i/tmp_int/gmi/failed and
   both dummy wrappers are gone. All seven ordered native locals/parameters
   and both regions agree; whole-TU bytes/layout and branch distances remain
   exact (run-vd2ngt11). No fence, qualifier, dummy reference, register pin,
   compiler output rewrite or preprocessor line marker is retained.
   Earlier20/135 and14/139 source basins were intermediate, not floors.
   Literal original expression/label spelling and full SLD remain unsealed. */
int iMCRD_HandleError(int func,int opResult,int card)

{
  int code = 0;
  CARDINFO *pCI = MCRD_getcard(card);

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
    pCI->lasterror = 2;
    gMemCardInfo.bReady = 1;
    goto iMCRDError_return;
  case 2:
    pCI->status = -4;
    pCI->lasterror = 3;
    gMemCardInfo.bReady = 1;
    goto iMCRDError_return;
  case 3:
    if (MemCardAccept(gMemCardInfo.channel) == 0) {
      pCI->lasterror = 0x17;
      gMemCardInfo.bReady = 1;
      goto iMCRDError_return;
    }
    else {
      gMemCardInfo.task = LOAD_CARD;
      gMemCardInfo.bReady = 0;
      goto iMCRDError_return;
    }
  case 4:
    if (func == 2) {
      if (gMemCardInfo.ConfirmFormatProc() != 0) {
        int numberoftries;
        int result;
        numberoftries = 0;
        opResult = -1;
        result = iMCRD_FormatCard(card);
        for (;;) {
          if (result != opResult) goto iMCRDError_formatOK;
          numberoftries = numberoftries + 1;
          if (numberoftries >= 3) break;
          result = iMCRD_FormatCard(card);
        }
        if (result != -1) {
iMCRDError_formatOK:
          gMemCardInfo.task = WRITE_FILE;
          return 6;
        }
        pCI->status = -2;
        pCI->lasterror = 7;
        gMemCardInfo.bReady = 1;
        goto iMCRDError_return;
      }
    }
    pCI->status = -2;
    pCI->lasterror = 5;
    gMemCardInfo.bReady = 1;
    goto iMCRDError_return;
  case 5:
    pCI->lasterror = 0x13;
    gMemCardInfo.bReady = 1;
    goto iMCRDError_return;
  case 6:
    if (gMemCardInfo.ConfirmOverwriteProc() != 0) {
      MemCardDeleteFile(gMemCardInfo.channel,gMemCardInfo.fileinfo.name);
      gMemCardInfo.task = WRITE_FILE;
      return 0x15;
    }
    pCI->lasterror = 0xe;
    gMemCardInfo.bReady = 1;
    goto iMCRDError_return;
  case 7:
    pCI->lasterror = 0x14;
    gMemCardInfo.bReady = 1;
    goto iMCRDError_return;
  default:
    pCI->lasterror = 0x17;
    gMemCardInfo.bReady = 1;
  }

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
/* 2026-10-12 SOURCE-REVIEW-UNRESOLVED: base/pk remain unsupported source
   objects. Direct UINT index22dif/72; USHORT subtotal5dif/71 (retail's
   guard widening disappears); sjis_code staging53/73; direct base-first
   integer address15/73; widened base guard/direct array20/72. Explicit
   byte masks and unsigned-positive guards did not fix the5/71 subtotal.
   All failed bodies are reverted, with no const disguise, new qualifier,
   dummy use, register dial or compiler-output rewrite.
   Native C combine/lreg/greg receipts under scratch/rtl_a5/ascii2sjis_
   {direct,capture}_20261012.* show capture insn132 zero-extends QI r84
   into SI r109 before guard134; the near direct form deletes that extension
   and guard134 reads a SI subreg of QI r84. This is a specific widening/
   combine ownership question, not proof that either named capture existed.
   Literal original text and full SLD remain open. */
static short ascii2sjis(u_char ascii_code)

{
  u_short sjis_code;
  u_char stmp;
  u_char stmp2;
  u_int base;
  u_short *pk;

  stmp = 0;
  stmp2 = stmp;                 /* MATCH: oracle's addu a1,v1,zero = stmp2 inits from stmp's zero */
  if ((u_char)(ascii_code - 0x20) < 0x10) {
    stmp2 = 1;
  }
  else if (9 < (u_char)(ascii_code - 0x30)) {
    if ((u_char)(ascii_code - 0x3a) < 7) {
      stmp2 = 0xb;
    }
    /* MATCH: negative literals (-0x41/-0x5b/-0x61/-0x7b), NOT the algebraically-equal
     * +0xbf/+0xa5/+0x9f/+0x85 - the oracle's addiu immediates are the signed forms. */
    else if ((u_char)(ascii_code - 0x41) < 0x1a) {
      stmp = 1;
    }
    else if ((u_char)(ascii_code - 0x5b) < 6) {
      stmp2 = 0x25;
    }
    else if ((u_char)(ascii_code - 0x61) < 0x1a) {
      stmp = 2;
    }
    /* MATCH: the last two arms are a FLAT continuation of the same else-if chain.
     * Folding them into one `else { stmp2 = 0x3f; if (...) return 0; }` block makes
     * gcc sink the stmp=2 arm to just before the merge (its `j` then dies, ours 71
     * vs 72) and inverts the 0x61 guard to bnez; the flat chain keeps the stmp=2
     * arm out-of-line with its own `j` = the oracle's beqz + j/li v1,2 pair. */
    else if ((u_char)(ascii_code - 0x7b) < 4) {
      stmp2 = 0x3f;
    }
    else {
      return 0;
    }
  }
  /* MATCH: stmp2!=0 is the IF-BODY (fall-through) - the oracle's beqz jumps to the
   * ascii_table arm; the inverted (stmp2==0 first) shape emits bnez. */
  if (stmp2 != 0) {
    pk = ascii_k_table;
    base = stmp2;
    base = base + 0x1f;
    sjis_code = pk[(u_int)ascii_code - base];
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
static u_char sjis2ascii(short sjis_code)

{
  /* Retail `idx` is the table selector in $a1, not the sign-extended high
     byte in $v1. Repeated source shifts are CSE'd into that unnamed value;
     the narrow `bottom` remains distinct in $a2. */
  int idx;
  u_char bottom;

  idx = 0;
  bottom = sjis_code >> 8;      /* short >> 8 = oracle sll 16 / sra 24 */
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
    return sjis_k_table[(bottom & 0xff) - 0x40];
  }
  if ((sjis_code & 0xffU) == 0x82) {
    if (9U < (u_int)((sjis_code >> 8) - 0x4f)) {
      if ((u_int)((sjis_code >> 8) - 0x60) < 0x1aU) {
        idx = 1;
      }
      else if ((u_int)((sjis_code >> 8) + 0x7f & 0xff) < 0x1aU) {
        idx = 2;
      }
    }
    return sjis_table[idx][1] + (bottom - sjis_table[idx][0]);
  }
  return '\0';
}

/* end of memcard.c */
