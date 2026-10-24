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

/* Retail chunk.obj opens .rodata with this unreferenced class tag. */
static inline const char *SimpleMem_ClassName(void) { return "SimpleMem"; }
extern "C" int sprintf(char *, const char *, ...);

/* ---- chunk.obj-owned globals (.bss zero) ---- */
CVECTOR      *Chunk_lightTable;      /* @0x8013c818 */
coorddef     *Chunk_chunkCenters;    /* @0x8013c81c */

/* ---- intra-TU forward declarations ---- */
void Chunk_UpdateSys(DRender_tView *Vi);
void Chunk_Init(void);
void Chunk_DeInit(void);

/* ---- InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem  [@0x8008b3fc]  CHUNK.CPP ----
 * SYM-v3 REG locals applied per the disasm-v2 register map (SSA-split across the
 * mutually-exclusive scopes): instGroup=$s1, simGroup=$s4, i/numElements=$a2/$s0,
 * inst=Trk_SimpleInst* walker, index=$v1, size=$a3, simObjs=$v1, count=$a1, geomGroup=$s1.
 * SourceRecoveryUnresolved: groupData/quadData and the first simObjs have no
 * supplied original identifier. Their real payload roles are known, but they
 * are not proved distinct original objects. Both guarded boomInst views use
 * semantic names; their original identifiers and exact declaration spelling
 * are absent from optimized SYM. All329 word/file tags, header/end coordinates,
 * all45 region identities and all24 complete supplied local tuples agree.
 * 2026-10-23: existing payload/count accessors and real work regions restore
 * 24/24 complete local tuples (previously 3/24), at unchanged329 words/ELF.
 * Four reconstruction gotos are replaced by ordinary conditional arms.
 * Early-skip/real index-walk regions then remove both empty asm fences and
 * the volatile read, preserving all earlier correct local/region tuples.
 * Positive group/zero-count arms restore the shared i/numElements endpoint.
 * Receipts: build/nc12/chunk_scope_endpoint_20261023; original text remains open. */
#line 82 "C:/nfs4/GAME/COMMON/CHUNK.CPP"
void Chunk::InstanceGroup(SerializedGroup *chunkGroup, SimpleMem *mem)
{
  {
    char *groupData;
    groupData = (char *)(chunkGroup)->LocateGroupType(0x1c, 0)->GetData();


    this->firstSimSliceInd = *(short *)(groupData + 10);
    this->boundPts[0] = ((RelCoord16 *)(groupData + 16))[0];
    this->boundPts[1] = ((RelCoord16 *)(groupData + 16))[1];
    this->boundPts[2] = ((RelCoord16 *)(groupData + 16))[2];
    this->boundPts[3] = ((RelCoord16 *)(groupData + 16))[3];
    this->chunkboundPts[0] = ((RelCoord16 *)(groupData + 16))[4];
    this->chunkboundPts[1] = ((RelCoord16 *)(groupData + 16))[5];
    this->chunkboundPts[2] = ((RelCoord16 *)(groupData + 16))[6];
    this->chunkboundPts[3] = ((RelCoord16 *)(groupData + 16))[7];


    this->chunkInd = *(short *)(groupData + 12);
  }








  if (CHUNK_COMMMODE != 1) {

    this->objInstanceBuf = (Group *)(chunkGroup)->LocateCreateGroupType(3, mem, 0);
    this->simObjBuf = (Group *)(chunkGroup)->LocateCreateGroupType(0xb, mem, 0);

  }
  else {
    SerializedGroup *instGroup;
    SerializedGroup *simGroup;

    simGroup = (chunkGroup)->LocateGroupType(0xb, 0);
    instGroup = (chunkGroup)->LocateGroupType(3, 0);

    if (simGroup != (SerializedGroup *)0x0)
    {
      int i = 0;
      int numElements = simGroup->GetNumElements();
      Trk_SimObject *simObjs = (Trk_SimObject *)simGroup->GetData();

      while (i < numElements) {
        Trk_SimpleInst *inst;


        if (simObjs[i].instIndex == 0x7f) {
          i = i + 1;

          continue;
        }


        inst = (Trk_SimpleInst *)instGroup->GetData();
        {

          int index = (int)simObjs[i].instIndex;

          if (instGroup->GetNumElements() <= index)
            break;
          while (index--) {
            inst = (Trk_SimpleInst *)((int)inst + (int)inst->size);
          }
        }
        if (inst != (Trk_SimpleInst *)0x0 && inst->type == '\x05')
        {
          Trk_CollideBoomInst *boomInst = (Trk_CollideBoomInst *)inst;

          if (boomInst->boomIndex == 0) {

            i = i + 1;
            continue;
          }
        }


        break; }



      numElements = i;

      if (numElements == 0) {
        this->simObjBuf = (Group *)0x0;
      }
      else {
        this->simObjBuf = (chunkGroup)->CreateLiteGroupDataSize(simGroup, mem, numElements * 0x14);
        this->simObjBuf->m_num_elements = numElements;

      }
    }
    else { this->simObjBuf = (Group *)0x0;
    }


    if (instGroup != (SerializedGroup *)0x0)
    {
      int numElements; int i; int size; Trk_SimpleInst *inst;
      numElements = instGroup->GetNumElements();
      i = 0;
      size = 0;
      inst = (Trk_SimpleInst *)instGroup->GetData();
      while (true) { if (i >= numElements) break;

        if (inst->type == '\x05')
        {
          Trk_CollideBoomInst *boomInst = (Trk_CollideBoomInst *)inst;
          if (boomInst->boomIndex != 0)
            break;
        } else if (inst->type != '\x01')
          break;

        size = size + (int)inst->size;
        inst = (Trk_SimpleInst *)((int)inst + (int)inst->size);
        i = i + 1;
      }
      this->objInstanceBuf = (chunkGroup)->CreateLiteGroupDataSize(instGroup, mem, size);
      this->objInstanceBuf->m_num_elements = i;
    }
    else { this->objInstanceBuf = (Group *)0x0; }


    if ((this->simObjBuf != (Group *)0x0) && (this->objInstanceBuf != (Group *)0x0))
    {
      Trk_SimObject *simObjs; int count;
      simObjs = (Trk_SimObject *)simGroup->GetData(); count = this->simObjBuf->GetNumElements();
      while (count--) {
        if ((int)(u_int)simObjs[count].instIndex >= this->objInstanceBuf->GetNumElements()) {


          simObjs[count].instIndex = 0x7f;
        }
      }
    }
  }


  { SerializedGroup *geomGroup; this->objSpecialInstanceBuf = (Group *)(chunkGroup)->LocateCreateGroupType(0x15, mem, 0);
    this->sfxBuf = (Group *)(chunkGroup)->LocateCreateGroupType(10, mem, 0);

    this->simQuadBuf = (Group *)(chunkGroup)->LocateCreateGroupType(5, mem, 0);
    this->simSliceBuf = (Group *)(chunkGroup)->LocateCreateGroupType(6, mem, 0);

    this->lineBuf = (Group *)(chunkGroup)->LocateCreateGroupType(9, mem, 0);


    geomGroup = (chunkGroup)->LocateGroupType(0x17, 0);
    char *quadData;
    quadData = (char *)(geomGroup)->LocateGroupType(0x1b, 0)->GetData();



    this->quadCounts[0] = *(u_char *)(quadData + 12);
    this->quadCounts[1] = *(u_char *)(quadData + 14);
    this->quadCounts[2] = *(u_char *)(quadData + 16);
    this->quadCounts[3] = *(u_char *)(quadData + 18);
    this->quadCounts[4] = *(u_char *)(quadData + 20);
    this->quadCounts[5] = *(u_char *)(quadData + 22);

    this->renderQuads[0] = (Trk_Quad *)(geomGroup)->LocateCreateGroupType(0x19, mem, 0)->GetData();
    this->renderQuads[1] = this->renderQuads[0] + *(short *)(quadData + 12);

    this->renderQuads[2] = this->renderQuads[1] + *(short *)(quadData + 14);
    this->renderQuads[3] = this->renderQuads[2] + *(short *)(quadData + 20);


    this->stripBuf = (Group *)(geomGroup)->LocateCreateGroupType(0x1a, mem, 0);

    this->lorezstripBuf = (Group *)(geomGroup)->LocateCreateGroupType(0x25, mem, 0);

    this->vertexBuf = (Group *)(geomGroup)->LocateCreateGroupType(0x18, mem, 0);

    this->objVertexBuf = (Group *)(geomGroup)->LocateCreateGroupType(0x27, mem, 0);
    this->objQuadBuf = (Group *)(geomGroup)->LocateCreateGroupType(0x28, mem, 0);
    this->objQuadInstanceBuf = (Group *)(geomGroup)->LocateCreateGroupType(0x29, mem, 0); } return;
}

/* ---- Chunk_UpdateSys__FP13DRender_tView [@0x8008b920] ---- */
#line 273 "C:/nfs4/GAME/COMMON/CHUNK.CPP"
void Chunk_UpdateSys(DRender_tView *Vi)
{





}

/* ---- Chunk_Init__Fv [@0x8008b928] ---- */
#line 290 "C:/nfs4/GAME/COMMON/CHUNK.CPP"
void Chunk_Init(void)
{









}

/* ---- Chunk_DeInit__Fv [@0x8008b930] ---- */
#line 309 "C:/nfs4/GAME/COMMON/CHUNK.CPP"
void Chunk_DeInit(void)
{

}
