# SYM-to-source declaration audit

Target: `C:\Temp\nfs4-decomp\recon\frontend\common`
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

- SYM functions in target TUs: 838
- Mapped to reconstructed definitions: 833 (792 demangled class/name maps)
- Source definitions still using mangled linkage identifiers: 0
- Explicit deleting-destructor ABI carriers: 41
- Explicit cross-TU ownership closures: 0
- Declaration-clean mapped functions: 613
- Missing SYM names: 2
- Extra source-local names: 484
- Type-comparison findings: 9
- Recognized ABI/debug-equivalent type encodings: 249
  (generic-function-pointer=12, promoted-stack-argument=28, reference-as-pointer=209)
- Function storage-class findings: 9
- Implicit aggregate special members (source body correctly absent): 2
- Explicit oracle-receipted carrier mappings: 0
- Explicit restored inline-local mappings: 64
- Explicit restored macro-local mappings: 0
- Explicit compact static-local mappings: 0
- Exact cross-build/canonical name recoveries: 0
- Explicit linkage-proven ABI parameters omitted from SYM: 22
- Explicit source-only codegen carriers: 438
- Explicit oracle-proven function type overrides: 0
- Functions needing mapping review: 3
- SYM object-owned data records in target TUs: 190
- Compact address-only data records mapped by exact name+VA: 176
- Mapped source global definitions: 188
- Special SYM vtable records mapped: 0/0
- Blob-backed object globals: 2
- Missing/extra global definitions: 0/0
- Global storage-class findings: 0
- Explicit oracle-proven global storage overrides: 0
- Global type findings: 0
- Recognized global debug-equivalent types: 0
  (none)
- Explicit measured global array carriers: 0
- Explicit source-only global/data-layout carriers: 0
- Explicit host-only fallback globals: 0
- Explicit linker-folded shared common globals: 0
- Explicit oracle-proven global type overrides: 2

## Review queue

### `Redraw__14tFEApplication` (0x8001373c, feapp.cpp:264, map=exact)

- Extra source locals: `pal2`, `pc`

### `DisplayHelp__14tFEApplications` (0x80013f74, feapp.cpp:748, map=exact)

- Extra source locals: `this_tDialogHelp`

### `RunDemoVideo__14tFEApplication` (0x80014014, feapp.cpp:796, map=exact)

- Extra source locals: `largest`, `menu`, `vtbl`

### `MainLoop__14tFEApplicationP5tMenu` (0x800142a4, feapp.cpp:911, map=exact)

- Extra source locals: `currentTicks`, `memcardDialog`

### `RunPostGame__14tFEApplication` (0x80015430, feapp.cpp:1355, map=exact)

- Extra source locals: `item`, `screen`

### `_._31tDialogMessageStringWithTimeout` (0x80015760, fedialog.h:65, map=header-owner)

- Storage: SYM STAT vs source EXT

### `CalcUsedPrice__11tCarManagers` (0x80016344, fecars.cpp:132, map=exact)

- Extra source locals: `carID`, `upgrades`

### `SellCar__11tCarManagerss` (0x8001652c, fecars.cpp:229, map=exact)

- Extra source locals: `lastSlotOffset`, `newSelection`, `numCars`, `playerFrontEnd`, `previousSlotOffset`, `removedSlotOffset`, `selectedSlotOffset`

### `RemoveFromPinkSlipsList__11tCarManagerss` (0x800167b8, fecars.cpp:376, map=exact)

- Extra source locals: `lastSlotOffset`, `newSelection`, `numCars`, `playerFrontEnd`, `previousSlotOffset`, `removedSlotOffset`, `selectedSlotOffset`

### `GetStockCar__11tCarManagersR8tCarInfo` (0x80016e90, fecars.cpp:693, map=exact)

- Extra source locals: `viewable`

### `GetNumTourneyCars__11tCarManagers` (0x80017378, fecars.cpp:855, map=exact)

- Extra source locals: `carID`

### `ValidCar__16tListIteratorCar7tPlayerc` (0x800180d4, fecars.cpp:1295, map=exact)

- Extra source locals: `carClass`

### `Increment__21tListIteratorCarColor7tPlayer` (0x800185b0, fecars.cpp:1500, map=exact)

- Extra source locals: `fNumColors`, `notWrapped`

### `Draw__11tDialogHelp` (0x8001912c, fedialog.cpp:511, map=exact)

- Extra source locals: `bufferPtr`, `firstTick`, `loadedTicks`

### `_._15tDialogYesNoTri` (0x80019ec4, fedialog.h:1035, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._15tDialogYesNoMem` (0x80019ee4, fedialog.h:1046, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._12tDialogYesNo` (0x80019f04, fedialog.h:1053, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._18tDialogInteractive` (0x80019f24, fedialog.h:1060, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`
- Storage: SYM STAT vs source EXT

### `_._21tDialogNoInputMessage` (0x80019f44, fedialog.h:1069, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._17tDialogBackUpOnly` (0x80019f64, fedialog.h:1080, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._20tDialogMessageString` (0x80019f84, fedialog.h:1086, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._11tDialogHelp` (0x80019fa4, fedialog.h:1097, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._11tDialogBase` (0x80019fc4, fedialog.h:1112, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `MenuNFS4_DrawTextBox__FiR4RECTissbT5` (0x8001a018, femenuextended.cpp:40, map=exact)

- Extra source locals: `fade`, `selFade`, `textType`

### `Draw__9tMenuNFS4` (0x8001b4f4, femenuextended.cpp:786, map=exact)

- Extra source locals: `iVar3`, `iVar4`

### `TransitionOn__12tMenuOptions` (0x8001be00, femenuextended.cpp:1163, map=exact)

- Extra source locals: `itemCursor`

### `_._29tMenuItemOptionsTwoItemChoice` (0x8001bf00, femenuextended.h:1246, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._31tMenuItemOptionsLeftRightChoice` (0x8001bf20, femenuextended.h:1257, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `Draw__27tMenuItemGoToMenuNFS4Buttonb` (0x8001bf40, femenuextended.h:1263, map=header-owner-signature)

- Extra source locals: `selected`

### `SubtractiveBox__Fiiiiiiii` (0x8001c0fc, femenuoptions.cpp:105, map=exact)

- Extra source locals: `packetCell`

### `UpdateTransition__27tMenuItemGoToMenuButtonFadeb` (0x8001c2dc, femenuoptions.cpp:205, map=exact)

- Extra source locals: `iVar2`

### `UpdateTransition__22tMenuItemLeftRightFadeb` (0x8001c438, femenuoptions.cpp:297, map=exact)

- Extra source locals: `iVar2`

### `UpdateTransition__12tOptionsMenu` (0x8001c854, femenuoptions.cpp:458, map=exact)

- Extra source locals: `adjusted`, `citem`, `entry`, `item`

### `Draw__12tOptionsMenu` (0x8001cb04, femenuoptions.cpp:563, map=exact)

- Extra source locals: `adjusted`, `entry`

### `ProcessInput__14tInsideBoxMenu7tPlayerR13tInputKeyTypeR12tMenuCommand` (0x8001ce2c, femenuoptions.cpp:672, map=exact)

- Extra source locals: `tVar2`

### `Draw__14tInsideBoxMenusssss` (0x8001cefc, femenuoptions.cpp:703, map=exact)

- Extra source locals: `entry10`, `entry6`

### `UpdateTransition__20tMenuItemSlidingMenub` (0x8001d31c, femenuoptions.cpp:860, map=exact)

- Extra source locals: `iVar2`

### `UpdatefOpenHeight__20tMenuItemSlidingMenub` (0x8001d41c, femenuoptions.cpp:911, map=exact)

- Extra source locals: `closeH`, `cur`, `fade`, `fadeOut`, `lim`, `newFade`, `shrinkH`, `slide`

### `Draw__20tMenuItemSlidingMenuiib` (0x8001d63c, femenuoptions.cpp:1060, map=exact-signature)

- Extra source locals: `drawX`, `drawY`

### `UpdatefOpenHeight__25tMenuItemSlidingActivatedb` (0x8001dd6c, femenuoptions.cpp:1241, map=exact)

- Extra source locals: `arg1`, `iVar2`, `iVar4`

### `UpdateTransition__25tMenuItemSlidingActivatedb` (0x8001dec8, femenuoptions.cpp:1344, map=exact)

- Extra source locals: `iVar2`

### `Draw__31tMenuItemDisplayLeftRightChoiceiib` (0x8001e230, femenuoptions.cpp:1456, map=exact)

- Extra source locals: `x`, `y`

### `Draw__29tMenuItemOnOffLeftRightChoiceiib` (0x8001e384, femenuoptions.cpp:1505, map=exact)

- Extra source locals: `x`, `y`

### `Draw__29tMenuItemLeftRightAudioSlideriib` (0x8001e570, femenuoptions.cpp:1579, map=exact)

- Extra source locals: `brightTextColor`, `rgbVals`

### `UpdateTransition__29tMenuItemLeftRightAudioSliderb` (0x8001e8d4, femenuoptions.cpp:1716, map=exact)

- Extra source locals: `iVar1`

### `Draw__18tInsideBoxSongMenusssss` (0x8001e9d8, femenuoptions.cpp:1774, map=exact)

- Extra source locals: `drawBaseY`, `fadeValue`, `fe`, `slide`, `width`

### `Draw__34tMenuItemControllerLeftRightChoiceiib` (0x8001f084, femenuoptions.cpp:1995, map=exact)

- Extra source locals: `w`, `x`, `y`

### `Draw__22tInsideBoxTwoWaySlideriiib` (0x8001f5a0, femenuoptions.cpp:2191, map=exact)

- Extra source locals: `fWidth`, `selection`

### `Calibrate__22tInsideBoxTwoWaySlider` (0x8001f918, femenuoptions.cpp:2297, map=exact)

- Extra source locals: `app`, `minimum`, `padBase`, `padInfo`, `screen`, `value`

### `ProcessInput__17tUserNameMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand` (0x8001fd2c, femenuoptions.cpp:2477, map=exact)

- Extra source locals: `character`, `column`, `lastColumn`, `rowBase`, `rowOffset`, `selectedChar`, `soundId`, `stringLength`

### `Draw__17tUserNameMenuItemb` (0x8002017c, femenuoptions.cpp:2700, map=exact)

- Extra source locals: `boxRight`, `columnx`, `menuStartY`, `right`, `row`

### `UpdateTransition__17tUserNameMenuItemb` (0x80020820, femenuoptions.cpp:3056, map=exact)

- Extra source locals: `iVar2`

### `Draw__19tMemoryCardMenuItemb` (0x8002089c, femenuoptions.cpp:3080, map=exact)

- Extra source locals: `less`, `sVar2`, `sv`, `v`

### `_._35tInsideBoxControllerLeftRightSlider` (0x80020bb8, femenuoptions.h:3242, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._19tMemoryCardMenuItem` (0x80020bd8, femenuoptions.h:3250, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._27tMenuItemGoToMenuButtonFade` (0x80020bf8, femenuoptions.h:3255, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._17tUserNameMenuItem` (0x80020c18, femenuoptions.h:3260, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._34tMenuItemControllerLeftRightChoice` (0x80020c38, femenuoptions.h:3265, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._29tMenuItemOnOffLeftRightChoice` (0x80020c58, femenuoptions.h:3270, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._31tMenuItemDisplayLeftRightChoice` (0x80020c78, femenuoptions.h:3275, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._25tMenuItemSlidingActivated` (0x80020c98, femenuoptions.h:3280, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._22tMenuItemLeftRightFade` (0x80020cb8, femenuoptions.h:3285, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib` (0x800212a4, fetextrender.cpp:182, map=exact)

- Extra source locals: `pixels`

### `TextValue__18tListIteratorTrack7tPlayer` (0x80021dd4, fetracks.cpp:203, map=exact)

- Extra source locals: `trackEntry`, `uVar1`

### `DrawTVLines__FR9tTVConfig` (0x80021ff8, fetv.cpp:64, map=exact)

- Extra source locals: `abe`

### `DrawTV__FR9tTVConfig` (0x8002234c, fetv.cpp:281, map=exact)

- Extra source locals: `noiseHeight`, `noiseShapeY`, `packetPtrSlot`, `rgbMask`

### `FECheat_HandleActivation__F10tCheatCode` (0x80023240, fecheats.cpp:30, map=exact)

- Missing SYM names: `num`
- Extra source locals: `placement`, `placements`

### `FECheat_ActivateCheat__FPc` (0x80023614, fecheats.cpp:199, map=exact)

- Extra source locals: `dlgThis`, `feApp`, `wordText`

### `FEInput_GetNoDebounceKey__Fii` (0x800238f8, feinput.cpp:43, map=exact)

- Extra source locals: `result`

### `Draw__9tMenuItemiib` (0x80024828, femenu.cpp:546, map=exact-signature)

- Extra source locals: `x`, `y`

### `Draw__9tMenuItemiiib` (0x80024864, femenu.cpp:559, map=exact-signature)

- Extra source locals: `w`

### `ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand` (0x8002497c, femenu.cpp:617, map=exact)

- Extra source locals: `frameFiller`

### `Draw__24tMenuItemLeftRightChoiceb` (0x80024a2c, femenu.cpp:661, map=exact)

- Extra source locals: `x`, `y`

### `ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand` (0x80024b84, femenu.cpp:726, map=exact)

- Extra source locals: `frameFiller`, `sound`, `volume`

### `DrawSlider__FsssssssssbT9ss` (0x80024c2c, femenu.cpp:1190, map=exact)

- Extra source locals: `greenVal`, `greenVal2`, `redVal`, `redVal2`

### `ProcessInput__23tMenuItemGoToMenuButton7tPlayerR13tInputKeyTypeR12tMenuCommand` (0x800253a4, femenu.cpp:1379, map=exact)

- Extra source locals: `frameFiller`

### `GoNonInterlaced__7tScreen` (0x80025bf8, fescreen.cpp:69, map=exact)

- Extra source locals: `backView`, `displayEnv`, `displayHeight`, `frontView`, `playerViewIndex`, `viewHeight`, `viewTable`

### `UpdateTransition__7tScreen` (0x80026848, fescreen.cpp:633, map=exact)

- Extra source locals: `fadeValue`, `transitionValue`

### `GetPSXPadValue__Fii` (0x80027194, front.cpp:638, map=exact)

- Extra source locals: `acc1`, `acc2`, `padBase`

### `SetPads__Fv` (0x8002750c, front.cpp:780, map=exact)

- Extra source locals: `waiting`

### `Front_Menu__F21tFront_ProcessingType` (0x80027af4, front.cpp:1114, map=exact)

- Extra source locals: `needCar`, `one`

### `Front_GetLapsForType__Fv` (0x80027fc0, front.cpp:1279, map=exact)

- Extra source locals: `uVar1`

### `Front_InitTourneyTraffic__FR9tFEStream` (0x8002845c, front.cpp:1448, map=exact)

- Extra source locals: `maxTraffic`, `tourn`

### `Front_InitOpponentCars__FR9tFEStream` (0x800285d0, front.cpp:1575, map=exact)

- Extra source locals: `numRacers`, `numRacers2`

### `Front_AppendCopData__FPiR9tFEStream` (0x80029e30, front.cpp:2383, map=exact)

- Extra source locals: `carInfo`

### `Front_AppendPerpData__FPiR9tFEStream` (0x8002a084, front.cpp:2462, map=exact)

- Extra source locals: `carInfo`, `carManagerPtr`

### `Front_AppendTrafficData__FPiR9tFEStream` (0x8002a31c, front.cpp:2553, map=exact)

- Extra source locals: `carInfo`, `traffic`

### `Front_AppendTrackData__FPiR9tFEStream` (0x8002a56c, front.cpp:2635, map=exact)

- Extra source locals: `speedMode`

### `Front_EnableLocalSpeech__Fv` (0x8002a6ac, front.cpp:2704, map=exact)

- Extra source locals: `lang`

### `Front_BuildStream__FPi` (0x8002a738, front.cpp:2739, map=exact)

- Extra source locals: `randomSeed`, `t`

### `MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand` (0x8002c288, femenudefs.cpp:254, map=exact)

- Extra source locals: `carSelectScreen`, `nextMenu`, `screenState`

### `AskTheUserToSaveTheGame__Fv` (0x8002c41c, femenudefs.cpp:378, map=exact)

- Extra source locals: `dlgThis`

### `MenuExtended_GoToCarSelect__FR12tMenuCommand` (0x8002c4fc, femenudefs.cpp:463, map=exact)

- Extra source locals: `dialog`, `nextMenu`, `screen`, `state`

### `GenericMenuSaveGame__Fi` (0x8002c9a0, femenudefs.cpp:730, map=exact)

- Extra source locals: `app`, `noInput`

### `PinkSlipsPreSave__Fv` (0x8002cabc, femenudefs.cpp:790, map=exact)

- Extra source locals: `dlgThis`

### `MenuExtended_GoToTournTrackInfo__FR12tMenuCommand` (0x8002cf40, femenudefs.cpp:1073, map=exact)

- Extra source locals: `frontEndBase`, `frontEndState`, `manager`, `selectedTourney`

### `MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand` (0x8002d0a8, femenudefs.cpp:1151, map=exact)

- Extra source locals: `frontEndState`, `manager`, `selectedTourney`

### `MenuExtended_BuyCar__FR12tMenuCommand` (0x8002d4f8, femenudefs.cpp:1482, map=exact)

- Extra source locals: `dialogAnchor`, `pp`

### `GenericMenuLoadGame__Fi` (0x8002d83c, femenudefs.cpp:1765, map=exact)

- Extra source locals: `app`, `mc`

### `MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand` (0x8002de74, femenudefs.cpp:2184, map=exact)

- Extra source locals: `dialogAnchor`, `dlgThis3`, `playerNum`

### `MenuExtended_GoToGarage__FR12tMenuCommand` (0x8002e09c, femenudefs.cpp:2281, map=exact)

- Extra source locals: `garageIterator`

### `MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand` (0x8002e21c, femenudefs.cpp:2492, map=exact)

- Extra source locals: `msg`

### `__15tGlobalMenuDefs` (0x8002e3b8, femenudefs.cpp:3054, map=exact)

- Extra source locals: `memoryMenu`, `userNameMenu`

### `TransitionIsFinished__32tBlankMenuItemGoToMenuNFS4Button` (0x800321c0, femenuoptions.h:3467, map=header-owner)

- Storage: SYM STAT vs source EXT

### `Draw__32tBlankMenuItemGoToMenuNFS4Buttoniib` (0x800321c8, femenuoptions.h:3484, map=header-owner-signature)

- Storage: SYM STAT vs source EXT

### `Draw__32tBlankMenuItemGoToMenuNFS4Buttonb` (0x800321d0, femenuoptions.h:3485, map=header-owner-signature)

- Storage: SYM STAT vs source EXT

### `_._32tBlankMenuItemGoToMenuNFS4Button` (0x800321d8, femenuoptions.h:3494, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`
- Storage: SYM STAT vs source EXT

### `TransitionIsFinished__33tBlankMenuItemNFS4LeftRightChoice` (0x800321f8, femenuextended.h:3499, map=header-owner)

- Storage: SYM STAT vs source EXT

### `Draw__33tBlankMenuItemNFS4LeftRightChoiceiib` (0x80032200, femenuextended.h:3505, map=header-owner)

- Storage: SYM STAT vs source EXT

### `_._33tBlankMenuItemNFS4LeftRightChoice` (0x80032208, femenuextended.h:3514, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`
- Storage: SYM STAT vs source EXT

### `Initialize__18tTournamentManager` (0x80032228, fetourn.cpp:9, map=exact)

- Extra source locals: `numCars`

### `LoadDescription__18tTournamentManager` (0x800322fc, fetourn.cpp:43, map=exact)

- Extra source locals: `tourneyDef`, `trackId`, `trnId`

### `StartNewTournament__18tTournamentManagerUcUc` (0x80032784, fetourn.cpp:205, map=exact)

- Extra source locals: `fRandOption`, `fTrackOption`, `numCompetitors`, `tourneyDef`, `tourneyDefLocal`, `tourneyInfoOffset`, `trackOffset`

### `IsTournamentFinished__18tTournamentManager` (0x800329bc, fetourn.cpp:293, map=exact)

- Extra source locals: `currentTourney`

### `tournPointsCompare__FPcT0` (0x80032a50, fetourn.cpp:312, map=exact)

- Extra source locals: `comps`, `tm`

### `CalcTrackFinishDamageBill__18tTournamentManagerbRlT2` (0x80032c6c, fetourn.cpp:390, map=exact)

- Extra source locals: `mask`

### `UpdateTrackFinishPoints__18tTournamentManager` (0x80032e30, fetourn.cpp:508, map=exact)

- Extra source locals: `comp`, `knockout`, `rankVal`, `ranked`, `ranking`, `stats`

### `UpdateCarLineup__18tTournamentManager` (0x800335d8, fetourn.cpp:776, map=exact)

- Extra source locals: `numCompetitors`

### `GetTournamentFinishPrize__18tTournamentManagers` (0x80033860, fetourn.cpp:850, map=exact)

- Extra source locals: `tourn`

### `PlayerRanking__18tTournamentManagers` (0x80033aa8, fetourn.cpp:930, map=exact)

- Extra source locals: `numCompetitors`

### `GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci` (0x80033b64, fetourn.cpp:963, map=exact)

- Extra source locals: `best`, `t`

### `Confirm__Fii` (0x80034438, fememcard.cpp:136, map=exact)

- Extra source locals: `dialog`, `dialogVtable`, `messageDialog`, `messageText`, `noInputDialog`

### `SaveGame__Fs` (0x80034988, fememcard.cpp:416, map=exact)

- Extra source locals: `displayDialog`, `dlgmsg`, `message`, `status`, `wd`

### `LoadGame__FsbT1` (0x80034e18, fememcard.cpp:598, map=exact)

- Extra source locals: `cardshifted`, `dialogBase`, `dialogText`, `dlgmsg`

### `SavePinkSlipsCars__Fss` (0x800353f0, fememcard.cpp:800, map=exact)

- Extra source locals: `cardInfo`

### `Init__14tCreditManageri` (0x80035af8, fecredits.cpp:27, map=exact)

- Extra source locals: `arg1`

### `SetupCurrCredit__14tCreditManager` (0x80035d68, fecredits.cpp:132, map=exact)

- Extra source locals: `advanceRequested`, `backgroundReady`, `currentCredit`, `inputPressed`, `nextCredit`, `startTicksSnapshot`, `textFade`

### `DrawCurrCredit__14tCreditManager` (0x80036084, fecredits.cpp:253, map=exact)

- Extra source locals: `tag`

### `DrawDropShadow__11tScreenMain` (0x80037804, screenmain.cpp:289, map=exact)

- Extra source locals: `addrMask`, `addr_24`, `palTag`, `pal_link`, `tagMask`

### `DrawBackground__11tScreenMain` (0x800379c0, screenmain.cpp:390, map=exact)

- Extra source locals: `animationFrame`, `curMenu`, `elapsedTicks`, `nextAnimation`, `startMovie`, `videoY`

### `_._11tScreenMain` (0x80038b44, screenmain.h:908, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `DrawBackground__16tScreenPinkSlips` (0x80038b68, screenpinkslips.cpp:21, map=exact)

- Extra source locals: `currentItem`, `movieVramX`, `rx`, `ry`, `selected`, `trackIndex`

### `ProcessInput__16tScreenPinkSlips7tPlayerR13tInputKeyTypeR12tMenuCommand` (0x80039690, screenpinkslips.cpp:336, map=exact)

- Extra source locals: `defs`

### `_._16tScreenPinkSlips` (0x800397cc, screenpinkslips.h:386, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `DrawBackground__26tScreenTournamentStandings` (0x80039b84, screenpost.cpp:316, map=exact)

- Extra source locals: `lastRacer`, `numRacers`, `type`

### `_._24tScreenPinkSlipStandings` (0x8003a88c, screenpost.h:573, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._31tScreenTournamentStandings3item` (0x8003a8ac, screenpost.h:583, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._26tScreenTournamentStandings` (0x8003a8cc, screenpost.h:593, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `DrawCar__FR8tCarInfossffcbUl7tPlayer` (0x8003a9d4, screencarselect.cpp:87, map=exact)

- Extra source locals: `signedTicks`

### `Cleanup__16tScreenCarSelect` (0x8003acb8, screencarselect.cpp:175, map=exact)

- Extra source locals: `vtbl`

### `DrawOverlay__16tScreenCarSelectP8tOverlay` (0x8003ad00, screencarselect.cpp:202, map=exact)

- Extra source locals: `curItem`, `flags`, `tournamentMoney`, `xPos`, `yOffset`

### `GetShapeInfo__16tScreenCarSelectRsT1PPcT3` (0x8003bae0, screencarselect.cpp:576, map=exact)

- Extra source locals: `vtbl`

### `DrawVideoWall__16tScreenCarSelects` (0x8003c118, screencarselect.cpp:849, map=exact)

- Extra source locals: `vtbl`

### `GetCar__16tScreenCarSelectR8tCarInfo` (0x8003c224, screencarselect.cpp:900, map=exact)

- Extra source locals: `color`

### `DrawBackground__16tScreenCarSelect` (0x8003c53c, screencarselect.cpp:994, map=exact)

- Extra source locals: `canUpload`

### `DrawForeground__16tScreenCarSelect` (0x8003c7d8, screencarselect.cpp:1085, map=exact)

- Extra source locals: `currentItemValue`, `fadeBase`, `overlayDirection`, `shapeFade`, `shapeTicks`, `textBase`, `validCarValue`

### `PreLoad__20tScreenCarSelectDuel` (0x8003d08c, screencarselect.cpp:1358, map=exact)

- Extra source locals: `useDefault`

### `DrawVideoWall__20tScreenCarSelectDuels` (0x8003d364, screencarselect.cpp:1471, map=exact)

- Extra source locals: `vtbl`

### `GetShapeInfo__20tScreenCarSelectDuelRsT1PPcT3` (0x8003d5e0, screencarselect.cpp:1547, map=exact)

- Extra source locals: `vtbl`

### `UpdateVideoWall__20tScreenCarSelectDuelR8tCarInfo` (0x8003d69c, screencarselect.cpp:1578, map=exact)

- Extra source locals: `country`

### `DrawBackground__20tScreenCarSelectDuel` (0x8003d7f0, screencarselect.cpp:1634, map=exact)

- Extra source locals: `elapsed`, `p1Ready`, `p2Ready`

### `GetCar__25tScreenCarSelectTwoPlayerR8tCarInfo` (0x8003e040, screencarselect.cpp:1839, map=exact)

- Extra source locals: `player`

### `DrawVideoWall__25tScreenCarSelectTwoPlayers` (0x8003e190, screencarselect.cpp:1890, map=exact)

- Extra source locals: `videoOffset`

### `UpdateVideoWall__25tScreenCarSelectTwoPlayerR8tCarInfo` (0x8003e3c8, screencarselect.cpp:1959, map=exact)

- Extra source locals: `country`

### `DrawBackground__25tScreenCarSelectTwoPlayer` (0x8003e4bc, screencarselect.cpp:2003, map=exact)

- Missing SYM names: `carInfo`
- Extra source locals: `elapsed`, `loading`, `player`, `uploadReady`, `uploadY`, `vtbl`

### `DoMemCardStuff__25tScreenPinkSlipsCarSelect` (0x8003ef14, screencarselect.cpp:2390, map=exact)

- Extra source locals: `cardInfo`, `pinkState`, `resultState`, `resultStatePtr`, `stateBase`

### `SetDialog__25tScreenPinkSlipsCarSelect` (0x8003f300, screencarselect.cpp:2558, map=exact)

- Extra source locals: `dlg`, `wordnum`

### `_._25tScreenPinkSlipsCarSelect` (0x8003f6d0, screencarselect.h, map=unmapped)

- Mapping: unresolved; inspect constructor/operator/overload spelling.

### `_._25tScreenCarSelectTwoPlayer` (0x8003f714, screencarselect.h, map=unmapped)

- Mapping: unresolved; inspect constructor/operator/overload spelling.

### `_._20tScreenCarSelectDuel` (0x8003f758, screencarselect.h:2825, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `GetShapeInfo__18tScreenTournSelectRsT1PPcT3` (0x8003f7d4, screentournselect.cpp:36, map=exact)

- Extra source locals: `fe`, `trophyTourn`, `useSpecial`

### `Initialize__18tScreenTournSelect` (0x8003f8a0, screentournselect.cpp:81, map=exact)

- Extra source locals: `fe`, `tvIdx`, `useSpecial`

### `DrawBackground__18tScreenTournSelect` (0x8003fe5c, screentournselect.cpp:259, map=exact)

- Extra source locals: `descriptionText`, `fe`, `number`, `shapeX`, `tournament`, `tvIdx`

### `GetShapeInfo__17tScreenTrophyRoomRsT1PPcT3` (0x800405d8, screentrophyroom.cpp:36, map=exact)

- Extra source locals: `cur`

### `Initialize__17tScreenTrophyRoom` (0x80040910, screentrophyroom.cpp:129, map=exact)

- Extra source locals: `curIdx`, `loopFe`, `place`, `placement`, `tournIdx`, `tourney`

### `DrawBackground__17tScreenTrophyRoom` (0x80040b18, screentrophyroom.cpp:238, map=exact)

- Extra source locals: `currentTourn`, `drawFlagsPtr`, `feTier`, `selectedTourn`, `tourn`

### `LoadTrophy__17tScreenTrophyRoom` (0x80040f2c, screentrophyroom.cpp:333, map=exact)

- Extra source locals: `tierIdx`, `tourn`

### `GetShapeInfo__17tScreenTrophyInfoRsT1PPcT3` (0x80041008, screentrophyinfo.cpp:9, map=exact)

- Extra source locals: `currentTourn`, `feTier`, `idx`, `placement`

### `DrawBackground__17tScreenTrophyInfo` (0x80041138, screentrophyinfo.cpp:92, map=exact)

- Extra source locals: `currentTourn`, `feTier`, `tourn`, `tournID`

### `_._17tScreenTrophyInfo` (0x800415e0, screentrophyinfo.h:215, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `DrawBackground__18tScreenTrackSelect` (0x80041600, screentracks.cpp:14, map=exact)

- Extra source locals: `packetPtrSlot`, `shapeX`, `startTicks`, `videoWall`, `videoY`

### `ProcessInput__18tScreenTrackSelect7tPlayerR13tInputKeyTypeR12tMenuCommand` (0x8004200c, screentracks.cpp:440, map=exact)

- Extra source locals: `ptVar1`

### `_._18tScreenTrackSelect` (0x800421d4, screentracks.h:523, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `DrawBackground__16tScreenTrackInfo` (0x80042298, screentrackinfo.cpp:38, map=exact)

- Extra source locals: `highlighted`, `screenInfo`, `state`, `trackList`

### `ProcessInput__16tScreenTrackInfo7tPlayerR13tInputKeyTypeR12tMenuCommand` (0x8004258c, screentrackinfo.cpp:105, map=exact)

- Extra source locals: `fee`

### `_._16tScreenTrackInfo` (0x80042628, screentrackinfo.h:127, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._19tScreenTrackRecords` (0x800430f8, screentrackrecords.h:240, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `SetActuators__23tScreenControllerConfigi` (0x80043124, screencontroller.cpp:30, map=exact)

- Extra source locals: `pulse`, `tickValue`

### `AnimKeyPoints__23tScreenControllerConfigbT1` (0x8004339c, screencontroller.cpp:155, map=exact)

- Extra source locals: `result`

### `CheckConfigs__23tScreenControllerConfig` (0x80043400, screencontroller.cpp:189, map=exact)

- Extra source locals: `arrowFadeBelowHalf`, `currentControllerForSwap`, `currentControllerSnapshot`, `previousControllerSnapshot`

### `SetCurrentController__23tScreenControllerConfigb` (0x80043778, screencontroller.cpp:343, map=exact)

- Extra source locals: `dialog`, `dialogIsIdle`, `menuDefinitions`, `previousNegconChoice`

### `DrawController__23tScreenControllerConfig` (0x80043de4, screencontroller.cpp:620, map=exact)

- Extra source locals: `controller`, `controllerOffset`, `haloX`, `iy`, `modeBase`, `offsets`, `rangeValue`, `row`, `shockImpactActive`, `shockModeActive`, `x`, `xOffset`

### `DrawBackground__23tScreenControllerConfig` (0x80044e40, screencontroller.cpp:1117, map=exact)

- Extra source locals: `om`

### `DrawForeground__23tScreenControllerConfig` (0x80045064, screencontroller.cpp:1202, map=exact)

- Extra source locals: `copyCount`, `dialog`, `flag`, `selectedConfig`, `textLength`, `textLocationIn`, `textLocationOut`, `textWidth`

### `Initialize__23tScreenControllerConfig` (0x800456fc, screencontroller.cpp:1396, map=exact)

- Extra source locals: `b`, `mode`

### `_._23tScreenControllerConfig` (0x8004590c, screencontroller.h, map=unmapped)

- Mapping: unresolved; inspect constructor/operator/overload spelling.

### `_._14tScreenDisplay` (0x80045a04, screendisplay.h:46, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `PlaySound__12tScreenAudio` (0x80045a28, screenaudio.cpp:9, map=exact)

- Extra source locals: `validItem`

### `DrawForeground__12tScreenAudio` (0x80045dc8, screenaudio.cpp:126, map=exact)

- Extra source locals: `fadeCalc`

### `DrawBackground__12tScreenAudio` (0x80045ed8, screenaudio.cpp:180, map=exact)

- Extra source locals: `displayPercent`, `fadeValue`, `optionsMenu`

### `Initialize__12tScreenAudio` (0x800461a4, screenaudio.cpp:303, map=exact)

- Extra source locals: `menus`

### `Cleanup__12tScreenAudio` (0x80046204, screenaudio.cpp:327, map=exact)

- Extra source locals: `info`

### `_._12tScreenAudio` (0x800462fc, screenaudio.h:363, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `DrawIcon__14tScreenMemcardP8shapetbliiiis` (0x80046344, screenmemcard.cpp:23, map=exact)

- Extra source locals: `u`

### `LoadIcon__14tScreenMemcardi` (0x8004653c, screenmemcard.cpp:89, map=exact)

- Extra source locals: `cardInfo`, `one`, `pulled`

### `DrawVerticalLine__14tScreenMemcardssss` (0x80046898, screenmemcard.cpp:196, map=exact)

- Extra source locals: `innerHeight`, `pos`, `shifted`, `test`

### `DrawHorizontalLine__14tScreenMemcardssss` (0x8004694c, screenmemcard.cpp:261, map=exact)

- Extra source locals: `pos`, `shifted`, `test`, `width`

### `PlaceIcons__14tScreenMemcardii` (0x80046a0c, screenmemcard.cpp:317, map=exact)

- Extra source locals: `animFrame`, `nfs4Icon`, `numIcons`, `savedY`, `tickFrame`, `tickPtr`

### `DrawBackground__14tScreenMemcard` (0x80047470, screenmemcard.cpp:698, map=exact)

- Extra source locals: `gouraudX`, `gouraudY`, `h`, `startX`, `startY`, `w`

### `DrawForeground__14tScreenMemcard` (0x80047ad8, screenmemcard.cpp:840, map=exact)

- Extra source locals: `fade`

### `Initialize__14tScreenMemcard` (0x80047c30, screenmemcard.cpp:901, map=exact)

- Extra source locals: `msgId`

### `_._14tScreenMemcard` (0x80047e3c, screenmemcard.h:988, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `GetShapeInfo__15tScreenCongratsRsT1PPcT3` (0x80047e8c, screencongrats.cpp:29, map=exact)

- Extra source locals: `numRanked`

### `DrawBackground__15tScreenCongrats` (0x8004813c, screencongrats.cpp:118, map=exact)

- Extra source locals: `spinTicks`, `vtbl`

### `CalculatePrizes__15tScreenCongrats` (0x800489b8, screencongrats.cpp:348, map=exact)

- Extra source locals: `carCXBits`, `carCYBits`

### `Initialize__15tScreenCongrats` (0x80048a2c, screencongrats.cpp:392, map=exact)

- Extra source locals: `vtbl`

### `ProcessInput__15tScreenCongrats7tPlayerR13tInputKeyTypeR12tMenuCommand` (0x80048af0, screencongrats.cpp:434, map=exact)

- Extra source locals: `bConsumeKey`

### `CalculatePrizes__23tScreenPinkSlipCongrats` (0x80048cdc, screencongrats.cpp:504, map=exact)

- Extra source locals: `player`

### `CalculatePrizes__23tScreenTournamentTrophy` (0x8004923c, screencongrats.cpp:727, map=exact)

- Extra source locals: `carCXBits`, `cashAwarded`, `knockout`, `ranked`

### `_._25tScreenTournamentCongrats` (0x800497a0, screencongrats.h:978, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._23tScreenBeTheCopCongrats` (0x800497c0, screencongrats.h:986, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._23tScreenPinkSlipCongrats` (0x800497e0, screencongrats.h:994, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._23tScreenTournamentTrophy` (0x80049800, screencongrats.h:1002, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `_._15tScreenCongrats` (0x80049820, screencongrats.h:1010, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `StatChk_SaveRecordLapTime__FP10Car_tStatsss` (0x80049b7c, statchk.cpp:97, map=exact)

- Extra source locals: `newBestLap`

### `StatChk_SaveTopTime__FP10Car_tStatss` (0x8004a1b8, statchk.cpp:428, map=exact)

- Extra source locals: `uRecSz`

### `Stattool_nCreateIndex__FiPiPs` (0x8004a868, stattool.cpp:11, map=exact)

- Extra source locals: `one`

### `Stattool_ParseTime__FiPc` (0x8004a99c, stattool.cpp:70, map=exact)

- Extra source locals: `min`, `sec`

### `Stattool_CheckForHumanCar__FP10Car_tStats` (0x8004aec4, stattool.cpp:280, map=exact)

- Extra source locals: `nNumCars`

### `Stattool_GetAINameFromPersonality__F14tPersonalities` (0x8004af4c, stattool.cpp:308, map=exact)

- Extra source locals: `namePtr`

### `DrawBackground__15tScreenUserName` (0x8004b1ac, screenusername.cpp:221, map=exact)

- Extra source locals: `fadeboxv`, `gridposv`

### `_._15tScreenUserName` (0x8004b7d4, screenusername.h:397, map=abi-carrier)

- Mapping: explicit verify_asm-PASS deleting-destructor ABI carrier; the source function's `pThis`/`__in_chrg` parameters represent the retail member destructor's implicit ABI parameters.
- Extra source locals: `thisp`

### `CalcOnOffFade__F13tMenuTextTypesssRiT4` (0x8004b9d4, fefades.cpp:96, map=exact)

- Extra source locals: `baseA`, `baseB`, `baseC`

## Implicit aggregate special members

- `__11tAllScreens` (0x8002baf4, `front.cpp`): implicit `tAllScreens` constructor; emitted from the aggregate member graph at the recorded declaration line, so an explicit source body would be incorrect.
- `_._11tAllScreens` (0x8002bf0c, `front.cpp`): implicit `tAllScreens` destructor; emitted from the aggregate member graph at the recorded declaration line, so an explicit source body would be incorrect.
## Explicit SYM carrier/optimization mappings


## Explicit restored inline-local mappings

- `DrawHelpIcons__14tFEApplication`: `this` from `HasOptionsMenu`
- `MainLoop__14tFEApplicationP5tMenu`: `this` from `IsVisible`, `this` from `SetString`
- `CalculateDimensions__11tDialogHelp`: `this` from `CanContinue`, `this` from `HasFlag`, `this` from `HasFlag`
- `Draw__11tDialogHelp`: `this` from `CalculateDimensionsVirtual`
- `Run__18tDialogInteractive`: `player` from `DialogCanProcessCircle`, `this` from `CalculateDimensionsVirtual`, `this` from `IsVisible`, `this` from `ProcessInputVirtual`
- `Draw__12tDialogYesNo`: `this` from `CalculateDimensionsVirtual`
- `FECheat_ActivateCheat__FPc`: `this` from `SetString`
- `ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand`: `this` from `IsDisabled`
- `ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand`: `this` from `IsDisabled`
- `GenericMenuSaveGame__Fi`: `this` from `SetMessage`, `this` from `SetMessage`, `this` from `SetString`
- `MenuExtended_GoToRace__FR12tMenuCommand`: `this` from `MessagePopup`, `this` from `SetString`, `this` from `SetString`, `this` from `SetString`, `this` from `SetString`
- `MenuExtended_GoTo2PlayerRace__FR12tMenuCommand`: `this` from `CurrentPlayer`, `this` from `CurrentPlayer`, `this` from `MessagePopup`, `this` from `SetString`, `this` from `SetString`, `this` from `SetString`
- `MenuExtended_GoToTournTrackInfo__FR12tMenuCommand`: `this` from `SetString`
- `MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand`: `this` from `SetString`
- `MenuExtended_EnterUserName__FR12tMenuCommand`: `data` from `SetUserNameData`, `m` from `SetCallingMenu`, `this` from `SetCallingMenu`, `this` from `SetUserNameData`
- `MenuExtended_SellCar__FR12tMenuCommand`: `this` from `SetString`
- `MenuExtended_LoadGame__FR12tMenuCommand`: `this` from `SetChoices`
- `MenuExtended_PostGameMenu__FR12tMenuCommand`: `this` from `SetDrawMoney`
- `MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand`: `m` from `SetCallingMenu`, `this` from `SetCallingMenu`, `this` from `SetPostGameNameData`
- `__15tGlobalMenuDefs`: `child` from `A1_SetChildMenu`
- `Confirm__Fii`: `this` from `SetString`
- `SaveGame__Fs`: `this` from `SetString`
- `LoadGame__FsbT1`: `this` from `SetString`, `this` from `SetString`
- `ProcessInput__16tScreenCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand`: `this` from `SetTextDescription`
- `DrawBackground__16tScreenCarSelect`: `this` from `GetPlayer`
- `DrawSliders__16tScreenCarSelectR8tCarInfoss`: `carInfo` from `CarStatValue`, `carStat` from `CarStatValue`, `result` from `CarStatValue`
- `DrawForeground__20tScreenCarSelectDuel`: `carInfo` from `CarStatValue`, `carStat` from `CarStatValue`, `result` from `CarStatValue`
- `GetCar__25tScreenCarSelectTwoPlayerR8tCarInfo`: `this` from `GetPlayer`
- `DrawForeground__25tScreenCarSelectTwoPlayer`: `carInfo` from `CarStatValue`, `carStat` from `CarStatValue`, `result` from `CarStatValue`
- `GetCar__25tScreenPinkSlipsCarSelectR8tCarInfo`: `this` from `GetPlayer`
- `DoMemCardStuff__25tScreenPinkSlipsCarSelect`: `this` from `GetPlayer`
- `SetDialog__25tScreenPinkSlipsCarSelect`: `this` from `GetPlayer`
- `SetCurrentController__23tScreenControllerConfigb`: `this` from `SetString`
- `DrawController__23tScreenControllerConfig`: `range` from `ControllerTwistRange`
- `DrawForeground__23tScreenControllerConfig`: `this` from `IsVisible`

## Explicit compact static-local mappings


## Exact cross-build/canonical name recoveries


## Explicit restored macro-local mappings


## Explicit linkage-proven ABI parameters omitted from SYM

- `ProcessInput__11tDialogBase7tPlayerR13tInputKeyTypeR12tMenuCommand`: `command`, `fromPlayer`
- `Draw__31tMenuItemDisplayLeftRightChoiceiib`: `selected`
- `Draw__29tMenuItemOnOffLeftRightChoiceiib`: `selected`
- `Draw__29tMenuItemLeftRightAudioSlideriib`: `selected`
- `ProcessInput__18tInsideBoxSongMenu7tPlayerR13tInputKeyTypeR12tMenuCommand`: `command`, `fromPlayer`
- `Draw__34tMenuItemControllerLeftRightChoiceiib`: `selected`
- `Draw__25tInsideBoxLeftRightSlideriiib`: `selected`
- `ProcessInput__22tInsideBoxTwoWaySlider7tPlayerR13tInputKeyTypeR12tMenuCommand`: `command`, `fromPlayer`
- `Draw__22tInsideBoxTwoWaySlideriiib`: `selected`
- `ProcessInput__17tUserNameMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand`: `command`, `fromPlayer`
- `Draw__17tUserNameMenuItemb`: `selected`
- `Draw__19tMemoryCardMenuItemb`: `selected`
- `ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand`: `command`
- `ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand`: `command`
- `MenuExtended_SellCar__FR12tMenuCommand`: `command`
- `MenuExtended_BuyCar__FR12tMenuCommand`: `command`
- `ProcessInput__18tScreenTrackSelect7tPlayerR13tInputKeyTypeR12tMenuCommand`: `command`, `player`

## Explicit source-only codegen carriers

- `Redraw__14tFEApplication`: `pal2`, `pc`
- `DisplayHelp__14tFEApplications`: `this_tDialogHelp`
- `RunDemoVideo__14tFEApplication`: `largest`, `menu`, `vtbl`
- `MainLoop__14tFEApplicationP5tMenu`: `currentTicks`, `memcardDialog`
- `RunPostGame__14tFEApplication`: `item`, `screen`
- `CalcUsedPrice__11tCarManagers`: `carID`, `upgrades`
- `SellCar__11tCarManagerss`: `lastSlotOffset`, `newSelection`, `numCars`, `playerFrontEnd`, `previousSlotOffset`, `removedSlotOffset`, `selectedSlotOffset`
- `RemoveFromPinkSlipsList__11tCarManagerss`: `lastSlotOffset`, `newSelection`, `numCars`, `playerFrontEnd`, `previousSlotOffset`, `removedSlotOffset`, `selectedSlotOffset`
- `GetStockCar__11tCarManagersR8tCarInfo`: `viewable`
- `GetNumTourneyCars__11tCarManagers`: `carID`
- `ValidCar__16tListIteratorCar7tPlayerc`: `carClass`
- `Increment__21tListIteratorCarColor7tPlayer`: `fNumColors`, `notWrapped`
- `Draw__11tDialogHelp`: `bufferPtr`, `firstTick`, `loadedTicks`
- `MenuNFS4_DrawTextBox__FiR4RECTissbT5`: `fade`, `selFade`, `textType`
- `Draw__9tMenuNFS4`: `iVar3`, `iVar4`
- `TransitionOn__12tMenuOptions`: `itemCursor`
- `SubtractiveBox__Fiiiiiiii`: `packetCell`
- `UpdateTransition__27tMenuItemGoToMenuButtonFadeb`: `iVar2`
- `UpdateTransition__22tMenuItemLeftRightFadeb`: `iVar2`
- `UpdateTransition__12tOptionsMenu`: `adjusted`, `citem`, `entry`, `item`
- `Draw__12tOptionsMenu`: `adjusted`, `entry`
- `ProcessInput__14tInsideBoxMenu7tPlayerR13tInputKeyTypeR12tMenuCommand`: `tVar2`
- `Draw__14tInsideBoxMenusssss`: `entry10`, `entry6`
- `UpdateTransition__20tMenuItemSlidingMenub`: `iVar2`
- `UpdatefOpenHeight__20tMenuItemSlidingMenub`: `closeH`, `cur`, `fade`, `fadeOut`, `lim`, `newFade`, `shrinkH`, `slide`
- `Draw__20tMenuItemSlidingMenuiib`: `drawX`, `drawY`
- `UpdatefOpenHeight__25tMenuItemSlidingActivatedb`: `arg1`, `iVar2`, `iVar4`
- `UpdateTransition__25tMenuItemSlidingActivatedb`: `iVar2`
- `Draw__31tMenuItemDisplayLeftRightChoiceiib`: `x`, `y`
- `Draw__29tMenuItemOnOffLeftRightChoiceiib`: `x`, `y`
- `Draw__29tMenuItemLeftRightAudioSlideriib`: `brightTextColor`, `rgbVals`
- `UpdateTransition__29tMenuItemLeftRightAudioSliderb`: `iVar1`
- `Draw__18tInsideBoxSongMenusssss`: `drawBaseY`, `fadeValue`, `fe`, `slide`, `width`
- `Draw__34tMenuItemControllerLeftRightChoiceiib`: `w`, `x`, `y`
- `Draw__22tInsideBoxTwoWaySlideriiib`: `fWidth`, `selection`
- `Calibrate__22tInsideBoxTwoWaySlider`: `app`, `minimum`, `padBase`, `padInfo`, `screen`, `value`
- `ProcessInput__17tUserNameMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand`: `character`, `column`, `lastColumn`, `rowBase`, `rowOffset`, `selectedChar`, `soundId`, `stringLength`
- `Draw__17tUserNameMenuItemb`: `boxRight`, `columnx`, `menuStartY`, `right`, `row`
- `UpdateTransition__17tUserNameMenuItemb`: `iVar2`
- `Draw__19tMemoryCardMenuItemb`: `less`, `sVar2`, `sv`, `v`
- `FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib`: `pixels`
- `TextValue__18tListIteratorTrack7tPlayer`: `trackEntry`, `uVar1`
- `DrawTVLines__FR9tTVConfig`: `abe`
- `DrawTV__FR9tTVConfig`: `noiseHeight`, `noiseShapeY`, `packetPtrSlot`, `rgbMask`
- `FECheat_HandleActivation__F10tCheatCode`: `placement`, `placements`
- `FECheat_ActivateCheat__FPc`: `dlgThis`, `feApp`, `wordText`
- `FEInput_GetNoDebounceKey__Fii`: `result`
- `Draw__9tMenuItemiib`: `x`, `y`
- `Draw__9tMenuItemiiib`: `w`
- `ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand`: `frameFiller`
- `Draw__24tMenuItemLeftRightChoiceb`: `x`, `y`
- `ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand`: `frameFiller`, `sound`, `volume`
- `DrawSlider__FsssssssssbT9ss`: `greenVal`, `greenVal2`, `redVal`, `redVal2`
- `ProcessInput__23tMenuItemGoToMenuButton7tPlayerR13tInputKeyTypeR12tMenuCommand`: `frameFiller`
- `GoNonInterlaced__7tScreen`: `backView`, `displayEnv`, `displayHeight`, `frontView`, `playerViewIndex`, `viewHeight`, `viewTable`
- `UpdateTransition__7tScreen`: `fadeValue`, `transitionValue`
- `GetPSXPadValue__Fii`: `acc1`, `acc2`
- `SetPads__Fv`: `waiting`
- `Front_Menu__F21tFront_ProcessingType`: `needCar`, `one`
- `Front_GetLapsForType__Fv`: `uVar1`
- `Front_InitTourneyTraffic__FR9tFEStream`: `maxTraffic`, `tourn`
- `Front_InitOpponentCars__FR9tFEStream`: `numRacers`, `numRacers2`
- `Front_AppendCopData__FPiR9tFEStream`: `carInfo`
- `Front_AppendPerpData__FPiR9tFEStream`: `carInfo`, `carManagerPtr`
- `Front_AppendTrafficData__FPiR9tFEStream`: `carInfo`, `traffic`
- `Front_AppendTrackData__FPiR9tFEStream`: `speedMode`
- `MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand`: `carSelectScreen`, `nextMenu`, `screenState`
- `AskTheUserToSaveTheGame__Fv`: `dlgThis`
- `MenuExtended_GoToCarSelect__FR12tMenuCommand`: `dialog`, `nextMenu`, `screen`, `state`
- `GenericMenuSaveGame__Fi`: `app`, `noInput`
- `PinkSlipsPreSave__Fv`: `dlgThis`
- `MenuExtended_GoToTournTrackInfo__FR12tMenuCommand`: `frontEndBase`, `frontEndState`, `manager`, `selectedTourney`
- `MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand`: `frontEndState`, `manager`, `selectedTourney`
- `MenuExtended_BuyCar__FR12tMenuCommand`: `dialogAnchor`, `pp`
- `GenericMenuLoadGame__Fi`: `app`, `mc`
- `MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand`: `dialogAnchor`, `dlgThis3`, `playerNum`
- `MenuExtended_GoToGarage__FR12tMenuCommand`: `garageIterator`
- `MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand`: `msg`
- `__15tGlobalMenuDefs`: `garageCarItem`, `memoryMenu`, `userNameMenu`
- `Initialize__18tTournamentManager`: `numCars`
- `LoadDescription__18tTournamentManager`: `tourneyDef`, `trackId`, `trnId`
- `StartNewTournament__18tTournamentManagerUcUc`: `fRandOption`, `fTrackOption`, `numCompetitors`, `tourneyDef`, `tourneyDefLocal`, `tourneyInfoOffset`, `trackOffset`
- `IsTournamentFinished__18tTournamentManager`: `currentTourney`
- `tournPointsCompare__FPcT0`: `comps`, `tm`
- `CalcTrackFinishDamageBill__18tTournamentManagerbRlT2`: `mask`
- `UpdateTrackFinishPoints__18tTournamentManager`: `comp`, `knockout`, `next`, `rankVal`, `ranked`, `ranking`, `stats`
- `UpdateCarLineup__18tTournamentManager`: `numCompetitors`
- `GetTournamentFinishPrize__18tTournamentManagers`: `tourn`
- `PlayerRanking__18tTournamentManagers`: `numCompetitors`
- `GetTrophyName__18tTournamentManagerP12tTourneyInfo11tTrophySizePci`: `best`, `t`
- `Confirm__Fii`: `dialog`, `dialogVtable`, `messageDialog`, `messageText`, `noInputDialog`
- `SaveGame__Fs`: `displayDialog`, `dlgmsg`, `message`, `status`, `wd`
- `LoadGame__FsbT1`: `cardshifted`, `dialogBase`, `dialogText`, `dlgmsg`
- `SavePinkSlipsCars__Fss`: `cardInfo`
- `Init__14tCreditManageri`: `arg1`
- `SetupCurrCredit__14tCreditManager`: `advanceRequested`, `backgroundReady`, `currentCredit`, `inputPressed`, `nextCredit`, `startTicksSnapshot`, `textFade`
- `DrawCurrCredit__14tCreditManager`: `tag`
- `DrawDropShadow__11tScreenMain`: `addrMask`, `addr_24`, `palTag`, `pal_link`, `tagMask`
- `DrawBackground__11tScreenMain`: `animationFrame`, `elapsedTicks`, `nextAnimation`, `startMovie`, `videoY`
- `DrawBackground__16tScreenPinkSlips`: `currentItem`, `movieVramX`, `rx`, `ry`, `selected`, `trackIndex`
- `ProcessInput__16tScreenPinkSlips7tPlayerR13tInputKeyTypeR12tMenuCommand`: `defs`
- `DrawBackground__26tScreenTournamentStandings`: `lastRacer`, `numRacers`, `type`
- `DrawCar__FR8tCarInfossffcbUl7tPlayer`: `signedTicks`
- `Cleanup__16tScreenCarSelect`: `vtbl`
- `DrawOverlay__16tScreenCarSelectP8tOverlay`: `flags`, `tournamentMoney`, `xPos`, `yOffset`
- `GetShapeInfo__16tScreenCarSelectRsT1PPcT3`: `vtbl`
- `DrawVideoWall__16tScreenCarSelects`: `vtbl`
- `GetCar__16tScreenCarSelectR8tCarInfo`: `color`
- `DrawBackground__16tScreenCarSelect`: `canUpload`
- `DrawForeground__16tScreenCarSelect`: `currentItemValue`, `fadeBase`, `overlayDirection`, `shapeFade`, `shapeTicks`, `textBase`, `validCarValue`
- `PreLoad__20tScreenCarSelectDuel`: `useDefault`
- `DrawVideoWall__20tScreenCarSelectDuels`: `vtbl`
- `GetShapeInfo__20tScreenCarSelectDuelRsT1PPcT3`: `vtbl`
- `UpdateVideoWall__20tScreenCarSelectDuelR8tCarInfo`: `country`
- `DrawBackground__20tScreenCarSelectDuel`: `elapsed`, `p1Ready`, `p2Ready`
- `GetCar__25tScreenCarSelectTwoPlayerR8tCarInfo`: `player`
- `DrawVideoWall__25tScreenCarSelectTwoPlayers`: `videoOffset`
- `UpdateVideoWall__25tScreenCarSelectTwoPlayerR8tCarInfo`: `country`
- `DrawBackground__25tScreenCarSelectTwoPlayer`: `elapsed`, `loading`, `player`, `uploadReady`, `uploadY`, `vtbl`
- `DoMemCardStuff__25tScreenPinkSlipsCarSelect`: `cardInfo`, `pinkState`, `resultState`, `resultStatePtr`, `stateBase`
- `SetDialog__25tScreenPinkSlipsCarSelect`: `dlg`, `wordnum`
- `GetShapeInfo__18tScreenTournSelectRsT1PPcT3`: `fe`, `trophyTourn`, `useSpecial`
- `Initialize__18tScreenTournSelect`: `fe`, `tvIdx`, `useSpecial`
- `DrawBackground__18tScreenTournSelect`: `descriptionText`, `fe`, `number`, `shapeX`, `tournament`, `tvIdx`
- `GetShapeInfo__17tScreenTrophyRoomRsT1PPcT3`: `cur`
- `Initialize__17tScreenTrophyRoom`: `curIdx`, `loopFe`, `place`, `placement`, `tournIdx`, `tourney`
- `DrawBackground__17tScreenTrophyRoom`: `currentTourn`, `drawFlagsPtr`, `feTier`, `selectedTourn`, `tourn`
- `LoadTrophy__17tScreenTrophyRoom`: `tierIdx`, `tourn`
- `GetShapeInfo__17tScreenTrophyInfoRsT1PPcT3`: `currentTourn`, `feTier`, `idx`, `placement`
- `DrawBackground__17tScreenTrophyInfo`: `currentTourn`, `feTier`, `tourn`, `tournID`
- `DrawBackground__18tScreenTrackSelect`: `packetPtrSlot`, `shapeX`, `startTicks`, `videoWall`, `videoY`
- `ProcessInput__18tScreenTrackSelect7tPlayerR13tInputKeyTypeR12tMenuCommand`: `ptVar1`
- `DrawBackground__16tScreenTrackInfo`: `highlighted`, `screenInfo`, `state`, `trackList`
- `ProcessInput__16tScreenTrackInfo7tPlayerR13tInputKeyTypeR12tMenuCommand`: `fee`
- `SetActuators__23tScreenControllerConfigi`: `pulse`, `tickValue`
- `AnimKeyPoints__23tScreenControllerConfigbT1`: `result`
- `CheckConfigs__23tScreenControllerConfig`: `arrowFadeBelowHalf`, `currentControllerForSwap`, `currentControllerSnapshot`, `previousControllerSnapshot`
- `SetCurrentController__23tScreenControllerConfigb`: `dialog`, `dialogIsIdle`, `menuDefinitions`, `previousNegconChoice`
- `DrawController__23tScreenControllerConfig`: `controller`, `controllerOffset`, `haloX`, `iy`, `modeBase`, `offsets`, `rangeValue`, `row`, `shockImpactActive`, `shockModeActive`, `x`, `xOffset`
- `DrawBackground__23tScreenControllerConfig`: `om`
- `DrawForeground__23tScreenControllerConfig`: `copyCount`, `dialog`, `flag`, `selectedConfig`, `textLength`, `textLocationIn`, `textLocationOut`, `textWidth`
- `Initialize__23tScreenControllerConfig`: `b`, `mode`
- `PlaySound__12tScreenAudio`: `validItem`
- `DrawForeground__12tScreenAudio`: `fadeCalc`
- `DrawBackground__12tScreenAudio`: `displayPercent`, `fadeValue`, `optionsMenu`
- `Initialize__12tScreenAudio`: `menus`
- `Cleanup__12tScreenAudio`: `info`
- `DrawIcon__14tScreenMemcardP8shapetbliiiis`: `u`
- `LoadIcon__14tScreenMemcardi`: `cardInfo`, `one`, `pulled`
- `DrawVerticalLine__14tScreenMemcardssss`: `innerHeight`, `pos`, `shifted`, `test`
- `DrawHorizontalLine__14tScreenMemcardssss`: `pos`, `shifted`, `test`, `width`
- `PlaceIcons__14tScreenMemcardii`: `animFrame`, `nfs4Icon`, `numIcons`, `savedY`, `tickFrame`, `tickPtr`
- `DrawBackground__14tScreenMemcard`: `gouraudX`, `gouraudY`, `h`, `startX`, `startY`, `w`
- `DrawForeground__14tScreenMemcard`: `fade`
- `Initialize__14tScreenMemcard`: `msgId`
- `GetShapeInfo__15tScreenCongratsRsT1PPcT3`: `numRanked`
- `DrawBackground__15tScreenCongrats`: `spinTicks`, `vtbl`
- `CalculatePrizes__15tScreenCongrats`: `carCXBits`, `carCYBits`
- `Initialize__15tScreenCongrats`: `vtbl`
- `ProcessInput__15tScreenCongrats7tPlayerR13tInputKeyTypeR12tMenuCommand`: `bConsumeKey`
- `CalculatePrizes__23tScreenPinkSlipCongrats`: `player`
- `CalculatePrizes__23tScreenTournamentTrophy`: `carCXBits`, `cashAwarded`, `knockout`, `ranked`
- `StatChk_SaveRecordLapTime__FP10Car_tStatsss`: `newBestLap`
- `StatChk_SaveTopTime__FP10Car_tStatss`: `uRecSz`
- `Stattool_nCreateIndex__FiPiPs`: `one`
- `Stattool_ParseTime__FiPc`: `min`, `sec`
- `Stattool_CheckForHumanCar__FP10Car_tStats`: `nNumCars`
- `Stattool_GetAINameFromPersonality__F14tPersonalities`: `namePtr`
- `DrawBackground__15tScreenUserName`: `fadeboxv`, `gridposv`
- `CalcOnOffFade__F13tMenuTextTypesssRiT4`: `baseA`, `baseB`, `baseC`

## Explicit oracle-proven function type overrides


## Object-owned global/storage review

- `statchk.cpp` blob-backed definitions: `NewBestLap`, `NewRecords`
- No ownership, storage-class, or type findings.
