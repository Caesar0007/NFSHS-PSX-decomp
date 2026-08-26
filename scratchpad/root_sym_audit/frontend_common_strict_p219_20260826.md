# SYM-to-source declaration audit

Target: `C:\Temp\nfs4-sym-next-20260825\recon\frontend\common`
Trusted SYM: `C:\Temp\claud\dumpsym_clean\dumpsym_src\nfs4-f-v3.txt`

This is a review queue, not an auto-fix list. Missing retail names are
strong evidence; extra source names can be matching carriers or decompiler
temporaries and must be tested against the function oracle before removal.
GCC-v2-mangled function/EXT names are used only as linkage keys; source
functions are mapped to their demangled C++ names and class scopes.

## Summary

- SYM functions in target TUs: 781
- Mapped to reconstructed definitions: 779 (779 demangled class/name maps)
- Source definitions still using mangled linkage identifiers: 0
- Explicit deleting-destructor ABI carriers: 0
- Explicit cross-TU ownership closures: 0
- Declaration-clean mapped functions: 753
- Missing SYM names: 0
- Extra source-local names: 226
- Type-comparison findings: 0
- Recognized ABI/debug-equivalent type encodings: 245
  (generic-function-pointer=12, promoted-stack-argument=26, reference-as-pointer=207)
- Function storage-class findings: 0
- Implicit aggregate special members (source body correctly absent): 2
- Explicit oracle-receipted carrier mappings: 3
- Explicit restored inline-local mappings: 60
- Explicit restored macro-local mappings: 0
- Explicit linkage-proven ABI parameters omitted from SYM: 19
- Explicit source-only codegen carriers: 389
- Explicit oracle-proven function type overrides: 0
- Functions needing mapping review: 0
- SYM object-owned data records in target TUs: 190
- Mapped source global definitions: 190
- Blob-backed object globals: 0
- Missing/extra global definitions: 0/0
- Global storage-class findings: 0
- Explicit oracle-proven global storage overrides: 0
- Global type findings: 0
- Recognized global debug-equivalent types: 0
  (none)
- Explicit measured global array carriers: 13
- Explicit oracle-proven global type overrides: 2

## Review queue

### `MainLoop__14tFEApplicationP5tMenu` (0x800142a4, feapp.cpp:907, map=exact)

- Extra source locals: `currentScreen`, `iVar10`, `inputFlags`, `menuFlags`, `pa_Var11`, `pa_Var12`, `ptVar17`, `ptVar18`, `this_tDialogBase_l181`, `this_tDialogMessageString_l311`, `this_tMenu_l139`, `this_tMenu_l92`, `ticksValue`

### `GoNonInterlaced__7tScreen` (0x80025bf8, fescreen.cpp:77, map=exact)

- Extra source locals: `dispY`, `env`, `height`, `iVar1`, `iVar2`, `playerView`, `sVar3`, `view0`, `view1`, `views`

### `MenuExtended_GoToDealer__FR12tMenuCommand` (0x8002c890, femenudefs.cpp:630, map=exact)

- Extra source locals: `cmd`, `cmdType`, `dlgThis`, `ptVar1`, `state`

### `MenuExtended_GoToSeller__FR12tMenuCommand` (0x8002c8f8, femenudefs.cpp:676, map=exact)

- Extra source locals: `cmd`, `cmdType`, `dlgThis`, `ptVar1`, `state`

### `MenuExtended_GoToTournTrackInfo__FR12tMenuCommand` (0x8002cf40, femenudefs.cpp:1084, map=exact)

- Extra source locals: `fe`, `feUse`, `iVar6`, `iVar7`, `pcVar5`, `pp`, `ptVar1`, `ptVar2`, `ptVar3`, `sVar4`, `this_00`, `tm`, `tsaved`

### `MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand` (0x8002d0a8, femenudefs.cpp:1181, map=exact)

- Extra source locals: `fe`, `iVar6`, `iVar7`, `pcVar5`, `pp`, `ptVar1`, `ptVar2`, `ptVar3`, `sVar4`, `this_00`, `tm`, `tsaved`

### `MenuExtended_BuyCar__FR12tMenuCommand` (0x8002d4f8, femenudefs.cpp:1561, map=exact)

- Extra source locals: `command`, `dlgThis`, `lVar3`, `pcVar4`, `pp`, `ptVar1`, `sVar2`, `this_00`

### `MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand` (0x8002de74, femenudefs.cpp:2265, map=exact)

- Extra source locals: `dlgThis2`, `dlgThis3`, `pcVar5`, `playerNum`, `ptVar2`, `ptVar3`, `this_00`

### `MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand` (0x8002e21c, femenudefs.cpp:2573, map=exact)

- Extra source locals: `dlgThis`, `fmt`, `iVar5`, `msg`, `pcVar4`, `ptVar2`, `sVar3`

### `DrawBackground__11tScreenMain` (0x800379c0, screenmain.cpp:403, map=exact)

- Extra source locals: `el`, `frameIdx`, `iVar10`, `iVar5`, `iVar7`, `sVar3`, `str`, `uFade`, `uVar6`, `uVar9`, `vy`

### `DrawBackground__16tScreenPinkSlips` (0x80038b68, screenpinkslips.cpp:21, map=exact)

- Extra source locals: `currentItem`, `movieVramX`, `pulse`, `rx`, `ry`, `selected`, `trackIndex`

### `DrawBackground__26tScreenTournamentStandings` (0x80039b84, screenpost.cpp:310, map=exact)

- Extra source locals: `bonus`, `halfWidth`, `lastRacer`, `line`, `numRacers`, `self`, `tm`, `type`

### `Initialize__16tScreenCarSelect` (0x8003bd88, screencarselect.cpp:663, map=exact)

- Extra source locals: `fadeTick`, `mdefs`, `sVar2`, `showroomTick`, `uVar6`, `valid`

### `DrawForeground__16tScreenCarSelect` (0x8003c7d8, screencarselect.cpp:1082, map=exact)

- Extra source locals: `currentItemValue`, `fadeBase`, `overlayDirection`, `shapeFade`, `shapeTicks`, `textBase`, `validCarValue`

### `DrawBackground__20tScreenCarSelectDuel` (0x8003d7f0, screencarselect.cpp:1598, map=exact)

- Extra source locals: `bVar1`, `bVar2`, `creditsTextVal`, `elapsed`, `sVar2`, `screenVtbl`, `screenVtbl2`, `vtbl`

### `DrawBackground__25tScreenCarSelectTwoPlayer` (0x8003e4bc, screencarselect.cpp:1967, map=exact)

- Extra source locals: `bVar1`, `brightness`, `carY_2`, `cur_pkt`, `cur_pkt_2`, `elapsed`, `pkt_addr24`, `pkt_addr24_2`, `player`, `sVar3`, `screenVtbl`, `screenVtbl2`, `ti7`, `ts10`, `ts3`, `vtbl`

### `DrawBackground__18tScreenTournSelect` (0x8003fe5c, screentournselect.cpp:259, map=exact)

- Extra source locals: `descriptionText`, `fe`, `number`, `shapeX`, `tournament`, `tvIdx`, `word`

### `Initialize__17tScreenTrophyRoom` (0x80040910, screentrophyroom.cpp:129, map=exact)

- Extra source locals: `curIdx`, `fe`, `loaded`, `loopFe`, `place`, `placement`, `tournIdx`, `tourney`

### `DrawBackground__17tScreenTrophyInfo` (0x80041138, screentrophyinfo.cpp:92, map=exact)

- Extra source locals: `currentTourn`, `definition`, `fade`, `feTier`, `tourn`, `tournID`, `tournamentIndex`, `tournaments`, `word`

### `DrawBackground__18tScreenTrackSelect` (0x80041600, screentracks.cpp:14, map=exact)

- Extra source locals: `addrMask`, `creditsTextVal`, `packetPtrSlot`, `shapeX`, `startTicks`, `videoWall`, `videoY`

### `ProcessInput__18tScreenTrackSelect7tPlayerR13tInputKeyTypeR12tMenuCommand` (0x8004200c, screentracks.cpp:412, map=exact)

- Extra source locals: `cmdResult`, `command`, `menuVtbl`, `player`, `ptVar1`, `pvVar2`, `trafficFlags`

### `DrawController__23tScreenControllerConfig` (0x80043de4, screencontroller.cpp:620, map=exact)

- Extra source locals: `controller`, `controllerOffset`, `haloX`, `iy`, `modeBase`, `offsets`, `rangeValue`, `row`, `shockImpactActive`, `shockModeActive`, `x`, `xOffset`

### `DrawForeground__23tScreenControllerConfig` (0x80045064, screencontroller.cpp:1168, map=exact)

- Extra source locals: `candidate`, `config`, `controller`, `dialog`, `flag`, `n`, `pTL`, `pTextLoc`, `squareWidth`, `textLength`, `textWidth`

### `PlaceIcons__14tScreenMemcardii` (0x80046a0c, screenmemcard.cpp:374, map=exact)

- Extra source locals: `animFrame`, `icon`, `nfs4Icon`, `numIcons`, `savedY`, `tickFrame`, `tickPtr`

### `DrawBackground__14tScreenMemcard` (0x80047470, screenmemcard.cpp:744, map=exact)

- Extra source locals: `extraY`, `gouraudX`, `gouraudY`, `h`, `startX`, `startY`, `w`, `width`

### `CalculatePrizes__23tScreenTournamentTrophy` (0x8004923c, screencongrats.cpp:711, map=exact)

- Extra source locals: `carCXBits`, `cashAwarded`, `knockout`, `loopLimit`, `money`, `numRanked`, `ranked`

## Implicit aggregate special members

- `__11tAllScreens` (0x8002baf4, `front.cpp`): implicit `tAllScreens` constructor; emitted from the aggregate member graph at the recorded declaration line, so an explicit source body would be incorrect.
- `_._11tAllScreens` (0x8002bf0c, `front.cpp`): implicit `tAllScreens` destructor; emitted from the aggregate member graph at the recorded declaration line, so an explicit source body would be incorrect.
## Explicit SYM carrier/optimization mappings

- `FECheat_HandleActivation__F10tCheatCode`: `num`
- `SetupCurrCredit__14tCreditManager`: `lasttick`
- `DrawBackground__25tScreenCarSelectTwoPlayer`: `carInfo`

## Explicit restored inline-local mappings

- `DrawHelpIcons__14tFEApplication`: `this` from `HasOptionsMenu`
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
- `MenuExtended_EnterUserName__FR12tMenuCommand`: `data` from `SetUserNameData`, `m` from `SetCallingMenu`, `this` from `SetCallingMenu`, `this` from `SetUserNameData`
- `MenuExtended_SellCar__FR12tMenuCommand`: `this` from `DisplayMessage`, `this` from `SetString`
- `MenuExtended_PurchaseUpgrade__Fi`: `this` from `DisplayMessage`
- `MenuExtended_LoadGame__FR12tMenuCommand`: `this` from `SetChoices`
- `MenuExtended_PostGameMenu__FR12tMenuCommand`: `this` from `SetDrawMoney`
- `MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand`: `m` from `SetCallingMenu`, `this` from `SetCallingMenu`, `this` from `SetPostGameNameData`
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

## Explicit source-only codegen carriers

- `Redraw__14tFEApplication`: `globalMenuDefs`, `pal2`, `pc`
- `SetScreen__14tFEApplicationsP7tScreen`: `iVar1`, `this_00`
- `DisplayHelp__14tFEApplications`: `this_tDialogHelp`
- `RunDemoVideo__14tFEApplication`: `largest`, `menu`, `vtbl`
- `RunPostGame__14tFEApplication`: `item`, `screen`
- `FeAudio_InitCommentary__Fii`: `arg1`
- `CalcUsedPrice__11tCarManagers`: `carID`, `upgrades`
- `SellCar__11tCarManagerss`: `lastSlotOffset`, `newSelection`, `numCars`, `playerFrontEnd`, `previousSlotOffset`, `removedSlotOffset`, `selectedSlotOffset`
- `RemoveFromPinkSlipsList__11tCarManagerss`: `lastSlotOffset`, `newSelection`, `numCars`, `playerFrontEnd`, `previousSlotOffset`, `removedSlotOffset`, `selectedSlotOffset`
- `GetStockCar__11tCarManagersR8tCarInfo`: `uVar1`
- `GetNumTourneyCars__11tCarManagers`: `carID`
- `ValidCar__16tListIteratorCar7tPlayerc`: `carClass`
- `Increment__21tListIteratorCarColor7tPlayer`: `fNumColors`, `notWrapped`
- `Draw__11tDialogHelp`: `bufferPtr`, `firstTick`, `loadedTicks`
- `MenuNFS4_DrawTextBox__FiR4RECTissbT5`: `fade`, `selFade`, `textType`
- `TransitionIsFinished__9tMenuNFS4`: `iVar2`, `iVar4`, `ptVar1`, `uVar3`
- `Draw__9tMenuNFS4`: `iVar3`, `iVar4`
- `TransitionOff__12tMenuOptions`: `iVar1`
- `TransitionOn__12tMenuOptions`: `enterTicks`, `itemCursor`
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
- `TransitionOn__17tUserNameMenuItem`: `dst`
- `UpdateTransition__17tUserNameMenuItemb`: `iVar2`
- `Draw__19tMemoryCardMenuItemb`: `less`, `sVar2`, `sv`, `v`
- `FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib`: `pixels`
- `TextValue__18tListIteratorTrack7tPlayer`: `trackEntry`, `uVar1`
- `DrawTVLines__FR9tTVConfig`: `abe`
- `DrawTV__FR9tTVConfig`: `noiseHeight`, `noiseShapeY`, `packetPtrSlot`, `rgbMask`
- `FECheat_HandleActivation__F10tCheatCode`: `placement`, `placements`
- `FECheat_ActivateCheat__FPc`: `dlgThis`, `pcVar4`, `ptVar2`
- `FEInput_GetNoDebounceKey__Fii`: `result`
- `Draw__9tMenuItemiib`: `x`, `y`
- `Draw__9tMenuItemiiib`: `w`
- `ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand`: `frameFiller`
- `Draw__24tMenuItemLeftRightChoiceb`: `x`, `y`
- `ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand`: `frameFiller`, `sound`, `volume`
- `DrawSlider__FsssssssssbT9ss`: `greenVal`, `greenVal2`, `redVal`, `redVal2`
- `ProcessInput__23tMenuItemGoToMenuButton7tPlayerR13tInputKeyTypeR12tMenuCommand`: `frameFiller`
- `TransitionOff__7tScreen22tScreen_TransitionTypeP5tMenu`: `arg2`, `iVar1`
- `TransitionOn__7tScreen22tScreen_TransitionTypeP5tMenu`: `arg2`, `iVar1`
- `UpdateTransition__7tScreen`: `fadeValue`, `transitionValue`
- `GetPSXPadValue__Fii`: `acc`
- `SetPads__Fv`: `waiting`
- `Front_Menu__F21tFront_ProcessingType`: `needCar`, `one`
- `Front_GetLapsForType__Fv`: `uVar1`
- `Front_InitTourneyTraffic__FR9tFEStream`: `maxTraffic`, `tourn`
- `Front_InitOpponentCars__FR9tFEStream`: `numRacers`, `numRacers2`
- `Front_AppendCopData__FPiR9tFEStream`: `carInfo`
- `Front_AppendPerpData__FPiR9tFEStream`: `carInfo`, `carManagerPtr`
- `Front_AppendTrafficData__FPiR9tFEStream`: `carInfo`, `traffic`
- `Front_AppendTrackData__FPiR9tFEStream`: `speedMode`
- `Front_EnableLocalSpeech__Fv`: `lang`
- `Front_BuildStream__FPi`: `randomSeed`
- `MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand`: `carSelectScreen`, `dialog`, `menuDefinitions`, `nextMenu`, `screenState`
- `AskTheUserToSaveTheGame__Fv`: `dlgThis`
- `MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand`: `ptVar1`
- `MenuExtended_GoToCarSelect__FR12tMenuCommand`: `dialog`, `nextMenu`, `screen`, `state`
- `MenuExtended_GoToUpgrades__FR12tMenuCommand`: `ptVar1`
- `GenericMenuSaveGame__Fi`: `app`, `noInput`
- `PinkSlipsPreSave__Fv`: `dlgThis`
- `MenuExtended_EnterUserName__FR12tMenuCommand`: `defs`, `player`
- `MenuExtended_GoToShowroom__FR12tMenuCommand`: `ptVar1`
- `MenuExtended_GoToDealerShowroom__FR12tMenuCommand`: `ptVar1`
- `GenericMenuLoadGame__Fi`: `app`, `mc`
- `MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand`: `defs`
- `MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand`: `defs`
- `MenuExtended_GoToGarage__FR12tMenuCommand`: `garageIterator`
- `MenuExtended_ExitTourney__FR12tMenuCommand`: `dialog`
- `__15tGlobalMenuDefs`: `memoryMenu`, `userNameMenu`
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
- `Decrement__23tListIteratorTournament7tPlayer`: `value`
- `Confirm__Fii`: `dialog`, `dialogVtable`, `displayDialog`, `feApp`, `messageDialog`, `messageText`, `noInputDialog`
- `SaveGame__Fs`: `displayDialog`, `dlgmsg`, `message`, `status`, `wd`
- `LoadGame__FsbT1`: `cardshifted`, `dialogBase`, `dialogText`, `dlgmsg`
- `SavePinkSlipsCars__Fss`: `pCVar7`
- `Init__14tCreditManageri`: `arg1`
- `Draw__14tCreditManagerb`: `mainScreen`
- `SetupCurrCredit__14tCreditManager`: `advanceRequested`, `backgroundReady`, `currentCredit`, `inputPressed`, `nextCredit`, `startTicksSnapshot`, `textFade`
- `DrawCurrCredit__14tCreditManager`: `frameTick`, `pixelWidth`, `subTitleFadeBase`, `tag`, `text`, `titleFadeBase`
- `TurnOff__10tVideoWall`: `tickCounter`
- `TurnOn__10tVideoWall`: `tickCounter`
- `DrawDropShadow__11tScreenMain`: `addrMask`, `addr_24`, `palTag`, `pal_link`, `tagMask`
- `Initialize__16tScreenPinkSlips`: `iVar1`, `tmp`
- `ProcessInput__16tScreenPinkSlips7tPlayerR13tInputKeyTypeR12tMenuCommand`: `defs`
- `DrawBackground__24tScreenPinkSlipStandings`: `halfWidth`
- `DrawCar__FR8tCarInfossffcbUl7tPlayer`: `signedTicks`
- `Cleanup__16tScreenCarSelect`: `vtbl`
- `DrawOverlay__16tScreenCarSelectP8tOverlay`: `flags`, `tournamentMoney`, `xPos`, `yOffset`
- `CalcSplinePosition__16tScreenCarSelectiiiiUlRiN46`: `_i`
- `GetShapeInfo__16tScreenCarSelectRsT1PPcT3`: `vtbl`
- `UpdateVideoWall__16tScreenCarSelectR8tCarInfo`: `bVar1`
- `DrawVideoWall__16tScreenCarSelects`: `vtbl`
- `GetCar__16tScreenCarSelectR8tCarInfo`: `uVar1`
- `DrawBackground__16tScreenCarSelect`: `canUpload`
- `PreLoad__20tScreenCarSelectDuel`: `useDefault`
- `DrawVideoWall__20tScreenCarSelectDuels`: `vtbl`
- `GetShapeInfo__20tScreenCarSelectDuelRsT1PPcT3`: `vtbl`
- `UpdateVideoWall__20tScreenCarSelectDuelR8tCarInfo`: `bVar1`
- `GetCar__25tScreenCarSelectTwoPlayerR8tCarInfo`: `player`
- `DrawVideoWall__25tScreenCarSelectTwoPlayers`: `videoOffset`
- `UpdateVideoWall__25tScreenCarSelectTwoPlayerR8tCarInfo`: `bVar1`
- `DoMemCardStuff__25tScreenPinkSlipsCarSelect`: `cardInfo`, `pinkState`, `resultState`, `resultStatePtr`, `stateBase`
- `SetDialog__25tScreenPinkSlipsCarSelect`: `dlg`, `wordnum`
- `GetShapeInfo__18tScreenTournSelectRsT1PPcT3`: `fe`, `trophyTourn`, `useSpecial`
- `Initialize__18tScreenTournSelect`: `fe`, `tvIdx`, `useSpecial`
- `GetShapeInfo__17tScreenTrophyRoomRsT1PPcT3`: `cur`
- `DrawBackground__17tScreenTrophyRoom`: `currentTourn`, `drawFlagsPtr`, `feTier`, `selectedTourn`, `tourn`
- `LoadTrophy__17tScreenTrophyRoom`: `tierIdx`, `tourn`
- `GetShapeInfo__17tScreenTrophyInfoRsT1PPcT3`: `currentTourn`, `feTier`, `idx`, `placement`
- `GetShapeInfo__16tScreenTrackInfoRsT1PPcT3`: `dayTimes2`, `weatherPlus`
- `DrawBackground__16tScreenTrackInfo`: `highlighted`, `screenInfo`, `state`, `trackList`
- `ProcessInput__16tScreenTrackInfo7tPlayerR13tInputKeyTypeR12tMenuCommand`: `fee`
- `DrawBackground__19tScreenTrackRecords`: `clampTmp`, `half`, `lineFadeCalc`
- `SetActuators__23tScreenControllerConfigi`: `pulse`, `tickValue`
- `Controller_SetRamp__Fv`: `one`
- `AnimKeyPoints__23tScreenControllerConfigbT1`: `result`
- `CheckConfigs__23tScreenControllerConfig`: `arrowFadeBelowHalf`, `currentControllerForSwap`, `currentControllerSnapshot`, `previousControllerSnapshot`
- `SetCurrentController__23tScreenControllerConfigb`: `dialog`, `dialogIsIdle`, `menuDefinitions`, `previousNegconChoice`
- `DrawArrow__23tScreenControllerConfigPs`: `clampVal`
- `DrawBackground__23tScreenControllerConfig`: `om`
- `Initialize__23tScreenControllerConfig`: `b`, `mode`
- `PlaySound__12tScreenAudio`: `validItem`
- `DrawForeground__12tScreenAudio`: `fadeCalc`
- `DrawBackground__12tScreenAudio`: `displayPercent`, `fadeValue`, `optionsMenu`
- `Initialize__12tScreenAudio`: `audioMode`, `menus`
- `Cleanup__12tScreenAudio`: `info`
- `DrawIcon__14tScreenMemcardP8shapetbliiiis`: `u`
- `LoadIcon__14tScreenMemcardi`: `cardInfo`, `one`, `pulled`
- `DrawVerticalLine__14tScreenMemcardssss`: `innerHeight`, `pos`, `shifted`, `test`
- `DrawHorizontalLine__14tScreenMemcardssss`: `pos`, `shifted`, `test`, `width`
- `DrawBackground__14tScreenMemcard`: `these`
- `DrawForeground__14tScreenMemcard`: `fade`
- `Initialize__14tScreenMemcard`: `feApp`, `menus`, `msgId`
- `Cleanup__14tScreenMemcard`: `iconTable`, `menus`
- `GetShapeInfo__15tScreenCongratsRsT1PPcT3`: `numRanked`
- `DrawBackground__15tScreenCongrats`: `spinTicks`, `vtbl`
- `CalculatePrizes__15tScreenCongrats`: `carCXBits`, `carCYBits`
- `Initialize__15tScreenCongrats`: `vtbl`
- `ProcessInput__15tScreenCongrats7tPlayerR13tInputKeyTypeR12tMenuCommand`: `bConsumeKey`
- `CalculatePrizes__23tScreenPinkSlipCongrats`: `base`, `player`, `speechId2`
- `StatChk_SaveRecordLapTime__FP10Car_tStatsss`: `newBestLap`
- `StatChk_SaveTopTime__FP10Car_tStatss`: `uRecSz`
- `StatChk_ClearNewRecords__Fv`: `pRec`
- `Stattool_nCreateIndex__FiPiPs`: `one`
- `Stattool_ParseTime__FiPc`: `min`, `sec`
- `Stattool_CheckForHumanCar__FP10Car_tStats`: `nNumCars`
- `Stattool_GetAINameFromPersonality__F14tPersonalities`: `namePtr`
- `DrawVerticalLine__15tScreenUserNamesss`: `depth`
- `DrawHorizontalLine__15tScreenUserNamesss`: `depth`
- `DrawBackground__15tScreenUserName`: `fadeboxv`, `gridposv`, `textfadev`
- `CalcOnOffFade__F13tMenuTextTypesssRiT4`: `baseA`, `baseB`, `baseC`

## Explicit oracle-proven function type overrides


## Object-owned global/storage review

- No ownership, storage-class, or type findings.
