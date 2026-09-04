/* game/psx/sim.cpp -- RECONSTRUCTED (NFS4 PSX sim engine core / main loop; C++ TU)
 *   8 fns: Sim_StartUp/Restart/CleanUp/FadeInSFX/ProcessSimSchedules/ProcessPause/CheckForPause/MainGameLoop.
 *   GTE-free. Full SYM-locals applied.
 */
#include "sim_types.h"
#include "sim_externs.h"

/* sim.obj-owned initialized/aggregate data in retail address order.
 * SYM places this exact 68-byte run at 0x8011E09C..0x8011E0E0. */
int counter[4] = { 320, 384, 448, 512 };
Sim_tSimGlobalVar simGlobal;
Sim_tSimSystemVar simVar;

/* gp-rel owning-TU defs: these small (<=G4) globals are extern-declared
 * but OWNED here; tentative defs -> cc1 `.comm` -> stock maspsx gp-rels them
 * (matches the oracle's %gp_rel). section 3.12 #6. (auto: gen_gprel_defs.py) */
int InBetween = 0;   /* @0x8013d40c  W67-A4: explicit =0 -- retail emits this cell
    BEFORE the schedule-name literal pool below, so it cannot have been tentative
    (16E =0 discriminator).  DO NOT strip the =0. */

/* W67-A4: retail's .sdata run 0x8013d410..0x8013d428 holds the Sched_CreateNewSchedule
   name literals -- a -G8 build keeps <=8-byte literals in .sdata (18C), but whole-TU
   -G8 REGRESSES this TU (Sim_MainGameLoop 12 / Sim_ProcessSimSchedules 13 diffs,
   measured w67a4 -- the audiocmn class), so the literals are materialized as NAMED
   .sdata arrays instead (the audiocmn/w66a6 section-attribute device; codegen-neutral:
   >G4 so the address form stays absolute, and the gate is reloc-name lenient). */
/* SYM-GLOBAL-CARRIER: D_8013D410
   SYM-GLOBAL-CARRIER: D_8013D418
   SYM-GLOBAL-CARRIER: D_8013D420
   The retail string bytes, addresses, and three schedule-constructor calls are
   exact; SYM does not retain identifiers for these TU-local literals. */
static char D_8013D410[] __attribute__((section(".sdata"), aligned(4))) = "Sc32-1";
static char D_8013D418[] __attribute__((section(".sdata"), aligned(4))) = "Sc32-2";
static char D_8013D420[] __attribute__((section(".sdata"), aligned(4))) = "Sc64";

/* retail emits the next three AFTER the literal pool -> they stay tentative;
   first-declaration order unPauseDelay, skipRender, quitType is load-bearing (17B).
   DO NOT RE-SORT. */
int quitType;
int skipRender;
int unPauseDelay;

/* ---- intra-TU forward declarations (auto-emitted, signature-exact) ---- */
void Sim_StartUp(void);
void Sim_Restart(void);
void Sim_CleanUp(void);
void Sim_FadeInSFX(void);
void Sim_ProcessSimSchedules(void);
static void Sim_ProcessPause(void);
void Sim_CheckForPause(int checkInput);
void Sim_MainGameLoop(void);


/* ---- Sim_StartUp__Fv  [SIM.CPP:186-227] SLD-VERIFIED ---- */
void Sim_StartUp(void)

{
  simVar.restartGame = 1;
  simVar.endSimGame = 0;
  simVar.pauseSim = 0;
  simVar.quickPauseSim = 0;
  simVar.goalClockTicks = 0;
  simVar.currentClockTicks = 0;
  simVar.keyRelease = 0;
  simGlobal.gameStarted = 0;
  simGlobal.gameTicks = 0;
  simGlobal.schedule32Hz = Sched_CreateNewSchedule(D_8013D410,0x46);   /* "Sc32-1" */
  simGlobal.schedule32Hz2 = Sched_CreateNewSchedule(D_8013D418,0xb);   /* "Sc32-2" */
  simGlobal.schedule64Hz = Sched_CreateNewSchedule(D_8013D420,0x1a);   /* "Sc64" */
  FastRandom_StartUp(GameSetup_gData.randSeed);
  AICop_StartUp();
  AIInit_StartUp1();
  R3DCar_StartUp();
  CarIO_StartUp();
  Cars_StartUp();
  R3DCar_PostStartUp();
  AIHigh_StartUp();
  Loading_UpdateLoadingScreen(8);
  Loading_UpdateLoadingScreen(9);
  AIInit_StartUp2();
  Loading_UpdateLoadingScreen(10);
  AudioCmn_Init();
  Sched_AddFunction(simGlobal.schedule64Hz,(void (*)(void *))Camera_Update,(void *)0x0,100);
  return;
}

/* ---- Sim_Restart__Fv  [SIM.CPP:231-260] SLD-VERIFIED ---- */
void Sim_Restart(void)

{
  quitType = 1;
  simVar.endSimGame = 0;
  simVar.pauseSim = 0;
  simVar.quickPauseSim = 0;
  simVar.goalClockTicks = 0;
  simVar.currentClockTicks = 0;
  simGlobal.gameStarted = 0;
  countdown = '\0';
  simGlobal.gameTicks = 0;
  GameSetup_gData.perpArrests = 0;
  FastRandom_StartUp(GameSetup_gData.randSeed);
  AICop_Restart();
  AIInit_Reset1();
  R3DCar_Restart();
  AIHigh_Restart1();
  Cars_Restart();
  AIHigh_Restart2();
  AIInit_Reset2();
  Hud_Reset();
  Render_RestartTrackRender();
  SimQueue_Reset();
  simGlobal.time32Hz = Input_gTime;
  return;
}

/* ---- Sim_CleanUp__Fv  [SIM.CPP:264-286] SLD-VERIFIED ---- */
void Sim_CleanUp(void)

{
  Force_Disable();
  SimQueue_CleanUp();
  Sched_DeleteFunction(simGlobal.schedule64Hz,(void (*)(void *))Camera_Update,(void *)0x0);
  AIInit_CleanUp2();
  AIHigh_CleanUp();
  Cars_CleanUp();
  R3DCar_CleanUp();
  CarIO_CleanUp();
  AIInit_CleanUp1();
  AICop_CleanUp();
  FastRandom_CleanUp();
  Sched_CleanUpSchedule(simGlobal.schedule32Hz);
  Sched_CleanUpSchedule(simGlobal.schedule32Hz2);
  Sched_CleanUpSchedule(simGlobal.schedule64Hz);
  return;
}

/* ---- Sim_FadeInSFX__Fv  [SIM.CPP:290-301] SLD-VERIFIED ---- */
void Sim_FadeInSFX(void)

{
  if (simGlobal.gameTicks == 0) {
    GameSetup_gData.userSetting.sfxLevel = gMasterSFXLevel;
    gMasterSFXLevel = 0;
    return;
  }
  if (simGlobal.gameTicks - 0x11U < 0x40) {
    if (Replay_ReplayInterface.statsScreen != 0) {
      gMasterSFXLevel =
          (GameSetup_gData.userSetting.sfxLevel >> 2) *
          (simGlobal.gameTicks + -0x10) >> 6;
    }
    else {
      gMasterSFXLevel =
          GameSetup_gData.userSetting.sfxLevel *
          (simGlobal.gameTicks + -0x10) >> 6;
    }
  }
  return;
}

/* ---- Sim_ProcessSimSchedules__Fv  [SIM.CPP:312-531] SLD-VERIFIED ---- */
/* PASS (201/201 insns). The `firstSfx` loop invariant must be declared inside
 * the `i < 4` block: that SLD-confirmed scope keeps its `$s1` initialization
 * after the branch and lets gcc fill the branch delay slot with the speculative
 * `%hi(simGlobal)` load used by the no-loop path. */
void Sim_ProcessSimSchedules(void)

{
  int i;

  if (!(((GameSetup_gData.raceType == RaceType_HotPursuit) || (GameSetup_gData.raceType == RaceType_Id5)) &&
       (((Cars_gHumanRaceCarList[0]->carFlags & 0x200U) != 0 ||
        ((Cars_gNumHumanRaceCars == 2 &&
          ((Cars_gHumanRaceCarList[1]->carFlags & 0x200U) != 0))))))) {
    if (simGlobal.gameStarted == 0) {
      i = (u_char)countdown - 1;
      if (i >= 0) goto countdown_index_ready;
      i = 0;
countdown_index_ready:
      {
        if (i < 4) {
          /* SYM-CODEGEN-CARRIER: firstSfx -- removing the block-local 0x23
             shrinks retail's 201 instructions to 197 and produces eight word
             diffs, changing both the pre-loop branch layout and invariant
             constant materialization.  Its SLD-confirmed scope is documented
             in the function receipt above. */
          int firstSfx = 0x23;

          do {
            AudioCmn_GetAsyncSfx(2,i + firstSfx,false);
            i = i + 1;
          } while (i < 4);
        }
      }
      if (simGlobal.gameTicks >= counter[(u_char)countdown]) {
        if (0x1ff < simGlobal.gameTicks) {
          simGlobal.gameStarted = 1;
        }
        AudioCmn_PlaySound(-4,(u_char)countdown + 0x23,0,0x7f,0x40);
        countdown = countdown + '\x01';
      }
      Sim_FadeInSFX();
    }
  }
  else {
    Sim_FadeInSFX();
    simGlobal.gameStarted = 1;
  }
  if ((simGlobal.gameTicks & 1U) == 0) {
    systemtask(0);
    gWSavePtr = (u_long)SetSp(&gScratchLastWord);
    stackSpeedUpEnbabledFlag = 1;
    Stats_ClearPosition();
    Collide_ClearCollisionRegistry();
    Sched_Execute(simGlobal.schedule32Hz);
    Cars_ManageBureaucracy();
    gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
    stackSpeedUpEnbabledFlag = 0;
    Cars_CheckForAccidentScenes();
  }
  gWSavePtr = (u_long)SetSp(&gScratchLastWord);
  stackSpeedUpEnbabledFlag = 1;
  Sched_Execute(simGlobal.schedule64Hz);
  gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
  stackSpeedUpEnbabledFlag = 0;
  if ((simGlobal.gameTicks & 1U) != 0) {
    gWSavePtr = (u_long)SetSp(&gScratchLastWord);
    stackSpeedUpEnbabledFlag = 1;
    AIHigh_Execute();
    gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
    stackSpeedUpEnbabledFlag = 0;
    gWSavePtr = (u_long)SetSp(&gScratchLastWord);
    stackSpeedUpEnbabledFlag = 1;
    Sched_Execute(simGlobal.schedule32Hz2);
    Stats_TrackEndGame();
    Stats_DoPlayerGlue();
    gWSavePtr = (u_long)SetSp((void *)gWSavePtr);
    stackSpeedUpEnbabledFlag = 0;
    AudioClc_SoundCars();
  }
  simGlobal.gameTicks = simGlobal.gameTicks + 1;
  return;
}

/* ---- Sim_ProcessPause__Fv  [SIM.CPP:467-531] SLD-VERIFIED ---- */
static void Sim_ProcessPause(void)

{
  int r;
  
  if (unPauseDelay <= clock_realTime.time32Hz) {
    r = MPause_Logic();
    if (r == 1) {
      if (simVar.quickPauseSim == 0) {
        AudioCmn_UnPause();
      }
      gSimQueue_BlockSelf = 0;
      simVar.pauseSim = 0;
      Force_UnPause();
    }
    else if (r == 2) {
      AudioCmn_UnPauseAndRestart();
      simVar.pauseSim = 1;
      simVar.endSimGame = 1;
      simVar.restartGame = 1;
    }
    else {
      if (1 < r - 4U) {
        return;
      }
      if (r == 5) {
        GameSetup_gData.pinkSlipsForfeit = (int)(Device_gPausePortIndex != '\0');
      }
      Hud_BTC_QuitOut();
      AudioCmn_UnPauseAndRestart();
      simVar.pauseSim = 0;
      simVar.endSimGame = 1;
      simVar.restartGame = 0;
      Stats_ExtrapolateOpponentTimes(1);
      quitType = 1;
    }
    MPause_EndPauseMenu();
  }
  return;
}

/* ---- Sim_CheckForPause__Fi  [SIM.CPP:536-551] SLD-VERIFIED ---- */
void Sim_CheckForPause(int checkInput)

{
  if ((((Replay_ReplayMode < 2) && (simVar.restartGame == 0)) && (0x20 < simGlobal.gameTicks)) &&
     (((checkInput != 0 && (Input_Interface(6,1) != 0)) ||
      (Device_gForcePause != 0)))) {
    unPauseDelay = clock_realTime.time32Hz + 4;
    AudioCmn_Pause();
    gSimQueue_BlockSelf = 1;
    simVar.pauseSim = 1;
    Force_Pause();
  }
  return;
}

/* ---- Sim_MainGameLoop__Fv  [SIM.CPP:554-826] SLD-VERIFIED ---- */
/* MATCH (W56-A15, 45->31): retail stores the NAMED-ONE constant for InBetween
 * (InBetween==0 here so `InBetween = one` == `InBetween++`), sharing the `1`
 * with the `speed == one` compare. `int one;` assigned `one = 1;` at the START
 * of the else{} block (its materialization position = oracle's `li s0,1`) is the
 * dial (function-scope `int one = 1;` hoists to prologue -> +2 regress).
 * W59-A14: 11 -> 6 diffs. CLASS (2) IS SOLVED -- three cooperating edits, each one alone
 * regressing, all three together landing (see the input-loop block below):
 *   (2a) the loop-entry guard must NOT read GameSetup through `gameSetup`; retail reads it
 *        through the ALREADY-LIVE `replaySetup` pointer (`replaySetup->commMode`), so no new
 *        address is materialized before the guard;
 *   (2b) `gameSetup = (char *)&GameSetup_gData;` then moves BELOW the guard, which lets reorg
 *        put its `lui %hi` in the `bnez` delay slot exactly like retail;
 *   (2c) that move alone flips the whole gameSetup web s2<->s3 (measured 33). A 1-operand
 *        READ-ONLY fence on gameSetup is the priced cure: allocsim MATCH 22/23 says
 *        p195(gameSetup) refs 6 -> 7 raises pri 0.1578 -> 0.1842 past p118 (0.1611) and swaps
 *        the pair back to retail's {gameSetup=$s2, call-result=$s3}.
 *   Falsified on the way (do NOT retry): reading the guard as `GameSetup_gData.commMode`
 *   (fused %lo form, 38 -- rotates the whole s4..fp band) or as `*(int *)((char *)&G + 0xc)` /
 *   `((int *)&G)[3]` (11 -- gcc CSEs `&G+12` and derives gameSetup as `addiu s2,v1,-12`,
 *   a 3-insn 05F base anchor); an identity fence instead of the read-only fence (same 11).
 * RESIDUAL 6 = CLASS (1) ONLY, ours 319 vs oracle 321:
 *      the oracle splits the two Sim_ProcessSimSchedules() calls across the else{} block
 *      (jal#1; j .Lshared; [else: InBetween=one; Camera_Update; j out]; .Lshared: jal#2) --
 *      our cross_jump keeps the PAIR's copy (fall-through) and deletes the bigcond arm's, so
 *      we save the `j`+`nop`. Retail kept the BIGCOND arm's copy, i.e. in retail's emission
 *      that arm was laid out LAST. Measured this wave, all worse: De-Morgan `!(...)` + arm
 *      swap (32, layout unchanged, s4<->s5 rotation); goto-to-shared-tail with the shared
 *      call after the if/else (38/317) and its flat variant (25/318 -- the `goto` lets gcc
 *      thread the ELSE into the fall-through so cse merges the `speed` load into the ||
 *      chain, `li v0,3; beq a0,v0` instead of retail's fresh `lw v1,4(s4)`).
 *      Named angle: this is a cross_jump SURVIVOR-CHOICE, not a source expression -- next
 *      lever is a block-order device that keeps the || chain's ELSE a branch target while
 *      emitting the bigcond arm last.
 * W77 source-only closure (2026-08-24): PASS 321/321.  The SLD proves source
 * statement order B (lines 764-765), C (769-770), A (775).  An explicit goto to
 * the late A block plus a B-first switch reproduces that B/C/A layout.  The
 * switch discriminator is a measured volatile-on-the-test read: it prevents
 * reuse of the earlier speed value, restoring retail's fresh `lw`, its two load-
 * delay nops, and the s4/s5 base lifetimes.  The nonvolatile form is 32@319; the
 * former A/B/C structured source is 6@319. */
void Sim_MainGameLoop(void)

{
  int lastRealTick;
  int lastGoalTick;
  /* SYM-CODEGEN-CARRIER: one
     Retail debug data retains no name for this shared constant pseudo.  The
     measured block-local assignment below places `li s0,1` exactly; a
     function-scope initialization moves it to the prologue and regresses by
     two diffs. */
  int one;
  /* SYM-CODEGEN-CARRIER: replaySetup
     This anonymous GCC CSE address occupies retail $s5.  Removing it makes
     the function four instructions short and produces 45 diffs; the adjacent
     W57-A12 receipt documents the allocator alternatives. */
  GameSetup_tData *replaySetup;

  quitType = 1;
  lastRealTick = clock_realTime.time64Hz + 10000;
  lastGoalTick = 0;
  simGlobal.time32Hz = Input_gTime;
  do {
    if (simVar.endSimGame != 0) goto SimMainLoop_endGame;
    systemtask(0);
    {
      int realTick;
      int diffReal;
      int diffGoal;

      realTick = clock_realTime.time64Hz;
      simVar.goalClockTicks = gSimQueue_Ticker * 2;
      diffReal = realTick - lastRealTick;
      diffGoal = simVar.goalClockTicks - lastGoalTick;
      if (diffReal > diffGoal) {
        simVar.goalClockTicks++;
      }
      lastRealTick = realTick;
      lastGoalTick = simVar.goalClockTicks;
    }
    if (0x10 < Input_gTime - simGlobal.time32Hz) {
      simGlobal.time32Hz = Input_gTime;
    }
    replaySetup = &GameSetup_gData;
    /* MATCH (W57-A12, 31->11): a 1-operand READ-ONLY fence on replaySetup, placed at its
       narrowest scope (immediately after the assignment, 06B). replaySetup is NOT in the SYM
       8c list -- only lastRealTick (REG $0x16=$s6) and lastGoalTick (REG $0x17=$s7) are -- yet
       the oracle DOES park &GameSetup_gData in a callee-saved reg ($s5), i.e. it is a gcc CSE
       temp, not a source local. Without the fence our band came out one slot LOW
       (lastRealTick=$s5, lastGoalTick=$s6, replaySetup=$s7); the +1 ref DEMOTES the two SYM
       locals past the address temp so the whole 3-way rotation lands on the SYM map. Measured
       alternatives, all worse: dropping the local entirely (45, ours 4 insns short), fencing
       lastRealTick/lastGoalTick instead at decl (67) or before-consumer (44). */
    while ((simGlobal.time32Hz <= Input_gTime && (simVar.endSimGame == 0))) {
      if ((Replay_ReplayMode == 2) && (simVar.pauseSim == 0)) {
        Replay_GetInterfaceKey();
        if (Replay_ReplayInterface.depressed == 4) {
          Replay_ReplayInterface.depressed = 0;
          simVar.endSimGame = Replay_ReplayInterface.end;
          if (replaySetup->instantReplay != 0) {
            AudioCmn_UnPauseAndRestart();
          }
          else {
            if ((Replay_ReplayInterface.end != 0) && (simVar.quickPauseSim != 0)) {
              simVar.quickPauseSim = 0;
              AudioCmn_UnPauseAndQuit();
            }
            else if (simVar.quickPauseSim != Replay_ReplayInterface.pause) {
              simVar.quickPauseSim = Replay_ReplayInterface.pause;
              if (simVar.quickPauseSim != 0) {
                Camera_Update();
                AudioCmn_Pause();
              }
              else {
                AudioCmn_UnPause();
              }
            }
          }
        }
      }
      if (simVar.endSimGame == 0) {
        if (simVar.pauseSim != 0) {
          Sim_ProcessPause();
          simVar.keyRelease = 0x18;
        }
        else {
          if (Input_Interface(0x15,1) != 0) {
            AudioMus_SwitchSong();
            Hud_ActivateCDPlayer = 1;
          }
          if (simVar.keyRelease != 0) {
            if (Input_Interface(simVar.keyRelease,0) == 0) {
              simVar.keyRelease = 0;
            }
          }
          else {
            int i;
            /* SYM-CODEGEN-CARRIER: gameSetup
               The late address materialization and priced read-only fence
               reproduce retail's $s2 web.  Direct/fused GameSetup spellings
               were measured at 11--38 diffs, as receipted below. */
            char *gameSetup;

            i = 0;
            /* MATCH (W59-A14, class 2a/2b): the guard reads commMode through the ALREADY-LIVE
               replaySetup pointer, so nothing of GameSetup is materialized before it; the
               `gameSetup` la then sits BELOW the guard and reorg fills the `bnez` delay slot
               with its `lui %hi` exactly like retail. */
            if (i > (int)(u_int)(replaySetup->commMode == 1))
              goto SimMainLoop_inputDone;
            gameSetup = (char *)&GameSetup_gData;
            /* MATCH (W59-A14, class 2c): 1-operand read-only fence = +1 ref on gameSetup.
               allocsim (MATCH 22/23) prices it: pri 0.1578 -> 0.1842 overtakes the
               call-result pseudo (0.1611), restoring retail's gameSetup=$s2 / result=$s3.
               Without it the whole web flips s2<->s3 (measured 33 diffs). */
            __asm__ ("" : : "r"(gameSetup));
SimMainLoop_inputLoop:
              if ((Input_Interface(i != 0 ? 0x1b : 0x1a,1) != 0) &&
                  (Replay_ReplayMode < 2)) {
                Camera_NextMode(i);
              }
              if (Input_Interface(i != 0 ? 0x1d : 0x1c,1) != 0) {
                DashHUD_ToggleHud(i);
              }
              *(int *)((i << 2) + (int)Input_gLookBehind) =
                  Input_Interface(i + 0x16,0);
              Sim_CheckForPause(1);
              i++;
              if (i <= (int)(u_int)(*(int *)(gameSetup + 0xc) == 1))
                goto SimMainLoop_inputLoop;
SimMainLoop_inputDone:
              ;
          }
        }
      }
      simGlobal.time32Hz = simGlobal.time32Hz + 1;
    }
    skipRender = 0;
    if (((simVar.pauseSim == 0) && (simVar.quickPauseSim == 0)) && (simVar.endSimGame == 0)) {
      if (simVar.currentClockTicks > simVar.goalClockTicks) {
        skipRender = 1;
      }
      else {
        one = 1;
        do {
          if ((simVar.currentClockTicks & 1U) == 0) {
            SimQueue_SetCurrentInput(simVar.currentClockTicks >> 1);
          }
          InBetween = 0;
          /* NEAR-MISS 6 (ours 319 / oracle 321) -- W61-A13 2026-08-15, DIAGNOSED.
             Not a coloring or a statement-order residual: it is pure BASIC-BLOCK
             PLACEMENT of the shared Sim_ProcessSimSchedules() block.  Label the
             three arms A = the shared PSS (this if's then-arm, also the target of
             all four condition branches), B = the speed==3 arm, C = the
             InBetween/Camera_Update arm.  Retail lays them out [B][C][A]:
                 bne v1,v0,.L7158 ; jal PSS ; j .L716C          <- B (ONE call + j)
               .L7158: sw s0,InBetween ; jal Camera_Update ; j .L7174   <- C
               .L716C: jal PSS                                   <- A
               .L7174:
             so gcc cross-jump-merged B's SECOND call into A and B pays a `j`.
             Ours lays them out [B][A][C]: B falls straight THROUGH into A, so the
             `j`+`nop` pair never exists -- byte-for-byte identical merge, 2 insns
             shorter.  Everything else in the function matches.
             FALSIFIED (each a real gate run):
               goto-shared-tail, one call in B (label after C) ....... 38 @317
               goto-shared-tail, both calls in B .................... 32 @319
               negated outer guard, no gotos ....................... 32 @319
               inner if/else inverted (C arm written first) .......... 8 @319
               base + explicit `goto` out of the C arm .............. 6 @319 (ties)
               negated guard + shared call textually last .......... 38 @317
             The goto forms make it WORSE because gcc then folds B entirely
             (`beq a0,v0,.Lshared`), losing B's own call.
             NEXT ANGLE: this is a jump.c/cross_jump block-ordering question, not a
             spelling one -- dump the RTL after jump2 and find which pass puts A
             adjacent to B.  Do not spend more source permutations.
             W62-A12 (2026-08-15): re-gated 6 @319/321.  THE 12C EXIT-BLOCK
             PLACEMENT DEVICE IS FALSIFIED HERE, and it is falsified as being
             EQUIVALENT to the plain skip-goto, which is the useful part:
               `if (0) { pss: PSS(); }` after C, cond+B goto pss ......... 38 @317
               same with the if/else skeleton kept intact ................ 38 @317
               explicit `goto done; pss: PSS(); done:;` (the W61 control) . 38 @317
             All three produce the IDENTICAL score, i.e. gcc expands `if (0) {L: X;}`
             to exactly the same `j Lend / L: X / Lend:` as the hand-written skip --
             the device does not add a distinct basin on this shape.  Also measured:
               13D on-demand cross_jump UN-MERGER, void fence heading arm A .. 12 @323
               same fence between B's two calls ......................... 6 @319 (inert)
             The 317 forms remain 2 SHORT of ours, confirming the receipt above:
             once B ends in a goto, gcc folds B's own call away entirely.
             The unexplored axis is therefore the LAYOUT pass, not the source. */
          if ((Replay_ReplayMode != 2) ||
              (Replay_ReplayInterface.speed == 2) ||
              ((Replay_ReplayInterface.speed == one) &&
               ((simVar.currentClockTicks & 1U) == 0)) ||
              ((Replay_ReplayInterface.speed == 0) &&
               ((simVar.currentClockTicks & 3U) == 0)))
            goto SimMainLoop_processSchedules;
          /* MATCH: SLD lines 764-775 order the B/C/A blocks.  The fresh test
             read is required for retail's inner speed reload and base lifetimes. */
          switch (*(volatile int *)&Replay_ReplayInterface.speed) {
            case 3:
              Sim_ProcessSimSchedules();
              Sim_ProcessSimSchedules();
              break;
            default:
              InBetween = one;
              Camera_Update();
              break;
          }
          goto SimMainLoop_processedSchedules;
SimMainLoop_processSchedules:
          Sim_ProcessSimSchedules();
SimMainLoop_processedSchedules:
          simVar.currentClockTicks = simVar.currentClockTicks + 1;
        } while (simVar.currentClockTicks <= simVar.goalClockTicks);
      }
    }
    else {
      Camera_Update();
    }
    if (skipRender == 0) {
      Render_Render(simVar.pauseSim);
    }
    if ((Input_MainExitKey() != 0) ||
        ((Replay_ReplayMode == 3 && (0x40 < simGlobal.gameTicks)))) {
      simVar.endSimGame = 1;
    }
  } while( true );
SimMainLoop_endGame:
  if (Replay_ReplayMode < 2) {
    GameSetup_gData.finalPerpArrests = GameSetup_gData.perpArrests;
  }
  return;
}

/* end of sim.cpp */
