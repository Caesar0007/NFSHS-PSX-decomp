# 0 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\memcard.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\memcard.c"
# 16 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\memcard.c"
typedef unsigned char u_char;
typedef unsigned char uchar;
typedef unsigned char byte;
typedef unsigned short u_short;
typedef unsigned short ushort;
typedef unsigned int u_int;
typedef unsigned int uint;
typedef unsigned long u_long;


typedef struct RECT {
    short x, y, w, h;
} RECT;

typedef enum {
    N_AMERICA = 0,
    JAPAN = 1,
    EUROPE = 2
} PRODUCTLOC;

typedef enum {
    NONE = 0,
    LOAD_CARD = 1,
    WRITE_FILE = 2,
    LOAD_FILE = 3,
    DELETE_FILE = 4
} MANAGERTASK;

typedef struct shapetbl {
    unsigned int type : 8;
    int next : 24;
    short width, height, centerx, centery;
    int shapex : 12;
    unsigned int reserved : 1;
    unsigned int twiddled : 1;
    unsigned int transposed : 1;
    unsigned int rotated : 1;
    int shapey : 12;
    unsigned int mipmaps : 4;
    char data;
} shapetbl;

typedef struct DIRENTRY {
    char name[20];
    long attr, size;
    struct DIRENTRY *next;
    long head;
    char system[4];
} DIRENTRY;

typedef struct CARDINFO_def {
    int status, lasterror, numfiles, freeblocks;
    DIRENTRY dir[15];
} CARDINFO_def;

typedef struct MCRDFILEHEADER_def {
    u_char magicnumber[2];
    u_char type, nslots;
    short title[32];
    u_char unused[28];
    u_char iconclut[32];
    u_char icon1[128], icon2[128], icon3[128];
} MCRDFILEHEADER_def;

typedef struct MCRDFILEINFO_def {
    int cardnum;
    char name[24];
    char *title;
    int size, offset;
    unsigned int flags;
    MCRDFILEHEADER_def header;
    void *pData;
    shapetbl *icon[3];
} MCRDFILEINFO_def;

typedef struct MCRDFILE_def {
    char *name, *title;
    int size, offset;
    unsigned int flags;
    void *pData;
    shapetbl *icon[3];
    u_char *numicons, *numblocks;
} MCRDFILE_def;

typedef struct MCRDOPTS_def {
    PRODUCTLOC productLocation;
    char *productCode;
    int bMoveIconsToVram;
    RECT VramIconArea;
    void *ConfirmFormatProc, *ConfirmOverwriteProc, *LoadingDataProc, *SavingDataProc;
} MCRDOPTS_def;

typedef struct fMemCardInfo_def {
    PRODUCTLOC productLocation;
    char productCode[16];
    int bMoveIconsToVram;
    RECT VramIconArea;
    void *ConfirmFormatProc, *ConfirmOverwriteProc, *LoadingDataProc, *SavingDataProc;
    MANAGERTASK task;
    int bReady, fMultitap;
    long channel;
    int existencecheckticks[8];
    MCRDFILEHEADER_def header;
    MCRDFILEINFO_def fileinfo;
    CARDINFO_def card[8];
} fMemCardInfo_def;


extern fMemCardInfo_def gMemCardInfo;
extern int timerhz;


extern unsigned int shapetype(int v);
extern unsigned int cluttype(int v);
extern long MemCardInit(long val);
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
extern u_char *getshapeclut(shapetbl *shape);
extern void blockclear(void *dst, int size);
extern void blockmove(void *src, void *dst, int size);
extern int addtimer(void (*proc)(void));
extern int deltimer(void (*proc)(void));
extern void timedwait(int n);
extern void asyncidle();
extern int VSync(int mode);
extern char *strcpy(char *dst, char *src);
extern char *strcat(char *dst, char *src);
extern char *strncpy(char *dst, char *src, int n);
extern unsigned int strlen(char *s);
extern int strcmp(char *a, char *b);
extern CARDINFO_def *MCRD_getcard(int card);


void MCRD_init(int fMultitap);
int iMCRD_InitCard(int card);
void MCRD_restore(void);
void MCRD_getopts(MCRDOPTS_def *pOPT);
void MCRD_setopts(MCRDOPTS_def *pOPT);
void MCRD_loadfile(int card, MCRDFILE_def *pFILE, int bNameHasProductCode);
int iMCRD_DoFileLoad(int card);
int MCRD_savefile(int card, MCRDFILE_def *pFILE);
int iMCRD_DoFileWrite(int card);
int iMCRD_DoFileDelete(int card);
int MCRD_handlecardevents(int card);
int MCRD_fileexists(int card, char *name);
int garyMemCardGrabBlocks(int card, int filenum);
int iMCRD_LoadCard(int card);
int iMCRD_FormatCard(int card);
int iMCRD_HandleError(int func, int opResult, int card);
int iMCRD_DefaultCBProc1(void);
void iMCRD_timersub(void);
short ascii2sjis(u_char ascii_code);
u_char sjis2ascii(short sjis_code);


static u_short ascii_table[3][2] = {
    {0x824f, 0x0030}, {0x8260, 0x0041}, {0x8281, 0x0061}
};
static u_short ascii_k_table[33] = {
    0x8140, 0x8149, 0x8168, 0x8194, 0x8190, 0x8193, 0x8195, 0x8166, 0x8169, 0x816a, 0x8196,
    0x817b, 0x8143, 0x817c, 0x8144, 0x815e, 0x8146, 0x8147, 0x8171, 0x8181, 0x8172, 0x8148,
    0x8197, 0x816d, 0x818f, 0x816e, 0x814f, 0x8151, 0x8165, 0x816f, 0x8162, 0x8170, 0x8150
};
static u_char sjis_table[3][2] = {
    {0x4f, 0x30}, {0x60, 0x41}, {0x81, 0x61}
};
static u_char sjis_k_table[88] = {
    0x20, 0x00, 0x00, 0x2c, 0x2e, 0x00, 0x3a, 0x3b, 0x3f, 0x21, 0x00, 0x00, 0x00, 0x00, 0x00, 0x5e,
    0x7e, 0x5f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2f, 0x00,
    0x00, 0x00, 0x7c, 0x00, 0x00, 0x60, 0x27, 0x00, 0x22, 0x28, 0x29, 0x00, 0x00, 0x5b, 0x5d, 0x7b,
    0x7d, 0x3c, 0x3e, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x2b, 0x2d, 0x00, 0x00, 0x00,
    0x00, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x5c,
    0x24, 0x00, 0x00, 0x25, 0x23, 0x26, 0x2a, 0x40
};




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




void MCRD_restore(void)

{
  deltimer(iMCRD_timersub);
  MemCardSync(0,(long *)0x0,(long *)0x0);
  MemCardStop();
  MemCardEnd();
  return;
}




void MCRD_getopts(MCRDOPTS_def *pOPT)
{
  pOPT->productLocation = gMemCardInfo.productLocation;
  pOPT->productCode = (char *)0x0;
  pOPT->ConfirmFormatProc = gMemCardInfo.ConfirmFormatProc;
  pOPT->ConfirmOverwriteProc = gMemCardInfo.ConfirmOverwriteProc;
  pOPT->LoadingDataProc = gMemCardInfo.LoadingDataProc;
  pOPT->SavingDataProc = gMemCardInfo.SavingDataProc;
  pOPT->bMoveIconsToVram = gMemCardInfo.bMoveIconsToVram;
  pOPT->VramIconArea = gMemCardInfo.VramIconArea;
}




void MCRD_setopts(MCRDOPTS_def *pOPT)

{
# 295 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\memcard.c"
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
  gMemCardInfo.VramIconArea = pOPT->VramIconArea;
  return;
}




void MCRD_loadfile(int card,MCRDFILE_def *pFILE,int bNameHasProductCode)

{
  MCRDFILEINFO_def *pMFI;






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
# 385 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\memcard.c"
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
# 440 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\memcard.c"
      s->next = 0x90;
      s->height = 0x10;
      s->width = 0x10;
      s->centery = 0;
      s->centerx = 0;
      s->shapey = 0;
      s->shapex = 0;






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




int MCRD_savefile(int card,MCRDFILE_def *pFILE)

{
  u_short sjis;
  uint len;
  uchar *clut;
  int i;
  int nIcons;
  MCRDFILEINFO_def *pMFI;





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


      pMFI->header.nslots = (uchar)((pFILE->size + 0x2000) / 0x2000);
      if (pFILE->title == (char *)0x0) {
        return -1;
      }
      len = strlen(pFILE->title);
      if (len == 0) {
        return -1;
      }
      len = strlen(pFILE->title);



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
    gMemCardInfo.bReady = 0;
    gMemCardInfo.task = LOAD_CARD;
    return 0xc;
  }
  return err;
}




int iMCRD_DoFileDelete(int card)

{
  long del_res;
  CARDINFO_def *pcard;
  MCRDFILEINFO_def *pMFI;
  int retval;
  int ret_state;

  ret_state = 0x11;
  pMFI = &gMemCardInfo.fileinfo;
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




int MCRD_handlecardevents(int card)

{





  CARDINFO_def *pCI;
  int ret;
  int status;
  u_long cmd;
  u_long res;
# 769 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\memcard.c"
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
# 806 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\memcard.c"
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
# 825 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\memcard.c"
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
# 883 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\memcard.c"
    goto MCRDhandleCard_end;
  }
MCRDhandleCard_task:




  switch(gMemCardInfo.task) {
  case NONE:
    status = 0x16;
    if (gMemCardInfo.existencecheckticks[card + -1] < 0) {
      gMemCardInfo.bReady = 0;
      status = 0x17;
      if (MemCardExist(gMemCardInfo.channel) == 0) goto MCRDhandleCard_end;
      status = 0x15;
    } else {
# 909 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\memcard.c"
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




int iMCRD_FormatCard(int card)

{
  CARDINFO_def *pCI;
  long fmtRes;
  int result;

  result = 0;
  pCI = MCRD_getcard(card);
  fmtRes = MemCardFormat(gMemCardInfo.channel);
# 1090 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\memcard.c"
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




int iMCRD_HandleError(int func,int opResult,int card)

{
  int scratch_i;
  int tmp_int;
  CARDINFO_def *pCI;
  fMemCardInfo_def *gmi;
  int code;
# 1171 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\memcard.c"
  code = 0;
  pCI = MCRD_getcard(card);



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
# 1209 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\memcard.c"
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

        int numberoftries;
        int result;
        int failed;





        numberoftries = 0;



        failed = -1;
# 1244 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\memcard.c"
        do {
# 1253 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\memcard.c"
          do {
            result = iMCRD_FormatCard(card);
          } while (0);






          if (result != failed) goto iMCRDError_formatOK;
          numberoftries = numberoftries + 1;
        } while (numberoftries < 3);
        if (result != -1) {


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




    pCI->lasterror = scratch_i;
    gmi->bReady = 1;
    goto iMCRDError_return;
  case 7:
    tmp_int = 0x14;
    break;
  default:
    tmp_int = 0x17;
  }





  do {
    pCI->lasterror = tmp_int;
    gMemCardInfo.bReady = 1;


  } while (0);
iMCRDError_return:
  return code;
}




int iMCRD_DefaultCBProc1(void)

{
  return 1;
}




short ascii2sjis(u_char ascii_code)

{



  u_short sjis_code;
  u_char stmp;
  u_char stmp2;
  uint base;
  u_short *pk;

  stmp = 0;
  stmp2 = stmp;
  if ((byte)(ascii_code - 0x20) < 0x10) {
    stmp2 = 1;
  }
  else if (9 < (byte)(ascii_code - 0x30)) {
    if ((byte)(ascii_code - 0x3a) < 7) {
      stmp2 = 0xb;
    }


    else if ((byte)(ascii_code - 0x41) < 0x1a) {
      stmp = 1;
    }
    else if ((byte)(ascii_code - 0x5b) < 6) {
      stmp2 = 0x25;
    }
    else if ((byte)(ascii_code - 0x61) < 0x1a) {
      stmp = 2;
    }





    else if ((byte)(ascii_code - 0x7b) < 4) {
      stmp2 = 0x3f;
    }
    else {
      return 0;
    }
  }


  if (stmp2 != 0) {
# 1396 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\memcard.c"
    pk = ascii_k_table;
    base = stmp2;
    base = base + 0x1f;
    sjis_code = pk[(uint)ascii_code - base];
  }
  else {
    sjis_code = (ascii_table[stmp][0] + ascii_code) - ascii_table[stmp][1];
  }




  return (sjis_code << 8) | (sjis_code >> 8);
}




u_char sjis2ascii(short sjis_code)

{
  uint hi;
  u_char hb;
  int kind;

  kind = 0;
  hi = sjis_code >> 8;
  hb = hi;
# 1432 "C:\\Temp\\nfs4-wt46-a10\\recon\\frontend\\psx\\memcard.c"
  if ((sjis_code & 0xffU) == 0x81) {



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
