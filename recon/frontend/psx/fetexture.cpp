/* frontend/psx/fetexture.cpp  --  RECONSTRUCTED  (FE PSH/PMX texture loader; C++ TU)
 *   Bodies: Ghidra decompiler. Line numbers: PsyQ SLD (8c-start, 8e-end).
 *   2 functions; LoadPmx is a thin wrapper over LoadPmxAtOffset(f,index,dest,0,0).
 *   dest is tTexture_ShapeInfo*; the type:8 / next:24 bitfields appear as field_0x9 /
 *   *(uint*)&field_0xc in the decompiler -> mapped to the named bitfields here.
 *   Most locals carry the project's earlier deep-inspection names; remaining iVar/uVar
 *   are decompiler scratch temps. C++ linkage (mangled in SYM, not extern "C").
 */
#include "fetexture.h"
#include "fetexture_externs.h"

/* lines 1-22: file header, #includes, static data, macros (no symbols emitted) */

/* ---- FETexture_LoadPmxAtOffset  (fetexture.cpp:23, code lines 23-115) ---- */
void FETexture_LoadPmxAtOffset(char *f,int index,tTexture_ShapeInfo *dest,int yoffset,int xoffset)

{
  byte hdrflags;
  short tpage_or_clut;
  int newptr;
  char *oldptr;
  int shapeData;
  int shapeDataSize;
  int decompBuf;
  int uploadResult;
  int bpp;
  uint clutmode;
  uint savedHdr4;
  int savedHdr0;
  uint savedHdr1;
  uint savedHdr2;
  int savedHdr3;
  shapetbl *unpacked;
  shapetbl *shpptr;
  char is_compressed;
  int loc_48;
  shapetbl old_shape;
  int xclut;
  int yclut;
  byte ts1 [20];
  short ts4;
  short ts5;
  short ts2;
  short ts3;
  byte tc6;
  
  xclut = 0;
  yclut = 0;
  shapeData = (int)shapepointer(f,index);
  if (shapeData != 0) {
    hdrflags = *(byte *)shapeData;
    decompBuf = shapeData;
    if ((hdrflags & 0x80) != 0) {
      shapeDataSize = unpacksize((void *)(shapeData + 0x10));
      decompBuf = (int)reservememadr("unpacked",shapeDataSize + 0x10,0);
      blockmove((void *)shapeData,(void *)decompBuf,0x10);
      oldptr = (char *)(shapeData + 0x10);
      newptr = decompBuf + 0x10;
      unpack(oldptr,(void *)newptr);
      *(byte *)decompBuf = *(byte *)decompBuf & 0x7f;
      *(uint *)decompBuf =
           (uint)*(byte *)decompBuf | ((shapeData + (*(int *)shapeData >> 8)) - decompBuf) * 0x100;
    }
    clutmode = (byte)*(uint *)decompBuf & 3;
    if (clutmode != 2) {
      Texture_GetClutId(clutmode,&xclut,&yclut);
      dest->clutID = yclut << 6 | xclut >> 4 & 0x3fU;
    }
    savedHdr0 = *(int *)decompBuf;
    savedHdr1 = *(uint *)(decompBuf + 4);
    savedHdr2 = *(uint *)(decompBuf + 8);
    savedHdr3 = *(uint *)(decompBuf + 0xc);
    savedHdr4 = *(uint *)(decompBuf + 0x10);
    vramfxya
              ((void *)decompBuf,
               (short)((int)(*(uint *)(decompBuf + 0xc) << 0x14) >> 0x14) + (short)xoffset,
               (short)((int)(*(uint *)(decompBuf + 0xc) << 4) >> 0x14) + (short)yoffset,(short)xclut
               ,yclut);
    dest->shpptr = (shapetbl *)shapeData;
    dest->type = (byte)*(uint *)decompBuf;
    dest->next = *(uint *)decompBuf >> 8;   /* next:24 bitfield */
    dest->width = (short)*(uint *)(decompBuf + 4);
    dest->height = *(short *)(decompBuf + 6);
    dest->centerx = (short)*(uint *)(decompBuf + 8);
    dest->centery = *(short *)(decompBuf + 10);
    dest->shapex = (short)((int)(*(uint *)(decompBuf + 0xc) << 0x14) >> 0x14);
    dest->shapey = (short)((int)(*(uint *)(decompBuf + 0xc) << 4) >> 0x14);
    uploadResult = shapedepth((void *)decompBuf);
    dest->depth = (char)uploadResult;
    dest->tpage = ((byte)dest->type & 3) << 7 | (short)(dest->shapey & 0x100U) >> 4 |
                  (ushort)(((ushort)dest->shapex & 0x3ff) >> 6) | (dest->shapey & 0x200U) << 2;
    tpage_or_clut = GetClut((dest->clutID & 0x3fU) << 4,dest->clutID >> 6);
    dest->clut = tpage_or_clut;
    if ((yoffset != 0) || (xoffset != 0)) {
      *(int *)decompBuf = savedHdr0;
      *(uint *)(decompBuf + 4) = savedHdr1;
      *(uint *)(decompBuf + 8) = savedHdr2;
      *(int *)(decompBuf + 0xc) = savedHdr3;
      *(uint *)(decompBuf + 0x10) = savedHdr4;
    }
    if ((hdrflags & 0x80) != 0) {
      purgememadr((void *)decompBuf);
    }
  }
  return;
}

/* lines 116-124: (static data / macros / comments - no emitted code) */

/* ---- FETexture_LoadPmx  (fetexture.cpp:125, code lines 125-126) ---- */
void FETexture_LoadPmx(char *f,int index,tTexture_ShapeInfo *dest)

{
  
  FETexture_LoadPmxAtOffset(f,index,dest,0,0);
  return;
}

/* end of fetexture.cpp */