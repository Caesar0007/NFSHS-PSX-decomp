# SYM-to-source declaration audit

Target: `C:\Temp\nfs4-decomp\recon\game\common`
Trusted SYM: `C:\Temp\claud\dumpsym_clean\dumpsym_src\nfs4-f-v3.txt`

This is a review queue, not an auto-fix list. Missing retail names are
strong evidence; extra source names can be matching carriers or decompiler
temporaries and must be tested against the function oracle before removal.
GCC-v2-mangled function/EXT names are used only as linkage keys; source
functions are mapped to their demangled C++ names and class scopes.

Strict source-identity mode: matching-only local/global/split-array
carrier annotations do not suppress missing, extra, or array-shape
findings. Carrier receipt categories remain listed for review, not
as original-name proof. Optimized/inline, ABI, canonical, host-only
and explicit type-override categories retain their separate rules
and still require their own evidence. This is not an SLD, foreign
header-interface, source-token, or complete runtime-layout seal.

## Summary

- SYM functions in target TUs: 1258
- Mapped to reconstructed definitions: 1258 (1246 demangled class/name maps)
- Source definitions still using mangled linkage identifiers: 0
- Explicit deleting-destructor ABI carriers: 12
- Explicit cross-TU ownership closures: 0
- Declaration-clean mapped functions: 1085
- Missing SYM names: 0
- Extra source-local names: 474
- Type-comparison findings: 28
- Recognized ABI/debug-equivalent type encodings: 21
  (anonymous-enum-tag=1, generic-function-pointer=3, reference-as-pointer=13, vla-runtime-pointer=4)
- Function storage-class findings: 28
- Implicit aggregate special members (source body correctly absent): 0
- Explicit oracle-receipted carrier mappings: 13
- Explicit restored inline-local mappings: 64
- Explicit restored macro-local mappings: 0
- Explicit compact static-local mappings: 4
- Exact cross-build/canonical name recoveries: 32
- Explicit linkage-proven ABI parameters omitted from SYM: 13
- Explicit source-only codegen carriers: 466
- Explicit oracle-proven function type overrides: 0
- Functions needing mapping review: 0
- SYM object-owned data records in target TUs: 547
- Compact address-only data records mapped by exact name+VA: 372
- Mapped source global definitions: 547
- Special SYM vtable records mapped: 115/115
- Blob-backed object globals: 0
- Missing/extra global definitions: 0/22
- Global storage-class findings: 0
- Explicit oracle-proven global storage overrides: 0
- Global type findings: 0
- Recognized global debug-equivalent types: 3
  (anonymous-struct-tag=1, explicit-signed-char=2)
- Explicit measured global array carriers: 0
- Explicit source-only global/data-layout carriers: 22
- Explicit host-only fallback globals: 0
- Explicit linker-folded shared common globals: 0
- Explicit oracle-proven global type overrides: 0

## Review queue

### `AIHigh_StartUp__Fv` (0x8005ad94, aihigh.cpp:45, map=exact)

- Extra source locals: `carFlags`, `copCarFlag`, `newHigh`, `slot`

### `AIHigh_Execute__Fv` (0x8005b210, aihigh.cpp:280, map=exact)

- Extra source locals: `bVar1`

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

### `CheckForCrimes__16AIHigh_BasicPerp` (0x8005b500, aih_basicperp.cpp:21, map=exact)

- Extra source locals: `speed`, `wrongWay`

### `RemoveChaser__16AIHigh_BasicPerpii7copType` (0x8005becc, aih_basicperp.cpp:400, map=exact)

- Extra source locals: `piBase`, `piVar2`

### `AddChaser__16AIHigh_BasicPerpii7copType` (0x8005bf08, aih_basicperp.cpp:443, map=exact)

- Extra source locals: `piVar2`

### `CheckSpikeBelt__15AIHigh_BasicCop` (0x8005c1ec, aih_basiccop.cpp:64, map=exact)

- Extra source locals: `freshenElapsed`

### `_._15AIHigh_BasicCop` (0x8005cb4c, aihigh.h:588, map=header-owner)

- Storage: SYM STAT vs source EXT

### `FindRandomBarrierFreeArea__19AIHigh_BTC_HumanCopiii` (0x8005d150, aih_btccop.cpp:449, map=exact)

- Extra source locals: `doubledFraction`

### `NewStage__19AIHigh_BTC_HumanCopiii` (0x8005d650, aih_btccop.cpp:785, map=exact)

- Extra source locals: `laneBits`, `leftWidth`, `limitL`, `limitR`

### `UpdateFreezeModeAndPullOverMode__19AIHigh_BTC_HumanCop` (0x8005dad4, aih_btccop.cpp:1094, map=exact)

- Extra source locals: `startingDirection`

### `HighExecute__18AIHigh_BTC_Wingman` (0x8005e33c, aih_btccop.cpp:2503, map=exact)

- Extra source locals: `minLatMetersDistance`, `minLongMetersDistance`, `minTimeInZone`, `murder`, `speed`

### `UpdateFreezeModeAndPullOverMode__18AIHigh_BTC_Wingman` (0x8005eef8, aih_btccop.cpp:3055, map=exact)

- Extra source locals: `oldFreezeMode`

### `SetupWingman__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCop` (0x8005ef38, aih_btccop.cpp:3092, map=exact)

- Extra source locals: `sideTimes28`

### `SetupBlockader__18AIHigh_BTC_WingmanP19AIHigh_BTC_HumanCopi` (0x8005f074, aih_btccop.cpp:3177, map=exact)

- Extra source locals: `beltSlice`, `blockadeDirection`, `blockadeFlags`, `blockadeSlice`, `initSliceCandidate`, `initializationSliceDistance`, `maximumDistance`, `numSlices`, `perpDistance`, `sliceOffset`

### `Execute__17AIState_NonActive` (0x8005f624, aistate.h:3660, map=header-owner)

- Storage: SYM STAT vs source EXT

### `_._17AIState_NonActive` (0x8005f62c, aistate.h:3666, map=header-owner)

- Storage: SYM STAT vs source EXT

### `TestForRelease__12AIState_Base` (0x8005f678, aistate.h:3675, map=header-owner-va-copy)

- Storage: SYM STAT vs source EXT

### `_._12AIState_Base` (0x8005f680, aistate.h:3684, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Storage: SYM STAT vs source EXT

### `IsFalseArrest__15AIHigh_BTC_Perp` (0x8005f798, aih_btcperp.cpp:129, map=exact)

- Extra source locals: `dotTerm`, `dotTerm2`

### `HandlePullOver__15AIHigh_BTC_Perp` (0x8005fa58, aih_btcperp.cpp:306, map=exact)

- Extra source locals: `activationCopReady`, `caught`, `gameTicks`, `mobileSpeaker`

### `CheckForActivation__15AIHigh_BTC_Perp` (0x8005ff74, aih_btcperp.cpp:643, map=exact)

- Extra source locals: `activationRequested`

### `NewStage__20AIHigh_BTC_HumanPerpP19AIHigh_BTC_HumanCop` (0x8006007c, aih_btcperp.cpp:722, map=exact)

- Extra source locals: `carObj`, `wrappedSlice`

### `CalculateTimeTillContact__17AIHigh_BTC_AIPerp` (0x80060710, aih_btcperp.cpp:1138, map=exact)

- Extra source locals: `copDistance`

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

### `CheckIfABlockadeCanBeSetup__13AIHigh_Player` (0x80061400, aih_play.cpp:87, map=exact)

- Extra source locals: `cannotSetup`, `chaseInfo`, `type`

### `SetupBlockade__13AIHigh_Player` (0x80061784, aih_play.cpp:198, map=exact)

- Extra source locals: `bVar2`, `chaseInfo`, `distance`, `lastSlice`, `manager`, `one`

### `CheckForNewLevel__13AIHigh_Playeri` (0x8006220c, aih_play.cpp:635, map=exact)

- Extra source locals: `doIt`

### `MaintainAvailableCops__13AIHigh_Player` (0x80062638, aih_play.cpp:844, map=exact)

- Extra source locals: `available`, `pInfo`

### `__13AIHigh_PlayerP8Car_tObj` (0x800628c0, aih_play.cpp:950, map=exact)

- Extra source locals: `chaseIndex`, `copGameInfoCopy`, `levels`, `pInfo`, `pInfo3`

### `HandleCops__13AIHigh_Player` (0x80062ac4, aih_play.cpp:1084, map=exact)

- Extra source locals: `pInfo`, `prodSlipYawNeg`

### `HandlePullOver__13AIHigh_Player` (0x80062d7c, aih_play.cpp:1235, map=exact)

- Extra source locals: `bVar1`, `chaseInfo`

### `_._13AIHigh_Player` (0x80063248, aihigh.h:1347, map=header-owner)

- Storage: SYM STAT vs source EXT

### `CheckForWipeOut__15AIHigh_Opponent` (0x80063308, aih_opp.cpp:23, map=exact)

- Extra source locals: `absField`, `bVar1`, `carIndex`, `field1380`, `hlai`, `numRacers`, `slotAddr`, `speedLimit`, `state`

### `HighExecute__10AIHigh_Cop` (0x80063cc4, aih_cop.cpp:318, map=exact)

- Extra source locals: `aihCopFlagsBoundary_`, `blockLevel`, `carObj`, `chaseTarget`, `co`, `copChasers`, `cutOff`, `dir`, `distance`, `meters`, `murder`, `needy`, `one`, `retarget`, `rev`, `speed`, `targetLevel`, `wrongWayHit`

### `CheckForWipeOut__10AIHigh_Cop` (0x80065430, aih_cop.cpp:1617, map=exact)

- Extra source locals: `skipWipeOut`

### `CheckForNewTarget__10AIHigh_Cop` (0x800655a8, aih_cop.cpp:1718, map=exact)

- Extra source locals: `blockadeActive`

### `CheckForNewTriggers__10AIHigh_Cop` (0x80065944, aih_cop.cpp:1985, map=exact)

- Extra source locals: `perpInfo`

### `HighExecute__14AIHigh_Traffic` (0x80065e6c, aih_traf.cpp:171, map=exact)

- Extra source locals: `release`

### `AIPerson_LoadPersonalityData__FP10Udff_tInfo` (0x80068b60, aiperson.cpp:93, map=exact)

- Extra source locals: `copCollisionFirmness`

### `AIPhysic_RevEngine__FP8Car_tObj` (0x800692fc, aiphysic.cpp:64, map=exact)

- Extra source locals: `deadfrm`

### `AIPhysic_HandleWipeoutTimer__FP8Car_tObj` (0x80069af0, aiphysic.cpp:426, map=exact)

- Extra source locals: `limit`

### `AIPhysic_OutOfControlPhysics__FP8Car_tObj` (0x8006b400, aiphysic.cpp:1066, map=exact)

- Extra source locals: `cfg`, `latvelcalcLookahead`

### `AIPhysic_GetRearEndDamageFactor__FP8Car_tObj` (0x8006ba70, aiphysic.cpp:1416, map=exact)

- Extra source locals: `result`

### `AIPhysic_ChangeDirection__FP8Car_tObji` (0x8006c9f0, aiphysic.cpp:1855, map=exact)

- Extra source locals: `rampPos`, `sg`

### `Get__26AIDataRecord_CarTracking_ti` (0x8006d50c, aidatarecord.h:276, map=header-owner)

- Storage: SYM STAT vs source EXT

### `_._26AIDataRecord_CarTracking_t` (0x8006d514, aidatarecord.h:286, map=header-owner)

- Storage: SYM STAT vs source EXT

### `_._30AIDataRecord_CurveSpeedTable_t` (0x8006d534, aidatarecord.h:295, map=header-owner)

- Storage: SYM STAT vs source EXT

### `_._25AIDataRecord_TrackCurve_t` (0x8006d554, aidatarecord.h:304, map=header-owner)

- Storage: SYM STAT vs source EXT

### `_._23AIDataRecord_BestLine_t` (0x8006d574, aidatarecord.h:313, map=header-owner)

- Storage: SYM STAT vs source EXT

### `AISpeeds_BTCGetGlueFactor__FP8Car_tObj` (0x8006e09c, aispeeds.cpp:397, map=exact)

- Extra source locals: `clampedGlueIndex`

### `AIScript_ProcessActionsAndReactions__FP10AIScript_ti` (0x8006f7f0, aiscript.cpp:68, map=exact)

- Extra source locals: `new_var`, `new_var2`, `one`, `seven`, `two`

### `__13AIState_ChaseP8Car_tObjT1P8coorddefiiiii` (0x8006fbfc, aistate.cpp:314, map=exact)

- Extra source locals: `direction`, `reverseDirCheck`

### `SetUp__13AIState_Chase` (0x8006fe98, aistate.cpp:530, map=exact)

- Extra source locals: `dc`, `iVar2`

### `Execute__13AIState_Chase` (0x8007015c, aistate.cpp:717, map=exact)

- Extra source locals: `lmAbs`

### `CloseTargeting__13AIState_Chase` (0x80070408, aistate.cpp:919, map=exact)

- Extra source locals: `latBias`, `latOffset`, `limit`, `t`

### `ApproachTargeting__13AIState_Chasei` (0x800708b8, aistate.cpp:1182, map=exact)

- Extra source locals: `iVar5`, `pCVar4`

### `Execute__15AIState_Offroad` (0x800712e0, aistate.cpp:1801, map=exact)

- Extra source locals: `iVar4`

### `_._17AIState_Purgatory` (0x8007163c, aistate.cpp:1954, map=exact)

- Extra source locals: `ppCVar3`, `sortedList`

### `Execute__21AIState_RovingTraffic` (0x80071a68, aistate.cpp:2303, map=exact)

- Extra source locals: `iVar8`, `iVar9`

### `Execute__14AIState_Donuts` (0x80071e70, aistate.cpp:2468, map=exact)

- Extra source locals: `carObj`

### `Execute__17AIState_GotoSlice` (0x800723c0, aistate.cpp:2678, map=exact)

- Extra source locals: `carObj`, `desiredSpeed`, `inRange`, `limit`

### `Execute__17AIState_NonActive` (0x80072750, aistate.h:3013, map=header-owner-va-copy)

- Storage: SYM STAT vs source EXT

### `_._17AIState_NonActive` (0x80072758, aistate.h:3034, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Storage: SYM STAT vs source EXT

### `TestForRelease__12AIState_Base` (0x80072830, aistate.h:3116, map=header-owner-va-copy)

- Storage: SYM STAT vs source EXT

### `_._12AIState_Base` (0x80072838, aistate.h:3139, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Storage: SYM STAT vs source EXT

### `AudioCmn_LoadAsyncSfx__FiiPvi` (0x8007675c, audiocmn.cpp:299, map=exact)

- Extra source locals: `s`

### `AudioCmn_Init__Fv` (0x80076a74, audiocmn.cpp:399, map=exact)

- Extra source locals: `ambient`, `mystic`, `setup`

### `AudioCmn_PlaySFX__Fiiiiii` (0x800783cc, audiocmn.cpp:1389, map=exact)

- Extra source locals: `bbase`, `chbase`, `lookup`, `nbase`, `pan`, `pbase`, `pch`, `r`, `slot`

### `AudioCmn_SoundCar__FP8Car_tObjiiiiiii` (0x800788bc, audiocmn.cpp:1586, map=exact)

- Extra source locals: `attenuation`, `distanceScale`, `roadProduct`, `rpmRatio`, `scaledAmplitude`, `tunnelFlag`

### `AudioEng_StartUp__FiPc` (0x8007be54, audioeng.cpp:312, map=exact)

- Extra source locals: `chanbase`

### `AudioEng_CleanUp__Fv` (0x8007c534, audioeng.cpp:568, map=exact)

- Extra source locals: `player`

### `AudioTrk_Reset__Fv` (0x8007c614, audiotrk.cpp:22, map=exact)

- Extra source locals: `se`

### `BWorld_CheckChunkVisible__FP12BWorldSm_PosT0` (0x8007dc14, bworld.cpp:392, map=exact)

- Extra source locals: `chunkIndBwd`, `chunkIndFwd`

### `BWorld_OnyxBuildFacets__FP13DRender_tView` (0x8007e0f4, bworld.cpp:893, map=exact)

- Extra source locals: `ts`

### `BWorld_Init__Fv` (0x8007e5c8, bworld.cpp:1084, map=exact)

- Extra source locals: `random`

### `Camera_UpdateTailCam__Fii` (0x80080d84, camera.cpp:260, map=exact)

- Extra source locals: `armPtr`, `armY`, `ax`, `first`, `flip`, `lookBehindBase`, `offset`, `rev`, `second`, `slices`, `z`

### `Camera_UpdateHeliCam__Fii` (0x800813cc, camera.cpp:591, map=exact)

- Extra source locals: `armY`, `ax`, `rev`, `second`, `z`

### `SetCameraZoom__Fii` (0x80081d38, camera.cpp:864, map=exact)

- Extra source locals: `gs`

### `Camera_UpdateTVCam__Fi` (0x80081e48, camera.cpp:896, map=exact)

- Extra source locals: `clampedHeight`, `lastIndex`

### `Camera_UpdateAnimCam__Fi` (0x80081f94, camera.cpp:945, map=exact)

- Extra source locals: `cVar1`, `cVar4`

### `Camera_UpdateSplineCam__Fi` (0x800826c0, camera.cpp:1244, map=exact)

- Extra source locals: `d`, `halfSlices`, `newSlice`, `nextSliceIdx`, `rotBase`

### `Camera_UpdatePulloverCam__Fi` (0x80082c94, camera.cpp:1435, map=exact)

- Extra source locals: `gameTicks`, `side`

### `Camera_Update__Fv` (0x800833d8, camera.cpp:1588, map=exact)

- Extra source locals: `bitsInfo`, `cameraBase`, `collisionPlayer`, `inCarMask`, `isInCar`, `modeBits`, `rotationBase`

### `Camera_AcquireTarget__FiP8coorddefT1P10matrixtdefi` (0x80084898, camera.cpp:2184, map=exact)

- Extra source locals: `adj`

### `Camera_NextMode__Fi` (0x8008581c, camera.cpp:2496, map=exact)

- Extra source locals: `modeForRange`, `splitBase`

### `Cars_DoExtraCarCollisionProcessing__FP8Car_tObj` (0x80086b38, cars.cpp:477, map=exact)

- Extra source locals: `player`

### `Car_DoPostCollisionStuff__FP8Car_tObj` (0x800898dc, cars.cpp:1395, map=exact)

- Extra source locals: `absRoll`, `clampCond`, `rideOffsetVal`, `roundedGV`

### `InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem` (0x8008b3fc, chunk.cpp:28, map=exact)

- Extra source locals: `groupData`, `quadData`

### `Clock_MasterInterruptHandler__Fv` (0x8008b938, clock.cpp:27, map=exact)

- Extra source locals: `even128`

### `Collide_DoActualObjectCollisionCheck__FP13BO_tNewtonObjT0P8coorddefT2` (0x8008f550, collide.cpp:841, map=exact)

- Extra source locals: `selectedRange`

### `Collide_TestObjectVertices__FP13BO_tNewtonObjT0P8coorddefT2` (0x80090144, collide.cpp:1215, map=exact)

- Extra source locals: `rpx`, `rpz`

### `Collide_ClearCollisionRegistry__Fv` (0x800914d4, collide.cpp:1653, map=exact)

- Extra source locals: `n`

### `Control_Human__FP8Car_tObj` (0x80091fe4, control.cpp:18, map=exact)

- Extra source locals: `lights`

### `Distance__Q26Speech12LocationBanki` (0x8009486c, speech.cpp:283, map=exact)

- Extra source locals: `backward`, `end`, `forward`, `start`

### `FindLocation__Q26Speech7SpeakerP8Car_tObj` (0x800949d8, speech.cpp:363, map=exact)

- Extra source locals: `advance`, `offset`

### `LoadBankHeaders__6SpeechPcPQ26Speech11CarBankNamell` (0x800951bc, speech.cpp:675, map=exact)

- Extra source locals: `alignment`, `dataSize`, `extension`, `isheader`, `reserveArg`, `reserveBytes`, `reserveCallArg`

### `__6Speech` (0x800955f4, speech.cpp:839, map=exact)

- Extra source locals: `dispatch`, `mobile`

### `Promote__Q26Speech7Speaker` (0x80095d8c, speech.cpp:1178, map=exact)

- Extra source locals: `cont`

### `Activate__Q26Speech15DispatchSpeakeri` (0x80095e54, speech.cpp:1220, map=exact)

- Extra source locals: `iVar1`

### `Roger__Q26Speech15DispatchSpeaker` (0x80095f28, speech.cpp:1264, map=exact)

- Extra source locals: `ID_CAR`, `ID_UNIT`, `bank`, `invalid`

### `StatusReply__Q26Speech15DispatchSpeaker` (0x8009619c, speech.cpp:1363, map=exact)

- Extra source locals: `blocked`, `candidate`, `context`, `from`, `hasBlocker`, `invalid`, `location`, `reverse`, `statusSub`, `wing`

### `Status__Q26Speech15DispatchSpeaker` (0x800965d0, speech.cpp:1645, map=exact)

- Extra source locals: `callSign`, `canUpdate`, `engageEntry`, `engageThis`, `fastEnough`, `initialInvalid`, `isCurrentSub`, `nestedDifferent`, `perpDistance`, `perpVf`

### `Status__Q26Speech13MobileSpeaker` (0x80096b88, speech.cpp:1857, map=exact)

- Extra source locals: `branchVoice`, `colourArg`, `condition`, `dispatchThis`, `iVar4`, `maskedFlags`, `nearLocation`, `pMVar12`, `pSVar10`, `pa_Var3`, `savedDispatch`, `superBank`, `superReady`, `uVar8`, `vs_KMH_MPH`

### `Report__Q26Speech15DispatchSpeakerP8Car_tObj` (0x800971b0, speech.cpp:2268, map=exact)

- Extra source locals: `bank`, `hasSub`, `pursuitCar`, `pursuitLocation`, `speech`

### `Deny__Q26Speech15DispatchSpeaker` (0x80097358, speech.cpp:2351, map=exact)

- Extra source locals: `bank`, `vs_RDBLK_SSTRP`

### `Activate__Q26Speech13MobileSpeakerP8Car_tObj` (0x80097620, speech.cpp:2463, map=exact)

- Extra source locals: `iVar3`

### `FindMobile__6SpeechP8Car_tObj` (0x800977b8, speech.cpp:2530, map=exact)

- Extra source locals: `mobile`

### `Report__Q26Speech13MobileSpeakerP8Car_tObj` (0x80097bfc, speech.cpp:2642, map=exact)

- Extra source locals: `reportCar`, `reportLocation`

### `Engage__Q26Speech13MobileSpeakerP8Car_tObj` (0x80097ce8, speech.cpp:2678, map=exact)

- Extra source locals: `condition`, `engageCar`, `engageLocation`, `engageSpeed`, `knownEntry`, `knownThis`, `pursuitFlag`, `pursuitReady`, `reacquiredCar`, `repeatReady`, `replyCar`, `replyLocation`, `replyTo`, `reportEntry`, `reportThis`, `sightedCar`, `sightedLocation`, `superFlag`, `superReady`

### `Lose__Q26Speech13MobileSpeaker` (0x80098434, speech.cpp:2959, map=exact)

- Extra source locals: `bank`, `dispatchThis`, `finalDispatch`, `iVar3`, `outOfRange`, `perpCar`, `savedDispatch`, `useLeader`, `voiceArg`

### `RoadBlock__Q26Speech13MobileSpeaker` (0x80098a4c, speech.cpp:3220, map=exact)

- Extra source locals: `ctx`, `dispatch`

### `SpikeBelt__Q26Speech13MobileSpeaker` (0x80098b60, speech.cpp:3261, map=exact)

- Extra source locals: `ctx`, `dispatch`

### `Backup__Q26Speech13MobileSpeaker` (0x80098c74, speech.cpp:3302, map=exact)

- Extra source locals: `requestCar`

### `Roger__Q26Speech13MobileSpeaker` (0x80098d6c, speech.cpp:3350, map=exact)

- Extra source locals: `bank`, `bankBase`, `bankIndex`, `confirmVoice`, `elseBankBase`, `isStatusSub`, `voice`

### `ReportBlockade__Q26Speech13MobileSpeaker` (0x8009916c, speech.cpp:3504, map=exact)

- Extra source locals: `DISTANCE`

### `CopSpeak_Play__FP17CopSpeak_tRequesti` (0x8009a304, copspeak.cpp:595, map=exact)

- Extra source locals: `scaled`

### `CopSpeak_Request__FP17CopSpeak_tRequest` (0x8009a4c8, copspeak.cpp:676, map=exact)

- Extra source locals: `head`

### `CopSpeak_Server__Fv` (0x8009a994, copspeak.cpp:860, map=exact)

- Extra source locals: `carNoise`

### `GenericPMX_LoadTexture__Fv` (0x8009b458, genericpmx.cpp:41, map=exact)

- Extra source locals: `pmx_height`

### `Input_Update__Fv` (0x8009c478, input.cpp:106, map=exact)

- Extra source locals: `activeBase`, `activePtr`, `activeValue`, `addressBlocker`, `addressBlocker2`, `addressBlocker3`, `addressBlocker4`, `addressBlocker5`, `dbFlags`, `interfaceActive`, `one`

### `MPause_Logic__Fv` (0x8009e784, mpause.cpp:226, map=exact)

- Extra source locals: `newItem`, `oldItem`

### `Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef` (0x8009ff80, newton.cpp:602, map=exact)

- Extra source locals: `newWheelAcc`, `wheelY`

### `Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef` (0x800a2af0, newton.cpp:1803, map=exact)

- Extra source locals: `dsum`, `nx`, `nxq`, `ny`, `nyq`, `nz`, `nz2`, `retreat`, `t3`, `yTemp`

### `Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj` (0x800a2e84, newton.cpp:2531, map=exact)

- Extra source locals: `aborted`, `quadPt`

### `NFS3_CheckForFileOperations__Fv` (0x800a46dc, nfs3.cpp:355, map=exact)

- Extra source locals: `e`

### `Object_InitCollisionCheckLoop__FP12BWorldSm_PosP18Object_tSimObjListPi` (0x800a4cfc, object.cpp:164, map=exact)

- Extra source locals: `altSlice`

### `Object_CheckCollisionResults__FP18Object_tSimObjListiP13BO_tNewtonObj` (0x800a52f0, object.cpp:411, map=exact)

- Extra source locals: `finishedMulti`

### `__15ObjectMultiAnimP8coorddefP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectP23ObjectFinishedMultiAnim` (0x800a6200, object.cpp:1005, map=exact)

- Extra source locals: `z`

### `Draw__15ObjectMultiAnimP13DRender_tViewP11Draw_DCachei` (0x800a62f8, object.cpp:1044, map=exact)

- Extra source locals: `t3`

### `_._10ObjectAnim` (0x800a6de0, object.h:1344, map=header-owner)

- Storage: SYM STAT vs source EXT

### `Paths_StartUp__Fv` (0x800a6e14, paths.cpp:17, map=exact)

- Extra source locals: `scanFrame`

### `Draw__25tPMenuItemLeftRightChoiceb` (0x800a7650, pausemenu.cpp:466, map=exact)

- Extra source locals: `text`, `textX`

### `ProcessInput__25tPMenuItemLeftRightSliderR13tInputKeyTypeR13tPMenuCommand` (0x800a78ac, pausemenu.cpp:550, map=exact)

- Extra source locals: `max`, `value`

### `Draw__25tPMenuItemLeftRightSliderb` (0x800a79c8, pausemenu.cpp:664, map=exact)

- Extra source locals: `off`, `packetPtr`

### `tPMenuConstructor__6tPMenuP10tPMenuItemPv` (0x800a7f7c, pausemenu.cpp:903, map=exact)

- Extra source locals: `offset`

### `CheckForDisabled__6tPMenu` (0x800a8194, pausemenu.cpp:997, map=exact)

- Extra source locals: `disabled`

### `ProcessInput__6tPMenuR13tInputKeyTypeR13tPMenuCommand` (0x800a829c, pausemenu.cpp:1034, map=exact)

- Extra source locals: `disabled`

### `Physics_DoBarrierCheck__FP8Car_tObj` (0x800a94b8, physics.cpp:427, map=exact)

- Extra source locals: `centerKeep`, `centerX`, `centerY`, `centerZ`, `linearZ`, `positionX`, `positionY`, `positionZ`, `raw1`, `raw2`, `raw3`, `velocityX`, `velocityZ`, `x1raw`, `x3factor`, `x3left`

### `Physics_AutoShift__FP8Car_tObj` (0x800a9a50, physics.cpp:727, map=exact)

- Extra source locals: `lastGearOffset`

### `Physics_FixEngineRpm__FP8Car_tObj` (0x800aa4e4, physics.cpp:1068, map=exact)

- Extra source locals: `firstProduct`, `nextMatY`, `nextVelX`, `nextVelY`, `transformedZ`

### `Physics_CalculateCarAcceleration__FP8Car_tObj` (0x800aa984, physics.cpp:1303, map=exact)

- Extra source locals: `adjustedDesiredRpm`, `candidateRpm`, `clampedFlywheelRpm`, `currentFlywheelRpm`, `downshiftRedlineRpm`, `revLimitedRpm`, `scaledRatio`

### `Physics_CalcWheelLockAcc__FP8Car_tObjP23Physics_tWheelAccStruct` (0x800ab49c, physics.cpp:1628, map=exact)

- Extra source locals: `cmp`, `skid`

### `Physics_CalcTractionCircleAcc__FP8Car_tObjP23Physics_tWheelAccStruct` (0x800ab698, physics.cpp:1732, map=exact)

- Extra source locals: `gripLossQuotient`, `gripLossRatio`, `roadGripCompare`, `skidValue`, `wheel_reg`

### `Physics_CalculateTireForces__FP8Car_tObjP23Physics_tWheelAccStruct` (0x800aba3c, physics.cpp:1849, map=exact)

- Extra source locals: `cap`, `minSlipAngle`, `xAcc`

### `Physics_CalculateRSControlDesiredPosition__FP8Car_tObjii` (0x800abfa4, physics.cpp:2057, map=exact)

- Extra source locals: `laneDelta`

### `Physics_Real__FP8Car_tObj` (0x800ac164, physics.cpp:2130, map=exact)

- Extra source locals: `adjustedRpm`, `brakeLevel`, `fz`, `gasLevel`, `lm`, `rsControl`, `sumZ`, `wheelMult`

### `R3DCar_Restart__Fv` (0x800adec8, r3dcar.cpp:166, map=exact)

- Extra source locals: `brakeOn`, `gsData`, `headOn`, `numCars`, `ppCVar3`

### `R3DCar_GetCarName__FPcii` (0x800aee98, r3dcar.cpp:600, map=exact)

- Extra source locals: `copIdx`

### `R3DCar_Instantiate3DCar__FP8Car_tObji` (0x800aef2c, r3dcar.cpp:620, map=exact)

- Extra source locals: `colorTypeOffset`, `finalIndex`, `loadedSceneColor`, `loadedSceneVRam`, `scaledIndex`, `shape`, `shpfile`, `textureData`

### `R3DCar_Visibilty__FP8Car_tObjP13DRender_tView` (0x800af74c, r3dcar.cpp:897, map=exact)

- Extra source locals: `modeOne`

### `R3DCar_InsertCarFacet__FP8Car_tObjP13DRender_tView` (0x800afbd0, r3dcar.cpp:1064, map=exact)

- Extra source locals: `copIndex`, `lightFlags`, `lightOff`, `limit`, `positionStep`

### `R3DCar_ReadInCarTextureMenu__FP8Car_tObjPcii` (0x800b0db0, r3dcar.cpp:1772, map=exact)

- Extra source locals: `sfBase`, `sfp`

### `R3DCar_InsertCarFacetMenu__FP8Car_tObjP13DRender_tView` (0x800b10fc, r3dcar.cpp:1883, map=exact)

- Extra source locals: `bVar2`, `cancelFile`, `copIndex0`, `copIndex1`, `gf`, `iVar9`, `loadedSceneBase`, `objId`, `pGVar14`, `ppTVar21`, `sVar3`, `slotOff`, `subOtBase`, `subOtOff`, `uVar20`

### `Replay_ResetReplay__Fv` (0x800b3f44, replay.cpp:194, map=exact)

- Extra source locals: `piVar2`

### `Replay_GetInput__Fi` (0x800b4b38, replay.cpp:360, map=exact)

- Extra source locals: `hasCameras`, `steering`

### `Sim_ProcessSimSchedules__Fv` (0x800b6878, sim.cpp:168, map=exact)

- Extra source locals: `firstSfx`

### `Sim_MainGameLoop__Fv` (0x800b6d4c, sim.cpp:339, map=exact)

- Extra source locals: `gameSetup`, `one`, `replaySetup`

### `Stats_TrackEndGame__Fv` (0x800b8db8, stats.cpp:822, map=exact)

- Extra source locals: `raceCar`, `raceIndex`, `sliceCar`, `sliceTotal`

### `LoadShapesAndMakePmx__FPcP12Draw_tPixMapiii` (0x800b942c, track.cpp:129, map=exact)

- Extra source locals: `emptyPalNum`, `multiPalCount`

### `Track_AnimateTextures__Fv` (0x800b99dc, track.cpp:328, map=exact)

- Extra source locals: `artPtr`, `negOne`, `pmxIndexPtr`, `simPtr`, `typeEnvMap`, `uvOffset`

### `ReduceObjectPrecision__FP5GroupT0i` (0x800ba25c, track.cpp:634, map=exact)

- Extra source locals: `x`, `y`, `z`

### `Track_Init__FPc` (0x800ba808, track.cpp:840, map=exact)

- Extra source locals: `dest`, `loadBuf`, `tT33`, `this_00`, `tu3`

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
- `ReduceObjectPrecision__FP5GroupT0i`: `this` from `GetNumElements`
- `InvalidatePersistentCollideBoomObjects__FP5GroupT0`: `this` from `GetNumElements`
- `CalcObjectBoundingSphere__FP5GroupT0`: `this` from `GetData`
- `Track_LoadObjectKillData__Fv`: `this` from `GetData`, `this` from `GetData`, `this` from `GetNumElements`, `this` from `GetNumElements`

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
- `AudioClc_GetClosestCars__Fiii`: `view`
- `AudioCmn_PlaySFX__Fiiiiii`: `bankNum`
- `SetupChunkBuildList__FP13DRender_tView`: `chunkViewList`
- `BWorldSm_FindClosestSlice__FP8coorddefP12BWorldSm_Pos`: `sliceChanged`
- `GetStmQuadPts__FP12BWorldSm_PosP8coorddef`: `vertices`
- `FindClosestQuad__FP8coorddefP12BWorldSm_Pos`: `sliceChanged`
- `Cars_Restart__Fv`: `carObj`
- `CopSpeak_PlayNextRequest__Fv`: `next`
- `PauseMenu_MenuTextPositioned__Fssss`: `flags`
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
- `AIPhysic_RevEngine__FP8Car_tObj`: `deadfrm`
- `AIPhysic_HandleWipeoutTimer__FP8Car_tObj`: `limit`
- `AIPhysic_OutOfControlPhysics__FP8Car_tObj`: `cfg`, `latvelcalcLookahead`
- `AIPhysic_GetRearEndDamageFactor__FP8Car_tObj`: `result`
- `AIPhysic_ChangeDirection__FP8Car_tObji`: `rampPos`, `sg`
- `AISpeeds_BTCGetGlueFactor__FP8Car_tObj`: `clampedGlueIndex`
- `AIScript_ProcessActionsAndReactions__FP10AIScript_ti`: `new_var`, `new_var2`, `one`, `seven`, `two`
- `__13AIState_ChaseP8Car_tObjT1P8coorddefiiiii`: `direction`, `reverseDirCheck`
- `SetUp__13AIState_Chase`: `dc`, `iVar2`
- `Execute__13AIState_Chase`: `lmAbs`
- `CloseTargeting__13AIState_Chase`: `latBias`, `latOffset`, `limit`, `t`
- `ApproachTargeting__13AIState_Chasei`: `iVar5`, `pCVar4`
- `Execute__15AIState_Offroad`: `iVar4`
- `_._17AIState_Purgatory`: `ppCVar3`, `sortedList`
- `Execute__21AIState_RovingTraffic`: `iVar8`, `iVar9`
- `Execute__14AIState_Donuts`: `carObj`
- `Execute__17AIState_GotoSlice`: `carObj`, `desiredSpeed`, `inRange`, `limit`
- `AudioCmn_LoadAsyncSfx__FiiPvi`: `s`
- `AudioCmn_Init__Fv`: `ambient`, `mystic`, `setup`
- `AudioCmn_PlaySFX__Fiiiiii`: `bbase`, `chbase`, `lookup`, `nbase`, `pan`, `pbase`, `pch`, `r`, `slot`
- `AudioCmn_SoundCar__FP8Car_tObjiiiiiii`: `attenuation`, `distanceScale`, `roadProduct`, `rpmRatio`, `scaledAmplitude`, `tunnelFlag`
- `AudioEng_StartUp__FiPc`: `chanbase`
- `AudioEng_CleanUp__Fv`: `player`
- `BWorld_CheckChunkVisible__FP12BWorldSm_PosT0`: `chunkIndBwd`, `chunkIndFwd`
- `BWorld_OnyxBuildFacets__FP13DRender_tView`: `ts`
- `BWorld_Init__Fv`: `random`
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
- `Car_DoPostCollisionStuff__FP8Car_tObj`: `absRoll`, `clampCond`, `rideOffsetVal`, `roundedGV`
- `InstanceGroup__5ChunkP15SerializedGroupP9SimpleMem`: `groupData`, `quadData`
- `Clock_MasterInterruptHandler__Fv`: `even128`
- `Collide_DoActualObjectCollisionCheck__FP13BO_tNewtonObjT0P8coorddefT2`: `selectedRange`
- `Collide_TestObjectVertices__FP13BO_tNewtonObjT0P8coorddefT2`: `rpx`, `rpz`
- `Collide_ClearCollisionRegistry__Fv`: `n`
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
- `CopSpeak_Server__Fv`: `carNoise`
- `Input_Update__Fv`: `activeBase`, `activePtr`, `activeValue`, `addressBlocker`, `addressBlocker2`, `addressBlocker3`, `addressBlocker4`, `addressBlocker5`, `dbFlags`, `interfaceActive`, `one`
- `MPause_Logic__Fv`: `newItem`, `oldItem`
- `Newton_FindGroundElevationAndNormal__FP13BO_tNewtonObjP8coorddef`: `newWheelAcc`, `wheelY`
- `Newton_DoPostBarrierCollisionHandling__FP13BO_tNewtonObjG8coorddef`: `dsum`, `nx`, `nxq`, `ny`, `nyq`, `nz`, `nz2`, `retreat`, `t3`, `yTemp`
- `Newton_TestForUndrivableSurfaces__FP13BO_tNewtonObj`: `aborted`, `quadPt`
- `Object_InitCollisionCheckLoop__FP12BWorldSm_PosP18Object_tSimObjListPi`: `altSlice`
- `Object_CheckCollisionResults__FP18Object_tSimObjListiP13BO_tNewtonObj`: `finishedMulti`
- `__15ObjectMultiAnimP8coorddefP7AnimDefP19Trk_CollideBoomInstP13Trk_ObjectDefP13Trk_SimObjectP23ObjectFinishedMultiAnim`: `z`
- `Draw__15ObjectMultiAnimP13DRender_tViewP11Draw_DCachei`: `t3`
- `Paths_StartUp__Fv`: `scanFrame`
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
- `Replay_ResetReplay__Fv`: `piVar2`
- `Replay_GetInput__Fi`: `hasCameras`, `steering`
- `Sim_ProcessSimSchedules__Fv`: `firstSfx`
- `Sim_MainGameLoop__Fv`: `gameSetup`, `one`, `replaySetup`
- `Stats_TrackEndGame__Fv`: `raceCar`, `raceIndex`, `sliceCar`, `sliceTotal`
- `LoadShapesAndMakePmx__FPcP12Draw_tPixMapiii`: `emptyPalNum`, `multiPalCount`
- `Track_AnimateTextures__Fv`: `artPtr`, `negOne`, `pmxIndexPtr`, `simPtr`, `typeEnvMap`, `uvOffset`
- `ReduceObjectPrecision__FP5GroupT0i`: `x`, `y`, `z`
- `Track_Init__FPc`: `dest`, `loadBuf`, `tT33`, `this_00`, `tu3`

## Explicit oracle-proven function type overrides


## Object-owned global/storage review

- `aih_btccop.cpp` explicit source-only global/data-layout carriers: `AIH_BTCCop_freezeToggle_8013c564`
- `aih_traf.cpp` explicit source-only global/data-layout carriers: `D_800551A4`
- `aihigh.cpp` explicit source-only global/data-layout carriers: `AIHigh_None_vtable`, `AIHigh_kVtbl_80054dcc`
- `sim.cpp` explicit source-only global/data-layout carriers: `D_8013D410`, `D_8013D418`, `D_8013D420`
- `vtables_aidatarecord.cpp` explicit source-only global/data-layout carriers: `AIDataRecord_BestLine_t_vtable`, `AIDataRecord_CarTracking_t_vtable`, `AIDataRecord_CurveSpeedTable_t_vtable`, `AIDataRecord_TrackCurve_t_vtable`
- `vtables_aihigh.cpp` explicit source-only global/data-layout carriers: `AIHigh_BTC_Perp_vtable`, `AIHigh_BasicCop_vtable`, `AIHigh_Player_vtable`
- `vtables_aistate.cpp` explicit source-only global/data-layout carriers: `AIState_Base_vtable`, `AIState_NonActive_vtable`, `AIState_None_vtable`
- `vtables_object.cpp` explicit source-only global/data-layout carriers: `ObjectAnim_vtable`
- `vtables_tdialog.cpp` explicit source-only global/data-layout carriers: `tDialogInteractive_vtable`, `tDialogMessageStringWithTimeout_vtable`
- `vtables_tmenu.cpp` explicit source-only global/data-layout carriers: `tBlankMenuItemGoToMenuNFS4Button_vtable`, `tBlankMenuItemNFS4LeftRightChoice_vtable`
- `aih_btccop.cpp` extra definitions: `AIH_BTCCop_freezeToggle_8013c564`
- `aih_traf.cpp` extra definitions: `D_800551A4`
- `aihigh.cpp` extra definitions: `AIHigh_None_vtable`, `AIHigh_kVtbl_80054dcc`
- `sim.cpp` extra definitions: `D_8013D410`, `D_8013D418`, `D_8013D420`
- `vtables_aidatarecord.cpp` extra definitions: `AIDataRecord_BestLine_t_vtable`, `AIDataRecord_CarTracking_t_vtable`, `AIDataRecord_CurveSpeedTable_t_vtable`, `AIDataRecord_TrackCurve_t_vtable`
- `vtables_aihigh.cpp` extra definitions: `AIHigh_BTC_Perp_vtable`, `AIHigh_BasicCop_vtable`, `AIHigh_Player_vtable`
- `vtables_aistate.cpp` extra definitions: `AIState_Base_vtable`, `AIState_NonActive_vtable`, `AIState_None_vtable`
- `vtables_object.cpp` extra definitions: `ObjectAnim_vtable`
- `vtables_tdialog.cpp` extra definitions: `tDialogInteractive_vtable`, `tDialogMessageStringWithTimeout_vtable`
- `vtables_tmenu.cpp` extra definitions: `tBlankMenuItemGoToMenuNFS4Button_vtable`, `tBlankMenuItemNFS4LeftRightChoice_vtable`
