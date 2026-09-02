/* game/common/nfs3.cpp -- RECONSTRUCTED (game boot / module start-up + main() entry; C TU, 11 fns) */
#include "nfs3_types.h"
#include "nfs3_externs.h"
#include "../../lib/nfile.h"   /* FileMgr @0x8013EA88 == the `gFileDevice` symbol */


/* ---- nfs3.obj-OWNED globals -- DEFINED here (self-contained; SYM-typed via gen_owned_defs:
   .data = real NFS4.EXE bytes, .bss = zero) ---- */
char         befuddleExtensions[14][4] = { 113, 112, 108, 0, 97, 105, 105, 0, 115, 112, 100, 0, 113, 97, 108, 0, 115, 97, 108, 0, 100, 116, 97, 0, 113, 112, 115, 0, 105, 110, 102, 0, 113, 100, 97, 0, 99, 97, 114, 0, 113, 97, 115, 0, 113, 100, 116, 0, 115, 112, 108, 0, 115, 112, 101, 0 };   /* @0x8011423c */
tCarManager  carManager;   /* @0x80114274  (bss(zero)) */
tfrontEnd    frontEnd;   /* @0x80114600  (bss(zero)) */
tTrackManager trackManager;   /* @0x80114a50  (bss(zero)) */
tTournamentManager tournamentManager;   /* @0x80114ad8  (bss(zero)) */
tCreditManager CreditManager;   /* @0x80114d5c  (bss(zero)) */
tRecordBuffer Stats_gTrackRecords[187];   /* @0x80114d94  (bss(zero)) */
char         gTournamentFinishOrder[12];   /* @0x80115c30  (bss(zero)) */
char         befuddleTemp[10];   /* @0x80115c3c  (bss(zero)) */
/* W64-A18: the eight .sdata objects below carry an EXPLICIT `= 0` initialiser.
 * They are genuinely zero in retail, but a TENTATIVE definition (no initialiser)
 * is emitted AFTER every initialised object in the same section, which put this
 * TU's 88-byte small-data run 0x8013D270..0x8013D2C8 in the wrong ORDER (ownmap
 * E3: 4 distinct implied bases).  Retail INTERLEAVES initialised and zero objects,
 * which only happens when all of them are initialised.  Do NOT drop the `= 0`. */
char         gMusicInSimIsOn = 1;   /* @0x8013d270 */
int          gUseFrontend = 1;   /* @0x8013d274 */
u_long       gFECheats = 0;   /* @0x8013d278 */
u_long       gFEBonus = 0;   /* @0x8013d27c */
int          gFEBigHandle = 0;   /* @0x8013d280 */
bool         MEMCARDFRONTENDISINITTED = false;   /* @0x8013d284; SYM BOOL, 4-byte C++ bool */
char         gCheckTotalTime = 1;   /* @0x8013d288 */
char         gCheckLapTime = 1;   /* @0x8013d289 */
char         gUpdateTournamentInfoFlag = 1;   /* @0x8013d28a */
char         gUpdateKnockoutInfoFlag = 1;   /* @0x8013d28b */
char         gKnockOutSpeechFlag = 1;   /* @0x8013d28c */
char         gCalculateVictory = 1;   /* @0x8013d28d */
char         gPlayerEnteredNameAlready[2] = {0, 0};   /* @0x8013d290 */
/* W67-A4: the next three are TENTATIVE on purpose -- retail emits them AFTER the
   TU's -G8 string-literal pool 0x8013d294..0x8013d2b4 ("%s%s" "ymus" "win*" "lose*"),
   i.e. in the deferred batch, while every cell above is initialised (16E =0
   discriminator, read in reverse).  First-declaration order nfs_sysInfo ->
   missionManager -> finishOrder is load-bearing (17B).  DO NOT initialise. */
tNfsSystemInfo nfs_sysInfo;   /* @0x8013d2b4 */
tMissionManager missionManager;   /* @0x8013d2b8 */
char         finishOrder[8];   /* @0x8013d2c0 */


/* ---- Nfs2_SystemNLibStartUp  [NFS3.CPP:118-135] SLD-VERIFIED ---- */


void Nfs2_SystemNLibStartUp(void)

{
  /* SYM-CODEGEN-CARRIER: p -- retail's source-level
   * `Speech::fgUndefined = new Speech::Speaker` has no named local, but the
   * flattened reconstruction must spell the implicit new-expression result
   * explicitly while installing Speaker's vptr and zeroing fSub.  Assigning
   * __builtin_new directly to the global keeps 25 instructions but moves both
   * constructor stores after the global store (4 authoritative diffs); this
   * carrier preserves retail's constructor-before-publication order exactly. */
  int p;

  Platform_SysStartUp();
  Loading_GetInitialMemory();
  if (_6Speech_fgUndefined == 0) {
    p = (int)__builtin_new(0x50);
    *(void ***)(p + 0x4c) = (void **)Speaker_vtable;
    *(int *)(p + 0x48) = 0;
    _6Speech_fgUndefined = p;
  }
  Render_InitLibRender();
  return;
}



/* ---- Nfs2_BefuddleCode  [NFS3.CPP:178-181] SLD-VERIFIED ---- */


void Nfs2_BefuddleCode(void)

{
  int loop;

  loop = 0;
  do {
    strcpy(befuddleTemp,befuddleExtensions[loop]);
    loop = loop + 1;
  } while (loop < 0xe);
  return;
}



/* ---- Nfs2_ResetGame  [NFS3.CPP:186-348] SLD-VERIFIED ---- */


void Nfs2_ResetGame(void)

{
  Replay_ResetReplay();
  BWorld_Restart();
  Sim_Restart();
  Camera_Init();
  Weather_Restart();
  AudioCmn_Reset();
  Speech_Reset();
  AudioClc_StartUp();
  DashHUD_ResetHUD();
  return;
}



/* ---- NFS4_LoadPerps  [NFS3.CPP:247-348] SLD-VERIFIED ---- */


static void NFS4_LoadPerps(void)

{
  char *buffer;
  char *data;
  char *cars;
  tCarInfo *carData;
  char filename[64];
  u_long numTiers;
  u_long numMissions;
  u_long numCars;
  short i;
  u_long j;
  GameSetup_tPerpData *perpInfo;

  if (0 < GameSetup_gData.numPerps) {
    sprintf(filename,"%s%s",Paths_Paths[0x25],
            GameSetup_gData.commMode != 1 ? "zHPurs.mis" : "zHPurs2.mis");
    buffer = (char *)loadfileadr(filename,0x10);
    sprintf(filename,"%s%s",Paths_Paths[0x25],"fecars.car");
    cars = (char *)loadfileadr(filename,0x10);

    numTiers = *(u_long *)buffer;
    numMissions = *(u_long *)(buffer + 4);
    numCars = *(u_long *)cars;
    data = buffer + 12;
    data += numTiers * 4;
    data += numMissions * 20;
    data += GameSetup_gData.stageOffset * 44;
    perpInfo = GameSetup_gData.perpInfo;

    i = 0;
    if (0 < GameSetup_gData.numPerps) {
      carData = (tCarInfo *)(cars + 4);
      do {
      for (j = 0; j < numCars; j++) {
        if ((int)(signed char)carData[j].fCarID == (u_int)(u_char)data[0])
          break;
      }
      if (j >= numCars)
        j = 0;

        perpInfo->CarType = carData[j].fSimNumber;
        perpInfo->Colour = (u_char)data[1];
        perpInfo->Personality = (u_char)data[2];
        perpInfo->TimeLimit = *(short *)(data + 4);
        if (GameSetup_gData.commMode != 1) {
          perpInfo->WingmanTime = *(short *)(data + 6);
          perpInfo->SpikeBeltTime = *(short *)(data + 8);
          perpInfo->BlockadeCopTime = *(short *)(data + 10);
        }
        else {
          perpInfo->WingmanTime = -1;
          perpInfo->SpikeBeltTime = -1;
          perpInfo->BlockadeCopTime = -1;
        }

        perpInfo->Distance = *(u_short *)(data + 14);
        perpInfo->SpeedFactor = *(int *)(data + 16);
        perpInfo->WeightFactor = *(int *)(data + 20);
        perpInfo->GlueFactor = *(int *)(data + 24);
        perpInfo->SpeechColour = carData[j].fSpeechColors[(u_char)data[1]];
        perpInfo->HudColour =
            ((carData[j].fColorList[(u_char)data[1]] & 0xff0000) >> 16) |
            (carData[j].fColorList[(u_char)data[1]] & 0xff00) |
            ((carData[j].fColorList[(u_char)data[1]] & 0xff) << 16);

        data += 44;
        perpInfo++;
        i++;
      } while (i < GameSetup_gData.numPerps);
    }
    purgememadr(buffer);
    purgememadr(cars);
  }
}



/* ---- Nfs2_GameModuleStartUp  [NFS3.CPP:357-460] SLD-VERIFIED ---- */


void Nfs2_GameModuleStartUp(int *FrontEndDataStream)

{
  Audio_InitDriver(0,0);
  restoretextdraw();
  Platform_InitMemory();
  Platform_ResetDCTBuffer();
  GameSetup_StartUp(FrontEndDataStream);
  Replay_InitReplay();
  Nfs2_BefuddleCode();
  Loading_DrawLoadingScreen();
  Loading_UpdateLoadingScreen(1);
  NFS4_LoadPerps();
  Loading_UpdateLoadingScreen(2);
  Physics_CheckGamedata();
  Clock_SystemStartUp();
  AudioCmn_LoadGameSamples();
  CopSpeak_StartUp();
  if ((GameSetup_gData.raceType == RaceType_HotPursuit) && (_6Speech_fgSpeech == 0)) {
    _6Speech_fgSpeech = (int)__6Speech(__builtin_new(0x3a4));
  }
  Render_InitPauseMenu();
  Render_InitTrackRender();
  Loading_UpdateLoadingScreen(4);
  BWorld_Init();
  Loading_UpdateLoadingScreen(6);
  Hrz_InitHorizon();
  Night_InitNightDriving();
  Weather_Init();
  Loading_UpdateLoadingScreen(7);
  Sim_StartUp();
  Render_InitTrackRenderPostSim();
  Hud_InitMap();
  SimQueue_StartUp();
  if (((D_801131F8[0] == 1) ? 0x13000 : 0xb000) < largestunused()) {
    AudioMus_SysStartUp(0x6000,0x14000,"ymus");
  }
  AudioMus_BuildPlayList(GameSetup_gData.userSetting.numplaylistsongs,GameSetup_gData.userSetting.playlist);
  largestunused();
  return;
}



/* ---- Nfs2_CleanUpGameModule  [NFS3.CPP:464-549] SLD-VERIFIED ----
 * MATCH RECEIPT: SYM lists only `short k`; the seven pointer/value temporaries
 * in the prior reconstruction were decompiler inventions.  Retail's ten
 * four-word copy iterations are CC1PLPSX's expansion of the single 160-byte
 * Car_tStats aggregate assignment below.  Replacing the manual field-copy
 * loop with the source-level assignment reduced 57 diffs directly to PASS
 * (105/105). */


void Nfs2_CleanUpGameModule(void)

{
  short k;
  
  Render_KillTrackRender();
  Render_KillPauseMenu();
  k = 0;
  if (0 < GameSetup_gData.numCars) {
    do {
      Cars_gList[k]->stats.carType = Cars_gList[k]->carInfo->carType;
      Cars_gList[k]->stats.carClass = Cars_gList[k]->carInfo->carClass;
      Cars_gList[k]->stats.carNameIndex = Cars_gList[k]->carInfo->carNameIndex;
      Cars_gList[k]->stats.carFlags = Cars_gList[k]->carFlags;
      Cars_gNewCarStatsList[k] = Cars_gList[k]->stats;
      k = k + 1;
    } while (k < GameSetup_gData.numCars);
  }
  Replay_StoringReplay();
  AudioCmn_DeInit();
  if (_6Speech_fgSpeech != 0) {
    ___6Speech((void *)_6Speech_fgSpeech,3);
    _6Speech_fgSpeech = 0;
  }
  CopSpeak_CleanUp();
  Clock_SystemCleanUp();
  GameSetup_CleanUp();
  Sim_CleanUp();
  Hrz_KillHorizon();
  BWorld_DeInit();
  Camera_Kill();
  Weather_DeInit();
  Audio_DeInitDriver();
  return;
}



/* ---- LoadFrontendOverlay  [NFS3.CPP:560-580] SLD-VERIFIED ---- */


void LoadFrontendOverlay(void)

{
  int handle;
  
  handle = asyncloadfileat("front.bin",bigBuf);
  while (getasyncreadstatus(handle) == 0) {
    systemtask(0);
  }
  return;
}



/* ---- LoadOverlay  [NFS3.CPP:589-596] SLD-VERIFIED ---- */


void LoadOverlay(void)

{
  int handle;
  char fname [60];
  
  LoadFrontendOverlay();
  sprintf(fname,"%sDCT.BIN",Paths_Paths[0x20]);
  handle = asyncloadfileat(fname,(int)&CF_DVLC);
  while (getasyncreadstatus(handle) == 0) {
    systemtask(0);
  }
  return;
}



/* ---- NFS4_LoadingIcon  [NFS3.CPP:626-669] SLD-VERIFIED ---- */


void NFS4_LoadingIcon(void)

{
  char *ldfile;
  shapetbl *shp;
  int lang;
  char fname [80];
  RECT r;

  sprintf(fname,"%sldic.psh",Paths_Paths[0x25]);
  ldfile = (char *)loadfileadr(fname,0);
  lang = (int)(u_char)frontEnd.language;
  if (5 < lang) {
    lang = 0;
  }
  shp = (shapetbl *)shapepointer(ldfile,lang);
  r.w = 0x400;
  r.x = 0;
  r.y = 0;
  r.h = 0x200;
  ClearImage(&r,'\0','\0','\0');
  DrawSync(0);
  initlinkmode(0,100,0);   /* oracle 0x94650: a2=0 (dropped 3rd arg) */
  Draw_DirectSetEnvironment(0,0,0x200,0xf0,1,1,1,0,0,0);
  settrans(0);
  movfxya(shp,0x1e2 - shp->width,0xd2);
  DrawSync(0);
  purgememadr(ldfile);
  initlinkmode(0,1,1);   /* oracle 0x946c0: a2=1 (dropped 3rd arg) */
  return;
}



/* ---- NFS3_CheckForFileOperations  [NFS3.CPP:686-694] SLD-VERIFIED ---- */


void NFS3_CheckForFileOperations(void)

{
  /* MATCH: retail walks the eaclib FileMgr's op-slot array (+0x18) up to the handle array
   * (+0x1C) through ONE CSE'd %hi/%lo(gFileDevice) base. Direct gFileMgr field expressions
   * preserve that shape without a non-SYM pointer local or two invented small globals.
   *
   * W59-A4 NAMED ANGLE for the residual 9 (ours 20 / oracle 21), fully decoded:
   * retail's two zeroed asm operands land in $a2 and $a0 (`addu a2,zero,zero;
   * addu a0,a2,zero`), so the asm CLOBBERS $a0 -- which is why retail must copy the
   * loop bound out of the load's $a0 into $a1 (`addu a1,a0,zero` in the guard's
   * beqz slot, oracle insn 7) and tests `sltu v0,v1,a1` inside the loop.  Ours gets
   * $a1/$a2 for the operands, leaves $a0 free, needs no copy, and is 1 insn shorter.
   * Every diff is downstream of that ONE operand-register choice.
   * MEASURED FALSIFIED: a shared `int zero = 0;` local for both operands (8 diffs but
   * gcc hoists a single `addu a1,zero,zero` OUT of the loop -- 19 insns, retail
   * materializes both INSIDE); a named `int *end` loop bound (inert, 9).
   * Per 08D this class is only reachable by naming the register, i.e. the
   * USER-blocked $4-clobber-fence policy -- do not spend spellings here.
   *
   * W61-A13 (2026-08-15) -- THE PARKED "$4-CLOBBER POLICY" PREMISE IS REFUTED,
   * and 9 -> 8 landed PIN-FREE.  Two separate findings:
   *
   * (1) LANDED, pin-free: the template is `"break 0x666\n\tnop"`, not `"break 0x666"`.
   *     Retail's oracle carries a standalone `nop` right AFTER the break (insn 14,
   *     NOT a delay slot -- the bnez slot is insn 18).  Neither maspsx nor GNU as
   *     emits it for us, so it belongs in the transcription, exactly like the
   *     explicit post-`jal` nops in PATCH.cpp/blockmove (catalog SS-G rows).
   *     RESULT: 9 diffs (ours 20 / oracle 21) -> 8 diffs, COUNT-EXACT 21/21.
   *     The whole residual is now the single operand-register question below.
   *
   * (2) THE POLICY QUESTION IS AIMED AT THE WRONG MECHANISM.  Priced on the real
   *     gate (all probes restored; nothing pin-adjacent was landed):
   *         base + nop template, no clobber ........ 8 diffs  21/21   [LANDED]
   *         + clobber "$4"  (the parked device) .... 2 diffs  21/21
   *         + clobber "$5" ......................... 6 diffs  21/21
   *         + clobber "$7" ......................... 8 diffs  21/21
   *     The clobber-"$4" residual is `-addu a3,a2,zero` / `+addu a0,a2,zero`:
   *     retail's SECOND asm operand IS $a0.  Retail does not clobber $a0 -- it
   *     ALLOCATES $a0 to the operand, which is precisely why the loop bound has to
   *     be copied out of $a0 into $a1 (`addu a1,a0,zero` in the guard's beqz slot)
   *     and why the loop tests `sltu v0,v1,a1`.  A $4 clobber therefore CANNOT
   *     reproduce retail (it forbids the very allocation retail made) and stalls at
   *     2.  => the standing "$4-clobber sign-off" item does not unblock this fn; the
   *     real question is a pin-free ASM-OPERAND allocation dial: make gcc hand the
   *     operand pair {$a2,$a0} instead of {$a1,$a2}.
   *     ALSO FALSIFIED in the NEW 21/21 basin (09K basin-relative re-test of the
   *     W59 verdicts): named bound `int *end = mgr->handlearray;` = 8 (inert here
   *     too); read-only fence on `end` = 10; `while` form = 16 @19; three "r"(0)
   *     operands = 9 @22; "memory" clobber = 18 @21; two named zero locals = 15 @18.
   *     Next instrument: -dl/-dg on this TU to read which allocno wins $a0.
   *
   * W62-A12 (2026-08-15) -- THAT INSTRUMENT WAS RUN.  The residual is NOT a
   * local-alloc or a global-alloc question at all: it is a RELOAD SPILL-REGISTER
   * choice.  Real CC1PLPSX -dl/-dg on this TU says, verbatim:
   *     ;; 3 regs to allocate: 82 86 83
   *     ;; Need 2 regs of class GR_REGS (for insn 38).
   *     Spilling reg 5.  Spilling reg 6.
   *     ;; Register dispositions: 82 in 3   83 in 4   86 in 4
   * insn 38 is the `break 0x666` asm.  Its two "r"(0) operands are satisfied by
   * RELOAD spill regs, and reload picks the lowest hard regs that are not live --
   * $5,$6 for us because $4 is occupied for the whole loop by the bound (allocnos
   * 83 AND 86 both land in reg 4; they do not conflict, so nothing forces them
   * apart).  Retail's bound lives in $5 (freed $4 by the copy `addu a1,a0,zero` in
   * the guard's beqz slot), so ITS reload spilled {6,4} -- which is exactly the
   * {$a2,$a0} operand pair.  ⇒ the whole residual reduces to ONE question: make
   * allocnos 83/86 conflict so the loop-carried one is forced off $a0.
   * FALSIFIED W62-A12 (real gate runs, all 21/21): 13B identity launder on a named
   * bound `int *end` 10; the same with decl-with-init split 10; two locals
   * `lim`/`end` with the second laundered 10; identity launder on the WALKER 8
   * (inert); laundered bound with the walker initialised first 8 (inert).
   * The launder makes the bound die twice -> it becomes a global allocno, but it
   * still does not CONFLICT with the load's pseudo, so both keep reg 4.
   * ROUTE: a source shape whose pre-loop test and loop test use SIMULTANEOUSLY-LIVE
   * pseudos (retail's `addu a1,a0,zero` is that overlap made visible), or the
   * reload-side instrument.  The $4-clobber policy item stays refuted.
   *
   * W69 (2026-08-16) -- THE ROUTE ABOVE WAS WALKED WITH THE NEW W69 DEVICE (the
   * NON-VOLATILE identity launder `asm("" : "=r"(x) : "0"(x) : "$N")`, which
   * seals StatusReply in speech.cpp: an asm WITH an output is not volatile, so it
   * is a zero-insn hard-register CONFLICT that is NOT a sched barrier).  Result:
   * the residual is now a PROVEN MUTUAL EXCLUSION, and the best form is a TRAP,
   * so the natural 8-diff body is deliberately KEPT.  Everything measured:
   *   -- $4-denying devices (any placement) ....................... 2 diffs 21/21
   *      `asm("" : : : "$4")` at the top of the loop body ......... 2
   *      launder on the walker `piVar1` + "$4", top of body ....... 2
   *      the same two INSIDE the `if` ............................. 3 @22
   *      (and, from W61, the "$4" clobber on the trap asm itself ... 2)
   *      ALL of them fix the WHOLE loop -- the bound moves off $a0 to $a1, the
   *      copy `addu a1,a0,zero` mints in the beqz slot, the loop tests `a1` --
   *      and ALL of them leave exactly `-addu a3,a2,zero / +addu a0,a2,zero`.
   *   !!! WHY THAT IS A CAP, NOT A NEAR-MISS (the new certificate): the trap asm's
   *      two `"r"(0)` operands are satisfied by RELOAD SPILL REGISTERS (W62-A12's
   *      -dl/-dg reading, unchanged), and reload puts every EXPLICITLY-USED hard
   *      register into bad_spill_regs (reload1.c:3894, the 13E law).  A clobber
   *      of "$4" ANYWHERE IN THE FUNCTION therefore removes $a0 from the spill
   *      pool for the WHOLE function.  So the one dial that moves the bound off
   *      $a0 is the same dial that forbids retail's `addu a0,a2,zero`: the two
   *      halves of this residual cannot both be bought with a hard-reg clobber.
   *      => landing the 2-diff form would BAKE IN THE BLOCKER (the W64 "an
   *      INHERITED fence can BE the blocker" hazard).  Natural body retained.
   *   -- overlap shapes (split `e` for the pre-test / laundered `lim` for the
   *      loop, so the two bound pseudos are simultaneously live -- exactly the
   *      route W62-A12 asked for).  They DO mint a real copy, but gcc then self-
   *      temps the load (`lw v0,28(v0)`) instead of retail's `lw a0,28(v0)` and
   *      spends the copy on the load-delay slot instead of the beqz slot:
   *        launder, no clobber .................. 13 @22
   *        launder + "$4" ........................ 9 @22
   *        launder + "$5" ....................... 11 @22   + "$6" ... 13 @22
   *      Denying $v0 to force the load up one register wrecks the walker/base
   *      pair instead (clobber "$2" 18, "$2","$5" 20, "$2","$3" 18, "$2","$6" 20,
   *      "$2","$7" 18 -- all 21/21).
   *   -- >>> BEST FENCE-COMPATIBLE, NON-$4 form: rotate the loop by hand
   *      (`e = handlearray; p = oparray; if (p < e) { do {...; p++;} while
   *      (p < lim); }`) with `lim` laundered from `e` INSIDE the guard and the
   *      launder clobbering "$5" ................................. 6 diffs 21/21
   *      (the same shape with "$4" 8, no clobber 8; the pre-guard placements 8/8/6).
   *      Not landed either: it is 2 worse than the $4 forms, needs a loop
   *      restructure, and still carries a fence into a non-sealed basin.
   *   -- named `end` + launder in the loop BODY: "$4" 8, "$5" 8, none 10, "$6" 10.
   *   -- named `end` + launder before the loop: "$4" 8, none 10, volatile "$4" 8.
   *   ROUTE UNCHANGED AND NOW SHARPER: the only remaining instrument is one that
   *   moves the loop-carried bound off $a0 WITHOUT naming a hard register --
   *   i.e. a third simultaneously-live value in the loop that legitimately takes
   *   $a0 (retail's own reason), or a reload-side spill-order dial.
   *
   * W71-A7 (2026-08-21) -- 8 STAYS @21/21.  The named route was attacked directly by
   * ADDING A THIRD ASM OPERAND (a real register-resident value, so it needs no spill
   * reg of its own and cannot be the "three r(0) operands" row already falsified):
   *     third operand "r"(p)   (the walker)          8 diffs 21/21  -- INERT
   *     third operand "r"(gFileMgr.handlearray)     18 diffs 23/21  -- +2 insns
   * A register-resident third operand does not enter the reload spill decision at all,
   * so it cannot move allocnos 83/86 apart; a memory-resident one pays real
   * instructions.  ⇒ the "third simultaneously-live value" route has to come from a
   * value the LOOP genuinely needs (not from an asm operand), or from the reload-side
   * instrument.  The W69 mutual-exclusion certificate stands; natural body kept.
   *
   * W72-A10 (2026-08-22) -- READ OFF gcc-2.8.1's OWN SOURCE (C:/Temp/gcc-2.8.1-src).
   * The certificate is CONFIRMED at source level AND the route is now exact.
   * (a) reload1.c:582  `bcopy (regs_ever_live, regs_explicitly_used, ...)` -- taken
   *     BEFORE pseudo homes are merged, so regs_explicitly_used = the hard regs that
   *     literally appear in the RTL (asm clobbers among them).  order_regs_for_reload
   *     then does, for MIPS (`! SMALL_REGISTER_CLASSES`):
   *         `SET_HARD_REG_BIT (bad_spill_regs, i)` for every regs_explicitly_used[i].
   *     => a "$4" clobber ANYWHERE removes $a0 from the spill pool for the WHOLE
   *     function.  W69's mutual exclusion is a compiler LAW, not an observation.
   * (b) MIPS defines no REG_ALLOC_ORDER, so order_regs_for_reload takes the `#else`
   *     arm and potential_reload_regs is built in THREE runs, not one sorted list:
   *         [1] uses==0 AND call_used, ASCENDING regno
   *         [2] uses==0 AND !call_used, ascending
   *         [3] uses!=0, qsort by increasing uses (tie: regno)
   *     Ours: pseudos occupy $v0,$v1,$a0 => run[1] starts 5,6 => "Spilling reg 5.
   *     Spilling reg 6." (exactly the W62-A12 dump) => operands land $a1,$a2.
   *     Retail's pair is $a2 THEN $a0, i.e. 6 from run[1] and 4 from run[3].  A reg
   *     is in run[3] only if some pseudo is ALLOCATED to it.  => retail HAS a pseudo
   *     in $a0 that is DEAD inside the loop: the loaded bound, which dies at
   *     `addu $a1,$a0,$zero`.  The bound itself lives in $a1.  => THE FIX IS NOT A
   *     CLOBBER AND NOT AN ASM OPERAND: it is to own TWO bound pseudos with a real,
   *     UNCOALESCIBLE copy between them.
   * (c) WHY retail's copy is uncoalescible (local-alloc.c combine_regs, :1866 comment):
   *     "If UREG is a pseudo-register that hasn't already been assigned a quantity
   *      number, it means that it is NOT LOCAL TO THIS BLOCK or dies more than once.
   *      In either event, we can't do anything with it."  The copy's source is set in
   *     the guard's block and used in the next one, so local-alloc must leave it.
   * (d) WHERE retail's second pseudo comes from: jump.c `duplicate_loop_exit_test`
   *     gives the DUPLICATED (pre-loop guard) copy of the exit test a FRESH pseudo for
   *     every register set only inside the exit code
   *     (`reg_map[REGNO (reg)] = gen_reg_rtx (GET_MODE (reg));`) -- and the bound load
   *     IS such a register, because the bound is a MEM read living in the loop
   *     condition.  The in-loop load then becomes a register COPY of the guard's
   *     pseudo, landing after the guard branch = a different block = (c).
   *     !! that function BAILS OUT (`return 0`) if the exit code contains
   *     NOTE_INSN_BLOCK_BEG/END or a CALL, and only handles bottom-test loops.
   * (e) In OUR build only ONE pseudo survives: cse rewrites the in-loop bound read to
   *     the guard's pseudo and the resulting copy is coalesced away.  MEASURED this
   *     wave (real gate runs, all 8 @21/21 unless noted):
   *       hand-rotated guard+do-while, `lim` laundered from `e` .......... 8
   *       the same without the launder .................................. 8
   *       `if (*p != 0)` with NO braces (kills the body's block notes) ... 8
   *       plain `while (p < (int *)gFileMgr.handlearray)` ................ 8
   *       split `e`/`lim` + read-only fence on `e` AFTER the loop ....... 10 @23
   *         -- this one DOES mint retail's shape (`lw $a1,28; addu $a0,$a1`)
   *            but with the two registers SWAPPED and the two loads reordered,
   *            because `e` (fenced, long-lived) loses the allocno race to `lim`.
   *       explicit DOUBLE source read of the bound (guard + do-while cond)  17 @22
   *         -- keeps both loads; loop.c cannot hoist the second because the
   *            volatile trap asm makes the loop `has_volatile`.
   * ROUTE: get loop.c/cse to leave the in-loop bound read as a COPY placed AFTER the
   * guard branch (jump.c's duplicated-test pseudo + a hoist), with the guard's pseudo
   * winning the lower register.  Everything else about this function is retail-exact.
   *
   * 🏆 W74-A8 (2026-08-22/23) -- 8 -> 2 @21/21, PIN-FREE.  THE W72-A10 ROUTE WAS
   * WRONG ABOUT WHICH PASS IS AT FAULT; the RTL dumps settle it.
   * (a) `tools/rtl_dump.py recon/game/common/nfs3.cpp -dj -dl -dg` shows
   *     jump.c's duplicate_loop_exit_test ALREADY FIRES on the plain `for` body
   *     (jump dump: guard pseudos 88/89/90/91 duplicated ahead of NOTE_INSN_LOOP_BEG,
   *     in-loop test keeps 83/84/85/86), and cse+loop DO leave retail's copy:
   *     .lreg insn 72, in the PREHEADER block 1, is literally
   *         (set (reg/s:SI 85) (reg:SI 90))   == retail's `addu a1,a0,zero`
   *     So the two bound pseudos and the uncoalescible copy EXIST in our build too;
   *     "our cse eats it" was false.
   * (b) The copy dies in GLOBAL ALLOC, not in cse.  .greg says:
   *         ;; 3 regs to allocate: 80 90 85
   *         ;; 85 conflicts: 80 85 2 29        <- 90 ABSENT
   *         ;; 90 conflicts: 80 90 2 29        <- 85 ABSENT
   *         ;; Register dispositions: 80 in 3   85 in 4   90 in 4
   *     Both bounds get $a0, so insn 72 becomes `addu a0,a0,zero` and is deleted --
   *     which is exactly why the guard's beqz slot was a `nop`.
   * (c) WHY THEY DO NOT CONFLICT (gcc-2.8.1 global.c:713-724, read not guessed):
   *     the per-insn order is  mark_reg_clobber  ->  REG_DEAD deaths  ->
   *     note_stores(mark_reg_store).  For ANY single_set whose source carries the
   *     REG_DEAD note, the source is removed from allocnos_live BEFORE the dest is
   *     marked, so a copy NEVER makes its two pseudos conflict.  (This also kills
   *     the W69 identity-launder attempts: `asm("":"=r"(x):"0"(x))` is one pseudo,
   *     and even a two-pseudo asm is still a single_set with a dying input.)
   * (d) THE DIAL, therefore, is to keep the GUARD's pseudo live PAST the copy --
   *     i.e. a read-only fence on the guard bound placed AFTER the loop:
   *         g = handlearray; if (p < g) { e = g; do {...} while (p < e); }
   *          *     Zero insns, no hard-register name, no clobber (so the W69 mutual-exclusion
   *     certificate -- "the only $a0 dial also forbids retail's spill" -- is
   *     SIDE-STEPPED, not violated: nothing enters regs_explicitly_used).
   *     RESULT 2 @21/21; insns 0-11 and 13-20 are byte-exact incl. retail's
   *     `addu a1,a0,zero` in the guard's beqz delay slot and `sltu v0,v1,a1`.
   * MEASURED THIS WAVE (all re-gated, 21/21 unless noted):
   *     fence AFTER the loop, inside the guard ............ 2   (== after the if)
   *     fence AFTER the whole if (this body) ............... 2
   *     fence in the PREHEADER (between `e = g;` and the do) 8  -- there `g`
   *        becomes block-local, so local-alloc's combine_regs coalesces the copy
   *        again; the fence MUST sit after the loop.
   *     3rd operand `"r"(g)` on the trap asm instead of the fence ......... 2
   *     bound re-read (`e = handlearray;`) instead of `e = g;` + fence .... 2
   *     fence operands {g,p} 2 / {g,g} 2 / {g,e} 3 @22 / loop-on-g+fence-e 5 @22
   *     bound read BEFORE the walker read (`g` then `p`) + fence .......... 2
   *     plain `for` + named `g` + 3rd trap operand `"r"(g)` ............... 8
   *     no fence at all, any rotation/2nd-read spelling (7 shapes) ........ 8
   * RESIDUAL 2 = `-addu a3,a2,zero` / `+addu a0,a2,zero`: the trap asm's two
   *   `"r"(0)` operands are RELOAD SPILL regs, and reload1.c:3946
   *   order_regs_for_reload builds potential_reload_regs run[1] from hard regs
   *   with ZERO pseudo uses, ascending.  Ours now has pseudos in $v0,$v1,$a0,$a1
   *   -> run[1] = 6,7 -> $a2,$a3.  Retail's pair is $a2,$a0, so in retail
   *   hard_reg_n_uses[4] == 0, i.e. NO pseudo is allocated to $a0 at all and its
   *   `lw a0,0x1C(v0)` is a RELOAD of an UNALLOCATED pseudo that kept its
   *   REG_EQUIV(mem) (22B-8 DEMOTE-OUT-OF-ALLOCATION).  Our guard load cannot keep
   *   REG_EQUIV: -msplit-addresses gives it an address pseudo (81) that carries
   *   REG_DEAD on that very insn, and local-alloc.c validate_equiv_mem refuses any
   *   MEM whose address register dies there (16B).  FALSIFIED attempt at that:
   *   swapping the two field reads so the base dies on the WALKER's load instead
   *   (`g` read first) is exactly neutral (2).  NEXT ANGLE: get the guard bound
   *   demoted out of allocation entirely (a REG_EQUIV-preserving shape, or a
   *   -mno-split-addresses per-fn splice for this TU) so $a0 re-enters the spill
   *   pool; everything else in the function is retail-exact.
   *
   * ===== W75-A11 (2026-08-23): 2 STAYS @21/21.  THE RELOAD MODEL IS NOW
   * VALIDATED BY PREDICTION, AND THE REQUIREMENT IS EXACT.
   * (1) MECHANISM, read off reload1.c (not probed).  order_regs_for_reload
   *     (:3840) builds potential_reload_regs in THREE runs when the target has
   *     no REG_ALLOC_ORDER (MIPS): [1] hard_reg_n_uses==0 AND call_used,
   *     ASCENDING regno; [2] uses==0 AND !call_used; [3] uses!=0, qsort by
   *     INCREASING uses.  fixed regs and every regs_explicitly_used reg get
   *     `uses += large+1` and land in bad_spill_regs (:3888-3903).
   *     allocate_reload_reg (:5083) then walks spill_regs ROUND-ROBIN from the
   *     FUNCTION-GLOBAL cursor last_spill_reg (reset to -1 at :823):
   *       i = (i + 1) % n_spills   -- advanced PER RELOAD, not per insn.
   *     OURS: pseudos sit in $v0,$v1,$a0(G = the guard bound),$a1(L) => run[1]
   *     starts 6,7 => n_spills=2, spill_regs=[$a2,$a3]; cursor -1 => the trap's
   *     operand0 takes index 0 ($a2), operand1 index 1 ($a3).  Exactly ours.
   * (2) PREDICTION TEST (the receipt this wave adds).  Adding `: "$7"` to the
   *     trap asm puts $a3 in bad_spill_regs, so spill_regs must become
   *     [$a2,$t0] and operand1 must become $t0.  MEASURED: FAIL 2 @21/21 with
   *     `-addu t0,a2,zero / +addu a0,a2,zero`.  Predicted == measured, so the
   *     model is an ORACLE for this residual, not a hypothesis.  (Reverted.)
   * (3) THE EXACT REQUIREMENT FOR RETAIL'S `addu a0,a2,zero`.  Retail's pair is
   *     spill_regs[1] THEN spill_regs[0] -- a WRAP -- which forces BOTH:
   *       (a) spill_regs = [$a0,$a2], i.e. hard_reg_n_uses[$a0]==0: NO pseudo
   *           allocated to $a0 anywhere in the function; AND
   *       (b) an EARLIER reload in the function, so the cursor already sits at
   *           index 0 when the trap is reloaded.
   *     ONE fact satisfies both: retail's guard bound G is UNALLOCATED and
   *     carries REG_EQUIV(mem gFileDevice+0x1C), so `lw a0,0x1C(v0)` IS that
   *     earlier reload and `addu a1,a0,zero` is reload INHERITANCE feeding L.
   *     This supersedes the W74 wording ("get $a0 back into the spill pool"):
   *     the two halves are not independent dials, they are one fact.
   * (4) WHY NO DEVICE BUYS IT (certificate sharpened, all source-cited).  A
   *     clobber only ever REMOVES a register from the pool (2), so it cannot
   *     make $a0 free.  Demotion via REG_LIVE_LENGTH is unreachable from C:
   *     flow.c:1179/1200 set -1 only for setjmp-live pseudos and global.c:558
   *     honours -2 only for parameters; with 3-4 allocnos and ~20 free regs
   *     global.c:561 find_reg always succeeds.  local-alloc.c's
   *     reg_equiv_replace escape (the `REG_N_REFS==2 && REG_BASIC_BLOCK<0`
   *     arm of update_equiv_regs) cannot fire either: our G has THREE refs
   *     (set + guard test + the preheader copy) and its set/use share a block.
   * (5) ALSO FALSIFIED THIS WAVE (each a real gate run, all 2 @21/21 unless
   *     noted).  PER-FN -mno-split-addresses -- the very angle W74 named as the
   *     next one -- 6 @21/21: it folds +0x18/+0x1C into the address so the two
   *     field loads become 0(v0)/4(v0), and the a3-vs-a0 pick is UNCHANGED, so
   *     it does not demote G.  PER-FN CC1 FLAG SWEEP (a NEW axis; instrument =
   *     scratchpad/w75/vprobe_flag.py, a generic per-FUNCTION flag splice built
   *     on build.py's _apply_fn_splice, W75_FN_FLAG='{"<tu>":{"<flag>":["fn"]}}'):
   *     -fno-expensive-optimizations, -fno-caller-saves, -fno-rerun-cse-after-loop,
   *     -fno-cse-follow-jumps, -fno-cse-skip-blocks, -fno-thread-jumps,
   *     -fno-force-mem, -fno-peephole, -fno-function-cse, -fno-inline,
   *     -fno-defer-pop, -fno-strength-reduce, -fno-schedule-insns,
   *     -fno-schedule-insns2, -G0, -G8 = ALL exactly 2 (inert);
   *     -fno-omit-frame-pointer 9 @26.  The FLAG AXIS IS CLOSED for this fn.
   * NEXT NAMED ANGLE (W75): a source shape in which the guard bound is
   * never a pseudo -- the guard test carrying the MEM directly, with the loop
   * bound a separate pseudo -- so G's references collapse to one reload plus
   * inheritance.
   *
   * ===== W76-A11 (2026-08-23): SEALED PASS 21/21 -- PIN-SEALED (last-resort
   * register pins, per the W76 policy order (a)-(e); wordcmp REAL=0, slotcheck 0).
   * (1) THE W75 NAMED ANGLE WAS WALKED AND FALSIFIED FIRST (real gate runs):
   *     guard carrying the MEM directly, bound read first ........ 8 @21/21
   *     the same with a read-only fence on the bound ............. 8 @21/21
   *     anonymous guard temp + separate re-read + fence on e ..... 3 @22/21
   *     cse folds the second read of the SAME MEM into the first pseudo in
   *     every ordering, so the guard bound always keeps >=2 same-block refs
   *     and stays allocated; update_equiv_regs' replace arm (REG_N_REFS==2 &&
   *     REG_BASIC_BLOCK<0, local-alloc.c:1169) is unreachable for a guard
   *     compare by construction (set and use share the block).  With that the
   *     W75 certificate is COMPLETE: no C shape and no zero-insn device can
   *     make hard_reg_n_uses[$a0]==0 while keeping retail's bytes => pin lane.
   * (2) THE CONSTRUCTION (all three registers taken by construction, no reload
   *     left in the function, so the whole spill-pool question dissolves):
   *       register int *g asm("$4") = handlearray  -> lw a0,0x1C(v0) (G home)
   *       e = g                                    -> addu a1,a0,zero (L=$5,
   *         kept real because z1's $4 is SCOPE-live through the loop: the arm
   *         pin, not the W74 fence, now supplies the G/L conflict -- the fence
   *         was REMOVED after a 23B-3 device-removal retest, still PASS)
   *       arm: register int z0 asm("$6"); register int z1 asm("$4");
   *            z0 = 0;                             -> addu a2,zero,zero (slot)
   *            asm("" : "=r"(z0) : "0"(z0));       -> zero-insn opacity launder
   *            z1 = z0;                            -> addu a0,a2,zero
   *            asm volatile("break 0x666
	nop" : : "r"(z0), "r"(z1));
   * (3) WHY EACH PIECE IS LOAD-BEARING (each removal measured):
   *     z-pins with plain inits, g unpinned + fence ....... 8 @21/21 (the
   *        fence extends pseudo-G through the arm -> G conflicts the arm pins
   *        -> G displaced to $a1, L to $a3)
   *     g pinned, z inits `= 0` (both orders) ............. 5 @22/21
   *     g pinned, separate stmts z0=0; z1=0 ............... 5 @22/21
   *     g pinned, z1 = z0 WITHOUT the launder ............. 5 @22/21
   *        mechanism (fresh -dS dump): $4 is SCOPE-live through g's block, so
   *        (set $4 0) carries the longer chain and sched1 orders it BEFORE
   *        (set $6 0) regardless of statement order; cse const-props a plain
   *        z1=z0 back to (set $4 0).  The launder makes z0's value opaque, so
   *        z1=z0 keeps a true dependence and the order is forced: z0's set
   *        lands in the beqz slot (gcc dbr fills it itself) and z1's set IS
   *        retail's addu a0,a2,zero.
   *
   * ===== W85-S3 (2026-09-02) -- DEVICE COUNT 4 -> 2, STILL PASS 21/21.
   * The W76 construction above is SUPERSEDED: two of its four devices are inert
   * once the OTHER two are present, which the W76 removal matrix could not see
   * because it only ever removed ONE piece from the full four-device form.
   * Removed (each re-gated on the real gate, `verify_asm ... 21/21`):
   *     (a) the `register int *g asm("$4")` PIN on the guard bound ..... PASS
   *         => the G/L conflict comes ENTIRELY from z1's `$4` being scope-live
   *         through the loop; pinning G to the same `$4` was redundant.
   *     (b) the `asm("" : "=r"(z0) : "0"(z0))` opacity LAUNDER, together with
   *         the `z1 = z0` copy spelling ................................ PASS
   *         => with G unpinned, plain decl-inits `z0 = 0` / `z1 = 0` already
   *         schedule as retail's `addu a2,zero,zero` (beqz slot) + `addu
   *         a0,a2,zero`; the const-prop the launder existed to defeat only
   *         happened while `$4` was ALSO g's home.
   * LANDED FORM: `register int z0 asm("$6") = 0; register int z1 asm("$4") = 0;`
   * plus the `break 0x666` transcription.  Two pins, no launder, no fence.
   * FULL W85 MEASUREMENT MATRIX (every row a real gate run on this TU):
   *     landed 2-pin decl-init form (this body) ............... PASS 21/21
   *     2 pins, separate `z0=0; z1=0;` statements ............. PASS 21/21
   *     2 pins, decl order z1-then-z0 ......................... PASS 21/21
   *     2 pins + launder + `z1 = z0` (the W76 form, g unpinned)  PASS 21/21
   *     z1 pin only, plain zeros .............................. 4 @21/21
   *        -- correct REGISTERS ($a2 then $a0); the only diff is
   *           `addu a0,zero,zero` vs retail's copy `addu a0,a2,zero`
   *     z1 pin only + launder + `z1 = z0` ..................... 3 @20/21
   *     z0 pin only, plain zeros .............................. 5 @20/21
   *     z0 pin only + launder + `z1 = z0` ..................... 5 @20/21
   *     2 pins, statement order `z1=0; z0=0;` ................. 4 @21/21
   *     NO pins, `int z0=0; int z1=0;` ........................ 4 @21/21
   *        -- cse merges the two zeros into ONE pseudo; the second slot nops
   *     NO device at all, natural `for` + `"r"(0),"r"(0)` ..... 8 @21/21
   *     NO device, hand-rotated guard+do/while ................ 8 @21/21
   *     W74 read-only fence `asm("" : : "r"(g))` after the loop  2 @21/21
   * The last three rows re-confirm the W74/W75/W76 pin-free floor from scratch
   * (2 diffs, and only with a fence that is itself a banned device), so the two
   * remaining `$N` pins are KEPT under the W85 iron rule.  The W75(4)
   * certificate was independently re-derived this wave from
   * C:/Temp/gcc-2.8.1-src/extracted: global.c:389 only skips allocation for
   * REG_LIVE_LENGTH == -1 (flow.c:1179/1200, setjmp-live only) or == -2
   * (parameters, global.c:558), and local-alloc.c:1170's reg_equiv_replace arm
   * needs REG_N_REFS==2 && REG_BASIC_BLOCK<0 -- none reachable from this C.
   * DO NOT re-add the g pin or the launder, and do not touch the two z pins --
   * every neighbouring cell is measured above.  PsyQ notation: asm text none
   * needed (empty template), clobbers none, reg names "$N" accepted by this
   * CC1PLPSX. */
  int *p;
  /* SYM-CODEGEN-CARRIER: e -- the retail SYM retains only `p`, but this
   * separate loop-bound pseudo is required by the W74-W76 GCC 2.8.1
   * global/reload receipt above; folding it into `g` changes the exact
   * guard-copy and trap-operand allocation. */
  int *e;

  p = (int *)gFileMgr.oparray;
  {
  int *g = (int *)gFileMgr.handlearray;
  if (p < g) {
    e = g;
    do {
      if (*p != 0) {
#if defined(__mips__)
        /* MATCH: trap() is INLINE in retail -- `break 0x666` (objdump: break 1,614) plus two
         * zeroed register args; no jal, so the function stays a leaf (no frame, no $ra save). */
        {
          register int z0 __asm__("$6") = 0;
          register int z1 __asm__("$4") = 0;
          __asm__ __volatile__("break 0x666
	nop" : : "r"(z0), "r"(z1));
        }
#else
        trap(0x666);   /* host build: no MIPS break */
#endif
      }
      p = p + 1;
    } while (p < e);
  }
  }
  return;
}



/* ---- main  [NFS3.CPP:703-935] SLD-VERIFIED ---- */
/* MATCH: PASS 237/237.  CC1PL inserts `__main` automatically for C++ main, so
   the explicit reconstructed call was a duplicate (19 -> 10 and it also freed
   the retail startup scheduling).  SYM lists only setup and oldReplayMode as
   register locals: spelling the win/lose choice as the two direct PlaySong
   call arms lets cross-jump merge the call while selecting the string in $a0,
   removing the decompiler-invented pattern local (10 -> PASS).  The opponent
   count and final menu selector are likewise direct expressions; the former
   iVar2/uVar1 aliases were not retained by SYM and fold away at exact PASS. */

int main(void)

{
  int *setup;
  short oldReplayMode;
  
  oldReplayMode = 0;
  Platform_DebuggerPollHost();
  Nfs2_SystemNLibStartUp();
  Audio_InitDriver(0,0);
  Audio_DeInitDriver();
  SetVideoMode(0);
  frontEnd.language = -1;
  LoadFrontendOverlay();
  ComingIntoTheFrontEndTheVeryFirstTime = 1;
  (&carManager)->Initialize();
  (&carManager)->LoadDescription();
  FECheat_ActivateBonus(cheat_Roadster);
  (&carManager)->SetClassViewable((tCarClassType)0, 1);
  (&carManager)->SetClassViewable((tCarClassType)1, 1);
  (&carManager)->SetClassViewable((tCarClassType)2, 1);
  (&carManager)->SetClassViewable((tCarClassType)3, 1);
  (&carManager)->SetClassViewable((tCarClassType)4, 1);
  (&carManager)->SetClassViewable((tCarClassType)5, 1);
  (&tournamentManager)->Initialize();
  (&missionManager)->Initialize();
  (&trackManager)->Initialize();
  (&tournamentManager)->LoadDescription();
  (&trackManager)->LoadDescription();
  Front_InitGraphics();
  Front_Menu(kFront_InitialLoad);
  do {
    NFS3_CheckForFileOperations();
    setup = (int *)MinFront_ParseOptions();
    if (gUseFrontend != 0) {
      setup = (int *)Front_BuildStream(setup);
    }
    (&trackManager)->ReleaseDescription();
    (&missionManager)->ReleaseDescription();
    (&tournamentManager)->ReleaseDescription();
    (&carManager)->ReleaseDescription();
    initlinkmode(0,1,1);
    NFS3_CheckForFileOperations();
    Nfs2_GameModuleStartUp(setup);
    NFS3_CheckForFileOperations();
    while (simVar.restartGame != 0) {
      simVar.restartGame = 0;
      Nfs2_ResetGame();
      Sim_MainGameLoop();
      if ((GameSetup_gData.replayMode < 2) || (GameSetup_gData.instantReplay != 0)) {
        if ((simVar.restartGame == 0) || (GameSetup_gData.instantReplay != 0)) {
          GameSetup_gData.replayMode = 2;
          /* MATCH: retail lays the instantReplay!=0 arm as the FALL-THROUGH (its
           * statsScreen=0 store rides the `j` delay slot) and branches to the ==0 body. */
          if (GameSetup_gData.instantReplay != 0) {
            Replay_ReplayInterface.statsScreen = 0;
          }
          else {
            Replay_ReplayInterface.statsScreen = 1;
            if ((1 < Stats_GetNumOpponents()) &&
               (((GameSetup_gData.raceType != RaceType_HotPursuit && (GameSetup_gData.raceType != RaceType_Id5)) ||
                (((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) == 0 &&
                 ((Cars_gNumHumanRaceCars != 2 ||
                  ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) == 0)))))))) {
              if ((Cars_gHumanRaceCarList[0]->stats).finalPosition == 1) {
                AudioMus_PlaySong("win*");
              }
              else {
                AudioMus_PlaySong("lose*");
              }
            }
          }
          Replay_ReplayMode = 2;
          simVar.restartGame = 1;
          GameSetup_gData.instantReplay = 0;
        }
      }
      else {
        Replay_ReplayInterface.statsScreen = 0;
      }
    }
    Nfs2_CleanUpGameModule();
    NFS4_LoadingIcon();
    LoadOverlay();
    NFS3_CheckForFileOperations();
    Front_InitGraphicsAndDisplayLoading();
    GameSetup_gData.replayMode = (int)oldReplayMode;
    Front_GetInGameVars();
    (&carManager)->LoadDescription();
    (&tournamentManager)->LoadDescription();
    (&trackManager)->LoadDescription();
    Front_Menu((quitType == 1) ? 2 : 1);
    oldReplayMode = (short)GameSetup_gData.replayMode;
    NFS3_CheckForFileOperations();
  } while( true );
}



/* end of nfs3.cpp */

/* _6Speech_fgUndefined and _6Speech_fgSpeech are both owned by Speech.  This TU
   addresses them absolutely, so their declarations remain pure externs. */
