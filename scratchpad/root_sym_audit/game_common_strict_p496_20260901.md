# SYM-to-source declaration audit

Target: `C:\Temp\nfs4-sym-next-20260825\recon\game\common`
Trusted SYM: `C:\Temp\claud\dumpsym_clean\dumpsym_src\nfs4-f-v3.txt`

This is a review queue, not an auto-fix list. Missing retail names are
strong evidence; extra source names can be matching carriers or decompiler
temporaries and must be tested against the function oracle before removal.
GCC-v2-mangled function/EXT names are used only as linkage keys; source
functions are mapped to their demangled C++ names and class scopes.

## Summary

- SYM functions in target TUs: 1193
- Mapped to reconstructed definitions: 1193 (1189 demangled class/name maps)
- Source definitions still using mangled linkage identifiers: 0
- Explicit deleting-destructor ABI carriers: 4
- Explicit cross-TU ownership closures: 0
- Declaration-clean mapped functions: 855
- Missing SYM names: 0
- Extra source-local names: 1445
- Type-comparison findings: 0
- Recognized ABI/debug-equivalent type encodings: 20
  (anonymous-enum-tag=1, generic-function-pointer=3, reference-as-pointer=12, vla-runtime-pointer=4)
- Function storage-class findings: 0
- Implicit aggregate special members (source body correctly absent): 0
- Explicit oracle-receipted carrier mappings: 15
- Explicit restored inline-local mappings: 43
- Explicit restored macro-local mappings: 0
- Explicit linkage-proven ABI parameters omitted from SYM: 2
- Explicit source-only codegen carriers: 137
- Explicit oracle-proven function type overrides: 0
- Functions needing mapping review: 0
- SYM object-owned data records in target TUs: 547
- Compact address-only data records mapped by exact name+VA: 366
- Mapped source global definitions: 547
- Special SYM vtable records mapped: 115/115
- Blob-backed object globals: 0
- Missing/extra global definitions: 0/0
- Global storage-class findings: 0
- Explicit oracle-proven global storage overrides: 0
- Global type findings: 0
- Recognized global debug-equivalent types: 3
  (anonymous-struct-tag=1, explicit-signed-char=2)
- Explicit measured global array carriers: 0
- Explicit source-only global/data-layout carriers: 32
- Explicit host-only fallback globals: 0
- Explicit linker-folded shared common globals: 0
- Explicit oracle-proven global type overrides: 0

## Review queue

### `AI_DoReactions__FP8Car_tObj` (0x80057b94, ai.cpp:185, map=exact)

- Extra source locals: `iVar1`, `uVar2`

### `AI_CheckForPlayerActions__FP8Car_tObjT0` (0x80057dd4, ai.cpp:256, map=exact)

- Extra source locals: `carObjLocal`, `carOdometer`, `direction`, `otherCarObjLocal`, `otherOdometer`

### `AI_OpponentBlockPlayer__FP8Car_tObjT0` (0x800580d8, ai.cpp:350, map=exact)

- Extra source locals: `bVar1`, `iVar3`, `personality`

### `AI_HandleShouldersAndOffRoad__FP8Car_tObj` (0x8005895c, ai.cpp:582, map=exact)

- Extra source locals: `bVar1`, `lane`, `merit0`, `merit2`, `sl`

### `AI_CalculateLaneSpeeds__FP8Car_tObj` (0x80058d20, ai.cpp:659, map=exact)

- Extra source locals: `carObjLaneShift`, `forwardDistanceIntMeters`, `iVar2`

### `AI_CalcMeritsBasedOnSpeed__FP8Car_tObj` (0x800590b4, ai.cpp:781, map=exact)

- Extra source locals: `iVar1`, `lane`, `laneInfo`, `laneSpeed`, `observation`, `observationBase`

### `AI_CheckForClearLanes__FP8Car_tObj` (0x80059434, ai.cpp:900, map=exact)

- Extra source locals: `iVar2`, `runningIndex`

### `AI_HandleTrafficHonking__FP8Car_tObj` (0x80059b88, ai.cpp:1105, map=exact)

- Extra source locals: `dir`, `honk`, `iVar2`

### `AI_CalculateDesiredLatPosition__FP8Car_tObj` (0x8005a15c, ai.cpp:1311, map=exact)

- Extra source locals: `bVar1`, `carObjLocal`, `desiredLane`, `iVar2`, `iVar4`, `laneInfo`, `laneWidth`, `minLatPosition`

### `AI_CalculateAdjustedDesiredSpeed__FP8Car_tObj` (0x8005a390, ai.cpp:1411, map=exact)

- Extra source locals: `adjustedSpeed`, `carObjLocal`

### `AI_IsMellowZone__FP8Car_tObji` (0x8005a628, ai.cpp:1503, map=exact)

- Extra source locals: `bVar1`, `numCars`

### `AI_PushFinishedCarsToSide__FP8Car_tObj` (0x8005a724, ai.cpp:1551, map=exact)

- Extra source locals: `bVar1`, `iVar2`, `raceT`

### `ReleaseCops__15AIHigh_BTC_Perp` (0x8005f6b4, aih_btcperp.cpp:45, map=exact)

- Extra source locals: `ppCVar2`

### `IsFalseArrest__15AIHigh_BTC_Perp` (0x8005f798, aih_btcperp.cpp:113, map=exact)

- Extra source locals: `dotTerm`, `dotTerm2`, `ppCVar7`

### `HandlePullOver__15AIHigh_BTC_Perp` (0x8005fa58, aih_btcperp.cpp:291, map=exact)

- Extra source locals: `bVar1`, `cond5`, `iVar2`, `pSVar3`

### `NotifyCopsOfArrest__15AIHigh_BTC_Perp` (0x8005fc30, aih_btcperp.cpp:412, map=exact)

- Extra source locals: `iVar3`, `pCVar1`, `ppCVar2`

### `NotifyCopsOfArrestComplete__15AIHigh_BTC_Perp` (0x8005fce8, aih_btcperp.cpp:460, map=exact)

- Extra source locals: `iVar3`, `pCVar1`, `ppCVar2`

### `NotifyCopsOfFalseArrest__15AIHigh_BTC_Perp` (0x8005fda0, aih_btcperp.cpp:508, map=exact)

- Extra source locals: `iVar3`, `pCVar1`, `ppCVar2`

### `NotifyHumanCopsOfArrestHud__15AIHigh_BTC_Perp` (0x8005fe58, aih_btcperp.cpp:556, map=exact)

- Extra source locals: `iVar3`, `pCVar1`, `ppCVar2`

### `ClearForNewStage__15AIHigh_BTC_PerpP19AIHigh_BTC_HumanCop` (0x8005ff10, aih_btcperp.cpp:606, map=exact)

- Extra source locals: `pCVar1`

### `CheckForActivation__15AIHigh_BTC_Perp` (0x8005ff74, aih_btcperp.cpp:650, map=exact)

- Extra source locals: `iVar2`, `iVar5`, `pAVar3`, `pCVar1`, `pCVar6`, `ppCVar4`

### `NewStage__20AIHigh_BTC_HumanPerpP19AIHigh_BTC_HumanCop` (0x8006007c, aih_btcperp.cpp:735, map=exact)

- Extra source locals: `carObj`, `wrappedSlice`

### `__17AIHigh_BTC_AIPerpP8Car_tObj` (0x800602f4, aih_btcperp.cpp:898, map=exact)

- Extra source locals: `iVar2`, `pCVar1`

### `_._17AIHigh_BTC_AIPerp` (0x8006037c, aih_btcperp.cpp:961, map=exact)

- Extra source locals: `iVar1`, `pCVar2`

### `AvoidCops__17AIHigh_BTC_AIPerp` (0x800603cc, aih_btcperp.cpp:1013, map=exact)

- Extra source locals: `bVar1`, `iVar2`, `iVar4`, `iVar6`, `iVar7`, `pCVar3`, `pCVar5`

### `CalculateTimeTillContact__17AIHigh_BTC_AIPerp` (0x80060710, aih_btcperp.cpp:1180, map=exact)

- Extra source locals: `copDistance`

### `FindClosestCop__17AIHigh_BTC_AIPerp` (0x800607b4, aih_btcperp.cpp:1239, map=exact)

- Extra source locals: `pCVar2`, `ppCVar4`

### `HighExecute__17AIHigh_BTC_AIPerp` (0x800608b4, aih_btcperp.cpp:1326, map=exact)

- Extra source locals: `_Var4`, `iVar1`, `otherCarObj`, `pAVar3`, `pAVar5`, `this_00`

### `NewStage__17AIHigh_BTC_AIPerpP19AIHigh_BTC_HumanCop` (0x80060d74, aih_btcperp.cpp:1631, map=exact)

- Extra source locals: `pAVar5`, `this_00`

### `CheckIfABlockadeCanBeSetup__13AIHigh_Player` (0x80061400, aih_play.cpp:29, map=exact)

- Extra source locals: `cannotSetup`, `chaseInfo`, `copCar`, `type`

### `SetupBlockade__13AIHigh_Player` (0x80061784, aih_play.cpp:132, map=exact)

- Extra source locals: `bVar2`, `chaseInfo`, `copBlockade`, `distance`, `lastSlice`, `manager`, `one`, `speaker`

### `CheckForNewLevel__13AIHigh_Playeri` (0x8006220c, aih_play.cpp:570, map=exact)

- Extra source locals: `doIt`, `lapTicks`, `numLevels`, `p`, `pa_Var1`, `pci`, `pi`, `pt`

### `HandleSpeech__13AIHigh_Player` (0x800624ec, aih_play.cpp:760, map=exact)

- Extra source locals: `_Var4`, `iVar3`, `pSVar1`

### `MaintainAvailableCops__13AIHigh_Player` (0x80062638, aih_play.cpp:878, map=exact)

- Extra source locals: `available`, `pInfo`

### `__13AIHigh_PlayerP8Car_tObj` (0x800628c0, aih_play.cpp:976, map=exact)

- Extra source locals: `a`, `chaseIndex`, `copGameInfoCopy`, `iVar1`, `iVar4`, `lapTicks`, `levels`, `pCVar2`, `pInfo`, `pInfo2`, `pInfo3`, `pcVar3`

### `HandleCops__13AIHigh_Player` (0x80062ac4, aih_play.cpp:1147, map=exact)

- Extra source locals: `pInfo`, `prodSlipYawNeg`

### `CleanupBlockaders__13AIHigh_Playeri` (0x80062c64, aih_play.cpp:1227, map=exact)

- Extra source locals: `bVar3`, `pCVar2`

### `HandlePullOver__13AIHigh_Player` (0x80062d7c, aih_play.cpp:1301, map=exact)

- Extra source locals: `a`, `bVar1`, `chaseInfo`, `chaseLapTime`, `engagementLapTime`, `iVar2`, `iVar5`, `pcVar6`

### `CheckForWipeOut__15AIHigh_Opponent` (0x80063308, aih_opp.cpp:18, map=exact)

- Extra source locals: `absField1380`, `bVar1`, `carObj_h`, `hlai`, `new_var`, `numRacers`, `pInfo`, `state`, `tableEntry`

### `DoRearEnder__15AIHigh_Opponent` (0x800634e8, aih_opp.cpp:472, map=exact)

- Extra source locals: `iVar1`, `mask`, `pCVar4`, `pCVar6`, `ppCVar7`, `sliceAddress`, `smackCarObj`, `speed`, `tickPtr`

### `DoProvokedAttack__15AIHigh_Opponent` (0x80063b2c, aih_opp.cpp:790, map=exact)

- Extra source locals: `iVar1`, `iVar4`, `myCarObj`, `oppCarObj`, `pCVar3`

### `HighExecute__10AIHigh_Cop` (0x80063cc4, aih_cop.cpp:288, map=exact)

- Extra source locals: `aihCopFlagsBoundary_`, `blockLevel`, `carObj`, `chaseInfo`, `chaseTarget`, `co`, `copChasers`, `cutOff`, `dir`, `distance`, `driveAway`, `engagement`, `factor`, `meters`, `mode`, `mode2`, `mode3`, `murder`, `needy`, `oldState`, `one`, `p`, `perTick`, `perp`, `requestSlice`, `retarget`, `rev`, `reverse`, `rotation`, `slices`, `speaker`, `speed`, `targetLevel`, `wrongWayHit`

### `CheckForWipeOut__10AIHigh_Cop` (0x80065430, aih_cop.cpp:1978, map=exact)

- Extra source locals: `bVar1`, `iVar2`, `pAVar3`

### `CheckForNewTarget__10AIHigh_Cop` (0x800655a8, aih_cop.cpp:2099, map=exact)

- Extra source locals: `bVar1`, `bVar3`

### `CheckForNewTriggers__10AIHigh_Cop` (0x80065944, aih_cop.cpp:2365, map=exact)

- Extra source locals: `crime`, `gotPtr`, `initialGameTicks`, `numCars`, `pSimGlobalInitial`, `perpInfo`, `typeOffset`

### `HighExecute__14AIHigh_Traffic` (0x80065e6c, aih_traf.cpp:171, map=exact)

- Extra source locals: `normalState`, `purgatoryState`, `release`

### `AICop_NoCopsInArea__Fii` (0x80066b08, aicop.cpp:92, map=exact)

- Extra source locals: `iVar1`, `iVar3`, `ppCVar2`

### `AIInit_InitAICar__FP8Car_tObjP10Udff_tInfo` (0x80067314, aiinit.cpp:342, map=exact)

- Extra source locals: `iVar1`, `iVar2`, `iVar6`, `pAVar3`, `pAVar4`, `pCVar5`, `scale`

### `AIInit_DeInitAICar__FP8Car_tObj` (0x800674e8, aiinit.cpp:407, map=exact)

- Extra source locals: `nm`, `pAVar2`, `pAVar3`, `pa_Var1`

### `AILife_RCPickSliceAndDirection__FP8Car_tObj` (0x800676e4, ailife.cpp:58, map=exact)

- Extra source locals: `basisCar`, `basisCarIndex`, `speed`

### `AIPerson_SetPersonalityPointers__Fv` (0x80068afc, aiperson.cpp:77, map=exact)

- Extra source locals: `iVar2`, `ppCVar1`

### `AIPerson_LoadScriptData__FP10Udff_tInfo` (0x80068ea4, aiperson.cpp:165, map=exact)

- Extra source locals: `actionMul`, `addr`, `byteOff2`, `byteOffset`, `iVar1`, `scriptBase`

### `AIPerson_LoadGlue__FP10Udff_tInfo` (0x80068f80, aiperson.cpp:209, map=exact)

- Extra source locals: `b`, `cmp`, `iVar1`, `iVar3`, `piVar2`

### `AIPhysic_HandleWipeoutTimer__FP8Car_tObj` (0x80069af0, aiphysic.cpp:431, map=exact)

- Extra source locals: `base`, `info`, `limit`, `r`

### `AIPhysic_CheckForBadPosition__FP8Car_tObj` (0x80069e14, aiphysic.cpp:528, map=exact)

- Extra source locals: `pos`, `slice`

### `AIPhysics_UseCoolPhysics__FP8Car_tObj` (0x80069eec, aiphysic.cpp:552, map=exact)

- Extra source locals: `b`, `flags`

### `AIPhysic_SimplePhysics__FP8Car_tObj` (0x80069f30, aiphysic.cpp:568, map=exact)

- Extra source locals: `a`, `cs`, `lat`, `v`

### `AIPhysic_SimplePhysics_LongVel__FP8Car_tObj` (0x8006a29c, aiphysic.cpp:648, map=exact)

- Extra source locals: `level`, `newSpeed`, `t`

### `AIPhysic_SimplePhysics_LatVel__FP8Car_tObj` (0x8006a5f4, aiphysic.cpp:762, map=exact)

- Extra source locals: `absV`

### `AIPhysic_HandleDirection__FP8Car_tObj` (0x8006a7cc, aiphysic.cpp:818, map=exact)

- Extra source locals: `x574`, `x718`

### `AIPhysic_Preperation__FP8Car_tObj` (0x8006a8b4, aiphysic.cpp:846, map=exact)

- Extra source locals: `lat`

### `AIPhysic_GetDesiredVector__FP8Car_tObj` (0x8006ac3c, aiphysic.cpp:923, map=exact)

- Extra source locals: `sl`, `t`, `v`

### `AIPhysic_CheckIfOutOfControl__FP8Car_tObj` (0x8006b260, aiphysic.cpp:1062, map=exact)

- Extra source locals: `iVar3`, `lat`, `spd`

### `AIPhysic_OutOfControlPhysics__FP8Car_tObj` (0x8006b400, aiphysic.cpp:1121, map=exact)

- Extra source locals: `latvelcalcLookahead`, `wipeOutEndTick`

### `AIPhysic_InControlPhysics__FP8Car_tObj` (0x8006bac8, aiphysic.cpp:1522, map=exact)

- Extra source locals: `r`

### `AIPhysic_ProcessBarrierCollision__FP8Car_tObj` (0x8006c920, aiphysic.cpp:1919, map=exact)

- Extra source locals: `v`

### `AIPhysic_ProcessCollision__FP8Car_tObj` (0x8006c974, aiphysic.cpp:1930, map=exact)

- Extra source locals: `v`

### `AIPhysic_ChangeDirection__FP8Car_tObji` (0x8006c9f0, aiphysic.cpp:1956, map=exact)

- Extra source locals: `newDir`, `rampPos`, `sg`, `v`

### `AIPhysic_CheckForGripReduction__FP8Car_tObj` (0x8006caa8, aiphysic.cpp:1988, map=exact)

- Extra source locals: `iVar1`, `iVar2`, `iVar3`, `iVar4`, `iVar5`, `pers`

### `AIPhysic_InitCar__FP8Car_tObj` (0x8006cc60, aiphysic.cpp:2061, map=exact)

- Extra source locals: `carFlags`, `this_`

### `AIScript_ProcessActionsAndReactions__FP10AIScript_ti` (0x8006f7f0, aiscript.cpp:77, map=exact)

- Extra source locals: `iVar2`, `new_var`, `new_var2`, `one`, `seven`, `two`

### `CloseTargeting__13AIState_Chase` (0x80070408, aistate.cpp:955, map=exact)

- Extra source locals: `latBias`, `latOffset`, `limit`, `slicePtr`, `t`, `x`, `z`

### `_._17AIState_Purgatory` (0x8007163c, aistate.cpp:2033, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `iVar2`, `pCVar1`, `pCVar2`, `pCVar4`, `pCVar6`, `ppCVar3`, `sortedList`

### `CheckIfCarIsNearbyAndStop__21AIState_RovingTrafficP8Car_tObjRi` (0x800718b4, aistate.cpp:2296, map=exact)

- Extra source locals: `carObj`, `iVar1`, `iVar2`, `iVar5`, `status_r`, `sum`

### `Execute__21AIState_RovingTraffic` (0x80071a68, aistate.cpp:2422, map=exact)

- Extra source locals: `iVar8`, `iVar9`, `pCVar4`, `ppCVar10`

### `Execute__17AIState_GotoSlice` (0x800723c0, aistate.cpp:2836, map=exact)

- Extra source locals: `carObj`, `desiredSpeed`, `inRange`, `limit`

### `Init__24AITrigger_TriggerManagerPc` (0x8007286c, aitriger.cpp:17, map=exact)

- Extra source locals: `deletedMarker`, `pptVar2`

### `InsertTrigger__24AITrigger_TriggerManagerP9trigger_tb` (0x80072948, aitriger.cpp:61, map=exact)

- Extra source locals: `iVar1`

### `GetTrigger__24AITrigger_TriggerManageriPi` (0x80072cd8, aitriger.cpp:187, map=exact)

- Extra source locals: `ptVar1`

### `CheckForClosestTriggerOfType__24AITrigger_TriggerManageri11triggerTypei` (0x80072d40, aitriger.cpp:207, map=exact)

- Extra source locals: `numTriggers`

### `Sort__24AITrigger_TriggerManager` (0x80072e30, aitriger.cpp:286, map=exact)

- Extra source locals: `firstTrigger`, `firstTriggerIndex`, `lastTrigger`, `numTriggers`, `prevTrigger`, `prevTriggerIndex`, `size`, `ta`, `tb`

### `Anim_Restart__Fv` (0x80073a94, anim.cpp:18, map=exact)

- Extra source locals: `deleteMe`, `p`, `pEnd`

### `Anim_DeInitSystem__Fv` (0x80073cb0, anim.cpp:88, map=exact)

- Extra source locals: `bVar1`, `iVar3`, `ppTVar2`

### `Anim_Handle__Fi` (0x80073ce8, anim.cpp:111, map=exact)

- Extra source locals: `iVar2`, `pAVar1`

### `__10AnimScripti` (0x80074360, anim.cpp:268, map=exact-signature)

- Extra source locals: `iVar1`, `ppTVar2`

### `__10AnimScriptii` (0x800743cc, anim.cpp:283, map=exact-signature)

- Extra source locals: `iVar2`, `ppTVar1`

### `__10AnimScriptP5Groupiii` (0x80074468, anim.cpp:305, map=exact-signature)

- Extra source locals: `iVar3`, `ppTVar2`

### `AudioClc_SetHorn__FP8Car_tObji` (0x80074738, audioclc.cpp:52, map=exact)

- Extra source locals: `iVar3`, `pAVar2`, `piVar1`

### `AudioClc_HonkHorn__FP8Car_tObjiii` (0x800747a8, audioclc.cpp:83, map=exact)

- Extra source locals: `iVar3`, `pAVar2`, `piVar1`

### `AudioCmn_UpdateThunder__Fv` (0x800764d0, audiocmn.cpp:223, map=exact)

- Extra source locals: `iVar2`, `uVar1`

### `AudioCmn_RemoveAsyncSfx__Fi` (0x800765b4, audiocmn.cpp:264, map=exact)

- Extra source locals: `ptr`

### `AudioCmn_DeInitAsyncSfx__Fv` (0x8007663c, audiocmn.cpp:286, map=exact)

- Extra source locals: `slot`

### `AudioCmn_LoadAsyncSfx__FiiPvi` (0x8007675c, audiocmn.cpp:341, map=exact)

- Extra source locals: `s`

### `AudioCmn_Init__Fv` (0x80076a74, audiocmn.cpp:447, map=exact)

- Extra source locals: `ambient`, `backwards`, `lap`, `lapSeed`, `mystic`, `setup`

### `AudioCmn_CheckState__FP8Car_tObj` (0x800770bc, audiocmn.cpp:773, map=exact)

- Extra source locals: `lap`, `tailOffset`

### `AudioCmn_InitChannelArray__Fv` (0x800778b0, audiocmn.cpp:998, map=exact)

- Extra source locals: `iVar2`, `neg1`, `pCVar1`

### `scaleFrequency__Fiii` (0x800778e8, audiocmn.cpp:1018, map=exact)

- Extra source locals: `uVar1`, `uVar2`

### `ChooseLoopedSample__F6s_typeT0` (0x80077c94, audiocmn.cpp:1168, map=exact)

- Extra source locals: `iVar1`

### `AudioCmn_SFX__Fi6s_typeT1iii` (0x80077d50, audiocmn.cpp:1232, map=exact)

- Extra source locals: `forceAmp`

### `freeVoiceChannel__Fi` (0x800780d0, audiocmn.cpp:1337, map=exact)

- Extra source locals: `pThis`

### `AudioCmn_PlaySound__Fiiiii` (0x800783a0, audiocmn.cpp:1470, map=exact)

- Extra source locals: `iVar1`

### `AudioCmn_PlaySFX__Fiiiiii` (0x800783cc, audiocmn.cpp:1479, map=exact)

- Extra source locals: `bankNum`, `bbase`, `bch`, `chbase`, `lookup`, `nbase`, `pan`, `pbase`, `pch`, `r`, `slot`, `slot2`

### `AudioCmn_SoundCar__FP8Car_tObjiiiiiii` (0x800788bc, audiocmn.cpp:1658, map=exact)

- Extra source locals: `bVar1`, `currentGas`, `delta`, `gasDelta`, `iVar10`, `iVar6`, `iVar9`, `rampIndex`, `rampedGas`, `roadProduct`, `sVar2`, `sndPlayer`, `speed`, `tunnelFlag`, `uVar7`

### `AudioCmn_TrafficSFX__Fiiiiiiii` (0x80079104, audiocmn.cpp:2002, map=exact)

- Extra source locals: `dir12`, `fade`, `index`, `patch`

### `AudioCmn_TrafficSkidSFX__Fi6s_typeT1iii` (0x80079390, audiocmn.cpp:2071, map=exact)

- Extra source locals: `iVar1`

### `AudioCmn_PlayerHornOn__Fiiiii` (0x80079444, audiocmn.cpp:2096, map=exact)

- Extra source locals: `iSFXnum`, `sndPlayer`, `uVar1`

### `AudioCmn_PlayerHornOff__Fi` (0x80079548, audiocmn.cpp:2134, map=exact)

- Extra source locals: `sndPlayer`, `uVar1`

### `AudioCmn_PlayFESFXVol__Fii` (0x80079624, audiocmn.cpp:2172, map=exact)

- Extra source locals: `volScaled`

### `quickSirenOn__Fi` (0x8007971c, audiocmn.cpp:2214, map=exact)

- Extra source locals: `iVar1`

### `SuperCopSirenOn__Fi` (0x80079790, audiocmn.cpp:2229, map=exact)

- Extra source locals: `iVar1`

### `UpdateSiren__Fiiiii` (0x8007995c, audiocmn.cpp:2273, map=exact)

- Extra source locals: `bend`

### `AudioCmn_UnPauseAndQuit__Fv` (0x80079ca4, audiocmn.cpp:2366, map=exact)

- Extra source locals: `j`

### `AudioCmn_UnPauseAndRestart__Fv` (0x80079d8c, audiocmn.cpp:2392, map=exact)

- Extra source locals: `j`

### `AudioMus_Fail__Fi` (0x8007a1dc, audiomus.cpp:196, map=exact)

- Extra source locals: `iVar2`, `pAVar1`

### `AudioMus_QueueRequestedSong__Fv` (0x8007a258, audiomus.cpp:219, map=exact)

- Extra source locals: `iVar4`, `pAVar2`, `pcVar3`, `piVar1`

### `AudioMus_SetCurrentSongInfo__Fv` (0x8007a390, audiomus.cpp:323, map=exact)

- Extra source locals: `iVar3`, `iVar4`, `pAVar2`

### `AudioMus_Server__Fii` (0x8007a3d0, audiomus.cpp:347, map=exact)

- Extra source locals: `availableSongs`, `buffered`, `diskReady`, `diskSong`, `randomMusic`, `randomNextSong`, `randomRange`, `randomValue`, `requestedSong`, `switchMode`

### `AudioMus_SysStartUp__FiiPc` (0x8007ac18, audiomus.cpp:619, map=exact)

- Extra source locals: `iVar2`, `pcVar1`

### `AudioMus_BuildPattern__FPc` (0x8007af60, audiomus.cpp:732, map=exact)

- Extra source locals: `iVar2`, `iVar3`, `pattern_00`, `piVar1`

### `AudioEng_Set__Fiiiiiiii` (0x8007b5a8, audioeng.cpp:31, map=exact)

- Extra source locals: `adjustedEsp`, `azimuth`, `camera`, `direction`, `doppler`, `gasLevel`, `shiftedEsp`, `volume`

### `AudioEng_Update__Fv` (0x8007b824, audioeng.cpp:115, map=exact)

- Extra source locals: `bVar3`, `cVar6`, `iVar4`, `iVar8`, `iVar9`, `pAVar10`, `pAVar11`, `pAVar12`, `pAVar13`, `pAVar16`, `sVar1`, `sVar2`, `uVar14`, `uVar15`, `uVar5`, `uVar7`

### `AudioEng_StartUp__FiPc` (0x8007be54, audioeng.cpp:355, map=exact)

- Extra source locals: `chanbase`, `gslot`

### `AudioEng_CleanUp__Fv` (0x8007c534, audioeng.cpp:609, map=exact)

- Extra source locals: `base`, `current`, `noHandle`

### `AudioTrk_Reset__Fv` (0x8007c614, audiotrk.cpp:24, map=exact)

- Extra source locals: `iVar4`, `iVar5`, `neg1`, `pAVar1`, `pCVar2`, `puVar3`

### `AudioTrk_StartUp__Fv` (0x8007c6f4, audiotrk.cpp:62, map=exact)

- Extra source locals: `iVar2`, `neg1`, `pAVar1`

### `AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji` (0x8007c750, audiotrk.cpp:85, map=exact)

- Extra source locals: `dopClamped`, `fadeIn`, `fadevol`, `level`

### `AudioTrk_SoundTrack__FP8Car_tObji` (0x8007cdc4, audiotrk.cpp:337, map=exact)

- Extra source locals: `curBack`

### `AudioTrk_PreLoad__Fv` (0x8007d35c, audiotrk.cpp:474, map=exact)

- Extra source locals: `room`

### `xzsquaredist32__FP8coorddefT0` (0x8007d5c4, bworld.cpp:56, map=exact)

- Extra source locals: `iVar1`, `iVar2`

### `UpdateContext__FP13DRender_tViewi` (0x8007d608, bworld.cpp:67, map=exact)

- Extra source locals: `pt`, `uVar1`

### `BWorld_InitSpikeBelt__Fv` (0x8007d818, bworld.cpp:146, map=exact)

- Extra source locals: `b`, `g`, `r`

### `BWorld_CheckChunkVisible__FP12BWorldSm_PosT0` (0x8007dc14, bworld.cpp:405, map=exact)

- Extra source locals: `chunkIndBwd`, `chunkIndFwd`, `sliceBwd`, `sliceFwd`

### `BWorld_IsSliceInBuildList__Fi` (0x8007e0a0, bworld.cpp:894, map=exact)

- Extra source locals: `chunkCount`, `piVar1`

### `BWorld_OnyxBuildFacets__FP13DRender_tView` (0x8007e0f4, bworld.cpp:921, map=exact)

- Extra source locals: `fogDist`, `fogStart`, `fogState`, `pvVar3`, `time`, `ts`

### `BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos` (0x8007ea14, bworldsm.cpp:101, map=exact)

- Extra source locals: `bVar3`, `iVar4`

### `BWorldSm_SetSlice__FiP12BWorldSm_Pos` (0x8007ed64, bworldsm.cpp:204, map=exact)

- Extra source locals: `iVar2`, `uVar1`

### `BworldSm_UpdateSimQuad__FP12BWorldSm_Pos` (0x8007f094, bworldsm.cpp:371, map=exact)

- Extra source locals: `iVar3`, `pGVar1`, `pTVar2`

### `BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi` (0x8007fac4, bworldsm.cpp:671, map=exact)

- Extra source locals: `direction`, `inQuad`

### `PointDirection__FP8coorddefN20` (0x8007fcb0, bworldsm.cpp:719, map=exact)

- Extra source locals: `iVar1`, `iVar2`

### `BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos` (0x8007ffd4, bworldsm.cpp:793, map=exact)

- Extra source locals: `bVar1`, `surfVal`

### `BWorldSm_FindClosestTriangleRez__FP8coorddefP12BWorldSm_Posi` (0x80080570, bworldsm.cpp:972, map=exact)

- Extra source locals: `attempt`, `botInd`, `currDist`, `cx`, `cy`, `cz`, `i`, `iVar2`, `iVar3`, `iVar4`, `pThis`, `simIndex`, `simSlices`, `slices`, `startQuadInd`, `startSlice`, `startsimquad`, `x`, `y`, `z`

### `Camera_TunnelLimit__FiPi` (0x800807c4, camera.cpp:120, map=exact)

- Extra source locals: `bVar1`, `pvVar2`

### `Camera_UpdateCollisionCam__Fi` (0x8008090c, camera.cpp:152, map=exact)

- Extra source locals: `pBVar3`

### `Camera_UpdateSimpleCam__Fi` (0x80080ac8, camera.cpp:190, map=exact)

- Extra source locals: `pBVar2`, `sVar1`

### `Camera_UpdateBumperCam__Fi` (0x80080bac, camera.cpp:211, map=exact)

- Extra source locals: `mode`, `pBVar4`

### `Camera_UpdateTailCam__Fii` (0x80080d84, camera.cpp:253, map=exact)

- Extra source locals: `armPtr`, `armY`, `ax`, `first`, `flip`, `lookBehind`, `lookBehindBase`, `mode`, `offset`, `rev`, `second`, `slices`, `x`, `z`

### `Camera_UpdateHeliCam__Fii` (0x800813cc, camera.cpp:568, map=exact)

- Extra source locals: `armY`, `ax`, `first`, `mode`, `offset`, `positionAnchor`, `rev`, `second`, `slices`, `x`, `z`

### `Camera_UpdateCircleCam__Fi` (0x80081ab8, camera.cpp:799, map=exact)

- Extra source locals: `pBVar2`, `sVar1`, `uVar3`

### `SetCameraZoom__Fii` (0x80081d38, camera.cpp:848, map=exact)

- Extra source locals: `gs`

### `Camera_UpdateTVCam__Fi` (0x80081e48, camera.cpp:876, map=exact)

- Extra source locals: `dist4`, `iVar1`, `iVar2`

### `Camera_UpdateAnimCam__Fi` (0x80081f94, camera.cpp:928, map=exact)

- Extra source locals: `cVar1`, `cVar4`, `iVar2`, `pAVar3`, `pBVar6`

### `Camera_UpdateFinishCam__Fi` (0x80082254, camera.cpp:995, map=exact)

- Extra source locals: `iVar1`, `pBVar2`, `pThis`

### `Camera_UpdateBlimpCam__Fi` (0x8008237c, camera.cpp:1032, map=exact)

- Extra source locals: `iVar3`, `pBVar2`, `sVar1`

### `Camera_SetSplineCam__Fi` (0x800824c0, camera.cpp:1060, map=exact)

- Extra source locals: `anchorSlice`, `cameraDirection`, `slice`, `sliceStep`

### `Camera_UpdateSplineCam__Fi` (0x800826c0, camera.cpp:1247, map=exact)

- Extra source locals: `anchorSlice`, `cameraPos`, `d`, `halfSlices`, `newSlice`, `nextSlice`, `nextSliceIdx`, `rotBase`, `rotRow`, `zoom`

### `Camera_UpdatePulloverCam__Fi` (0x80082c94, camera.cpp:1446, map=exact)

- Extra source locals: `cameraBase`, `cameraInfo`, `gameTicks`, `iVar3`

### `Camera_UpdateCopCam1__Fi` (0x80083010, camera.cpp:1530, map=exact)

- Extra source locals: `iVar1`, `pBVar5`

### `Camera_UpdateCopCam2__Fi` (0x800831a8, camera.cpp:1556, map=exact)

- Extra source locals: `tx`, `ty`, `tz`

### `Camera_Update__Fv` (0x800833d8, camera.cpp:1614, map=exact)

- Extra source locals: `bitsInfo`, `cameraBase`, `collisionPlayer`, `inCarMask`, `isInCar`, `modeBits`, `rotationBase`

### `Camera_Kill__Fv` (0x80083bec, camera.cpp:1928, map=exact)

- Extra source locals: `none`

### `Camera_TooSteep__FiP12BWorldSm_Pos` (0x80083d28, camera.cpp:1968, map=exact)

- Extra source locals: `d0`

### `Camera_AcquireTarget__FiP8coorddefT1P10matrixtdefi` (0x80084898, camera.cpp:2201, map=exact)

- Extra source locals: `adj`, `pBVar1`

### `Camera_SetMode__Fii` (0x80085608, camera.cpp:2474, map=exact)

- Extra source locals: `sVar1`

### `Camera_NextMode__Fi` (0x8008581c, camera.cpp:2515, map=exact)

- Extra source locals: `modeForRange`, `sVar1`, `setupBase`, `setupOffset`, `splitBase`, `uVar2`

### `Cars_DoGravityEffectsOnAcc__FP8Car_tObji` (0x80085d84, cars.cpp:91, map=exact)

- Extra source locals: `iVar1`, `iVar2`

### `Cars_InitializeCarTablesFlagsAndCounters__FP8Car_tObj` (0x800860e4, cars.cpp:237, map=exact)

- Extra source locals: `carType`, `pGVar6`, `pcVar1`, `pvVar2`, `uVar4`, `uVar7`

### `Cars_SetCarUpForHiRezSim__FP8Car_tObj` (0x80086ac4, cars.cpp:481, map=exact)

- Extra source locals: `bVar1`, `pTVar2`

### `Car_TireSkiddingStuff__FP8Car_tObj` (0x800878cc, cars.cpp:887, map=exact)

- Extra source locals: `cappedFront`, `skidVelocity`, `splashFront`, `splashRear`

### `Car_DoPostCollisionStuff__FP8Car_tObj` (0x800898dc, cars.cpp:1446, map=exact)

- Extra source locals: `absRoll`, `bodyPitchVal`, `clampCond`, `currentRollVal`, `gvClamp`, `iVar1`, `negGroundVel`, `negPitch`, `pBVar4`, `pCVar2`, `rideOffsetVal`, `roundedGV`

### `Cars_InitCar__FP8Car_tObji` (0x8008a174, cars.cpp:1786, map=exact)

- Extra source locals: `iVar1`, `mem`, `pCVar2`

### `Cars_Restart__Fv` (0x8008a4cc, cars.cpp:1908, map=exact)

- Extra source locals: `numCars`, `pCVar2`, `ppCVar6`

### `Cars_CleanUp__Fv` (0x8008aa40, cars.cpp:2072, map=exact)

- Extra source locals: `iVar1`, `iVar4`, `pCVar2`, `ppCVar3`, `schedule32Hz`

### `Cars_FindCurrentLap__FP8Car_tObj` (0x8008abc8, cars.cpp:2123, map=exact)

- Extra source locals: `uVar1`, `uVar2`

### `Cars_Randomize__Fv` (0x8008af84, cars.cpp:2228, map=exact)

- Extra source locals: `iVar1`, `iVar2`

### `InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem` (0x8008b3fc, chunk.cpp:28, map=exact)

- Extra source locals: `cVar2`, `cur`, `group`, `groupData`, `groupMem`, `pGVar6`, `pTVar9`, `probe`, `quadData`, `quadGroup`, `sVar3`, `stride`

### `Clock_MasterInterruptHandler__Fv` (0x8008b938, clock.cpp:27, map=exact)

- Extra source locals: `even128`, `local_10`

### `Collide_LimitAngularVel__FP13BO_tNewtonObj` (0x8008d8b4, collide.cpp:367, map=exact)

- Extra source locals: `iVar1`, `iVar2`

### `Collide_TestWithPlane__FP13BO_tNewtonObjP8coorddefT1` (0x8008d9a8, collide.cpp:448, map=exact)

- Extra source locals: `relDotFull`

### `Collide_DoObjectObjectCollision__FP13BO_tNewtonObjT0P8coorddefT2` (0x8008e5d4, collide.cpp:641, map=exact)

- Extra source locals: `object1`, `scaleFactor`

### `Collide_TestObjectVertices__FP13BO_tNewtonObjT0P8coorddefT2` (0x80090144, collide.cpp:1278, map=exact)

- Extra source locals: `rpx`, `rpz`

### `Collide_CheckForCollisionBetween__FP13BO_tNewtonObjT0` (0x80091374, collide.cpp:1665, map=exact)

- Extra source locals: `iVar2`, `iVar3`, `new_var`, `speedThresh`

### `Collide_ClearCollisionRegistry__Fv` (0x800914d4, collide.cpp:1761, map=exact)

- Extra source locals: `n`

### `Collide_CheckMeForCollisions__FP13BO_tNewtonObj` (0x800918cc, collide.cpp:1846, map=exact)

- Extra source locals: `minImpulse`

### `Roger__Q26Speech15DispatchSpeaker` (0x80095f28, speech.cpp:1263, map=exact)

- Extra source locals: `bVar1`, `bank`, `iVar2`, `pCVar5`, `pSVar7`, `reg_a1`, `reg_a2`, `reg_a3`, `sub`

### `StatusReply__Q26Speech15DispatchSpeaker` (0x8009619c, speech.cpp:1361, map=exact)

- Extra source locals: `bank`, `blocked`, `candidate`, `car`, `child`, `context`, `distance`, `from`, `hasBlocker`, `invalid`, `location`, `reverse`, `statusSub`, `sub`, `wing`

### `Status__Q26Speech15DispatchSpeaker` (0x800965d0, speech.cpp:1628, map=exact)

- Extra source locals: `PURS_UPDT`, `branchSub`, `canUpdate`, `car`, `carSpeed`, `carVf`, `case3Distance`, `case3DistanceVf`, `checkVf`, `clearVf`, `currentPosition`, `currentVf`, `dispatchVf`, `distanceVf`, `fastEnough`, `initialInvalid`, `initialVf`, `isCurrentSub`, `nearEntry`, `nearThis`, `nearVf`, `nestedDifferent`, `nestedPosition`, `nestedSpeaker`, `perpDistance`, `perpVf`, `position`, `positionSpeed`, `positionVf`, `ready`, `resetVf`, `speakerVf`, `speechContext`, `speechEntry`, `speechIndex`, `speechTable`, `statusSub`, `statusVf`, `tu5`, `uVar10`, `updateDistance`

### `Status__Q26Speech13MobileSpeaker` (0x80096b88, speech.cpp:1859, map=exact)

- Extra source locals: `COLOUR`, `REVINTRO`, `bVar1`, `bVar2`, `dispatchThis`, `dispatchVf`, `iVar11`, `iVar4`, `maskedFlags`, `nearLocation`, `pCVar5`, `pMVar12`, `pSVar10`, `pSVar7`, `pSVar9`, `pa_Var3`, `puVar6`, `uVar13`, `uVar8`, `vs_KMH_MPH`

### `Report__Q26Speech15DispatchSpeakerP8Car_tObj` (0x800971b0, speech.cpp:2237, map=exact)

- Extra source locals: `COLOUR`, `CONFIRM`, `REVINTRO`, `bVar1`, `bank`, `ctx`, `iVar3`, `iVar4`, `introFrom`, `pa_Var2`, `param2`, `piVar5`, `pursuitCar`, `reg_a2`, `reg_a3`, `sightedTo`, `speech`

### `Deny__Q26Speech15DispatchSpeaker` (0x80097358, speech.cpp:2319, map=exact)

- Extra source locals: `REVINTRO`, `bank`, `ctx`, `iVar2`, `iVar3`, `pSVar4`, `pa_Var1`, `reg_a3`, `vs_RDBLK_SSTRP`

### `Report__Q26Speech13MobileSpeakerP8Car_tObj` (0x80097bfc, speech.cpp:2613, map=exact)

- Extra source locals: `ID_UNIT1`, `REVINTRO`, `VOICE`, `ctx`, `pa_Var1`, `reportCar`, `reportLocation`

### `Engage__Q26Speech13MobileSpeakerP8Car_tObj` (0x80097ce8, speech.cpp:2654, map=exact)

- Extra source locals: `COLOUR`, `bVar2`, `bVar3`, `bVar4`, `bVar5`, `dispatchPosition`, `dispatchPositionVf`, `dispatchResult`, `dispatchThis`, `dispatchVf`, `engageCar`, `engageLocation`, `engageSpeed`, `iVar7`, `knownEntry`, `knownThis`, `pMVar6`, `pSVar12`, `pSVar13`, `pursuitFlag`, `replyCar`, `replyLocation`, `replyTo`, `sameVoice`, `savedDispatch`, `sightedCar`, `sightedLocation`, `superFlag`, `temp_a1_4`, `temp_s0_3`, `temp_s1_2`, `temp_v0_21`, `temp_v0_22`

### `Lose__Q26Speech13MobileSpeaker` (0x80098434, speech.cpp:2921, map=exact)

- Extra source locals: `REVINTRO`, `bVar1`, `bank`, `dispatchThis`, `finalDispatch`, `iVar3`, `iVar4`, `pCVar5`, `pSVar7`, `pa_Var2`, `reg_a1`, `reg_a2`, `reg_a3`, `uVar6`, `uVar8`, `voiceArg`

### `RoadBlock__Q26Speech13MobileSpeaker` (0x80098a4c, speech.cpp:3169, map=exact)

- Extra source locals: `REVINTRO`, `VOICE`, `ctx`, `dispatch`, `iVar2`, `iVar3`, `pa_Var4`

### `SpikeBelt__Q26Speech13MobileSpeaker` (0x80098b60, speech.cpp:3218, map=exact)

- Extra source locals: `REVINTRO`, `VOICE`, `ctx`, `dispatch`, `iVar2`, `iVar3`, `pa_Var4`

### `Backup__Q26Speech13MobileSpeaker` (0x80098c74, speech.cpp:3267, map=exact)

- Extra source locals: `COLOUR`, `ID_UNIT1`, `REVINTRO`, `VOICE`, `ctx`, `flags`, `iVar2`, `pCVar3`, `pa_Var1`, `requestCar`, `requestLocation`

### `Roger__Q26Speech13MobileSpeaker` (0x80098d6c, speech.cpp:3327, map=exact)

- Extra source locals: `COLOUR`, `VOICE`, `bVar1`, `bank`, `bankBase`, `bankIndex`, `confirmUnit`, `confirmVoice`, `ctx_00`, `dispatchStatus`, `iVar2`, `pSVar6`, `reg_a1`, `reg_a2`, `reg_a3`, `statusSub`

### `Purge__Q26Speech13MobileSpeaker` (0x80098f18, speech.cpp:3413, map=exact)

- Extra source locals: `bVar1`, `dispatchPurge`, `dispatchStatus`, `iVar3`, `next`, `pMVar4`, `pa_Var2`

### `ReportBlockade__Q26Speech13MobileSpeaker` (0x8009916c, speech.cpp:3506, map=exact)

- Extra source locals: `DISTANCE`, `ID_UNIT1`, `REVINTRO`, `SPIKE_BELT_SIDE`, `VOICE`, `car`, `ctx`, `iVar2`, `pa_Var1`

### `CopSpeak_RadioStaticActive__Fi` (0x80099418, copspeak.cpp:82, map=exact)

- Extra source locals: `handle`

### `CopSpeak_RadioStaticSquelch__Fv` (0x80099588, copspeak.cpp:130, map=exact)

- Extra source locals: `iVar1`, `ph`

### `CopSpeak_Free__FP17CopSpeak_tRequest` (0x8009971c, copspeak.cpp:209, map=exact)

- Extra source locals: `iVar1`, `iVar2`

### `CopSpeak_CleanUp__Fv` (0x80099adc, copspeak.cpp:343, map=exact)

- Extra source locals: `iVar2`, `pCVar1`

### `CopSpeak_InitVars__Fv` (0x80099b70, copspeak.cpp:371, map=exact)

- Extra source locals: `pCVar1`

### `CopSpeak_DirectRequest__FillP8Car_tObjPc` (0x80099bec, copspeak.cpp:397, map=exact)

- Extra source locals: `iVar1`, `iVar2`

### `CopSpeak_GenericBankRequest__FiP8Car_tObj` (0x80099c98, copspeak.cpp:424, map=exact)

- Extra source locals: `iVar1`, `iVar2`

### `CopSpeak_GetEnginePatch__Fii` (0x8009a2cc, copspeak.cpp:601, map=exact)

- Extra source locals: `iVar1`, `t1`

### `CopSpeak_Play__FP17CopSpeak_tRequesti` (0x8009a304, copspeak.cpp:618, map=exact)

- Extra source locals: `scaled`

### `CopSpeak_Skip__Fv` (0x8009a45c, copspeak.cpp:678, map=exact)

- Extra source locals: `iVar2`, `uVar1`

### `CopSpeak_Request__FP17CopSpeak_tRequest` (0x8009a4c8, copspeak.cpp:701, map=exact)

- Extra source locals: `head`, `iVar6`

### `CopSpeak_PlayNextRequest__Fv` (0x8009a828, copspeak.cpp:821, map=exact)

- Extra source locals: `iVar3`, `next`

### `CopSpeak_Flush__Fv` (0x8009a944, copspeak.cpp:861, map=exact)

- Extra source locals: `iVar1`, `iVar2`, `pCVar1`

### `CopSpeak_Server__Fv` (0x8009a994, copspeak.cpp:881, map=exact)

- Extra source locals: `carNoise`

### `CopSpeak_SfxQueued__Fv` (0x8009ac60, copspeak.cpp:971, map=exact)

- Extra source locals: `iVar1`, `pEntry`

### `DashHUD_CheckWrongWay__Fi` (0x8009b098, dashhud.cpp:100, map=exact)

- Extra source locals: `iVar2`, `pBVar1`

### `GenericPMX_LoadTexture__Fv` (0x8009b458, genericpmx.cpp:48, map=exact)

- Extra source locals: `pmx_height`, `shape_result`

### `LocateGroupNum__15SerializedGroupi` (0x8009c1c0, group.cpp:65, map=exact)

- Extra source locals: `iVar1`, `iVar2`, `pThis`, `param_1`

### `LocateCreateGroupType__15SerializedGroupiP9SimpleMemi` (0x8009c204, group.cpp:92, map=exact)

- Extra source locals: `iVar1`, `memAddress`, `param_1`, `uVar2`

### `CreateLiteGroup__15SerializedGroupP15SerializedGroupP9SimpleMem` (0x8009c27c, group.cpp:113, map=exact)

- Extra source locals: `memAddress`, `n`, `pThis`, `param_1`, `puVar1`, `sourceAddress`

### `CreateLiteGroupDataSize__15SerializedGroupP15SerializedGroupP9SimpleMemi` (0x8009c2e4, group.cpp:134, map=exact)

- Extra source locals: `memAddress`, `pThis`, `param_1`, `puVar1`, `sourceAddress`

### `Input_Update__Fv` (0x8009c478, input.cpp:106, map=exact)

- Extra source locals: `activeBase`, `activePtr`, `activeValue`, `addressBlocker`, `addressBlocker2`, `addressBlocker3`, `addressBlocker4`, `addressBlocker5`, `dbFlags`, `interfaceActive`, `one`

### `Math_NormalizeShortVector__FP8coorddef` (0x8009dbd4, mathnfs.cpp:298, map=exact)

- Extra source locals: `iVar1`, `iVar2`, `len_or_inv`, `tmp`, `z_sq`

### `MPause_MusicLogic__Fc` (0x8009e3e8, mpause.cpp:123, map=exact)

- Extra source locals: `bVar1`, `iVar3`, `pThis`, `uVar2`

### `MPause_ControllerLogic__Fv` (0x8009e6a0, mpause.cpp:222, map=exact)

- Extra source locals: `item`

### `MPause_Logic__Fv` (0x8009e784, mpause.cpp:254, map=exact)

- Extra source locals: `newItem`, `oldItem`, `pThis`

### `MPause_Render__Fv` (0x8009eaa0, mpause.cpp:363, map=exact)

- Extra source locals: `offset`, `y`

### `MPause_EndPauseMenu__Fv` (0x8009eeb0, mpause.cpp:451, map=exact)

- Extra source locals: `deviceSetup`

### `Newton_AddDamageZone__FP13BO_tNewtonObjiii` (0x8009ef2c, newton.cpp:85, map=exact)

- Extra source locals: `cappedYVel`, `newYVel`, `randomX`, `randomY`, `randomZ`, `result`, `secondTemp`

### `Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef` (0x8009ff80, newton.cpp:627, map=exact)

- Extra source locals: `iVar20`, `iVar24`, `iVar3`, `iVar5`, `newWheelAcc`, `pBVar4`, `temp`, `ti1`, `ti4`, `ti5`, `tstr9`, `wheelIndex`, `wheelY`

### `Newton_LimitCarsToDrivableDist__FP13BO_tNewtonObj` (0x800a0da4, newton.cpp:1096, map=exact)

- Extra source locals: `iVar1`

### `Newton_CalcPerpenHeightOfCenterPointFromGround__FP13BO_tNewtonObjP8coorddefT1` (0x800a116c, newton.cpp:1161, map=exact)

- Extra source locals: `iVar1`

### `Newton_UpdateRoadInfo__FP13BO_tNewtonObj` (0x800a1568, newton.cpp:1281, map=exact)

- Extra source locals: `pTVar2`, `uVar1`

### `Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi` (0x800a179c, newton.cpp:1361, map=exact)

- Extra source locals: `altitude`, `surfaceType`

### `Newton_QDUpdateVel__FP13BO_tNewtonObj` (0x800a1e68, newton.cpp:1548, map=exact)

- Extra source locals: `iVar1`, `iVar2`, `iVar3`

### `Newton_QDUpdateRot64Hz__FP13BO_tNewtonObj` (0x800a20e8, newton.cpp:1620, map=exact)

- Extra source locals: `cVar1`, `iVar2`, `iVar3`, `m1`

### `Newton_QDUpdateRot32Hz__FP13BO_tNewtonObj` (0x800a21f8, newton.cpp:1664, map=exact)

- Extra source locals: `cVar1`, `iVar2`, `iVar3`, `m1`

### `Newton_CalculateGroundShadowMatrix__FP13BO_tNewtonObjP8coorddefi` (0x800a2318, newton.cpp:1707, map=exact)

- Extra source locals: `dot`

### `Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef` (0x800a2af0, newton.cpp:1901, map=exact)

- Extra source locals: `dsum`, `nx`, `nxq`, `ny`, `nyq`, `nz`, `nz2`, `retreat`, `t3`, `yTemp`

### `Netwon_CheckForBadQuad__FP13BO_tNewtonObjP12BWorldSm_Posi` (0x800a2e24, newton.cpp:2455, map=exact)

- Extra source locals: `quad`, `uVar1`

### `Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj` (0x800a2e84, newton.cpp:2592, map=exact)

- Extra source locals: `aborted`, `iVar12`, `quadPt`

### `Newton_LimitAngularVelocity__FP13BO_tNewtonObj` (0x800a35dc, newton.cpp:2922, map=exact)

- Extra source locals: `uVar1`

### `Newton_ApplyTheLawOfGravity__FP13BO_tNewtonObj` (0x800a3674, newton.cpp:2946, map=exact)

- Extra source locals: `maxImpulse`

### `Nfs2_SystemNLibStartUp__Fv` (0x800a3dec, nfs3.cpp:50, map=exact)

- Extra source locals: `p`

### `Nfs2_GameModuleStartUp__FPi` (0x800a41a8, nfs3.cpp:192, map=exact)

- Extra source locals: `pThis`

### `LoadFrontendOverlay__Fv` (0x800a44f8, nfs3.cpp:289, map=exact)

- Extra source locals: `iVar1`

### `LoadOverlay__Fv` (0x800a454c, nfs3.cpp:307, map=exact)

- Extra source locals: `iVar1`

### `NFS3_CheckForFileOperations__Fv` (0x800a46dc, nfs3.cpp:365, map=exact)

- Extra source locals: `__asm__`, `e`

### `main` (0x800a4730, nfs3.cpp:765, map=exact)

- Extra source locals: `iVar2`, `uVar1`

### `BuildObjCollisionMatrix__FiiiP10matrixtdef` (0x800a4be8, object.cpp:110, map=exact)

- Extra source locals: `impactComp`, `objComp`

### `Object_KillStatus__Fv` (0x800a5258, object.cpp:363, map=exact)

- Extra source locals: `pOVar1`, `ppOVar2`

### `Object_CheckCollisionResults__FP18Object_tSimObjListiP13BO_tNewtonObj` (0x800a52f0, object.cpp:415, map=exact)

- Extra source locals: `finishedMulti`, `finishedSign`

### `Object_FindDefWithThisID__Fi` (0x800a59ac, object.cpp:650, map=exact)

- Extra source locals: `objDef`, `pThis`, `ppTVar2`

### `Object_AddCustomObject__FP9SceneElemi` (0x800a5a04, object.cpp:680, map=exact)

- Extra source locals: `size`, `type`

### `GetObjMaxDimensions__FPP13Trk_ObjectDefP14Trk_SimpleInstP8coorddef` (0x800a5d58, object.cpp:869, map=exact)

- Extra source locals: `lastVert`, `stopVert`

### `Draw__14ObjectSignAnimP13DRender_tViewP11Draw_DCachei` (0x800a6a38, object.cpp:1260, map=exact)

- Extra source locals: `finishedAnim`, `pTVar4`, `pThis`, `pa_Var3`, `ret`

### `Paths_StartUp__Fv` (0x800a6e14, paths.cpp:17, map=exact)

- Extra source locals: `deadfrm`, `frontPath`, `pathTable`

### `PauseMenu_FullText__FPcsss` (0x800a6e60, pausemenu.cpp:17, map=exact)

- Extra source locals: `iVar1`

### `PauseMenu_MenuTextPositioned__Fssss` (0x800a6f14, pausemenu.cpp:46, map=exact)

- Extra source locals: `iVar1`, `sMenuText`

### `PauseMenu_MenuText__FsbT1` (0x800a6f8c, pausemenu.cpp:68, map=exact)

- Extra source locals: `iVar1`

### `TextValue__14tPListIterator7tPlayer` (0x800a7054, pausemenu.cpp:120, map=exact)

- Extra source locals: `arg1`, `uVar1`

### `Increment__14tPListIterator7tPlayer` (0x800a70a4, pausemenu.cpp:134, map=exact)

- Extra source locals: `arg1`

### `Decrement__14tPListIterator7tPlayer` (0x800a7110, pausemenu.cpp:150, map=exact)

- Extra source locals: `arg1`, `pWork`, `piVar2`, `sVar1`

### `TextValue__21tPListIteratorIndexed7tPlayer` (0x800a7240, pausemenu.cpp:214, map=exact)

- Extra source locals: `arg1`, `pa_Var1`, `uVar2`

### `Increment__21tPListIteratorIndexed7tPlayer` (0x800a7290, pausemenu.cpp:231, map=exact)

- Extra source locals: `arg1`

### `Decrement__21tPListIteratorIndexed7tPlayer` (0x800a731c, pausemenu.cpp:248, map=exact)

- Extra source locals: `arg1`, `iVar2`, `pbVar4`, `piVar3`, `sVar1`

### `ProcessInput__10tPMenuItemR13tInputKeyTypeR13tPMenuCommand` (0x800a7448, pausemenu.cpp:324, map=exact)

- Extra source locals: `command`, `keyval`

### `Draw__28tPMenuItemNonInteractiveTextb` (0x800a74ac, pausemenu.cpp:356, map=exact)

- Extra source locals: `selected`

### `ProcessInput__25tPMenuItemLeftRightChoiceR13tInputKeyTypeR13tPMenuCommand` (0x800a75c4, pausemenu.cpp:427, map=exact)

- Extra source locals: `command`

### `Draw__25tPMenuItemLeftRightChoiceb` (0x800a7650, pausemenu.cpp:456, map=exact)

- Extra source locals: `index`, `vtable_p`, `x`

### `ProcessInput__25tPMenuItemLeftRightSliderR13tInputKeyTypeR13tPMenuCommand` (0x800a78ac, pausemenu.cpp:538, map=exact)

- Extra source locals: `command`, `max`, `value`

### `Draw__25tPMenuItemLeftRightSliderb` (0x800a79c8, pausemenu.cpp:645, map=exact)

- Extra source locals: `off`

### `ProcessInput__24tPMenuItemGoToMenuButtonR13tInputKeyTypeR13tPMenuCommand` (0x800a7dfc, pausemenu.cpp:818, map=exact)

- Extra source locals: `iVar2`, `pa_Var1`, `ptVar3`

### `tPMenuConstructor__6tPMenuP10tPMenuItemPv` (0x800a7f7c, pausemenu.cpp:893, map=exact)

- Extra source locals: `iVar2`, `iVar3`

### `Initialize__6tPMenu` (0x800a8048, pausemenu.cpp:947, map=exact)

- Extra source locals: `bVar1`, `disabled`, `iVar2`, `ptVar3`

### `Debounce__6tPMenu` (0x800a8148, pausemenu.cpp:989, map=exact)

- Extra source locals: `pa_Var1`

### `CheckForDisabled__6tPMenu` (0x800a8194, pausemenu.cpp:1007, map=exact)

- Extra source locals: `bVar1`, `iVar3`, `pa_Var2`, `ptVar4`, `ptVar5`

### `ProcessInput__6tPMenuR13tInputKeyTypeR13tPMenuCommand` (0x800a829c, pausemenu.cpp:1048, map=exact)

- Extra source locals: `bVar1`, `iVar2`, `pa_Var3`, `ptVar4`, `ptVar6`, `tVar5`

### `Draw__6tPMenu` (0x800a8510, pausemenu.cpp:1133, map=exact)

- Extra source locals: `pa_Var1`, `ptVar2`, `ptVar4`

### `Physics_InitCarSpecs__FP8Car_tObjP10Udff_tInfo` (0x800a86c8, physics.cpp:72, map=exact)

- Extra source locals: `iVar1`, `iVar2`, `iVar3`

### `Physics_CalculateDerivedCarSpecs__FP8Car_tObj` (0x800a8964, physics.cpp:165, map=exact)

- Extra source locals: `rpmAtMaxSpeedInHighestGear`

### `Physics_AttenuateVelocity__FP8Car_tObjiP10matrixtdef` (0x800a8e7c, physics.cpp:262, map=exact)

- Extra source locals: `vy`, `vz`, `x`, `z`

### `Physics_GetTorque__FP8Car_tObji` (0x800a92e4, physics.cpp:352, map=exact)

- Extra source locals: `iVar1`, `iVar2`

### `Physics_DoBarrierCheck__FP8Car_tObj` (0x800a94b8, physics.cpp:460, map=exact)

- Extra source locals: `centerKeep`, `centerX`, `centerY`, `centerZ`, `impact`, `linearZ`, `positionX`, `positionY`, `positionZ`, `raw1`, `raw2`, `raw3`, `velocityX`, `velocityY`, `velocityZ`, `x1raw`, `x3factor`, `x3left`

### `Physics_AutoShift__FP8Car_tObj` (0x800a9a50, physics.cpp:738, map=exact)

- Extra source locals: `lastGearOffset`

### `Physics_RampCarControlValues__FP8Car_tObj` (0x800a9d0c, physics.cpp:841, map=exact)

- Extra source locals: `iVar5`

### `Physics_FixEngineRpm__FP8Car_tObj` (0x800aa4e4, physics.cpp:1094, map=exact)

- Extra source locals: `firstExprGuard`, `firstProduct`, `nextMatX`, `nextMatY`, `nextVelX`, `nextVelY`, `transformedZ`

### `Physics_StopCar__FP8Car_tObj` (0x800aa6d8, physics.cpp:1181, map=exact)

- Extra source locals: `iVarW`, `iVarX`, `iVarY`, `iVarZ`

### `Physics_TestForBarrierCollision__FP8Car_tObj` (0x800aa7b0, physics.cpp:1215, map=exact)

- Extra source locals: `iVar1`

### `Physics_CalculateRoadGripModifiers__FP8Car_tObj` (0x800aa808, physics.cpp:1232, map=exact)

- Extra source locals: `speed`

### `Physics_CalculateCarAcceleration__FP8Car_tObj` (0x800aa984, physics.cpp:1346, map=exact)

- Extra source locals: `adjustedDesiredRpm`, `adjustedFlywheelRpm`, `candidateRpm`, `clampedFlywheelRpm`, `currentFlywheelRpm`, `damageAmount`, `damagedFlywheelRpm`, `downshiftRedlineRpm`, `newFlywheelRpm`, `redlineRpm`, `revLimitedRpm`, `scaledRatio`

### `Physics_CalcWheelLockAcc__FP8Car_tObjP23Physics_tWheelAccStruct` (0x800ab49c, physics.cpp:1662, map=exact)

- Extra source locals: `cmp`, `skid`

### `Physics_CalcTractionCircleAcc__FP8Car_tObjP23Physics_tWheelAccStruct` (0x800ab698, physics.cpp:1756, map=exact)

- Extra source locals: `gripLossQuotient`, `gripLossRatio`, `roadGripCompare`, `skidValue`, `tireType`, `wheel_reg`

### `Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct` (0x800aba3c, physics.cpp:1908, map=exact)

- Extra source locals: `a`, `cap`, `minSlipAngle`, `xAcc`

### `Physics_CalculateRSControlDesiredPosition__FP8Car_tObjii` (0x800abfa4, physics.cpp:2143, map=exact)

- Extra source locals: `laneDelta`

### `Physics_Real__FP8Car_tObj` (0x800ac164, physics.cpp:2212, map=exact)

- Extra source locals: `adjustedRpm`, `bVar1`, `brakeCap`, `brakeLevel`, `fz`, `gasLevel`, `iVar10`, `iVar11`, `iVar3`, `iVar4`, `iVar5`, `iVar6`, `iVar7`, `limitedBrakeAcc`, `lm`, `pTVar9`, `pvVar2`, `rsControl`, `sumZ`, `uVar13`, `uVar8`, `wheelMult`

### `R3DCar_ChangeTrafficColor__FP8Car_tObji` (0x800adc2c, r3dcar.cpp:85, map=exact)

- Extra source locals: `iVar1`, `palCopy`, `uVar2`, `uVar4`

### `R3DCar_Restart__Fv` (0x800adec8, r3dcar.cpp:174, map=exact)

- Extra source locals: `brakeOn`, `gsData`, `headOn`, `numCars`, `ppCVar3`

### `R3DCar_ReadInCarData__FPcP8Car_tObj` (0x800ae0a8, r3dcar.cpp:265, map=exact)

- Extra source locals: `iStack_30`, `iVar7`, `iVar9`, `in_a2`, `pSStack_34`, `pVStack_38`, `pacVar11`

### `R3DCcar_ReadeMapData__Fv` (0x800ae5b0, r3dcar.cpp:401, map=exact)

- Extra source locals: `addr`, `iVar1`, `iVar3`, `pRVar2`

### `R3DCcar_ReadTrackShadow__Fv` (0x800ae668, r3dcar.cpp:433, map=exact)

- Extra source locals: `addr`, `iVar1`, `iVar2`

### `R3DCar_DeInstantiate3DCarMenu__FP8Car_tObj` (0x800aecb4, r3dcar.cpp:566, map=exact)

- Extra source locals: `addr`, `addr_00`, `cVar1`, `iVar3`, `uVar2`

### `R3DCar_LoadFileAdr__FPc` (0x800aee50, r3dcar.cpp:626, map=exact)

- Extra source locals: `loadAddr`, `size`

### `R3DCar_Instantiate3DCar__FP8Car_tObji` (0x800aef2c, r3dcar.cpp:660, map=exact)

- Extra source locals: `colorTypeOffset`, `commMode`, `finalIndex`, `iVar9`, `loadedSceneColor`, `loadedSceneVRam`, `pGVar6`, `pTVar4`, `pcVar7`, `sVar3`, `scaledIndex`, `shape`, `shpfile`, `uVar2`, `uVar8`

### `R3DCar_InsertCarFacet__FP8Car_tObjP13DRender_tView` (0x800afbd0, r3dcar.cpp:1104, map=exact)

- Extra source locals: `brakeLight`, `copIndex`, `headLight`, `lightOff`, `limit`, `positionStep`, `replayMode`, `signalLight`, `uVar8`, `wheelRotation`

### `R3DCar_ReadInCarTextureMenu__FP8Car_tObjPcii` (0x800b0db0, r3dcar.cpp:1808, map=exact)

- Extra source locals: `sfBase`, `sfp`

### `R3DCar_InsertCarFacetMenu__FP8Car_tObjP13DRender_tView` (0x800b10fc, r3dcar.cpp:1907, map=exact)

- Extra source locals: `bVar2`, `cVar6`, `cancelFile`, `copIndex0`, `copIndex1`, `gf`, `iVar12`, `iVar13`, `iVar15`, `iVar16`, `iVar8`, `iVar9`, `loadedSceneBase`, `objId`, `pGVar14`, `pTVar10`, `ppTVar21`, `sVar3`, `slotOff`, `subOtBase`, `subOtOff`, `uVar20`, `uVar7`

### `R3DCar_Showroom__FP13DRender_tView` (0x800b2b88, r3dcar.cpp:2853, map=exact)

- Extra source locals: `m`, `t`

### `Render_Render__Fi` (0x800b34a8, render.cpp:234, map=exact)

- Extra source locals: `Player`, `ViewID`

### `StampImage__Fii` (0x800b38a8, render.cpp:383, map=exact)

- Extra source locals: `tpageX`, `x`

### `Replay_Compress__FPc` (0x800b3c4c, replay.cpp:65, map=exact)

- Extra source locals: `u`

### `Replay_Decompress__FPc` (0x800b3d10, replay.cpp:114, map=exact)

- Extra source locals: `u_pointer`

### `Replay_ResetReplay__Fv` (0x800b3f44, replay.cpp:182, map=exact)

- Extra source locals: `cam_walk`, `iVar1`, `pBuf`, `piVar2`

### `Replay_StoringControllerData__FG15tControllerData` (0x800b40bc, replay.cpp:256, map=exact)

- Extra source locals: `packedPtr`, `replayBuffer`, `source`

### `Replay_RetreivingControllerData__Fv` (0x800b4488, replay.cpp:313, map=exact)

- Extra source locals: `pcVar4`

### `Replay_GetInput__Fi` (0x800b4b38, replay.cpp:379, map=exact)

- Extra source locals: `counter`, `hasCameras`, `steering`

### `Sched_ExecuteCheck__FiiiiPiN24i` (0x800b61bc, schedule.cpp:29, map=exact)

- Extra source locals: `distanceTemp`

### `Sched_DeleteFunction__FP15Sched_tSchedulePFPv_vPv` (0x800b6434, schedule.cpp:129, map=exact)

- Extra source locals: `count`

### `Sched_Execute__FP15Sched_tSchedule` (0x800b6500, schedule.cpp:167, map=exact)

- Extra source locals: `distanceIndex`, `iVar2`, `j`, `mask`, `n`, `ppuVar1`

### `Sim_FadeInSFX__Fv` (0x800b67f8, sim.cpp:138, map=exact)

- Extra source locals: `iVar1`, `iVar2`

### `Sim_ProcessSimSchedules__Fv` (0x800b6878, sim.cpp:169, map=exact)

- Extra source locals: `firstSfx`

### `Sim_ProcessPause__Fv` (0x800b6b9c, sim.cpp:244, map=exact)

- Extra source locals: `iVar1`

### `Sim_CheckForPause__Fi` (0x800b6ca0, sim.cpp:287, map=exact)

- Extra source locals: `iVar1`

### `Sim_MainGameLoop__Fv` (0x800b6d4c, sim.cpp:345, map=exact)

- Extra source locals: `gameSetup`, `one`, `replaySetup`

### `SimQueue_Put__FiP14Input_tResults` (0x800b73cc, simqueue.cpp:105, map=exact)

- Extra source locals: `entry`, `iVar4`

### `GetAngleWind__FP17Souffle_tISouffle` (0x800b7694, souffle.cpp:39, map=exact)

- Extra source locals: `iVar1`, `uVar2`

### `Souffle_DoSouffle__Fv` (0x800b78ec, souffle.cpp:150, map=exact)

- Extra source locals: `dampingSpeed`, `iVar2`

### `Souffle_InsertFacet__FP13DRender_tView` (0x800b7de8, souffle.cpp:306, map=exact)

- Extra source locals: `iVar1`, `i_2`, `inCircle`, `is_2`, `off`, `translation`, `z`

### `Stats_TrackStats__FP8Car_tObj` (0x800b81fc, stats.cpp:129, map=exact)

- Extra source locals: `raceSlice`, `sliceTotal`

### `Stats_TrackEndGame__Fv` (0x800b8db8, stats.cpp:817, map=exact)

- Extra source locals: `checkpointUpdate`, `raceCar`, `sliceCar`, `sliceTotal`

### `LoadShapesAndMakePmx__FPcP12Draw_tPixMapiii` (0x800b942c, track.cpp:129, map=exact)

- Extra source locals: `emptyPalNum`, `multiPalOffset`

### `Track_AnimateTextures__Fv` (0x800b99dc, track.cpp:321, map=exact)

- Extra source locals: `artPtr`, `cVar2`, `iVar8`, `negOne`, `pDVar3`, `pTVar7`, `psVar6`, `sVar1`, `simPtr`, `typeEnvMap`, `uVar4`, `uVar5`

### `ReduceObjectPrecision__FP5GroupT0i` (0x800ba25c, track.cpp:610, map=exact)

- Extra source locals: `pointCount`, `x`, `y`, `z`

### `InvalidatePersistentCollideBoomObjects__FP5GroupT0` (0x800ba2fc, track.cpp:644, map=exact)

- Extra source locals: `iVar2`, `pGVar1`, `pThis`

### `CalcObjectBoundingSphere__FP5GroupT0` (0x800ba368, track.cpp:669, map=exact)

- Extra source locals: `dx`, `dy`, `dz`

### `CalcObjDefPtrs__Fv` (0x800ba5c8, track.cpp:727, map=exact)

- Extra source locals: `bVar1`, `iVar4`, `pGVar2`, `pGVar3`, `pThis`

### `Track_InitPersistentData__FP15SerializedGroup` (0x800ba62c, track.cpp:753, map=exact)

- Extra source locals: `simGroup`

### `Track_Init__FPc` (0x800ba808, track.cpp:814, map=exact)

- Extra source locals: `chunkIdx`, `dest`, `elemIdx`, `elemNext`, `elemPtr`, `entry`, `geomSubGrp`, `groupBase`, `groupOffset`, `iVar43_field`, `iVar44_field`, `instSubGrp`, `loadBuf`, `matCount`, `matInfo_p`, `matOffset`, `pCVar5`, `pSVar4`, `pThis`, `perGroup`, `rootSerGroup`, `scratchAlloc`, `src`, `subGroup`, `tR7`, `tT33`, `this_00`, `tp3`, `tp4`, `tp7`, `tu2`, `tu22`, `tu23`, `tu24`, `tu25`, `tu26`, `tu27`, `tu28`, `tu29`, `tu3`, `tu30`, `tu31`, `tu32`, `tu33`, `tu34`, `tu35`, `uVar6`, `uVar7_00`

### `Track_LoadObjectKillData__Fv` (0x800badb4, track.cpp:1056, map=exact)

- Extra source locals: `groupElements`

### `RestoreAll__11SaveSurface` (0x800baffc, track.cpp:1186, map=exact)

- Extra source locals: `iVar1`

## Implicit aggregate special members

## Explicit SYM carrier/optimization mappings

- `CheckForNewLevel__13AIHigh_Playeri`: `level`
- `HighExecute__10AIHigh_Cop`: `rightLatPos`, `slice`, `slowDownEndTime`, `timeNow`
- `CheckForNeedyPlayers__10AIHigh_Cop`: `thisPlayer`
- `HighExecute__14AIHigh_Traffic`: `trigger`
- `AIPhysic_ProcessCollision__FP8Car_tObj`: `reverseTime`
- `AIPhysic_InitCar__FP8Car_tObj`: `d`
- `Engage__Q26Speech13MobileSpeakerP8Car_tObj`: `Sub`
- `Catch__Q26Speech13MobileSpeakeri`: `Arrest`, `carObj`
- `Bullhorn__Q26Speech13MobileSpeaker`: `carObj`
- `Newton_CalcDistToClosestPlayerCar__FP13BO_tNewtonObj`: `dummy`
- `Newton_SetInitialSlicePositionOrientationEtc__FP13BO_tNewtonObjiP8coorddefi`: `dummy`

## Explicit restored inline-local mappings

- `AISpeeds_NeedToSlowDownForCurve__FP8Car_tObjiii`: `futureSpeed` from `GetNeededDistance`, `sIndex` from `GetBrakeDistance`, `speed` from `GetBrakeDistance`, `this` from `GetBrakeDistance`, `this` from `GetBrakeDistance`, `this` from `GetNeededDistance`
- `SetCar__Q26Speech7SpeakerP8Car_tObj`: `Colour` from `SetColour`
- `CheckLocationBank__6SpeechPQ26Speech12LocationBankPci`: `bankid` from `Set`, `name` from `Set`
- `CheckCallSignBank__6SpeechPQ26Speech12CallSignBankPci`: `bankid` from `SetMobile`, `unit` from `SetMobile`
- `CalculateBankSize__6SpeechPcPQ26Speech11CarBankNamePlT3`: `a` from `IsHeader`, `b` from `IsHeader`, `c` from `IsHeader`, `d` from `IsHeader`, `p` from `ReadBE32`, `this` from `IsHeader`, `this` from `ReadBE32`, `this` from `ReadBE32`, `this` from `ReadBE32`
- `LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell`: `a` from `IsData`, `b` from `IsData`, `c` from `IsData`, `d` from `IsData`, `this` from `IsData`, `this` from `IsHeader`
- `SubmitRequest__6Speechlll`: `bank` from `BankOffset`, `this` from `BankOffset`, `this` from `FileHandle`
- `Ready__Q26Speech15DispatchSpeakerP8Car_tObj`: `Blockade` from `SetBlockade`
- `Catch__Q26Speech13MobileSpeakeri`: `this` from `Colour`, `this` from `Distance`, `this` from `Location`, `this` from `Location`, `this` from `VirtualCallSign`, `this` from `VirtualCallSign`, `this` from `VirtualClearPerp`, `this` from `VirtualPerp`, `this` from `VirtualPerp`, `this` from `VirtualPerp`, `this` from `VirtualPerp`, `this` from `VirtualPerp`, `this` from `VirtualPerp`

## Explicit restored macro-local mappings


## Explicit linkage-proven ABI parameters omitted from SYM

- `Value__14tPListIterator7tPlayer`: `arg1`
- `Value__21tPListIteratorIndexed7tPlayer`: `arg1`

## Explicit source-only codegen carriers

- `AI_HandleChangeInNumLanes__FP8Car_tObj`: `laneCount`
- `AI_TryToShareLanes__FP8Car_tObjT0`: `laneWidth`
- `AI_KeepCarsInLane__FP8Car_tObj`: `local`
- `AIHigh_StartUp__Fv`: `carFlags`, `copCarFlag`, `newHigh`, `slot`
- `AIHigh_Execute__Fv`: `bVar1`
- `CheckForCrimes__16AIHigh_BasicPerp`: `speed`, `wrongWay`
- `RemoveChaser__16AIHigh_BasicPerpii7copType`: `piBase`, `piVar2`
- `AddChaser__16AIHigh_BasicPerpii7copType`: `piVar2`
- `CheckSpikeBelt__15AIHigh_BasicCop`: `freshenElapsed`
- `FindRandomBarrierFreeArea__19AIHigh_BTC_HumanCopiii`: `doubledFraction`
- `NewStage__19AIHigh_BTC_HumanCopiii`: `laneBits`, `leftWidth`, `limitL`, `limitR`
- `UpdateFreezeModeAndPullOverMode__19AIHigh_BTC_HumanCop`: `startingDirection`
- `HighExecute__18AIHigh_BTC_Wingman`: `minLatMetersDistance`, `minLongMetersDistance`, `minTimeInZone`, `murder`, `speed`
- `UpdateFreezeModeAndPullOverMode__18AIHigh_BTC_Wingman`: `oldFreezeMode`
- `SetupWingman__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCop`: `sideTimes28`
- `SetupBlockader__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCopi`: `beltSlice`, `blockadeDirection`, `blockadeFlags`, `blockadeSlice`, `initSliceCandidate`, `initializationSliceDistance`, `maximumDistance`, `numSlices`, `perpDistance`, `sliceOffset`
- `AILife_PlaceCarAtLocation__FP8Car_tObji`: `direction`
- `AILife_ReencarnateTraffic__FP8Car_tObj`: `colorIdx`
- `AILife_ReencarnateTrafficByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef`: `colorIdx`
- `AILife_IsSliceInAnyVisibleArea__Fi`: `ppCVar2`
- `AILife_IsSliceCloseToAnyCopCar__Fi`: `ppCVar2`
- `AIPerson_LoadPersonalityData__FP10Udff_tInfo`: `copCollisionFirmness`
- `AIPhysic_RevEngine__FP8Car_tObj`: `deadfrm`
- `AIPhysic_CalculateGear__FP8Car_tObj`: `found`
- `AIPhysic_OutOfControlPhysics__FP8Car_tObj`: `cfg`, `r`
- `AIPhysic_GetRearEndDamageFactor__FP8Car_tObj`: `result`
- `StartUp2__14AIDataRecord_t`: `pAVar1`
- `CleanUp1__14AIDataRecord_t`: `pa_Var1`
- `Setup__23AIDataRecord_AccTable_t`: `iVar1`
- `Upgrade__30AIDataRecord_CurveSpeedTable_ti`: `iVar1`, `pcVar1`, `round`
- `AISpeeds_BTCGetGlueFactor__FP8Car_tObj`: `clampedGlueIndex`
- `AISpeeds_CalcTrafficTopSpeed__FP8Car_tObj`: `minimumSpeed`
- `AISpeeds_CalcHumanCurveSpeed__FP8Car_tObj`: `off`
- `AIScript_ClearLastReactionIndex__FP10AIScript_t`: `neg1`
- `__14AIState_NormalP8Car_tObj`: `pCVar1`
- `__13AIState_ChaseP8Car_tObjT1P8coorddefiiiii`: `direction`, `reverseDirCheck`
- `_._13AIState_Chase`: `pCVar1`
- `SetUp__13AIState_Chase`: `dc`, `iVar2`, `pCVar2`
- `Execute__13AIState_Chase`: `lmAbs`
- `ApproachTargeting__13AIState_Chasei`: `iVar5`, `pCVar4`
- `FindBarrierEndSlice__13AIState_Chase`: `numSlicesLess6`
- `_._15AIState_Offroad`: `pCVar1`
- `Execute__15AIState_Offroad`: `iVar4`, `pCVar3`
- `_._14AIState_Donuts`: `pCVar1`
- `Execute__14AIState_Donuts`: `carObj`, `numSlicesLess3`
- `AIWorld_IsDriveableLaneInSliceRange__Fiiii`: `i`, `sliceDelta`
- `AIWorld_LaneIndex__Fii`: `iVar2`
- `AIWorld_CalculateDeltaRoadYaw__FP8Car_tObj`: `gnLess1`, `iVar2`, `nextSlice`, `numSlices`
- `AIWorld_CalcRoadBend__FP8Car_tObji`: `bend`
- `Anim_FreeHandle__Fi`: `deleteMe`
- `AudioClc_GetClosestCars__Fiii`: `viewpos`
- `AudioMus_Threshold__Fv`: `music`
- `AudioMus_SetEntry__FP19AudioMus_tSongEntry`: `iVar3`
- `AudioMus_PlaySong__FPc`: `pick`
- `SetupChunkBuildList__FP13DRender_tView`: `buildList`, `viewList`
- `BWorld_InitContexts__Fv`: `noClient`
- `BWorld_Init__Fv`: `random`
- `GetStmQuadPts__FP12BWorldSm_PosP8coorddef`: `vertices`
- `FindClosestQuad__FP8coorddefP12BWorldSm_Pos`: `sliceChanged`
- `NormalCache_Init__Fv`: `invalid`
- `Cars_DoExtraCarCollisionProcessing__FP8Car_tObj`: `player`
- `Cars_CalculateRoadSpan__FP8Car_tObj`: `absSpan`
- `Collide_DoActualObjectCollisionCheck__FP13BO_tNewtonObjT0P8coorddefT2`: `selectedRange`
- `Control_Human__FP8Car_tObj`: `lights`
- `Distance__Q26Speech12LocationBanki`: `backward`, `end`, `forward`, `start`
- `FindLocation__Q26Speech7SpeakerP8Car_tObj`: `advance`, `offset`
- `LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell`: `alignment`, `dataSize`, `extension`, `isheader`, `reserveArg`, `reserveBytes`, `reserveCallArg`
- `__6Speech`: `dispatch`, `mobile`
- `Promote__Q26Speech7Speaker`: `cont`
- `Activate__Q26Speech15DispatchSpeakeri`: `iVar1`
- `Activate__Q26Speech13MobileSpeakerP8Car_tObj`: `iVar3`
- `FindMobile__6SpeechP8Car_tObj`: `mobile`
- `LocateNextGroupType__15SerializedGroupi`: `zero`
- `LocateGroupType__15SerializedGroupii`: `newLen`, `uVar2`
- `NFS3_CheckForFileOperations__Fv`: `z0`, `z1`
- `Object_InitCollisionCheckLoop__FP12BWorldSm_PosP18Object_tSimObjListPi`: `altSlice`
- `__15ObjectMultiAnimP8coorddefP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectP23ObjectFinishedMultiAnim`: `z`
- `Draw__15ObjectMultiAnimP13DRender_tViewP11Draw_DCachei`: `t3`
- `Draw__25tPMenuItemLeftRightSliderb`: `packetPtr`
- `Physics_RampCarControlValues__FP8Car_tObj`: `incValue`
- `R3DCar_GetCarName__FPcii`: `copIdx`
- `R3DCar_Visibilty__FP8Car_tObjP13DRender_tView`: `modeOne`
- `Souffle_Add__FP8coorddefiT0iii`: `limit`
- `Stats_TrackEndGame__Fv`: `raceIndex`
- `TextSys_Word__Fi`: `off`
- `TextSys_WordFlags__Fi`: `off`
- `TextSys_WordX__Fi`: `off`
- `TextSys_WordY__Fi`: `off`
- `Track_DeInit__Fv`: `deleteMe`

## Explicit oracle-proven function type overrides


## Object-owned global/storage review

- `aih_btccop.cpp` explicit source-only global/data-layout carriers: `AIH_BTCCop_freezeToggle_8013c564`
- `aih_traf.cpp` explicit source-only global/data-layout carriers: `D_800551A4`
- `aihigh.cpp` explicit source-only global/data-layout carriers: `AIHigh_None_vtable`, `AIHigh_kVtbl_80054dcc`
- `audiocmn.cpp` explicit source-only global/data-layout carriers: `D_8013C67C`, `D_8013C684`, `D_8013C68C`, `D_8013C690`, `D_8013C694`, `D_8013C698`, `D_8013C69C`, `D_8013C6A0`, `D_8013C6A4`, `D_8013C6A8`
- `sim.cpp` explicit source-only global/data-layout carriers: `D_8013D410`, `D_8013D418`, `D_8013D420`
- `vtables_aidatarecord.cpp` explicit source-only global/data-layout carriers: `AIDataRecord_BestLine_t_vtable`, `AIDataRecord_CarTracking_t_vtable`, `AIDataRecord_CurveSpeedTable_t_vtable`, `AIDataRecord_TrackCurve_t_vtable`
- `vtables_aihigh.cpp` explicit source-only global/data-layout carriers: `AIHigh_BTC_Perp_vtable`, `AIHigh_BasicCop_vtable`, `AIHigh_Player_vtable`
- `vtables_aistate.cpp` explicit source-only global/data-layout carriers: `AIState_Base_vtable`, `AIState_NonActive_vtable`, `AIState_None_vtable`
- `vtables_object.cpp` explicit source-only global/data-layout carriers: `ObjectAnim_vtable`
- `vtables_tdialog.cpp` explicit source-only global/data-layout carriers: `tDialogInteractive_vtable`, `tDialogMessageStringWithTimeout_vtable`
- `vtables_tmenu.cpp` explicit source-only global/data-layout carriers: `tBlankMenuItemGoToMenuNFS4Button_vtable`, `tBlankMenuItemNFS4LeftRightChoice_vtable`
- No ownership, storage-class, or type findings.
