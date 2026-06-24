/* game/common/chunk.cpp -- RECONSTRUCTED (NFS4 track-chunk geometry/instance binder; C++ TU).
 *   4 fns: Chunk::InstanceGroup (the chunk ctor body) + 3 empty hooks
 *   (Chunk_UpdateSys / Chunk_Init / Chunk_DeInit).
 *
 *   InstanceGroup was HAND-RECONSTRUCTED from disasm-v2.txt (offset 0x7B3FC..0x7B91C):
 *   Ghidra mis-decompiled the 32-byte unaligned struct-copy (lwl/lwr/swl/swr) that fills
 *   boundPts[4]/chunkboundPts[4] into ~200 lines of phantom-register (in_t3/uVar15/uVar16)
 *   bit-shuffle garbage. disasm-v2 shows it is a plain byte-exact 32-byte copy of &group[2].
 *   The rest of the body matches Ghidra's field-resolved output (delay-slot stores verified
 *   against disasm-v2: each call's result lands in the slot of the *following* jal). Self-contained.
 */
#include "../../nfs4_types.h"
#include "chunk_externs.h"

/* ---- chunk.obj-owned globals (.bss zero) ---- */
CVECTOR      *Chunk_lightTable;      /* @0x8013c818 */
coorddef     *Chunk_chunkCenters;    /* @0x8013c81c */

/* ---- intra-TU forward declarations ---- */
void InstanceGroup(Chunk *pThis, SerializedGroup *chunkGroup, SimpleMem *mem);
void Chunk_UpdateSys(DRender_tView *Vi);
void Chunk_Init(void);
void Chunk_DeInit(void);

/* ---- InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem  [@0x8008b3fc]  CHUNK.CPP ----
 * SYM-v3 REG locals applied per the disasm-v2 register map (SSA-split across the
 * mutually-exclusive scopes): instGroup=$s1, simGroup=$s4, i/numElements=$s0/$a2,
 * inst=Trk_SimpleInst* walker, index=$v1, size=$a3, simObjs=$v1, count=$a1, geomGroup=$s1. */
void InstanceGroup(Chunk *pThis, SerializedGroup *chunkGroup, SimpleMem *mem)
{
  SerializedGroup *group;
  SerializedGroup *geomGroup;
  SerializedGroup *quadGroup;
  Group *pGVar6;
  Trk_Quad *pTVar9;
  short sVar3;

  group = (chunkGroup)->LocateGroupType(0x1c, 0);
  pThis->firstSimSliceInd = *(short *)((int)&group[1].dummy + 2);   /* @0x7B43C group+26 */
  /* @0x7B448-0x7B4E4 disasm-v2: byte-exact 32-byte block copy &group[2] -> boundPts/chunkboundPts.
     (Ghidra rendered this unaligned lwl/lwr/swl/swr run as in_t3 register-shuffle garbage.) */
  memcpy(pThis->boundPts, &group[2], 32);
  pThis->chunkInd = (short)group[1].m_num_elements;                 /* @0x7B4E8 group+28 */
  if (GameSetup_gData.commMode != 1) {
    pGVar6 = (Group *)(chunkGroup)->LocateCreateGroupType(3, mem, 0);
    pThis->objInstanceBuf = pGVar6;
    pGVar6 = (Group *)(chunkGroup)->LocateCreateGroupType(0xb, mem, 0);
    pThis->simObjBuf = pGVar6;
  }
  else {
    SerializedGroup *simGroup;    /* $s4  type-0xB (sim-object) group */
    SerializedGroup *instGroup;   /* $s1  type-3  (instance) group */
    int i;
    int numElements;
    int size;

    simGroup  = (chunkGroup)->LocateGroupType(0xb, 0);
    instGroup = (chunkGroup)->LocateGroupType(3, 0);
    /* ---- count sim-objects that resolve to a live type-5/term-0 instance ---- */
    if (simGroup == (SerializedGroup *)0x0) {
      pThis->simObjBuf = (Group *)0x0;
    }
    else {
      Trk_SimpleInst *inst = (Trk_SimpleInst *)(simGroup + 1);
      numElements = simGroup->m_num_elements;
      for (i = 0; i < numElements; i = i + 1) {
        if (*((u_char *)inst + 18) != 0x7f) {
          int index = (int)*((u_char *)inst + 18);
          SerializedGroup *probe = instGroup + 1;
          if (instGroup->m_num_elements <= index) break;
          while (index = index - 1, index != -1) {
            probe = (SerializedGroup *)((int)&probe->m_type + (int)(short)probe->m_type);
          }
          if (((probe == (SerializedGroup *)0x0) ||
               (*(char *)((int)&probe->m_type + 2) != '\x05')) ||
              (*(char *)((int)&probe[2].m_type + 3) != '\0')) break;
        }
        inst = (Trk_SimpleInst *)((int)inst + 0x14);
      }
      if (i == 0) {
        pThis->simObjBuf = (Group *)0x0;
      }
      else {
        pGVar6 = (chunkGroup)->CreateLiteGroupDataSize(simGroup, mem, i * 0x14);
        pThis->simObjBuf = pGVar6;
        pGVar6->m_num_elements = i;
      }
    }
    /* ---- count instance entries (variable-stride walk) ---- */
    i = 0;
    if (instGroup == (SerializedGroup *)0x0) {
      pThis->objInstanceBuf = (Group *)0x0;
    }
    else {
      Trk_SimpleInst *inst = (Trk_SimpleInst *)(instGroup + 1);
      char cVar2;
      int stride;
      size = 0;
      for (; i < instGroup->m_num_elements; i = i + 1) {
        cVar2 = *((char *)inst + 2);
        if (cVar2 == '\x05') {
          if (*((char *)inst + 0x23) != '\0') break;
        }
        else if (cVar2 != '\x01') break;
        stride = (int)*(short *)inst;
        size = size + stride;
        inst = (Trk_SimpleInst *)((int)inst + stride);
      }
      pGVar6 = (chunkGroup)->CreateLiteGroupDataSize(instGroup, mem, size);
      pThis->objInstanceBuf = pGVar6;
      pGVar6->m_num_elements = i;
    }
    /* ---- clamp out-of-range instance indices to 0x7f ---- */
    if ((pThis->simObjBuf != (Group *)0x0) && (pThis->objInstanceBuf != (Group *)0x0)) {
      int count = pThis->simObjBuf->m_num_elements;
      Trk_SimObject *simObjs = (Trk_SimObject *)((int)simGroup + count * 0x14 + 0x10);
      while (true) {
        Trk_SimObject *cur = simObjs;
        count = count - 1;
        if (count == -1) break;
        simObjs = (Trk_SimObject *)((int)cur - 0x14);
        if (pThis->objInstanceBuf->m_num_elements <= (int)(u_int)*((u_char *)cur - 2)) {
          *((u_char *)cur - 2) = 0x7f;
        }
      }
    }
  }
  /* ---- geometry sub-groups (always run) ---- */
  pGVar6 = (Group *)(chunkGroup)->LocateCreateGroupType(0x15, mem, 0);
  pThis->objSpecialInstanceBuf = pGVar6;
  pGVar6 = (Group *)(chunkGroup)->LocateCreateGroupType(10, mem, 0);
  pThis->sfxBuf = pGVar6;
  pGVar6 = (Group *)(chunkGroup)->LocateCreateGroupType(5, mem, 0);
  pThis->simQuadBuf = pGVar6;
  pGVar6 = (Group *)(chunkGroup)->LocateCreateGroupType(6, mem, 0);
  pThis->simSliceBuf = pGVar6;
  pGVar6 = (Group *)(chunkGroup)->LocateCreateGroupType(9, mem, 0);
  pThis->lineBuf = pGVar6;
  geomGroup = (chunkGroup)->LocateGroupType(0x17, 0);
  quadGroup = (geomGroup)->LocateGroupType(0x1b, 0);
  pThis->quadCounts[0] = (u_char)quadGroup[1].m_num_elements;
  pThis->quadCounts[1] = *(u_char *)((int)&quadGroup[1].m_num_elements + 2);
  pThis->quadCounts[2] = (u_char)quadGroup[2].m_type;
  pThis->quadCounts[3] = *(u_char *)((int)&quadGroup[2].m_type + 2);
  pThis->quadCounts[4] = (u_char)quadGroup[2].m_length;
  pThis->quadCounts[5] = *(u_char *)((int)&quadGroup[2].m_length + 2);
  pGVar6 = (Group *)(geomGroup)->LocateCreateGroupType(0x19, mem, 0);
  pTVar9 = (Trk_Quad *)(pGVar6 + 1);
  pThis->renderQuads[0] = pTVar9;
  pTVar9 = pTVar9 + (short)quadGroup[1].m_num_elements;
  pThis->renderQuads[1] = pTVar9;
  sVar3 = *(short *)((int)&quadGroup[1].m_num_elements + 2);
  pThis->renderQuads[2] = pTVar9 + sVar3;
  pThis->renderQuads[3] = pTVar9 + sVar3 + (short)quadGroup[2].m_length;
  pGVar6 = (Group *)(geomGroup)->LocateCreateGroupType(0x1a, mem, 0);
  pThis->stripBuf = pGVar6;
  pGVar6 = (Group *)(geomGroup)->LocateCreateGroupType(0x25, mem, 0);
  pThis->lorezstripBuf = pGVar6;
  pGVar6 = (Group *)(geomGroup)->LocateCreateGroupType(0x18, mem, 0);
  pThis->vertexBuf = pGVar6;
  pGVar6 = (Group *)(geomGroup)->LocateCreateGroupType(0x27, mem, 0);
  pThis->objVertexBuf = pGVar6;
  pGVar6 = (Group *)(geomGroup)->LocateCreateGroupType(0x28, mem, 0);
  pThis->objQuadBuf = pGVar6;
  pGVar6 = (Group *)(geomGroup)->LocateCreateGroupType(0x29, mem, 0);
  pThis->objQuadInstanceBuf = pGVar6;
  return;
}

/* ---- Chunk_UpdateSys__FP13DRender_tView  [@0x8008b920] (empty hook: goto $ra; nop) ---- */
void Chunk_UpdateSys(DRender_tView *Vi)
{
  (void)Vi;
}

/* ---- Chunk_Init__Fv  [@0x8008b928] (empty hook) ---- */
void Chunk_Init(void)
{
}

/* ---- Chunk_DeInit__Fv  [@0x8008b930] (empty hook) ---- */
void Chunk_DeInit(void)
{
}

/* end of chunk.cpp */
