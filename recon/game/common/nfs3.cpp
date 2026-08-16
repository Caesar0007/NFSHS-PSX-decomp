/* game/common/nfs3.cpp -- RECONSTRUCTED (game boot / module start-up + main() entry; C TU, 11 fns) */
#include "../../nfs4_types.h"
#include "nfs3_externs.h"
#include "new.h"
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
int          MEMCARDFRONTENDISINITTED = 0;   /* @0x8013d284 */
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


void NFS4_LoadPerps(void)

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
  void *pThis;
  
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
    pThis = __builtin_new(0x3a4);
    _6Speech_fgSpeech = (int)new ((Speech *)pThis) Speech;
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
    delete (Speech *)_6Speech_fgSpeech;
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
  int iVar1;
  
  handle = asyncloadfileat("front.bin",bigBuf);
  while (iVar1 = getasyncreadstatus(handle), iVar1 == 0) {
    systemtask(0);
  }
  return;
}



/* ---- LoadOverlay  [NFS3.CPP:589-596] SLD-VERIFIED ---- */


void LoadOverlay(void)

{
  int handle;
  int iVar1;
  char fname [60];
  
  LoadFrontendOverlay();
  sprintf(fname,"%sDCT.BIN",Paths_Paths[0x20]);
  handle = asyncloadfileat(fname,(int)&CF_DVLC);
  while (iVar1 = getasyncreadstatus(handle), iVar1 == 0) {
    systemtask(0);
  }
  return;
}



/* ---- NFS4_LoadingIcon  [NFS3.CPP:626-669] SLD-VERIFIED ---- */


void NFS4_LoadingIcon(void)

{
  void *ldfile;
  void *shp;
  int lang;
  char fname [80];
  RECT r;

  sprintf(fname,"%sldic.psh",Paths_Paths[0x25]);
  ldfile = loadfileadr(fname,0);
  lang = (int)(u_char)frontEnd.language;
  if (5 < lang) {
    lang = 0;
  }
  shp = shapepointer(ldfile,lang);
  r.w = 0x400;
  r.x = 0;
  r.y = 0;
  r.h = 0x200;
  ClearImage(&r,'\0','\0','\0');
  DrawSync(0);
  initlinkmode(0,100,0);   /* oracle 0x94650: a2=0 (dropped 3rd arg) */
  Draw_DirectSetEnvironment(0,0,0x200,0xf0,1,1,1,0,0,0);
  settrans(0);
  movfxya(shp,0x1e2 - *(short *)((int)shp + 4),0xd2);
  DrawSync(0);
  purgememadr(ldfile);
  initlinkmode(0,1,1);   /* oracle 0x946c0: a2=1 (dropped 3rd arg) */
  return;
}



/* ---- NFS3_CheckForFileOperations  [NFS3.CPP:686-694] SLD-VERIFIED ---- */


void NFS3_CheckForFileOperations(void)

{
  /* MATCH: retail walks the eaclib FileMgr's op-slot array (+0x18) up to the handle array
   * (+0x1C) through ONE %hi/%lo(gFileDevice) base -- a base-anchor pointer local, not two
   * separate small globals (the invented gFileMem/gFileHandleTable were gp-rel scalars).
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
   *   $a0 (retail's own reason), or a reload-side spill-order dial. */
  FileMgr *mgr = &gFileMgr;
  int *piVar1;

  for (piVar1 = (int *)mgr->oparray; piVar1 < (int *)mgr->handlearray; piVar1 = piVar1 + 1) {
    if (*piVar1 != 0) {
#if defined(__mips__)
      /* MATCH: trap() is INLINE in retail -- `break 0x666` (objdump: break 1,614) plus two
       * zeroed register args; no jal, so the function stays a leaf (no frame, no $ra save). */
      __asm__ __volatile__("break 0x666
	nop" : : "r"(0), "r"(0));
#else
      trap(0x666);   /* host build: no MIPS break */
#endif
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
   removing the decompiler-invented pattern local (10 -> PASS). */

int main(void)

{
  u_int uVar1;
  int *setup;
  int iVar2;
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
  Front_Menu(0);
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
            iVar2 = Stats_GetNumOpponents();
            if ((1 < iVar2) &&
               (((GameSetup_gData.raceType != RaceType_HotPursuit && (GameSetup_gData.raceType != Id5)) ||
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
    uVar1 = 1;
    if (quitType == 1) {
      uVar1 = 2;
    }
    Front_Menu(uVar1);
    oldReplayMode = (short)GameSetup_gData.replayMode;
    NFS3_CheckForFileOperations();
  } while( true );
}



/* end of nfs3.cpp */

/* _6Speech_fgUndefined and _6Speech_fgSpeech are both owned by Speech.  This TU
   addresses them absolutely, so their declarations remain pure externs. */
