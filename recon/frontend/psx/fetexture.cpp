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
  /* SYM 8c: fsize 88, mask $807f0000 (ra,s6..s0).  REGPARM f($a0) index($a1)
   * dest($s3) yoffset($s5); ARG xoffset @+0x10 copied to REG $s6.  Locals are
   * EXACTLY: shpptr(shapetbl* $s2) old_shape(shapetbl AUTO -0x40 = sp+0x18)
   * bpp(int $a0) xclut(AUTO sp+0x30) yclut(AUTO sp+0x34) unpacked(shapetbl* $s1)
   * + block-scoped is_compressed(char $s4) and oldptr(char*)/newptr(int).
   * Ghidra's savedHdr0..4 are ONE `shapetbl old_shape` struct copy (the oracle's
   * 4-word + 1-word movstrsi block, save AND restore); ts1[20]/ts2..ts5/tc6/
   * loc_48/shapeData/decompBuf/clutmode/hdrflags/uploadResult were fictions. */
  shapetbl *unpacked;
  int yclut;
  int xclut;
  int bpp;
  shapetbl old_shape;
  shapetbl *shpptr;

  xclut = 0;
  yclut = 0;
  shpptr = (shapetbl *)shapepointer(f,index);
  if (shpptr != 0) {
    char is_compressed;

    is_compressed = *(char *)shpptr & 0x80;
    if (is_compressed != 0) {
      char *oldptr;
      int newptr;

      oldptr = (char *)shpptr + 0x10;
      unpacked = (shapetbl *)reservememadr("unpacked",unpacksize(oldptr) + 0x10,0);
      blockmove(shpptr,unpacked,0x10);
      newptr = (int)unpacked + 0x10;
      unpack(oldptr,(void *)newptr);
      *(char *)unpacked = *(char *)unpacked & 0x7f;
      *(u_int *)unpacked =
           (u_int)*(u_char *)unpacked |
           ((int)shpptr + (*(int *)shpptr >> 8) - (int)unpacked) * 0x100;
    }
    else {
      unpacked = shpptr;
    }
    bpp = *(u_char *)unpacked & 3;
    if (bpp != 2) {
      Texture_GetClutId(bpp,&xclut,&yclut);
      dest->clutID = yclut << 6 | xclut >> 4 & 0x3f;
    }
    old_shape = *unpacked;
    vramfxya(unpacked,unpacked->shapex + xoffset,unpacked->shapey + yoffset,xclut,yclut);
    dest->shpptr = shpptr;
    dest->type = *(u_char *)unpacked;
    dest->next = *(u_int *)unpacked >> 8;   /* next:24 bitfield */
    dest->width = unpacked->width;
    dest->height = unpacked->height;
    dest->centerx = unpacked->centerx;
    dest->centery = unpacked->centery;
    dest->shapex = unpacked->shapex;
    dest->shapey = unpacked->shapey;
    dest->depth = shapedepth(unpacked);
    dest->tpage = ((u_char)dest->type & 3) << 7 | (short)(dest->shapey & 0x100U) >> 4 |
                  (ushort)(((ushort)dest->shapex & 0x3ff) >> 6) | (dest->shapey & 0x200U) << 2;
    dest->clut = GetClut((dest->clutID & 0x3fU) << 4,dest->clutID >> 6);
    if ((yoffset != 0) || (xoffset != 0)) {
      *unpacked = old_shape;
    }
    if (is_compressed != 0) {
      purgememadr(unpacked);
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
