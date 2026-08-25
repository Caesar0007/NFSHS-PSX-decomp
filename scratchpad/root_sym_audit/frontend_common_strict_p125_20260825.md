# SYM-to-source declaration audit

Target: `C:\Temp\nfs4-sym-next-20260825\recon\frontend\common`
Trusted SYM: `C:\Temp\nfs4-clean\nfs4-f-v3.txt`

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
- Declaration-clean mapped functions: 662
- Missing SYM names: 0
- Extra source-local names: 684
- Type-comparison findings: 0
- Recognized ABI/debug-equivalent type encodings: 246
  (generic-function-pointer=12, promoted-stack-argument=26, reference-as-pointer=208)
- Function storage-class findings: 0
- Implicit aggregate special members (source body correctly absent): 2
- Explicit oracle-receipted carrier mappings: 4
- Explicit restored inline-local mappings: 4
- Explicit restored macro-local mappings: 0
- Explicit source-only codegen carriers: 195
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

### `SellCar__11tCarManagerss` (0x8001652c, fecars.cpp:229, map=exact)

- Extra source locals: `chk`, `fePlayer`, `nc`, `newSel`, `prevSlot`, `slot`, `slot31`

### `RemoveFromPinkSlipsList__11tCarManagerss` (0x800167b8, fecars.cpp:364, map=exact)

- Extra source locals: `chk`, `fePlayer`, `nc`, `newSel`, `prevSlot`, `slot`, `slot31`

### `GetGarageCar__11tCarManagersR8tCarInfos` (0x80016f4c, fecars.cpp:687, map=exact)

- Extra source locals: `iVar3`, `iVar5`, `src`, `uVar1`, `uVar2`, `uVar4`

### `FindSimilarCar__11tCarManagerR10tCarModelsRcsP10tCarModels` (0x80017718, fecars.cpp:987, map=exact)

- Extra source locals: `arg3`, `arg4`, `bVar1`, `iVar5`, `uVar7`

### `CalculateDimensions__11tDialogHelp` (0x80018b90, fedialog.cpp:228, map=exact)

- Extra source locals: `canContinue`, `currentTicks`, `openHeight`, `openWidth`, `padState`, `scanMenu`, `shape3`

### `Draw__11tDialogHelp` (0x8001912c, fedialog.cpp:401, map=exact)

- Extra source locals: `bufferPtr`, `buttonY`, `firstTick`, `loadedTicks`, `pa_Var3`

### `CalculateDimensions__20tDialogMessageString` (0x80019418, fedialog.cpp:500, map=exact)

- Extra source locals: `clampedFade`, `fade_or_h`, `iVar2`, `shapeHeight`, `shapeWidth`, `tick_age`

### `Draw__20tDialogMessageString` (0x8001962c, fedialog.cpp:570, map=exact)

- Extra source locals: `halfw`, `idx`, `pa_Var1`, `rh`

### `Run__18tDialogInteractive` (0x800197e8, fedialog.cpp:654, map=exact)

- Extra source locals: `bVar2`, `helpPopup`, `iVar5`, `iVar6`, `pa_Var3`

### `Draw__12tDialogYesNo` (0x80019b44, fedialog.cpp:833, map=exact)

- Extra source locals: `idx`, `pa_Var3`, `ptVar8`, `rgbBase`, `sMenuText`, `sVar1`, `sVar2`, `textBase`

### `Draw__28tMenuItemNFS4LeftRightChoiceiib` (0x8001a8c8, femenuextended.cpp:332, map=exact)

- Extra source locals: `bVar3`, `iVar2`, `sVar1`, `sVar4`, `string`

### `Draw__31tMenuItemOptionsLeftRightChoiceiib` (0x8001abe0, femenuextended.cpp:480, map=exact)

- Extra source locals: `pa_Var4`, `pcVar3`, `ptVar5`, `sVar2`, `y_00`

### `TransitionOn__29tMenuItemOptionsTwoItemChoice` (0x8001adb8, femenuextended.cpp:524, map=exact)

- Extra source locals: `bVar`, `cVar1`, `pa_Var3`, `ptVar2`

### `Draw__29tMenuItemOptionsTwoItemChoiceiib` (0x8001ae14, femenuextended.cpp:554, map=exact)

- Extra source locals: `cVar2`, `pa_Var7`, `pcVar5`, `ptVar4`, `sVar3`, `sVar6`

### `Draw__12tOptionsMenu` (0x8001cb04, femenuoptions.cpp:557, map=exact)

- Extra source locals: `adjusted`, `bVar4`, `entry`, `pa_Var2`, `ptVar1`

### `Draw__14tInsideBoxMenusssss` (0x8001cefc, femenuoptions.cpp:698, map=exact)

- Extra source locals: `arg5`, `entry10`, `entry6`, `item`

### `Draw__20tMenuItemSlidingMenuiib` (0x8001d63c, femenuoptions.cpp:1048, map=exact-signature)

- Extra source locals: `draw`, `drawFlagsPtr`, `drawX`, `drawY`, `right`

### `ProcessInput__25tMenuItemSlidingActivated7tPlayerR13tInputKeyTypeR12tMenuCommand` (0x8001df44, femenuoptions.cpp:1358, map=exact)

- Extra source locals: `iVar2`, `pAVar1`, `pa_Var3`, `ptVar4`

### `Draw__31tMenuItemDisplayLeftRightChoiceiib` (0x8001e230, femenuoptions.cpp:1455, map=exact)

- Extra source locals: `pa_Var4`, `ptVar5`, `sMenuText`, `sVar1`, `selected`, `x`, `y`

### `Draw__29tMenuItemOnOffLeftRightChoiceiib` (0x8001e384, femenuoptions.cpp:1504, map=exact)

- Extra source locals: `cVar1`, `pa_Var3`, `ptVar6`, `selected`, `x`, `y`

### `Draw__29tMenuItemLeftRightAudioSlideriib` (0x8001e570, femenuoptions.cpp:1576, map=exact)

- Extra source locals: `iVar6`, `pa_Var3`, `ptVar4`, `rgbVals`, `sMenuText`, `selected`, `uVar1`, `uVar5`

### `Draw__18tInsideBoxSongMenusssss` (0x8001e9d8, femenuoptions.cpp:1779, map=exact)

- Extra source locals: `drawBaseY`, `fadeValue`, `fe`, `slide`, `width`

### `Draw__34tMenuItemControllerLeftRightChoiceiib` (0x8001f084, femenuoptions.cpp:1985, map=exact)

- Extra source locals: `pa_Var7`, `pcVar6`, `ptVar8`, `sVar2`, `selected`, `w`, `x`, `y`

### `Draw__25tInsideBoxLeftRightSlideriiib` (0x8001f2f0, femenuoptions.cpp:2070, map=exact)

- Extra source locals: `pa_Var3`, `ptVar4`, `sMenuText`, `selected`, `uVar1`

### `Draw__22tInsideBoxTwoWaySlideriiib` (0x8001f5a0, femenuoptions.cpp:2177, map=exact)

- Extra source locals: `fWidth`, `pa_Var4`, `ptVar5`, `sMenuText`, `sVar1`, `selected`, `uVar2`

### `Calibrate__22tInsideBoxTwoWaySlider` (0x8001f918, femenuoptions.cpp:2280, map=exact)

- Extra source locals: `app`, `minimum`, `padBase`, `padInfo`, `screen`, `value`

### `ProcessInput__17tUserNameMenuItem7tPlayerR13tInputKeyTypeR12tMenuCommand` (0x8001fd2c, femenuoptions.cpp:2451, map=exact)

- Extra source locals: `bVar1`, `command`, `fromPlayer`, `iVar9`, `rowOffset`, `sVar4`, `sfxArg`, `uVar10`, `uVar5`, `wrapColumn`

### `Draw__17tUserNameMenuItemb` (0x8002017c, femenuoptions.cpp:2654, map=exact)

- Extra source locals: `boxRight`, `columnx`, `menuStartY`, `right`, `row`, `selected`

### `LoadDescription__13tTrackManager` (0x80021b14, fetracks.cpp:74, map=exact)

- Extra source locals: `addr`, `dst`, `iVar3`, `one`, `pcVar2`, `uVar1`, `uVar4`

### `DrawTV__FR9tTVConfig` (0x8002234c, fetv.cpp:240, map=exact)

- Extra source locals: `noiseHeight`, `noiseShapeY`, `packetPtrSlot`, `palette`, `palette2`, `paletteTag`, `paletteTag2`, `rgbMask`, `rpal`, `rtag`, `tagMask`

### `InitTV__FR9tTVConfigP18tTexture_ShapeInfos` (0x80023008, fetv.cpp:537, map=exact)

- Extra source locals: `iVar4`, `iVar5`, `uVar1`, `uVar2`, `uVar3`

### `FECheat_EncodeString__FPcT0` (0x80023410, fecheats.cpp:139, map=exact)

- Extra source locals: `iVar6`, `pbVar4`, `pcVar1`, `pcVar2`, `pcVar3`, `uVar5`

### `FECheat_ActivateCheat__FPc` (0x80023614, fecheats.cpp:227, map=exact)

- Extra source locals: `dlgThis`, `pcVar4`, `ptVar2`

### `ProcessInput__24tMenuItemLeftRightChoice7tPlayerR13tInputKeyTypeR12tMenuCommand` (0x8002497c, femenu.cpp:621, map=exact)

- Extra source locals: `SFXnum`, `command`, `frameFiller`, `pa_Var2`, `ptVar3`, `uVar1`

### `Draw__24tMenuItemLeftRightChoiceb` (0x80024a2c, femenu.cpp:664, map=exact)

- Extra source locals: `iVar1`, `iVar2`, `index`, `pa_Var3`, `textState`

### `ProcessInput__24tMenuItemLeftRightSlider7tPlayerR13tInputKeyTypeR12tMenuCommand` (0x80024b84, femenu.cpp:725, map=exact)

- Extra source locals: `command`, `frameFiller`, `pcVar3`, `ptVar4`, `sVar1`, `uVar2`

### `DrawSlider__FsssssssssbT9ss` (0x80024c2c, femenu.cpp:1166, map=exact)

- Extra source locals: `greenVal`, `greenVal2`, `redVal`, `redVal2`

### `Draw__24tMenuItemLeftRightSliderb` (0x800251e4, femenu.cpp:1284, map=exact)

- Extra source locals: `iVar2`, `pa_Var3`, `uVar1`, `wordnum`

### `ProcessInput__23tMenuItemGoToMenuButton7tPlayerR13tInputKeyTypeR12tMenuCommand` (0x800253a4, femenu.cpp:1357, map=exact)

- Extra source locals: `frameFiller`, `fromPlayer`, `reg_a3`, `uVar1`, `uVar2`

### `GoNonInterlaced__7tScreen` (0x80025bf8, fescreen.cpp:73, map=exact)

- Extra source locals: `env`, `height`, `iVar1`, `iVar2`, `playerView`, `sVar3`, `view0`, `view1`, `views`

### `MenuExtended_GoToTwoPlayerSingleRace__FR12tMenuCommand` (0x8002c288, femenudefs.cpp:236, map=exact)

- Extra source locals: `defs`, `dlgThis`, `ptVar1`, `sVar3`, `screenState`, `this_00`, `uVar2`

### `MenuExtended_GoToCarSelect__FR12tMenuCommand` (0x8002c4fc, femenudefs.cpp:435, map=exact)

- Extra source locals: `dialog`, `nextMenu`, `screen`, `state`

### `MenuExtended_GoToDealer__FR12tMenuCommand` (0x8002c890, femenudefs.cpp:589, map=exact)

- Extra source locals: `cmdType`, `dlgThis`, `ptVar1`

### `MenuExtended_GoToSeller__FR12tMenuCommand` (0x8002c8f8, femenudefs.cpp:629, map=exact)

- Extra source locals: `cmdType`, `dlgThis`, `ptVar1`

### `GenericMenuSaveGame__Fi` (0x8002c9a0, femenudefs.cpp:694, map=exact)

- Extra source locals: `app`, `dlgThis`, `noInput`, `pcVar4`, `ret`

### `MenuExtended_GoToRace__FR12tMenuCommand` (0x8002cc98, femenudefs.cpp:880, map=exact)

- Extra source locals: `dlgThis`, `pcVar3`, `ptVar1`, `uVar2`, `wordnum`

### `MenuExtended_GoTo2PlayerRace__FR12tMenuCommand` (0x8002cdf4, femenudefs.cpp:952, map=exact)

- Extra source locals: `dlgThis`, `pcVar3`, `ptVar1`, `uVar2`, `wordnum`

### `MenuExtended_GoToTournTrackInfo__FR12tMenuCommand` (0x8002cf40, femenudefs.cpp:1024, map=exact)

- Extra source locals: `dlgThis`, `fe`, `iVar6`, `iVar7`, `pcVar5`, `pp`, `ptVar1`, `ptVar2`, `ptVar3`, `sVar4`, `this_00`, `tm`, `tsaved`

### `MenuExtended_GoToSpecialEventTrackInfo__FR12tMenuCommand` (0x8002d0a8, femenudefs.cpp:1121, map=exact)

- Extra source locals: `dlgThis`, `fe`, `iVar6`, `iVar7`, `pcVar5`, `pp`, `ptVar1`, `ptVar2`, `ptVar3`, `sVar4`, `this_00`, `tm`, `tsaved`

### `MenuExtended_EnterUserName__FR12tMenuCommand` (0x8002d214, femenudefs.cpp:1244, map=exact)

- Extra source locals: `bVar1`, `bVar2`, `dlgThis`, `ptVar3`, `ptVar4`

### `MenuExtended_SellCar__FR12tMenuCommand` (0x8002d3a0, femenudefs.cpp:1433, map=exact)

- Extra source locals: `bVar1`, `command`, `dlgThis`, `lVar4`, `lVar5`, `lVar6`, `pcVar7`, `pp`, `ptVar2`, `sVar3`, `this_00`

### `MenuExtended_BuyCar__FR12tMenuCommand` (0x8002d4f8, femenudefs.cpp:1537, map=exact)

- Extra source locals: `command`, `dlgThis`, `lVar3`, `pcVar4`, `pp`, `ptVar1`, `sVar2`, `this_00`

### `MenuExtended_PurchaseUpgrade__Fi` (0x8002d64c, femenudefs.cpp:1608, map=exact)

- Extra source locals: `dlgThis`, `lVar3`, `pcVar4`, `pp`, `ptVar1`, `sVar2`, `uVar5`

### `MenuExtended_LoadGame__FR12tMenuCommand` (0x8002d8d0, femenudefs.cpp:1874, map=exact)

- Extra source locals: `command`, `dlgThis`, `framePadding`, `sVar1`

### `MenuExtended_PostGameMenu__FR12tMenuCommand` (0x8002db04, femenudefs.cpp:2016, map=exact)

- Extra source locals: `dlgThis`, `ptVar3`, `ptVar4`, `pvVar2`, `sVar1`

### `MenuExtended_FinishedPlayer1GetName__FR12tMenuCommand` (0x8002dc04, femenudefs.cpp:2075, map=exact)

- Extra source locals: `dlgThis`, `ptVar1`, `ptVar2`, `ptVar3`, `pvVar5`, `sVar4`

### `MenuExtended_FinishedPlayer2GetName__FR12tMenuCommand` (0x8002dd14, femenudefs.cpp:2126, map=exact)

- Extra source locals: `ptVar1`, `pvVar3`, `sVar2`

### `MenuExtended_AwardPinkSlipsCar__FR12tMenuCommand` (0x8002de74, femenudefs.cpp:2246, map=exact)

- Extra source locals: `dlgThis`, `dlgThis2`, `dlgThis3`, `pcVar5`, `playerNum`, `ptVar1`, `ptVar2`, `ptVar3`, `this_00`

### `MenuExtended_GoToGarage__FR12tMenuCommand` (0x8002e09c, femenudefs.cpp:2338, map=exact)

- Extra source locals: `dlgThis`, `ptVar1`, `this_00`

### `MenuExtended_ExitTourney__FR12tMenuCommand` (0x8002e18c, femenudefs.cpp:2505, map=exact)

- Extra source locals: `dlgThis`, `ptVar1`, `sVar2`

### `MenuExtended_ExitPinkSlipsEarly__FR12tMenuCommand` (0x8002e21c, femenudefs.cpp:2563, map=exact)

- Extra source locals: `dlgThis`, `fmt`, `iVar5`, `msg`, `pcVar4`, `ptVar2`, `sVar3`

### `__15tGlobalMenuDefs` (0x8002e3b8, femenudefs.cpp:3128, map=exact)

- Extra source locals: `pm_`, `pu_`

### `Confirm__Fii` (0x80034438, fememcard.cpp:153, map=exact)

- Extra source locals: `app`, `dialogVf`, `displayDialog`, `dlg`, `dlgmsg`, `noInput`, `pcVar5`, `sVar4`

### `SaveGame__Fs` (0x80034988, fememcard.cpp:417, map=exact)

- Extra source locals: `displayDialog`, `dlgmsg`, `message`, `pCVar4`, `wd`

### `LoadGame__FsbT1` (0x80034e18, fememcard.cpp:567, map=exact)

- Extra source locals: `cardshifted`, `dialogBase`, `dialogText`, `dlgmsg`

### `Draw__14tCreditManagerb` (0x80035c24, fecredits.cpp:94, map=exact)

- Extra source locals: `fadeValue`, `iVar2`, `mainScreen`, `uVar3`

### `SetupCurrCredit__14tCreditManager` (0x80035d68, fecredits.cpp:158, map=exact)

- Extra source locals: `bVar1`, `iVar2`, `iVar3`, `iVar4`, `iVar5`, `pvVar3`, `startTicks`

### `DrawCurrCredit__14tCreditManager` (0x80036084, fecredits.cpp:264, map=exact)

- Extra source locals: `lineWidth`, `pcVar3`, `scrollY`, `t16`, `tagByte`, `uVar4`, `width2`

### `DrawBackground__11tScreenMain` (0x800379c0, screenmain.cpp:403, map=exact)

- Extra source locals: `el`, `frameIdx`, `iVar10`, `iVar5`, `iVar7`, `sVar3`, `str`, `uFade`, `uVar6`, `uVar9`, `vy`

### `DrawBackground__16tScreenPinkSlips` (0x80038b68, screenpinkslips.cpp:21, map=exact)

- Extra source locals: `currentItem`, `movieVramX`, `pulse`, `rx`, `ry`, `selected`, `trackIndex`

### `ProcessInput__16tScreenPinkSlips7tPlayerR13tInputKeyTypeR12tMenuCommand` (0x80039690, screenpinkslips.cpp:325, map=exact)

- Extra source locals: `command`, `defs`, `fromPlayer`, `uVar2`

### `DrawBackground__26tScreenTournamentStandings` (0x80039b84, screenpost.cpp:310, map=exact)

- Extra source locals: `bonus`, `halfWidth`, `lastRacer`, `line`, `numRacers`, `self`, `tm`, `type`

### `DrawOverlay__16tScreenCarSelectP8tOverlay` (0x8003ad00, screencarselect.cpp:179, map=exact)

- Extra source locals: `flags`, `tournamentMoney`, `vtbl`, `xPos`, `yOffset`

### `SetState__16tScreenCarSelecti` (0x8003b59c, screencarselect.cpp:380, map=exact)

- Extra source locals: `cVar1`, `ovl`, `t1`, `t2`

### `Initialize__16tScreenCarSelect` (0x8003bd88, screencarselect.cpp:651, map=exact)

- Extra source locals: `fadeTick`, `mdefs`, `sVar2`, `showroomTick`, `uVar6`, `valid`

### `ProcessInput__16tScreenCarSelect7tPlayerR13tInputKeyTypeR12tMenuCommand` (0x8003bf90, screencarselect.cpp:744, map=exact)

- Extra source locals: `lrItem`, `state2`, `tVar4`, `vtbl`

### `DrawBackground__16tScreenCarSelect` (0x8003c53c, screencarselect.cpp:988, map=exact)

- Extra source locals: `bVar1`, `bright`, `valid`, `vtbl`

### `DrawForeground__16tScreenCarSelect` (0x8003c7d8, screencarselect.cpp:1092, map=exact)

- Extra source locals: `currentItemValue`, `fadeBase`, `overlayDirection`, `shapeFade`, `shapeTicks`, `textBase`, `validCarValue`

### `PreLoad__20tScreenCarSelectDuel` (0x8003d08c, screencarselect.cpp:1338, map=exact)

- Extra source locals: `buf_or_path`, `str`, `use_default`, `vtbl`

### `DrawBackground__20tScreenCarSelectDuel` (0x8003d7f0, screencarselect.cpp:1607, map=exact)

- Extra source locals: `bVar1`, `bVar2`, `creditsTextVal`, `elapsed`, `sVar2`, `screenVtbl`, `screenVtbl2`, `vtbl`

### `DrawForeground__20tScreenCarSelectDuel` (0x8003de68, screencarselect.cpp:1762, map=exact)

- Extra source locals: `ci`, `sliderResult`, `vtbl`

### `DrawVideoWall__25tScreenCarSelectTwoPlayers` (0x8003e190, screencarselect.cpp:1887, map=exact)

- Extra source locals: `offset`, `sVar2`, `vtbl`

### `DrawBackground__25tScreenCarSelectTwoPlayer` (0x8003e4bc, screencarselect.cpp:2002, map=exact)

- Extra source locals: `bVar1`, `brightness`, `carY_2`, `cur_pkt`, `cur_pkt_2`, `elapsed`, `pkt_addr24`, `pkt_addr24_2`, `player`, `sVar3`, `screenVtbl`, `screenVtbl2`, `ti7`, `ts10`, `ts3`, `vtbl`

### `DoMemCardStuff__25tScreenPinkSlipsCarSelect` (0x8003ef14, screencarselect.cpp:2410, map=exact)

- Extra source locals: `cardInfo`, `pinkState`, `resultState`, `resultStatePtr`, `stateBase`

### `GetShapeInfo__18tScreenTournSelectRsT1PPcT3` (0x8003f7d4, screentournselect.cpp:36, map=exact)

- Extra source locals: `fe`, `swapName`, `trophyTourn`, `useSpecial`

### `Initialize__18tScreenTournSelect` (0x8003f8a0, screentournselect.cpp:75, map=exact)

- Extra source locals: `fe`, `flags`, `tvIdx`, `useSpecial`

### `DrawBackground__18tScreenTournSelect` (0x8003fe5c, screentournselect.cpp:247, map=exact)

- Extra source locals: `descriptionText`, `fe`, `number`, `shapeX`, `tournament`, `tvIdx`, `word`

### `GetShapeInfo__17tScreenTrophyRoomRsT1PPcT3` (0x800405d8, screentrophyroom.cpp:36, map=exact)

- Extra source locals: `cur`, `swapName`, `tourn`

### `Initialize__17tScreenTrophyRoom` (0x80040910, screentrophyroom.cpp:133, map=exact)

- Extra source locals: `curIdx`, `fe`, `loaded`, `loopFe`, `place`, `placement`, `tournIdx`, `tourney`

### `DrawBackground__17tScreenTrophyRoom` (0x80040b18, screentrophyroom.cpp:228, map=exact)

- Extra source locals: `currentTourn`, `feTier`, `pDrawFlags`, `selectedTourn`, `tourn`

### `LoadTrophy__17tScreenTrophyRoom` (0x80040f2c, screentrophyroom.cpp:312, map=exact)

- Extra source locals: `cur`, `swapName`, `tierIdx`, `tourn`

### `GetShapeInfo__17tScreenTrophyInfoRsT1PPcT3` (0x80041008, screentrophyinfo.cpp:9, map=exact)

- Extra source locals: `currentTourn`, `feTier`, `idx`, `placement`

### `DrawBackground__17tScreenTrophyInfo` (0x80041138, screentrophyinfo.cpp:84, map=exact)

- Extra source locals: `currentTourn`, `definition`, `fade`, `feTier`, `tourn`, `tournID`, `tournamentIndex`, `tournaments`, `word`

### `DrawBackground__18tScreenTrackSelect` (0x80041600, screentracks.cpp:14, map=exact)

- Extra source locals: `addrMask`, `creditsTextVal`, `packetPtrSlot`, `shapeX`, `startTicks`, `videoWall`, `videoY`

### `ProcessInput__18tScreenTrackSelect7tPlayerR13tInputKeyTypeR12tMenuCommand` (0x8004200c, screentracks.cpp:412, map=exact)

- Extra source locals: `cmdResult`, `command`, `menuVtbl`, `player`, `ptVar1`, `pvVar2`, `trafficFlags`

### `DrawBackground__16tScreenTrackInfo` (0x80042298, screentrackinfo.cpp:35, map=exact)

- Extra source locals: `highlighted`, `pList`, `screenInfo`, `state`, `word`

### `DrawBackground__19tScreenTrackRecords` (0x80042b48, screentrackrecords.cpp:153, map=exact)

- Extra source locals: `clampTmp`, `fadeAmt`, `half`, `lineFadeCalc`

### `CheckConfigs__23tScreenControllerConfig` (0x80043400, screencontroller.cpp:189, map=exact)

- Extra source locals: `armArrowDim`, `cmp`, `ctrlCur`, `swapCur`, `swapPrev`

### `SetCurrentController__23tScreenControllerConfigb` (0x80043778, screencontroller.cpp:335, map=exact)

- Extra source locals: `choice`, `ctrlType`, `dialog`, `dialogIdle`, `menus`

### `DrawController__23tScreenControllerConfig` (0x80043de4, screencontroller.cpp:606, map=exact)

- Extra source locals: `controller`, `controllerOffset`, `haloX`, `iy`, `modeBase`, `offsets`, `rangeValue`, `row`, `shockImpactActive`, `shockModeActive`, `x`, `xOffset`

### `DrawForeground__23tScreenControllerConfig` (0x80045064, screencontroller.cpp:1154, map=exact)

- Extra source locals: `candidate`, `config`, `controller`, `dialog`, `flag`, `n`, `pTL`, `pTextLoc`, `squareWidth`, `textLength`, `textWidth`

### `DrawBackground__12tScreenAudio` (0x80045ed8, screenaudio.cpp:180, map=exact)

- Extra source locals: `displayPercent`, `fadeValue`, `optionsMenu`

### `LoadIcon__14tScreenMemcardi` (0x8004653c, screenmemcard.cpp:151, map=exact)

- Extra source locals: `cardInfo`, `iconShape`, `one`, `pulled`

### `DrawVerticalLine__14tScreenMemcardssss` (0x80046898, screenmemcard.cpp:253, map=exact)

- Extra source locals: `height`, `innerHeight`, `pos`, `shifted`, `test`

### `DrawHorizontalLine__14tScreenMemcardssss` (0x8004694c, screenmemcard.cpp:305, map=exact)

- Extra source locals: `pos`, `shifted`, `test`, `width`

### `PlaceIcons__14tScreenMemcardii` (0x80046a0c, screenmemcard.cpp:353, map=exact)

- Extra source locals: `animFrame`, `icon`, `nfs4Icon`, `numIcons`, `savedY`, `tickFrame`, `tickPtr`

### `DrawBackground__14tScreenMemcard` (0x80047470, screenmemcard.cpp:723, map=exact)

- Extra source locals: `extraY`, `gouraudX`, `gouraudY`, `h`, `startX`, `startY`, `w`, `width`

### `Initialize__14tScreenMemcard` (0x80047c30, screenmemcard.cpp:917, map=exact)

- Extra source locals: `feApp`, `inputPlayer`, `loadFlags`, `menus`, `msgId`, `saveFlags`

### `CalculatePrizes__15tScreenCongrats` (0x800489b8, screencongrats.cpp:327, map=exact)

- Extra source locals: `carCXBits`, `carCYBits`

### `CalculatePrizes__23tScreenPinkSlipCongrats` (0x80048cdc, screencongrats.cpp:465, map=exact)

- Extra source locals: `base`, `player`, `speechId2`, `vtbl`

### `CalculatePrizes__23tScreenTournamentTrophy` (0x8004923c, screencongrats.cpp:694, map=exact)

- Extra source locals: `carCXBits`, `cashAwarded`, `knockout`, `loopLimit`, `money`, `numRanked`, `ranked`

### `StatChk_SaveRecordLapTime__FP10Car_tStatsss` (0x80049b7c, statchk.cpp:97, map=exact)

- Extra source locals: `newBestLap`, `playerName`, `track`

### `Stattool_GetAllDefaultRecords__FP13tRecordBufferb` (0x8004ac98, stattool.cpp:197, map=exact)

- Extra source locals: `base`, `dest`, `src`

### `Stattool_CheckForHumanCar__FP10Car_tStats` (0x8004aec4, stattool.cpp:276, map=exact)

- Extra source locals: `bound`, `numCars`, `one`

### `DrawBackground__15tScreenUserName` (0x8004b1ac, screenusername.cpp:230, map=exact)

- Extra source locals: `fadeboxv`, `gridposv`, `textfadev`

### `CalcOnOffFade__F13tMenuTextTypesssRiT4` (0x8004b9d4, fefades.cpp:90, map=exact)

- Extra source locals: `baseA`, `baseB`, `baseC`

## Implicit aggregate special members

- `__11tAllScreens` (0x8002baf4, `front.cpp`): implicit `tAllScreens` constructor; emitted from the aggregate member graph at the recorded declaration line, so an explicit source body would be incorrect.
- `_._11tAllScreens` (0x8002bf0c, `front.cpp`): implicit `tAllScreens` destructor; emitted from the aggregate member graph at the recorded declaration line, so an explicit source body would be incorrect.
## Explicit SYM carrier/optimization mappings

- `Run__18tDialogInteractive`: `player`
- `FECheat_HandleActivation__F10tCheatCode`: `num`
- `SetupCurrCredit__14tCreditManager`: `lasttick`
- `DrawBackground__25tScreenCarSelectTwoPlayer`: `carInfo`

## Explicit restored inline-local mappings

- `DrawHelpIcons__14tFEApplication`: `this` from `HasOptionsMenu`
- `GetCar__25tScreenCarSelectTwoPlayerR8tCarInfo`: `this` from `GetPlayer`
- `GetCar__25tScreenPinkSlipsCarSelectR8tCarInfo`: `this` from `GetPlayer`
- `DrawController__23tScreenControllerConfig`: `range` from `ControllerTwistRange`

## Explicit restored macro-local mappings


## Explicit source-only codegen carriers

- `Redraw__14tFEApplication`: `globalMenuDefs`, `pal2`, `pc`
- `SetScreen__14tFEApplicationsP7tScreen`: `iVar1`, `this_00`
- `DisplayHelp__14tFEApplications`: `this_tDialogHelp`
- `RunDemoVideo__14tFEApplication`: `largest`, `menu`, `vtbl`
- `RunPostGame__14tFEApplication`: `item`, `screen`
- `FeAudio_InitCommentary__Fii`: `arg1`
- `CalcUsedPrice__11tCarManagers`: `carID`, `upgrades`
- `GetStockCar__11tCarManagersR8tCarInfo`: `uVar1`
- `GetNumTourneyCars__11tCarManagers`: `carID`
- `ValidCar__16tListIteratorCar7tPlayerc`: `carClass`
- `Increment__21tListIteratorCarColor7tPlayer`: `fNumColors`, `notWrapped`
- `DrawAllDialogs__11tDialogBase`: `sVar1`
- `ProcessInput__11tDialogBase7tPlayerR13tInputKeyTypeR12tMenuCommand`: `command`, `fromPlayer`
- `CalculateDimensions__12tDialogYesNo`: `iVar2`
- `TransitionIsFinished__9tMenuNFS4`: `iVar2`, `iVar4`, `ptVar1`, `uVar3`
- `Draw__9tMenuNFS4`: `iVar3`, `iVar4`
- `TransitionOff__12tMenuOptions`: `iVar1`
- `TransitionOn__12tMenuOptions`: `enterTicks`, `itemCursor`
- `SubtractiveBox__Fiiiiiiii`: `packetCell`
- `UpdateTransition__27tMenuItemGoToMenuButtonFadeb`: `iVar2`
- `UpdateTransition__22tMenuItemLeftRightFadeb`: `iVar2`
- `UpdateTransition__12tOptionsMenu`: `adjusted`, `citem`, `entry`, `item`
- `ProcessInput__14tInsideBoxMenu7tPlayerR13tInputKeyTypeR12tMenuCommand`: `tVar2`
- `UpdateTransition__20tMenuItemSlidingMenub`: `iVar2`
- `UpdatefOpenHeight__20tMenuItemSlidingMenub`: `closeH`, `cur`, `fade`, `fadeOut`, `lim`, `newFade`, `shrinkH`, `slide`
- `UpdatefOpenHeight__25tMenuItemSlidingActivatedb`: `arg1`, `iVar2`, `iVar4`
- `UpdateTransition__25tMenuItemSlidingActivatedb`: `iVar2`
- `UpdateTransition__29tMenuItemLeftRightAudioSliderb`: `iVar1`
- `ProcessInput__18tInsideBoxSongMenu7tPlayerR13tInputKeyTypeR12tMenuCommand`: `command`, `fromPlayer`
- `ProcessInput__22tInsideBoxTwoWaySlider7tPlayerR13tInputKeyTypeR12tMenuCommand`: `command`, `fromPlayer`
- `TransitionOn__17tUserNameMenuItem`: `dst`
- `UpdateTransition__17tUserNameMenuItemb`: `iVar2`
- `Draw__19tMemoryCardMenuItemb`: `less`, `sVar2`, `selected`, `sv`, `v`
- `FETextRender_WordWrapTextRGBJustify__FPcR4RECTiiib`: `pixels`
- `TextValue__18tListIteratorTrack7tPlayer`: `trackEntry`, `uVar1`
- `DrawTVLines__FR9tTVConfig`: `abe`
- `FECheat_HandleActivation__F10tCheatCode`: `placement`, `placements`
- `FEInput_GetNoDebounceKey__Fii`: `result`
- `Draw__9tMenuItemiib`: `x`, `y`
- `Draw__9tMenuItemiiib`: `w`
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
- `AskTheUserToSaveTheGame__Fv`: `dlgThis`
- `MenuExtended_TransitionFromPostGameToMainMenu__FR12tMenuCommand`: `ptVar1`
- `MenuExtended_GoToUpgrades__FR12tMenuCommand`: `ptVar1`
- `PinkSlipsPreSave__Fv`: `dlgThis`
- `MenuExtended_GoToShowroom__FR12tMenuCommand`: `ptVar1`
- `MenuExtended_GoToDealerShowroom__FR12tMenuCommand`: `ptVar1`
- `GenericMenuLoadGame__Fi`: `app`, `mc`
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
- `SavePinkSlipsCars__Fss`: `pCVar7`
- `Init__14tCreditManageri`: `arg1`
- `TurnOff__10tVideoWall`: `tickCounter`
- `TurnOn__10tVideoWall`: `tickCounter`
- `DrawDropShadow__11tScreenMain`: `addrMask`, `addr_24`, `palTag`, `pal_link`, `tagMask`
- `Initialize__16tScreenPinkSlips`: `iVar1`, `tmp`
- `DrawBackground__24tScreenPinkSlipStandings`: `halfWidth`
- `DrawCar__FR8tCarInfossffcbUl7tPlayer`: `signedTicks`
- `Cleanup__16tScreenCarSelect`: `vtbl`
- `CalcSplinePosition__16tScreenCarSelectiiiiUlRiN46`: `_i`
- `GetShapeInfo__16tScreenCarSelectRsT1PPcT3`: `vtbl`
- `UpdateVideoWall__16tScreenCarSelectR8tCarInfo`: `bVar1`
- `DrawVideoWall__16tScreenCarSelects`: `vtbl`
- `GetCar__16tScreenCarSelectR8tCarInfo`: `uVar1`
- `DrawVideoWall__20tScreenCarSelectDuels`: `vtbl`
- `GetShapeInfo__20tScreenCarSelectDuelRsT1PPcT3`: `vtbl`
- `UpdateVideoWall__20tScreenCarSelectDuelR8tCarInfo`: `bVar1`
- `GetCar__25tScreenCarSelectTwoPlayerR8tCarInfo`: `player`
- `UpdateVideoWall__25tScreenCarSelectTwoPlayerR8tCarInfo`: `bVar1`
- `DrawForeground__25tScreenCarSelectTwoPlayer`: `ci`
- `SetDialog__25tScreenPinkSlipsCarSelect`: `dlg`, `wordnum`
- `GetShapeInfo__16tScreenTrackInfoRsT1PPcT3`: `dayTimes2`, `weatherPlus`
- `ProcessInput__16tScreenTrackInfo7tPlayerR13tInputKeyTypeR12tMenuCommand`: `fee`
- `SetActuators__23tScreenControllerConfigi`: `pulse`, `tickValue`
- `Controller_SetRamp__Fv`: `one`
- `AnimKeyPoints__23tScreenControllerConfigbT1`: `result`
- `DrawArrow__23tScreenControllerConfigPs`: `clampVal`
- `DrawBackground__23tScreenControllerConfig`: `om`
- `Initialize__23tScreenControllerConfig`: `b`, `mode`
- `PlaySound__12tScreenAudio`: `validItem`
- `DrawForeground__12tScreenAudio`: `fadeCalc`
- `Initialize__12tScreenAudio`: `audioMode`, `menus`
- `Cleanup__12tScreenAudio`: `info`
- `DrawIcon__14tScreenMemcardP8shapetbliiiis`: `u`
- `DrawBackground__14tScreenMemcard`: `these`
- `DrawForeground__14tScreenMemcard`: `fade`
- `Cleanup__14tScreenMemcard`: `iconTable`, `menus`
- `GetShapeInfo__15tScreenCongratsRsT1PPcT3`: `numRanked`
- `DrawBackground__15tScreenCongrats`: `spinTicks`, `vtbl`
- `Initialize__15tScreenCongrats`: `vtbl`
- `ProcessInput__15tScreenCongrats7tPlayerR13tInputKeyTypeR12tMenuCommand`: `bConsumeKey`
- `StatChk_SaveTopTime__FP10Car_tStatss`: `uRecSz`
- `StatChk_ClearNewRecords__Fv`: `pRec`
- `Stattool_nCreateIndex__FiPiPs`: `one`
- `Stattool_ParseTime__FiPc`: `min`, `sec`
- `Stattool_GetAINameFromPersonality__F14tPersonalities`: `namePtr`
- `DrawVerticalLine__15tScreenUserNamesss`: `depth`
- `DrawHorizontalLine__15tScreenUserNamesss`: `depth`

## Explicit oracle-proven function type overrides


## Object-owned global/storage review

- No ownership, storage-class, or type findings.
