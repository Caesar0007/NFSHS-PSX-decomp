/* frontend/psx/mdec.cpp  --  RECONSTRUCTED  (PSX MDEC / DCT video-frame decode)
 *   Bodies      : Ghidra decompiler (nfs4-f.exe MIPS), full re-decompile.
 *   Line numbers: PsyQ SLD per-instruction stream (cross-checked 8c-start/8e-end).
 *   Field names : SYM-authentic MDECSTRUCT layout incl. nested RECT framerect/striprect.
 *   Linkage     : initmdec/restoremdec/mdec/mdecdone = extern "C" (unmangled in SYM);
 *                 mdecreset/MDECCompleteHandler = normal C++ (cfront-mangled in SYM).
 *   Locals      : SYM-authentic `mdec` (MDECSTRUCT* cast) + `timeout`; others semantic
 *                 (area/bufsize/buf/hs/stride/mode/drawsync/nextx). Magic 0x4345444d='MDEC'.
 */
#include "mdec.h"
#include "mdec_externs.h"

/* lines 1-91: file header, #includes, static data (DECDCTTAB), macros (no symbols) */

/* ---- initmdec  (mdec.cpp:92, code lines 92-145) ---- */
int initmdec(int width,int height,int bpp,int memtype)

{
  int area;
  void *buf;
  short hs;
  int stride;
  void *bufsize;
  MDECSTRUCT *mdec;
  
  mdec = (MDECSTRUCT *)reservememadr("MDECstruct",0x2c,memtype);
  blockclear(mdec,0x2c);
  mdec->id = 0x4345444d;   /* 'MDEC' */
  if (gMDECinfo.numhandles == 0) {
    DecDCTReset(0);
    DecDCToutCallback(MDECCompleteHandler);
  }
  area = ((width + 0xfU) & 0xfffffff0) * ((height + 0xfU) & 0xfffffff0);
  mdec->width = width;
  mdec->height = height;
  mdec->bpp = bpp;
  if (area < 0) {
    area = area + 0xff;
  }
  bufsize = (void *)(bpp * 0x1e0 + (area >> 8) * 0x300);
  buf = reservememadr("MDEC buffers",(int)bufsize,memtype);
  mdec->stripbuf = (u_long *)buf;
  blockclear(buf,(int)bufsize);
  stride = width * bpp;
  mdec->striprect.w = (short)bpp;
  mdec->vlcbuf = (u_long *)((int)mdec->stripbuf + bpp * 0x1e0);
  if (stride < 0) {
    stride = stride + 0xf;
  }
  hs = (short)height;
  mdec->framerect.h = hs;
  mdec->framerect.w = (short)(stride >> 4);
  mdec->striprect.h = hs;
  mdec->striprectsize =
       ((int)mdec->striprect.w * (int)hs) / 2;
  gMDECinfo.numhandles = gMDECinfo.numhandles + 1;
  return (int)mdec;
}

/* lines 146-179: (static data / macros / comments - no emitted code) */

/* ---- restoremdec  (mdec.cpp:180, code lines 180-205) ---- */
void restoremdec(int handle)

{
  MDECSTRUCT *mdec = (MDECSTRUCT *)handle;
  
  gMDECinfo.numhandles = gMDECinfo.numhandles + -1;
  if (gMDECinfo.numhandles == 0) {
    DecDCToutCallback(0);
  }
  purgememadr(mdec->stripbuf);
  mdec->id = 0;
  purgememadr(mdec);
  return;
}

/* lines 206-238: (static data / macros / comments - no emitted code) */

/* ---- mdecreset  (mdec.cpp:239, code lines 239-245) ---- */
void mdecreset(void)

{
  if (gMDECinfo.numhandles != 0) {
    DecDCTReset(0);
    DecDCToutCallback(MDECCompleteHandler);
  }
  gMDECinfo.hDecode = 0;
  return;
}

/* lines 246-294: (static data / macros / comments - no emitted code) */

/* ---- mdec  (mdec.cpp:295, code lines 295-338) ---- */
void mdec(int handle,char *src,int x,int y)

{
  long mode;
  int timeout;
  MDECSTRUCT *mdec = (MDECSTRUCT *)handle;
  
  timeout = ticks + timerhz * 4;
  while (gMDECinfo.hDecode != 0) {
    systemtask(0);
    if (timeout < ticks) {
      mdecreset();
    }
  }
  gMDECinfo.hDecode = handle;
  DecDCTvlc((u_long *)(src + 8),mdec->vlcbuf);
  mode = 2;
  mdec->striprect.x = (short)x;
  mdec->framerect.x = (short)x;
  mdec->striprect.y = (short)y;
  mdec->framerect.y = (short)y;
  if (mdec->bpp == 0x18) {
    mode = 3;
  }
  DecDCTin(mdec->vlcbuf,mode);
  DecDCTout(mdec->stripbuf,mdec->striprectsize);
  return;
}

/* lines 339-380: (static data / macros / comments - no emitted code) */

/* ---- mdecdone  (mdec.cpp:381, code lines 381-382) ---- */
int mdecdone(int handle)

{
  return (uint)(gMDECinfo.hDecode != handle);
}

/* lines 383-387: (static data / macros / comments - no emitted code) */

/* ---- MDECCompleteHandler  (mdec.cpp:388, code lines 388-415) ---- */
void MDECCompleteHandler(void)

{
  short nextx;
  long drawsync;
  MDECSTRUCT *mdec = (MDECSTRUCT *)gMDECinfo.hDecode;
  
  LoadImage
            (&mdec->striprect,mdec->stripbuf);
  drawsync = DrawSync(0);
  if (drawsync != 0) {
    g_mdecdrawsyncfailed[0] = 1;
  }
  nextx = mdec->striprect.x + mdec->bpp;
  mdec->striprect.x = nextx;
  if ((int)nextx < (int)mdec->framerect.x + (int)mdec->framerect.w) {
    DecDCTout(mdec->stripbuf,mdec->striprectsize);
  }
  else {
    gMDECinfo.hDecode = 0;
  }
  return;
}

/* end of mdec.cpp */