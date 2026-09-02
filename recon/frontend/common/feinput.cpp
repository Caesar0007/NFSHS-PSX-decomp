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

void FEInput_VerifyControllerValues(int controller)

{
  if ((gPadinfo.buf[controller * 4].nopad == '\0') &&
     (frontEnd.controlType[controller] != (u_short)gPadinfo.buf[controller * 4].ID)) {
    Front_ResetPSXController(controller,0);
  }
  return;
}



/* ---- FEInput_GetNoDebounceKey  [FEINPUT.CPP:44-142] SLD-VERIFIED ---- */
/* MATCH: PASS (159 insns), improved from 38 diffs @147/159.
   The SLD fixes the negCon source order as twist-high, twist-low, buttonII, buttonI
   (lines 122/125/129/132); restoring that order moves every case block into retail
   order.  The compiler-eliminated `result` pseudo and
   the shared comparison funnels
   preserve retail's branch normalisers instead of folding them to xori/sltu.
   `return_one` gives buttonI and the final PAD-state test the shared constant target;
   `return_mask` joins the analog `~state` and negCon `PAD_state & 0xffff` paths before
   the common `& key`, reproducing retail's shared raw-mask block.  The two empty asm
   statements are zero-insn scheduling barriers permitted by AGENT_GUIDE.md; they have
   no register pin and emit no instruction.
   Falsified in the old 38 basin: direct if/return spellings (neutral), bool return/local
   spellings (neutral), raw-mask return (37), and per-site barriers (159, severe). */

int FEInput_GetNoDebounceKey(int key,int controller)

{
  char *analogs;
  int result;

  /* SYM-CODEGEN-CARRIER: result -- absent from the optimized SYM local list,
     but required by the byte-exact shared comparison/return funnels below. */

  PAD_update();
  if (gPadinfo.buf[controller * 4].nopad != '\0') {
    return 0;
  }
  FEInput_VerifyControllerValues(controller);
  analogs = (char *)&gPadinfo.buf[controller * 4].data.negcon.twist;
  if ((gPadinfo.buf[controller * 4].ID == 's') ||
      (gPadinfo.buf[controller * 4].ID == 'S')) {
    switch (key) {
    case 0x800000:
      result = (u_char)analogs[0] < 0x40;
      goto return_bool;
    case 0x200000:
      result = (u_char)analogs[0] < 0xc1;
      goto return_not_bool;
    case 0x100000:
      result = (u_char)analogs[1] < 0x40;
      goto return_bool;
    case 0x400000:
      result = (u_char)analogs[1] < 0xc1;
      goto return_not_bool;
    case (int)0x80000000:
      result = (u_char)analogs[2] < 0x40;
      goto return_bool;
    case 0x20000000:
      result = (u_char)analogs[2] < 0xc1;
      goto return_not_bool;
    case 0x10000000:
      result = (u_char)analogs[3] < 0x40;
      goto return_bool;
    case 0x40000000:
      result = (u_char)analogs[3] < 0xc1;
      goto return_not_bool;
    default:
      result = ~(u_int)gPadinfo.buf[controller * 4].data.standard.state;
      goto return_mask;
    }
  }

  if (gPadinfo.buf[controller * 4].ID == '#') {
    switch (key) {
    case 0x200000:
      result = gPadinfo.buf[controller * 4].data.negcon.twist < 0xa1;
      goto return_not_bool;
    case 0x800000:
      result = gPadinfo.buf[controller * 4].data.negcon.twist < 0x62;
return_bool:
      /* W85-S5 (device removed): this used to be `if (result) return 1;` +
         a void `__asm__("" : : "i"(0))` boundary + `return 0;`.  Without a
         boundary gcc collapses the pair into the `sltu $v0,$zero,$v0`
         normalization and drops retail's explicit `bnez`/`li 1`-in-delay-slot
         + `j <shared tail>`/`addu $v0,$zero,$zero` shape (157 vs 159 insns).
         The pure-C equivalent is the catalog's goto-to-shared-tail: branch to
         the SAME `return_one` label the sibling arm already uses, which is
         exactly the `j` target retail shares. */
      if (result) {
        goto return_one;
      }
      return 0;
    case 0x8000:
      result = gPadinfo.buf[controller * 4].data.negcon.buttonII < 0x41;
      goto return_not_bool;
    case 0x4000:
      result = gPadinfo.buf[controller * 4].data.negcon.buttonI < 0x41;
return_not_bool:
      if (!result) {
        goto return_one;
      }
      return 0;
    default:
      result = (u_int)PAD_state(controller << 2) & 0xffff;
return_mask:
      if ((result & key) != 0) {
        return 1;
      }
      __asm__("" : : "i"(0));
      return 0;
    }
  }
  if ((((u_int)PAD_state(controller << 2) & 0xffff) & key) == 0) {
    return 0;
  }

return_one:
  return 1;
}



/* ---- FEInput_GetDebounceKey  [FEINPUT.CPP:146-179] SLD-VERIFIED ---- */

int FEInput_GetDebounceKey(int key,int controller)

{
  /* SYM (nfs4-f-v3.txt @0x80023B74): key REGPARM $16, controller REGPARM $17,
     and exactly ONE named local -- `int tick` REG $4 (a0), declared at the top of
     the block starting at 0x80023BB8 (the `lw ticks`) and running to 0x80023C38.
     The oracle reads `ticks` ONCE into that local; the old body re-read the global
     at every use.  Branch polarity: the debounce SET path and the debounce CLEAR
     path are both laid out OUT OF LINE after the tick block (oracle `beqz` to
     .L80023C38 / .L80023C50), so both guards must be written as the taken-branch
     case with the tick block falling through. */
  if (FEInput_GetNoDebounceKey(key,controller) != 0) {
    if ((debounce[controller] & key) != 0) {
      int tick = ticks[0];

      if ((((key == 0x10) || (key == 0x80)) || (key == 0x20)) || (key == 0x40)) {
        if (nextTick == 0) {
          nextTick = tick + FeTools_gScrollTicksOut[0] + 10;
        }
        if (tick < nextTick) {
          return 0;
        }
        nextTick = tick + FeTools_gScrollTicksOut[0];
        return 1;
      }
      return 0;
    }
    debounce[controller] = debounce[controller] | key;
    nextTick = 0;
    return 1;
  }
  debounce[controller] = debounce[controller] & ~key;
  return 0;
}



/* ---- FEInput_GetKeyFromPlayer  [FEINPUT.CPP:214-319] SLD-VERIFIED ---- */
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
    }
  }
  if (FEInput_GetDebounceKey(0x4000,player) != 0) {
    return kInput_KeyType_Cross;
  }
  if (FEInput_GetDebounceKey(0x1000,player) != 0) {
    return kInput_KeyType_Triangle;
  }
  if (FEInput_GetDebounceKey(0x2000,player) != 0) {
    return kInput_KeyType_Circle;
  }
  /* Inverting only this final test preserves the bnez tail layout. */
  if (FEInput_GetDebounceKey(0x8000,player) == 0) {
    return (tInputKeyType)
        ((u_int)(FEInput_GetDebounceKey(8,player) != 0) << 0xd);
  }
  return kInput_KeyType_Square;
}



/* end of feinput.cpp */
