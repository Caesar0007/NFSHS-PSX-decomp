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
#include "chunk_types.h"
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
  SerializedGroup *geomGroup;
  /* SYM-CODEGEN-CARRIER: groupData -- spelling every access from the returned
     SerializedGroup directly emits 328/329 instructions and five diffs; retail
     materializes the +0x10 data base while retaining the call result. */
  char *groupData;
  groupData = (char *)((chunkGroup)->LocateGroupType(0x1c, 0) + 1);
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
  if (CHUNK_COMMMODE != 1) {
    this->objInstanceBuf =
         (Group *)(chunkGroup)->LocateCreateGroupType(3, mem, 0);
    this->simObjBuf =
         (Group *)(chunkGroup)->LocateCreateGroupType(0xb, mem, 0);
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
      Trk_SimObject *simObjs = (Trk_SimObject *)(simGroup + 1);
      Trk_SimpleInst *inst;
      for (; i < numElements; i = i + 1) {
        /* MATCH (reqdelta receipt, allocsim 27/27 on this fn): retail puts the counter
           `i` in $a2 and the inner while-loop's -1 sentinel in $a3; we had them swapped
           because p115(i) pri .7741 < p136(-1) pri 1.0.  reqdelta's minimal single dial
           is refs(i) 8 -> 11, and flow.c weights a ref by loop depth (+2 in-loop, +1
           outside): these two 0-insn use fences deliver exactly +3.  Count stays 329. */
        __asm__("" : : "r"(i));
        /* MATCH: retail reloads instIndex for `index` after the guard; without
           this volatile read GCC forwards the guard value and drops one insn. */
        if (((volatile Trk_SimObject *)simObjs)[i].instIndex != 0x7f) {
          int index = (int)simObjs[i].instIndex;
          /* SYM-INLINE-THIS: LocateGroupNum */
          inst = (Trk_SimpleInst *)(instGroup + 1);
          if (instGroup->m_num_elements <= index) break;
          while (index--) {
            inst = (Trk_SimpleInst *)((int)inst + (int)inst->size);
          }
          if (((inst == (Trk_SimpleInst *)0x0) || (inst->type != '\x05')) ||
              (*((char *)inst + 0x23) != '\0')) break;
        }
      }
      __asm__("" : : "r"(i));
      numElements = i;
      if (numElements == 0) {
        goto InstanceGroup_noSimObjects;
      }
      this->simObjBuf =
           (chunkGroup)->CreateLiteGroupDataSize(simGroup, mem, numElements * 0x14);
      this->simObjBuf->m_num_elements = numElements;
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

      numElements = instGroup->m_num_elements;
      i = 0;
      size = 0;
      inst = (Trk_SimpleInst *)(instGroup + 1);
      while (true) {
        if (i >= numElements) break;
        if (*((char *)inst + 2) == '\x05') {
          if (*((char *)inst + 0x23) != '\0') break;
        }
        else if (*((char *)inst + 2) != '\x01') break;
        size = size + (int)*(short *)inst;
        inst = (Trk_SimpleInst *)((int)inst + (int)*(short *)inst);
        i = i + 1;
      }
      this->objInstanceBuf =
           (chunkGroup)->CreateLiteGroupDataSize(instGroup, mem, size);
      this->objInstanceBuf->m_num_elements = i;
      goto InstanceGroup_instancesDone;
    }

InstanceGroup_noInstances:
    this->objInstanceBuf = (Group *)0x0;

InstanceGroup_instancesDone:
    ;
    /* ---- clamp out-of-range instance indices to 0x7f ---- */
    if ((this->simObjBuf != (Group *)0x0) && (this->objInstanceBuf != (Group *)0x0)) {
      Trk_SimObject *simObjs;
      int count;

      simObjs = (Trk_SimObject *)(simGroup + 1);
      count = this->simObjBuf->GetNumElements();
      while (count--) {
        if ((int)(u_int)simObjs[count].instIndex >=
            this->objInstanceBuf->GetNumElements()) {
          simObjs[count].instIndex = 0x7f;
        }
      }
    }
  }
  /* ---- geometry sub-groups (always run) ---- */
  this->objSpecialInstanceBuf =
       (Group *)(chunkGroup)->LocateCreateGroupType(0x15, mem, 0);
  this->sfxBuf =
       (Group *)(chunkGroup)->LocateCreateGroupType(10, mem, 0);
  this->simQuadBuf =
       (Group *)(chunkGroup)->LocateCreateGroupType(5, mem, 0);
  this->simSliceBuf =
       (Group *)(chunkGroup)->LocateCreateGroupType(6, mem, 0);
  this->lineBuf =
       (Group *)(chunkGroup)->LocateCreateGroupType(9, mem, 0);
  geomGroup = (chunkGroup)->LocateGroupType(0x17, 0);
  {
    /* SYM-CODEGEN-CARRIER: quadData -- the `geomGroup` container stays live
       for all later group creations, so retail retains the separate +0x10
       result of the single LocateGroupType(0x1b) call. */
    char *quadData;

    quadData = (char *)((geomGroup)->LocateGroupType(0x1b, 0) + 1);
    this->quadCounts[0] = *(u_char *)(quadData + 12);
    this->quadCounts[1] = *(u_char *)(quadData + 14);
    this->quadCounts[2] = *(u_char *)(quadData + 16);
    this->quadCounts[3] = *(u_char *)(quadData + 18);
    this->quadCounts[4] = *(u_char *)(quadData + 20);
    this->quadCounts[5] = *(u_char *)(quadData + 22);
    this->renderQuads[0] =
         (Trk_Quad *)((Group *)(geomGroup)->LocateCreateGroupType(0x19, mem, 0) + 1);
    this->renderQuads[1] = this->renderQuads[0] + *(short *)(quadData + 12);
    this->renderQuads[2] = this->renderQuads[1] + *(short *)(quadData + 14);
    this->renderQuads[3] = this->renderQuads[2] + *(short *)(quadData + 20);
  }
  this->stripBuf =
       (Group *)(geomGroup)->LocateCreateGroupType(0x1a, mem, 0);
  this->lorezstripBuf =
       (Group *)(geomGroup)->LocateCreateGroupType(0x25, mem, 0);
  this->vertexBuf =
       (Group *)(geomGroup)->LocateCreateGroupType(0x18, mem, 0);
  this->objVertexBuf =
       (Group *)(geomGroup)->LocateCreateGroupType(0x27, mem, 0);
  this->objQuadBuf =
       (Group *)(geomGroup)->LocateCreateGroupType(0x28, mem, 0);
  this->objQuadInstanceBuf =
       (Group *)(geomGroup)->LocateCreateGroupType(0x29, mem, 0);
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
