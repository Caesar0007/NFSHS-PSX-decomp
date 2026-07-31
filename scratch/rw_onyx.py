# -*- coding: utf-8 -*-
import re
p = 'recon/game/psx/draww.cpp'
src = open(p, encoding='utf-8').read()
start = src.index('/* ---- DrawW_OnyxLinePrim__')
end   = src.index('/* ---- DrawW_BuildChunkCenterLineFacets__')
old = src[start:end]

m = re.search(r'( *__asm__ volatile\(.*?"memory"\);\n)', old, re.S)
asm = m.group(1)
asm = asm.replace('\n              ', '\n        ').replace('\n                  ', '\n            ')
asm = '        ' + asm.lstrip(' ')

new = r'''/* ---- DrawW_OnyxLinePrim__FP8CCOORD16P8Trk_LineiP25Draw_tGiveShelbyMoreCache  [DRAWW.CPP:3108-3330] SLD-VERIFIED ----
   REWRITTEN 2026-07-31 (w38-a2) from the SYM 8c block + raw oracle.  The prior body was
   Ghidra soup (~50 fabricated locals) and carried FOUR behavioural bugs (see below).
   SYM ground truth (nfs4-f-v3.txt @0x800C98B8, fsize 120, mask 0xc0ff0000):
     REGPARM geomVertices=$s3 lineQuad=$s6 sd=$s1;  count = class ARG (stack home 0x80(sp),
     re-loaded at every loop test -- never register-cached);
     REG   prim=$s0 (POLY_GT4*), lineQuadCount=$fp, pmx=$s4 (Draw_tPixMap*),
           linetype=$v0, save_pre_otz=$s7, t1/t2=$a0/$a1 (the 8-byte vertex-copy temps),
           a/b=$v1/$v0 (night colour words), l0..l3=$v0/$v1/$a0/$a1 (pmx word copy),
           depth_index=$a1;
     AUTO  vt0..vt3 @0x10/0x18/0x20/0x28, temp0(VECTOR)/a(CVECTOR) SHARE @0x30,
           bfct @0x40, depthcue @0x44, doSubdivision @0x4C;
     LABEL loopbot  -> the rejection paths are `goto loopbot`, not nested ifs.
   BUGS FIXED (all oracle-cited):
    1. vt0/vt1 were NEVER INITIALISED -- the old body only filled vt2/vt3, so two of the
       four RTPS transforms ran on garbage stack.  Oracle @0x800C9950-0x800C997C copies
       four whole CCOORD16s: vt0=geomVertices[3], vt1=[1], vt2=[0], vt3=[2].
    2. pmx: oracle `lbu type; sll 2; addu gDLPixmap; lw s4,0(v0)` = pmx = gDLPixmap[type]
       (gDLPixmap is an ARRAY OF POINTERS).  The old body used &gDLPixmap[type] and then
       read the pixmap words out of the POINTER TABLE itself.
    3. gte_stsxy3 targets are Render_gPacketPtr + 0x14/0x2C/0x20 (oracle keeps the packet
       cursor in $s0 from the +8 store above), NOT the scratchpad literals 0x1F800014 /
       0x1F80002C / 0x1F800020 -- same bug class as the +8 store fixed in 2026-07-12.
    4. Night_NightCopCalc was called with (temp0, (short*)sd); oracle passes &vt2.light
       (`addiu a1,sp,0x26`) and &vt3.light (`addiu a1,sp,0x2E`).
   MATCH shapes taken from the oracle: whole-struct CCOORD16/CVECTOR assignments (the
   align-1 CVECTOR ones expand to the oracle's lwl/lwr+swl/swr movstrsi runs, the u_long
   casts to plain lw/sw); the night colour path stores WORDS (4 stores), not 16 bytes;
   the pmx->prim copy is the SYM's load-4/store-4 l0..l3 group; `if (nightFlags)` has the
   NIGHT arm as the fall-through (oracle `beqz -> .L800C9E14` = the dpcs arm is out of
   line); the stack-speedup `if` likewise has the speedup arm as fall-through. ---- */
void DrawW_OnyxLinePrim(CCOORD16 *geomVertices,Trk_Line *lineQuad,int count,Draw_tGiveShelbyMoreCache *sd)

{
  POLY_GT4 *prim;
  int lineQuadCount;
  Draw_tPixMap *pmx;
  CCOORD16 vt0;
  CCOORD16 vt1;
  CCOORD16 vt2;
  CCOORD16 vt3;

  sd->offsubdivid = 0x200;
  for (lineQuadCount = 0; lineQuadCount < count + -1;
       lineQuadCount = lineQuadCount + 1, lineQuad = lineQuad + 1, geomVertices = geomVertices + 2) {
    int linetype;

    while ((lineQuadCount < count + -1) && (lineQuad->type != 0xff)) {
      int doSubdivision;
      int save_pre_otz;
      int depthcue;
      u_char *packetPtr;

      linetype = lineQuad->type;
      pmx = gDLPixmap[linetype];
      vt0 = geomVertices[3];
      vt1 = geomVertices[1];
      vt2 = geomVertices[0];
      vt3 = geomVertices[2];
      gte_ldv0((int *)(&vt0));
      gte_rtps();
      gte_stlvnl(((char *)sd + 0x98));
      /* CORRECTNESS (oracle @0x800C99C8): the SXY writes target the CURRENT packet
       * cursor (Render_gPacketPtr + 8 / +0x14 / +0x2C / +0x20), never the fixed
       * scratchpad literals -- 0x1F800008 is Render_gPacketEnd's own slot. */
      packetPtr = Render_gPacketPtr;
      gte_swc2(0xe,(void *)(packetPtr + 8));
      gte_ldv0((int *)(&vt1));
      gte_rtps();
      gte_stlvnl(((char *)sd + 0xa8));
      gte_ldv0((int *)(&vt2));
      gte_rtps();
      gte_stlvnl(((char *)sd + 0xb8));
      gte_ldv0((int *)(&vt3));
      gte_rtps();
      gte_stlvnl(((char *)sd + 0xc8));
      if (!((((sd->tVn0).vx < (sd->tVn0).vz || ((sd->tVn1).vx < (sd->tVn1).vz)) ||
             ((sd->tVn2).vx < (sd->tVn2).vz)) || ((sd->tVn3).vx < (sd->tVn3).vz))) goto loopbot;
      if (!((((-(sd->tVn0).vx < (sd->tVn0).vz) || (-(sd->tVn1).vx < (sd->tVn1).vz)) ||
             (-(sd->tVn2).vx < (sd->tVn2).vz)) || (-(sd->tVn3).vx < (sd->tVn3).vz))) goto loopbot;
      gte_stsxy3((void *)(packetPtr + 0x14),(void *)(packetPtr + 0x2c),(void *)(packetPtr + 0x20));
      {
        long bfct;

        gte_avsz4();
        gte_swc2(0x7,&sd->otz);
        gte_nclip();
        gte_swc2(0x18,&bfct);
        if ((sd->head).mirror == 1) {
          bfct = -bfct;
        }
        if (bfct < 0) goto loopbot;
      }
      save_pre_otz = sd->otz >> 1;
      doSubdivision = (int)(sd->otz < 200);
      sd->otz = save_pre_otz + 0x4b;
      if (sd->otz <= 0) goto loopbot;
      if (Draw_gViewOtSize + -3 < sd->otz) goto loopbot;
      if (doSubdivision != 0) {
        prim = &sd->GT4Prim;
      }
      else {
        /* OT-link, EA DMPSX-analog FIXED-REG TEMPLATE ($t4/$t5/$t6 scratches; same shape
         * as DrawW_SubdividFacet / DrawW_DrawQuad's sealed instances): slot =
         * sd->head.cprim.LastPrim + sd->otz*4; sd->head.cprim.PrimPtr = prim+0x34;
         * prim->tag = slot->addr24 | (0x0C<<24); slot->addr24 = prim. */
        int primSlot;

        primSlot = (int)(sd->head).cprim.PrimPtr;
ASMBLOCK        prim = (POLY_GT4 *)primSlot;
      }
      gte_swc2(0x8,&depthcue);
      if (sd->nightFlags != 0) {
        if ((sd->nightFlags & 1U) != 0) {
          VECTOR temp0;

          gte_SetRotMatrix(((char *)sd + 0x34));
          gte_SetTransMatrix(((char *)sd + 0x34));
          gte_ldv0((int *)(&vt2));
          gte_rt();
          gte_stlvnl(&temp0);
          gte_ldv0((int *)(&vt3));
          gte_rt();
          Night_NightCalc(&temp0,&vt2.light,sd);
          gte_stlvnl(&temp0);
          Night_NightCalc(&temp0,&vt3.light,sd);
        }
        if (BW_gCopCarObj != (Car_tObj *)0x0) {
          VECTOR temp0;

          gte_SetRotMatrix(((char *)sd + 0x54));
          gte_SetTransMatrix(((char *)sd + 0x54));
          gte_ldv0((int *)(&vt2));
          gte_rt();
          gte_stlvnl(&temp0);
          gte_ldv0((int *)(&vt3));
          gte_rt();
          Night_NightCopCalc(&temp0,&vt2.light);
          gte_stlvnl(&temp0);
          Night_NightCopCalc(&temp0,&vt3.light);
        }
        {
          long a;
          long b;

          a = *(long *)&Chunk_lightTable[vt3.light];
          b = *(long *)&Chunk_lightTable[vt2.light];
          *(long *)&prim->r3 = b;
          *(long *)&prim->r1 = b;
          *(long *)&prim->r2 = a;
          *(long *)&prim->r0 = a;
        }
        gte_SetRotMatrix(((char *)sd + 0x14));
        gte_SetTransMatrix(((char *)sd + 0x14));
      }
      else {
        CVECTOR a;

        /* the CVECTOR (align-1) struct assignments ARE the oracle's lwl/lwr + swl/swr
         * movstrsi runs; a u_long cast here would emit aligned lw/sw instead. */
        a = *(CVECTOR *)&Chunk_lightTable[vt3.light];
        gte_ldrgb(&a);
        gte_ldIR0(&depthcue);
        gte_dpcs();
        gte_swc2(0x16,(char *)prim + 0x1c);
        *(CVECTOR *)&prim->r0 = *(CVECTOR *)&prim->r2;
        a = *(CVECTOR *)&Chunk_lightTable[vt2.light];
        gte_ldrgb(&a);
        gte_ldIR0(&depthcue);
        gte_dpcs();
        gte_swc2(0x16,(char *)prim + 0x28);
        *(CVECTOR *)&prim->r1 = *(CVECTOR *)&prim->r3;
      }
      prim->code = 0x3e;
      *(u_char *)((int)&prim->tag + 3) = 0xc;
      {
        u_long l0;
        u_long l1;
        u_long l2;
        u_long l3;

        l0 = *(u_long *)&pmx->u0;
        l1 = *(u_long *)&pmx->u1;
        l2 = *(u_long *)&pmx->u2;
        l3 = *(u_long *)&pmx->u3;
        *(u_long *)&prim->u0 = l0;
        *(u_long *)&prim->u1 = l1;
        *(u_long *)&prim->u2 = l2;
        *(u_long *)&prim->u3 = l3;
      }
      if (prim->clut == 0xffff) {
        int depth_index;

        depth_index = (save_pre_otz - sd->startfog) * 0x10 >> ((int)sd->distfog);
        if (depth_index < 0) {
          depth_index = 0;
        }
        else if (0xf < depth_index) {
          depth_index = 0xf;
        }
        prim->clut = gClutDepth[pmx->pad2][depth_index];
      }
      if (doSubdivision != 0) {
        gte_SetRotMatrix(((char *)sd + 0x74));
        gte_SetTransMatrix(((char *)sd + 0x74));
        if (stackSpeedUpEnbabledFlag != 0) {
          gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
          stackSpeedUpEnbabledFlag = 0;
          DrawW_SetUpSubdividFacet_Line(sd);
          gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
          stackSpeedUpEnbabledFlag = 1;
        }
        else {
          DrawW_SetUpSubdividFacet_Line(sd);
        }
        gte_SetRotMatrix(((char *)sd + 0x14));
        gte_SetTransMatrix(((char *)sd + 0x14));
      }
loopbot:
      lineQuadCount = lineQuadCount + 1;
      lineQuad = lineQuad + 1;
      geomVertices = geomVertices + 2;
    }
  }
  return;
}

'''
new = new.replace('ASMBLOCK', asm)
open(p, 'w', encoding='utf-8').write(src[:start] + new + src[end:])
print("spliced %d -> %d" % (len(old), len(new)))
