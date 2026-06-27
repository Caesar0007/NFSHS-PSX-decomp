/* frontend/psx/memcard.c  --  RECONSTRUCTED  (PSX memory-card I/O; MEMCARD.C, C source)
 *   Bodies      : Ghidra decompiler (nfs4-f.exe MIPS), full re-decompile.
 *   Line numbers: PsyQ SLD per-instruction stream (8c-start, SLD-max end).
 *   Linkage     : C file -> extern "C" (unmangled SYM names). 3 statics: iMCRD_timersub,
 *                 ascii2sjis, sjis2ascii (SYM class STAT). Drives the typed global
 *                 gMemCardInfo (fMemCardInfo_def) - fields already named by the decompiler.
 *   NOTE: a few bodies carry decompiler mis-renderings (e.g. MCRD_getopts' 8-byte RECT
 *   copy was byte-unaligned -> rewritten as a struct assignment). Local temp names are
 *   the project's type-hinted bulk names (tu/tp/...), not original source identifiers.
 */
#include "memcard.h"
#include "memcard_externs.h"

/* forward decls for the file-local statics (called before their definitions) */
extern "C" void  iMCRD_timersub(void);
extern "C" short ascii2sjis(u_char ascii_code);
extern "C" u_char sjis2ascii(short sjis_code);   /* @0x80050810 (memcard.c); extern "C" so the symbol is `sjis2ascii` not the C++-mangled local (pairs with the front oracle) */

/* file-local SJIS<->ASCII lookup tables (SYM class STAT; table *values* live in .data,
   not in the SYM, so these are declared empty - the layout/sizes are SYM-accurate). */
static u_short ascii_table[3][2];    /* 0x80052a78 */
static u_short ascii_k_table[33];    /* 0x80052a84 */
static u_char  sjis_table[3][2];     /* 0x80052ac8 */
static u_char  sjis_k_table[88];     /* 0x80052ad0 */

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
  int loc;
  
  if (pOPT->productCode == (char *)0x0) {
    gMemCardInfo.productCode[0] = '\0';
    gMemCardInfo.productLocation = N_AMERICA;
  }
  else {
    gMemCardInfo.productCode[0] = 'B';
    loc = pOPT->productLocation;
    if (loc == 1) {
      gMemCardInfo.productCode[1] = 'I';
    }
    else if ((loc == 0) || (loc != 2)) {
      gMemCardInfo.productCode[1] = 'A';
    }
    else {
      gMemCardInfo.productCode[1] = 'E';
    }
    strncpy(gMemCardInfo.productCode + 2,pOPT->productCode,10);
    gMemCardInfo.productCode[0xc] = '\0';
    gMemCardInfo.productLocation = pOPT->productLocation;
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
  
  blockclear(&gMemCardInfo.fileinfo,0x23c);
  gMemCardInfo.fileinfo.cardnum = card;
  if (bNameHasProductCode == 0) {
    strcpy(gMemCardInfo.fileinfo.name,gMemCardInfo.productCode);
  }
  strcat(gMemCardInfo.fileinfo.name,pFILE->name);
  gMemCardInfo.fileinfo.title = pFILE->title;
  gMemCardInfo.fileinfo.size = pFILE->size;
  gMemCardInfo.fileinfo.offset = pFILE->offset;
  gMemCardInfo.fileinfo.icon[0] = pFILE->icon[0];
  gMemCardInfo.fileinfo.icon[1] = pFILE->icon[1];
  gMemCardInfo.fileinfo.icon[2] = pFILE->icon[2];
  gMemCardInfo.fileinfo.pData = pFILE->pData;
  pFILE->numicons = &gMemCardInfo.fileinfo.header.type;
  pFILE->numblocks = &gMemCardInfo.fileinfo.header.nslots;
  gMemCardInfo.task = LOAD_FILE;
  gMemCardInfo.bReady = 0;
  return;
}

/* lines 433-434: (static data / macros / comments - no emitted code) */

/* ---- iMCRD_DoFileLoad  (memcard.c:435, code lines 435-525) ---- */
int iMCRD_DoFileLoad(int card)

{
  uchar ch;
  int error;
  long sync_done;
  int err_state;
  uint attr;
  long sync;
  uchar *src;
  shapetbl *s;
  uint *pIcon;
  int i;
  int iconNum;
  MCRDFILEINFO_def *pMFI;
  int ret;
  long cmd;
  long res;
  
  ret = (int)&gMemCardInfo.fileinfo /* 0x80052fc8; +0x30 -> .header.title[] */;
  if ((gMemCardInfo.fileinfo.title != (char *)0x0) ||
     (gMemCardInfo.fileinfo.icon[0] != (shapetbl *)0x0)) {
    res = MemCardReadFile
                    (gMemCardInfo.channel,gMemCardInfo.fileinfo.name,
                     (u_long *)&gMemCardInfo.fileinfo.header,0,0x200);
    while (sync_done = MemCardSync(1,&cmd,&res), sync_done == 0) {
      ((int(*)(void))gMemCardInfo.LoadingDataProc)();
      VSync(0);
    }
    err_state = iMCRD_HandleError(3,res,card);
    if (err_state != 0) {
      return err_state;
    }
    i = 0;
    if (gMemCardInfo.fileinfo.title != (char *)0x0) {
      while( true ) {
        ch = sjis2ascii(*(short *)(ret + 0x30));
        gMemCardInfo.fileinfo.title[i] = ch;
        ret = ret + 2;
        if (ch == '\0') break;
        i = i + 1;
      }
    }
    iconNum = 0;
    i = 0;
    do {
      pIcon = *(uint **)((int)gMemCardInfo.fileinfo.icon + i);
      if (pIcon == (uint *)0x0) break;
      src = gMemCardInfo.fileinfo.header.icon1;
      if (iconNum != 0) {
        if (iconNum == 1) {
          src = gMemCardInfo.fileinfo.header.icon2;
        }
        else {
          src = gMemCardInfo.fileinfo.header.icon3;
        }
      }
      blockmove(src,pIcon + 4,0x80);
      attr = shapetype(4);
      *(char *)pIcon = (char)attr;
      attr = attr & 0xff | 0x9000;
      *pIcon = attr;
      *(u_short *)((int)pIcon + 6) = 0x10;
      *(u_short *)(pIcon + 1) = 0x10;
      *(u_short *)((int)pIcon + 10) = 0;
      *(u_short *)(pIcon + 2) = 0;
      pIcon[3] = pIcon[3] & 0xf000f000;
      pIcon = (uint *)((int)pIcon + ((int)attr >> 8));
      blockmove(gMemCardInfo.fileinfo.header.iconclut,pIcon + 4,0x20);
      attr = cluttype(0x10);
      *(char *)pIcon = (char)attr;
      iconNum = iconNum + 1;
      *(u_short *)(pIcon + 1) = 0x10;
      *(u_short *)((int)pIcon + 6) = 1;
      *(u_short *)((int)pIcon + 10) = 0;
      *(u_short *)(pIcon + 2) = 0;
      *pIcon = attr & 0xff;
      pIcon[3] = pIcon[3] & 0xf000f000;
      i = iconNum * 4;
    } while (iconNum < 3);
  }
  if (gMemCardInfo.fileinfo.size != 0) {
    res = MemCardReadFile
                    (gMemCardInfo.channel,gMemCardInfo.fileinfo.name,
                     (u_long *)gMemCardInfo.fileinfo.pData,gMemCardInfo.fileinfo.offset + 0x200,
                     gMemCardInfo.fileinfo.size);
    if (res == 0) {
      gMemCardInfo.bReady = 1;
      return 0x10;
    }
    do {
      sync = MemCardSync(0,&cmd,&res);
    } while (sync == 0);
    i = iMCRD_HandleError(3,res,card);
    if (i != 0) {
      return i;
    }
  }
  gMemCardInfo.bReady = 1;
  return 0xf;
}

/* lines 526-662: (static data / macros / comments - no emitted code) */

/* ---- MCRD_savefile  (memcard.c:663, code lines 663-748) ---- */
int MCRD_savefile(int card,MCRDFILE_def *pFILE)

{
  short sjis;
  uint len;
  uchar *clut;
  MCRDFILE_def *pScan;
  char *src;
  int i;
  int nIcons;
  MCRDFILEINFO_def *pMFI;
  int ret;
  
  ret = (int)&gMemCardInfo.fileinfo /* 0x80052fc8; +0x30 -> .header.title[] */;
  if ((pFILE->size & 0x7fU) == 0) {
    blockclear(&gMemCardInfo.fileinfo,0x23c);
    gMemCardInfo.fileinfo.header.magicnumber[0] = 'S';
    gMemCardInfo.fileinfo.header.magicnumber[1] = 'C';
    strcpy(gMemCardInfo.fileinfo.name,gMemCardInfo.productCode);
    src = pFILE->name;
    strcat(gMemCardInfo.fileinfo.name,src);
    gMemCardInfo.fileinfo.size = pFILE->size;
    gMemCardInfo.fileinfo.flags = pFILE->flags;
    gMemCardInfo.fileinfo.offset = pFILE->offset;
    gMemCardInfo.fileinfo.pData = pFILE->pData;
    i = 0;
    gMemCardInfo.fileinfo.cardnum = card;
    if ((pFILE->flags & 0x200) != 0) {
      nIcons = 0;
      pScan = pFILE;
      do {
        if (pScan->icon[0] != (shapetbl *)0x0) {
          nIcons = nIcons + 1;
        }
        i = i + 1;
        pScan = (MCRDFILE_def *)&pScan->title;
      } while (i < 3);
      if (nIcons == 0) {
        return -1;
      }
      gMemCardInfo.fileinfo.header.type = (char)nIcons + '\x10';
      i = pFILE->size + 0x2000;
      gMemCardInfo.fileinfo.header.nslots = (uchar)(i >> 0xd);
      if (i < 0) {
        gMemCardInfo.fileinfo.header.nslots = (uchar)(pFILE->size + 0x3fff >> 0xd);
      }
      if (pFILE->title == (char *)0x0) {
        return -1;
      }
      len = strlen(pFILE->title);
      if (len == 0) {
        return -1;
      }
      len = strlen(pFILE->title);
      i = 0;
      if (0x20 < len) goto MCRDsave_errorDefault;
      do {
        sjis = ascii2sjis(pFILE->title[i]);
        *(short *)(ret + 0x30) = sjis;
        if (sjis == 0) break;
        i = i + 1;
        ret = ret + 2;
      } while (i < 0x20);
      clut = getshapeclut(pFILE->icon[0],(int)src);
      blockmove(clut + 0x10,gMemCardInfo.fileinfo.header.iconclut,0x20);
      blockmove
                (&pFILE->icon[0]->data,gMemCardInfo.fileinfo.header.icon1,0x80);
      if ((1 < nIcons) &&
         (blockmove
                    (&pFILE->icon[1]->data,gMemCardInfo.fileinfo.header.icon2,0x80), nIcons == 3)) {
        blockmove
                  (&pFILE->icon[2]->data,gMemCardInfo.fileinfo.header.icon3,0x80);
      }
    }
    ret = 0;
    gMemCardInfo.task = WRITE_FILE;
    gMemCardInfo.bReady = 0;
  }
  else {
MCRDsave_errorDefault:
    ret = -1;
  }
  return ret;
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
  
  if ((gMemCardInfo.fileinfo.flags & 0x200) != 0) {
    res = MemCardCreateFile
                    (gMemCardInfo.channel,gMemCardInfo.fileinfo.name,
                     (uint)gMemCardInfo.fileinfo.header.nslots);
    err_state = iMCRD_HandleError(2,res,card);
    if (err_state != 0) {
      return err_state;
    }
    timedwait(0x40);
    res = MemCardWriteFile
                    (gMemCardInfo.channel,gMemCardInfo.fileinfo.name,
                     (u_long *)&gMemCardInfo.fileinfo.header,0,0x200);
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
                  (gMemCardInfo.channel,gMemCardInfo.fileinfo.name,
                   (u_long *)gMemCardInfo.fileinfo.pData,gMemCardInfo.fileinfo.offset + 0x200,
                   gMemCardInfo.fileinfo.size);
  if (res == 0) {
    gMemCardInfo.bReady = 1;
    return 0xd;
  }
  do {
    sync = MemCardSync(0,&cmd,&res);
  } while (sync == 0);
  err = iMCRD_HandleError(2,res,card);
  if (err == 0) {
    gMemCardInfo.task = LOAD_CARD;
    gMemCardInfo.bReady = 0;
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
  del_res = MemCardDeleteFile
                      (gMemCardInfo.channel,gMemCardInfo.fileinfo.name);
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
  CARDINFO_def *pCI;
  long sync;
  int ret;
  int status;
  u_long cmd;
  u_long res;
  
  ret = 0x17;
  pCI = MCRD_getcard(card);
  sync = MemCardSync(0,(long *)&cmd,(long *)&res);
  if (sync == 0) {
    return 0x15;
  }
  if (sync < 1) {
    if (sync != -1) {
      return 0x17;
    }
    switch(gMemCardInfo.task) {
    case NONE:
      if (gMemCardInfo.existencecheckticks[card + -1] < 0) {
        gMemCardInfo.bReady = 0;
        sync = MemCardExist(gMemCardInfo.channel);
        if (sync != 0) {
          return 0x15;
        }
        return 0x17;
      }
      goto MCRDhandleCard_returnCode22;
    case LOAD_CARD:
      ret = 0x17;
      if (card == gMemCardInfo.fileinfo.cardnum) {
        pCI->lasterror = 0;
        gMemCardInfo.bReady = 0;
        gMemCardInfo.task = NONE;
        ret = iMCRD_LoadCard(card);
      }
      break;
    case WRITE_FILE:
      ret = 0x17;
      if (card == gMemCardInfo.fileinfo.cardnum) {
        pCI->lasterror = 0;
        gMemCardInfo.bReady = 0;
        gMemCardInfo.task = NONE;
        ret = iMCRD_DoFileWrite(card);
      }
      break;
    case LOAD_FILE:
      ret = 0x17;
      if (card == gMemCardInfo.fileinfo.cardnum) {
        pCI->lasterror = 0;
        gMemCardInfo.bReady = 0;
        gMemCardInfo.task = NONE;
        ret = iMCRD_DoFileLoad(card);
      }
      break;
    case DELETE_FILE:
      ret = 0x17;
      if (card == gMemCardInfo.fileinfo.cardnum) {
        pCI->lasterror = 0;
        gMemCardInfo.bReady = 0;
        gMemCardInfo.task = NONE;
        ret = iMCRD_DoFileDelete(card);
      }
    }
  }
  else {
    if (sync != 1) {
      return 0x17;
    }
    if (cmd != 1) {
      if (cmd == 2) {
        switch(res) {
        case 0:
        case 3:
          gMemCardInfo.task = LOAD_CARD;
          gMemCardInfo.fileinfo.cardnum = card;
          return 4;
        case 1:
          iMCRD_InitCard(card);
          pCI->status = -1;
          return 2;
        case 2:
          iMCRD_InitCard(card);
          return 3;
        case 4:
          pCI->status = -2;
          return 5;
        default:
          return 0x17;
        }
      }
      return 0x17;
    }
    if (res == 1) {
      gMemCardInfo.bReady = cmd;
      gMemCardInfo.existencecheckticks[card + -1] = timerhz;
      pCI->status = -1;
      return 2;
    }
    if (res != 0) {
      if (res == 2) {
        gMemCardInfo.bReady = cmd;
        pCI->status = -4;
        return 3;
      }
      if (res == 3) {
        MemCardAccept(gMemCardInfo.channel);
        return 0x15;
      }
      return 0x17;
    }
    gMemCardInfo.bReady = cmd;
    gMemCardInfo.existencecheckticks[card + -1] = timerhz;
    if (pCI->status == -1) {
      MemCardAccept(gMemCardInfo.channel);
      return 0x16;
    }
MCRDhandleCard_returnCode22:
    ret = 0x16;
  }
  return ret;
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
extern "C" void iMCRD_timersub(void)

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
  
  pCI = MCRD_getcard(card);
  fmtRes = MemCardFormat(gMemCardInfo.channel);
  if (fmtRes == 1) {
    result = -1;
  }
  else {
    result = 0;
    if ((fmtRes < 2) || (result = 0, fmtRes != 2)) goto iMCRDformat_setReady;
    result = -4;
  }
  pCI->status = result;
  result = -1;
iMCRDformat_setReady:
  pCI->status = 0;
  pCI->freeblocks = 0xf;
  return result;
}

/* lines 1733-1736: (static data / macros / comments - no emitted code) */

/* ---- iMCRD_HandleError  (memcard.c:1737, code lines 1737-1895) ---- */
int iMCRD_HandleError(int func,int opResult,int card)

{
  CARDINFO_def *pcard;
  long accept;
  int confirm;
  int scratch_i;
  int tmp_int;
  int result;
  int numberoftries;
  CARDINFO_def *pCI;
  int code;
  int ret_state;
  
  ret_state = 0;
  pcard = MCRD_getcard(card);
  if (opResult != 0) {
    if (func == 2) {
      ret_state = 0xd;
    }
    else if (func < 3) {
      if (func == 1) {
        ret_state = 10;
      }
    }
    else if (func == 3) {
      ret_state = 0x10;
    }
  }
  switch(opResult) {
  case 0:
    goto iMCRDError_return;
  case 1:
    pcard->status = -1;
    tmp_int = 2;
    break;
  case 2:
    pcard->status = -4;
    tmp_int = 3;
    break;
  case 3:
    accept = MemCardAccept(gMemCardInfo.channel);
    if (accept != 0) {
      gMemCardInfo.task = LOAD_CARD;
      gMemCardInfo.bReady = 0;
      return ret_state;
    }
    scratch_i = 0x17;
    goto iMCRDError_setLastError;
  case 4:
    if (func == 2) {
      confirm = ((int(*)(void))gMemCardInfo.ConfirmFormatProc)();
      numberoftries = 0;
      if (confirm != 0) {
        do {
          confirm = iMCRD_FormatCard(card);
          numberoftries = numberoftries + 1;
          if (confirm != -1) {
            gMemCardInfo.task = WRITE_FILE;
            return 6;
          }
        } while (numberoftries < 3);
        pcard->status = -2;
        tmp_int = 7;
        break;
      }
    }
    pcard->status = -2;
    tmp_int = 5;
    break;
  case 5:
    tmp_int = 0x13;
    break;
  case 6:
    confirm = ((int(*)(void))gMemCardInfo.ConfirmOverwriteProc)();
    scratch_i = 0xe;
    if (confirm != 0) {
      MemCardDeleteFile(gMemCardInfo.channel,gMemCardInfo.fileinfo.name);
      gMemCardInfo.task = WRITE_FILE;
      return 0x15;
    }
iMCRDError_setLastError:
    pcard->lasterror = scratch_i;
    gMemCardInfo.bReady = 1;
    return ret_state;
  case 7:
    tmp_int = 0x14;
    break;
  default:
    tmp_int = 0x17;
  }
  pcard->lasterror = tmp_int;
  gMemCardInfo.bReady = 1;
iMCRDError_return:
  return ret_state;
}

/* lines 1896-1897: (static data / macros / comments - no emitted code) */

/* ---- iMCRD_DefaultCBProc1  (memcard.c:1898, code lines 1898-1899) ---- */
int iMCRD_DefaultCBProc1(void)

{
  return 1;
}

/* lines 1900-2062: (static data / macros / comments - no emitted code) */

/* ---- ascii2sjis  (memcard.c:2063, code lines 2063-2096) [static] ---- */
extern "C" short ascii2sjis(u_char ascii_code)

{
  ushort sjis_code;
  byte stmp;
  uint code;
  byte stmp2;
  int kind;
  
  stmp = 0;
  kind = 0;
  if ((byte)(ascii_code - 0x20) < 0x10) {
    kind = 1;
  }
  else if (9 < (byte)(ascii_code - 0x30)) {
    if ((byte)(ascii_code - 0x3a) < 7) {
      kind = 0xb;
    }
    else if ((byte)(ascii_code + 0xbf) < 0x1a) {
      stmp = 1;
    }
    else if ((byte)(ascii_code + 0xa5) < 6) {
      kind = 0x25;
    }
    else if ((byte)(ascii_code + 0x9f) < 0x1a) {
      stmp = 2;
    }
    else {
      kind = 0x3f;
      if (3 < (byte)(ascii_code + 0x85)) {
        return 0;
      }
    }
  }
  if (kind == 0) {
    code = ((uint)ascii_table[stmp][0] + (uint)ascii_code) - (uint)ascii_table[stmp][1];
    sjis_code = (short)code * 0x100;
  }
  else {
    code = (uint)ascii_k_table[(uint)ascii_code - (kind + 0x1f)];
    sjis_code = ascii_k_table[(uint)ascii_code - (kind + 0x1f)] << 8;
  }
  return sjis_code | (ushort)(code >> 8) & 0xff;
}

/* lines 2097-2101: (static data / macros / comments - no emitted code) */

/* ---- sjis2ascii  (memcard.c:2102, code lines 2102-2122) [static] ---- */
extern "C" u_char sjis2ascii(short sjis_code)

{
  uint hi;
  int kind;

  kind = 0;
  hi = (int)((uint)(ushort)sjis_code << 0x10) >> 0x18;
  if ((sjis_code & 0xffU) == 0x81) {
    return *(uchar *)((int)ascii_k_table + (hi & 0xff) + 0xc);
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
    return sjis_table[kind][1] + ((char)((ushort)sjis_code >> 8) - sjis_table[kind][0]);
  }
  return '\0';
}

/* end of memcard.c */
