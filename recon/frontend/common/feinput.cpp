/* frontend/common/feinput.cpp -- RECONSTRUCTED (front-end controller input; C++ TU)
 *   4 free fns: FEInput_VerifyControllerValues (pad-id sanity), FEInput_GetNoDebounceKey
 *   (raw key read, incl negCon analog thresholds), FEInput_GetDebounceKey (edge+repeat),
 *   FEInput_GetKeyFromPlayer (PSX->FE key mapping). ns nfs4::FRONTEND::COMMON::FEInput.
 */
#include "feinput.h"



/* ---- FEInput.obj-OWNED data -- DEFINED here (self-contained; real NFS4.EXE bytes). ---- */
static long nextTick = 0;   /* @0x80051738; SYM STAT LONG */
tPSXToFEMapping getKeyMappings[16] = { {16, 512}, {128, 2048}, {32, 4096}, {64, 1024}, {1024, 32}, {256, 64}, {2048, 128}, {512, 256}, {1048576, 512}, {8388608, 2048}, {2097152, 4096}, {4194304, 1024}, {268435456, 512}, {-2147483648, 2048}, {536870912, 4096}, {1073741824, 1024} };   /* @0x8005173c */
static int debounce[2];     /* @0x80052b60; SYM STAT INT[2] */


/* ---- FEInput_VerifyControllerValues  [FEINPUT.CPP:28-38] SLD-VERIFIED ---- */
/* Retail SLD separates the no-pad and controller-ID guards on +1/+5,
   then the reset call on +9. A real unconditional return on that source
   line preserves the root block and gives the epilogue/end retail's +10. */

#line 25 "C:/nfs4/FRONTEND/COMMON/FEINPUT.CPP"
void FEInput_VerifyControllerValues(int controller)


{
  if (gPadinfo.buf[controller * 4].nopad == '\0')



    if (frontEnd.controlType[controller] != (u_short)gPadinfo.buf[controller * 4].ID)



      Front_ResetPSXController(controller,0); return;
}



/* ---- FEInput_GetNoDebounceKey [FEINPUT.CPP:44-142] SOURCE/SLD REVIEW OPEN ---- */
/* MATCH: PASS (159 insns), improved from 38 diffs @147/159.
   The SLD fixes the negCon source order as twist-high, twist-low, buttonII, buttonI
   (lines 122/125/129/132); restoring that order moves every case block into retail
   order.  The reconstruction's unresolved `result` carrier and
   the shared comparison funnels
   preserve retail's branch normalisers instead of folding them to xori/sltu.
   `return_one` gives buttonI and the final PAD-state test the shared constant target;
   `return_mask` joins the analog `~state` and negCon `PAD_state & 0xffff` paths before
   the common `& key`, reproducing retail's shared raw-mask block. One empty asm
   scheduling barrier remains at `return_mask`; it has no register pin and emits
   no instruction. The other was retired by the shared-tail source form.
   Falsified in the old 38 basin: direct if/return spellings (neutral), bool return/local
   spellings (neutral), raw-mask return (37), and per-site barriers (159, severe). */

      /* W85-S5 (device removed): this used to be `if (result) return 1;` +
         a void `__asm__("" : : "i"(0))` boundary + `return 0;`.  Without a
         boundary gcc collapses the pair into the `sltu $v0,$zero,$v0`
         normalization and drops retail's explicit `bnez`/`li 1`-in-delay-slot
         + `j <shared tail>`/`addu $v0,$zero,$zero` shape (157 vs 159 insns).
         The pure-C equivalent is the catalog's goto-to-shared-tail: branch to
         the SAME `return_one` label the sibling arm already uses, which is
         exactly the `j` target retail shares. */
  /* SOURCE-REVIEW-UNRESOLVED: retail has no result local; native emits REG:$2.
     These funnels are a current byte match, not proof this object was original. */
#line 41 "C:/nfs4/FRONTEND/COMMON/FEINPUT.CPP"
int FEInput_GetNoDebounceKey(int key,int controller)


{
  char *analogs;

  PAD_update();
  if (gPadinfo.buf[controller * 4].nopad != '\0') {
    goto return_zero;
  }
  FEInput_VerifyControllerValues(controller);

  analogs = (char *)&gPadinfo.buf[controller * 4].data.negcon.twist;
  if ((gPadinfo.buf[controller * 4].ID == 's') ||

      (gPadinfo.buf[controller * 4].ID == 'S')) {

    switch (key) {
    case 0x800000:

      if ((u_char)analogs[0] < 0x40) goto return_one; return 0;
    case 0x200000:

      if ((u_char)analogs[0] < 0xc1) return 0; goto return_one;
    case 0x100000:

      if ((u_char)analogs[1] < 0x40) goto return_one; return 0;
    case 0x400000:

      if ((u_char)analogs[1] < 0xc1) return 0; goto return_one;
    case (int)0x80000000:

      if ((u_char)analogs[2] < 0x40) goto return_one; return 0;
    case 0x20000000:

      if ((u_char)analogs[2] < 0xc1) return 0; goto return_one;
    case 0x10000000:

      if ((u_char)analogs[3] < 0x40) goto return_one; return 0;
    case 0x40000000:

      if ((u_char)analogs[3] < 0xc1) return 0; goto return_one;
    default:

      if ((~(u_int)gPadinfo.buf[controller * 4].data.standard.state & key) != 0) goto return_one_b; analogs = 0; return 0;
    }
  }





























  if (gPadinfo.buf[controller * 4].ID == '#') {

    switch (key) {
    case 0x200000:

      if (gPadinfo.buf[controller * 4].data.negcon.twist < 0xa1) return 0; goto return_one;
    case 0x800000:

      if (gPadinfo.buf[controller * 4].data.negcon.twist < 0x62) goto return_one; return_zero: return 0;
    case 0x8000:


      if (gPadinfo.buf[controller * 4].data.negcon.buttonII < 0x41) return 0; goto return_one;
    case 0x4000:

      if (gPadinfo.buf[controller * 4].data.negcon.buttonI < 0x41) return 0; goto return_one;
    default:

      if ((((u_int)PAD_state(controller << 2) & 0xffff) & key) != 0) goto return_one_b; analogs = 0; return 0;
    }
  }

  if ((((u_int)PAD_state(controller << 2) & 0xffff) & key) == 0) {
    return 0;
  }
return_one_b: return 1; return_one: return 1;
}



/* ---- FEInput_GetDebounceKey [FEINPUT.CPP:146-179] NATIVE CLEAN; SLD OPEN ---- */
/* Source/SLD follow-up (2026-11-01): actual compound-body ownership and a
   non-direction early return restore all14 block line/address records and
   tick's source153 load, with the whole four-function object unchanged.
   The call148 / branch150 split is still unresolved: moving the condition
   close to150 repairs the branch but wrongly moves the call too. No result
   object or synthetic region is added to conceal those two remaining tags.
   Receipt: build/tmp/v/feinput_debounce_20261101/proof.json. */

/* SYM (nfs4-f-v3.txt @0x80023B74): key REGPARM $16, controller REGPARM $17,
   and exactly ONE named local -- `int tick` REG $4 (a0), declared at the top of
   the block starting at 0x80023BB8 (the tick load) and running to 0x80023C38.
   The oracle reads ticks ONCE through an inline pair; the old body re-read the global
   at every use.  Branch polarity: the debounce SET path and the debounce CLEAR
   path are both laid out OUT OF LINE after the tick block (oracle `beqz` to
   .L80023C38 / .L80023C50), so both guards must be written as the taken-branch
   case with the tick block falling through. */
#line 143 "C:/nfs4/FRONTEND/COMMON/FEINPUT.CPP"
int FEInput_GetDebounceKey(int key,int controller)


{
  int r;
  r = FEInput_GetNoDebounceKey(key,controller) != 0;

  if (r)
  {
    if ((debounce[controller] & key) != 0)
    {

      int tick = gettick();

      if (key != 0x10 && key != 0x80 && key != 0x20 && key != 0x40) return 0;


        if (nextTick == 0) {
          nextTick = tick + FeTools_gScrollTicksOut + 10;
        }
        if (tick < nextTick) {
          return 0;
        }
        nextTick = tick + FeTools_gScrollTicksOut;
        return 1;


    } else {
      debounce[controller] = debounce[controller] | key;
      nextTick = 0;
      return 1;


    }
  } else {
    debounce[controller] = debounce[controller] & ~key;
    return 0;
  }
}



/* ---- FEInput_GetKeyFromPlayer [FEINPUT.CPP:214-319] NATIVE CLEAN; SLD OPEN ---- */
#line 210 "C:/nfs4/FRONTEND/COMMON/FEINPUT.CPP"
tInputKeyType
FEInput_GetKeyFromPlayer(tPlayer player,long debounce)


{
  u_short i;

  /* MATCH 2026-08-03 (5->PASS): SLD records only `unsigned short i`.
     Keeping the short-circuit test directly in the for-loop condition lets
     GCC create retail's temporary found pseudo, clear it in the back-edge
     delay slot, and place the mapping/Square return blocks in oracle order. */







  for (i = 0; i < 16; i++) {
    if ((FEInput_GetDebounceKey(getKeyMappings[i].PSXKey,player) != 0) ||
        (((debounce & getKeyMappings[i].FEKey) == kInput_KeyType_NoKey) &&
         (FEInput_GetNoDebounceKey(getKeyMappings[i].PSXKey,player) != 0))) {
      return (tInputKeyType)getKeyMappings[i].FEKey;
    } }


































  if (FEInput_GetDebounceKey(0x4000,player) != 0) {
    return kInput_KeyType_Cross; } if (FEInput_GetDebounceKey(0x1000,player) != 0) {
    return kInput_KeyType_Triangle;
  } if (FEInput_GetDebounceKey(0x2000,player) != 0) {
    return kInput_KeyType_Circle;
  }

  if (FEInput_GetDebounceKey(0x8000,player) != 0) return kInput_KeyType_Square;
  if (FEInput_GetDebounceKey(8,player) != 0) return kInput_KeyType_Start;










































  return kInput_KeyType_NoKey;
}



/* end of feinput.cpp */
