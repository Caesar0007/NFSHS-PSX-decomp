# SYM-to-source declaration audit

Target: `C:\Temp\nfs4-decomp\recon\game\common`
Trusted SYM: `C:\Temp\claud\dumpsym_clean\dumpsym_src\nfs4-f-v3.txt`

This is a review queue, not an auto-fix list. Missing retail names are
strong evidence; extra source names can be matching carriers or decompiler
temporaries and must be tested against the function oracle before removal.
GCC-v2-mangled function/EXT names are used only as linkage keys; source
functions are mapped to their demangled C++ names and class scopes.

## Summary

- SYM functions in target TUs: 1258
- Mapped to reconstructed definitions: 1258 (1246 demangled class/name maps)
- Source definitions still using mangled linkage identifiers: 0
- Explicit deleting-destructor ABI carriers: 12
- Explicit cross-TU ownership closures: 0
- Declaration-clean mapped functions: 1228
- Missing SYM names: 0
- Extra source-local names: 6
- Type-comparison findings: 28
- Recognized ABI/debug-equivalent type encodings: 21
  (anonymous-enum-tag=1, generic-function-pointer=3, reference-as-pointer=13, vla-runtime-pointer=4)
- Function storage-class findings: 28
- Implicit aggregate special members (source body correctly absent): 0
- Explicit oracle-receipted carrier mappings: 13
- Explicit restored inline-local mappings: 57
- Explicit restored macro-local mappings: 0
- Explicit compact static-local mappings: 4
- Exact cross-build/canonical name recoveries: 30
- Explicit linkage-proven ABI parameters omitted from SYM: 13
- Explicit source-only codegen carriers: 542
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

### `_._15AIHigh_BTC_Perp` (0x8005b438, aihigh.h:428, map=header-owner)

- Storage: SYM STAT vs source EXT

### `HighExecute__11AIHigh_None` (0x8005b460, aihigh.h:436, map=header-owner)

- Storage: SYM STAT vs source EXT

### `_._11AIHigh_None` (0x8005b468, aihigh.h:455, map=header-owner)

- Storage: SYM STAT vs source EXT

### `Execute__12AIState_None` (0x8005b488, aistate.h:475, map=header-owner)

- Storage: SYM STAT vs source EXT

### `_._12AIState_None` (0x8005b490, aistate.h:495, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Storage: SYM STAT vs source EXT

### `TestForRelease__12AIState_Base` (0x8005b4c4, aistate.h:536, map=header-owner)

- Storage: SYM STAT vs source EXT

### `_._12AIState_Base` (0x8005b4cc, aistate.h:555, map=header-owner)

- Storage: SYM STAT vs source EXT

### `_._15AIHigh_BasicCop` (0x8005cb4c, aihigh.h:588, map=header-owner)

- Storage: SYM STAT vs source EXT

### `Execute__17AIState_NonActive` (0x8005f624, aistate.h:3660, map=header-owner)

- Storage: SYM STAT vs source EXT

### `_._17AIState_NonActive` (0x8005f62c, aistate.h:3666, map=header-owner)

- Storage: SYM STAT vs source EXT

### `TestForRelease__12AIState_Base` (0x8005f678, aistate.h:3675, map=header-owner-va-copy)

- Storage: SYM STAT vs source EXT

### `_._12AIState_Base` (0x8005f680, aistate.h:3684, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Storage: SYM STAT vs source EXT

### `_._15AIHigh_BTC_Perp` (0x80061348, aihigh.h:1831, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Storage: SYM STAT vs source EXT

### `Execute__17AIState_NonActive` (0x80061370, aistate.h:1892, map=header-owner-va-copy)

- Storage: SYM STAT vs source EXT

### `_._17AIState_NonActive` (0x80061378, aistate.h:1901, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Storage: SYM STAT vs source EXT

### `TestForRelease__12AIState_Base` (0x800613c4, aistate.h:1913, map=header-owner-va-copy)

- Storage: SYM STAT vs source EXT

### `_._12AIState_Base` (0x800613cc, aistate.h:1922, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Storage: SYM STAT vs source EXT

### `_._13AIHigh_Player` (0x80063248, aihigh.h:1347, map=header-owner)

- Storage: SYM STAT vs source EXT

### `CheckForWipeOut__15AIHigh_Opponent` (0x80063308, aih_opp.cpp:23, map=exact)

- Extra source locals: `absField`, `carIndex`, `field1380`, `slotAddr`, `speedLimit`

### `Get__26AIDataRecord_CarTracking_ti` (0x8006d50c, aidatarecord.h:291, map=header-owner)

- Storage: SYM STAT vs source EXT

### `_._26AIDataRecord_CarTracking_t` (0x8006d514, aidatarecord.h:301, map=header-owner)

- Storage: SYM STAT vs source EXT

### `_._30AIDataRecord_CurveSpeedTable_t` (0x8006d534, aidatarecord.h:310, map=header-owner)

- Storage: SYM STAT vs source EXT

### `_._25AIDataRecord_TrackCurve_t` (0x8006d554, aidatarecord.h:319, map=header-owner)

- Storage: SYM STAT vs source EXT

### `_._23AIDataRecord_BestLine_t` (0x8006d574, aidatarecord.h:328, map=header-owner)

- Storage: SYM STAT vs source EXT

### `Execute__17AIState_NonActive` (0x80072750, aistate.h:3044, map=header-owner-va-copy)

- Storage: SYM STAT vs source EXT

### `_._17AIState_NonActive` (0x80072758, aistate.h:3065, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Storage: SYM STAT vs source EXT

### `TestForRelease__12AIState_Base` (0x80072830, aistate.h:3147, map=header-owner-va-copy)

- Storage: SYM STAT vs source EXT

### `_._12AIState_Base` (0x80072838, aistate.h:3170, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Storage: SYM STAT vs source EXT

### `NFS3_CheckForFileOperations__Fv` (0x800a46dc, nfs3.cpp:355, map=exact)

- Extra source locals: `e`

### `_._10ObjectAnim` (0x800a6de0, object.h:1344, map=header-owner)

- Storage: SYM STAT vs source EXT

## Implicit aggregate special members

## Explicit SYM carrier/optimization mappings

- `HighExecute__10AIHigh_Cop`: `rightLatPos`, `slice`, `slowDownEndTime`, `timeNow`
- `CheckForNeedyPlayers__10AIHigh_Cop`: `thisPlayer`
- `HighExecute__14AIHigh_Traffic`: `trigger`
- `AIPhysic_ProcessCollision__FP8Car_tObj`: `reverseTime`
- `Engage__Q26Speech13MobileSpeakerP8Car_tObj`: `Sub`
- `Lose__Q26Speech13MobileSpeaker`: `carObj`
- `Catch__Q26Speech13MobileSpeakeri`: `Arrest`, `carObj`
- `Roger__Q26Speech13MobileSpeaker`: `carObj`
- `Bullhorn__Q26Speech13MobileSpeaker`: `carObj`

## Explicit restored inline-local mappings

- `HighExecute__17AIHigh_BTC_AIPerp`: `carObj` from `AIState_BTCInactive`, `trafficOffset` from `AIState_BTCInactive`
- `CheckForNewLevel__13AIHigh_Playeri`: `level` from `SetChaseLevel`
- `__13AIHigh_PlayerP8Car_tObj`: `level` from `SetChaseLevel`
- `HandlePullOver__13AIHigh_Player`: `level` from `SetChaseLevel`
- `AIPhysic_InitCar__FP8Car_tObj`: `brakeDistanceMeters` from `AIPhysic_BrakeInfo`, `brakeTableLoop` from `AIPhysic_BrakeInfo`, `deceleration` from `AIPhysic_BrakeInfo`, `distance` from `AIPhysic_BrakeInfo`, `invDeceleration` from `AIPhysic_BrakeInfo`, `sIndex` from `AIPhysic_BrakeInfo`, `this` from `AIPhysic_BrakeInfo`
- `AISpeeds_NeedToSlowDownForCurve__FP8Car_tObjiii`: `futureSpeed` from `GetNeededDistance`, `sIndex` from `GetBrakeDistance`, `speed` from `GetBrakeDistance`, `this` from `GetBrakeDistance`, `this` from `GetBrakeDistance`, `this` from `GetNeededDistance`
- `SetCar__Q26Speech7SpeakerP8Car_tObj`: `Colour` from `SetColour`
- `CheckLocationBank__6SpeechPQ26Speech12LocationBankPci`: `bankid` from `Set`, `name` from `Set`
- `CheckCallSignBank__6SpeechPQ26Speech12CallSignBankPci`: `bankid` from `SetMobile`, `unit` from `SetMobile`
- `CalculateBankSize__6SpeechPcPQ26Speech11CarBankNamePlT3`: `a` from `IsHeader`, `b` from `IsHeader`, `c` from `IsHeader`, `d` from `IsHeader`, `p` from `ReadBE32`, `this` from `IsHeader`, `this` from `ReadBE32`, `this` from `ReadBE32`, `this` from `ReadBE32`
- `LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell`: `a` from `IsData`, `b` from `IsData`, `c` from `IsData`, `d` from `IsData`, `this` from `IsData`, `this` from `IsHeader`
- `SubmitRequest__6Speechlll`: `bank` from `BankOffset`, `this` from `BankOffset`, `this` from `FileHandle`
- `Ready__Q26Speech15DispatchSpeakerP8Car_tObj`: `Blockade` from `SetBlockade`
- `Catch__Q26Speech13MobileSpeakeri`: `this` from `Colour`, `this` from `Distance`, `this` from `Location`, `this` from `Location`, `this` from `VirtualCallSign`, `this` from `VirtualCallSign`, `this` from `VirtualClearPerp`, `this` from `VirtualPerp`, `this` from `VirtualPerp`, `this` from `VirtualPerp`, `this` from `VirtualPerp`, `this` from `VirtualPerp`, `this` from `VirtualPerp`
- `Object_CheckCollisionResults__FP18Object_tSimObjListiP13BO_tNewtonObj`: `this` from `ObjectFinishedMultiAnim`, `this` from `ObjectFinishedSignAnim`

## Explicit compact static-local mappings

- `CopSpeak_Debug__Fv`: `Copspeak_gTimeString` from compact SYM `Copspeak_gTimeString.308`
- `DashHUD_HUDCalc__Fi`: `tick32` from compact SYM `tick32.32`
- `Track_MakeTrackPathName__FPc`: `strspc` from compact SYM `strspc.42`
- `Track_MakeTrackDataPathName__FPc`: `strspc` from compact SYM `strspc.45`

## Exact cross-build/canonical name recoveries

- `AI_CalcMeritsBasedOnSpeed__FP8Car_tObj`: `i`
- `AI_HandleTrafficHonking__FP8Car_tObj`: `honkprob`
- `DoProvokedAttack__15AIHigh_Opponent`: `otherCar`
- `AILife_ReencarnateTraffic__FP8Car_tObj`: `paintIndex`
- `AILife_ReencarnateTrafficByPosition__FP8Car_tObjiiP8coorddefP10matrixtdef`: `paintIndex`
- `AIWorld_LaneIndex__Fii`: `perpDistance`
- `AIWorld_CalcRoadBend__FP8Car_tObji`: `bend`
- `Anim_Restart__Fv`: `i`
- `AudioCmn_PlaySFX__Fiiiiii`: `bankNum`
- `AudioTrk_Reset__Fv`: `se`
- `BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos`: `sliceChanged`
- `GetStmQuadPts__FP12BWorldSm_PosP8coorddef`: `vertices`
- `FindClosestQuad__FP8coorddefP12BWorldSm_Pos`: `sliceChanged`
- `Cars_Restart__Fv`: `carObj`
- `CopSpeak_PlayNextRequest__Fv`: `next`
- `PauseMenu_MenuText__FsbT1`: `x`
- `Physics_CalculateDerivedCarSpecs__FP8Car_tObj`: `rpmAtMaxSpeedInHighestGear`
- `Physics_AttenuateVelocity__FP8Car_tObjiP10matrixtdef`: `vy`, `vz`, `x`
- `Replay_Compress__FPc`: `u_pointer`
- `Replay_Decompress__FPc`: `u_pointer`
- `TextSys_Word__Fi`: `offset`, `phrase`
- `TextSys_WordFlags__Fi`: `s`, `sptr`
- `TextSys_WordX__Fi`: `x`, `xptr`
- `TextSys_WordY__Fi`: `y`, `yptr`

## Explicit restored macro-local mappings


## Explicit linkage-proven ABI parameters omitted from SYM

- `Value__14tPListIterator7tPlayer`: `arg1`
- `TextValue__14tPListIterator7tPlayer`: `arg1`
- `Increment__14tPListIterator7tPlayer`: `arg1`
- `Decrement__14tPListIterator7tPlayer`: `arg1`
- `Value__21tPListIteratorIndexed7tPlayer`: `arg1`
- `TextValue__21tPListIteratorIndexed7tPlayer`: `arg1`
- `Increment__21tPListIteratorIndexed7tPlayer`: `arg1`
- `Decrement__21tPListIteratorIndexed7tPlayer`: `arg1`
- `ProcessInput__10tPMenuItemR13tInputKeyTypeR13tPMenuCommand`: `command`, `keyval`
- `Draw__28tPMenuItemNonInteractiveTextb`: `selected`
- `ProcessInput__25tPMenuItemLeftRightChoiceR13tInputKeyTypeR13tPMenuCommand`: `command`
- `ProcessInput__25tPMenuItemLeftRightSliderR13tInputKeyTypeR13tPMenuCommand`: `command`

## Explicit source-only codegen carriers

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
- `IsFalseArrest__15AIHigh_BTC_Perp`: `dotTerm`, `dotTerm2`
- `HandlePullOver__15AIHigh_BTC_Perp`: `activationCopReady`, `caught`, `gameTicks`, `mobileSpeaker`
- `CheckForActivation__15AIHigh_BTC_Perp`: `activationRequested`
- `NewStage__20AIHigh_BTC_HumanPerpP19AIHigh_BTC_HumanCop`: `carObj`, `wrappedSlice`
- `CalculateTimeTillContact__17AIHigh_BTC_AIPerp`: `copDistance`
- `CheckIfABlockadeCanBeSetup__13AIHigh_Player`: `cannotSetup`, `chaseInfo`, `type`
- `SetupBlockade__13AIHigh_Player`: `bVar2`, `chaseInfo`, `distance`, `lastSlice`, `manager`, `one`
- `CheckForNewLevel__13AIHigh_Playeri`: `doIt`
- `MaintainAvailableCops__13AIHigh_Player`: `available`, `pInfo`
- `__13AIHigh_PlayerP8Car_tObj`: `chaseIndex`, `copGameInfoCopy`, `levels`, `pInfo`, `pInfo3`
- `HandleCops__13AIHigh_Player`: `pInfo`, `prodSlipYawNeg`
- `HandlePullOver__13AIHigh_Player`: `bVar1`, `chaseInfo`
- `CheckForWipeOut__15AIHigh_Opponent`: `bVar1`, `hlai`, `numRacers`, `state`
- `HighExecute__10AIHigh_Cop`: `aihCopFlagsBoundary_`, `blockLevel`, `carObj`, `chaseTarget`, `co`, `copChasers`, `cutOff`, `dir`, `distance`, `meters`, `murder`, `needy`, `one`, `retarget`, `rev`, `speed`, `targetLevel`, `wrongWayHit`
- `CheckForWipeOut__10AIHigh_Cop`: `skipWipeOut`
- `CheckForNewTarget__10AIHigh_Cop`: `blockadeActive`
- `CheckForNewTriggers__10AIHigh_Cop`: `perpInfo`
- `HighExecute__14AIHigh_Traffic`: `release`
- `AIPerson_LoadPersonalityData__FP10Udff_tInfo`: `copCollisionFirmness`
- `AIPerson_LoadScriptData__FP10Udff_tInfo`: `actionMul`, `byteOff2`, `byteOffset`, `scriptBase`
- `AIPhysic_RevEngine__FP8Car_tObj`: `deadfrm`
- `AIPhysic_HandleWipeoutTimer__FP8Car_tObj`: `info`, `limit`
- `AIPhysic_OutOfControlPhysics__FP8Car_tObj`: `cfg`, `latvelcalcLookahead`
- `AIPhysic_GetRearEndDamageFactor__FP8Car_tObj`: `result`
- `AIPhysic_ChangeDirection__FP8Car_tObji`: `rampPos`, `sg`
- `AIPhysic_CheckForGripReduction__FP8Car_tObj`: `pers`
- `Upgrade__30AIDataRecord_CurveSpeedTable_ti`: `iVar1`, `pcVar1`, `round`
- `AISpeeds_BTCGetGlueFactor__FP8Car_tObj`: `clampedGlueIndex`
- `AISpeeds_CalcTrafficTopSpeed__FP8Car_tObj`: `minimumSpeed`
- `AISpeeds_CalcHumanCurveSpeed__FP8Car_tObj`: `off`
- `AIScript_ProcessActionsAndReactions__FP10AIScript_ti`: `new_var`, `new_var2`, `one`, `seven`, `two`
- `__13AIState_ChaseP8Car_tObjT1P8coorddefiiiii`: `direction`, `reverseDirCheck`
- `SetUp__13AIState_Chase`: `dc`, `iVar2`
- `Execute__13AIState_Chase`: `lmAbs`
- `CloseTargeting__13AIState_Chase`: `latBias`, `latOffset`, `limit`, `t`
- `ApproachTargeting__13AIState_Chasei`: `iVar5`, `pCVar4`
- `FindBarrierEndSlice__13AIState_Chase`: `numSlicesLess6`
- `Execute__15AIState_Offroad`: `iVar4`
- `_._17AIState_Purgatory`: `ppCVar3`, `sortedList`
- `Execute__21AIState_RovingTraffic`: `iVar8`, `iVar9`
- `Execute__14AIState_Donuts`: `carObj`, `numSlicesLess3`
- `Execute__17AIState_GotoSlice`: `carObj`, `desiredSpeed`, `inRange`, `limit`
- `Init__24AITrigger_TriggerManagerPc`: `deletedCheckTime`
- `AudioClc_GetClosestCars__Fiii`: `viewpos`
- `AudioCmn_LoadAsyncSfx__FiiPvi`: `s`
- `AudioCmn_Init__Fv`: `ambient`, `backwards`, `mystic`, `setup`
- `AudioCmn_PlaySFX__Fiiiiii`: `bbase`, `chbase`, `lookup`, `nbase`, `pan`, `pbase`, `pch`, `r`, `slot`
- `AudioCmn_SoundCar__FP8Car_tObjiiiiiii`: `attenuation`, `currentGas`, `distanceScale`, `gasDelta`, `previousGas`, `rampedGas`, `roadProduct`, `rpmRatio`, `scaledAmplitude`, `tunnelFlag`
- `AudioCmn_TrafficSFX__Fiiiiiiii`: `fade`, `patch`
- `AudioCmn_PlayFESFXVol__Fii`: `volScaled`
- `UpdateSiren__Fiiiii`: `bend`
- `AudioMus_Threshold__Fv`: `music`
- `AudioMus_Server__Fii`: `randomMusic`, `randomRange`, `switchMode`
- `AudioMus_PlaySong__FPc`: `pick`
- `AudioEng_Set__Fiiiiiiii`: `adjustedEsp`, `azimuth`, `camera`, `direction`, `doppler`, `gasLevel`, `shiftedEsp`, `volume`
- `AudioEng_Update__Fv`: `rampedVolume`, `targetVolume`
- `AudioEng_StartUp__FiPc`: `chanbase`
- `AudioEng_CleanUp__Fv`: `player`
- `AudioTrk_AddCustomObject__FP9AudioElemiP8coorddefiP8Car_tObji`: `dopClamped`, `fadevol`, `level`
- `AudioTrk_SoundTrack__FP8Car_tObji`: `curBack`
- `BWorld_CheckChunkVisible__FP12BWorldSm_PosT0`: `chunkIndBwd`, `chunkIndFwd`
- `SetupChunkBuildList__FP13DRender_tView`: `buildList`, `viewList`
- `BWorld_OnyxBuildFacets__FP13DRender_tView`: `fogDist`, `fogStart`, `fogState`, `time`, `ts`
- `BWorld_Init__Fv`: `random`
- `BWorldSm_FindClosestQuadRez__FP8coorddefP12BWorldSm_Posi`: `inQuad`
- `BWorldSm_TunnelFlagSm__FP12BWorldSm_Pos`: `surfVal`
- `BWorldSm_FindClosestTriangleRez__FP8coorddefP12BWorldSm_Posi`: `crossA`, `crossB`
- `Camera_UpdateTailCam__Fii`: `armPtr`, `armY`, `ax`, `first`, `flip`, `lookBehindBase`, `offset`, `rev`, `second`, `slices`, `z`
- `Camera_UpdateHeliCam__Fii`: `armY`, `ax`, `rev`, `second`, `z`
- `SetCameraZoom__Fii`: `gs`
- `Camera_UpdateTVCam__Fi`: `clampedHeight`, `lastIndex`
- `Camera_UpdateAnimCam__Fi`: `cVar1`, `cVar4`
- `Camera_UpdateSplineCam__Fi`: `d`, `halfSlices`, `newSlice`, `nextSliceIdx`, `rotBase`
- `Camera_UpdatePulloverCam__Fi`: `gameTicks`, `side`
- `Camera_Update__Fv`: `bitsInfo`, `cameraBase`, `collisionPlayer`, `inCarMask`, `isInCar`, `modeBits`, `rotationBase`
- `Camera_AcquireTarget__FiP8coorddefT1P10matrixtdefi`: `adj`
- `Camera_NextMode__Fi`: `modeForRange`, `splitBase`
- `Cars_DoExtraCarCollisionProcessing__FP8Car_tObj`: `player`
- `Car_TireSkiddingStuff__FP8Car_tObj`: `splashFront`, `splashRear`
- `Car_DoPostCollisionStuff__FP8Car_tObj`: `absRoll`, `clampCond`, `rideOffsetVal`, `roundedGV`
- `InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem`: `cur`, `groupData`, `probe`, `quadCount`, `quadData`, `renderQuad`
- `Clock_MasterInterruptHandler__Fv`: `even128`
- `Collide_DoObjectObjectCollision__FP13BO_tNewtonObjT0P8coorddefT2`: `object1`
- `Collide_DoActualObjectCollisionCheck__FP13BO_tNewtonObjT0P8coorddefT2`: `selectedRange`
- `Collide_TestObjectVertices__FP13BO_tNewtonObjT0P8coorddefT2`: `rpx`, `rpz`
- `Collide_CheckForCollisionBetween__FP13BO_tNewtonObjT0`: `normalPtr`, `speedThresh`
- `Collide_ClearCollisionRegistry__Fv`: `n`
- `Collide_CheckMeForCollisions__FP13BO_tNewtonObj`: `minImpulse`
- `Control_Human__FP8Car_tObj`: `lights`
- `Distance__Q26Speech12LocationBanki`: `backward`, `end`, `forward`, `start`
- `FindLocation__Q26Speech7SpeakerP8Car_tObj`: `advance`, `offset`
- `LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell`: `alignment`, `dataSize`, `extension`, `isheader`, `reserveArg`, `reserveBytes`, `reserveCallArg`
- `__6Speech`: `dispatch`, `mobile`
- `Promote__Q26Speech7Speaker`: `cont`
- `Activate__Q26Speech15DispatchSpeakeri`: `iVar1`
- `Roger__Q26Speech15DispatchSpeaker`: `ID_CAR`, `ID_UNIT`, `bank`, `invalid`
- `StatusReply__Q26Speech15DispatchSpeaker`: `blocked`, `candidate`, `context`, `from`, `hasBlocker`, `invalid`, `location`, `reverse`, `statusSub`, `wing`
- `Status__Q26Speech15DispatchSpeaker`: `callSign`, `canUpdate`, `engageEntry`, `engageThis`, `fastEnough`, `initialInvalid`, `isCurrentSub`, `nestedDifferent`, `perpDistance`, `perpVf`
- `Status__Q26Speech13MobileSpeaker`: `branchVoice`, `colourArg`, `condition`, `dispatchThis`, `iVar4`, `maskedFlags`, `nearLocation`, `pMVar12`, `pSVar10`, `pa_Var3`, `savedDispatch`, `superBank`, `superReady`, `uVar8`, `vs_KMH_MPH`
- `Report__Q26Speech15DispatchSpeakerP8Car_tObj`: `bank`, `hasSub`, `pursuitCar`, `pursuitLocation`, `speech`
- `Deny__Q26Speech15DispatchSpeaker`: `bank`, `vs_RDBLK_SSTRP`
- `Activate__Q26Speech13MobileSpeakerP8Car_tObj`: `iVar3`
- `FindMobile__6SpeechP8Car_tObj`: `mobile`
- `Report__Q26Speech13MobileSpeakerP8Car_tObj`: `reportCar`, `reportLocation`
- `Engage__Q26Speech13MobileSpeakerP8Car_tObj`: `condition`, `engageCar`, `engageLocation`, `engageSpeed`, `knownEntry`, `knownThis`, `pursuitFlag`, `pursuitReady`, `reacquiredCar`, `repeatReady`, `replyCar`, `replyLocation`, `replyTo`, `reportEntry`, `reportThis`, `sightedCar`, `sightedLocation`, `superFlag`, `superReady`
- `Lose__Q26Speech13MobileSpeaker`: `bank`, `dispatchThis`, `finalDispatch`, `iVar3`, `outOfRange`, `perpCar`, `savedDispatch`, `useLeader`, `voiceArg`
- `RoadBlock__Q26Speech13MobileSpeaker`: `ctx`, `dispatch`
- `SpikeBelt__Q26Speech13MobileSpeaker`: `ctx`, `dispatch`
- `Backup__Q26Speech13MobileSpeaker`: `requestCar`
- `Roger__Q26Speech13MobileSpeaker`: `bank`, `bankBase`, `bankIndex`, `confirmVoice`, `elseBankBase`, `isStatusSub`, `voice`
- `ReportBlockade__Q26Speech13MobileSpeaker`: `DISTANCE`
- `CopSpeak_Play__FP17CopSpeak_tRequesti`: `scaled`
- `CopSpeak_Request__FP17CopSpeak_tRequest`: `head`
- `CopSpeak_PlayNextRequest__Fv`: `iVar3`
- `CopSpeak_Flush__Fv`: `request`
- `CopSpeak_Server__Fv`: `carNoise`
- `GenericPMX_LoadTexture__Fv`: `pmx_height`
- `LocateNextGroupType__15SerializedGroupi`: `zero`
- `LocateGroupType__15SerializedGroupii`: `newLen`
- `Input_Update__Fv`: `activeBase`, `activePtr`, `activeValue`, `addressBlocker`, `addressBlocker2`, `addressBlocker3`, `addressBlocker4`, `addressBlocker5`, `dbFlags`, `interfaceActive`, `one`
- `MPause_ControllerLogic__Fv`: `item`
- `MPause_Logic__Fv`: `newItem`, `oldItem`
- `Newton_AddDamageZone__FP13BO_tNewtonObjiii`: `cappedYVel`, `newYVel`, `result`
- `Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef`: `newWheelAcc`, `wheelY`
- `Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef`: `dsum`, `nx`, `nxq`, `ny`, `nyq`, `nz`, `nz2`, `retreat`, `t3`, `yTemp`
- `Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj`: `aborted`, `quadPt`
- `Object_InitCollisionCheckLoop__FP12BWorldSm_PosP18Object_tSimObjListPi`: `altSlice`
- `Object_CheckCollisionResults__FP18Object_tSimObjListiP13BO_tNewtonObj`: `finishedMulti`
- `__15ObjectMultiAnimP8coorddefP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectP23ObjectFinishedMultiAnim`: `z`
- `Draw__15ObjectMultiAnimP13DRender_tViewP11Draw_DCachei`: `t3`
- `Paths_StartUp__Fv`: `scanFrame`
- `PauseMenu_MenuTextPositioned__Fssss`: `flags`
- `Draw__25tPMenuItemLeftRightChoiceb`: `text`, `textX`
- `ProcessInput__25tPMenuItemLeftRightSliderR13tInputKeyTypeR13tPMenuCommand`: `max`, `value`
- `Draw__25tPMenuItemLeftRightSliderb`: `off`, `packetPtr`
- `tPMenuConstructor__6tPMenuP10tPMenuItemPv`: `offset`
- `CheckForDisabled__6tPMenu`: `disabled`
- `ProcessInput__6tPMenuR13tInputKeyTypeR13tPMenuCommand`: `disabled`
- `Physics_DoBarrierCheck__FP8Car_tObj`: `centerKeep`, `centerX`, `centerY`, `centerZ`, `linearZ`, `positionX`, `positionY`, `positionZ`, `raw1`, `raw2`, `raw3`, `velocityX`, `velocityZ`, `x1raw`, `x3factor`, `x3left`
- `Physics_AutoShift__FP8Car_tObj`: `lastGearOffset`
- `Physics_FixEngineRpm__FP8Car_tObj`: `firstProduct`, `nextMatY`, `nextVelX`, `nextVelY`, `transformedZ`
- `Physics_CalculateCarAcceleration__FP8Car_tObj`: `adjustedDesiredRpm`, `candidateRpm`, `clampedFlywheelRpm`, `currentFlywheelRpm`, `downshiftRedlineRpm`, `revLimitedRpm`, `scaledRatio`
- `Physics_CalcWheelLockAcc__FP8Car_tObjP23Physics_tWheelAccStruct`: `cmp`, `skid`
- `Physics_CalcTractionCircleAcc__FP8Car_tObjP23Physics_tWheelAccStruct`: `gripLossQuotient`, `gripLossRatio`, `roadGripCompare`, `skidValue`, `wheel_reg`
- `Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct`: `cap`, `minSlipAngle`, `xAcc`
- `Physics_CalculateRSControlDesiredPosition__FP8Car_tObjii`: `laneDelta`
- `Physics_Real__FP8Car_tObj`: `adjustedRpm`, `brakeLevel`, `fz`, `gasLevel`, `lm`, `rsControl`, `sumZ`, `wheelMult`
- `R3DCar_Restart__Fv`: `brakeOn`, `gsData`, `headOn`, `numCars`, `ppCVar3`
- `R3DCar_GetCarName__FPcii`: `copIdx`
- `R3DCar_Instantiate3DCar__FP8Car_tObji`: `colorTypeOffset`, `finalIndex`, `loadedSceneColor`, `loadedSceneVRam`, `scaledIndex`, `shape`, `shpfile`, `textureData`
- `R3DCar_Visibilty__FP8Car_tObjP13DRender_tView`: `modeOne`
- `R3DCar_InsertCarFacet__FP8Car_tObjP13DRender_tView`: `copIndex`, `lightFlags`, `lightOff`, `limit`, `positionStep`
- `R3DCar_ReadInCarTextureMenu__FP8Car_tObjPcii`: `sfBase`, `sfp`
- `R3DCar_InsertCarFacetMenu__FP8Car_tObjP13DRender_tView`: `bVar2`, `cancelFile`, `copIndex0`, `copIndex1`, `gf`, `iVar9`, `loadedSceneBase`, `objId`, `pGVar14`, `ppTVar21`, `sVar3`, `slotOff`, `subOtBase`, `subOtOff`, `uVar20`
- `Replay_ResetReplay__Fv`: `pBuf`, `piVar2`
- `Replay_GetInput__Fi`: `counter`, `hasCameras`, `steering`
- `Sim_ProcessSimSchedules__Fv`: `firstSfx`
- `Sim_MainGameLoop__Fv`: `gameSetup`, `one`, `replaySetup`
- `Stats_TrackEndGame__Fv`: `raceCar`, `raceIndex`, `sliceCar`, `sliceTotal`
- `LoadShapesAndMakePmx__FPcP12Draw_tPixMapiii`: `emptyPalNum`, `multiPalCount`
- `Track_AnimateTextures__Fv`: `artPtr`, `negOne`, `pmxIndexPtr`, `simPtr`, `typeEnvMap`, `uvOffset`
- `ReduceObjectPrecision__FP5GroupT0i`: `x`, `y`, `z`
- `Track_Init__FPc`: `dest`, `loadBuf`, `tT33`, `this_00`, `tu3`
- `Track_LoadObjectKillData__Fv`: `groupElements`

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
