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
void Chunk_UpdateSys(DRender_tView *Vi);
void Chunk_Init(void);
void Chunk_DeInit(void);

/* ---- InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem  [@0x8008b3fc]  CHUNK.CPP ----
 * SYM-v3 REG locals applied per the disasm-v2 register map (SSA-split across the
 * mutually-exclusive scopes): instGroup=$s1, simGroup=$s4, i/numElements=$s0/$a2,
 * inst=Trk_SimpleInst* walker, index=$v1, size=$a3, simObjs=$v1, count=$a1, geomGroup=$s1. */
void Chunk::InstanceGroup(SerializedGroup *chunkGroup, SimpleMem *mem)
{
  SerializedGroup *group;
  SerializedGroup *geomGroup;
  SerializedGroup *quadGroup;
  Group *pGVar6;
  Trk_Quad *pTVar9;
  short sVar3;
  char *groupData;
  SimpleMem *groupMem;

  groupMem = mem;
  group = (chunkGroup)->LocateGroupType(0x1c, 0);
  groupData = (char *)(group + 1);
  this->firstSimSliceInd = *(short *)(groupData + 10);   /* @0x7B43C group+26 */
  /* @0x7B448-0x7B4E4 disasm-v2: byte-exact 32-byte block copy &group[2] -> boundPts/chunkboundPts.
     (Ghidra rendered this unaligned lwl/lwr/swl/swr run as in_t3 register-shuffle garbage.) */
  this->boundPts[0] = ((RelCoord16 *)(groupData + 16))[0];
  this->boundPts[1] = ((RelCoord16 *)(groupData + 16))[1];
  this->boundPts[2] = ((RelCoord16 *)(groupData + 16))[2];
  this->boundPts[3] = ((RelCoord16 *)(groupData + 16))[3];
  this->chunkboundPts[0] = ((RelCoord16 *)(groupData + 16))[4];
  this->chunkboundPts[1] = ((RelCoord16 *)(groupData + 16))[5];
  this->chunkboundPts[2] = ((RelCoord16 *)(groupData + 16))[6];
  this->chunkboundPts[3] = ((RelCoord16 *)(groupData + 16))[7];
  this->chunkInd = *(short *)(groupData + 12);                     /* @0x7B4E8 group+28 */
  if (GameSetup_gData.commMode != 1) {
    pGVar6 = (Group *)(chunkGroup)->LocateCreateGroupType(3, groupMem, 0);
    this->objInstanceBuf = pGVar6;
    pGVar6 = (Group *)(chunkGroup)->LocateCreateGroupType(0xb, groupMem, 0);
    this->simObjBuf = pGVar6;
  }
  else {
    SerializedGroup *instGroup;   /* $s1  type-3  (instance) group */
    SerializedGroup *simGroup;    /* $s4  type-0xB (sim-object) group */

    simGroup  = (chunkGroup)->LocateGroupType(0xb, 0);
    instGroup = (chunkGroup)->LocateGroupType(3, 0);
    /* ---- count sim-objects that resolve to a live type-5/term-0 instance ---- */
    if (simGroup == (SerializedGroup *)0x0) {
      this->simObjBuf = (Group *)0x0;
    }
    else {
      int i = 0;
      int numElements = simGroup->m_num_elements;
      Trk_SimpleInst *inst = (Trk_SimpleInst *)(simGroup + 1);
      for (; i < numElements; i = i + 1) {
        /* MATCH (reqdelta receipt, allocsim 27/27 on this fn): retail puts the counter
           `i` in $a2 and the inner while-loop's -1 sentinel in $a3; we had them swapped
           because p115(i) pri .7741 < p136(-1) pri 1.0.  reqdelta's minimal single dial
           is refs(i) 8 -> 11, and flow.c weights a ref by loop depth (+2 in-loop, +1
           outside): these two 0-insn use fences deliver exactly +3.  Count stays 329. */
        __asm__("" : : "r"(i));
        if (((volatile Trk_SimObject *)inst)[i].instIndex != 0x7f) {
          int index = (int)((Trk_SimObject *)inst)[i].instIndex;
          SerializedGroup *probe = instGroup + 1;
          if (instGroup->m_num_elements <= index) break;
          while (index--) {
            probe = (SerializedGroup *)((int)&probe->m_type + (int)(short)probe->m_type);
          }
          if (((probe == (SerializedGroup *)0x0) ||
               (*(char *)((int)&probe->m_type + 2) != '\x05')) ||
              (*(char *)((int)&probe[2].m_type + 3) != '\0')) break;
        }
      }
      __asm__("" : : "r"(i));
      numElements = i;
      if (numElements == 0) {
        goto InstanceGroup_noSimObjects;
      }
      pGVar6 = (chunkGroup)->CreateLiteGroupDataSize(simGroup, groupMem, numElements * 0x14);
      this->simObjBuf = pGVar6;
      pGVar6->m_num_elements = numElements;
      goto InstanceGroup_simObjectsDone;

InstanceGroup_noSimObjects:
      this->simObjBuf = (Group *)0x0;

InstanceGroup_simObjectsDone:
      ;
    }
    /* ---- count instance entries (variable-stride walk) ---- */
    if (instGroup == (SerializedGroup *)0x0) {
      goto InstanceGroup_noInstances;
    }
    {
      Trk_SimpleInst *inst;
      int numElements;
      int i;
      int size;
      char cVar2;
      int stride;

      numElements = instGroup->m_num_elements;
      i = 0;
      size = 0;
      inst = (Trk_SimpleInst *)(instGroup + 1);
      while (true) {
        if (i >= numElements) break;
        cVar2 = *((char *)inst + 2);
        if (cVar2 == '\x05') {
          if (*((char *)inst + 0x23) != '\0') break;
        }
        else if (cVar2 != '\x01') break;
        stride = (int)*(short *)inst;
        size = size + stride;
        inst = (Trk_SimpleInst *)((int)inst + stride);
        i = i + 1;
      }
      pGVar6 = (chunkGroup)->CreateLiteGroupDataSize(instGroup, groupMem, size);
      this->objInstanceBuf = pGVar6;
      pGVar6->m_num_elements = i;
      goto InstanceGroup_instancesDone;
    }

InstanceGroup_noInstances:
    this->objInstanceBuf = (Group *)0x0;

InstanceGroup_instancesDone:
    ;
    /* ---- clamp out-of-range instance indices to 0x7f ---- */
    if ((this->simObjBuf != (Group *)0x0) && (this->objInstanceBuf != (Group *)0x0)) {
      int count = this->simObjBuf->m_num_elements;
      Trk_SimObject *simObjs = (Trk_SimObject *)(simGroup + 1);
      while (count--) {
        Trk_SimObject *cur;

        cur = simObjs + count;
        if (this->objInstanceBuf->m_num_elements <= (int)(u_int)cur->instIndex) {
          cur->instIndex = 0x7f;
        }
      }
    }
  }
  /* ---- geometry sub-groups (always run) ---- */
  pGVar6 = (Group *)(chunkGroup)->LocateCreateGroupType(0x15, groupMem, 0);
  this->objSpecialInstanceBuf = pGVar6;
  pGVar6 = (Group *)(chunkGroup)->LocateCreateGroupType(10, groupMem, 0);
  this->sfxBuf = pGVar6;
  pGVar6 = (Group *)(chunkGroup)->LocateCreateGroupType(5, groupMem, 0);
  this->simQuadBuf = pGVar6;
  pGVar6 = (Group *)(chunkGroup)->LocateCreateGroupType(6, groupMem, 0);
  this->simSliceBuf = pGVar6;
  pGVar6 = (Group *)(chunkGroup)->LocateCreateGroupType(9, groupMem, 0);
  this->lineBuf = pGVar6;
  geomGroup = (chunkGroup)->LocateGroupType(0x17, 0);
  quadGroup = (geomGroup)->LocateGroupType(0x1b, 0);
  {
    char *quadData;

    quadData = (char *)(quadGroup + 1);
    this->quadCounts[0] = *(u_char *)(quadData + 12);
    this->quadCounts[1] = *(u_char *)(quadData + 14);
    this->quadCounts[2] = *(u_char *)(quadData + 16);
    this->quadCounts[3] = *(u_char *)(quadData + 18);
    this->quadCounts[4] = *(u_char *)(quadData + 20);
    this->quadCounts[5] = *(u_char *)(quadData + 22);
    pGVar6 = (Group *)(geomGroup)->LocateCreateGroupType(0x19, groupMem, 0);
    this->renderQuads[0] = (Trk_Quad *)(pGVar6 + 1);
    pTVar9 = this->renderQuads[0];
    pTVar9 = pTVar9 + *(short *)(quadData + 12);
    this->renderQuads[1] = pTVar9;
    sVar3 = *(short *)(quadData + 14);
    this->renderQuads[2] = pTVar9 + sVar3;
    this->renderQuads[3] = pTVar9 + sVar3 + *(short *)(quadData + 20);
  }
  pGVar6 = (Group *)(geomGroup)->LocateCreateGroupType(0x1a, groupMem, 0);
  this->stripBuf = pGVar6;
  pGVar6 = (Group *)(geomGroup)->LocateCreateGroupType(0x25, groupMem, 0);
  this->lorezstripBuf = pGVar6;
  pGVar6 = (Group *)(geomGroup)->LocateCreateGroupType(0x18, groupMem, 0);
  this->vertexBuf = pGVar6;
  pGVar6 = (Group *)(geomGroup)->LocateCreateGroupType(0x27, groupMem, 0);
  this->objVertexBuf = pGVar6;
  pGVar6 = (Group *)(geomGroup)->LocateCreateGroupType(0x28, groupMem, 0);
  this->objQuadBuf = pGVar6;
  pGVar6 = (Group *)(geomGroup)->LocateCreateGroupType(0x29, groupMem, 0);
  this->objQuadInstanceBuf = pGVar6;
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
