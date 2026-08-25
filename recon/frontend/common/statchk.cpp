/* frontend/common/statchk.cpp  --  RECONSTRUCTED  (record-lap / top-time check + save; C++ TU)
 *   5 EXT free functions; C++ linkage (cfront-mangled). Bodies: Ghidra decompiler.
 *   Calls Stattool helpers + tCarManager::GetCarFromSimID (external method, declared free-form).
 */
#include "statchk.h"

/* MATCH (w35-a10): cc1plus expands a constant-size `memcpy` inline (movstrsi);
   retail emits a real `jal memcpy`.  Calling it under a different C name with
   an asm label defeats the builtin recognition while emitting the same
   symbol/relocation. */
extern "C" void *memcpy_call(void *dst, const void *src, int n) __asm__("memcpy");

/* MATCH (w35-a10): both are STRONG DATA symbols in front_data.data.s and every
   oracle reaches them absolutely (0 %gp_rel uses tree-wide).  A TU-owned
   tentative def makes NewBestLap small-common -> .sbss -> %gp_rel; the
   unsized-array asm-label view keeps %hi an RTL pseudo (catalog wave-13). */
extern int A_NewRecords[] __asm__("NewRecords");
extern int A_NewBestLap[] __asm__("NewBestLap");
#define NewRecords  A_NewRecords
#define NewBestLap  A_NewBestLap[0]

/* ---- StatChk_IsRecordLapTime  (statchk.cpp:50) ---- */
bool StatChk_IsRecordLapTime(Car_tStats *dummyCars,short nNumCars,short *nBestCarIndex)

{
  short bBestLapFlag;
  short bCheckLapRecords;
  short i;
  int *nBestLapTimes;
  short *nRankBestLapTimes;
  short nBestCarIndexTemp;
  short nNewRecordHolder;
  tRecordBuffer RecordHolder;
  tRecordBuffer *TrackRecords;
  tCarInfo *carInfo;
  
  bBestLapFlag = 0;
  bCheckLapRecords = Stattool_CheckForHumanCar(dummyCars);
  if (bCheckLapRecords != 1) {
    return 0;
  }
    nBestLapTimes = (int *)reservememadr("ranklap",nNumCars * sizeof(int),0x10);
    nRankBestLapTimes = (short *)reservememadr("rankbst",nNumCars * sizeof(short),0x10);
    TrackRecords = (tRecordBuffer *)reservememadr("trkrcrds",0x168,0x10);
    for (i = 0; i < nNumCars; i++) {
      carInfo = GetCarFromSimID(&carManager, (short)dummyCars[i].carType);
      if ((dummyCars[i].carFlags & 0x200U) != 0) {
        goto InvalidCar;
      }
      if ((carInfo->fCarClass != 7) && (carInfo->fCarClass != 8)) {
        nBestLapTimes[i] = dummyCars[i].finalBestLap;
      }
      else {
        nBestLapTimes[i] = (i + 1) * 0x23280;
      }
    }
    if (nNumCars >= 2) {
      Stattool_nCreateIndex((int)nNumCars,nBestLapTimes,nRankBestLapTimes);
    }
    else {
      *nRankBestLapTimes = 0;
    }
    for (nNewRecordHolder = 0; nNewRecordHolder < nNumCars; nNewRecordHolder++) {
        nBestCarIndexTemp = nRankBestLapTimes[nNewRecordHolder];
        if (((dummyCars[nBestCarIndexTemp].carFlags & 4U) != 0) &&
           (0 < dummyCars[nRankBestLapTimes[nBestCarIndexTemp]].finalBestLap)) {
          bCheckLapRecords = 1;
          break;
        }
        bCheckLapRecords = 0;
    }
    if (bCheckLapRecords) goto CheckRecord;
    purgememadr(nBestLapTimes);
    goto PurgeRest;
InvalidCar:
    purgememadr(nBestLapTimes);
    purgememadr(nRankBestLapTimes);
    purgememadr(TrackRecords);
    return 0;
CheckRecord:
      nBestCarIndexTemp = nRankBestLapTimes[nNewRecordHolder];
      Stattool_GetRecords(Front_GetTrackRaced(),TrackRecords);
      memcpy_call(&RecordHolder,TrackRecords,0x14);
      if (((dummyCars[nBestCarIndexTemp].finalBestLap < RecordHolder.nBestLap) || (RecordHolder.nBestLap == 0))
         && (0 < dummyCars[nBestCarIndexTemp].finalBestLap)) {
        bBestLapFlag = 1;
      }
      *nBestCarIndex = nBestCarIndexTemp;
    purgememadr(nBestLapTimes);
PurgeRest:
    purgememadr(nRankBestLapTimes);
    purgememadr(TrackRecords);
    return (u_short)bBestLapFlag;
}

/* ---- StatChk_SaveRecordLapTime  (statchk.cpp:227) ---- */
void StatChk_SaveRecordLapTime(Car_tStats *dummyCars,short nNumCars,short nBestCarIndex)

{
  short track;
  int newBestLap;
  tCarInfo *carInfo;
  tRecordBuffer *TrackRecords;
  char *playerName;
  tRecordBuffer RecordHolder;
  tRecordBuffer DummyRaceResult;
  
  carInfo = GetCarFromSimID(&carManager, (short)dummyCars[nBestCarIndex].carType);
  /* MATCH: the != pair range-folds to the oracle's UNSIGNED sltiu(x-7,2);
     a `1 < x - 7` spelling emits the signed slti. */
  if ((carInfo->fCarClass != 7) && (carInfo->fCarClass != 8)) {
    TrackRecords = (tRecordBuffer *)reservememadr("trkrcrds",0x168,0x10);
    track = Front_GetTrackRaced();
    Stattool_GetRecords(track,TrackRecords);
    memcpy_call(&RecordHolder,TrackRecords + 1,0x14);
    if ((dummyCars[nBestCarIndex].finalNumArrests == 0) &&
       (dummyCars[nBestCarIndex].finalFinishType == 2)) {
      DummyRaceResult.nTime = dummyCars[nBestCarIndex].finalTotalTime;
    }
    else {
      DummyRaceResult.nTime = 0;
    }
    DummyRaceResult.nBestLap = dummyCars[nBestCarIndex].finalBestLap;
    DummyRaceResult.nCar = *(signed char *)&carInfo->fCarID;   /* MATCH: lb, plain char is unsigned here */
    playerName = PlayerName((int)nBestCarIndex);
    strcpy(DummyRaceResult.sName,playerName);
    memcpy_call(TrackRecords,&DummyRaceResult,0x14);
    track = Front_GetTrackRaced();
    blockmove(TrackRecords,Stats_gTrackRecords + track * 0x11,0x154);
    /* MATCH: materialize the value before forming the global lvalue. GCC 2.8.1 then gives
       the shorter-lived NewBestLap address $v0 and this value $v1, matching retail. */
    newBestLap = 1;
    NewBestLap = newBestLap;
    purgememadr(TrackRecords);
  }
  return;
}

/* ---- StatChk_IsTopTime  (statchk.cpp:285) ---- */
/* MATCH W68 (2026-08-13): SYM and the five VA-separated 0x80049D0C exports
   prove that the second traversal uses `nCar` as its loop counter and reuses
   `k = nRankCarTotalTimes[nCar]` for the ranked car.  Restoring those original
   variable roles recovers the complete saved-register allocation.  The two
   post-loop tie breakers use negated `car0 > car1` tests, which preserve the
   retail load order and branch polarity.  Together with the explicit
   `bDoRecordCheck == 1` comparison, this takes the authoritative function from
   113 residual byte diffs to PASS at 299/299 instructions. */
short StatChk_IsTopTime(Car_tStats *dummyCars,short nNumCars)

{
  int retvalue;
  short bDoRecordCheck;
  short nLaps;
  short nLapIndicator;
  int nCheckTotalTime;
  short k;
  short nCar;
  int *nCarTotalTimes;
  short *nRankCarTotalTimes;
  tRecordBuffer *RecordHolders;
  int LASTPLACE [2];
  int TOPLIST [2];
  int NUMBERONE [2];
  
  bDoRecordCheck = 0;
  nLaps = Front_GetLapsForType();
  memset(LASTPLACE,0,sizeof(LASTPLACE));
  memset(TOPLIST,0,sizeof(TOPLIST));
  memset(NUMBERONE,0,sizeof(NUMBERONE));
  RecordHolders = (tRecordBuffer *)reservememadr("toprcrds",0x168,0x10);
  nCarTotalTimes = (int *)reservememadr("carttime",nNumCars * sizeof(int),0x10);
  nRankCarTotalTimes = (short *)reservememadr("carttrnk",nNumCars * sizeof(short),0x10);
  retvalue = 0;
  for (k = 0; k < nNumCars; k++) {
    nRankCarTotalTimes[dummyCars[k].position - 1] = k;
  }
  nCar = Front_GetTrackRaced();
  Stattool_GetRecords(nCar,RecordHolders);
  nLapIndicator = 9;
  if (nLaps == 2) {
    nLapIndicator = 1;
  }
  for (nCar = 0; nCar < nNumCars; nCar++) {
    tCarInfo *carInfo;
    carInfo = GetCarFromSimID(&carManager, (short)dummyCars[nCar].carType);
    k = nRankCarTotalTimes[nCar];
    if ((dummyCars[k].carFlags & 0x200U) != 0) {
      purgememadr(RecordHolders);
      purgememadr(nCarTotalTimes);
      purgememadr(nRankCarTotalTimes);
      return 0;
    }
    if ((carInfo->fCarClass != 7) && (carInfo->fCarClass != 8)) {   /* MATCH: unsigned sltiu range fold */
      if ((((byte)frontEnd.gameMode < 3) && ((dummyCars[k].carFlags & 4U) != 0)) &&
         (dummyCars[k].finalFinishType == 2)) {
        bDoRecordCheck = 1;
      }
      if (bDoRecordCheck == 1) {
        k = nRankCarTotalTimes[nCar];
        nCheckTotalTime = dummyCars[k].finalTotalTime;
        bDoRecordCheck = 0;
        if ((nCheckTotalTime < RecordHolders[nLapIndicator + 6].nTime) ||
           ((RecordHolders[nLapIndicator + 7].nTime == 0 && (0 < nCheckTotalTime)))) {
          TOPLIST[k] = 1;
        }
        else if ((nCheckTotalTime < RecordHolders[nLapIndicator + 7].nTime) ||
                ((RecordHolders[nLapIndicator + 7].nTime == 0 && (0 < nCheckTotalTime)))) {
          TOPLIST[nRankCarTotalTimes[nCar]] = 1;
          LASTPLACE[nRankCarTotalTimes[nCar]] = 1;
        }
        if ((nCheckTotalTime < RecordHolders[nLapIndicator].nTime) ||
           ((RecordHolders[nLapIndicator + 7].nTime == 0 && (0 < nCheckTotalTime)))) {
          TOPLIST[nRankCarTotalTimes[nCar]] = 1;
          NUMBERONE[nRankCarTotalTimes[nCar]] = 1;
        }
      }
    }
  }
  /* MATCH W64-A17 -- REAL CFG FIX (11C branch-target audit; gate-invisible,
     caught by tools/brdist.py + tools/psyqproof.py as REAL=1 on a PASSing
     body).  Retail's chain is FLAT: from the LASTPLACE[0]!=0 / LASTPLACE[1]==0
     / TOPLIST[1]==0 path it FALLS THROUGH into the third test
     (`beqz $v0,.L8004A09C` at 0x8004A08C, offset 3), where our nested
     `if (LASTPLACE[0]) {...} else if (...)` jumped straight to the join
     (offset 12).  cse's record_jump_equiv deletes the repeated LASTPLACE[0]
     guard, so the flat spelling is codegen-identical -- gate still PASS
     299/299, and the branch word now matches. */
  if ((LASTPLACE[0] != 0) && (LASTPLACE[1] != 0)) {
    if (!(dummyCars->finalTotalTime > dummyCars[1].finalTotalTime)) {
      TOPLIST[1] = 0;
    }
    else {
      TOPLIST[0] = 0;
    }
  }
  else if ((LASTPLACE[0] != 0) && (TOPLIST[1] != 0)) {
    TOPLIST[0] = 0;
  }
  else if ((LASTPLACE[1] != 0) && (TOPLIST[0] != 0)) {
    TOPLIST[1] = 0;
  }
  if ((NUMBERONE[0] != 0) && (NUMBERONE[1] != 0)) {
    if (!(dummyCars->finalTotalTime > dummyCars[1].finalTotalTime)) {
      NUMBERONE[1] = 0;
    }
    else {
      NUMBERONE[0] = 0;
    }
  }
  retvalue = (ushort)(TOPLIST[0] != 0);
  if (NUMBERONE[0] != 0) {
    retvalue = retvalue | 2;
  }
  if (TOPLIST[1] != 0) {
    retvalue = retvalue | 4;
  }
  if (NUMBERONE[1] != 0) {
    retvalue = retvalue | 8;
  }
  purgememadr(RecordHolders);
  purgememadr(nCarTotalTimes);
  purgememadr(nRankCarTotalTimes);
  return retvalue;
}

/* ---- StatChk_SaveTopTime  (statchk.cpp:464) ----
 * REWRITE (w36-a10): SYM 8c gives fsize=176, mask=$c0ff0000, and the EXACT
 * 17-local set below (bTopTenFlag AUTO, bDoRecordCheck REG $17, nLapIndicator
 * AUTO, nPlace AUTO, nTopTenSort[8]/nTopTenIndex[8]/topPlacements[2] AUTO,
 * nCheckTotalTime REG $3, k REG $10, nCar REG $12, buffer/nCarTotalTimes
 * AUTO, nRankCarTotalTimes REG $15, DummyRaceResult AUTO, RecordHolders
 * REG $16, carInfo REG $6). The prior Ghidra recon fabricated 9 extra
 * locals (track/sortIdx/idx/playerName/recBase/rank/pSlot/slot/pRec) that
 * inflated the frame to 192 B vs the SYM's 176 B. Every fabricated temp
 * below folds into a real SYM local by tracing that its value is IDENTICAL
 * to an already-live real local at that point (e.g. Ghidra's "k=*pSlot"
 * reassignment always equals the already-computed "nCar"; "recBase"/"pRec"
 * are always "nLapIndicator" itself, never copied). Single flat SYM scope
 * (Block start line=1 .. Block end line=188) => k/nCar/nCheckTotalTime are
 * each ONE real C variable reused sequentially across the function's
 * several small loops (classic C89 "declare once at top, reuse" style),
 * matching the sibling StatChk_IsTopTime in this same file.
 *
 * MATCH W61 (2026-08-10): the duplicated finish-test arms recover retail's
 * saved-register allocation; keeping the initial record size opaque while
 * pricing the already-live nNumCars operand recovers the long exact middle;
 * memcpy_call prevents GCC's 20-byte builtin expansion; and a separate
 * loop-copy size plus its signed index input recovers retail's MULT shape.
 * Together with the explicit lap-count else, these reduce the authoritative
 * residual 199->62 at the exact 416/416 instruction count. Reusing uRecSz at
 * the tail, block-scoped size locals, declaration initializers, bulk-copy
 * identity fences, and explicit index temporaries measured neutral or worse
 * in that basin and were reverted.
 *
 * MATCH W66 (2026-08-11): model the first bulk-copy unit and its shifted byte
 * count as separate short-lived values before the expanded record assignment.
 * This recovers the retail calculation lifetime and reduces 62->59 diffs
 * (417/416 instructions); the two empty templates are identity/scheduling
 * fences only, with no register pinning or emitted instructions.
 *
 * MATCH W67 (2026-08-11): repeat the bulk unit as a read operand of its
 * zero-instruction identity fence.  The extra QTY reference changes GCC 2.8's
 * local-allocation priority and recovers the retail t2/t3/t0/t1 rotation for
 * the expanded five-word assignment, reducing 59->38 diffs (418/416).
 *
 * MATCH W68 (2026-08-14): retain strcpy's otherwise-dead return in the already
 * dead carInfo local and price that value in the bulk-unit identity fence.
 * This recovers retail's direct `li t1,20` plus the exact expanded-record word
 * rotation, reducing the authoritative residual 36->34 (418/416).  Direct
 * source-shape restoration, split first-size fences, and a distinct copy-call
 * size handoff all measured neutral or worse and were reverted.
 *
 * MATCH W69 (2026-08-15): in the W68 basin, a second identity only at the
 * final memcpy size handoff prevents uCopySz from coalescing directly into
 * hard argument $a2.  GCC now keeps the loop size in retail's $t0 and emits
 * the late `addu a2,t0,zero`, removing one instruction and reducing 34->33
 * (417/416).  Moving this fence before copyDst or duplicating it is neutral;
 * naming the source offset or reusing uBulkSz regresses to 79/62 diffs.
 *
 * W62-A16 (2026-08-15, re-gated baseline 33 @ 417/416 -- NOT the 34 the W69 note
 * implies; the basin moved, so every parked spelling below was re-priced here):
 * 🔑 NEW DEVICE FOUND for the receipted open question "what made retail's 20
 * OPAQUE without an asm" -- gcc-2.8 cse is BASIC-BLOCK-LOCAL, so a
 * `size = sizeof(T);` assignment placed on the FAR SIDE OF A LOOP from its use
 * cannot be constant-folded into the multiply expansion.  Hoisting
 * `uRecSz = sizeof(tRecordBuffer);` above the topPlacements zero-loop and
 * DELETING fence-1 keeps retail's `sll/addu/sll` *18 chain at ZERO instructions
 * and ZERO asm: 112 diffs @ 416 == the ORACLE COUNT (the fence basin is 417).
 * It is not landed because the pseudo is then live ACROSS the loop and takes
 * $a1 (forcing the nNumCars spill up 10 slots), where retail's is born AFTER
 * the loop in $t0 -- so retail's opacity is a THIRD mechanism (a REG_EQUIV
 * constant rematerialised at the use), not cross-BB and not an asm.
 * Re-gated from the 33 basin, all falsified: assign-before-loop no fence 112@416
 * / with fence 37@417 / fence-also-before-loop 120@416; assign INSIDE the loop
 * 112@416; decl-with-init 112@416; identity(no extra operand) at the use 114@416;
 * read-only at the use 112@416 (x2 operands 114); fence operand = uRecSz itself
 * 33@417 (the dead `lhu` is replaced by an equally dead `addu t0,v0,zero`),
 * = topPlacements[0] 33, = nCarTotalTimes 33, = "i"(0) 110@416, double identity
 * 110@416, = dummyCars (a ZERO-INSN operand, already in $fp) 110@416.
 * ⇒ 12E's law reproduced exactly: every operand that costs a real insn gives 33
 * (retail's REGISTERS, +1 count); every zero-insn operand gives 110-112
 * (retail's COUNT, wrong registers).  The device is priced, not free.
 * The cross-BB device does NOT transfer to the other two size sites: uBulkUnit
 * hoisted above the placement loop = 193@421 (no f2) / 235@421 (f2 kept), and
 * uCopySz hoisted above the copy loop = 248@424 / 327@423 -- both hoists escape
 * the outer per-car loop and buy a callee-saved home.  Dropping f3 alone = 60@416.
 *
 * W64-A17 (2026-08-15, re-gated baseline 33 @ 417/416 -- unchanged basin):
 * LANDED (scaffolding only, gate-neutral): fence-2 lost its INERT `uBulkSz`
 * operand (`"r"(uBulkUnit),"r"(uBulkSz)` -> `"r"(uBulkUnit)`), re-confirmed
 * EXACTLY 33 @ 417 -- one fewer artificial operand for the same result.
 * THE +1 IS NOW FULLY ITEMISED (three sites, read off tools/side_by_side.py):
 *   site 1 (uRecSz*18) ours `li v0,20; lhu t0,96(sp); ... sll s0,v0,3;
 *          addu a1,s0,v0` vs retail `li t0,20; sll s0,t0,3; addu a1,s0,t0`
 *          => +1 (the dead `lhu` = fence-1's `"r"(nNumCars)` price);
 *   site 2 (uBulkUnit*8) ours `li t1,20; addu v0,t1,zero; sll a2,v0,3` vs
 *          retail `li t1,20; sll a2,t1,3` => +1 (the identity fence's
 *          output copy: `"=r"/"0"` puts the asm result in a NEW pseudo);
 *   site 3 (memcpy size) ours `li a2,20 ... mult v0,a2` vs retail
 *          `li t0,20; mult v0,t0; addu a2,t0,zero` => -1 (retail's copy).
 *   +1 +1 -1 = +1 == 417-416.  QED.
 * NEW FALSIFICATIONS this wave (all re-gated from the 33 basin):
 *   - fence-2 DROPPED entirely 60 @416 (retail's COUNT, wrong registers --
 *     the 12E law again, and the SAME 60@416 basin as dropping f3);
 *   - site-2 identity fence -> READ-ONLY fence (the one shape that should
 *     delete its output copy) 35 @417 -- the copy is NOT the fence's output
 *     but the global-allocno price 13B names, so removing the output does
 *     not remove the copy;
 *   - read-only + fence-2 reduced 60 @416 (same basin);
 *   - fence-3 given a second read operand (`uCopySz` / `copyDst`) 33 @417
 *     both -- the site-3 missing `addu a2,t0,zero` is not ref-reachable.
 * => the residual stays the priced 12E certificate: EVERY zero-insn device
 * buys retail's COUNT (416) with the wrong registers (60-115 diffs), every
 * insn-costing operand buys retail's REGISTERS at +1 count (33).  The open
 * item is unchanged and is retail's THIRD opacity mechanism for the literal
 * 20 (a REG_EQUIV constant rematerialised at the use, born after the
 * topPlacements loop in $t0) -- an instrumented-cc1 job, not a spelling.
 *
 * W67-A8 (2026-08-15, re-gated baseline 33 @ 417/416): the do-while(0) DEPTH
 * WRAPPER probed as the NON-FENCE ref instrument at sites 1+2 -- it
 * reproduces the 12E law exactly like every other zero-insn device and does
 * NOT combine with the register half.  All re-gated, all reverted: wrapper
 * on the uBulkUnit assignment replacing the identity fence 60 @416 (retail
 * count, wrong regs = the fence-2-dropped basin) / at depth 2 60 @416 /
 * minus the RO fence 59 @415; wrapper around the uBulkSz multiply with the
 * identity fence KEPT 33 (inert) / with a RO carInfo fence instead 34 @416
 * -- count EXACT but structurally FALSE (cse folds 20*8 through the
 * stripped phony loop into `li a2,160`; the sll is gone, so NOT landed);
 * wrapper on the uRecSz assignment with a no-operand identity 110 @416 /
 * no fence 111 @413 / depth 2 111 @413 / RO fence 34 @414 (3 short) / full
 * fence kept 33 (inert); laundering uBulkSz instead of uBulkUnit 57 @417.
 * => the wrapper buys only the count half (59-111 basins); the 12E
 * certificate now stands on a second instrument family.
 * Harness: scratchpad/w67a8/stt_v{1,2}.json + probe.py.
 *
 * 🏆 W71-A18 (2026-08-21): 33 -> PASS 416/416, ALL THREE FENCES DELETED.
 * The "third opacity mechanism" the W62/W64 certificates named as an
 * instrumented-cc1 job was reachable from source after all, and it is the
 * ordinary 1998 shape: ONE record-size variable for the whole function.
 *   - `uRecSz = sizeof(tRecordBuffer);` is assigned ONCE, BEFORE the
 *     topPlacements zero-loop, and feeds every size site (uRecSz*18,
 *     uRecSz*8 twice, and the per-record copy size).  gcc-2.8's cse is
 *     BASIC-BLOCK-LOCAL, so with the loop between def and uses the constant
 *     can never be folded into the multiply expansions -- retail's
 *     `li 20; sll,3; addu; sll,1` (*18) and `li 20; sll,3` (*8) shift chains
 *     come out for free, with ZERO asm (the W62 cross-BB device, which was
 *     parked because a SHORT-lived hoisted pseudo takes $a1).
 *   - The reason it now works is the LIVE RANGE: one variable used at all
 *     three sites is CALL-CROSSING across the whole outer per-car loop, so
 *     it needs a callee-saved home; with mask $c0ff0000 the s-pool is full,
 *     it loses allocation, and reload REMATERIALIZES its REG_EQUIV constant
 *     at each use -- which is exactly retail's three independent `li 20`s in
 *     three different scratch registers (t0 / t1 / t0), including the late
 *     `addu a2,t0,zero` at the memcpy site that fence-3 used to buy at +1
 *     instruction.  The old three-short-lived-variables shape could never
 *     produce it: each got its own caller-saved register, and every device
 *     that made one opaque cost the instruction the 12E certificate priced.
 *   - The whole 12E "count XOR registers" certificate is therefore RETIRED
 *     for this function: the correct source shape buys BOTH.
 * Re-gated variants: the same single variable defined AFTER the loop (same
 * BB as its first use) = 87 @413 -- cse folds it and three insns vanish;
 * single variable + the old fence-1 kept = 187 @421.  Post-seal cleanup
 * (all re-gated PASS): uBulkUnit/uBulkSz/uCopySz decls dropped and both
 * derived sizes spelled inline (`uRecSz * 8`, `uRecSz`).
 * Harness: scratchpad/A18/stt_v1.json + stt_clean2.json + probe.py. */
void StatChk_SaveTopTime(Car_tStats *dummyCars,short nNumCars)

{
  bool bTopTenFlag;
  bool bDoRecordCheck;
  short nLapIndicator;
  short nPlace;
  int nTopTenSort [8];
  short nTopTenIndex [8];
  int nCheckTotalTime;
  /* SYM-CODEGEN-CARRIER: uRecSz -- retail records no source local, but one
     function-wide record-size variable is required to preserve the three
     separate constant rematerializations and shift chains.  Spelling
     sizeof(tRecordBuffer) directly is FAIL 126 (412/416). */
  unsigned int uRecSz;
  short k;
  short nCar;
  char *buffer;
  int *nCarTotalTimes;
  short *nRankCarTotalTimes;
  tRecordBuffer DummyRaceResult;
  tRecordBuffer *RecordHolders;
  tCarInfo *carInfo;
  int topPlacements [2];

  uRecSz = sizeof(tRecordBuffer);
  bDoRecordCheck = false;
  bTopTenFlag = false;
  nPlace = 0;
  for (k = 0; k < 2; k = k + 1) {
    topPlacements[k] = 0;
  }

  RecordHolders = (tRecordBuffer *)reservememadr("toprcrds",uRecSz * 18,0x10);
  nCarTotalTimes = (int *)reservememadr("carttime",nNumCars * sizeof(int),0x10);
  nRankCarTotalTimes = (short *)reservememadr("carttrnk",nNumCars * sizeof(short),0x10);
  buffer = (char *)reservememadr("records",uRecSz * 8,0x10);

  for (k = 0; k < nNumCars; k = k + 1) {
    nRankCarTotalTimes[dummyCars[k].position - 1] = k;
  }

  Stattool_GetRecords(Front_GetTrackRaced(),RecordHolders);

  if (Front_GetLapsForType() == 2) {
    nLapIndicator = 1;
  }
  else {
    nLapIndicator = 9;
  }

  for (nCar = 0; nCar < nNumCars; nCar = nCar + 1) {
      carInfo = GetCarFromSimID(&carManager,
                 (short)dummyCars[nRankCarTotalTimes[nCar]].carType);
      if ((carInfo->fCarClass != 7) && (carInfo->fCarClass != 8)) {   /* MATCH: unsigned sltiu range fold */
        if ((byte)frontEnd.gameMode < 3) {
          if (((dummyCars[nRankCarTotalTimes[nCar]].carFlags & 4U) != 0) &&
              (dummyCars[nRankCarTotalTimes[nCar]].finalFinishType == 2))
          {
            bDoRecordCheck = true;
          }
        }
        else if (nRankCarTotalTimes[nCar] == GameSetup_gData.localCar) {
          if (((dummyCars[nRankCarTotalTimes[nCar]].carFlags & 4U) != 0) &&
              (dummyCars[nRankCarTotalTimes[nCar]].finalFinishType == 2))
          {
            bDoRecordCheck = true;
          }
        }
        if (bDoRecordCheck == true) {
          nCheckTotalTime = dummyCars[nRankCarTotalTimes[nCar]].finalTotalTime;
          bDoRecordCheck = false;
          if ((nCheckTotalTime < RecordHolders[nLapIndicator + 7].nTime) ||
             ((RecordHolders[nLapIndicator + 7].nTime == 0) && (0 < nCheckTotalTime))) {
            DummyRaceResult.nTime = nCheckTotalTime;
            DummyRaceResult.nCar = *(signed char *)&carInfo->fCarID;   /* MATCH: lb, plain char is unsigned here */
            bTopTenFlag = true;
            DummyRaceResult.nBestLap = dummyCars[nRankCarTotalTimes[nCar]].finalBestLap;
            RecordHolders[nLapIndicator + 7] = DummyRaceResult;
            for (k = nLapIndicator; k < nLapIndicator + 8; k = k + 1) {
              nTopTenSort[k - nLapIndicator] = RecordHolders[k].nTime;
              if (nTopTenSort[k - nLapIndicator] == 0) {
                nTopTenSort[k - nLapIndicator] = (k + 1) * 0x23280;
              }
            }
            Stattool_nCreateIndex(8,nTopTenSort,nTopTenIndex);
            for (k = 0; k < 8; k = k + 1) {
              if (nTopTenIndex[k] == 7) {
                nPlace = k + 1;
              }
            }
            for (k = 0; k < 8; k = k + 1) {
              if (nTopTenIndex[k] == nRankCarTotalTimes[nCar]) {
                topPlacements[nRankCarTotalTimes[nCar]] = (int)nPlace;
                break;
              }
            }
            carInfo = (tCarInfo *)strcpy(DummyRaceResult.sName,
                                        PlayerName((int)nRankCarTotalTimes[nCar]));
            RecordHolders[nLapIndicator + 7] = DummyRaceResult;
            memcpy_call(buffer,&RecordHolders[nLapIndicator],uRecSz * 8);
            for (k = 0; k < 8; k = k + 1) {
              memcpy_call((tRecordBuffer *)
                          ((nLapIndicator + k) * (int)sizeof(tRecordBuffer) +
                           (int)RecordHolders),
                          buffer + nTopTenIndex[k] * uRecSz,uRecSz);
            }
          }
        }
      }
  }
  if (bTopTenFlag == true) {
    blockmove(RecordHolders,Stats_gTrackRecords + Front_GetTrackRaced() * 0x11,0x154);
  }
  if (topPlacements[0] == topPlacements[1]) {
    topPlacements[1] = topPlacements[0] + 1;
  }
  else if ((topPlacements[1] != 0) && (topPlacements[1] < topPlacements[0])) {
    topPlacements[0] = topPlacements[0] + 1;
  }
  for (k = 0; k < 2; k = k + 1) {
    if ((topPlacements[k] != 0) && (topPlacements[k] < 9)) {
      NewRecords[topPlacements[k] - 1] = 1;
    }
  }
  purgememadr(buffer);
  purgememadr(RecordHolders);
  purgememadr(nCarTotalTimes);
  purgememadr(nRankCarTotalTimes);
  return;
}

/* ---- StatChk_ClearNewRecords  (statchk.cpp:664) ---- */
void StatChk_ClearNewRecords(void)

{
  int *pRec;
  int i;
  
  i = 7;
  pRec = NewRecords;
  pRec = pRec + 7;   /* MATCH: SYM-CODEGEN-CARRIER: pRec -- split -> la NewRecords
                         + separate addiu 0x1C (oracle unfused). */
  do {
    *pRec = 0;
    i = i + -1;
    pRec = pRec + -1;
  } while (-1 < i);
  NewBestLap = 0;
  return;
}

/* end of statchk.cpp */

#undef NewRecords
#undef NewBestLap
bool NewRecords[8];   /* @0x80052978; SYM EXT BOOL[8] */
bool NewBestLap;      /* @0x80052998; SYM EXT BOOL */
